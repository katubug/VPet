// Only reached if somehow living != 0 in the death room — shouldn't normally happen.
if (global.game.living != 0) {
    draw_text(x, y, "How on earth did you get here?");
}
