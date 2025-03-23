function clutter_happiness(_clutter_amount) 
{
     global.game.happiness -= (_clutter_amount)
    show_debug_message(global.game.happiness)
}