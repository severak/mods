-- https://minetest.gitlab.io/minetest/
-- https://rubenwardy.com/minetest_modding_book/en/index.html

-- https://notabug.org/TenPlus1/farming/

local is_farming_redo = farming and farming.mod and farming.mod=='redo'

if is_farming_redo then
	print "[lowtech] Farming redo present."
end

-- Grindstone

local grains = {"farming:wheat", "farming:rye", "farming:oat", "farming:barley"}

-- how many items will be made from $total if these are made in batches of $unit units?
local discount = function(total, unit)
	if total <= unit then
		return math.floor(total / unit)
	elseif total <= unit *3 then
		return math.floor(total / unit) + 1
	end
	return math.floor(total / (unit +1) )
end

minetest.register_node("lowtech:grinding_stone", {
    description = "Grinding stone",
    tiles = {
		"default_cobble.png",
		"default_cobble.png",
		"default_cobble.png",
		"default_cobble.png",
		"default_cobble.png",
		"default_cobble.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, -0.125, 0.0625, 0.5, 0.0625}, -- NodeBox1
			{-0.5, -0.4375, -0.5, 0.5, -0.1875, 0.5}, -- NodeBox2
			{-0.4375, -0.125, -0.4375, 0.4375, 0.125, 0.375}, -- NodeBox3
		}
	},
    groups = {cracky=3, stone=3},
	
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("dst") and inv:is_empty("src")
	end,
	
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('src', 2)
		inv:set_size('dst', 4)
		meta:set_string("formspec", [[
size[8,9]
label[0,0;Grindstone]
list[context;src;1,1;2,2;]
list[context;dst;5,1;2,2;]
list[current_player;main;0,5;8,4;]		
]])
	end,
	
	on_punch = function(pos, node, player, pointed_thing)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		
		local found_grain_types = 0
		local found_grain_count = 0
		
		for _, grain in pairs(grains) do
			if inv:contains_item("src", grain .. " 4") then
				found_grain_types = found_grain_types + 1
				local taken = inv:remove_item("src", grain .. " 99")
				found_grain_count = found_grain_count + taken:get_count()
			end
		end
		
		if found_grain_types > 1 then
			inv:add_item("dst", "farming:flour_multigrain " .. discount(found_grain_count, 4))
		elseif found_grain_types == 1 then
			inv:add_item("dst", "farming:flour " .. discount(found_grain_count, 4))
		end
		
		if inv:contains_item("src", "farming:rice 4") then
			local taken = inv:remove_item("src","farming:rice 99")
			inv:add_item("dst", "farming:rice_flour " .. discount(taken:get_count(), 4))
		end
		
		if inv:contains_item("src", "vessels:glass_bottle") and (inv:contains_item("src", "farming:seed_hemp") or inv:contains_item("src", "farming:seed_sunflower") or inv:contains_item("src", "farming:hemp_leaf"))  then
			while (inv:contains_item("src", "vessels:glass_bottle")) do
				inv:remove_item("src", "vessels:glass_bottle 1")
				if inv:contains_item("src", "farming:seed_hemp 8") then
					local taken = inv:remove_item("src","farming:seed_hemp 8")
					inv:add_item("dst", "farming:hemp_oil")
				end
				if inv:contains_item("src", "farming:hemp_leaf 6") then
					local taken = inv:remove_item("src","farming:hemp_leaf 6")
					inv:add_item("dst", "farming:hemp_oil")
				end
				
				if inv:contains_item("src", "farming:seed_sunflower 8") then
					local taken = inv:remove_item("src","farming:seed_sunflower 8")
					inv:add_item("dst", "farming:sunflower_oil")
				end
				
				-- TODO - return bottles not used for oil
				-- TODO - crush also whole sunflower
			end
		end
		
		minetest.sound_play("default_gravel_footstep", { pos = pos})
	end,
	
})

minetest.register_craft({
    type = "shaped",
    output = "lowtech:grindstone",
    recipe = {
        {"", "default:cobble", ""},
        {"default:cobble", "default:stick",  "default:cobble"},
        {"", "default:cobble",  ""}
    }
})

-- TODO - electric mill

-- Spinning wheel

-- 4*cotton -> 1* wool
-- 2*cotton -> 1* string


minetest.register_node("lowtech:spinning_wheel", {
	description = "Spinning wheel",
	tiles = {
		"default_wood.png",
		"default_wood.png",
		"default_wood.png",
		"default_wood.png",
		"default_wood.png",
		"default_wood.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, 0, -0.375, 0.0625, 0.25, 0.25}, -- NodeBox1
			{-0.125, -0.5, -0.125, -0.0625, 0.5, 0}, -- NodeBox4
			{0.0625, -0.5, -0.0625, 0.125, 0.5, 0}, -- NodeBox5
			{-0.0625, -0.375, -0.375, 0.0625, -0.125, 0.25}, -- NodeBox6
			{-0.0625, -0.3125, -0.375, 0.0625, 0.1875, -0.1875}, -- NodeBox7
			{-0.0625, -0.3125, 0.0625, 0.0625, 0.25, 0.25}, -- NodeBox8
			{-0.125, 0.5, -0.125, 0.125, 0.5, 0}, -- NodeBox9
		}
	},
	groups = {wood=3},
})

-- Loom
minetest.register_node("lowtech:loom", {
	description = "Loom",
	tiles = {
		"default_wood.png",
		"default_wood.png",
		"default_wood.png",
		"default_wood.png",
		"default_wood.png",
		"default_wood.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}, -- NodeBox5
			{0.3125, -0.5, -0.0625, 0.4375, 0.1875, 0.0625}, -- NodeBox6
			{-0.4375, -0.5, -0.0625, -0.3125, 0.1875, 0.125}, -- NodeBox7
			{-0.5, 0.1875, 0.4375, 0.5, 0.3125, 0.5}, -- NodeBox8
			{-0.5, 0.1875, -0.5, -0.3125, 0.3125, 0.5}, -- NodeBox9
			{0.375, 0.1875, -0.5, 0.5, 0.3125, 0.5}, -- NodeBox10
			{-0.5, 0.1875, -0.5, 0.5, 0.3125, -0.375}, -- NodeBox11
		}
	},
	groups = {wood=3},
})


-- BONUS - ability to burn guinea pigs pellets

if minetest.get_modpath("guinea_pig") then
	minetest.register_craft({
		type = "fuel",
		recipe = "guinea_pig:pellets",
		burntime = 30,
	})
end
