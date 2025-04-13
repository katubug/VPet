
for (row = 0; row < menu_rows; row++){
    for (column = 0; column < menu_columns; column++){
        var drawX = cursor + padding;
        var drawY = cursor + padding;
        
        if (row == gridX && column == gridY) draw_sprite(spr_adult_clup, 0, drawX, drawY);
    }
}