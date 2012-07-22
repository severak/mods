asciiart={}
asciiart.palette={
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


minetest.register_on_chat_message(
	function(name,message)
		local cmd = "/ascii"
		if message:sub(0, #cmd) == cmd then
			local player=minetest.env:get_player_by_name(name)
			local ppos=player:getpos()
			local file=message:sub(#cmd+2)..".txt"
			local path=minetest.get_modpath("asciiart")
			local fh=io.open(path.."/txt/"..file,"r")
			local palette=asciiart.palette
			local x=ppos.x
			local startx=x
			local y=ppos.y
			local z=ppos.z
			if fh then
				for l in io.lines(path.."/txt/"..file) do
					if (l=="==floor") then
						y=y+1
						x=startx
					else
						for i=1,#l do
							local symbol=l:sub(i,i)
							local nname=palette[symbol] or "air"
							minetest.env:add_node({x=x,y=y,z=z+i},{name=nname})
						end
						x=x+1
					end
				end
				minetest.chat_send_player(name, "Placing your ASCII art!")
			else
				minetest.chat_send_player(name, "File "..file.." not found!")
			end
			return true
		end
	end
)
                            