archaeology={}
local a=archaeology
a.fossilSpawnHere={"default:stone","default:dirt"}
a.fossils={"archaeology:ammonite","archaeology:fossil"}

function a.placeFossil(minp,maxp)
	local rp={}
	rp.x=math.random(minp.x,maxp.x)
	rp.y=math.random(minp.y,maxp.y)
	rp.z=math.random(minp.y,maxp.y)
	local origNode=minetest.env:get_node(rp)
	if a.fossilSpawnHere[origNode.name] then
		minetest.env:set_node(rp,{name=a.pickOne(a.fossils) })
		print(string.format("ammonite spawned at %d;%d;%d", rp.x, rp.y, rp.z))
	else
		print(string.format("ammonite not spawned at %d;%d;%d", rp.x, rp.y, rp.z))
	end
end

function a.pickOne(set)
	if #set==1 then
		return set[1]
	end
	if #set>1 then
		return set[math.random(#set)]
	end
	return nil
end

minetest.register_node("archaeology:ammonite", {
	description = "Ammonite",
	tiles = {"default_stone.png^archaeology_ammonite.png"},
	inventory_image = "default_stone.png^archaeology_ammonite.png",
	is_ground_content = true,
	groups = {cracky=2}
})

minetest.register_node("archaeology:fossil", {
	description = "Fossil",
	tiles = {"archaeology_fossil.png"},
	inventory_image = "archaeology_fossil.png",
	is_ground_content = true,
	groups = {cracky=2}
})

minetest.register_on_generated(function(minp,maxp,seed)
	print(string.format("Generated %d;%d;%d - %d;%d;%d (%s)",minp.x,minp.y,minp.z, maxp.x,maxp.y,maxp.z, seed))
	a.placeFossil(minp,maxp)
end)