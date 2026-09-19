/// @description Rock Paper Scissors vs Death — setup

// ── RULES ────────────────────────────────────────────────────────────────────
// wins_needed: first side to reach this many round wins takes the match.
// pity_chance: if the player loses the match, Death has this chance of letting
//   the pet go anyway
wins_needed = 2;
pity_chance = 0.175;

// ── CHOICES ──────────────────────────────────────────────────────────────────
// Order matters: each choice beats the one before it and loses to the one after
// it (wrapping around), so the winner check is just an index compare in Step.
// buttons and hand sprites are built from input verbs
choices = [
    { label: "Rock",     verb: "rock",     spr_player: spr_human_rock,     spr_death: spr_death_rock     },
    { label: "Paper",    verb: "paper",    spr_player: spr_human_paper,    spr_death: spr_death_paper    },
    { label: "Scissors", verb: "scissors", spr_player: spr_human_scissors, spr_death: spr_death_scissors },
];
fist_index = 0;

// ── SCORE ────────────────────────────────────────────────────────────────────
player_score  = 0;
death_score   = 0;
round_number  = 1;   // only decisive rounds count, draws replay
player_choice = -1; 
death_choice  = -1;
round_result  = "";  // "win" | "lose" | "draw"
match_result  = "";  // "win" | "lose" | "pity"
dialog_spawned = false;

// ── STATE MACHINE ────────────────────────────────────────────────────────────
// "choosing"  - waiting for the player to pick a hand
// "shake"     - both fists pump, then hands swap to the real choices
// "result"    - show who won the round, then loop back or end the match
// "game_over" - dialog is up, ignore everything
state = "choosing";
state_timer = 0;  // frames spent in the current state
frames_alive = 0; // frames since the room opened, drives the one-off slide-in

// Timings, in frames. Tweak these to speed the whole thing up or slow it down.
var _fps = game_get_speed(gamespeed_fps);
intro_frames      = round(_fps * 0.4);   // hands slide in from the edges when the room opens
shake_pumps       = 3;                  // how many times the fists bob before reveal
shake_pump_frames = round(_fps * 0.25);  // length of one pump
shake_frames      = shake_pumps * shake_pump_frames;
reveal_pop_frames = round(_fps * 0.15);  // scale pop when hands swap to real choices
result_frames     = round(_fps * 1.2);   // how long the round result stays up

// ── LAYOUT ───────────────────────────────────────────────────────────────────
gui_w = display_get_gui_width();
gui_h = display_get_gui_height();

// Text block at the top of the content area
line_h   = 0; // set in Draw once the font is known
text_top = global.display_area_top + 4;

// Hands face each other in the middle.
// hand_*_x / hand_y is where each hand rests when horizontal (angle 0).
hand_y         = gui_h * 0.42;
hand_player_x  = gui_w * 0.3;
hand_death_x   = gui_w * 0.7;
hand_offscreen = 60;  // how far past the screen edge hands start before sliding in
hand_pop_scale = 1.3; // starting scale of the reveal pop

// The hand swings like it's on a forearm pivoting at an (invisible) elbow.
// The elbow sits arm_length behind the resting hand position, so a bigger
// arm_length = wider arc. arm_angle_max is how far up the hand raises before
// slamming back down; 90 = straight up.
arm_length    = 30;
arm_angle_max = 80;
idle_angle    = 6;

// Result text sits between the hands and the buttons
result_y = gui_h * 0.6;

// Buttons: one per choice, centred as a row above the bottom nav area
btn_w   = 48;
btn_h   = 18;  // must be >= 16 for the nine-slice sprites
btn_gap = 4;
btn_y   = global.display_area_bottom - btn_h / 2 - 6;

buttons = [];
var _count   = array_length(choices);
var _row_w   = _count * btn_w + (_count - 1) * btn_gap;
var _cur_x   = gui_w / 2 - _row_w / 2;
for (var i = 0; i < _count; i++) {
    var _cx = _cur_x + btn_w / 2;
    // Input virtual button so touch fires the same verb as the keyboard key
    var _vb = input_virtual_create()
        .rectangle(_cx - btn_w / 2, btn_y - btn_h / 2, _cx + btn_w / 2, btn_y + btn_h / 2)
        .button(choices[i].verb);
    array_push(buttons, { label: choices[i].label, verb: choices[i].verb, cx: _cx, cy: btn_y, vb: _vb, hover: false });
    _cur_x += btn_w + btn_gap;
}
focused_btn = 0; // keyboard focus, same left/right/accept scheme as obj_dialog_modal

// HELPERS

// Switch state and restart the timer. Always go through this so the timer is right.
set_state = function(_new_state) {
    state = _new_state;
    state_timer = 0;
};

// Deceleration curve for the slide-in and the pop. 0..1 in, 0..1 out.
ease_out = function(t) {
    return 1 - (1 - t) * (1 - t);
};

// Acceleration curve for the slam. 0..1 in, 0..1 out.
ease_in = function(t) {
    return t * t;
};

// One pump of the arm: raises smoothly over the first half, slams down over the
// second. t is 0..1 within the pump, returns the arm angle in degrees.
pump_angle = function(t) {
    if (t < 0.5) return arm_angle_max * ease_out(t / 0.5);
    return arm_angle_max * (1 - ease_in((t - 0.5) / 0.5));
};

// Starts a round with the given choice index. Death picks at the same time so the
// outcome is locked in before the animation plays.
play_round = function(_choice) {
    player_choice = _choice;
    death_choice  = irandom(array_length(choices) - 1);
    var _n = array_length(choices);
    if (death_choice == player_choice) {
        round_result = "draw";
    } else if (death_choice == (player_choice + 1) mod _n) {
        round_result = "lose"; // Death picked the thing that beats us
    } else {
        round_result = "win";
    }
    set_state("shake");
};

// Called once at the end of the match. Applies the outcome and pops the dialog.
finish_match = function() {
    if (dialog_spawned) return;
    dialog_spawned = true;

    // Created at depth -9999 so it draws over everything
    var _dlg = instance_create_depth(0, 0, -9999, obj_dialog_modal);

    audio_play_sound((match_result == "lose") ? snd_death : snd_yay, 1, false);

    if (match_result == "lose") {
        // Same new-egg flow as the "nah im good" button in obj_room_death.
        // Reset needs and set up the new egg BEFORE time_reset() so the save it writes captures the fresh state, not the dead pet's.
        global.game.living = 1;
        global.game.limbo  = 0;
        reset_needs();
        global.game.evolution_phase = "egg";
        var starter_pet = irandom_range(0, 2);
        if (starter_pet == 0) global.game.current_pet_type = "chobo";
        if (starter_pet == 1) global.game.current_pet_type = "pomba";
        if (starter_pet == 2) global.game.current_pet_type = "dodati";
        time_reset();

        _dlg.message = "Death wins. Better luck next time.";
        array_push(_dlg.buttons, { label: "Awwww", callback: function() {
            room_goto(rm_main);
        }});
    } else {
        _dlg.message = (match_result == "pity")
            ? "Death sighs, mutters something about paperwork, and lets your pet go."
            : "You won your pet back!";
        array_push(_dlg.buttons, { label: "YAY", callback: function() {
            global.game.living = 1;
            global.game.limbo  = 0;
            room_goto(rm_main);
        }});
    }
};
