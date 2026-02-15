/// @description Draw HUD

draw_set_font(fnt_Quicksand);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var hud_x = x + margin;
var hud_y = y + margin;

// === ALWAYS VISIBLE INFO ===

// Player Name
draw_set_color(c_white);
draw_text(hud_x, hud_y, "Owner: " + string(global.game.ownername));
hud_y += 25;

// Pet Name (if you have it stored, otherwise skip this line)
if (variable_global_exists("game") && variable_struct_exists(global.game, "petname")) {
    draw_text(hud_x, hud_y, "Pet: " + string(global.game.petname));
    hud_y += 25;
}

// Pet Type
draw_text(hud_x, hud_y, "Type: " + string(global.game.current_pet_type));
hud_y += 30; // Extra space before bars

// === HUNGER BAR ===
// Label
draw_set_color(c_white);
draw_text(hud_x, hud_y, "Hunger");

// Bar background
draw_set_alpha(bar_bg_alpha);
draw_set_color(color_bg);
draw_rectangle(hud_x, hud_y + 20, hud_x + bar_width, hud_y + 20 + bar_height, false);
draw_set_alpha(1);

// Bar fill
var hunger_percent = clamp(global.game.hunger / 20, 0, 1);
var hunger_fill_width = bar_width * hunger_percent;

draw_set_alpha(bar_fill_alpha);
draw_set_color(color_hunger_full);
draw_rectangle(hud_x, hud_y + 20, hud_x + hunger_fill_width, hud_y + 20 + bar_height, false);
draw_set_alpha(1);

// Bar outline
draw_set_color(color_border);
for (var i = 0; i < bar_outline; i++) {
    draw_rectangle(hud_x - i, hud_y + 20 - i, hud_x + bar_width + i, hud_y + 20 + bar_height + i, true);
}

hud_y += bar_height + 20 + bar_spacing;

// === HAPPINESS BAR ===
// Label
draw_set_color(c_white);
draw_text(hud_x, hud_y, "Happiness");

// Bar background
draw_set_alpha(bar_bg_alpha);
draw_set_color(color_bg);
draw_rectangle(hud_x, hud_y + 20, hud_x + bar_width, hud_y + 20 + bar_height, false);
draw_set_alpha(1);

// Bar fill
var happiness_percent = clamp(global.game.happiness / 20, 0, 1);
var happiness_fill_width = bar_width * happiness_percent;

draw_set_alpha(bar_fill_alpha);
draw_set_color(color_happiness_full);
draw_rectangle(hud_x, hud_y + 20, hud_x + happiness_fill_width, hud_y + 20 + bar_height, false);
draw_set_alpha(1);

// Bar outline
draw_set_color(color_border);
for (var i = 0; i < bar_outline; i++) {
    draw_rectangle(hud_x - i, hud_y + 20 - i, hud_x + bar_width + i, hud_y + 20 + bar_height + i, true);
}

hud_y += bar_height + 20 + bar_spacing + 10; // Extra space before extended stats

// === EXTENDED STATS (TOGGLE WITH SHIFT+S) ===
if (show_extended_stats) {
    
    // Draw semi-transparent background for extended stats
    draw_set_alpha(0.8);
    draw_set_color(c_dkgray);
    var extended_height = 140;
    draw_rectangle(hud_x - 10, hud_y - 5, hud_x + bar_width + 10, hud_y + extended_height, false);
    draw_set_alpha(1);
    
    // Border
    draw_set_color(c_white);
    draw_rectangle(hud_x - 10, hud_y - 5, hud_x + bar_width + 10, hud_y + extended_height, true);
    
    // Title
    draw_set_color(c_yellow);
    draw_text(hud_x, hud_y, "Extended Stats:");
    hud_y += 25;
    
    // Stats
    draw_set_color(c_white);
    
    // Check if global.pet exists, otherwise use fallback
    var joy_val = 0;
    var nonsense_val = 0;
    var enthusiasm_val = 0;
    var selfesteem_val = 0;
    
    if (variable_global_exists("pet")) {
        if (variable_struct_exists(global.pet, "joy")) joy_val = global.pet.joy;
        if (variable_struct_exists(global.pet, "nonsense")) nonsense_val = global.pet.nonsense;
        if (variable_struct_exists(global.pet, "enthusiasm")) enthusiasm_val = global.pet.enthusiasm;
        if (variable_struct_exists(global.pet, "selfesteem")) selfesteem_val = global.pet.selfesteem;
    }
    
    draw_text(hud_x, hud_y, "Joy: " + string(joy_val));
    hud_y += 20;
    
    draw_text(hud_x, hud_y, "Nonsense: " + string(nonsense_val));
    hud_y += 20;
    
    draw_text(hud_x, hud_y, "Enthusiasm: " + string(enthusiasm_val));
    hud_y += 20;
    
    draw_text(hud_x, hud_y, "Self-esteem: " + string(selfesteem_val));
    hud_y += 20;
    
    // Pet Age (if you have it)
    if (variable_global_exists("game") && variable_struct_exists(global.game, "pet_age")) {
        draw_text(hud_x, hud_y, "Age: " + string(global.game.pet_age) + " days");
    } else {
        draw_text(hud_x, hud_y, "Age: N/A");
    }
    
    // Show toggle hint
    draw_set_alpha(0.6);
    draw_set_color(c_ltgray);
    draw_text(hud_x, hud_y + 25, "Press Shift+S to hide");
    draw_set_alpha(1);
    
} else {
    // Show hint to open extended stats
    draw_set_alpha(0.6);
    draw_set_color(c_ltgray);
    draw_text(hud_x, hud_y, "Press Shift+S for stats");
    draw_set_alpha(1);
}

// Reset draw settings
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
