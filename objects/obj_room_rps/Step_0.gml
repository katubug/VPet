/// @description State machine + input

state_timer++;
frames_alive++;

switch (state) {

    // ── CHOOSING ─────────────────────────────────────────────────────────────
    case "choosing":
        if (global.dialog_open) break;

        // Mouse hover keeps keyboard focus in sync, same as obj_dialog_modal
        var _mx = device_mouse_x_to_gui(0);
        var _my = device_mouse_y_to_gui(0);
        for (var i = 0; i < array_length(buttons); i++) {
            var _b = buttons[i];
            _b.hover = point_in_rectangle(_mx, _my,
                _b.cx - btn_w / 2, _b.cy - btn_h / 2,
                _b.cx + btn_w / 2, _b.cy + btn_h / 2);
            if (_b.hover) focused_btn = i;
        }

        // Left/right move focus, accept fires it. Each choice's own verb
        // (R/P/S key or its touch button) fires it directly.
        var _count = array_length(buttons);
        if (input_check_pressed("left"))  focused_btn = (focused_btn - 1 + _count) mod _count;
        if (input_check_pressed("right")) focused_btn = (focused_btn + 1) mod _count;

        var _picked = -1;
        if (input_check_pressed("accept")) _picked = focused_btn;
        for (var i = 0; i < _count; i++) {
            if (input_check_pressed(buttons[i].verb)) _picked = i;
        }
        if (_picked != -1) {
            focused_btn = _picked;
            play_round(_picked);
        }
        break;

    // ── SHAKE ────────────────────────────────────────────────────────────────
    // Fists pump for shake_frames, then the reveal pop plays. Draw GUI derives
    // all the motion from state_timer; this just fires the matching sounds and
    // waits it out.
    case "shake":
        // One "woom" at the start of each pump. state_timer is 1 on the first
        // frame we ever see "shake" (see set_state), so pump starts land on
        // 1, 1+shake_pump_frames, 1+2*shake_pump_frames, ...
        if (state_timer < shake_frames && (state_timer - 1) mod shake_pump_frames == 0) {
            audio_play_sound(snd_woom, 1, false);
        }
        // Impact the instant the fists swap to the real hands
        if (state_timer == shake_frames) {
            audio_play_sound(snd_impact, 1, false);
        }
        if (state_timer >= shake_frames + reveal_pop_frames) {
            if (round_result == "win")  player_score++;
            if (round_result == "lose") death_score++;
            set_state("result");
        }
        break;

    // ── RESULT ───────────────────────────────────────────────────────────────
    case "result":
        if (state_timer >= result_frames) {
            if (player_score >= wins_needed) {
                match_result = "win";
                set_state("game_over");
            } else if (death_score >= wins_needed) {
                // Death might take pity and let the pet go anyway
                match_result = (random(1) < pity_chance) ? "pity" : "lose";
                set_state("game_over");
            } else {
                if (round_result != "draw") round_number++;
                player_choice = -1;
                death_choice  = -1;
                set_state("choosing");
            }
        }
        break;

    // ── GAME OVER ────────────────────────────────────────────────────────────
    case "game_over":
        finish_match(); // guarded internally so the dialog only spawns once
        break;
}
