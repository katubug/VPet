/// @description Core Inventory System
/// This script contains the item database and all inventory management functions

#region ITEM DATABASE

/// @function inventory_init_database()
/// @description Initialize the item database with all game items
function inventory_init_database() {
    
    // Create global item database
    global.item_database = {};
    
    // ========================================
    // FOOD ITEMS
    // ========================================
    
    global.item_database.apple = {
        id: "apple",
        name: "Red Apple",
        category: "food",
        sprite: spr_food_bibo, // Replace with your actual sprite
        description: "A crisp, juicy red apple. Restores hunger.",
        hunger_restore: 3,
        stats: {
            joy: 0,
            nonsense: -1,  // Decreases nonsense
            selfesteem: 0,
            enthusiasm: 2   // Increases enthusiasm
        },
        buy_price: 5,
        sell_price: 2,
        rarity: "common",
        max_stack: 99
    };
    
    global.item_database.bread = {
        id: "bread",
        name: "Fresh Bread",
        category: "food",
        sprite: spr_food_basic, // Replace with your actual sprite
        description: "Warm, freshly baked bread.",
        hunger_restore: 5,
        stats: {
            joy: 1,
            nonsense: 0,
            selfesteem: 1,
            enthusiasm: 0
        },
        buy_price: 8,
        sell_price: 3,
        rarity: "common",
        max_stack: 99
    };
    
    global.item_database.lemon = {
        id: "lemon",
        name: "Lemon",
        category: "food",
        sprite: spr_food_basic, // Replace with your actual sprite
        description: "A sour lemon. Good for cooking!",
        hunger_restore: 1,
        stats: {
            joy: -1,        // Sour = less joy
            nonsense: 2,    // Silly/zany food
            selfesteem: 0,
            enthusiasm: 1
        },
        buy_price: 3,
        sell_price: 1,
        rarity: "common",
        max_stack: 99
    };
    
    // ========================================
    // TOY ITEMS
    // ========================================
    
    global.item_database.ball = {
        id: "ball",
        name: "Rubber Ball",
        category: "toy",
        sprite: spr_food_basic, // Replace with your toy sprite
        description: "A bouncy rubber ball. Your pet loves to play fetch!",
        happiness_restore: 5,
        animation: "ball_play", // Animation ID to play
        buy_price: 15,
        sell_price: 7,
        rarity: "common",
        max_stack: 1,
        durability: 10,  // Number of uses before breaking
        current_durability: 10
    };
    
    global.item_database.plushie = {
        id: "plushie",
        name: "Soft Plushie",
        category: "toy",
        sprite: spr_food_basic, // Replace with your toy sprite
        description: "A cuddly stuffed toy. Perfect for naptime.",
        happiness_restore: 3,
        animation: "plushie_cuddle",
        buy_price: 20,
        sell_price: 10,
        rarity: "uncommon",
        max_stack: 1,
        durability: 20,
        current_durability: 20
    };
    
    // ========================================
    // SEED ITEMS
    // ========================================
    
    global.item_database.tomato_seed = {
        id: "tomato_seed",
        name: "Tomato Seed",
        category: "seed",
        sprite: spr_food_basic, // Replace with your seed sprite
        description: "Plant this to grow fresh tomatoes.",
        grow_time: 120, // Seconds to grow
        harvest_item: "tomato", // What it produces
        harvest_amount: 3, // How many you get
        buy_price: 10,
        sell_price: 4,
        rarity: "common",
        max_stack: 99
    };
    
    global.item_database.carrot_seed = {
        id: "carrot_seed",
        name: "Carrot Seed",
        category: "seed",
        sprite: spr_food_basic, // Replace with your seed sprite
        description: "Plant this to grow crunchy carrots.",
        grow_time: 90,
        harvest_item: "carrot",
        harvest_amount: 4,
        buy_price: 8,
        sell_price: 3,
        rarity: "common",
        max_stack: 99
    };
    
    // ========================================
    // INGREDIENT ITEMS
    // ========================================
    
    global.item_database.flour = {
        id: "flour",
        name: "Flour",
        category: "ingredient",
        sprite: spr_food_basic, // Replace with your ingredient sprite
        description: "Basic baking ingredient. Used in many recipes.",
        recipes: ["bread", "cake", "cookies"], // What can be made with it
        buy_price: 5,
        sell_price: 2,
        rarity: "common",
        max_stack: 99
    };
    
    global.item_database.sugar = {
        id: "sugar",
        name: "Sugar",
        category: "ingredient",
        sprite: spr_food_basic, // Replace with your ingredient sprite
        description: "Sweet crystals for baking treats.",
        recipes: ["cake", "cookies", "candy"],
        buy_price: 6,
        sell_price: 2,
        rarity: "common",
        max_stack: 99
    };
    
    global.item_database.egg = {
        id: "egg",
        name: "Egg",
        category: "ingredient",
        sprite: spr_food_basic, // Replace with your ingredient sprite
        description: "A fresh egg. Great for cooking!",
        recipes: ["cake", "bread", "omelette"],
        buy_price: 4,
        sell_price: 1,
        rarity: "common",
        max_stack: 24
    };
    
    show_debug_message("Item database initialized with " + string(variable_struct_names_count(global.item_database)) + " items");
}

#endregion

#region INVENTORY INITIALIZATION

/// @function inventory_init()
/// @description Initialize the player's inventory structure
function inventory_init() {
    
    // Initialize item database first
    inventory_init_database();
    
    // Create inventory structure
    global.inventory = {
        food: [],
        toy: [],
        seed: [],
        ingredient: []
    };
    
    // Track evolution stats from foods eaten
    global.pet_diet_stats = {
        joy_total: 0,
        nonsense_total: 0,
        selfesteem_total: 0,
        enthusiasm_total: 0
    };
    
    // Track discovered items (for collection/journal)
    global.discovered_items = ds_map_create();
    
    // Storage limits (can be upgraded later)
    global.inventory_limits = {
        food: 50,
        toy: 20,
        seed: 30,
        ingredient: 50
    };
    
    show_debug_message("Inventory system initialized");
}

#endregion

#region CORE INVENTORY FUNCTIONS

/// @function inventory_add(item_id, quantity)
/// @description Add an item to the inventory
/// @param {String} item_id - The item's ID from the database
/// @param {Real} quantity - How many to add
/// @return {Bool} True if successful, false if failed
function inventory_add(_item_id, _quantity = 1) {
    
    // Auto-initialize if needed (safety check)
    if (!variable_global_exists("inventory")) {
        inventory_init();
    }
    
    // Get item data from database
    var item_data = inventory_get_item_data(_item_id);
    
    if (item_data == undefined) {
        show_debug_message("ERROR: Item '" + _item_id + "' not found in database!");
        return false;
    }
    
    var category = item_data.category;
    var inventory_array = global.inventory[$ category];
    
    // Check storage limit
    var current_count = inventory_get_total_items(category);
    if (current_count >= global.inventory_limits[$ category]) {
        show_debug_message("Inventory full! Cannot add " + item_data.name);
        return false;
    }
    
    // Mark as discovered
    global.discovered_items[? _item_id] = true;
    
    // Check if item already exists in inventory
    var item_found = false;
    var first_stack_index = -1;
    
    for (var i = 0; i < array_length(inventory_array); i++) {
        if (inventory_array[i].id == _item_id) {
            // Remember the first stack we found
            if (first_stack_index == -1) {
                first_stack_index = i;
            }
            
            // Item exists - check if we can stack it
            var max_stack = item_data.max_stack;
            var current_quantity = inventory_array[i].quantity;
            var space_available = max_stack - current_quantity;
            
            if (space_available > 0) {
                // Can add at least some to this stack
                var amount_to_add = min(_quantity, space_available);
                inventory_array[i].quantity += amount_to_add;
                _quantity -= amount_to_add;
                item_found = true;
                
                show_debug_message("Added " + string(amount_to_add) + "x " + item_data.name + " (now have " + string(inventory_array[i].quantity) + ")");
                
                // If we've added everything, we're done
                if (_quantity == 0) {
                    break;
                }
            }
        }
    }
    
    // If we still have items left to add, create new stack(s)
    if (_quantity > 0) {
        var max_stack = item_data.max_stack;
        
        while (_quantity > 0) {
            var stack_quantity = min(_quantity, max_stack);
            
            var new_item = {
                id: _item_id,
                quantity: stack_quantity,
                // Copy any mutable properties (like durability)
                durability: item_data[$ "current_durability"] ?? -1,
            };
            
            array_push(inventory_array, new_item);
            show_debug_message("Added " + string(stack_quantity) + "x " + item_data.name + " (new stack)");
            
            _quantity -= stack_quantity;
        }
    }
    
    return true;
}

/// @function inventory_remove(item_id, quantity)
/// @description Remove an item from the inventory
/// @param {String} item_id - The item's ID
/// @param {Real} quantity - How many to remove
/// @return {Bool} True if successful, false if not enough items
function inventory_remove(_item_id, _quantity = 1) {
    
    var item_data = inventory_get_item_data(_item_id);
    
    if (item_data == undefined) {
        show_debug_message("ERROR: Item '" + _item_id + "' not found in database!");
        return false;
    }
    
    var category = item_data.category;
    var inventory_array = global.inventory[$ category];
    
    // Check if we have enough of the item
    if (!inventory_has(_item_id, _quantity)) {
        show_debug_message("Not enough " + item_data.name + " to remove!");
        return false;
    }
    
    // Remove the quantity
    var remaining = _quantity;
    for (var i = 0; i < array_length(inventory_array); i++) {
        if (inventory_array[i].id == _item_id) {
            if (inventory_array[i].quantity >= remaining) {
                // This stack has enough
                inventory_array[i].quantity -= remaining;
                
                // Remove entry if quantity is 0
                if (inventory_array[i].quantity <= 0) {
                    array_delete(inventory_array, i, 1);
                }
                
                show_debug_message("Removed " + string(_quantity) + "x " + item_data.name);
                return true;
            } else {
                // Remove what we can from this stack
                remaining -= inventory_array[i].quantity;
                array_delete(inventory_array, i, 1);
                i--; // Adjust index after deletion
            }
        }
    }
    
    return true;
}

/// @function inventory_has(item_id, quantity)
/// @description Check if the player has enough of an item
/// @param {String} item_id - The item's ID
/// @param {Real} quantity - How many needed
/// @return {Bool} True if player has enough
function inventory_has(_item_id, _quantity = 1) {
    
    var item_data = inventory_get_item_data(_item_id);
    
    if (item_data == undefined) return false;
    
    var category = item_data.category;
    var inventory_array = global.inventory[$ category];
    
    var total = 0;
    for (var i = 0; i < array_length(inventory_array); i++) {
        if (inventory_array[i].id == _item_id) {
            total += inventory_array[i].quantity;
        }
    }
    
    return (total >= _quantity);
}

/// @function inventory_get_quantity(item_id)
/// @description Get total quantity of an item in inventory
/// @param {String} item_id - The item's ID
/// @return {Real} Total quantity owned
function inventory_get_quantity(_item_id) {
    
    var item_data = inventory_get_item_data(_item_id);
    
    if (item_data == undefined) return 0;
    
    var category = item_data.category;
    var inventory_array = global.inventory[$ category];
    
    var total = 0;
    for (var i = 0; i < array_length(inventory_array); i++) {
        if (inventory_array[i].id == _item_id) {
            total += inventory_array[i].quantity;
        }
    }
    
    return total;
}

/// @function inventory_get_item_data(item_id)
/// @description Get item data from the database
/// @param {String} item_id - The item's ID
/// @return {Struct} Item data or undefined if not found
function inventory_get_item_data(_item_id) {
    return global.item_database[$ _item_id];
}

/// @function inventory_get_all_items(category)
/// @description Get all items in a category
/// @param {String} category - Category name (food, toy, seed, ingredient)
/// @return {Array} Array of items in that category
function inventory_get_all_items(_category) {
    return global.inventory[$ _category];
}

/// @function inventory_get_total_items(category)
/// @description Get total number of item slots used in a category
/// @param {String} category - Category name
/// @return {Real} Number of different items (not total quantity)
function inventory_get_total_items(_category) {
    return array_length(global.inventory[$ _category]);
}

/// @function inventory_clear(category)
/// @description Clear all items from a category (or all categories if no param)
/// @param {String} category - Optional category to clear
function inventory_clear(_category = "") {
    if (_category == "") {
        // Clear all categories
        global.inventory.food = [];
        global.inventory.toy = [];
        global.inventory.seed = [];
        global.inventory.ingredient = [];
        show_debug_message("Cleared entire inventory");
    } else {
        // Clear specific category
        global.inventory[$ _category] = [];
        show_debug_message("Cleared " + _category + " inventory");
    }
}

#endregion

#region FEEDING SYSTEM

/// @function inventory_feed_pet(food_id)
/// @description Feed a food item to the pet, restore hunger, and update stats
/// @param {String} food_id - The food item's ID
/// @return {Bool} True if successfully fed, false if failed
function inventory_feed_pet(_food_id) {
    
    var item_data = inventory_get_item_data(_food_id);
    
    // Check if it's actually food
    if (item_data == undefined || item_data.category != "food") {
        show_debug_message("ERROR: " + _food_id + " is not a food item!");
        return false;
    }
    
    // Check if pet is already full
    if (global.game.hunger >= 20) {
        show_debug_message("Pet is full!");
        
        // Show popup message
        var popup = instance_create_depth(0, 0, -9999, obj_popup_message);
        popup.message = "Pet is full!";

        return false;
    }
    
    // Check if player has the food
    if (!inventory_has(_food_id, 1)) {
        show_debug_message("Don't have any " + item_data.name + "!");
        return false;
    }
    
    // Remove the food from inventory
    inventory_remove(_food_id, 1);
    
    // Restore hunger (cap at 20)
    global.game.hunger = min(global.game.hunger + item_data.hunger_restore, 20);
    
    // Update diet stats for evolution
    global.pet_diet_stats.joy_total += item_data.stats.joy;
    global.pet_diet_stats.nonsense_total += item_data.stats.nonsense;
    global.pet_diet_stats.selfesteem_total += item_data.stats.selfesteem;
    global.pet_diet_stats.enthusiasm_total += item_data.stats.enthusiasm;
    
    // Update global.pet stats (the actual stats that affect evolution)
    global.pet.joy += item_data.stats.joy;
    global.pet.nonsense += item_data.stats.nonsense;
    global.pet.selfesteem += item_data.stats.selfesteem;
    global.pet.enthusiasm += item_data.stats.enthusiasm;
    
    show_debug_message("Pet ate " + item_data.name + "!");
    show_debug_message("Stats changed - Joy: " + string(item_data.stats.joy) + 
                      ", Nonsense: " + string(item_data.stats.nonsense) +
                      ", Self-esteem: " + string(item_data.stats.selfesteem) +
                      ", Enthusiasm: " + string(item_data.stats.enthusiasm));
    
    return true;
}

#endregion

#region HELPER FUNCTIONS

/// @function inventory_is_discovered(item_id)
/// @description Check if player has discovered this item
/// @param {String} item_id - The item's ID
/// @return {Bool} True if discovered
function inventory_is_discovered(_item_id) {
    return ds_map_exists(global.discovered_items, _item_id);
}

/// @function inventory_get_discovered_count()
/// @description Get total number of discovered items
/// @return {Real} Number of unique items discovered
function inventory_get_discovered_count() {
    return ds_map_size(global.discovered_items);
}

/// @function inventory_get_total_items_in_database()
/// @description Get total items in the database
/// @return {Real} Total items that exist
function inventory_get_total_items_in_database() {
    return variable_struct_names_count(global.item_database);
}

#endregion
