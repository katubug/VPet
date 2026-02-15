/// Create Event

// Check if inventory exists
if (variable_global_exists("inventory")) {
    show_debug_message("Inventory EXISTS");
    show_debug_message("Food array length: " + string(array_length(global.inventory.food)));
} else {
    show_debug_message("Inventory DOES NOT EXIST - initializing now");
    inventory_init();
}

// Now add items
inventory_add("apple", 1);

inventory_add("apple", 1);        // Add 1 apple
inventory_add("flour", 10);       // Add 10 flour
inventory_add("ball", 1);         // Add 1 ball

// Check if inventory is working
show_debug_message("Food items: " + string(array_length(inventory_get_all_items("food"))));
show_debug_message("Lemon count: " + string(inventory_get_quantity("lemon")));