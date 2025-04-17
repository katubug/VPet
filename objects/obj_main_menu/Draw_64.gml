
for (row = 0; row < menu_rows; row++){
    for (column = 0; column < menu_columns; column++){
        var drawX = cursor + padding;
        var drawY = cursor + padding;
        
        if (row == gridX && column == gridY){
            draw_sprite(spr_ui_icon1, 0, drawX, drawY);
            draw_set_alpha(1);
        } else{
            draw_set_alpha(0.5)
    }
    }
}