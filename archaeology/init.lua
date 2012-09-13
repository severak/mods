--Archaeology mod for minetest
--Licence: WTFPL
--Author: Severak
archaeology={}
local a=archaeology
a.fossilSpawnHere={["default:stone"]=true,["default:dirt"]=true}
a.fossils={"archaeology:ammonite"}
a.ruins={"kostel","kriz"}
a.modpath=minetest.get_modpath("archaeology")
a.palette={
  c="default:cobble",
  w="default:wood",
  g="default:glass",
  b="default:brick",
  s="default:steelblock",
  S="default:sandstone",
  f="default:fence_wood",
  m="default:mese",
  d="default:dirt"  
}

function a.placeFossil(minp,maxp)
	local rp={}
	rp.x=math.random(minp.x,maxp.x)
	rp.y=math.random(minp.y,maxp.y)
	rp.z=math.random(minp.y,maxp.y)
	local thisFossil=a.pickOne(a.fossils)
	local oNodeName=minetest.env:get_node(rp).name
	if a.fossilSpawnHere[oNodeName] then
		print(string.format("%s spawned at (%d,%d,%d) (%s)", thisFossil, rp.x, rp.y, rp.z, oNodeName))
		minetest.env:add_node(rp,{name=thisFossil })
	else
		--print(string.format("%s NOT spawned at %d;%d;%d (%s)", thisFossil,  rp.x, rp.y, rp.z, oNodeName))
	end
end

function a.findPosForRuin(minp,maxp)
	local rp={}
	rp.x=math.random(minp.x,maxp.x)
	rp.y=math.random(minp.y,maxp.y)
	rp.z=math.random(minp.y,maxp.y)
	local oNodeName=minetest.env:get_node(rp).name
	local uNodeName=minetest.env:get_node({x=rp.x,y=rp.y+5,z=rp.z}).name
	local placeOK=true
	--print(string.format("Checking at (%d,%d,%d)",rp.x,rp.y,rp.z))
	if a.fossilSpawnHere[oNodeName] and uNodeName=="air" then
		--print("Misto je OK")
		return rp
	else
	--	print(string.format("Spatna puda %s",oriNode.name))
	end
	return nil
end

function a.placeRuin(pos,name)
	local fn=a.modpath.."/txt/"..name..".txt"
	local fh=io.open(fn,"r")
	local palette=a.palette
	local x=pos.x
	local startx=x
	local y=pos.y
	local z=pos.z
	if fh then
		fh:close()
		for l in io.lines(fn) do
			if l=="==floor" then
				y=y+1
				x=startx
			else
				for i=1,#l do
					local symbol=l:sub(i,i)
					if palette[symbol] then
						minetest.env:add_node({x=x,y=y,z=z+i},{name=palette[symbol]})
						--print(string.format("set(%d,%d,%d,%s)",x,y,z,palette[symbol]))
					end
				end
				x=x+1
			end
		end
	else
		error("File not founc "..fn)
	end
	print(string.format("%s spawned at (%d,%d,%d)",name,pos.x,pos.y,pos.z))
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

minetest.register_on_generated(function(minp,maxp)
	--print(string.format("Generated %d;%d;%d - %d;%d;%d",minp.x,minp.y,minp.z, maxp.x,maxp.y,maxp.z))
	if not (minp.y<-10 or maxp.y<-10 ) then
		a.placeFossil(minp,maxp)
	end
	if not (minp.y<-10 or maxp.y<-10 ) then
		local rp=a.findPosForRuin(minp,maxp)
		if rp then
			a.placeRuin(rp,a.pickOne(a.ruins))
		end
	end
end)