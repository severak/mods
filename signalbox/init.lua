-- signalbox_switch

mesecon.register_node("signalbox:signalbox_switch", {
	paramtype2="facedir",
	description="More visible switch",
	is_ground_content = false,
	light_source = 8,
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = function (pos, node)
		if(mesecon.flipstate(pos, node) == "on") then
			mesecon.receptor_on(pos)
		else
			mesecon.receptor_off(pos)
		end
		minetest.sound_play("signalbox_switch", { pos = pos }, true)
	end
},{
	groups = {dig_immediate=2},
	tiles = {	"signalbox_switch_side.png", "signalbox_switch_side.png",
				"signalbox_switch_side.png", "signalbox_switch_side.png",
				"signalbox_switch_off.png", "signalbox_switch_off.png"},
	mesecons = {receptor = { state = mesecon.state.off }}
},{
	groups = {dig_immediate=2, not_in_creative_inventory=1},
	tiles = {	"signalbox_switch_side.png", "signalbox_switch_side.png",
				"signalbox_switch_side.png", "signalbox_switch_side.png",
				"signalbox_switch_on.png", "signalbox_switch_on.png"},
	mesecons = {receptor = { state = mesecon.state.on }}
})

mesecon.register_node("signalbox:signalbox_switch_panel", {
	paramtype2="facedir",
	description="Signal box panel - switch",
	is_ground_content = false,
	light_source = 6,
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = function (pos, node)
		if(mesecon.flipstate(pos, node) == "on") then
			mesecon.receptor_on(pos)
		else
			mesecon.receptor_off(pos)
		end
		minetest.sound_play("signalbox_switch", { pos = pos }, true)
	end
},{
	groups = {dig_immediate=2},
	tiles = {	"signalbox_panel_switch_off.png", "signalbox_panel.png",
				"signalbox_panel.png", "signalbox_panel.png",
				"signalbox_panel.png", "signalbox_panel.png"},
	mesecons = {receptor = { state = mesecon.state.off }}
},{
	groups = {dig_immediate=2, not_in_creative_inventory=1},
	tiles = {	"signalbox_panel_switch_on.png", "signalbox_panel.png",
				"signalbox_panel.png", "signalbox_panel.png",
				"signalbox_panel.png", "signalbox_panel.png"},
	mesecons = {receptor = { state = mesecon.state.on }}
})

mesecon.register_node("signalbox:signalbox_switch_panel_r", {
	paramtype2="facedir",
	description="Signal box panel - switch",
	is_ground_content = false,
	light_source = 6,
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = function (pos, node)
		if(mesecon.flipstate(pos, node) == "on") then
			mesecon.receptor_on(pos)
		else
			mesecon.receptor_off(pos)
		end
		minetest.sound_play("signalbox_switch", { pos = pos }, true)
	end
},{
	groups = {dig_immediate=2},
	tiles = {	"signalbox_panel_r_switch_off.png", "signalbox_panel.png",
				"signalbox_panel.png", "signalbox_panel.png",
				"signalbox_panel.png", "signalbox_panel.png"},
	mesecons = {receptor = { state = mesecon.state.off }}
},{
	groups = {dig_immediate=2, not_in_creative_inventory=1},
	tiles = {	"signalbox_panel_r_switch_on.png", "signalbox_panel.png",
				"signalbox_panel.png", "signalbox_panel.png",
				"signalbox_panel.png", "signalbox_panel.png"},
	mesecons = {receptor = { state = mesecon.state.on }}
})

minetest.register_node("signalbox:line", {
	paramtype2="facedir",
    description = "Signal box - line",
    tiles = {
        "signalbox_line.png",    -- y+
        "signalbox_panel.png",  -- y-
        "signalbox_panel.png", -- x+
        "signalbox_panel.png",  -- x-
        "signalbox_panel.png",  -- z+
        "signalbox_panel.png", -- z-
    },
	light_source = 6,
    groups = {dig_immediate=2},
})

minetest.register_node("signalbox:merge", {
	paramtype2="facedir",
    description = "Signal box - merge",
    tiles = {
        "signalbox_merge.png",    -- y+
        "signalbox_panel.png",  -- y-
        "signalbox_panel.png", -- x+
        "signalbox_panel.png",  -- x-
        "signalbox_panel.png",  -- z+
        "signalbox_panel.png", -- z-
    },
	light_source = 6,
    groups = {dig_immediate=2},
})

minetest.register_node("signalbox:merge_r", {
	paramtype2="facedir",
    description = "Signal box - merge",
    tiles = {
        "signalbox_merge_r.png",    -- y+
        "signalbox_panel.png",  -- y-
        "signalbox_panel.png", -- x+
        "signalbox_panel.png",  -- x-
        "signalbox_panel.png",  -- z+
        "signalbox_panel.png", -- z-
    },
	light_source = 6,
    groups = {dig_immediate=2},
})

minetest.register_node("signalbox:blank", {
    description = "Signal box - blank panel",
    tiles = {
        "signalbox_panel.png",    -- y+
        "signalbox_panel.png",  -- y-
        "signalbox_panel.png", -- x+
        "signalbox_panel.png",  -- x-
        "signalbox_panel.png",  -- z+
        "signalbox_panel.png", -- z-
    },
    groups = {dig_immediate=2},
})

--[[
minetest.register_craft({
	output = "signalbox_switch:mesecon_switch_off 2",
	recipe = {
		{"default:steel_ingot", "default:cobble", "default:steel_ingot"},
		{"group:mesecon_conductor_craftable","", "group:mesecon_conductor_craftable"},
	}
})
]]
