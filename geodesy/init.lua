
geodesy = {}

geodesy.A = {} -- distance from this point
geodesy.G = {} -- angle from this point
geodesy.huds = {} -- huds currently shown



minetest.register_craftitem("geodesy:theodolite", {
    description = "Theodolite (used to measure distances)",
    inventory_image = "geodesy_theodolite.png",
    on_use = function(itemstack, user, pointed_thing)
        local name = user:get_player_name()
		if not name then
		   return
		end
		if pointed_thing.type=="node" then
			local pos=pointed_thing.under
            
            if geodesy.A[name] then
                local A = geodesy.A[name]
                local B = pos
                minetest.chat_send_player(name, "Set point B (".. B.x .. "," .. B.y .. "," .. B.z .. ")")
                
                local dx = math.abs(A.x - B.x)
                local dy = math.abs(A.y - B.y)
                local dz = math.abs(A.z - B.z)

                local distance = math.floor(math.sqrt(dx^2 + dz^2))

                minetest.chat_send_player(name, "Distance is " .. distance .. "m, altitude difference is ".. dy ..  "m.")
                if dx==0 or dz==0 or dx==dz then
                    minetest.chat_send_player(name, "These points are in line.")
                end

                geodesy.A[name] = nil

            else
                local A = pos
                geodesy.A[name] = pos
                minetest.chat_send_player(name, "Set point A (".. A.x .. "," .. A.y .. "," .. A.z .. ")")
            end
        end
    end
})

minetest.register_craftitem("geodesy:goniometer", {
    description = "Goniometer (used to measure angles)",
    inventory_image = "geodesy_goniometer.png",
    on_use = function(itemstack, user, pointed_thing)
        local name = user:get_player_name()
		if not name then
		   return
		end
		if pointed_thing.type=="node" then
			local pos=pointed_thing.under
            if geodesy.G[name] then
                -- stops measuring¨
                if geodesy.huds[name] then
                    user:hud_remove(geodesy.huds[name])
                end
                geodesy.huds[name] = nil
                geodesy.G[name] = nil
            else
                geodesy.G[name] = pos
                minetest.chat_send_player(name, "Measuring angle from point (".. pos.x .. "," .. pos.y .. "," .. pos.z .. ")")

                geodesy.huds[name] = user:hud_add({
                    hud_elem_type = "text",
                    position  = {x = 1, y = 0.8},
                    offset    = {x = -120, y = -25},
                    text      = "Angle is ?°",
                    alignment = 0,
                    scale     = { x = 100, y = 30},
                    number    = 0xFFFFFF,
                })
            end
        end
    end,
})

minetest.register_craft({
    type = "shaped",
    output = "geodesy:goniometer",
    recipe = {
        {"default:stick", "default:stick",    "default:stick"},
        {"", "default:stick",  ""},
        {"", "", "default:stick"}
    }
})

function geodesy.update_hud(player)
    local player_name = player:get_player_name()
    

    if geodesy.huds[player_name] and geodesy.G[player_name] then
        local A = player:get_pos()
        local B = geodesy.G[player_name]
        local look = player:get_look_dir()

        local dx = math.abs(A.x - B.x)
        local dy = math.abs(A.y - B.y)
        local dz = math.abs(A.z - B.z)


        -- local v = geodesy.G
        player:hud_change(geodesy.huds[player_name], "text", "Angle is " .. -math.atan(dx, dz) .. "°")
    end
end

local updatetimer = 0
minetest.register_globalstep(function(dtime)
  updatetimer = updatetimer + dtime
  if updatetimer > 0.1 then
    local players = minetest.get_connected_players()
    for i=1, #players do
      geodesy.update_hud(players[i])
    end
    updatetimer = 0
  end
end)

minetest.register_on_leaveplayer(function(player)
    local name = player:get_player_name()
    geodesy.A[name] = nil
    geodesy.G[name] = nil
    geodesy.huds[name] = nil
end)