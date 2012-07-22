--
--Tourist paths from Czech republic
--
--and various symbols from beer to pig
--
--Author: Severak
--Licence: MIT to all
--Version: 1.0
--
function kct_register_color(color)

  minetest.register_node("kct:"..color, {
  	description = color.." trail",
  	drawtype = "signlike",
    tile_images = {"kct_"..color..".png"},
  	inventory_image = "kct_"..color..".png",
    paramtype = "light",
  	paramtype2 = "wallmounted",
    selection_box = {type = "wallmounted"}
  })
  
  minetest.register_node("kct:"..color.."_right", {
  	description = color.." trail right",
  	drawtype = "signlike",
    tile_images = {"kct_"..color.."_right.png"},
  	inventory_image = "kct_"..color.."_right.png",
    paramtype = "light",
  	paramtype2 = "wallmounted",
    selection_box = {type = "wallmounted"}
  })
  
  minetest.register_node("kct:"..color.."_right_sign", {
  	description = color.." trail sign right",
  	drawtype = "signlike",
    tile_images = {"kct_"..color.."_right_sign.png"},
  	inventory_image = "kct_"..color.."_right_sign.png",
    paramtype = "light",
  	paramtype2 = "wallmounted",
    selection_box = {type = "wallmounted"},
    metadata_name = "sign"
  })
  
  minetest.register_node("kct:"..color.."_left", {
  	description = color.." trail letf",
  	drawtype = "signlike",
    tile_images = {"kct_"..color.."_left.png"},
  	inventory_image = "kct_"..color.."_left.png",
    paramtype = "light",
  	paramtype2 = "wallmounted",
    selection_box = {type = "wallmounted"}
  })
  
  minetest.register_node("kct:"..color.."_left_sign", {
  	description = color.." trail sign letf",
  	drawtype = "signlike",
    tile_images = {"kct_"..color.."_left_sign.png"},
  	inventory_image = "kct_"..color.."_left_sign.png",
    paramtype = "light",
  	paramtype2 = "wallmounted",
    selection_box = {type = "wallmounted"},
    metadata_name = "sign"
  })

end

kct_register_color("red")
kct_register_color("yellow")
kct_register_color("green")

minetest.register_node("kct:bus", {
  	description = "Bus symbol",
  	drawtype = "signlike",
    tile_images = {"kct_bus.png"},
  	inventory_image = "kct_bus.png",
    paramtype = "light",
  	paramtype2 = "wallmounted",
    selection_box = {type = "wallmounted"}
})

minetest.register_node("kct:beer", {
  	description = "Beer symbol",
  	drawtype = "signlike",
    tile_images = {"kct_beer.png"},
  	inventory_image = "kct_beer.png",
    paramtype = "light",
  	paramtype2 = "wallmounted",
    selection_box = {type = "wallmounted"}
})

minetest.register_node("kct:postbox", {
	description = "Postbox",
	tile_images = {"kct_orange.png", "kct_orange.png", "kct_orange.png",
		"kct_orange.png", "kct_orange.png", "kct_post.png"},
	paramtype2 = "facedir",
	metadata_name = "chest",
	legacy_facedir_simple = true,
})

minetest.register_node("kct:city", {
  	description = "City name",
  	drawtype = "signlike",
    tile_images = {"kct_city.png"},
  	inventory_image = "kct_city.png",
    paramtype = "light",
  	paramtype2 = "wallmounted",
    selection_box = {type = "wallmounted"},
    metadata_name = "sign"
})

minetest.register_node("kct:city_end", {
  	description = "City name at exit",
  	drawtype = "signlike",
    tile_images = {"kct_city_end.png"},
  	inventory_image = "kct_city_end.png",
    paramtype = "light",
  	paramtype2 = "wallmounted",
    selection_box = {type = "wallmounted"},
    metadata_name = "sign"
})

minetest.register_node("kct:street", {
  	description = "Street name",
  	drawtype = "signlike",
    tile_images = {"kct_street.png"},
  	inventory_image = "kct_street.png",
    paramtype = "light",
  	paramtype2 = "wallmounted",
    selection_box = {type = "wallmounted"},
    metadata_name = "sign"
})

minetest.register_node("kct:crossing", {
  	description = "Railway crossing",
  	drawtype = "signlike",
    tile_images = {"kct_crossing.png"},
  	inventory_image = "kct_crossing.png",
    paramtype = "light",
  	paramtype2 = "wallmounted",
    selection_box = {type = "wallmounted"}
})

minetest.register_node("kct:pig", {
  	description = "Pig symbol",
  	drawtype = "signlike",
    tile_images = {"kct_pig.png"},
  	inventory_image = "kct_pig.png",
    paramtype = "light",
  	paramtype2 = "wallmounted",
    selection_box = {type = "wallmounted"},
    metadata_name = "sign"
})