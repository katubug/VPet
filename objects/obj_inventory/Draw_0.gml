/*
draw_text(0, 0, string("Inventory: ") + string(global.inventory));

for(var i = 0; i < ds_list_size(global.inventory); i += 1) {
	item = ds_list_find_value(global.inventory, i);

	item_name = item.display_name;

	draw_text(x + 10, y + 30 + (i * 20), string("Item Owned: ") + string(string(item_name)));

	draw_sprite(item.sprite_index, 0, x + 20, y + 30 + (i * 20));
}
  */