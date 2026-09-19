/// @description Draw score, hands, result text and buttons

draw_set_font(fnt_Kubasta);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
line_h = string_height("Ag");

// ── SCOREBOARD ───────────────────────────────────────────────────────────────
draw_text(gui_w / 2, text_top,              "Death challenges you!");
draw_text(gui_w / 2, text_top + line_h,     $"Round {round_number}  (first to {wins_needed})");
draw_text(gui_w / 2, text_top + line_h * 2, $"You {player_score} - {death_score} Death");

// ── HANDS ────────────────────────────────────────────────────────────────────
// Everything below is derived from state + state_timer so there's nothing to
// keep in sync — change the timings in Create and the animation follows.
var _slide = ease_out(min(frames_alive / intro_frames, 1)); // 0 = offscreen, 1 = in place

// Elbows sit arm_length behind each resting hand. The slide-in moves the whole arm.
var _elbow_px = lerp(-hand_offscreen, hand_player_x, _slide) - arm_length;
var _elbow_dx = lerp(gui_w + hand_offscreen, hand_death_x, _slide) + arm_length;

var _spr_p = choices[fist_index].spr_player;
var _spr_d = choices[fist_index].spr_death;
var _angle = 0; // degrees the forearm is raised; 0 = horizontal
var _scale = 1;
var _alpha_p = 1;
var _alpha_d = 1;

switch (state) {
    case "choosing":
        // Lazy wobble so the screen isn't static while waiting
        _angle = abs(sin(frames_alive * 0.05)) * idle_angle;
        break;

    case "shake":
        if (state_timer < shake_frames) {
            // Pump: raise then slam, once per shake_pump_frames
            var _t = (state_timer mod shake_pump_frames) / shake_pump_frames;
            _angle = pump_angle(_t);
        } else {
            // Reveal: swap to the real hands and pop them down to full size
            _spr_p = choices[player_choice].spr_player;
            _spr_d = choices[death_choice].spr_death;
            var _pop_t = (state_timer - shake_frames) / reveal_pop_frames;
            _scale = lerp(hand_pop_scale, 1, ease_out(clamp(_pop_t, 0, 1)));
        }
        break;

    case "result":
    case "game_over":
        _spr_p = choices[player_choice].spr_player;
        _spr_d = choices[death_choice].spr_death;
        // Loser fades a bit, winner does a little hop (hop is worked out below)
        if (round_result == "win")  _alpha_d = 0.5;
        if (round_result == "lose") _alpha_p = 0.5;
        break;
}

var _hop_p = (state == "result" && round_result == "win")  ? -abs(sin(state_timer * 0.15)) * 3 : 0;
var _hop_d = (state == "result" && round_result == "lose") ? -abs(sin(state_timer * 0.15)) * 3 : 0;

// Swing each hand around its elbow. Player's arm points right (0°) and raises
// counter-clockwise; Death's points left (180°) and raises clockwise, so the
// same _angle mirrors cleanly. lengthdir_y is negative going up, which is what we want.
var _px  = _elbow_px + lengthdir_x(arm_length, _angle);
var _py  = hand_y    + lengthdir_y(arm_length, _angle);
var _dx  = _elbow_dx + lengthdir_x(arm_length, 180 - _angle);
var _dy  = hand_y    + lengthdir_y(arm_length, 180 - _angle);

draw_sprite_ext(_spr_p, 0, _px, _py + _hop_p, _scale, _scale,  _angle, c_white, _alpha_p);
draw_sprite_ext(_spr_d, 0, _dx, _dy + _hop_d, _scale, _scale, -_angle, c_white, _alpha_d);

// ── RESULT TEXT ──────────────────────────────────────────────────────────────
if (state == "result") {
    draw_set_font(fnt_Kubasta_lrg);
    var _msg = "";
    switch (round_result) {
        case "draw": _msg = "Tie! Go again.";          break;
        case "win":  _msg = "You win the round!";       break;
        case "lose": _msg = "Death takes the round.";   break;
    }
    draw_text(gui_w / 2, result_y, _msg);
    draw_set_font(fnt_Kubasta);
}

// ── BUTTONS ──────────────────────────────────────────────────────────────────
// Same look as obj_dialog_modal: pink when focused/hovered, dark blue otherwise.
// Dimmed while the round is playing out so it's obvious they're not live.
var _btn_alpha = (state == "choosing" && !global.dialog_open) ? 1 : 0.5;
draw_set_alpha(_btn_alpha);
draw_set_valign(fa_middle);
for (var i = 0; i < array_length(buttons); i++) {
    var _b   = buttons[i];
    var _spr = (focused_btn == i && state == "choosing") ? spr_btn_base_pink : spr_btn_base_dkblue;
    draw_sprite_stretched(_spr, 0, _b.cx - btn_w / 2, _b.cy - btn_h / 2, btn_w, btn_h);
    draw_text(_b.cx, _b.cy, _b.label);
}

// ── RESET DRAW STATE ─────────────────────────────────────────────────────────
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
