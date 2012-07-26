--
--GELD MOD v 1.1
--by Severak
--
--Licence: WTFPL (on all)
--
minetest.register_craftitem("geld:default",{
	description="Sestertius",
	stack_max=100,
	inventory_image="geld_default.png"
})

minetest.register_craft({
	output="geld:default 25",
	recipe={
		{"","default:mese",""},
		{"default:mese","default:mese","default:mese"},
		{"","default:mese",""}
	}
})

minetest.register_craftitem("geld:tetradrachm",{
	description="Tetradrachm",
	stack_max=100,
	inventory_image="geld_tetradrachm.png"
})

minetest.register_craftitem("geld:stela",{
	description="Stela",
	stack_max=100,
	inventory_image="geld_stela.png"
})

minetest.register_craftitem("geld:huf",{
	description="Forint",
	stack_max=100,
	inventory_image="geld_huf.png"
})

minetest.register_craftitem("geld:rupee",{
	description="Rupee",
	stack_max=100,
	inventory_image="geld_rupee.png"
})

minetest.register_craftitem("geld:tolar",{
	description="Tolar",
	stack_max=100,
	inventory_image="geld_tolar.png"
})

minetest.register_craftitem("geld:usd_5",{
	description="5 $",
	stack_max=100,
	inventory_image="geld_usd_5.png"
})

minetest.register_craftitem("geld:with_hole",{
	description="Money with hole",
	stack_max=100,
	inventory_image="geld_with_hole.png"
})

minetest.register_craftitem("geld:soviet_ruble",{
	description="Soviet ruble",
	stack_max=100,
	inventory_image="geld_soviet_ruble.png"
})

minetest.register_on_newplayer(function(player)
	local initial_geld=minetest.setting_get("give_initial_geld") or nil
	if initial_geld then
		player:get_inventory():add_item('main', 'geld:'..initial_geld)
	end
end)