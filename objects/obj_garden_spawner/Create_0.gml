// Spawns all 9 garden plot instances in a 3x3 grid
// Adjust start_x/start_y to move the whole garden, spacing to change plot distance
var _start_x = 62;  // 250 ÷ 4 ≈ 62
var _start_y  = 115; // 460 ÷ 4 = 115
var _spacing  = 25;  // 100 ÷ 4 = 25
var _cols     = 3;
var _rows     = 3;

for (var _r = 0; _r < _rows; _r++) {
    for (var _c = 0; _c < _cols; _c++) {
        var _plot = instance_create_depth(
            _start_x + _c * _spacing,
            _start_y + _r * _spacing,
            0, obj_garden_plot_parent
        );
        // Assign index directly — guaranteed unique and in the correct order
        _plot.plot_index = _r * _cols + _c;
    }
}
