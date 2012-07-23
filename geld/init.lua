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

minetest.register_on_newplayer(function(player)
	local initial_geld=minetest.setting_get("give_initial_geld") or nil
	if initial_geld then
		player:get_inventory():add_item('main', 'geld:'..initial_geld)
	end
end)