draw_set_font(fnt_Quicksand);
fontSize = font_get_size(fnt_Quicksand);
BUFFER = cell(fontSize/2);

#region DRAW LETTERS

startX = 200;
startY = 60;
var charCount = 1;

for (var yy = 0; yy < yLetters; yy++){
    for (var xx = 0; xx < xLetters; xx++){
        #region code inside for loop
        var letter = a_letters[xx, yy];
        
        var drawX = startX + (xx * (fontSize*2));
        var drawY = startY + (yy * (fontSize + BUFFER));
        
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_text(drawX, drawY, letter);
        
        if (xx == gridX && yy = gridY) draw_sprite(sprite_button_back, 0, drawX, drawY);
        
        #endregion
    }
}

#endregion