minetest.register_node("asphalt:asphalt", {
	description = "Asphalt",
	drawtype = "raillike",
	tile_images = {"asphalt_asphalt.png"},
	inventory_image = "asphalt_asphalt.png",
	wield_image = "asphalt_asphalt.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		--fixed = <default>
	},
	material = minetest.digprop_dirtlike(0.75),
})

minetest.register_node("asphalt:line", {
	description = "Asphalt",
	drawtype = "raillike",
	tile_images = {"asphalt_line.png"},
	inventory_image = "asphalt_line.png",
	wield_image = "asphalt_line.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		--fixed = <default>
	},
	material = minetest.digprop_dirtlike(0.75),
})

minetest.register_node("asphalt:zebra", {
	description = "Asphalt",
	drawtype = "raillike",
	tile_images = {"asphalt_zebra.png"},
	inventory_image = "asphalt_zebra.png",
	wield_image = "asphalt_zebra.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		--fixed = <default>
	},
	material = minetest.digprop_dirtlike(0.75),
})