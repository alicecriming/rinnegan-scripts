--> paste Initializing

local loader = {
    username = "Rinnegan", 
    build = "Cracked"
}


local required = require
local pui = required 'gamesense/pui' or error('failded to load pui')
local base64 = required 'gamesense/base64' or error('failed to load base64')
local clipboard = required "gamesense/clipboard" or error('failed to load clipboard')
local vector = required 'vector' or error('failed to load vector')
local c_entity = required "gamesense/entity" or error('failed to load c_entity')
local c_weapon = required "gamesense/csgo_weapons" or error('failed to load csgo_weapons')
local msgpack = required 'gamesense/msgpack' or error('failed to load msgpack')
local c_entity = required 'gamesense/entity' or error('failed to load c_entity')
local images = require("gamesense/images")
local steamworks = require("gamesense/steamworks") or error('Missing https://gamesense.pub/forums/viewtopic.php?id=26526')
local _B, ease = pcall(require, "gamesense/easing")
if not _B then lib_error("easing") end



local paste = {}
-- LPH Macro
LPH_NO_VIRTUALIZE = function(...) return ... end
LPH_JIT = function(...) return ... end

local n = 0
local animation_time = 0
paste.funcs = {

    check_build = LPH_NO_VIRTUALIZE(function(build_check)
        local return_check = build == build_check or not obex_fetch
        if return_check == nil then
            return_check = false
        else
            return_check = build == build_check or not obex_fetch
        end

        return return_check
    end),
    misc = {
        get_entities = LPH_NO_VIRTUALIZE(function(enemy_only, alive_only)
            local enemy_only = enemy_only ~= nil and enemy_only or false
            local alive_only = alive_only ~= nil and alive_only or true
            
            local result = {}
        
            local me = entity.get_local_player()
            local player_resource = entity.get_player_resource()
            
            for player = 1, globals.maxplayers() do
                local is_enemy, is_alive = true, true
                
                if enemy_only and not entity.is_enemy(player) then is_enemy = false end
                if is_enemy then
                    if alive_only and entity.get_prop(player_resource, 'm_bAlive', player) ~= 1 then is_alive = false end
                    if is_alive then table.insert(result, player) end
                end
            end
        
            return result
        end),
        set_aa_visibility = LPH_NO_VIRTUALIZE(function(visible)
            for k, v in pairs(paste.refs.aa) do
                ui.set_visible(v, visible)
            end
        end),
		contains = LPH_NO_VIRTUALIZE(function(t, v)
			for i, vv in pairs(t) do
				if vv == v then
					return true
				end
			end
			return false
		end),
        lerp = function(a, b, t)
            return a + (b - a) * t
        end,
        table_lerp = LPH_NO_VIRTUALIZE(function(a, b, percentage)
            local result = {}
            for i=1, #a do
                result[i] = paste.funcs.misc.lerp(a[i], b[i], percentage)
            end
            return result
        end),
        get_key_mode = LPH_JIT(function(ref)
            local key = { ui.get(ref) }
            local mode = key[2]
            
            if mode == nil then
                return "nil"
            end
            
            return paste.visuals.keybinds.bind_mode[mode + 1]
        end),
        kb_get_max_width = LPH_JIT(function()
            local max = 0
        
            for name, bind in pairs(paste.visuals.keybinds.binds) do
                local ref = type(bind.ref) == "table" and bind.ref[2] or bind.ref
                local state = ui.get(ref)
                local mode = paste.funcs.misc.get_key_mode(ref)
                local name_w = paste.funcs.renderer.measure_text("c", name).x
                local mode_w = paste.funcs.renderer.measure_text("c", mode).x
        
                max = math.max(max, name_w + mode_w + paste.visuals.keybinds.padding)
        
            end
        
            if max == 0 then
                max = paste.funcs.renderer.measure_text("c", paste.visuals.keybinds.title).x + paste.visuals.keybinds.padding
            end
        
            return max
        end),
        inverse_lerp = LPH_NO_VIRTUALIZE(function(a, b, weight)
            return (weight - a) / (b - a)
        end),
        split = LPH_NO_VIRTUALIZE(function(string, sep)
            local result = {}
            for str in (string):gmatch("([^"..sep.."]+)") do
                table.insert(result, str)
            end
            return result
        end),
        colour_console = LPH_JIT(function(prefix, string)
            client.color_log(prefix[1], prefix[2], prefix[3], "paste ~ \0")
            client.color_log(255, 255, 232, string)
        end),
        can_hit_enemy = LPH_NO_VIRTUALIZE(function(target, ticks, head_only)
    
            local me = entity.get_local_player()
        
            local max_body_yaw = paste.funcs.aa.get_max_body_yaw(target)
        
            local eye_yaw = normalise_angle(anti_aim.get_abs_yaw())
        
            local x, y, z = entity.get_origin(me)
            z = z + 64
        
            local x, y, z = paste.funcs.aa.extrapolate_position(x, y, z, ticks, me)
        
            local eyex, eyey = entity.get_origin(target)
            _, _, eyez = entity.hitbox_position(target, 0)
        
            local lx, ly, lz = paste.funcs.aa.extend_vector(eyex, eyey, eyez, 8, normalise_angle(eye_yaw - (max_body_yaw/math.pi)))
        
            local rx, ry, rz = paste.funcs.aa.extend_vector(eyex, eyey, eyez, 8, normalise_angle(eye_yaw + (max_body_yaw/math.pi)))
        
            local _, ldamage = client.trace_bullet(me, x, y, z, lx, ly, lz, me)
        
            local _, rdamage = client.trace_bullet(me, x, y, z, rx, ry, rz, me)
        
            local damage = ldamage + rdamage
        
            if not head_only then
        
                local bx, by, bz = entity.hitbox_position(target, 3)
        
                local _, bdamage = client.trace_bullet(me, x, y, z, bx, by, bz, me)
        
                damage = damage + bdamage
        
            end
        
            return damage > 0
        
        end),
        can_enemy_hit_me = LPH_NO_VIRTUALIZE(function(target, ticks, head_only)
    
            local me = entity.get_local_player()
        
            local max_body_yaw = paste.funcs.aa.get_max_body_yaw(me)
        
            local eye_yaw = normalise_angle(anti_aim.get_abs_yaw())
        
            local x, y, z = entity.get_origin(target)
            z = z + 64
        
            local x, y, z = paste.funcs.aa.extrapolate_position(x, y, z, ticks, target)
        
            local eyex, eyey = client.eye_position()
            _, _, eyez = entity.hitbox_position(me, 0)
        
            local lx, ly, lz = paste.funcs.aa.extend_vector(eyex, eyey, eyez, 8, normalise_angle(eye_yaw - (max_body_yaw/math.pi)))
        
            local rx, ry, rz = paste.funcs.aa.extend_vector(eyex, eyey, eyez, 8, normalise_angle(eye_yaw + (max_body_yaw/math.pi)))
        
            local _, ldamage = client.trace_bullet(target, x, y, z, lx, ly, lz, target)
        
            local _, rdamage = client.trace_bullet(target, x, y, z, rx, ry, rz, target)
        
            local damage = ldamage + rdamage
        
            if not head_only then
        
                local bx, by, bz = entity.hitbox_position(me, 3)
        
                local _, bdamage = client.trace_bullet(target, x, y, z, bx, by, bz, target)
        
                damage = damage + bdamage
        
            end
        
            return damage > 0
        
        end),
        approach_angle = LPH_NO_VIRTUALIZE(function(angle, target)

            if angle < target then
                return math.max(angle + 1, target)
            elseif angle > target then
                return math.min(angle + 1, target)
            else
                return target
            end
        
        end),
        hit_flag = LPH_JIT(function(ent)

            if entity.is_dormant(ent) or not entity.is_alive(ent) then
                return end
        
            espData = entity.get_esp_data(ent)
        
            return bit.band(espData.flags, 2048) ~= 0
        end)
    },
    renderer = {
        measure_text = LPH_NO_VIRTUALIZE(function(flags, ...)
            local args = {...}
            local string = table.concat(args, "")
        
            return vector(renderer.measure_text(flags, string))
        end),
        rgba_to_hex = LPH_NO_VIRTUALIZE(function(r, g, b, a)
            return bit.tohex(
              (math.floor(r + 0.5) * 16777216) + 
              (math.floor(g + 0.5) * 65536) + 
              (math.floor(b + 0.5) * 256) + 
              (math.floor(a + 0.5))
            )
        end),
        gradient_text = LPH_JIT(function(r2, g2, b2, a2, text_to_draw, speed, base_r, base_g, base_b, base_a)
            local highlight_fraction =  (globals.realtime() / 2 % 1.2 * speed) - 1.2
            local output = ""
            for idx = 1, #text_to_draw do
                local character = text_to_draw:sub(idx, idx)
                local character_fraction = idx / #text_to_draw
                
                local r, g, b, a = base_r, base_g, base_b, base_a
                local highlight_delta = math.abs(character_fraction - 0.5 - highlight_fraction) * 1
                if highlight_delta <= 1 then
                    local r_fraction, g_fraction, b_fraction, a_fraction = r2 - r, g2 - g, b2 - b, a2 - a
                    r = r + r_fraction * (1 - highlight_delta)
                    g = g + g_fraction * (1 - highlight_delta)
                    b = b + b_fraction * (1 - highlight_delta)
                    a = a + a_fraction * (1 - highlight_delta)
                end
                output = output .. ('\a%02x%02x%02x%02x%s'):format(r, g, b, a, text_to_draw:sub(idx, idx))
            end
            return output
        end),
        two_gradient_text = LPH_NO_VIRTUALIZE(function(text, r, g, b, speed)
            local final_text = ''
            local curtime = globals.curtime()
            local a = 255
            local center = math.floor(#text / 2) + 1  -- calculate the center of the text
            for i=1, #text do
                -- calculate the distance from the center character
                local distance = math.abs(i - center)
                -- calculate the alpha based on the distance and the speed and time
                a = 255 - math.abs(255 * math.sin(speed * curtime / 4 - distance * 4 / 20))
                --local col = r, g, b, a
                local colr = unpack({paste.funcs.renderer.rgba_to_hex(r, g, b, a)})
                final_text = final_text .. '\a' .. colr .. text:sub(i, i)
            end
            return final_text
        end),
        colour_text_menu = LPH_JIT(function(string_to_colour)
            local r, g, b, a = 185, 190, 255, 255
            return "\a" .. unpack({paste.funcs.renderer.rgba_to_hex(r, g, b, a)}) .. string_to_colour .. "\aCDCDCDFF"
        end),
        colour_text = LPH_JIT(function(string_to_colour, accent)
            local r, g, b, a = ui.get(accent)
            return "\a" .. unpack({paste.funcs.renderer.rgba_to_hex(r, g, b, a)}) .. string_to_colour .. "\aCDCDCDFF"
        end),
		rec = LPH_JIT(function(x, y, w, h, r, g, b, a, radius)
			radius = math.min(x/2, y/2, radius)
			renderer.rectangle(x, y + radius, w, h - radius*2, r, g, b, a)
			renderer.rectangle(x + radius, y, w - radius*2, radius, r, g, b, a)
			renderer.rectangle(x + radius, y + h - radius, w - radius*2, radius, r, g, b, a)
			renderer.circle(x + radius, y + radius, r, g, b, a, radius, 180, 0.25)
			renderer.circle(x - radius + w, y + radius, r, g, b, a, radius, 90, 0.25)
			renderer.circle(x - radius + w, y - radius + h, r, g, b, a, radius, 0, 0.25)
			renderer.circle(x + radius, y - radius + h, r, g, b, a, radius, -90, 0.25)
		end),

        rectangle_outline = LPH_NO_VIRTUALIZE(function(x, y, w, h, r, g, b, a, thickness, radius)
            if thickness == nil or thickness < 1 then
              thickness = 1;
            end
        
            if radius == nil or radius < 0 then
              radius = 0;
            end
        
            local limit = math.min(w * 0.5, h * 0.5) * 0.5;
            thickness = math.min(limit / 0.5, thickness);
        
            local offset = 0;
        
            if radius >= thickness then
              radius = math.min(limit + (limit - thickness), radius);
              offset = radius + thickness;
            end
            if radius == 0 then
            renderer.rectangle(x + offset - 1, y, w - offset * 2 + 2, thickness, r, g, b, a);
            renderer.rectangle(x + offset - 1, y + h, w - offset * 2 + 2, -thickness, r, g, b, a);
            else
            renderer.rectangle(x + offset, y, w - offset * 2, thickness, r, g, b, a);
            renderer.rectangle(x + offset, y + h, w - offset * 2, -thickness, r, g, b, a);
            end
        
            local bounds = math.max(offset, thickness);
        
            renderer.rectangle(x, y + bounds, thickness, h - bounds * 2, r, g, b, a);
            renderer.rectangle(x + w, y + bounds, -thickness, h - bounds * 2, r, g, b, a);
        
            if radius == 0 then
              return
            end
        
            renderer.circle_outline(x + offset, y + offset, r, g, b, a, offset, 180, 0.25, thickness); -- ? left-top
            renderer.circle_outline(x + offset, y + h - offset, r, g, b, a, offset, 90, 0.25, thickness); -- ? left-botttom
        
            renderer.circle_outline(x + w - offset, y + offset, r, g, b, a, offset, 270, 0.25, thickness); -- ? right-top
            renderer.circle_outline(x + w - offset, y + h - offset, r, g, b, a, offset, 0, 0.25, thickness); -- ? right-bottom
        end),

		--glow_module = function(x, y, w, h, accent, width, rounding, accent_inner)
		--	local thickness = 1
		--	local offset = 1
		--	local r, g, b, a = accent:unpack()
		--	if accent_inner then
		--		m_render.rec(x , y, w, h, accent_inner, rounding)
		--		--renderer.blur(x , y, w, h)
		--		--m_render.rec_outline(x + width*thickness - width*thickness, y + width*thickness - width*thickness, w - width*thickness*2 + width*thickness*2, h - width*thickness*2 + width*thickness*2, color(r, g, b, 255), rounding, thickness)
		--	end
		--	for k = 0, width do
		--		local accent = color(r, g, b, a * (k/width)^(2.3))
		--		m_render.rec_outline(x + (k - width - offset)*thickness, y + (k - width - offset) * thickness, w - (k - width - offset)*thickness*2, h - (k - width - offset)*thickness*2, accent, rounding + thickness * (width - k + offset), thickness)
		--	end
		--end,
        rounded_rectangle = LPH_NO_VIRTUALIZE(function(x, y, w, h, r, g, b, a, radius)
            y = y + radius
            local datacircle = {
                {x + radius, y, 180},
                {x + w - radius, y, 90},
                {x + radius, y + h - radius * 2, 270},
                {x + w - radius, y + h - radius * 2, 0},
            }
        
            local data = {
                {x + radius, y, w - radius * 2, h - radius * 2},
                {x + radius, y - radius, w - radius * 2, radius},
                {x + radius, y + h - radius * 2, w - radius * 2, radius},
                {x, y, radius, h - radius * 2},
                {x + w - radius, y, radius, h - radius * 2},
            }
        
            for _, data in pairs(datacircle) do
                renderer.circle(data[1], data[2], r, g, b, a, radius, data[3], 0.25)
            end
        
            for _, data in pairs(data) do
               renderer.rectangle(data[1], data[2], data[3], data[4], r, g, b, a)
            end
        end),
        glow_rectangle = LPH_NO_VIRTUALIZE(function(x, y, w, h, r, g, b, a, round, size, g_w)
            for i = 1, size, 0.3 do
                local fixpositon = (i  - 1) * 2	 
                local fixi = i  - 1
                paste.funcs.renderer.rounded_rectangle(x - fixi, y - fixi, w + fixpositon , h + fixpositon , r , g ,b , (a -  i * g_w) ,round)	
            end
        end),
        outline_glow = LPH_NO_VIRTUALIZE(function(x, y, w, h, r, g, b, a, thickness, radius)
	    	if thickness == nil or thickness < 1 then
	    		thickness = 1;
	    	end
        
	    	if radius == nil or radius < 0 then
	    		radius = 0;
	    	end
        
	    	local limit = math.min(w * 0.5, h * 0.5);
        
	    	radius = math.min(limit, radius);
	    	thickness = thickness + radius;
        
	    	local rd = radius * 2;
	    	x, y, w, h = x + radius - 1, y + radius - 1, w - rd + 2, h - rd + 2;
        
	    	local factor = 1;
	    	local step = paste.funcs.misc.inverse_lerp(radius, thickness, radius + 1);
        
	    	for k = radius, thickness do
	    	  local kd = k * 2;
	    	  local rounding = radius == 0 and radius or k;
            
	    	  paste.funcs.renderer.rectangle_outline(x - k, y - k, w + kd, h + kd, r, g, b, a * factor / 3, 1, rounding);
	    	  factor = factor - step;
	    	end
	    end),
        fade_rounded_rect = LPH_NO_VIRTUALIZE(function(x, y, w, h, radius, r, g, b, a, glow)
            local n = a == 0 and 0 or a / 15
            --renderer.rectangle(x + radius, y, w - radius * 2, 1, r, g, b, a)
            renderer.circle_outline(x + radius, y + radius, r, g, b, a, radius, 180, 0.25, 1)
            --renderer.circle_outline(x + w - radius, y + radius, r, g, b, a, radius, 270, 0.25, 1)
            renderer.gradient(x, y + radius, 1, 1+h - radius * 2, r, g, b, a, r, g, b, n, false)
            renderer.gradient(x + w - 1, y + radius - 1, 1, 1+h - radius * 2, r, g, b, n, r, g, b, a, false)
            --renderer.circle_outline(x + radius, y + h - radius, r, g, b, 155, radius, 90, 0.25, 1)
            renderer.circle_outline(x + w - radius, y + h - radius, r, g, b, a, radius, 0, 0.25, 1)
            renderer.rectangle(x + radius, y + h - 1, w - radius * 2, 1, r, g, b, n)
            if a > 45 then
	    	    paste.funcs.renderer.outline_glow(x, y, w, h, r, g, b, glow, 5, radius)
            end
        end),
        fade_rounded_rect_notif = LPH_NO_VIRTUALIZE(function(x, y, w, h, radius, r, g, b, a, glow, w1)
            local n = a / 15
            local w1 = w1 < 3 and 0 or w1
            local circ_fill = w1 > 5 and 0.25 or w1 / 150
            
            -- left
            renderer.circle_outline(x + radius, y + radius, r, g, b, a, radius, 180, circ_fill, 1)
            -- right
            renderer.circle_outline(x + w - radius, y + h - radius, r, g, b, a, radius, 0, circ_fill, 1)
            -- left
            renderer.gradient(x + radius - 2, y, w1, 1, r, g, b, a, r, g, b, n, true)
            -- right
            renderer.gradient(x + w - w1 - radius + 2, y + h - 1, w1, 1, r, g, b, n, r, g, b, a, true)

            -- left
            renderer.gradient(x + radius - 5, y + h / 2 - radius * 2 + 2, 1, w1 / 3.5, r, g, b, a, r, g, b, n, false)
            -- right
            renderer.gradient(x + w - 1, y - w1 / 3.5 - (radius - h ) + 1, 1, w1 / 3.5, r, g, b, n, r, g, b, a, false)

            if a > 45 then
                paste.funcs.renderer.outline_glow(x, y, w, h, r, g, b, glow, 5, radius)
            end

        end),
        fade_rounded_rect_vel = LPH_NO_VIRTUALIZE(function(x, y, w, h, radius, r, g, b, a, glow, w1)
            local n = a / 15
            local w1 = w1 < 3 and 0 or w1
            local circ_fill = w1 > 5 and 0.25 or w1 / 150
            
            -- left
            renderer.circle_outline(x + radius, y + radius, r, g, b, a, radius, 180, circ_fill, 1)
            -- right
            renderer.circle_outline(x + w - radius, y + h - radius, r, g, b, a, radius, 0, circ_fill, 1)

            -- left
            renderer.gradient(x + radius - 2, y, w1, 1, r, g, b, a, r, g, b, n, true)
            -- right
            renderer.gradient(x + w - w1 - radius + 2, y + h - 1, w1, 1, r, g, b, n, r, g, b, a, true)

            -- left
            renderer.gradient(x + radius - 5, y + h / 2 - radius - h / 2 + 10, 1, w1 / 3.5, r, g, b, a, r, g, b, n, false)
            -- right
            renderer.gradient(x + w - 1, y - w1 / 3.5 - (radius - h ) + 1, 1, w1 / 3.5, r, g, b, n, r, g, b, a, false)

            -- glow
            if a > 45 then
                paste.funcs.renderer.outline_glow(x, y, w, h, r, g, b, glow, 5, radius)
            end
        end),

        horizontal_fade_glow = LPH_NO_VIRTUALIZE(function(x, y, w, h, radius, r, g, b, a, glow, r1, g1, b1)
            local n = a / 255 * n
            renderer.rectangle(x, y + radius, 1, h - radius * 2, r, g, b, a)
            renderer.circle_outline(x + radius, y + radius, r, g, b, a, radius, 180, 0.25, 1)
            renderer.circle_outline(x + radius, y + h - radius, r, g, b, a, radius, 90, 0.25, 1)
            renderer.gradient(x + radius, y, w / 3.5 - radius * 2, 1, r, g, b, a, 0, 0, 0, n / 0, true)
            renderer.gradient(x + radius, y + h - 1, w / 3.5 - radius * 2, 1, r, g, b, a, 0, 0, 0, n / 0, true)
            renderer.rectangle(x + radius, y + h - 1, w - radius * 2, 1, r1, g1, b1, n)
            renderer.rectangle(x + radius, y, w - radius * 2, 1, r1, g1, b1, n)
            renderer.circle_outline(x + w - radius, y + radius, r1, g1, b1, n, radius, -90, 0.25, 1)
            renderer.circle_outline(x + w - radius, y + h - radius, r1, g1, b1, n, radius, 0, 0.25, 1)
            renderer.rectangle(x + w - 1, y + radius, 1, h - radius * 2, r1, g1, b1, n)
	    	paste.funcs.renderer.outline_glow(x, y, w, h, r, g, b, glow, 5, radius)
        end)
    },
    ease = {
        in_out_quart = function(x)

            local sqt = x^2
            return sqt / (2 * (sqt - x) + 1);
        
        end
    }
}


local notify = {
    notifications = {
        side = {},
        bottom = {}
    },
    max = {
        side = 11,
        bottom = 5
    }
}

notify.__index = notify

local warning = images.get_panorama_image("icons/ui/warning.svg")

local screen_size = function()
    return vector(client.screen_size())
end

notify.queue_bottom = function()
    if #notify.notifications.bottom <= notify.max.bottom then
        return 0
    end
    return #notify.notifications.bottom - notify.max.bottom
end

notify.queue_side = function()
    if #notify.notifications.side <= notify.max.side then
        return 0
    end
    return #notify.notifications.side - notify.max.side
end

notify.clear_bottom = function()
    for i=1, notify.queue_bottom() do
        table.remove(notify.notifications.bottom, #notify.notifications.bottom)
    end
end

notify.clear_side = function()
    for i=1, notify.queue_side() do
        table.remove(notify.notifications.side, #notify.notifications.side)
    end
end


notify.new_bottom = function(timeout, color, title, ...)
    table.insert(notify.notifications.bottom, {
        started = false,
        instance = setmetatable({
            ["active"]  = false,
            ["timeout"] = timeout,
            ["color"]   = { r = color[1], g = color[2], b = color[3], a = 0 },
            ["x"]       = screen_size().x/2,
            ["y"]       = screen_size().y,
            ["text"]    = {...},
            ["title"]   = title,
            ["type"]    = "bottom"
        }, notify)
    })
end

function notify:handler()

    local side_count = 0
    local side_visible_amount = 0

    for index, notification in pairs(notify.notifications.side) do
        if not notification.instance.active and notification.started then
            table.remove(notify.notifications.side, index)
        end
    end

    for i = 1, #notify.notifications.side do
        if notify.notifications.side[i].instance.active then
            side_visible_amount = side_visible_amount + 1
        end
    end

    for index, notification in pairs(notify.notifications.side) do

        if index > notify.max.side then
            goto skip
        end
        
        if notification.instance.active then
            notification.instance:render_side(side_count, side_visible_amount)
            side_count = side_count + 1
        end

        if not notification.started then
            notification.instance:start()
            notification.started = true
        end

    end

    local bottom_count = 0
    local bottom_visible_amount = 0

    for index, notification in pairs(notify.notifications.bottom) do
        if not notification.instance.active and notification.started then
            table.remove(notify.notifications.bottom, index)
        end
    end

    for i = 1, #notify.notifications.bottom do
        if notify.notifications.bottom[i].instance.active then
            bottom_visible_amount = bottom_visible_amount + 1
        end
    end

    for index, notification in pairs(notify.notifications.bottom) do

        if index > notify.max.bottom then
            goto skip
        end
        
        if notification.instance.active then
            notification.instance:render_bottom(bottom_count, bottom_visible_amount)
            bottom_count = bottom_count + 1
        end

        if not notification.started then
            notification.instance:start()
            notification.started = true
        end

    end

    ::skip::
end

function notify:start()
    self.active = true
    self.delay = globals.realtime() + self.timeout
end

function notify:width()

    local w = 0
    
    local title_width = paste.funcs.renderer.measure_text("b", self.title).x
    local warning_x, warning_y = warning:measure(nil, 15)

    for _, line in pairs(self.text) do
        local line_width = paste.funcs.renderer.measure_text("", line).x
        w = w + line_width + 3
    end

    return math.max(w, title_width + warning_x + 5)
end

function notify:render_text(x, y)
    local x_offset = 0
    local padding = 3

    for i, line in pairs(self.text) do
        if i % 2 ~= 0 then
            r, g, b = 225, 225, 232
        else
           r, g, b = self.color.r, self.color.g, self.color.b

        end
        renderer.text(x + x_offset, y, r, g, b, self.color.a, "", 0, line)
        x_offset = x_offset + paste.funcs.renderer.measure_text("", line).x + padding
    end
end

function notify:render_bottom(index, visible_amount)
    local screen = screen_size()
    local x, y = self.x - 5, self.y - 20
    local padding = 10
    local w, h = self:width() + padding * 2 - 2, 5 + padding* 2
    local colour = {255,255,255}

    if globals.realtime() < self.delay then
        self.y = ease.quad_in_out(0.4, self.y, (( screen.y - 5 ) - ( (visible_amount - index) * h*1.4 )) - self.y, 1)
        self.color.a = ease.quad_in(0.18, self.color.a, 255 - self.color.a, 1)
    else
        self.y = ease.quad_in(0.3, self.y, screen.y - self.y, 1)
        self.color.a = ease.quad_out(0.1, self.color.a, 0 - self.color.a, 1)

        if self.color.a <= 2 then
            self.active = false
        end
    end
    
    local progress = math.max(0, (self.delay - globals.realtime()) / self.timeout)
    local bar_width = (w-10) * progress

    local animate_w1 = progress * (w/2) >= h * 2 and h * 2 or progress * (w/2)

    local animate_glow_s = progress * 100

    paste.funcs.renderer.rounded_rectangle(x - w/2, y, w, h, 19, 19, 19, self.color.a, 5)
    paste.funcs.renderer.rectangle_outline(x - w/2, y, w, h, 32, 32, 32, self.color.a, 2, 3)
    paste.funcs.renderer.fade_rounded_rect_notif(x - w/2 - 1, y, w + 2, h, 5, self.color.r, self.color.g, self.color.b, 255, animate_glow_s * 2, animate_w1)
    self:render_text(x - w/2 + padding, y + h/2 - paste.funcs.renderer.measure_text("", table.concat(self.text, " ")).y/2)
end








local smoothy = (function()
    local function ease(t, b, c, d)
    return c * t / d + b
end

local menu_color_ref = ui.reference("misc", "settings", "menu color")

local function get_menu_color_rgb()
    local r, g, b, a = ui.get(menu_color_ref)
    return r, g, b, a
end

client.exec('clear')


local r, g, b, a = get_menu_color_rgb()

local function multicolor_console(...)
    local texts = {...}
    for i = 1, #texts do
        local text = texts[i]
        client.color_log(text[1], text[2], text[3], i ~= #texts and (text[4] .. '\0') or text[4])
    end
end

local function get_timer()
    -- use your own timer implementation
    return globals.frametime()
end

local function get_type(value)
    local val_type = type(value)

    if val_type == 'boolean' then
        value = value and 1 or 0
    end

    return val_type
end

local function copy_tables(destination, keysTable, valuesTable)
    valuesTable = valuesTable or keysTable
    local mt = getmetatable(keysTable)

    if mt and getmetatable(destination) == nil then
        setmetatable(destination, mt)
    end

    for k,v in pairs(keysTable) do
        if type(v) == 'table' then
            destination[k] = copy_tables({ }, v, valuesTable[k])
        else
            local value = valuesTable[k]

            if type(value) == 'boolean' then
                value = value and 1 or 0
            end

            destination[k] = value
        end
    end

    return destination
end

local function resolve(easing_fn, previous, new, clock, duration)
    if type(new) == 'boolean' then new = new and 1 or 0 end
    if type(previous) == 'boolean' then previous = previous and 1 or 0 end

    local previous = easing_fn(clock, previous, new - previous, duration)

    if type(new) == 'number' then
        if math.abs(new-previous) <= .001 then
            previous = new
        end

        if previous % 1 < .0001 then
            previous = math.floor(previous)
        elseif previous % 1 > .9999 then
            previous = math.ceil(previous)
        end
    end

    return previous
end

local function perform_easing(ntype, easing_fn, previous, new, clock, duration)
    if ntype == 'table' then
        for k, v in pairs(new) do
            previous[k] = previous[k] or v
            previous[k] = perform_easing(
                type(v), easing_fn,
                previous[k], v,
                clock, duration
            )
        end

        return previous
    end

    return resolve(easing_fn, previous, new, clock, duration)
end

local function update(self, duration, value, easing)
    if type(value) == 'boolean' then
        value = value and 1 or 0
    end

    local clock = get_timer()
    local duration = duration or .15
    local value_type = get_type(value)
    local target_type = get_type(self.value)

    assert(value_type == target_type, 'type mismatch')

    if self.value == value then
        return value
    end

    if clock <= 0 or clock >= duration then
        if target_type == 'table' then
            copy_tables(self.value, value)
        else
            self.value = value
        end
    else
        local easing = easing or self.easing

        self.value = perform_easing(
            target_type, easing,
            self.value, value,
            clock, duration
        )
    end

    return self.value
end

local M = {
    __metatable = false,
    __call = update,

    __index = {
        update = update
    }
}

return function(default, easing_fn)
    if type(default) == 'boolean' then
        default = default and 1 or 0
    end

    return setmetatable({
        value = default or 0,
        easing = easing_fn or ease,
    }, M)
end
end)()
local anti_aim_states = {"Standing", "Running", "Slowwalk", "Ducking", "Air Borne", "Air Borne Duck", "Safe", 'Fakelag'}
local teams = {"CT", "T"}
local custom_aa = {}
local helpers = {}
local x,y = client.screen_size()
local player_state = 1

local system = {}
local screen_size_x, screen_size_y = client.screen_size()
local pui = require 'gamesense/pui' or error('failded to load pui')
local vector = require "vector"
system.list = {}
system.windows = {}
system.__index = system

local reference do
        reference = { }

        
        reference.fd = {ui.reference("Rage", "Other", "Duck peek assist")}
        reference.dt = {ui.reference("Rage", "Aimbot", "Double Tap")}
        reference.dt_fl = ui.reference("Rage", "Aimbot", "Double tap fake lag limit")
        reference.hs = {ui.reference("AA", "Other", "On shot anti-aim")}
        reference.color = pui.reference('Misc', 'Settings', 'Menu color')
        reference.dmg1 = ui.reference('RAGE', 'Aimbot', 'Minimum damage')
        reference.dmg = {ui.reference("Rage", "Aimbot", "Minimum damage override")}
        reference.fakeduck = ui.reference("RAGE", "Other", "Duck peek assist")
        reference.lua = ui.reference("AA", "Anti-aimbot angles", "Enabled")
        reference.forcebaim = ui.reference("RAGE", "Aimbot", "Force body aim")
        reference.pitch = {ui.reference("AA", "Anti-aimbot angles", "pitch")}
        reference.roll = ui.reference("AA", "Anti-aimbot angles", "roll")
        reference.yawbase = ui.reference("AA", "Anti-aimbot angles", "Yaw base")
        reference.lm = pui.reference("AA","Other","Leg movement")
        reference.yaw = {ui.reference("AA", "Anti-aimbot angles", "Yaw")}
        reference.fsbodyyaw = ui.reference("AA", "anti-aimbot angles", "Freestanding body yaw")
        reference.edgeyaw = ui.reference("AA", "anti-aimbot angles", "Edge yaw")
        reference.yawjitter = {ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")}
        reference.bodyyaw = {ui.reference("AA", "Anti-aimbot angles", "Body yaw")}
        reference.freestand = {ui.reference("AA", "Anti-aimbot angles", "Freestanding")}
        reference.slow = {ui.reference("AA", "Other", "Slow motion")}
        reference.consolea = pui.reference('Misc', 'Miscellaneous', 'Draw console output')
        reference.fp = {ui.reference("AA", "Other", "Fake peek")}
        reference.enable = {ui.reference("AA", "Fake lag", "Enabled")}
        reference.amount = ui.reference("AA", "Fake lag", "Amount")
        reference.variance = ui.reference("AA", "Fake lag", "Variance")
        reference.limit = ui.reference("AA", "Fake lag", "Limit")

 
end
local vars = {}
        pui.macros.dot = "\v•\r "
        pui.macros.d = "\a808080FF•\r  "
		pui.macros.gray = "\a505050FF"
        pui.macros.lgray = "\a909090FF"
		pui.macros.a = "\v"
        pui.macros.ab = "\v"
        pui.macros.red = "\aFF0000FF"
        pui.macros.dred = "\a700000FF"
        local group_fakelag=pui.group('AA','Fake lag')
local group_aa=pui.group('AA','Anti-aimbot angles')
local group_other=pui.group('AA','Other')
local group_home=pui.group('AA','Anti-Aimbot Angles')

local menu_color_ref = ui.reference("MISC","Settings","Menu color")
local tab_label = ui.new_label("AA","Fake lag","R H O D E S")
-- Convert RGBA to hex string
local function rgba_hex(r, g, b, a)
    return string.format("%02X%02X%02X%02X", r, g, b, a)
end

-- Create a moving gradient based on base color
local function create_gradient_array(r, g, b, length)
    local t = {}
    local curtime = globals.curtime()
    local speed = 2 -- movement speed

    for i = 1, length do
        -- Offset for smooth movement
        local factor = 0.5 + 0.5 * math.sin(curtime * speed + i / length * math.pi * 2)
        t[i] = {
            math.floor(r * factor),
            math.floor(g * factor),
            math.floor(b * factor),
            255
        }
    end

    return t
end

client.set_event_callback("paint_ui", function()
    local r, g, b, _ = ui.get(menu_color_ref)
    local text = "      R H O D E S"
    local icons = " | R E B O R N " 

    local arr = create_gradient_array(r, g, b, #text)
    local colored_str = ""

    for i = 1, #text do
        colored_str = colored_str .. string.format("\a%s%s", rgba_hex(unpack(arr[i])), text:sub(i,i))
    end

    colored_str = colored_str .. icons

    ui.set(tab_label, colored_str)
end)

local group_fakelag = pui.group('AA', 'Fake lag')

local group = pui.group('AA', 'Anti-aimbot angles')
local group_other = pui.group("AA", 'Other')
local group_home = pui.group("AA", 'Anti-Aimbot Angles')

local selection = {}
vars.selection = selection


selection.tab = group_fakelag:combobox(
    '\n', 
    {
        ' Home',          -- first icon colored
        ' Anti-Aimbot',  -- all others gray
        ' Visuals',
        ' Miscellaneous'
    }, 
    false, 
    false
)


selection.aa_tab = group_fakelag:combobox('\n', { ' Angles', ' Features'}, false, false):depend({ selection.tab, ' Anti-Aimbot' })

selection.separator = group_fakelag:label('\n'):depend({ selection.tab, ' Home', ' Anti-Aimbot', ' Visuals', ' Miscellaneous' })
selection.home_label23 = group_fakelag:label(string.format('\f<gray>When paste awakens, silence dies.')):depend({ selection.tab, ' Home' })
selection.home_label2344 = group_fakelag:label(string.format(' ')):depend({ selection.tab, ' Home' })

selection.home_label = group_fakelag:label(string.format('\v \rWelcome back to \vpaste\r, \v%s\r.', loader.username)):depend({ selection.tab, ' Home' })

selection.home_label2 = group_fakelag:label('\v{ } \r Your current build is \v' .. loader.build .. '\r.'):depend({ selection.tab, ' Home' })
local http = require("gamesense/http")
local json = require("json")

local online_users = {}
local username = loader.username or "Unknown"
local last_update_time = 0

selection.network_label = group_fakelag:label('\v \rNetworked Users: \v\r'):depend({ selection.tab, ' Home' })

local function update_label()
    local count, names = 0, {}
    for name in pairs(online_users) do
        count = count + 1
        table.insert(names, name)
    end
    local text = string.format('\v \rActive \vUsers \rConnected: \v%d\r', count)
    if count > 0 then
        text = text .. '\n' .. table.concat(names, ", ")
    end
    selection.network_label:set(text)
end

local function fetch_online_users()
    http.get("http://a1165783.xsph.ru/online_users.php", function(success, response)
        if success and response.status == 200 then
            local ok, data = pcall(json.parse, response.body)
            if ok and type(data.users) == "table" then
                online_users = {}
                for _, name in ipairs(data.users) do
                    online_users[name] = true
                end
                update_label()
            end
        end
    end)
end

local function notify_backend(status)
    http.post("http://a1165783.xsph.ru/online_users.php", {
        headers = { ["Content-Type"] = "application/x-www-form-urlencoded" },
        body = string.format("username=%s&status=%s", username, status)
    }, function(success)
        if success then fetch_online_users() end
    end)
end

client.set_event_callback("paint_ui", function()
    if not _G._has_announced_online then
        notify_backend("online")
        _G._has_announced_online = true
    end
end)

client.set_event_callback("run_command", function()
    if globals.realtime() - last_update_time >= 1 then
        last_update_time = globals.realtime()
        fetch_online_users()
    end
end)

client.set_event_callback("shutdown", function()
    notify_backend("offline")
end)

local configs = {}
vars.configs = configs
configs = configs or {}

local antiaim do
    vars.aa = {}

    vars.aa.encha = group:multiselect('\f<dot> \rAnti-Aimbot \vEnhancements', 'Manual AA', 'Freestand', 'Animations Breaker', 'Edge Yaw Fakeduck', 'Anti-Backstab', 'Fast Ladder Move', 'Static Freestand', 'Static On Warmup', 'Bombsite E Fix', 'Spin if Round End'):depend({ vars.selection.tab, ' Anti-Aimbot' }, { vars.selection.aa_tab, ' Features' })

    vars.aa.ground = group:combobox('\f<dot>On \vGround', { 'Disabled', 'Static', 'Walking', 'Jitter' }):depend({ vars.selection.tab, ' Anti-Aimbot' }, { vars.selection.aa_tab, ' Features' }, { vars.aa.encha, 'Animations Breaker' })
    vars.aa.air = group:combobox('\f<dot>In \vAir', { 'Disabled', 'Static', 'Walking' }):depend({ vars.selection.tab, ' Anti-Aimbot' }, { vars.selection.aa_tab, ' Features' }, { vars.aa.encha, 'Animations Breaker' })

    vars.aa.manual_left = group:hotkey('\f<dot>Manual Left'):depend({ vars.selection.tab, ' Anti-Aimbot' }, { vars.selection.aa_tab, ' Features' }, { vars.aa.encha, 'Manual AA' })
    vars.aa.manual_right = group:hotkey('\f<dot>Manual Right'):depend({ vars.selection.tab, ' Anti-Aimbot' }, { vars.selection.aa_tab, ' Features' }, { vars.aa.encha, 'Manual AA' })
    vars.aa.freestanding = group:hotkey('\f<dot>Freestanding'):depend({ vars.selection.tab, ' Anti-Aimbot' }, { vars.selection.aa_tab, ' Features' }, { vars.aa.encha, 'Freestand' })
end


local spin_yaw = 0
local round_ended = false
local saved_yaw, saved_yaw_offset, saved_fsbodyyaw = nil, nil, nil

-- Detect when the round ends
local function on_round_end(event)
    round_ended = true
end

-- Detect when a new round starts
local function on_round_start(event)
    round_ended = false
end

-- Function to update anti-aim
local function update_antiaim(c)
    local enabled_options = vars.aa.encha:get()
    local spin_enabled = false

    -- Check if "Spin if Round End" is selected
    for i = 1, #enabled_options do
        if enabled_options[i] == 'Spin if Round End' then
            spin_enabled = true
            break
        end
    end

    if not spin_enabled then return end  -- If option isn't enabled, do nothing

    -- Ensure yaw references exist before modifying them
    if not reference.yaw or not reference.yaw[1] or not reference.yaw[2] then
        return  -- Exit if references are missing
    end

    if round_ended then
        -- **Save normal anti-aim settings ONCE before switching to spin**
        if saved_yaw == nil then
            saved_yaw = ui.get(reference.yaw[1])
            saved_yaw_offset = ui.get(reference.yaw[2])
            if reference.fsbodyyaw then
                saved_fsbodyyaw = ui.get(reference.fsbodyyaw)
            end
        end

        -- **Spin smoothly within valid yaw limits (-180 to 180)**
        spin_yaw = (spin_yaw + 6) % 360  -- Increase speed for full spin

        -- Wrap spin_yaw to always be within -180 to 180
        if spin_yaw > 180 then
            spin_yaw = spin_yaw - 360
        end

        -- Apply spin settings
        ui.set(reference.yaw[1], "180")  -- Set yaw base to a valid value
        ui.set(reference.yaw[2], spin_yaw)  -- Apply wrapped yaw for smooth spinning

        if reference.fsbodyyaw then
            ui.set(reference.fsbodyyaw, false)
        end

        c.yaw = spin_yaw
    else
        -- **Round Active → Restore user's normal anti-aim settings SAFELY**
        if saved_yaw then
            ui.set(reference.yaw[1], saved_yaw)
            ui.set(reference.yaw[2], saved_yaw_offset)
            if reference.fsbodyyaw then
                ui.set(reference.fsbodyyaw, saved_fsbodyyaw)
            end
        end

        -- Clear saved settings so they are refreshed next round
        saved_yaw, saved_yaw_offset, saved_fsbodyyaw = nil, nil, nil
    end
end

-- Listen for game events
client.set_event_callback("round_end", on_round_end)
client.set_event_callback("round_start", on_round_start)
client.set_event_callback("setup_command", update_antiaim)

local yaws = {
    " Default",
    " Custom"
}

local angles, custom_angles do
    vars.angles = {}



-- Angles type combobox
vars.angles.type = group:combobox(
    "\n", -- minimal label spacing
    { ' Constructor', ' Preset', ' Anti-Bruteforce'}
):depend(
    { vars.selection.tab, ' Anti-Aimbot' },
    { vars.selection.aa_tab, ' Angles' }
)
vars.cheat_detect = group_fakelag:label("\v⛽ \rCheat \vBased")
vars.cheat_detect:depend({ vars.selection.tab, " Anti-Aimbot" })
vars.cheat_detect:depend({ vars.selection.aa_tab, " Angles" })
vars.cheat_detect:depend({ vars.angles.type, " Constructor" })

-- Combobox only shows when cheat_detect is enabled
vars.cheat_type = group_fakelag:combobox("\n", { "GS", "NL" })
vars.cheat_type:depend({ vars.selection.tab, " Anti-Aimbot" })
vars.cheat_type:depend({ vars.selection.aa_tab, " Angles" })
vars.cheat_type:depend({ vars.angles.type, " Constructor" })




    vars.angles.team = group_fakelag:combobox('\n', { 'CT', 'T' }):depend(
        { vars.selection.tab, ' Anti-Aimbot' },
        { vars.selection.aa_tab, ' Angles' },
        { vars.angles.type, ' Constructor' }
    )
    vars.angles.team_identity = group_fakelag:combobox('\v \rTeam \vIdentity', { ' Counter-Terrorists', ' Terrorists' }):depend(
    { vars.selection.aa_tab, ' Angles' },
    { vars.angles.type, ' Anti-Bruteforce' }
)

vars.angles.antibrute_enabled = group:checkbox('\f<dot> Activate \vAnti-Bruteforce'):depend(
    { vars.selection.aa_tab, ' Angles' },
    { vars.angles.type, ' Anti-Bruteforce' }
)

vars.angles.movement_states = group:listbox('\f<dot> Apply During Movement States', {
    'Standing',
    'Moving',
    'Slow Walking',
    'Crouching',
    'Crouch Walking',
    'In Air',
    'In Air (Duck)'
}, { multi = true }):depend(
    { vars.selection.aa_tab, ' Angles' },
    { vars.angles.type, ' Anti-Bruteforce' },
    { vars.angles.antibrute_enabled, true }
)



vars.angles.sensitivity_threshold = group_fakelag:slider(
    string.format('\f<dot> Sensitivity Threshold \v(%%)'), -180, 180, 0
):depend(
    { vars.selection.aa_tab, ' Angles' },
    { vars.angles.type, ' Anti-Bruteforce' },
    { vars.angles.antibrute_enabled, true }
)

vars.angles.reaction_delay = group_fakelag:slider(
    string.format('\f<dot> Reaction Delay \v(ms)'), 0, 5, 1
):depend(
    { vars.selection.aa_tab, ' Angles' },
    { vars.angles.type, ' Anti-Bruteforce' },
    { vars.angles.antibrute_enabled, true }
)

vars.angles.yaw_spin_speed = group_fakelag:slider(
    string.format('\f<dot> Yaw Spin Speed \v(°/s)'), -180, 180, 0
):depend(
    { vars.selection.aa_tab, ' Angles' },
    { vars.angles.type, ' Anti-Bruteforce' },
    { vars.angles.antibrute_enabled, true }
)

vars.angles.pitch_adjustment = group_fakelag:slider(
    string.format('\f<dot> Pitch Adjustment \v(°)'), -90, 90, 1
):depend(
    { vars.selection.aa_tab, ' Angles' },
    { vars.angles.type, ' Anti-Bruteforce' },
    { vars.angles.antibrute_enabled, true }
)

vars.angles.jitter_amplitude = group_fakelag:slider(
    string.format('\f<dot> Jitter Amplitude \v(°)'), 0, 30, 1
):depend(
    { vars.selection.aa_tab, ' Angles' },
    { vars.angles.type, ' Anti-Bruteforce' },
    { vars.angles.antibrute_enabled, true }
)

vars.angles.smoothing = group_fakelag:slider(
    string.format('\f<dot> Fake Flick \v(%%)'), 0, 10, 1
):depend(
    { vars.selection.aa_tab, ' Angles' },
    { vars.angles.type, ' Anti-Bruteforce' },
    { vars.angles.antibrute_enabled, true }
)

vars.angles.step_delay = group_fakelag:slider(
    string.format('\f<dot> Delay \v(ms)'), 0, 10, 20
):depend(
    { vars.selection.aa_tab, ' Angles' },
    { vars.angles.type, ' Anti-Bruteforce' },
    { vars.angles.antibrute_enabled, true }
)

vars.angles.max_angle_offset = group_fakelag:slider(
    string.format('\f<dot> Angle Offset \v(°)'), -180, 180, 0
):depend(
    { vars.selection.aa_tab, ' Angles' },
    { vars.angles.type, ' Anti-Bruteforce' },
    { vars.angles.antibrute_enabled, true }
)

    

    vars.angles.condition = group:combobox('\f<dot>\vPlayer \rVitality', anti_aim_states):depend(
        { vars.selection.tab, ' Anti-Aimbot' },
        { vars.selection.aa_tab, ' Angles' },
        { vars.angles.type, ' Constructor' }
    )

    -- -- vars.angles.yaw_ref = group:combobox('\f<dot>\vYaw \rReference \vBrute', yaws):depend(
    -- --     { vars.selection.tab, ' Anti-Aimbot' },
    -- --     { vars.selection.aa_tab, ' Angles' }
    -- -- )

    vars.angles.preset_list = group:listbox("\f<dot>\vPreset \rScheme", { " Hazey's Preset" }):depend(
        { vars.selection.tab, ' Anti-Aimbot' },
        { vars.selection.aa_tab, ' Angles' },
        { vars.angles.type, ' Preset' }
    )

    vars.angles.preset_label = group:label("\f<dot>You are using the \vdeveloper \rpreset."):depend(
        { vars.selection.tab, ' Anti-Aimbot' },
        { vars.selection.aa_tab, ' Angles' },
        { vars.angles.type, ' Preset' }
    )

    -- -- Separate class for Custom settings
    vars.custom_angles = {}

    for _, state in ipairs(anti_aim_states) do
        vars.custom_angles[state] = group:slider("\f<dot>\v" .. state .. " \rOffset", -180, 180, 0):depend(
            { vars.selection.tab, ' Anti-Aimbot' },
            { vars.selection.aa_tab, ' Angles' },
            { vars.angles.type, ' Custom' }
        )
    end
end

client.set_event_callback("paint", function()
    if vars.angles.preset_list then
        local selected_index = vars.angles.preset_list:get() + 1
        local preset_names = { " Hazey's x Rxdkys" }
        local preset_name = preset_names[selected_index] or " Hazey's x Rxdkys"
        
        vars.angles.preset_label:set("\f<dot> You are using the \vdeveloper's \rpreset.")
    end
end)



local conditions do

    function export_state(state, team, toteam)
        local config = pui.setup({custom_aa[team][state]})
    
        local data = config:save()
        local encrypted = base64.encode( json.stringify(data) )
    
        import_state(encrypted, state, toteam)
    end
    
    function import_state(encrypted, state,team)
        local data = json.parse(base64.decode(encrypted))
    
        local config = pui.setup({custom_aa[team][state]})
        config:load(data)
    end

    for i, team in next, teams do
        custom_aa[team] = {}
        for k, state in next, anti_aim_states do
            custom_aa[team][state] = {}

                    custom_aa[team][state].enabled = group:checkbox(string.format('\v \rActivate \v%s', state, team))
                    :depend({ vars.selection.tab, ' Anti-Aimbot' },{vars.angles.team, teams[i]}, { vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] })

                    custom_aa[team][state].pitch = group:combobox(string.format('\f<dot>\v%s  \v»  \ac8c8c8ffTilt', state), { 'Off', 'Default', 'Up', 'Down', 'Minimal', 'Random', 'Custom' })
                    :depend({ vars.selection.tab, ' Anti-Aimbot' },{vars.angles.team, teams[i]}, { vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] }, custom_aa[team][state].enabled)
    
                    custom_aa[team][state].pitch_value = group:slider(string.format('\f<dot>Pitch Parameter %s ', state), -89, 89, 0, true, '°')
                    :depend({ vars.selection.tab, ' Anti-Aimbot' },{vars.angles.team, teams[i]}, { vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] }, { custom_aa[team][state].pitch, 'Custom' }, custom_aa[team][state].enabled)

                    custom_aa[team][state].yaw_base = group:combobox(string.format('\f<dot>\v%s  \v»  \ac8c8c8ffYaw Reference', state), { 'Local view', 'At targets' })
                    :depend({ vars.selection.tab, ' Anti-Aimbot' },{vars.angles.team, teams[i]}, { vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] }, custom_aa[team][state].enabled)

                    custom_aa[team][state].yaw = group:combobox(string.format('\f<dot> \v%s  \v»  \ac8c8c8ffYaw', state), { 'Off', '180', 'Spin', 'Static', '180 Z', 'Crosshair', 'Slow Ticks' })
                    :depend({ vars.selection.tab, ' Anti-Aimbot' },{vars.angles.team, teams[i]}, { vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] }, custom_aa[team][state].enabled)
    
                    custom_aa[team][state].yaw_offset = group:slider(string.format('\f<dot> \v%s   \v»  \ac8c8c8ffYaw Offset', state), -180, 180, 0, true, '°')
                    :depend({ vars.selection.tab, ' Anti-Aimbot' },{vars.angles.team, teams[i]}, { vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] }, { custom_aa[team][state].yaw, '180', 'Spin', 'Static', '180 Z', 'Crosshair' }, custom_aa[team][state].enabled)
    
                    custom_aa[team][state].delayed_swap = group:checkbox(string.format('\v%s  \v» \rDelay', state))
                    :depend({ vars.selection.tab, ' Anti-Aimbot' },{vars.angles.team, teams[i]}, { vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] }, { custom_aa[team][state].yaw, 'Slow Ticks' }, custom_aa[team][state].enabled)

                    custom_aa[team][state].ticks_delay = group:slider(string.format('\f<dot> \v%s  \v» \ac8c8c8ffSlow Ticks ', state), 0, 14, 0, true, 't', 1)
                    :depend({ vars.selection.tab, ' Anti-Aimbot' },{vars.angles.team, teams[i]}, custom_aa[team][state].delayed_swap, { vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] }, { custom_aa[team][state].yaw, 'Slow Ticks' }, custom_aa[team][state].enabled)

                    custom_aa[team][state].yaw_left = group:slider(string.format('\f<dot> \v%s   \v» \ac8c8c8ffLeft Offset ', state), -180, 180, 0, true, '°')
                    :depend({ vars.selection.tab, ' Anti-Aimbot' },{vars.angles.team, teams[i]}, { vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] }, { custom_aa[team][state].yaw, 'Slow Ticks' }, custom_aa[team][state].enabled)
    
                    custom_aa[team][state].yaw_right = group:slider(string.format('\f<dot> \v%s   \v» \ac8c8c8ffRight Offset', state), -180, 180, 0, true, '°')
                    :depend({ vars.selection.tab, ' Anti-Aimbot' },{vars.angles.team, teams[i]}, { vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] }, { custom_aa[team][state].yaw, 'Slow Ticks' }, custom_aa[team][state].enabled)

                    custom_aa[team][state].body_yaw = group:combobox(string.format('\f<dot> \v%s  \v» \ac8c8c8ffBody Yaw', state), { 'Off', 'Static', 'Jitter', 'Opposite'})
                    :depend({ vars.selection.tab, ' Anti-Aimbot' },{vars.angles.team, teams[i]}, { vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] }, custom_aa[team][state].enabled)                
    
                    custom_aa[team][state].body_yaw_offset = group:slider(string.format('\f<dot> \v» \ac8c8c8ffBody Yaw Offset', state), -180, 180, 0, true, '°')
                    :depend({ vars.selection.tab, ' Anti-Aimbot' },{vars.angles.team, teams[i]}, { vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] }, { custom_aa[team][state].body_yaw, 'Jitter', 'Static', 'Opposite'}, custom_aa[team][state].enabled)

                    custom_aa[team][state].yaw_modifier = group:combobox(string.format('\f<dot> \v» \ac8c8c8ffYaw \vJitter', state), { 'Off', 'Offset', 'Center', 'Random', 'Skitter' })
                    :depend({ vars.selection.tab, ' Anti-Aimbot' }, {vars.angles.team, teams[i]},{ vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] }, { custom_aa[team][state].yaw, 'Off', true }, custom_aa[team][state].enabled)
    
                    custom_aa[team][state].yaw_modifier_offset = group:slider(string.format('\f<dot> \v» \ac8c8c8ffJitter \vOffset', state), -180, 180, 0, true, '°')
                    :depend({ vars.selection.tab, ' Anti-Aimbot' }, {vars.angles.team, teams[i]},{ vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] }, { custom_aa[team][state].yaw, 'Off', true }, { custom_aa[team][state].yaw_modifier, 'Off', true }, custom_aa[team][state].enabled)
    
                    custom_aa[team][state].defensive = group_fakelag:checkbox(string.format('\f<gray>{RH} \rForce \vDefensive', state))
                    :depend({ vars.selection.tab, ' Anti-Aimbot' },{vars.angles.team, teams[i]}, { vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] }, custom_aa[team][state].enabled)

                    -- On peek always on
                    custom_aa[team][state].defensive_force_mode = group_fakelag:combobox(string.format('\n', state), {'Always On', 'On Peek'})
                    :depend({ vars.selection.tab, ' Anti-Aimbot' }, { vars.angles.team, teams[i] }, { vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] }, custom_aa[team][state].enabled, custom_aa[team][state].defensive)

                    custom_aa[team][state].defensive_mode = group_fakelag:multiselect(string.format('\f<gray>{RH} \rDefensive \vMode', state), {'Double Tap', 'Hide Shots'})
                    :depend({ vars.selection.tab, ' Anti-Aimbot' },{vars.angles.team, teams[i]}, { vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] }, custom_aa[team][state].enabled,custom_aa[team][state].defensive)
                        
                    custom_aa[team][state].defensive_pitch = group_fakelag:combobox(string.format('\f<gray>{RH} \rDefensive \vPitch', state), {'Off', 'Default', 'Up', 'Up-Switch', 'Cycling', 'Random', 'Custom'})
                    :depend({ vars.selection.tab, ' Anti-Aimbot' },{vars.angles.team, teams[i]}, { vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] }, custom_aa[team][state].enabled,custom_aa[team][state].defensive)

                    -- Slow Ticks Integration (Visible only when 'Cycling' pitch and 'Force Defensive' are enabled)
                    custom_aa[team][state].cycling_slow_ticks = group_fakelag:slider(string.format('\f<gray>{RH} \rTicks', state), 1, 5, 16, true, 't', 1):depend({vars.selection.tab, ' Anti-Aimbot'},
                        {vars.angles.team, teams[i]},
                        {vars.selection.aa_tab, ' Angles'},
                        {vars.angles.type, ' Constructor'},
                        {vars.angles.condition, anti_aim_states[k]},
                        custom_aa[team][state].enabled,
                        custom_aa[team][state].defensive,  -- << Force Defensive must be enabled
                        {custom_aa[team][state].defensive_pitch, 'Cycling'}  -- Cycling must be selected
                    )

                    -- Cycling Pitch Offset (Visible only when 'Cycling' pitch and 'Force Defensive' are enabled)
                    custom_aa[team][state].cycling_pitch_offset = group_fakelag:slider(string.format('\f<gray>{RH} \v» \rCycling \vOffset', state), -89, 89, 0, true, '°', 1):depend(
                        {vars.selection.tab, ' Anti-Aimbot'},
                        {vars.angles.team, teams[i]},
                        {vars.selection.aa_tab, ' Angles'},
                        {vars.angles.type, ' Constructor'},
                        {vars.angles.condition, anti_aim_states[k]},
                        custom_aa[team][state].enabled,
                        custom_aa[team][state].defensive,  -- << Force Defensive must be enabled
                        {custom_aa[team][state].defensive_pitch, 'Cycling'}  -- Cycling must be selected
                    )

                    -- Cycling Pitch Offset 2 (Visible only when 'Cycling' pitch and 'Force Defensive' are enabled)
                    custom_aa[team][state].cycling_pitch_offset_2 = group_fakelag:slider(string.format('\f<gray>{RH} \v» \rCycling \vOffset 2', state), -89, 89, 0, true, '°', 1):depend(
                        {vars.selection.tab, ' Anti-Aimbot'},
                        {vars.angles.team, teams[i]},
                        {vars.selection.aa_tab, ' Angles'},
                        {vars.angles.type, ' Constructor'},
                        {vars.angles.condition, anti_aim_states[k]},
                        custom_aa[team][state].enabled,
                        custom_aa[team][state].defensive,  -- << Force Defensive must be enabled
                        {custom_aa[team][state].defensive_pitch, 'Cycling'}  -- Cycling must be selected
                    )

                    custom_aa[team][state].pitch_amount = group_fakelag:slider(string.format('\f<dot> \v» \rOffset', state), -89, 89, 0, true, '°', 1)
                    :depend({ vars.selection.tab, ' Anti-Aimbot' },{vars.angles.team, teams[i]}, { vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] }, custom_aa[team][state].enabled , {custom_aa[team][state].defensive_pitch, 'Custom', 'Random'},custom_aa[team][state].defensive)

                    custom_aa[team][state].pitch_amount_2 = group_fakelag:slider(string.format('\f<dot> »\ac8c8c8ffOffset 2', state), -89, 89, 0, true, '°', 1)
                    :depend({ vars.selection.tab, ' Anti-Aimbot' },{vars.angles.team, teams[i]}, { vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] }, custom_aa[team][state].enabled, {custom_aa[team][state].defensive_pitch, 'Random'},custom_aa[team][state].defensive)

                    custom_aa[team][state].defensive_yaw = group_fakelag:combobox(string.format('\f<gray>{RH} \rDefensive \vYaw', state), {'Off', '180', 'Random', '\abf3939FFFlicks', 'Meta', 'Spin'})
                    :depend({ vars.selection.tab, ' Anti-Aimbot' },{vars.angles.team, teams[i]}, { vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] }, custom_aa[team][state].enabled,custom_aa[team][state].defensive)

                    custom_aa[team][state].yaw_amount = group_fakelag:slider(string.format('\f<gray>{RH} \rDefensive \vYaw \rOffset', state), -180, 180, 0, true, '°', 1)
                    :depend({ vars.selection.tab, ' Anti-Aimbot' },{vars.angles.team, teams[i]}, { vars.selection.aa_tab, ' Angles' }, { vars.angles.type, ' Constructor' }, { vars.angles.condition, anti_aim_states[k] }, custom_aa[team][state].enabled, {custom_aa[team][state].defensive_yaw, 'Spin'},custom_aa[team][state].defensive)

                    -- META YAW
                    custom_aa[team][state].meta_yaw_ticks = group_fakelag:slider(
                        string.format('\f<dot> Yaw \vTicks', state),
                        1, 10, 5, true, 't', 1  -- Min = 1 (fastest), Max = 10 (slowest), Default = 5
                    ):depend(
                        {vars.selection.tab, ' Anti-Aimbot'},
                        {vars.angles.team, teams[i]},
                        {vars.selection.aa_tab, ' Angles'},
                        {vars.angles.type, ' Constructor'},
                        {vars.angles.condition, anti_aim_states[k]},
                        custom_aa[team][state].enabled,
                        custom_aa[team][state].defensive,
                        {custom_aa[team][state].defensive_yaw, 'Meta'}
                    )                    
                    
                    custom_aa[team][state].meta_yaw_degrees = group_fakelag:slider(
                        string.format('\f<dot> Yaw \vDegrees', state),
                        1, 180, 1, true, '°', 1  -- Min = 1, Max = 180, Default = 1 (slowest spin)
                    ):depend(
                        {vars.selection.tab, ' Anti-Aimbot'},
                        {vars.angles.team, teams[i]},
                        {vars.selection.aa_tab, ' Angles'},
                        {vars.angles.type, ' Constructor'},
                        {vars.angles.condition, anti_aim_states[k]},
                        custom_aa[team][state].enabled,
                        custom_aa[team][state].defensive,
                        {custom_aa[team][state].defensive_yaw, 'Meta'}
                    )  
                    
                    -- FLICK YAW
                    custom_aa[team][state].flicks_amount = group_fakelag:slider(
                        string.format('\f<gray>{RH} \v» \aF14646FFFlick \rAmount', state),
                        1, 5, 2, true, 'f', 1  -- Min = 1, Max = 10, Default = 5
                    ):depend(
                        { vars.selection.tab, ' Anti-Aimbot' },
                        { vars.angles.team, teams[i] },
                        { vars.selection.aa_tab, ' Angles' },
                        { vars.angles.type, ' Constructor' },
                        { vars.angles.condition, anti_aim_states[k] },
                        custom_aa[team][state].enabled,
                        custom_aa[team][state].defensive,
                        { custom_aa[team][state].defensive_yaw, '\abf3939FFFlicks' }
                    )
local helper_map = {["Helpers"]="",["Additional Exploits"]=""}
local helper_names = {"Helpers","Additional Exploits"}

local function render_helper_icons(active)
    local out = {}
    for i,name in ipairs(helper_names) do
        local icon = helper_map[name]
        out[#out+1] = (name==active and "\f<a>\v"..icon or "\f<gray>"..icon)
        if i<#helper_names then out[#out+1] = "\f<gray>  •  " end
    end
    return table.concat(out)
end

local helper_label = group_other:label("\n"):depend(
    {vars.selection.tab," Anti-Aimbot"},
    {vars.selection.aa_tab," Angles"},
    {vars.angles.type," Constructor"},
    {vars.angles.team,teams[i]},
    {vars.angles.condition,anti_aim_states[k]},
    custom_aa[team][state].enabled
)

local helper_combo = group_other:combobox("\n",helper_names,false):depend(
    {vars.selection.tab," Anti-Aimbot"},
    {vars.selection.aa_tab," Angles"},
    {vars.angles.type," Constructor"},
    {vars.angles.team,teams[i]},
    {vars.angles.condition,anti_aim_states[k]},
    custom_aa[team][state].enabled
)

helper_label:set(render_helper_icons(helper_combo.value))
helper_combo:set_callback(function(self) helper_label:set(render_helper_icons(self.value)) end)

local test_team = team=="CT" and "T" or "CT"
custom_aa[team][state].export_opposite_team = group_other:button(
    "\v\r Transfer To [\v"..test_team.." - "..state.."\ac8c8c8ff]",
    function()
        export_state(state,team,test_team)
        logger.invent(string.format("Transfered ['values'] to %s",test_team),{196,172,188})
    end
):depend(
    {vars.selection.tab," Anti-Aimbot"},
    {vars.selection.aa_tab," Angles"},
    {vars.angles.type," Constructor"},
    {vars.angles.team,teams[i]},
    {vars.angles.condition,anti_aim_states[k]},
    custom_aa[team][state].enabled,
    {helper_combo,"Helpers"}
)
local steal_active = false
local steal_progress = 0
local steal_target = 0
local progress_increment = 0.05 -- slower, 0.5% per frame for smooth gradual steal

local function start_steal(selected)
    if #selected == 0 then
        aa_stealer_status:set("\v Select \rPlayer \vVitality \rto \vsteal!")
        return
    end

    steal_target = 100
    steal_progress = 0
    steal_active = true

    -- simulate backend copying instantly
    for _, state_name in ipairs(selected) do
        export_state(state_name, team, team)
    end
end
local aa_stealer_multiselect = group_other:multiselect(
    "\vSelect \rPlayer \vVitality \rto \vsteal!", 
    anti_aim_states -- your list of AA states
):depend(
    {vars.selection.tab," Anti-Aimbot"},
    {vars.selection.aa_tab," Angles"},
    {vars.angles.type," Constructor"},
    {vars.angles.team,teams[i]},
    {vars.angles.condition,anti_aim_states[k]},
    custom_aa[team][state].enabled
)
local aa_stealer_button = group_other:button(
    "\v⛶ \rSteal \vAnti-Aim",
    function()
        local selected = aa_stealer_multiselect:get() -- now this exists
        start_steal(selected)
    end
):depend(
    {vars.selection.tab," Anti-Aimbot"},
    {vars.selection.aa_tab," Angles"},
    {vars.angles.type," Constructor"},
    {vars.angles.team,teams[i]},
    {vars.angles.condition,anti_aim_states[k]},
    custom_aa[team][state].enabled,
    {helper_combo,"Additional Exploits"}
)


client.set_event_callback("paint", function()
    if steal_active then
        if steal_progress < steal_target then
            steal_progress = math.min(steal_progress + progress_increment, steal_target)
            aa_stealer_status:set(string.format("                stealing... - %d%%\r", math.floor(steal_progress)))
        else
            aa_stealer_status:set("         stole successful... -  100%\r")
            steal_active = false
        end
    end
end)



end
end
end

local function is_player_alive()
    local local_player = entity.get_local_player()
    return local_player and entity.is_alive(local_player)  
end

local function draw_rounded_rect(x, y, w, h, radius, r, g, b, a)
    -- Background box with rounded edges
    renderer.rectangle(x + radius, y, w - radius * 2, h, r, g, b, a)  -- Main box
    renderer.rectangle(x, y + radius, w, h - radius * 2, r, g, b, a)  -- Side extensions
    
    -- Rounded corners
    renderer.circle(x + radius, y + radius, r, g, b, a, radius, 0, 1)
    renderer.circle(x + w - radius, y + radius, r, g, b, a, radius, 0, 1)
    renderer.circle(x + radius, y + h - radius, r, g, b, a, radius, 0, 1)
    renderer.circle(x + w - radius, y + h - radius, r, g, b, a, radius, 0, 1)
end
-- Helper functions
local function clamp(x, minval, maxval) return math.max(minval, math.min(maxval, x)) end
local function rgba_to_hex(r, g, b, a) return string.format('%02x%02x%02x%02x', r, g, b, a) end
local function lerp(a, b, t) return a + (b - a) * t end

local function draw_shadow_text(x, y, r, g, b, a, flag, text)
    for dx=-1,1,2 do
        for dy=-1,1,2 do
            renderer.text(x+dx, y+dy, 0,0,0,a,flag,0,text)
        end
    end
end

local function text_fade_animation(x, y, speed, color1, color2, text, flag)
    local final_text = ''
    local curtime = globals.curtime()
    for i = 1, #text do
        local wave = math.cos(8 * speed * curtime + (i * 10) / 30)
        local color = rgba_to_hex(
            lerp(color1.r, color2.r, clamp(wave,0,1)),
            lerp(color1.g, color2.g, clamp(wave,0,1)),
            lerp(color1.b, color2.b, clamp(wave,0,1)),
            color1.a
        )
        final_text = final_text .. '\a' .. color .. text:sub(i,i)
    end
    renderer.text(x, y, color1.r, color1.g, color1.b, color1.a, flag, nil, final_text)
end

-- Get the Menu Color from the GameSense UI
local menu_color_ref = ui.reference("misc", "settings", "menu color")
local function get_menu_color_rgb()
    local r, g, b, a = ui.get(menu_color_ref)
    -- fallback to white if nil
    return r or 255, g or 255, b or 255, a or 255
end

-- Main watermark function
local function draw_paste_watermark()
    if not is_player_alive() then return end
    if not vars.visuals.watermark:get() or vars.visuals.watermark_mode:get() ~= "Default" then return end

    local r, g, b, a = get_menu_color_rgb()
    local primary_color = {r=r, g=g, b=b, a=a}
    local moving_color = {r=15, g=15, b=15, a=255} -- static dark shadow/fade
    local speed = 1

    local username = loader.username or "Unknown"
    local side_main = "paste Scorpion / " .. username
    local side_sub = " "

    local sw, sh = client.screen_size()
    local offset_x = 80 -- moves watermark slightly left

    draw_shadow_text(sw-offset_x, sh/2-10, 0,0,0,255,"cb",side_main)
    text_fade_animation(sw-offset_x, sh/2-10, speed, primary_color, moving_color, side_main, "cb")
    draw_shadow_text(sw-offset_x, sh/2-5, 0,0,0,255,"cb",side_sub)
    text_fade_animation(sw-offset_x, sh/2-5, speed, primary_color, moving_color, side_sub, "cb")
end

client.set_event_callback("paint", draw_paste_watermark)







        -- Detection Focus, Accuracy Rate

        local stats = {
            total_shots = 0,
            hits = 0
        }

        -- Function to get the best enemy target
        local best_enemy = nil
        function get_best_enemy()
            local enemies = entity.get_players(true)  -- Get all enemy players
            local best_distance = math.huge
            local lp = entity.get_local_player()
            if not lp then return end

            for _, enemy in ipairs(enemies) do
                local ex, ey, ez = entity.get_prop(enemy, "m_vecOrigin")
                local lx, ly, lz = entity.get_prop(lp, "m_vecOrigin")
                if ex and lx then
                    local dist = (lx - ex)^2 + (ly - ey)^2 + (lz - ez)^2
                    if dist < best_distance then
                        best_distance = dist
                        best_enemy = enemy
                    end
                end
            end
        end

        client.set_event_callback("paint", function()
            local lp = entity.get_local_player()
            local selected_options = vars.visuals.selectionind:get() or {}

            -- Ensure selected_options is always a table
            if type(selected_options) ~= "table" then
                selected_options = {selected_options}
            end

            if not lp or entity.get_prop(lp, "m_lifeState") ~= 0 then return end
            
            if table.contains(selected_options, "Accuracy Rate") then
                renderer.indicator(255, 255, 255, 255, string.format("%s/%s (%s%%)", stats.hits, stats.total_shots, string.format("%.1f", stats.total_shots ~= 0 and (stats.hits / stats.total_shots * 100) or 0)))
            end
            
            if table.contains(selected_options, "Detection Focus") then
                get_best_enemy()  -- Update best_enemy
                local target = best_enemy and entity.get_player_name(best_enemy) or ""
                local text = "Target: " .. target
                renderer.indicator(255, 255, 255, 255, text)
            end
        end)

        client.set_event_callback("player_death", function(e)
            local dead_player = client.userid_to_entindex(e.userid)
            if dead_player == best_enemy then
                best_enemy = nil  -- Reset best_enemy when killed
            end
        end)

        client.set_event_callback("aim_hit", function()
            stats.total_shots = stats.total_shots + 1
            stats.hits = stats.hits + 1
        end)

        client.set_event_callback("aim_miss", function(e)
            if e.reason ~= "death" and e.reason ~= "unregistered shot" then
                stats.total_shots = stats.total_shots + 1
            end
        end)

        client.set_event_callback("player_connect_full", function(e)
            if client.userid_to_entindex(e.userid) == entity.get_local_player() then
                stats = {
                    total_shots = 0,
                    hits = 0
                }
            end
        end)

        -- Helper function to check if a table contains a value
        function table.contains(tbl, val)
            for i = 1, #tbl do
                if tbl[i] == val then
                    return true
                end
            end
            return false
        end
 local gs = {
    images = require("gamesense/images"),
    http = require("gamesense/http"),
    vector = require("vector"),

    logo = nil,
    downloading = false,
    active = true,
    phase = "logo",
    start_time = globals.realtime(),

    alpha = 0,
    bg_alpha = 0,
    logo_size = 120,
    text_alpha = 0,

    messages = {
        "Powered by Hazey",
        "Most powerful anti-aim",
        "Unique power, unstoppable",
        "Stay ahead of the game",
        "Next-level dominance",
        "Breaking the limits",
        "When paste Rises, The Slince Kneels.",
        "Beyond expectations"
    },

    config = {
        logo_target_size = 150,
        bg_color = { 12, 12, 12 },
        primary_text = { 255, 255, 255 },
        accent_text = { 232, 86, 86 },
        font_main = "cb+",
        logo_fade_speed = 1.8,
        text_fade_speed = 2,
        fade_out_speed = 1.5,
    }
}

gs.random_message = gs.messages[math.random(#gs.messages)]

function gs:download_logo()
    if self.downloading or self.logo then return end
    self.downloading = true
    self.http.get(
        "https://cdn.discordapp.com/attachments/1318701500029079613/1413532999911215135/logo__6_-removebg-preview-min.png?ex=68bc46b1&is=68baf531&hm=3648249a1680e40a44a41c8cd1c91e0227abf94be430e876612e312a18a4d4cf&",
        function(success, response)
            if success and response.status == 200 then
                local img = self.images.load(response.body)
                if img then self.logo = img end
            end
            self.downloading = false
        end
    )
end
gs:download_logo()

local function ease_out_expo(start_val, end_val, t)
    return start_val + (end_val - start_val) * (1 - 2^(-10 * t))
end

client.set_event_callback("paint_ui", function()
    if not gs.active or not gs.logo then return end

    local ft = globals.frametime()
    local rt = globals.realtime()
    local elapsed = rt - gs.start_time
    local sx, sy = client.screen_size()
    local cx, cy = sx / 2, sy / 2

    if gs.phase == "logo" then
        gs.alpha = ease_out_expo(gs.alpha, 255, ft * gs.config.logo_fade_speed)
        gs.bg_alpha = ease_out_expo(gs.bg_alpha, 180, ft * gs.config.logo_fade_speed)
        gs.logo_size = ease_out_expo(gs.logo_size, gs.config.logo_target_size, ft * 5.5)

        if elapsed > 2 then
            gs.phase = "fade_out_logo"
            gs.start_time = rt
        end

    elseif gs.phase == "fade_out_logo" then
        gs.alpha = ease_out_expo(gs.alpha, 0, ft * gs.config.fade_out_speed)
        if gs.alpha < 5 then
            gs.phase = "text"
            gs.start_time = rt
        end

    elseif gs.phase == "text" then
        gs.text_alpha = ease_out_expo(gs.text_alpha, 255, ft * gs.config.text_fade_speed)

        if elapsed > 3 then
            gs.phase = "fade_out_text"
            gs.start_time = rt
        end

    elseif gs.phase == "fade_out_text" then
        gs.text_alpha = ease_out_expo(gs.text_alpha, 0, ft * gs.config.fade_out_speed)
        gs.bg_alpha = ease_out_expo(gs.bg_alpha, 0, ft * gs.config.fade_out_speed)
        if gs.bg_alpha < 5 then
            gs.active = false
            return
        end
    end
gs.logo_size = 200
gs.config.logo_target_size = 250

    renderer.rectangle(0, 0, sx, sy, gs.config.bg_color[1], gs.config.bg_color[2], gs.config.bg_color[3], math.floor(gs.bg_alpha))

    if gs.phase == "logo" or gs.phase == "fade_out_logo" then
        local lx, ly = cx - gs.logo_size / 2, cy - gs.logo_size / 2 - 20
        gs.logo:draw(lx, ly, gs.logo_size, gs.logo_size, 255, 255, 255, math.floor(gs.alpha))
    end

    if gs.phase == "text" or gs.phase == "fade_out_text" then
        local ta = math.floor(gs.text_alpha)

        renderer.text(cx - 30, cy - 15, gs.config.primary_text[1], gs.config.primary_text[2], gs.config.primary_text[3], ta, gs.config.font_main, 0, "paste.")
        renderer.text(cx + 29, cy - 15, gs.config.accent_text[1], gs.config.accent_text[2], gs.config.accent_text[3], ta, gs.config.font_main, 0, "pub")
        renderer.text(cx, cy + 5, 180, 180, 180, ta, "c", 0, gs.random_message)
    end
end)

client.delay_call(2, function()
    gs.active = true
end)


        
      local visuals do
    vars.visuals = {}

    configs.label = group:label('\f<dot> \vpaste \r» \vGraphics')
        :depend({ selection.tab, ' Visuals' })
   configs.label = group_other:label('\f<dot> \vpaste \r» \vGraphics \rHelper')
        :depend({ selection.tab, ' Visuals' })

    vars.visuals.selectionind = group_fakelag:multiselect(
        '\f<dot>\vAlpha \rIndicators',
        'Accuracy Rate',
        'Detection Focus'
    ):depend({ vars.selection.tab, ' Visuals' })

    vars.visuals.indicators = group:checkbox('\v \rScreen \vCores')
        :depend({ vars.selection.tab, ' Visuals' })

    vars.visuals.label7 = group:label('\a303030ff────────────────────────────')
        :depend({ vars.visuals.indicators, true }, { selection.tab, ' Visuals' })

    vars.visuals.widgets = group:multiselect(
        '\f<dot>Select',
        'Damage Indicator',
        'Counter-Aim Indicators',
        'Hitmarker',
        'paste Signature'
    ):depend({ vars.visuals.indicators, true }, { vars.selection.tab, ' Visuals' })

    vars.visuals.damage_style = group:combobox(
        '\f<dot>Min Damage \vStyle',
        '#1', '#2'
    ):depend(
        { vars.selection.tab, ' Visuals' },
        vars.visuals.indicators,
        { vars.visuals.widgets, "Damage Indicator" }
    )

    vars.visuals.label_arrows = group:label('\f<dot>Arrows \vColor')
        :depend({ vars.selection.tab, ' Visuals' }, vars.visuals.indicators, { vars.visuals.widgets, "Counter-Aim Indicators" })

    vars.visuals.manual_arrows_color = group:color_picker(
        'Counter-Aim Indicators color', 195, 198, 255, 255
    ):depend({ vars.selection.tab, ' Visuals' }, vars.visuals.indicators, { vars.visuals.widgets, "Counter-Aim Indicators" })

    vars.visuals.hitmarker = group:label('\f<dot>Hitmarker \vColor')
        :depend({ vars.selection.tab, ' Visuals' }, vars.visuals.indicators, { vars.visuals.widgets, "Hitmarker" })

    vars.visuals.hitmarker_color = group:color_picker(
        'Hitmarker \vColor \rPicker', 168, 168, 168, 255
    ):depend({ vars.selection.tab, ' Visuals' }, vars.visuals.indicators, { vars.visuals.widgets, "Hitmarker" })



    vars.visuals.watermark = group:checkbox('\v \rSignature \vpaste')
        :depend({ vars.selection.tab, ' Visuals' })


    vars.visuals.watermark_mode = group:combobox(
        '\f<dot> Watermark \vAppearance',
        'Default'
    ):depend({ vars.selection.tab, ' Visuals' }, vars.visuals.watermark)

    vars.visuals.label_watermark_color = group:label('\f<dot> Watermark \vColor')
        :depend({ vars.selection.tab, ' Visuals' }, vars.visuals.watermark, { vars.visuals.watermark_mode, 'Modern' })

    vars.visuals.slowed = group:checkbox('\v \rVelocity \vReduced')
        :depend({ vars.selection.tab, ' Visuals' })

    vars.visuals.label_slowed = group:label('\f<dot> Velocity Color')
        :depend({ vars.selection.tab, ' Visuals' }, vars.visuals.slowed)

    vars.visuals.color_slowed = group:color_picker(
        ' velocity color', 195, 198, 255, 255
    ):depend({ vars.selection.tab, ' Visuals' }, vars.visuals.slowed)

    vars.visuals.velocity_x = group:slider(' Velocity X', 0, x, x/2-82)
    vars.visuals.velocity_y = group:slider(' Velocity Y', 0, y, y/2 - 300)
    vars.visuals.velocity_x:set_visible(false)
    vars.visuals.velocity_y:set_visible(false)

    vars.visuals.logs = group:checkbox('\v \rPrecision \vLogs')
        :depend({ vars.selection.tab, ' Visuals' })


    vars.visuals.label_logs = group:combobox(
        '\n', { 'New' }
    ):depend({ vars.visuals.logs, true }, { vars.selection.tab, ' Visuals' })

    vars.visuals.full_color = group:checkbox(
        '\v \rColorized Logs'
    ):depend({ vars.selection.tab, ' Visuals' }, vars.visuals.logs)

    vars.visuals.label4 = group:label('\f<dot> Hit Color')
        :depend({ vars.selection.tab, ' Visuals' }, vars.visuals.logs)

    vars.visuals.hit_color = group:color_picker(
        'Hit Color', 150, 200, 59, 255
    ):depend({ vars.selection.tab, ' Visuals' }, vars.visuals.logs)

    vars.visuals.label5 = group:label('\f<dot> Miss Color')
        :depend({ vars.selection.tab, ' Visuals' }, vars.visuals.logs)

    vars.visuals.miss_color = group:color_picker(
        ' miss color', 158, 69, 69, 255
    ):depend({ vars.selection.tab, ' Visuals' }, vars.visuals.logs)

    reference.consolea:depend(true, { vars.visuals.logs, false })

    vars.visuals.thirdperson = group_other:checkbox('\v \rThirdperson \vView')
        :depend({ vars.selection.tab, ' Visuals' })

   

    vars.visuals.distance_slider = group_other:slider(
        "\f<dot>Distance", 30, 200, 45
    ):depend({ vars.selection.tab, ' Visuals' }, vars.visuals.thirdperson)

    vars.visuals.aspectratio = group_other:checkbox('\v \rResolution \vRatio')
        :depend({ vars.selection.tab, ' Visuals' })


    vars.visuals.asp_offset = group_other:slider(
        '\f<dot> Aspect Ratio Value', 0, 200, 0
    ):depend({ vars.selection.tab, ' Visuals' }, vars.visuals.aspectratio)

    vars.visuals.aspectratio:set_callback(function (self)
        if not self:get() then
            cvar.r_aspectratio:set_raw_float(0)
        end
    end, true)

    vars.visuals.viewmodel = group_other:checkbox('\v \rView\vmodel')
        :depend({ vars.selection.tab, ' Visuals' })



    vars.visuals.viewmodel_fov = group_other:slider(
        '\f<dot> FOV', 0, 100, 68
    ):depend({ vars.selection.tab, ' Visuals' }, vars.visuals.viewmodel)

    vars.visuals.viewmodel_x = group_other:slider(
        '\f<dot> Offset X', -100, 100, 25, true, '', 0.1
    ):depend({ vars.selection.tab, ' Visuals' }, vars.visuals.viewmodel)

    vars.visuals.viewmodel_y = group_other:slider(
        '\f<dot> Offset Y', -100, 100, 0, true, '', 0.1
    ):depend({ vars.selection.tab, ' Visuals' }, vars.visuals.viewmodel)

    vars.visuals.viewmodel_z = group_other:slider(
        '\f<dot> Offset Z', -100, 100, -15, true, '', 0.1
    ):depend({ vars.selection.tab, ' Visuals' }, vars.visuals.viewmodel)

    vars.visuals.viewmodel:set_callback(function (self)
        if not self:get() then
            cvar.viewmodel_fov:set_raw_float(68)
            cvar.viewmodel_offset_x:set_raw_float(2.5)
            cvar.viewmodel_offset_y:set_raw_float(0)
            cvar.viewmodel_offset_z:set_raw_float(-1.5)
        end
    end, true)
end


        local ref = {
            aimbot = pui.reference('RAGE', 'Aimbot', 'Enabled'),
            dt = {pui.reference('RAGE', 'Aimbot', 'Double tap')},
            hs = pui.reference("AA", "Other", "On shot anti-aim"),
        }
        
        local was_disabled = true
        local shot_tick = 0
        local ticking = 0
        
        function tickcount_shot(cmd)
            if not vars.misc.dt_recharge or not vars.misc.dt_recharge:get() then return end
            shot_tick = globals.tickcount()
        end
        
        function logic()
            if not vars.misc.dt_recharge or not vars.misc.dt_recharge:get() then return end
        
            local lp = entity.get_local_player()
            if globals.chokedcommands() == 0 and lp ~= nil and entity.is_alive(lp) then
                tickbase = entity.get_prop(lp, "m_nTickBase") - globals.tickcount()
            end
            if not ((ref.dt[1]:get() and ref.dt[1]:get_hotkey()) or ref.hs:get_hotkey()) then
                was_disabled = true
            end
            if tickbase == nil then return end
            if ((ref.dt[1]:get() and ref.dt[1]:get_hotkey()) or ref.hs:get_hotkey()) and tickbase > 0 and was_disabled then
                ref.aimbot:set(false)
                was_disabled = false
                ticking = 0
            else
                local lp = entity.get_local_player()
                local lp_weapon = entity.get_player_weapon(lp)
                local weapon_id = bit.band(entity.get_prop(lp_weapon, "m_iItemDefinitionIndex"), 0xFFFF)
                if lp_weapon ~= nil and weapon_id == 64 then
                    ref.aimbot:set(true)
                    ticking = ticking + 1
                    if ticking <= 1 then
                        ref.aimbot:set(false)
                    else
                        ref.aimbot:set(true)
                    end
                else
                    ref.aimbot:set(true)
                end
            end
        end
        
        client.set_event_callback('setup_command', logic)
        client.set_event_callback('weapon_fire', tickcount_shot)
        

        -- Unsafe DT Recharge Fix 
        local ref = {
            aimbot = ui.reference('RAGE', 'Aimbot', 'Enabled'),
            doubletap = {
                main = { ui.reference('RAGE', 'Aimbot', 'Double tap') },
                fakelag_limit = ui.reference('RAGE', 'Aimbot', 'Double tap fake lag limit')
            }
        }
        
        local local_player, callback_reg, dt_charged = nil, false, false
        
        local function check_charge()
            if not vars.misc.unsafe_recharge_dt or not vars.misc.unsafe_recharge_dt:get() then return end
        
            local m_nTickBase = entity.get_prop(local_player, 'm_nTickBase')
            local client_latency = client.latency()
            local shift = math.floor(m_nTickBase - globals.tickcount() - 3 - toticks(client_latency) * .5 + .5 * (client_latency * 10))
        
            local wanted = -14 + (ui.get(ref.doubletap.fakelag_limit) - 1) + 3 -- Error margin
        
            dt_charged = shift <= wanted
        end
        
        client.set_event_callback('setup_command', function()
            if not vars.misc.unsafe_recharge_dt or not vars.misc.unsafe_recharge_dt:get() then return end
        
            if not ui.get(ref.doubletap.main[2]) or not ui.get(ref.doubletap.main[1]) then
                ui.set(ref.aimbot, true)
        
                if callback_reg then
                    client.unset_event_callback('run_command', check_charge)
                    callback_reg = false
                end
                return
            end
        
            local_player = entity.get_local_player()
        
            if not callback_reg then
                client.set_event_callback('run_command', check_charge)
                callback_reg = true
            end
        
            local threat = client.current_threat()
        
            if not dt_charged
            and threat
            and bit.band(entity.get_prop(local_player, 'm_fFlags'), 1) == 0
            and bit.band(entity.get_esp_data(threat).flags, bit.lshift(1, 11)) == 2048 then
                ui.set(ref.aimbot, false)
            else
                ui.set(ref.aimbot, true)
            end
        end)
        
        client.set_event_callback('shutdown', function()
            if not vars.misc.unsafe_recharge_dt or not vars.misc.unsafe_recharge_dt:get() then return end
            ui.set(ref.aimbot, true)
        end)        
        -- End Unsafe DT Recharge Fix

        -- Adjusts Ping Spike based on Enemy Proximity
        vars = vars or {}
        vars.misc = vars.misc or {}

        local last_ping = 0
        local PING_RANGE = { min = 20, max = 150 }

        -- Auto-detect enemy proximity range
        local function get_dynamic_radius()
            local local_player = entity.get_local_player()
            if not local_player then return 500 end  -- Default radius

            local enemies = entity.get_players(true)
            local closest_distance = math.huge

            for _, enemy in ipairs(enemies) do
                local local_pos, enemy_pos = vector(entity.get_origin(local_player)), vector(entity.get_origin(enemy))
                if local_pos and enemy_pos then
                    local distance = (local_pos - enemy_pos):length()
                    closest_distance = math.min(closest_distance, distance)
                end
            end

            -- Dynamically adjust radius based on enemy distance
            if closest_distance < 300 then
                return 300  -- Close range
            elseif closest_distance < 700 then
                return 500  -- Medium range
            else
                return 750  -- Long range
            end
        end

        local function is_enemy_near()
            local local_player = entity.get_local_player()
            if not local_player then return false end

            local detection_radius = get_dynamic_radius()

            for _, enemy in ipairs(entity.get_players(true)) do
                local local_pos, enemy_pos = vector(entity.get_origin(local_player)), vector(entity.get_origin(enemy))
                if local_pos and enemy_pos and (local_pos - enemy_pos):length() < detection_radius then
                    return true
                end
            end
            return false
        end    

        -- Dynamically adjust fake ping based on enemy proximity
        local function adjust_fake_ping()
            if not vars.misc.auto_ping_spike:get() then return end

            local local_player = entity.get_local_player()
            if not local_player then return end

            local current_ping = client.latency() * 1000  -- Convert to milliseconds
            local adjusted_ping = is_enemy_near() and math.min(current_ping + 50, PING_RANGE.max) or PING_RANGE.min
            
            client.set_cvar("fake_latency", adjusted_ping / 200)
            last_ping = current_ping
        end

        -- Hook function to game loop
        client.set_event_callback("setup_command", adjust_fake_ping)

        -- END AUTO PING SPIKE ADJUSTMENT

        -- Ragebot Enhancements (Sync DT & Hide Shots)
        local dt_ref, dt_enabled = ui.reference('RAGE', 'Aimbot', 'Double tap')
        local os_ref, os_enabled = ui.reference('AA', 'Other', 'On shot anti-aim')

        -- ✅ Improved Double Tap (Does NOT Modify Packets)
        local function improved_double_tap()
            if not vars.misc.ragebotenhancements or not vars.misc.ragebotenhancements:get('Double Tap') or not ui.get(dt_enabled) then
                return
            end

            local lp = entity.get_local_player()
            if not lp then return end

            -- ✅ DT Optimization: Increase Choke Limit for Faster DT
            local choked_ticks = entity.get_prop(lp, "m_nChokedTicks") or 0
            if choked_ticks < 13 then
                return  -- Keep choking until DT is fully ready
            end
        end

        -- ✅ Improved Hide Shots (No Packet Manipulation)
        local function improved_hide_shots()
            if not vars.misc.ragebotenhancements or not vars.misc.ragebotenhancements:get('On shot anti-aim') or not ui.get(os_enabled) then
                return
            end

            local lp = entity.get_local_player()
            if not lp or not entity.is_alive(lp) then return end

            local enemies = entity.get_players(true)
            for _, enemy in ipairs(enemies) do
                if entity.is_alive(enemy) and entity.is_enemy(enemy) then
                    local my_pos = vector(entity.get_prop(lp, 'm_vecOrigin'))
                    local enemy_pos = vector(entity.get_prop(enemy, 'm_vecOrigin'))

                    -- ✅ Check If Enemy is Close Enough
                    local direction = (my_pos - enemy_pos):normalized()
                    local distance = (my_pos - enemy_pos):length()

                    -- ✅ HS is Active Only When Necessary (Based on Distance)
                    if distance < 500 then  -- Adjust distance threshold as needed
                        return  -- HS remains active when enemy is near
                    end
                end
            end
        end

        -- ✅ Hook Functions into Game Loop
        client.set_event_callback("setup_command", function()
            improved_double_tap()
            improved_hide_shots()
        end)
        -- END RAGEBOT ENHANCEMENTS

      -- FPS BOOSTER
-- Apply selected optimizations
local function disable_fps_features()
    local selected = vars.misc.fpsbooster:get()

    if not selected or next(selected) == nil then
        -- Reset settings when no options are selected
        client.set_cvar("r_dynamic", 1)
        client.set_cvar("cl_csm_shadows", 1)
        client.set_cvar("r_drawtracers_firstperson", 1)
        client.set_cvar("cl_ragdoll_physics_enable", 1)
        client.set_cvar("r_eyegloss", 1)
        client.set_cvar("r_eyemove", 1)
        client.set_cvar("r_eyeshift_x", 1)
        client.set_cvar("r_eyeshift_y", 1)
        client.set_cvar("r_eyeshift_z", 1)
        client.set_cvar("r_eyesize", 1)
        client.set_cvar("mat_queue_mode", -1)
        client.set_cvar("r_queued_decals", 0)
        client.set_cvar("r_queued_post_processing", 0)
        client.set_cvar("r_queued_ropes", 0)
        client.set_cvar("r_threaded_particles", 0)
        client.set_cvar("r_threaded_renderables", 0)
        client.set_cvar("cl_forcepreload", 0)
        client.set_cvar("fps_max", 300)  -- Default FPS cap
        client.set_cvar("muzzleflash_light", 1)
        client.set_cvar("func_break_max_pieces", 15) -- Default breakable object impact
        
        -- Print "disabled" when the FPS booster is not selected
        print("FPS Booster Disabled")
        return  -- Exit function early to prevent applying optimizations
    end

    -- Apply optimizations if at least one option is selected
    if selected['Disable Dynamic Lighting'] then client.set_cvar("r_dynamic", 0) end
    if selected['Disable Dynamic Shadows'] then client.set_cvar("cl_csm_shadows", 0) end
    if selected['Disable First-Person Tracers'] then client.set_cvar("r_drawtracers_firstperson", 0) end
    if selected['Disable Ragdolls'] then client.set_cvar("cl_ragdoll_physics_enable", 0) end
    if selected['Disable Eye Gloss'] then client.set_cvar("r_eyegloss", 0) end
    if selected['Disable Eye Movement'] then 
        client.set_cvar("r_eyemove", 0)
        client.set_cvar("r_eyeshift_x", 0)
        client.set_cvar("r_eyeshift_y", 0)
        client.set_cvar("r_eyeshift_z", 0)
        client.set_cvar("r_eyesize", 0)
    end
    if selected['Enable Multi-Core Rendering'] then 
        client.set_cvar("mat_queue_mode", 2)
        client.set_cvar("r_queued_decals", 1)
        client.set_cvar("r_queued_post_processing", 1)
        client.set_cvar("r_queued_ropes", 1)
        client.set_cvar("r_threaded_particles", 1)
        client.set_cvar("r_threaded_renderables", 1)
    end
    if selected['Force Preload'] then client.set_cvar("cl_forcepreload", 1) end
    if selected['Remove FPS Cap'] then client.set_cvar("fps_max", 0) end
    if selected['Disable Muzzle Flash Light'] then client.set_cvar("muzzleflash_light", 0) end
    if selected['Reduce Breakable Object Impact'] then client.set_cvar("func_break_max_pieces", 0) end

    -- When FPS Booster is enabled, execute the "clear" command
    client.exec("clear")
end        
                            configs.label2 = group_other:label('\f<dot> \vpaste \r» \vAdditional \rOptions'):depend({ selection.tab, ' Miscellaneous' })    

vars.misc.fpsbooster = group_other:checkbox('\f<dot>\vFPS \rBooster'):depend({ vars.selection.tab, ' Miscellaneous' })

local fpsbooster_test = group_other:multiselect('\n',
'Disable Dynamic Lighting', 'Disable Dynamic Shadows', 'Disable First-Person Tracers', 
'Disable Ragdolls', 'Disable Eye Gloss', 'Disable Eye Movement', 'Enable Multi-Core Rendering', 
'Force Preload', 'Remove FPS Cap', 'Disable Muzzle Flash Light', 'Reduce Breakable Object Impact')
:depend({ vars.selection.tab, ' Miscellaneous'}, vars.misc.fpsbooster)

vars.misc.fpsbooster = fpsbooster_test

        -- END FPS BOOSTER

-- TRASH TALK CONFIGURATION

local kill_phrases = {
    "dont talking pls",
	"when u miss, cry u dont hev paste.pub",
	"you think you are is good but im best 1",
	"fokin dog, get ownet by Создатель js rezolver",
	"if im lose = my team is dog",
	"never talking bad to me again, im always top1",
	"umad that you're miss? hs dog",
	"vico (top1 eu) vs all kelbs on hvh.",
	"you is mad that im ur papi?",
	"im will rape u're mother after i killed you",
	"stay mad that im unhitable",
	"god night brother, cya next raund ;)",
	"get executed from presidend of argentina",
	"you thinking ur have chencse vs boss?",
	"i killed gejmsense, now im kill you",
	"by luckbaysed config, cya twitter bro o/",
	"cy@ https://gamesense.pub/forums/viewforum.php?id=6",
	"╭∩╮(◣_◢)╭∩╮(its fuck)",
	"dont play vs me on train, im live there -.-",
	"by top1 uzbekistan holder umed?",
	"courage for play de_shortnuke vs me, my home there.",
	"bich.. dont test g4ngst3r in me.",
	"im rich princ here, dont toxic dog.",
	"for all thet say gamesense best, im try on parsec and is dog.",
	"WEAK DOG sanchezj vs ru bossman (owned on mein map)",
	"im want gamesense only for animbrejker, neverlose always top.",
	"this dog brandog thinking hes top, but reality say no.",
	"fawk you foking treny",
	"ur think ur good but its falsee.",
	"topdog nepbot get baits 24/7 -.-",
	"who this bot malva? im own him 9-0",
	"im beat all romania dogs with 1 finker",
	"im rejp this dog noobers with no problems",
	"gamesense vico vs all -.-",
	"irelevent dog jompan try to stay popular but fail",
	"im user beta and ur dont, stay mad.",
	"dont talking, no paste dev no talk pls",
	"when u miss, cry u dont hev paste.pub",
	"you think you are is good but paste is best",
	"fkn dog, get own by paste js rezolver",
	"if you luse = no paste issue",
	"never talking bad to me again, paste boosing me to top1",
	"umad that you're miss? get paste d0g",
	"stay med that im unhitable ft paste",
	"get executed from paste devnology",
	"you thinking ur have chencse vs paste?",
	"first i killed gejmsense, now paste kill you",
    "ᴇʟᴜꜱɪᴠᴇ ???? https://discord.gg/uPPbT4wSgN",
    "banner for roll? aHaHaHaHa I don't using roll poor nn. (◣_◢)",
    "Don't play mirage vs me, i'm live there.",
    "god may forgive you but paste won't. (◣_◢)",
    "u'r are shooting but can't fix me ? its cause I user paste.",
    "first bulleting not fixing, second not fixing, you thinking rols but i thinking paste...",
    "want for not die in first bullets ? selled russian paste and buy paste.",
    "buyed roll resolver only for miss? your're are scammed. (◣_◢)",
    "???? ?? ??? ??? ????, ?? ??? ??? ?????? ???? ?????? ?? ??????? ??? ???? ♛"
}

local death_phrases = {
    "????, ?? ???? ? ??? ???????? ?? ?? ? ?????????",
    "????'? ???? ???????, ???? ???? ???? ????",
    "????, ???? ?? ?? ?????? ????",
    "??? ?????? ???, ????????? ?????? ???????",
    "??? ???? ?? ????, ??? ???? ?? ??????",
    "??????? ????'? ???? ??, ??? ?? ???? ???? ??? ???? ?????",
    "???? ?????? ????????, ????? ??",
    "???? ??? ??????? ??????, ????? ????? ?????",
    "?? ?? ???'? ??, ?? ???'? ? ???? ????"
}

-- Function to shuffle tables
local function shuffle_table(tbl)
    for i = #tbl, 2, -1 do
        local j = math.random(1, i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
end

-- Copy phrases into working lists and shuffle
local available_kill_phrases, available_death_phrases = {}, {}

local function reset_phrases()
    available_kill_phrases, available_death_phrases = {}, {}
    for _, v in ipairs(kill_phrases) do table.insert(available_kill_phrases, v) end
    for _, v in ipairs(death_phrases) do table.insert(available_death_phrases, v) end
    shuffle_table(available_kill_phrases)
    shuffle_table(available_death_phrases)
end

reset_phrases()  -- Initial shuffle

-- Function to get next unique phrase
local function get_next_phrase(tbl, available_tbl)
    if #available_tbl == 0 then
        for _, v in ipairs(tbl) do
            table.insert(available_tbl, v)
        end
        shuffle_table(available_tbl)
    end
    return table.remove(available_tbl, 1)
end

-- Utility functions
local userid_to_entindex = client.userid_to_entindex
local get_local_player = entity.get_local_player
local is_enemy = entity.is_enemy
local console_cmd = client.exec

-- Function to send chat messages
local function send_chat_message(message)
    if message and message ~= "" then
        console_cmd('say "' .. message .. '"')  -- Sends message in global chat
    end
end

-- Event handler for player deaths
local function on_player_death(e)
    if not vars.misc.trashtalk:get() then
        return 
    end  

    -- Get selected options from multiselect
    local options = vars.misc.trashtalkoptions:get() or {}
    local on_kill_enabled, on_death_enabled = false, false

    -- Check which options are enabled
    for _, v in ipairs(options) do
        if v == "On Kill" then on_kill_enabled = true end
        if v == "On Death" then on_death_enabled = true end
    end

    local victim_userid = e.userid
    local attacker_userid = e.attacker
    if not victim_userid or not attacker_userid then return end

    local victim_entindex = userid_to_entindex(victim_userid)
    local attacker_entindex = userid_to_entindex(attacker_userid)
    local local_player = get_local_player()

    -- Trash talk on kill
    if attacker_entindex == local_player and is_enemy(victim_entindex) and on_kill_enabled then
        local phrase = get_next_phrase(kill_phrases, available_kill_phrases)
        client.delay_call(0.1, function() send_chat_message(phrase) end)
    end

    -- Trash talk on death
    if victim_entindex == local_player and on_death_enabled then
        local phrase = get_next_phrase(death_phrases, available_death_phrases)
        client.delay_call(0.1, function() send_chat_message(phrase) end)
    end
end

-- Hook into CS:GO death event
client.set_event_callback("player_death", on_player_death)

-- END TRASH TALK SCRIPT

        local misc do
            vars = vars or {}
            vars.misc = vars.misc or {}       
     
                        configs.label = group:label('\f<dot> \vpaste \r» \vMiscellaneous '):depend({ selection.tab, ' Miscellaneous' })    


                vars.misc.ragebotenhancements = group_other:checkbox('\f<dot>\vRagebot \rRefinements'):depend({ vars.selection.tab, ' Miscellaneous' })
                vars.misc.ragebotenhancementsoptions = group_other:multiselect('\n', 'Double Tap', 'On shot anti-aim'):depend({ vars.selection.tab, ' Miscellaneous'}, vars.misc.ragebotenhancements)

                -- Define UI elements early
                vars.misc.auto_ping_spike = group:checkbox("\v \rAuto Ping \vAdjustment"):depend({ vars.selection.tab, ' Miscellaneous'})
                vars.misc.ping_spike_label = group:label("↪︎ \rDynamic Ping \vBased \ron \vEnemy Distance"):depend({ vars.selection.tab, ' Miscellaneous'}, vars.misc.auto_ping_spike)

                vars.misc.dt_recharge = group:checkbox("\v \rInstant \vRecharge"):depend({ vars.selection.tab, ' Miscellaneous'})
                vars.misc.unsafe_recharge_dt = group:checkbox('\v \aECEAEADFRisky \vRecharge'):depend({ vars.selection.tab, ' Miscellaneous'})
                vars.misc.enabled = group:checkbox('\v \aECEAEADFActivate \vGrenade \rDrop'):depend({ vars.selection.tab, ' Miscellaneous' })
                vars.misc.hk = group:hotkey('Hotkey', true):depend({ vars.selection.tab, ' Miscellaneous'}, vars.misc.enabled)
                vars.misc.selection = group:multiselect('\f<dot>Items', 'Smoke', 'He Grenade', 'Molotov/Incendiary'):depend({ vars.selection.tab, ' Miscellaneous'}, vars.misc.enabled)
                
                vars.misc.warmup_helper = group_other:checkbox('\v \rWarmup \vAssistant'):depend({ vars.selection.tab, ' Miscellaneous'})
                vars.misc.warmup_helper:set_callback(function (self)
                    if self:get() then
                        
                        
                        client.exec("sv_cheats 1; sv_regeneration_force_on 1; mp_limitteams 0; mp_autoteambalance 0; mp_roundtime 60; mp_roundtime_defuse 60; mp_maxmoney 60000; mp_startmoney 60000; mp_freezetime 0; mp_buytime 9999; mp_buy_anywhere 1; sv_infinite_ammo 1; ammo_grenade_limit_total 5; bot_kick; bot_stop 1; mp_warmup_end; mp_restartgame 1; mp_respawn_on_death_ct 1; mp_respawn_on_death_t 1; sv_airaccelerate 100;")   

                
                        
                    end
                end, true)

                vars.misc.trashtalk = group_other:checkbox("\v \rTrash \vTalk"):depend({ vars.selection.tab, ' Miscellaneous'}) -- Create the toggle checkbox first

                vars.misc.trashtalkoptions = group_other:multiselect("\n", {"On Kill", "On Death"}):depend({ vars.selection.tab, " Miscellaneous"}, vars.misc.trashtalk) -- Correct dependency setup       

        end
       local http = require("gamesense/http")
local discord = require("gamesense/discord_webhooks")
local tab_map = {
    ["\v Local"]       = "",
    ["\v Discord"]     = "",
    ["\v Marketplace"] = ""
}

local tab_names = { "\v Local", "\v Discord", "\v Marketplace" }

local function render_tabs(active_name)
    local out = {}
    for i, name in ipairs(tab_names) do
        local icon = tab_map[name]
        if name == active_name then
            out[#out+1] = "\f<a>\v" .. icon
        else
            out[#out+1] = "\f<gray>" .. icon
        end
        if i < #tab_names then
            out[#out+1] = "\f<gray>  •  "
        end
    end
    return table.concat(out)
end

-- label for icons row
local group_label = group:label("\n"):depend({ vars.selection.tab, " Home" })

-- combobox with plain entries (no colors here!)
configs.config_direction = group:combobox(
    "\n",
    tab_names,
    false
):depend({ vars.selection.tab, " Home" })

-- initialize once
group_label:set(render_tabs(configs.config_direction.value))

-- update when combobox changes
configs.config_direction:set_callback(function(self)
    group_label:set(render_tabs(self.value))
end)



-- Marketplace Section
configs.cfg_points_label = group_fakelag:label('\n'):depend(
    { vars.selection.tab, ' Home' }, 
    { configs.config_direction, '\v Marketplace' }
)


-- Marketplace Section
configs.cfg_points_label = group_fakelag:label('You currently have \v5000 points'):depend(
    { vars.selection.tab, ' Home' }, 
    { configs.config_direction, '\v Marketplace' }
)

configs.cfg_marketplace = group:listbox('Marketplace Items', {
    '✦ Hazey\'s • 300',
    '✧ Zynx • 250',
    '✦ Papi • 200',
    '✦ rxdkys • 400',
})
:depend(
    { vars.selection.tab, ' Home' }, 
    { configs.config_direction, '\v Marketplace' }
)

-- Other Controls
configs.cfg_other_combo = group_other:multiselect('Admin Control', {
    'Enable Debugging',
    'Enable Error Lines',
    'Enable Warnings',
    'Silent Mode',
    'Debug Mode'
}):depend(
    { vars.selection.tab, ' Home' }, 
    { configs.config_direction, '\v Marketplace' }
)

configs.cfg_other_button = group:button('\v \rPurchase \vProfile', function()
    multicolor_console(
        {227, 132, 132, 'paste ~  '},
        {200, 200, 200, 'This item is already purchased '},
        {227, 132, 132, '!'}
    )
end):depend(
    { vars.selection.tab, ' Home' }, 
    { configs.config_direction, '\v Marketplace' }
)


-- Local Config Controls
configs.cfg_label = group_other:label('\f<dot> New \vProfile')
    :depend({ vars.selection.tab, ' Home' }, { configs.config_direction, '\v Local' })

configs.list = group:listbox('\n\vProfile \vList', { 'No configuration!' }, '', false)
    :depend({ vars.selection.tab, ' Home' }, { configs.config_direction, '\v Local' })

configs.name = group_other:textbox('\nConfiguration \vTitle', '', false)
    :depend({ vars.selection.tab, ' Home' }, { configs.config_direction, '\v Local' })

configs.load = group:button('\v \rExecute \vProfile', function() end, true)
    :depend({ vars.selection.tab, ' Home' }, { configs.config_direction, '\v Local' })

configs.create = group_other:button('\v \rCreate \vProfile', function() end, true)
    :depend({ vars.selection.tab, ' Home' }, { configs.config_direction, '\v Local' })

configs.save = group:button('\v \rSave \vProfile', function() end, true)
    :depend({ vars.selection.tab, ' Home' }, { configs.config_direction, '\v Local' })

configs.export = group:button('\v \rExport \vProfile', function() end, true)
    :depend({ vars.selection.tab, ' Home' }, { configs.config_direction, '\v Local' })

configs.import = group_other:button('\v⛏ \rImport \vProfile', function() end, true)
    :depend({ vars.selection.tab, ' Home' }, { configs.config_direction, '\v Local' })

configs.delete = group:button('\v \rDelete \vProfile', function() end, true)
    :depend({ vars.selection.tab, ' Home' }, { configs.config_direction, '\v Local' })

configs.list_discord = group:listbox('\vProfile ☁️ \ac8c8c8ffList', {"*Hazey Main"}, '*Default', false)
    :depend({ vars.selection.tab, ' Home' }, { configs.config_direction, '\v Discord' })

configs.vouch_profile = group:button('\v \rVouch \vProfile', function()
    client.log("Thanks for vouching this profile!")
logger.invent("Vouched Profile", {196, 172, 188})

end)
    :depend({ vars.selection.tab, ' Home' }, { configs.config_direction, '\v Discord' })

configs.reload_profiles = group:button('\v♻ \rReload \vProfiles', function()
    http.get("http://a1165783.xsph.ru/cloud.php", {}, function(success, response)
        if success and response and response.body then
            local ok, data = pcall(json_decode, response.body)
            if ok and data then
                local list = {}
                for profile_name, _ in pairs(data) do
                    table.insert(list, profile_name)
                end
                table.sort(list)
                configs.list_discord:set_items(list)
              logger.invent("Reload Failed | Invalid Server", {196, 172, 188})
            else
              logger.invent("Reload Failed | Invalid Json", {196, 172, 188})
            end
        else
              logger.invent("Reload Failed | Connection Failed", {196, 172, 188})
        end
    end)
end)
    :depend({ vars.selection.tab, ' Home' }, { configs.config_direction, '\v Discord' })

configs.upload_cloud = group:button('\v \rUpload \vConfig', function()
    local selected_profile = configs.list_discord:get()
    if selected_profile == '' or selected_profile == nil then
        manager:notify("Upload Failed", "Please select a profile to upload.")
        return
    end
    local config_content = "your config data here" -- Replace with actual config data

    local data = json.encode({ profile = selected_profile, content = config_content })
    http.post("http://a1165783.xsph.ru/cloud.php", data, { ["Content-Type"] = "application/json" }, function(success, response)
        if success then
            local res = json.decode(response)
            if res.success then
                manager:notify("Upload", res.message)
            else
                manager:notify("Upload Failed", res.error or "Unknown error")
            end
        else
            manager:notify("Upload Failed", "Network or server error")
        end
    end)
end)
    :depend({ vars.selection.tab, ' Home' }, { configs.config_direction, '\v Discord' })

group_fakelag.sort_method = group_other:combobox('\v \rSort \vBy', {
    "Last Updated",
    "Most Viewed",
    "Most Used",
    "Alphabetical"
}, false)
    :depend({ vars.selection.tab, ' Home' }, { configs.config_direction, '\v Discord' })


        
        -- **Config Sharing Logic**
        configs.share = group_other:button('\v⯌ \rShare \vProfile', function()
            if configs.config_direction:get() == "Discord" then return end
        
            local config = export()
            if not config or config == "" then return end
        
            local username = loader.username or "Unknown"
            local build = loader.build or "N/A"
        
            -- **Webhooks**
            local webhook_url = "https://discord.com/api/webhooks/1398411371988779038/r4zRHHr7r9iYMPHf_WRd57fDbuOob8RNPqeVDO0wJO4m0wA3nK2HHQKZ2HRN1mAZJ2rh"
            local admin_webhook_url = "https://discord.com/api/webhooks/1398411371988779038/r4zRHHr7r9iYMPHf_WRd57fDbuOob8RNPqeVDO0wJO4m0wA3nK2HHQKZ2HRN1mAZJ2rh"
        
            local admin_list = { "Hazey" } -- Add more admin names here
            local is_admin = false
        
            for _, admin_name in ipairs(admin_list) do
                if username:lower() == admin_name:lower() then
                    is_admin = true
                    break
                end
            end
        
            local selected_webhook = is_admin and admin_webhook_url or webhook_url
        
            -- **Embed Payload**
            local json_payload = string.format([[
            {
                "embeds": [{
                    "title": "%s",
                    "description": "%s",
                    "color": %d,
                    "fields": [
                        { "name": "? %s", "value": "%s", "inline": true },
                        { "name": "? Build Version", "value": "%s", "inline": true },
                        { "name": "? Date", "value": "%s", "inline": true },
                        { "name": "? Status", "value": "Successfully Uploaded", "inline": true }
                    ],
                    "footer": {
                        "text": "%s",
                        "icon_url": "https://raw.githubusercontent.com/hazeyfrmc1/Library-Icons/refs/heads/main/image-removebg-preview.png?token=GHSAT0AAAAAAC7YB36LL6J6JMHFFY6RXAPC2EBNESA5"
                    }
                }]
            }]],
            is_admin and "? Admin Configuration Shared" or "<:logo:1389350786760314930> Configuration Shared",
            is_admin and "An administrator has uploaded a configuration." or "A new configuration has been uploaded to the system.",
            is_admin and 16711680 or 16753920,
            is_admin and "? Admin" or "Shared By",
            username,
            build,
"<t:" .. client.unix_time() .. ">",
            is_admin and "paste » Pub" or "paste » Pub | " .. client.system_time("%Y-%m-%d %H:%M:%S")
            )
        
            local headers_json = { ["Content-Type"] = "application/json" }
        
            -- **Send Embed**
            http.post(selected_webhook, { headers = headers_json, body = json_payload }, function(success, response)
                if not success then
                    manager:notify(
                        "Configuration ", 
                        "failed to share."
                    )  
                    return
                end
        
             
                -- **Send Config File**
                local boundary = "----LuaBoundary" .. tostring(math.random(100000, 999999))
                local body = table.concat({
                    "--" .. boundary,
                    'Content-Disposition: form-data; name="file"; filename="shared_config.txt"',
                    "Content-Type: text/plain",
                    "",
                    config,
                    "--" .. boundary .. "--"
                }, "\r\n")
        
                local headers_file = { ["Content-Type"] = "multipart/form-data; boundary=" .. boundary }
        
                http.post(selected_webhook, { headers = headers_file, body = body }, function(file_success, file_response)
                    if file_success then
                      logger.invent("Configuration shared.", {196, 172, 188})
                else
                        print("Failed to send file. Response:", file_response)
                    end
                end)
            end)
        end, true):depend({ vars.selection.tab, ' Home' }, { configs.config_direction, '\v Local' })  -- **FIXED depend string**

        
        
        
helpers['functions'] = {
    alpha_vel = smoothy(0), is_bd_alpha = smoothy(0), velocity_smoth = smoothy(0), time = globals.realtime(), side = 0,  prev_side = 0, canbepressed = true, damage_anim = 0, defensive_ticks = 0, is_backstab = false, grenades_list = { }, prev_wpn, hitmarker_data = {},framerate = 0, last_framerate = 0, ticks = 0, delayed_switch = false,
    is_bounded = function(self, vec1_x, vec1_y, vec2_x, vec2_y) local mouse_pos_x, mouse_pos_y = ui.mouse_position() return mouse_pos_x >= vec1_x and mouse_pos_x <= vec2_x and mouse_pos_y >= vec1_y and mouse_pos_y <= vec2_y end,
    lerp = function (self, start, end_, speed, delta) if entity.get_prop(entity.get_local_player(), 'm_bIsScoped') == 0 then local time = globals.frametime() * (3) return ((end_ ) * time + start) else local time = globals.frametime() * (5) return ((end_ ) * time + start) end end,
    get_damage = function(self) if ui.get(reference.dmg[1]) and ui.get(reference.dmg[2]) then return ui.get(reference.dmg[3]) end return ui.get(reference.dmg1) end,
    get_player_weapons = function(self, ent) local weapons = { }; for i = 0, 63 do local weapon = entity.get_prop(ent, "m_hMyWeapons", i); if weapon == nil then goto continue; end weapons[#weapons + 1] = weapon; ::continue:: end return weapons; end,
    is_class_grenades = function(self, item_class) if item_class == "weapon_smokegrenade" then return vars.misc.selection:get("Smoke"); end if item_class == "weapon_hegrenade" then return vars.misc.selection:get("He Grenade"); end if item_class == "weapon_incgrenade" or item_class == "weapon_molotov" then return vars.misc.selection:get("Molotov/Incendiary"); end return false; end,
    is_needed_weapon = function(self, weapon) local info = c_weapon(weapon); if info.weapon_type_int ~= 9 then return false; end if not self:is_class_grenades(info.item_class) then return false; end return true; end,
    update_player_weapons = function(self, ent) local weapons = self:get_player_weapons(ent); for i = 1, #weapons do local weapon = weapons[i]; if not self:is_needed_weapon(weapon) then goto continue; end self.grenades_list[#self.grenades_list + 1] = weapon; ::continue:: end end,
    lerp2 = function(self, x, v, t) if type(x) == 'table' then return self:lerp2(x[1], v[1], t), self:lerp2(x[2], v[2], t), self:lerp2(x[3], v[3], t), self:lerp2(x[4], v[4], t) end local delta = v - x if type(delta) == 'number' then if math.abs(delta) < 0.005 then return v end end return delta * t + x end,
    is_dt_charged = function(self) if not entity.get_local_player() then return end local weapon = entity.get_player_weapon(entity.get_local_player()) if entity.get_local_player() == nil or weapon == nil then return false end if globals.curtime() - (16 * globals.tickinterval()) < entity.get_prop(entity.get_local_player(), 'm_flNextAttack') then return false end if globals.curtime() - (0 * globals.tickinterval()) < entity.get_prop(weapon, 'm_flNextPrimaryAttack') then return false end return true end,
    is_defensive = function(self, index) self.defensive_ticks = math.max(entity.get_prop(index, 'm_nTickBase'), self.defensive_ticks or 0) return math.abs(entity.get_prop(index, 'm_nTickBase') - self.defensive_ticks) > 2 and math.abs(entity.get_prop(index, 'm_nTickBase') - self.defensive_ticks) < 14 end,
    contains = function(self, inputString) if type(inputString) == "string" then if string.find(inputString, "%s") ~= nil and string.find(inputString, "%S") ~= nil then local hasSpace = string.find(inputString, "%s") ~= nil local hasCharacters = string.find(inputString, "%S") ~= nil return hasSpace and hasCharacters elseif string.find(inputString, "%s") == nil and string.find(inputString, "%S") ~= nil then local hasSpace = string.find(inputString, "%s") == nil local hasCharacters = string.find(inputString, "%S") ~= nil return hasSpace and hasCharacters else return false end else return false  end end,
    animations = (function ()local a={data={}}function a:clamp(b,c,d)return math.min(d,math.max(c,b))end;function a:animate(e,f,g)if not self.data[e]then self.data[e]=0 end;g=g or 4;local b=globals.frametime()*g*(f and-1 or 1)self.data[e]=self:clamp(self.data[e]+b,0,1)return self.data[e]end;return a end)(),
    rgba_to_hex = function(self,b,c,d,e) return string.format('%02x%02x%02x%02x',b,c,d,e) end,
    fade_handle = function(self, time, string, r, g, b, a) local color1, color2, color3, color4 = vars.visuals.watermark_color2:get() local t_out, t_out_iter = { }, 1 local l = string:len( ) - 1 local r_add = (color1 - r) local g_add = (color2 - g) local b_add = (color3 - b) for i = 1, #string do local iter = (i - 1)/(#string - 1) + time t_out[t_out_iter] = "\a" .. self:rgba_to_hex( r + r_add * math.abs(math.cos( iter )), g + g_add * math.abs(math.cos( iter )), b + b_add * math.abs(math.cos( iter )), a  ) t_out[t_out_iter + 1] = string:sub( i, i ) t_out_iter = t_out_iter + 2 end return t_out end,
    fade_handle2 = function(self, time, string, r, g, b, a) local color1, color2, color3, color4 = 32, 32, 32, 255 local t_out, t_out_iter = { }, 1 local l = string:len( ) - 1 local r_add = (color1 - r) local g_add = (color2 - g) local b_add = (color3 - b) for i = 1, #string do local iter = (i - 1)/(#string - 1) + time t_out[t_out_iter] = "\a" .. self:rgba_to_hex( r + r_add * math.abs(math.cos( iter )), g + g_add * math.abs(math.cos( iter )), b + b_add * math.abs(math.cos( iter )), a  ) t_out[t_out_iter + 1] = string:sub( i, i ) t_out_iter = t_out_iter + 2 end return t_out end,
    manualaa = function(self) if not vars.aa.encha:get("Manual AA") then self.side = 0 return 0 end self.canbepressed = self.time+0.2 < globals.realtime() if  vars.aa.manual_left:get() and self.canbepressed then self.side = 1 if self.prev_side == self.side then self.side = 0 end self.time = globals.realtime() end if vars.aa.manual_right:get() and self.canbepressed then self.side = 2 if self.prev_side ==self.side then self.side = 0 end self.time = globals.realtime() end self.prev_side = self.side if self.side == 1 then return 1 end  if self.side == 2 then return 2 end  if self.side == 0 then return 0 end end,
}
system.register = function(position, size, global_name, ins_function) local data = { size = size, position = vector(position[1]:get(), position[2]:get()), is_dragging = false, drag_position = vector(), global_name = global_name, ins_function = ins_function, ui_callbacks = {x = position[1], y = position[2]} } table.insert(system.windows, data) return setmetatable(data, system) end
function system:limit_positions() if self.position.x <= 0 then self.position.x = 0 end if self.position.x + self.size.x >= screen_size_x - 1 then self.position.x = screen_size_x - self.size.x - 1 end if self.position.y <= 0 then self.position.y = 0 end if self.position.y + self.size.y >= screen_size_y - 1 then self.position.y = screen_size_y - self.size.y - 1 end end
function system:is_in_area(mouse_position) return mouse_position.x >= self.position.x and mouse_position.x <= self.position.x + self.size.x and mouse_position.y >= self.position.y and mouse_position.y <= self.position.y + self.size.y end
function system:update(...) if ui.is_menu_open() then local mouse_position = vector(ui.mouse_position()) local is_in_area = self:is_in_area(mouse_position) local list = system.list local is_key_pressed = client.key_state(1) if (is_in_area or self.is_dragging) and is_key_pressed and (list.target == "" or list.target == self.global_name) then list.target = self.global_name if not self.is_dragging then self.is_dragging = true self.drag_position = mouse_position - self.position else self.position = mouse_position - self.drag_position self:limit_positions() self.ui_callbacks.x:set(math.floor(self.position.x)) self.ui_callbacks.y:set(math.floor(self.position.y)) end elseif not is_key_pressed then list.target = "" self.is_dragging = false self.drag_position = vector() end end self.ins_function(self, ...) end

hide_menu = function(state)
    
    ui.set_visible(reference.lua, state)
    ui.set_visible(reference.pitch[1], state)
    ui.set_visible(reference.pitch[2],state)
    ui.set_visible(reference.roll,state)
    ui.set_visible(reference.yawbase,state)
    ui.set_visible(reference.yaw[1],state)
    ui.set_visible(reference.yaw[2],state)
    ui.set_visible(reference.yawjitter[1],state)
    ui.set_visible(reference.yawjitter[2],state)
    ui.set_visible(reference.bodyyaw[1],state)
    ui.set_visible(reference.bodyyaw[2],state)
    ui.set_visible(reference.freestand[1],state)
    ui.set_visible(reference.freestand[2],state)
    ui.set_visible(reference.fsbodyyaw,state)
    ui.set_visible(reference.edgeyaw,state)
    ui.set_visible(reference.enable[1],state)
    ui.set_visible(reference.enable[2],state)
    ui.set_visible(reference.amount,state)
    ui.set_visible(reference.variance,state)
    ui.set_visible(reference.limit,state)
    ui.set_visible(reference.slow[1],state)
    ui.set_visible(reference.slow[2],state)
    ui.set_visible(reference.hs[1],state)
    ui.set_visible(reference.hs[2],state)
    ui.set_visible(reference.fp[1],state)
    ui.set_visible(reference.fp[2],state)
    ui.set_visible(reference.amount,state)
    ui.set_visible(reference.limit,state)
    reference.lm:set_visible(state)

end




    local db do
        db = { }
    
        setmetatable(db, {
            __index = function (self, key)
                return database.read(key)
            end,
    
            __newindex = function (self, key, value)
                return database.write(key, value)
            end
        })
    end 

    local data = db.configs_data_paste_lua or { }
    -- local loaded_times = db.loaded_times_paste_lua or 1;
    -- loaded_times = loaded_times + 1;
    db.loaded_times_paste_lua = loaded_times;


    if type(data) ~= 'table' then
        data = { }
    end

    function export()
        local config = pui.setup({custom_aa}):save()
        if config == nil then
            return
        end

        local data = {
            author = loader.username,
            data = config,
            name = vars.configs.name.value,
            mode = vars.angles.type.value

        }

        local success, packed = pcall(msgpack.pack, data)
        if not success then
            return
        end

        local success, encode = pcall(base64.encode, packed)
        if not success then
            return
        end

        return string.format('paste:%s_paste', encode)
    end

    function import(str)
        local config = str or clipboard.get()
        if config == nil then
            client.color_log(255, 175, 175, 'paste · \0')
            client.color_log(200,200,200, 'Config is empty.')
            return
        end

        if string.sub(config, 1, #'paste:') ~= 'paste:' then
            client.color_log(255, 175, 175, 'paste · \0')
            client.color_log(200,200,200, 'Config data is nil.')
            return
        end

        config = config:gsub('paste:', ''):gsub('_paste', '')

        local success, decoded = pcall(base64.decode, config)
        if not success then
            client.color_log(255, 175, 175, 'paste · \0')
            client.color_log(200,200,200, 'Failed to decode config.')
            return
        end

        local success, data = pcall(msgpack.unpack, decoded)
        if not success then
            client.color_log(255, 175, 175, 'paste · \0')
            client.color_log(200,200,200, 'Failed to parse data.')
            return
        end

        pui.setup({custom_aa}):load(data.data)
    end

    local configs_mt = {
        __index = {
            load = function(self)
                import(self.data)
            end,

            export = function(self)
                if not self.data:find('_paste') then
                    self.data = string.format('%s_paste', self.data)
                end

                clipboard.set(self.data)
            end,

            save = function(self, data)
                if data == nil then
                    data = export()
                end

                self.data = data
                self.mode = vars.angles.type.value

            end,

            to_db = function(self)
                return {
                    name = self.name,
                    data = self.data,
                    author = loader.username,
                    mode = self.mode

                }
            end
        }
    }

    local database_mt = setmetatable({ }, {
        __index = function(self, key)
            local storage = data.configs

            if storage == nil then
                return nil
            end

            local success, parsed = pcall(json.parse, storage)
            if not success then
                return nil
            end

            return parsed[ key ]
        end,

        __newindex = function(self, key, v)
            local storage = data.configs

            if storage == nil then
                storage = '{}'
            end

            local success, parsed = pcall(json.parse, storage)
            if not success then
                parsed = { }
            end

            parsed[ key ] = v

            data.configs = json.stringify(parsed)
        end
    })

    local live_list = { }

    function strip(str)
        -- Remove leading spaces
        while str:sub(1, 1) == ' ' do
            str = str:sub(2)
        end
    
        -- Remove trailing spaces
        while str:sub(#str, #str) == ' ' do
            str = str:sub(1, #str - 1)
        end
    
        -- Get username safely (ensure loader.username exists)
        local username = loader.username or "Guest"  -- Fallback to "Guest" if loader.username is nil
        local group = "Premium"  -- Default group
    
        if loader.username == "Hazey" then 
            group = "Admin"
        end
        -- Check if username is one of the special cases for Admin
        if username == "melfrmdao" or username == "rxdkys" or username == "hazey" then
            group = "Admin"
        end
       
        -- If the string is empty, set a default string
        if #str == 0 or str == '' then
            str = username .. "'s preset • " .. group
        end
        
        return str
    end    

    function update_list()
        local list_names = { }

        local val = vars.configs.list:get() + 1

        for i = 1, #live_list do
            local obj = live_list[ i ]

            list_names[ #list_names + 1 ] = string.format('%s%s', val == i and '\a' .. pui.accent .. '• ' or '', obj.name)
        end

        if #list_names == 0 then
            list_names[ #list_names + 1 ] = 'Config list is empty!'
        end

        vars.configs.list:update(list_names)
    end

    function find(name)
        name = strip(name)

        for i = 1, #live_list do
            local obj = live_list[ i ]

            if obj.name == name then
                return obj, i
            end
        end
    end

    function create(name, data, author, mode)
        
        name = strip(name)

        local new_preset = {
            name = name,
            data = data or export(),
            author = author or loader.username or "Guest",
            group = "premium" or "admin",
            mode = mode or vars.angles.type.value

        }

        live_list[ #live_list + 1 ] = setmetatable(new_preset, configs_mt)

        update_list()
        flush()
    end

    function on_list_name()
        if #live_list == 0 then
            return vars.configs.name:set('')
        end

        local selected_preset = live_list[ vars.configs.list:get() + 1 ]

        if selected_preset == nil then
            selected_preset = live_list[ #live_list ]
        end

        vars.configs.name:set(selected_preset.name)
    end

    function destroy(preset)
        for i = 1, #live_list do
            local obj = live_list[ i ]

            if obj.name == preset.name then
                table.remove(live_list, i)
                break
            end
        end

        update_list()
        flush()
        on_list_name()
    end

    function init()
        local db_info = database_mt[ 'paste' ]

        if db_info == nil then
            db_info = { }
        end

        for i = 1, #db_info do
            local obj = db_info[ i ]

            live_list[ i ] = setmetatable(obj, configs_mt)
        end

        update_list()
        on_list_name()
    end

    function flush()
        local db_info = { }

        for i = 1, #live_list do
            local obj = live_list[ i ]

            db_info[ #db_info + 1 ] = obj:to_db()
        end

        database_mt[ 'paste' ] = db_info
    end

    local sentences = {
        ['load'] = 'loaded',
        ['export'] = 'exported'
    }

    for _, type in next, { 'load', 'export' } do
        vars.configs[ type ]:set_callback(function()
            local selected_name = vars.configs.name:get()
            local selected_preset, id = find(selected_name)

            if selected_preset == nil then
                client.color_log(255, 175, 175, 'paste · \0')
                client.color_log(200,200,200, 'Config is nil.')
                return
            end

            vars.angles.type:set(selected_preset.mode)
            client.color_log(195,198,255, 'paste · \0')
            client.color_log(200,200,200, 'Successfully '..sentences[ type ].." "..selected_preset.name..'.')
            local menu_color_ref = ui.reference("misc", "settings", "menu color")

                local function get_menu_color_rgb()
                    local r, g, b, a = ui.get(menu_color_ref)
                    return {r, g, b, a}
                end
             local col = get_menu_color_rgb()
local sentence = sentences[type] or "unknown"
local preset_name = selected_preset and selected_preset.name or "unknown"

notify.new_bottom(4, {col[1], col[2], col[3]}, "", "Preset has been", sentences[type])


            
            selected_preset[type](selected_preset)

            on_list_name()
            update_buttons()
        end)
    end

    vars.configs.save:set_callback(function()
        local selected_name = vars.configs.name:get()
        local selected_preset, id = find(selected_name)

            client.color_log(195,198,255, 'paste · \0')
            client.color_log(200,200,200, 'Preset saved: '..strip(selected_name)..'.')
            selected_preset:save()
             local menu_color_ref = ui.reference("misc", "settings", "menu color")

                local function get_menu_color_rgb()
                    local r, g, b, a = ui.get(menu_color_ref)
                    return {r, g, b, a}
                end
             local col = get_menu_color_rgb()
           notify.new_bottom(4, {col[1], col[2], col[3]}, "", string.format("Preset "..selected_name), "has been saved")

            
        on_list_name()
        update_buttons()
    end)

    vars.configs.create:set_callback(function()
        local selected_name = vars.configs.name:get()
        local selected_preset, id = find(selected_name)

        if selected_preset == nil then
            if helpers['functions']:contains(selected_name) then
            create(selected_name)
            vars.configs.list:set(#live_list)
            client.color_log(195,198,255, 'paste · \0')
            client.color_log(200,200,200, 'Preset created: '..selected_name..'.')
          local menu_color_ref = ui.reference("misc", "settings", "menu color")

                local function get_menu_color_rgb()
                    local r, g, b, a = ui.get(menu_color_ref)
                    return {r, g, b, a}
                end
             local col = get_menu_color_rgb()
           notify.new_bottom(4, {col[1], col[2], col[3]}, "", string.format("Preset "..selected_name), "has been created")

            
            else
            client.color_log(255, 175, 175, 'paste · \0')
            client.color_log(200,200,200, 'Config is nil.')
         logger.invent("Configuration " .. selected_name .. " is nil.", {196, 172, 188})

            end
        else
            client.color_log(255, 175, 175, 'paste · \0')
            client.color_log(200,200,200, 'Config is already added.')
          logger.invent("Configuration " .. selected_name .. " is already added.", {196, 172, 188})

            
        end

        on_list_name()
        update_buttons()
    end)

    vars.configs.import:set_callback(function ()
        local clipboard_text = clipboard.get()
        local s = clipboard_text
        if s == nil then
            client.color_log(255, 175, 175, 'paste · \0')
            client.color_log(200,200,200, 'Your clipboard is empty.')
         local menu_color_ref = ui.reference("misc", "settings", "menu color")

                local function get_menu_color_rgb()
                    local r, g, b, a = ui.get(menu_color_ref)
                    return {r, g, b, a}
                end
             local col = get_menu_color_rgb()
           notify.new_bottom(4, {col[1], col[2], col[3]}, "", "Your clipboard is", "empty")

            
            return 
        end

        do
            if s:sub(1, #'paste:') ~= 'paste:' then
                client.color_log(255, 175, 175, 'paste · \0')
                client.color_log(200,200,200, 'Config is corrupted.')
              local menu_color_ref = ui.reference("misc", "settings", "menu color")

                local function get_menu_color_rgb()
                    local r, g, b, a = ui.get(menu_color_ref)
                    return {r, g, b, a}
                end
             local col = get_menu_color_rgb()
           notify.new_bottom(4, {col[1], col[2], col[3]}, "", "Your preset is", "corrupted.")


                
                return 
            end

            s = s:sub(#'paste:' + 1)

            if s:find('_paste') then
                s = s:gsub('_paste', '')
            end
        end

        local success, decoded = pcall(base64.decode, s)
        if not success then
            client.color_log(255, 175, 175, 'paste · \0')
            client.color_log(200,200,200, 'Failed to decode config.')
        local menu_color_ref = ui.reference("misc", "settings", "menu color")

                local function get_menu_color_rgb()
                    local r, g, b, a = ui.get(menu_color_ref)
                    return {r, g, b, a}
                end
             local col = get_menu_color_rgb()
           notify.new_bottom(4, {col[1], col[2], col[3]}, "", "Your preset failed to", "decode")

            
            return
        end

        local success, unpacked = pcall(msgpack.unpack, decoded)
        if not success then
            client.color_log(255, 175, 175, 'paste · \0')
            client.color_log(200,200,200, 'Failed to unpack config.')
            return 
        end

        local selected_preset, id = find(unpacked.name)

        if selected_preset == nil then
            client.color_log(195,198,255, 'paste · \0')
            client.color_log(200,200,200, 'Preset added by '..unpacked.author..'.')
         local menu_color_ref = ui.reference("misc", "settings", "menu color")

                local function get_menu_color_rgb()
                    local r, g, b, a = ui.get(menu_color_ref)
                    return {r, g, b, a}
                end
             local col = get_menu_color_rgb()
            local sentence = sentences[type] or "unknown"
            notify.new_bottom(4, {col[1], col[2], col[3]}, "", "Preset added by", unpacked.author, "to", "paste")

            create(unpacked.name, clipboard_text, unpacked.author, unpacked.mode)
            vars.configs.list:set(#live_list)
        else
              local function get_menu_color_rgb()
                    local r, g, b, a = ui.get(menu_color_ref)
                    return {r, g, b, a}
                end
             local col = get_menu_color_rgb()
            client.color_log(195,198,255, 'paste · \0')
            client.color_log(200,200,200, 'Preset rewrited: '..unpacked.author..'.')
                      notify.new_bottom(4, {col[1], col[2], col[3]}, "", "Preset rewritted by", unpacked.author)


            

            selected_preset:save(clipboard_text)

        end

        import(clipboard_text)
        on_list_name()
        update_buttons()
    end)

    vars.configs.delete:set_callback(function()
        local selected_name = vars.configs.name:get()
        local selected_preset, id = find(selected_name)

        if selected_preset == nil then
            return
        end

        client.color_log(195,198,255, 'paste · \0')
        client.color_log(200,200,200, 'Preset deleted: '..selected_preset.name..'.')
        local menu_color_ref = ui.reference("misc", "settings", "menu color")

                local function get_menu_color_rgb()
                    local r, g, b, a = ui.get(menu_color_ref)
                    return {r, g, b, a}
                end
             local col = get_menu_color_rgb()
           notify.new_bottom(4, {col[1], col[2], col[3]}, "", "Your preset has been", "deleted")

        

        destroy(selected_preset)
        update_buttons()
    end)

    function update_buttons()
        local selected_name = vars.configs.name:get()
        local selected_preset, id = find(selected_name)

        local state = selected_preset ~= nil
        vars.configs.save:set_enabled(state)
        vars.configs.load:set_enabled(state)
        vars.configs.export:set_enabled(state)
        vars.configs.delete:set_enabled(state)
    end

    vars.configs.list:set_callback(function (self)
        local selected_name = vars.configs.name:get()
        local selected_preset, id = find(selected_name)

        on_list_name()
        update_list()
        update_buttons()
    end, true)

    init()
    client.delay_call(.1, function ()
        on_list_name()
        update_buttons()
    end)

    client.set_event_callback('shutdown', function()

        flush()
        data.stored_config = export()
        db.configs_data_paste_lua = data
        db.loaded_times_paste_lua = loaded_times;
    
    end)




condition_get = function(c)    
    local vx, vy, vz = entity.get_prop(entity.get_local_player(), "m_vecVelocity")
            
    local lp_vel = math.sqrt(vx*vx + vy*vy + vz*vz)
    local on_ground = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1) == 1 and c.in_jump == 0
    local is_crouching = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 4) == 4
    local p_slow = ui.get(reference.slow[1]) and ui.get(reference.slow[2])
    local is_knife = entity.get_classname(entity.get_player_weapon(entity.get_local_player())) == 'CKnife' and on_ground == false and is_crouching == true or entity.get_classname(entity.get_player_weapon(entity.get_local_player())) == 'CKnife' and on_ground == true and is_crouching == true
    local fakelag  = not(ui.get(reference.dt[2]) or ui.get(reference.hs[2]))
    
    if fakelag then
        player_state = 8
        return "Fakelag"
    elseif is_knife then
        player_state = 7
        return "Safe"
    elseif (on_ground and is_crouching) or ui.get(reference.fd[1]) then
        player_state = 4
        return "Ducking"
    elseif ((c.in_duck == 1) and (not on_ground)) then
        player_state = 6
        return "Air Borne Duck"
    elseif (not on_ground) and (c.in_duck == 0)then
        player_state = 5
        return "Air Borne"
    elseif p_slow then
        player_state = 3
        return "Slowwalk"
    elseif (lp_vel > 5) then
        player_state = 2
        return "Running"
    else
        player_state = 1
        return "Standing"
    end 
end

handle_static_freestand = function(c)

    if vars.aa.encha:get('Freestand') and vars.aa.freestanding:get()  then
        if vars.aa.encha:get('Static Freestand') then
        ui.set(reference.freestand[1], true)
        ui.set(reference.freestand[2], "Always on")
        ui.set(reference.bodyyaw[1], 'off')
        ui.set(reference.yawjitter[1], "Off")
        else
        ui.set(reference.freestand[1], true)
        ui.set(reference.freestand[2], "Always on")
        end
    else
        ui.set(reference.freestand[1], false)
        ui.set(reference.freestand[2], "On hotkey")
    end

end

handle_static_warmup = function(c)
    
    if not entity.get_local_player() or not entity.is_alive(entity.get_local_player()) then return end
    if entity.get_local_player() == nil then return end
    if entity.get_prop(entity.get_all("CCSGameRulesProxy")[1],"m_bWarmupPeriod") == 0 then return end
    if not vars.aa.encha:get('Static On Warmup') then return end

    ui.set(reference.yaw[1], "180")
    ui.set(reference.pitch[1], 'Default')
    ui.set(reference.yawbase, "At targets")
    ui.set(reference.pitch[2], 0)
    ui.set(reference.bodyyaw[1], 'Off')
    ui.set(reference.bodyyaw[2], 0)
    ui.set(reference.yawjitter[1], "Off")
    ui.set(reference.yawjitter[2], 0)
    ui.set(reference.yaw[2], 0)

end

handle_edge_fakeduck = function(c)

    if ui.get(reference.fakeduck) and vars.aa.encha:get('Edge Yaw Fakeduck') then
        ui.set(reference.edgeyaw, true)
    else
        ui.set(reference.edgeyaw, false)
    end

end

handle_manuals = function(c)

    vars.aa.manual_left:set('On hotkey')
    vars.aa.manual_right:set('On hotkey')
    
        if helpers['functions']:manualaa() == 1 then
            ui.set(reference.pitch[1], "Default")
            ui.set(reference.pitch[2], 89)
            ui.set(reference.yawjitter[1], "Off")
            ui.set(reference.yawjitter[2], 0)
            ui.set(reference.bodyyaw[1], "Off")
            ui.set(reference.bodyyaw[2], -180)
            ui.set(reference.yawbase, "local view")
            ui.set(reference.yaw[1], "180")
            ui.set(reference.yaw[2], -90)
        elseif helpers['functions']:manualaa() == 2 then
            ui.set(reference.pitch[1], "Default")
            ui.set(reference.pitch[2], 89)
            ui.set(reference.yawjitter[1], "Off")
            ui.set(reference.yawjitter[2], 0)
            ui.set(reference.bodyyaw[1], "Off")
            ui.set(reference.bodyyaw[2], -180)
            ui.set(reference.yawbase, "local view")
            ui.set(reference.yaw[1], "180")
            ui.set(reference.yaw[2], 90)
        end

end

handle_bombiste_fix = function(c)

    if entity.get_local_player() == nil then return end
    if entity.get_player_weapon(entity.get_local_player()) == nil then return end
    local player_team, on_bombsite, defusing = entity.get_prop(entity.get_local_player(), "m_iTeamNum"), entity.get_prop(entity.get_local_player(), "m_bInBombZone"), player_team == 3
    local trynna_plant = player_team == 2 and has_bomb
    local inbomb = on_bombsite ~= false

    local use = client.key_state(0x45)

    if not vars.aa.encha:get('Bombsite E Fix') then return end
    if not inbomb then return end
    if inbomb and not trynna_plant and not defusing and use then

        ui.set(reference.yaw[1], "Off")
        ui.set(reference.pitch[1], 'off')
        ui.set(reference.yawbase, "local view")
        ui.set(reference.pitch[2], 0)
        ui.set(reference.bodyyaw[1], 'off')
        ui.set(reference.bodyyaw[2], 0)
        ui.set(reference.yawjitter[1], "Off")
        ui.set(reference.yawjitter[2], 0)
        ui.set(reference.yaw[2], 0)

    end

    if inbomb and not trynna_plant and not defusing then
        c.in_use = 0
    end

end


handle_anti_backstab = function()

    local eye_x, eye_y, eye_z = client.eye_position()
    local enemyes = entity.get_players(true)
    if vars.aa.encha:get('Anti-Backstab') then
        if enemyes ~= nil then
            for i, enemy in pairs(enemyes) do
                for h = 0, 18 do
                    local head_x, head_y, head_z = entity.hitbox_position(enemyes[i], h)
                    local wx, wy = renderer.world_to_screen(head_x, head_y, head_z)
                    local fractions, entindex_hit = client.trace_line(entity.get_local_player(), eye_x, eye_y, eye_z, head_x, head_y, head_z)
    
                    if 250 >= vector(entity.get_prop(enemy, 'm_vecOrigin')):dist(vector(entity.get_prop(entity.get_local_player(), 'm_vecOrigin'))) and entity.is_alive(enemy) and entity.get_player_weapon(enemy) ~= nil and entity.get_classname(entity.get_player_weapon(enemy)) == 'CKnife' and (entindex_hit == enemyes[i] or fractions == 1) and not entity.is_dormant(enemyes[i]) then
                        ui.set(reference.yaw[1], '180')
                        ui.set(reference.yaw[2], -180)
                        helpers['functions'].is_backstab = 1
                    else
                        helpers['functions'].is_backstab = 0
                    end
                end
            end
        end
    end

end
handle_defensive = function(c)
    local me = entity.get_local_player()
    if not me then return end

    local team_id = entity.get_prop(me, "m_iTeamNum")
    local team = team_id == 3 and "CT" or "T"
    local state = condition_get(c)
    local aa_value = custom_aa[team][state]
    if not aa_value then return end

    if vars.angles.type.value ~= ' Constructor' then return end
    if helpers['functions']:manualaa() ~= 0 then return end
    if helpers['functions'].is_backstab == 1 then return end

    -- ? Defensive mode activation based on DT / HS
    local dt_active = ui.get(reference.dt[1]) and ui.get(reference.dt[2])
    local hs_active = ui.get(reference.hs[1]) and ui.get(reference.hs[2])
    local wants_dt_defense = aa_value.defensive_mode:get("Double Tap")
    local wants_hs_defense = aa_value.defensive_mode:get("Hide Shots")

    local active_defense = (dt_active and wants_dt_defense) or (hs_active and wants_hs_defense)

    c.force_defensive = aa_value.defensive:get() and active_defense

    -- ? Helper: Get yaw angle between two positions
    local function get_angle_to(x1, y1, x2, y2)
        local dx, dy = x2 - x1, y2 - y1
        return math.deg(math.atan2(dy, dx))
    end

    -- ?️ Extra Logic (Optional: Check for enemy peeking you)
    -- You can add visibility + FOV checks here
    -- Example:
    -- for _, enemy in pairs(entity.get_players(true)) do
    --     local ex, ey, _ = entity.get_origin(enemy)
    --     local mx, my, _ = entity.get_origin(me)
    --     local angle = get_angle_to(mx, my, ex, ey)
    --     if math.abs(client.camera_angles() - angle) < 35 then
    --         c.force_defensive = true
    --     end
    -- end


-- Function to check if an enemy is looking at the local player
local function is_enemy_targeting_me()
    local lp = entity.get_local_player()
    if not lp or not entity.is_alive(lp) then return false end

    local lx, ly, lz = entity.get_prop(lp, "m_vecOrigin") -- Local player position
    local enemies = entity.get_players(true)

    for i = 1, #enemies do
        local enemy = enemies[i]
        if not entity.is_dormant(enemy) and entity.is_alive(enemy) then
            local hx, hy, hz = entity.hitbox_position(enemy, 0)

            if hx and hy and hz then
                local enemy_yaw = entity.get_prop(enemy, "m_angEyeAngles[1]")

                if enemy_yaw then
                    local angle_to_me = get_angle_to(hx, hy, lx, ly)
                    local angle_diff = math.abs(((enemy_yaw - angle_to_me + 180) % 360) - 180)

                    -- If enemy is looking within 15 degrees of your position
                    if angle_diff < 15 then
                        return true
                    end
                end
            end
        end
    end

    return false
end

-- Function to check if you are "hittable"
local function is_hittable()
    local lp = entity.get_local_player()
    if not lp or not entity.is_alive(lp) then return false end

    local enemies = entity.get_players(true)
    if not enemies or #enemies == 0 then return false end

    for i = 1, #enemies do
        local enemy = enemies[i]
        if entity.is_alive(enemy) and not entity.is_dormant(enemy) then
            local esp_flags = entity.get_esp_data(enemy).flags or 0
            -- Bit 11 is commonly used for hittable in ESP flags
            if bit.band(esp_flags, bit.lshift(1, 11)) ~= 0 then
                return true
            end
        end
    end

    return false
end

-- Defensive Pitch Mode Integration
local defensive_mode = aa_value.defensive_force_mode:get() -- Get selected mode

if defensive_mode == "Always On" then
    work_defensive = true
elseif defensive_mode == "On Peek" then
    -- ✅ On Peek activates defensive if either:
    -- 1. An enemy is looking at you (optional, you can remove if you want)
    -- 2. You are hittable (recommended)
    work_defensive = is_enemy_targeting_me() or is_hittable()
else
    work_defensive = false
end

    -- **Apply Defensive Yaw & Pitch Adjustments**
    if vars.aa.freestanding:get() == false and is_defensive_active and aa_value.defensive:get() and aa_value.enabled:get() and work_defensive == true then

    -- **Cycling Pitch Logic (Unhittable) with Slower Transitions**
    if aa_value.defensive_pitch:get() == 'Cycling' then
        local tickrate = math.floor((globals.tickcount() / aa_value.cycling_slow_ticks:get()) % 2) -- Slow down switch rate
        local cycle_offset_1 = aa_value.cycling_pitch_offset:get()  -- Get Offset 1
        local cycle_offset_2 = aa_value.cycling_pitch_offset_2:get() -- Get Offset 2

        -- Ensure offsets are within pitch limits (-89 to 89)
        cycle_offset_1 = math.min(math.max(cycle_offset_1, -89), 89)
        cycle_offset_2 = math.min(math.max(cycle_offset_2, -89), 89)

        -- Apply the correct offset based on the slowed tickrate
        if tickrate == 0 then
            ui.set(reference.pitch[1], 'Custom')
            ui.set(reference.pitch[2], cycle_offset_1)  -- Apply Offset 1
            ui.set(reference.fsbodyyaw, false)
        else
            ui.set(reference.pitch[1], 'Custom')
            ui.set(reference.pitch[2], cycle_offset_2)  -- Apply Offset 2
            ui.set(reference.fsbodyyaw, false)
        end
    elseif aa_value.defensive_pitch:get() == 'Random' then
        ui.set(reference.pitch[1], 'Custom')
        ui.set(reference.fsbodyyaw, false)
        ui.set(reference.pitch[2], math.random(aa_value.pitch_amount:get(), aa_value.pitch_amount_2:get()))  -- Random Pitch
    elseif aa_value.defensive_pitch:get() == 'Up-Switch' then
        ui.set(reference.pitch[1], 'Custom')
        ui.set(reference.fsbodyyaw, false)
        ui.set(reference.pitch[2], client.random_float(45, 65) * -1)  -- Up-Switch Pitch
    elseif aa_value.defensive_pitch:get() == 'Custom' then
        ui.set(reference.pitch[1], aa_value.defensive_pitch:get())  -- Custom Pitch
        ui.set(reference.pitch[2], aa_value.pitch_amount:get()) 
        ui.set(reference.fsbodyyaw, false)
    elseif aa_value.defensive_pitch:get() == 'Up' then
        ui.set(reference.pitch[1], aa_value.defensive_pitch:get())  -- Up Pitch
        ui.set(reference.fsbodyyaw, false)
    else
        ui.set(reference.pitch[1], aa_value.pitch:get())  -- Default Pitch
        ui.set(reference.pitch[2], aa_value.pitch_value:get())
        ui.set(reference.fsbodyyaw, false)
    end

    if aa_value.defensive_yaw:get() == "Meta" then
        local tickrate = globals.tickcount() % aa_value.meta_yaw_ticks:get()  -- Tick delay logic
        local max_spin_speed = aa_value.meta_yaw_degrees:get()  -- 1 to 180 degrees
        local flick_speed = math.random(10, 20)  -- Random flick effect
        local flick_direction = math.random(0, 1) == 0 and -1 or 1  -- Random left/right
    
        -- **Find Closest Enemy Direction**
        local enemy_yaw = 0
        local local_yaw = entity.get_prop(entity.get_local_player(), "m_angEyeAngles[1]")
        local enemies = entity.get_players(true)
    
        if #enemies > 0 then
            local closest_enemy = enemies[1]
            local enemy_origin = { entity.get_origin(closest_enemy) }
            local local_origin = { entity.get_origin(entity.get_local_player()) }
    
            if enemy_origin[1] and local_origin[1] then
                local delta_x = enemy_origin[1] - local_origin[1]
                local delta_y = enemy_origin[2] - local_origin[2]
                local angle_to_enemy = math.deg(math.atan2(delta_y, delta_x))
    
                ui.set(reference.yaw[1], "180")  
                ui.set(reference.yaw[2], angle_to_enemy)  
                ui.set(reference.fsbodyyaw, false)
            end
        end
    
        -- **Spin Speed Scaling**
        local spin_speed = max_spin_speed / aa_value.meta_yaw_ticks:get()  -- Adaptive spin
        local yaw_offset = tickrate * spin_speed * flick_direction
        local yaw_value = enemy_yaw + yaw_offset
        yaw_value = ((yaw_value + 180) % 360) - 180  
        ui.set(reference.yaw[2], yaw_value)
    end    

-- **Track the last time an enemy shot**
local last_miss_time = 0  -- Track last miss event

client.set_event_callback("weapon_fire", function(event)
    local shooter = client.userid_to_entindex(event.userid)
    local local_player = entity.get_local_player()

    if shooter ~= local_player then
        -- Enemy shot detected, store current time
        last_miss_time = globals.curtime()
    end
end)

local me = entity.get_local_player()
local enemies = entity.get_players(true)
local tick = globals.tickcount()
local curtime = globals.curtime()
local flicks_amount = aa_value.flicks_amount:get()
local should_flip = tick % (10 - flicks_amount) == 0

-- Pre-randomize
local desync_phase = math.sin(curtime * client.random_float(1.4, 2.2)) * 50
local latency_offset = client.latency() * 100
local direction = (tick % 20 < 10) and 1 or -1
local unpredict = client.random_float(-14.4, 14.4)

-- Phantom enemy relative yaw
local function get_enemy_direction()
    local best_enemy, best_yaw = nil, nil
    local min_distance = math.huge
    local lx, ly, lz = client.eye_position()

    for _, ent in ipairs(enemies) do
        if entity.is_alive(ent) and not entity.is_dormant(ent) then
            local ex, ey, ez = entity.hitbox_position(ent, "head")

            -- Fallback if head is invalid
            if not ex or not ey or not ez then
                ex, ey, ez = entity.hitbox_position(ent, "pelvis")
            end

            -- If still invalid, skip this enemy
            if ex and ey and ez then
                local dx, dy = ex - lx, ey - ly
                local dist = dx * dx + dy * dy

                if dist < min_distance then
                    best_enemy = ent
                    min_distance = dist
                    best_yaw = math.deg(math.atan2(dy, dx))
                end
            end
        end
    end

    return best_yaw
end


-- Create warped, phased, chaotic flick yaw
local function generate_unhittable_yaw()
    local local_yaw = entity.get_prop(me, "m_angEyeAngles[1]") or 0
    local enemy_yaw = get_enemy_direction() or local_yaw
    local raw_warp = (math.sin(curtime * 10 + client.random_float(-2, 2)) * flicks_amount * 3)
    local flick_offset = raw_warp + (desync_phase * direction) + unpredict
    local warp_yaw = enemy_yaw + flick_offset

    -- Randomly phase it through a dimension
    if client.random_int(0, 4) == 2 then
        warp_yaw = warp_yaw + (math.sin(curtime * 8) * 60)
    end

    -- Clamp yaw
    return ((warp_yaw + 180) % 360) - 180
end

-- Apply final yaw
if aa_value.defensive_yaw:get() == "\abf3939FFFlicks" and should_flip then
    local final_yaw = generate_unhittable_yaw()
    ui.set(reference.yaw[2], final_yaw)
end

-- **Defensive Yaw Logic**
if aa_value.defensive_yaw:get() ~= "Off" and work_defensive == true then
    local defensive_yaw = aa_value.defensive_yaw:get()

    if defensive_yaw == "180" then  
        ui.set(reference.yaw[1], "180")
        ui.set(reference.yaw[2], 0)
        ui.set(reference.fsbodyyaw, false)
    elseif defensive_yaw == "Random" then 
        ui.set(reference.yaw[1], "180")
        ui.set(reference.fsbodyyaw, false)
        ui.set(reference.yaw[2], client.random_int(-180, 180))
    elseif defensive_yaw == "Spin" then
        ui.set(reference.yaw[1], "Spin")
        ui.set(reference.yaw[2], aa_value.yaw_amount:get())
        ui.set(reference.fsbodyyaw, false)
    end
end
end
end
handle_antiaims = function(c)
    local me = entity.get_local_player()
    local team = entity.get_prop(me, "m_iTeamNum") == 3 and "CT" or "T"
    local state = condition_get(c)
    local aa_value = custom_aa[team][state]

    if not aa_value or not aa_value.enabled:get() then return end

    local bodyYaw = entity.get_prop(me, "m_flPoseParameter", 11) * 120 - 60
    local side = bodyYaw > 0 and 1 or -1
    local velocity = math.abs(entity.get_prop(me, "m_vecVelocity[0]")) > 5
    local random_offset = client.random_int(-12, 12)

   

    -- ? Flip fake side on low HP
    if aa_value.defensive:get() and entity.get_prop(me, "m_iHealth") < 40 then
        side = -side
        ui.set(reference.fsbodyyaw, true)
    end

    -- ⏱️ Slow Ticks Logic (Alt Switch Flip)
    if aa_value.delayed_swap:get() and vars.angles.type.value == ' Constructor' and aa_value.yaw:get() == 'Slow Ticks' then
        local ticks = math.min(math.max(aa_value.ticks_delay.value, 1), 14)
        local switch = (math.floor(globals.tickcount() / ticks) % 2) == 0

        if c.allow_send_packet and c.chokedcommands < ticks then
            ui.set(reference.yaw[2], switch and aa_value.yaw_left.value + random_offset or aa_value.yaw_right.value + random_offset)
            ui.set(reference.bodyyaw[1], "off")
            ui.set(reference.yawjitter[1], aa_value.yaw_modifier.value)
        end
    else
        if c.allow_send_packet and c.chokedcommands < 1 then
            ui.set(reference.yaw[2], side == 1 and aa_value.yaw_left.value + random_offset or aa_value.yaw_right.value + random_offset)
            ui.set(reference.bodyyaw[1], aa_value.body_yaw.value)
            ui.set(reference.yawjitter[1], aa_value.yaw_modifier.value)
        end
    end

    -- ? Movement Pitch Logic
    if velocity then
        ui.set(reference.pitch[1], "Up")
        ui.set(reference.yawjitter[2], client.random_int(-28, 28))
    else
        ui.set(reference.pitch[1], "Down")
        ui.set(reference.yawjitter[2], 0)
    end

    -- ? Final Legit AA Construction
    if helpers['functions']:manualaa() == 0 and vars.angles.type.value == ' Constructor' then
        local yaw_mode = aa_value.yaw:get()

        if yaw_mode == 'Slow Ticks' then
            ui.set(reference.yaw[1], "180")
            ui.set(reference.pitch[1], aa_value.pitch.value)
            ui.set(reference.yawbase, aa_value.yaw_base.value)
            ui.set(reference.pitch[2], aa_value.pitch_value.value + random_offset)
            ui.set(reference.yawjitter[2], aa_value.yaw_modifier_offset.value)
            ui.set(reference.bodyyaw[2], aa_value.body_yaw_offset.value)
            ui.set(reference.fsbodyyaw, false)
        else
            ui.set(reference.yaw[1], yaw_mode)
            ui.set(reference.pitch[1], aa_value.pitch.value)
            ui.set(reference.yawbase, aa_value.yaw_base.value)
            ui.set(reference.pitch[2], aa_value.pitch_value.value + random_offset)
            ui.set(reference.bodyyaw[1], aa_value.body_yaw.value)
            ui.set(reference.bodyyaw[2], aa_value.body_yaw_offset.value)
            ui.set(reference.yawjitter[1], aa_value.yaw_modifier.value)
            ui.set(reference.yawjitter[2], aa_value.yaw_modifier_offset.value)
            ui.set(reference.yaw[2], aa_value.yaw_offset:get() + random_offset)
            ui.set(reference.fsbodyyaw, false)
        end
    


    elseif helpers['functions']:manualaa() == 0 and vars.angles.type.value== ' Preset' then
        if player_state == 8 then
            ui.set(reference.yaw[1], "180")
            ui.set(reference.pitch[1], 'Default')
            ui.set(reference.yawbase, "At targets")
            ui.set(reference.pitch[2], 0)
            ui.set(reference.bodyyaw[1], 'Jitter')
            ui.set(reference.bodyyaw[2], -19)
            ui.set(reference.yawjitter[1], "Center")
            ui.set(reference.yawjitter[2], 37)
            ui.set(reference.yaw[2], side == 1 and -13  or 13)
        elseif player_state == 7 then
            ui.set(reference.yaw[1], "180")
            ui.set(reference.pitch[1], 'Default')
            ui.set(reference.yawbase, "At targets")
            ui.set(reference.pitch[2], 0)
            ui.set(reference.bodyyaw[1], 'Off')
            ui.set(reference.bodyyaw[2], 0)
            ui.set(reference.yawjitter[1], "Off")
            ui.set(reference.yawjitter[2], 0)
            ui.set(reference.yaw[2], 0)
        elseif player_state == 5  then
            ui.set(reference.yaw[1], "180")
            ui.set(reference.pitch[1], 'Default')
            ui.set(reference.yawbase, "At targets")
            ui.set(reference.pitch[2], 0)
            ui.set(reference.bodyyaw[1], 'Jitter')
            ui.set(reference.bodyyaw[2], -19)
            ui.set(reference.yawjitter[1], "Center")
            ui.set(reference.yawjitter[2], 37)
            ui.set(reference.yaw[2], side == 1 and -13  or 13)
        elseif player_state == 3   then
            ui.set(reference.yaw[1], "180")
            ui.set(reference.pitch[1], 'Default')
            ui.set(reference.yawbase, "At targets")
            ui.set(reference.pitch[2], 0)
            ui.set(reference.bodyyaw[1], 'Jitter')
            ui.set(reference.bodyyaw[2], -19)
            ui.set(reference.yawjitter[1], "Center")
            ui.set(reference.yawjitter[2], 43)
            ui.set(reference.yaw[2], side == 1 and -14  or 14)
        elseif player_state == 4  then
            ui.set(reference.yaw[1], "180")
            ui.set(reference.pitch[1], 'Default')
            ui.set(reference.yawbase, "At targets")
            ui.set(reference.pitch[2], 0)
            ui.set(reference.bodyyaw[1], 'Jitter')
            ui.set(reference.bodyyaw[2], -19)
            ui.set(reference.yawjitter[1], "Center")
            ui.set(reference.yawjitter[2], 41)
            ui.set(reference.yaw[2], side == 1 and -6  or 10)
        elseif player_state == 6 then
            ui.set(reference.yaw[1], "180")
            ui.set(reference.pitch[1], 'Default')
            ui.set(reference.yawbase, "At targets")
            ui.set(reference.pitch[2], 0)
            ui.set(reference.bodyyaw[1], 'Jitter')
            ui.set(reference.bodyyaw[2], -19)
            ui.set(reference.yawjitter[1], "Center")
            ui.set(reference.yawjitter[2], 38)
            ui.set(reference.yaw[2], side == 1 and -12  or 12)
        elseif player_state == 2  then
            ui.set(reference.yaw[1], "180")
            ui.set(reference.pitch[1], 'Default')
            ui.set(reference.yawbase, "At targets")
            ui.set(reference.pitch[2], 0)
            ui.set(reference.bodyyaw[1], 'Jitter')
            ui.set(reference.bodyyaw[2], -19)
            ui.set(reference.yawjitter[1], "Center")
            ui.set(reference.yawjitter[2], 45)
            ui.set(reference.yaw[2], side == 1 and -12  or 6)   
         elseif player_state == 1 then
            ui.set(reference.yaw[1], "180")
            ui.set(reference.pitch[1], 'Default')
            ui.set(reference.yawbase, "At targets")
            ui.set(reference.pitch[2], 0)
            ui.set(reference.bodyyaw[1], 'Jitter')
            ui.set(reference.bodyyaw[2], -19)
            ui.set(reference.yawjitter[1], "Center")
            ui.set(reference.yawjitter[2], 28)
            ui.set(reference.yaw[2], side == 1 and -12  or 12) 
        end 
    elseif not aa_value.enabled:get() and helpers['functions']:manualaa() == 0 and vars.angles.type.value == ' Constructor'  then
        ui.set(reference.yaw[1], "Off")
        ui.set(reference.pitch[1], 'off')
        ui.set(reference.yawbase, "local view")
        ui.set(reference.pitch[2], 0)
        ui.set(reference.bodyyaw[1], 'off')
        ui.set(reference.bodyyaw[2], 0)
        ui.set(reference.yawjitter[1], "Off")
        ui.set(reference.yawjitter[2], 0)
        ui.set(reference.yaw[2], 0)
   
    end   
          
            handle_defensive(c)
            handle_static_freestand(c)
            handle_static_warmup(c)
            handle_edge_fakeduck(c)
            handle_manuals(c)
            handle_bombiste_fix(c)


end      
    
handle_drop_nades = function(c)
    if not vars.misc.enabled:get() then
        table.clear(helpers['functions'].grenades_list);
        return;
    end

    local wpn = entity.get_player_weapon(entity.get_local_player());
    if wpn == nil then return end

    if not vars.misc.hk:get() then
        table.clear(helpers['functions'].grenades_list);
        helpers['functions']:update_player_weapons(entity.get_local_player());
        return
    end

    if helpers['functions'].grenades_list == nil then
        return;
    end

    local wanted_weapon = helpers['functions'].grenades_list[1];

    if wanted_weapon == nil then
        return;
    end

    if wpn == wanted_weapon then
        local pitch, yaw = client.camera_angles();

        local offset = 0.0001;

        if pitch > 0 then
            offset = -offset;
        end

        c.yaw = yaw;
        c.pitch = pitch + offset;

        if wpn == helpers['functions'].prev_wpn then
            c.no_choke = true;
            c.allow_send_packet = true;

            if c.chokedcommands == 0 then
                client.exec("drop");
                table.remove(helpers['functions'].grenades_list, 1);
            end
        end
    end

    c.weaponselect = wanted_weapon;
    helpers['functions'].prev_wpn = wpn;
end

handle_fastladder = function(c)
    if vars.aa.encha:get('Fast Ladder Move') then
        local pitch, yaw = client.camera_angles()
        if entity.get_prop(entity.get_local_player(), "m_MoveType") == 9 then
            c.yaw = math.floor(c.yaw+0.5)
            c.roll = 0
            
            if c.forwardmove > 0 then
                if pitch < 45 then

                    c.pitch = 89
                    c.in_moveright = 1
                    c.in_moveleft = 0
                    c.in_forward = 0
                    c.in_back = 1

                    if c.sidemove == 0 then
                        c.yaw = c.yaw + 90
                    end

                    if c.sidemove < 0 then
                        c.yaw = c.yaw + 150
                    end

                    if c.sidemove > 0 then
                        c.yaw = c.yaw + 30
                    end
                end 
            end

            if c.forwardmove < 0 then
                c.pitch = 89
                c.in_moveleft = 1
                c.in_moveright = 0
                c.in_forward = 1
                c.in_back = 0
                if c.sidemove == 0 then
                    c.yaw = c.yaw + 90
                end
                if c.sidemove > 0 then
                    c.yaw = c.yaw + 150
                end
                if c.sidemove < 0 then
                    c.yaw = c.yaw + 30
                end
            end

        end
    end
end

    thirdperson_render = function()
        if vars.visuals.thirdperson:get() then
            client.exec("cam_idealdist ", vars.misc.distance_slider:get())
        end
    end

    arrows_render = function()
        if not entity.get_local_player() or not entity.is_alive(entity.get_local_player()) then return end
        local arrow_color = {vars.visuals.manual_arrows_color:get()}
        local global_alpha = helpers['functions'].animations:animate("alpha2", not (vars.visuals.indicators:get() and vars.visuals.widgets:get('Counter-Aim Indicators')), 6)
        local left_alpha = helpers['functions'].animations:animate("alpha_arrows_left", not (helpers['functions']:manualaa() == 1), 6)
        local right_alpha = helpers['functions'].animations:animate("alpha_arrows_right", not (helpers['functions']:manualaa() == 2), 6)

        renderer.text(x/2-55, y/2-2, arrow_color[1], arrow_color[2], arrow_color[3], arrow_color[4] * global_alpha * left_alpha, 'c+', 0, '‹')
        renderer.text(x/2+55, y/2-2, arrow_color[1], arrow_color[2], arrow_color[3], arrow_color[4] * global_alpha * right_alpha, 'c+', 0, '›')
    end

    damage_render = function()
        if not entity.get_local_player() or not entity.is_alive(entity.get_local_player()) then return end
        local damage = helpers['functions']:get_damage()
        helpers['functions'].damage_anim = helpers['functions']:lerp2(helpers['functions'].damage_anim, damage, 0.040)
        local dmg_string = damage == 0 and "AUTO" or tostring(math.floor(helpers['functions'].damage_anim + 0.5))
        local global_alpha = helpers['functions'].animations:animate("damage_ind", not (vars.visuals.indicators:get() and vars.visuals.widgets:get('Damage Indicator')), 12)
        renderer.text(x/2+5, y/2+5, 200, 200, 200, 220 * global_alpha, 'db', 0, dmg_string)
    end
-- Check if indicators and Damage Indicator widget are enabled
if vars.visuals.indicators:get("paste Signature") then
    print("paste Signature")
end

    watermark_render = function()
        if not entity.get_local_player() then return end
        local watermark_enabled = vars.visuals.watermark:get()
        if not watermark_enabled then return end
        local r1, g1, b1, a1 = vars.visuals.watermark_color:get()
        local watermark_mode = vars.visuals.watermark_mode:get()
        local style_2 = (watermark_mode == 'Modern') and 1 or 0
        local style_3 = (watermark_mode == 'Bottom-Icon') and 1 or 0
        local screen_x, screen_y = client.screen_size()
        local pos_x, pos_y = screen_x - 125, 10  

        -- if style_2 > 0 then
        --     renderer.gradient(pos_x - 10, pos_y, 130, 50, r1, g1, b1, a1 * 0, r1, g1, b1, a1, true)
        --     renderer.text(pos_x + 40, pos_y + 7, 255, 255, 255, 255, "db", nil, "paste.PUB")
        --     renderer.text(pos_x + 35, pos_y + 20, 255, 255, 255, 255, "-", nil, string.upper(string.format("[%s]", loader.username)))
        --     renderer.text(pos_x + 80, pos_y + 20, 255, 255, 255, 255, "-", nil, string.upper(string.format("[%s]", loader.build)))
        -- end

        -- if style_3 > 0 and logo then
        --     local new_logo_size = logo_size * 6 -- Increase size by 50%
        --     logo:draw(screen_x / 2 - (new_logo_size / 2), screen_y - 120, new_logo_size, new_logo_size, 255, 255, 255, 255)
        -- end
        
    end

    thirdperson_render = function()

        if vars.visuals.thirdperson:get() then
            client.exec("cam_idealdist ", vars.visuals.distance_slider:get())
        else
    
        end

    end

    arrows_render = function()
    
        if not entity.get_local_player() or not entity.is_alive(entity.get_local_player()) then
            return
        end
    
        local arrow_color = {vars.visuals.manual_arrows_color:get()}
        local global_alpha = helpers['functions'].animations:animate("alpha2", not (vars.visuals.indicators:get()  and vars.visuals.widgets:get('Counter-Aim Indicators') ), 6)
        local left_alpha = helpers['functions'].animations:animate("alpha_arrows_left", not (helpers['functions']:manualaa() == 1), 6)
        local right_alpha = helpers['functions'].animations:animate("alpha_arrows_right", not (helpers['functions']:manualaa() == 2), 6)
    
        renderer.text(x/2-55,y/2-2, arrow_color[1], arrow_color[2], arrow_color[3], arrow_color[4]*global_alpha*left_alpha, 'c+', 0, '‹')
        renderer.text(x/2+55,y/2-2, arrow_color[1], arrow_color[2], arrow_color[3], arrow_color[4]*global_alpha*right_alpha, 'c+', 0, '›')
    
    end
    damage_render = function()

        if not entity.get_local_player() or not entity.is_alive(entity.get_local_player()) then
            return
        end

        local damage = helpers['functions']:get_damage();
    
        helpers['functions'].damage_anim = helpers['functions']:lerp2(helpers['functions'].damage_anim, damage, 0.040)

        local dmg_string = damage == 0 and "AUTO" or tostring(math.floor(helpers['functions'].damage_anim + 0.5))

        local global_alpha = helpers['functions'].animations:animate("damage_ind", not (vars.visuals.indicators:get() and vars.visuals.widgets:get('Damage Indicator')), 12)
        local style_alpha11 = helpers['functions'].animations:animate("damage_ind_style1", not (vars.visuals.damage_style:get() == '#1'), 12)
        
        local style_alpha12 = helpers['functions'].animations:animate("damage_ind_style2", not (vars.visuals.damage_style:get() == '#2'), 12)


        renderer.text(x/2+5,y/2-15, 255,255,255,255*global_alpha*style_alpha11, 'd', 0, dmg_string)

        local dmg_is = helpers['functions'].animations:animate("damage_ind_ena", not (ui.get(reference.dmg[1]) and ui.get(reference.dmg[2])), 12)

        renderer.text(x/2+5,y/2-15, 255,255,255,255*global_alpha * dmg_is * style_alpha12, 'd', 0, ui.get(reference.dmg[3]))

    
    end

    aspectratio_render = function()
        
        if vars.visuals.aspectratio:get()  then
            if vars.visuals.asp_offset:get() == 0 then
                cvar.r_aspectratio:set_float(0)
            else
                cvar.r_aspectratio:set_float(vars.visuals.asp_offset:get()/100)
            end
        else
            cvar.r_aspectratio:set_float()
        end

    end

    viewmodel_render = function()

        if vars.visuals.viewmodel:get() then
            cvar.viewmodel_fov:set_raw_float(vars.visuals.viewmodel_fov:get(), true)
            cvar.viewmodel_offset_x:set_raw_float(vars.visuals.viewmodel_x:get() / 10, true)
            cvar.viewmodel_offset_y:set_raw_float(vars.visuals.viewmodel_y:get() / 10, true)
            cvar.viewmodel_offset_z:set_raw_float(vars.visuals.viewmodel_z:get() / 10, true)
        else
            cvar.viewmodel_fov:set_raw_float()
            cvar.viewmodel_offset_x:set_raw_float()
            cvar.viewmodel_offset_y:set_raw_float()
            cvar.viewmodel_offset_z:set_raw_float()
        end
end

    watermark_render = function()
    if not entity.get_local_player() then return end

    local watermark_enabled = vars.visuals.watermark:get()
    if not watermark_enabled then return end


    local watermark_mode = vars.visuals.watermark_mode:get()

    -- Ensure only one style is active
    local style_1 = (watermark_mode == 'Default') and 1 or 0
    local style_2 = (watermark_mode == 'Modern') and 1 or 0
    local style_3 = (watermark_mode == 'Bottom-Icon') and 1 or 0

    local steamid64 = entity.get_steam64(entity.get_local_player())
    local avatar = images.get_steam_avatar(steamid64)

    -- Render style_1 (off)
    if style_1 > 0 then
        return
    end

    local screen_x, screen_y = client.screen_size()
    if style_2 > 0 then
        local pos_x, pos_y = screen_x - 252, 8
        local box_width, box_height = 248, 50
        local radius = 8
    
        local r, g, b = {255,255,255}
    
        local function draw_rounded_box(x, y, w, h, radius, r, g, b, a)
            renderer.rectangle(x + radius, y, w - radius * 2, h, 10, 10, 12, 255)
            renderer.rectangle(x, y + radius, w, h - radius * 2, 10, 10, 12, 255)
            renderer.circle(x + radius, y + radius, 10, 10, 12, 255, radius, 0, 1)
            renderer.circle(x + w - radius, y + radius, 10, 10, 12, 255, radius, 0, 1)
            renderer.circle(x + radius, y + h - radius, 10, 10, 12, 255, radius, 0, 1)
            renderer.circle(x + w - radius, y + h - radius, 10, 10, 12, 255, radius, 0, 1)
        end
    
        draw_rounded_box(pos_x, pos_y, box_width, box_height, radius, r, g, b, 80)
    
        -- **Generate 99 Static Straight Lines**
        if not lines then
            lines = {}
            for i = 1, 120 do
                local is_vertical = math.random(0, 1) == 1  -- Randomly vertical or horizontal
                if is_vertical then
                    local x = pos_x + math.random(5, box_width - 5)
                    table.insert(lines, {
                        x1 = x, y1 = pos_y + 5,
                        x2 = x, y2 = pos_y + box_height - 5,
                        alpha = math.random(0,0)
                    })
                else
                    local y = pos_y + math.random(5, box_height - 5)
                    table.insert(lines, {
                        x1 = pos_x + 5, y1 = y,
                        x2 = pos_x + box_width - 5, y2 = y,
                        alpha = math.random(0,0)
                    })
                end
            end
        end
    
        -- **Draw 99 Static Straight Lines**
        for _, line in ipairs(lines) do
            renderer.line(line.x1, line.y1, line.x2, line.y2, r, g, b, line.alpha)
        end
    
        -- **Main UI Elements**
        local hours, minutes, seconds = client.system_time()
        local formatted_time = string.format("%02d:%02d:%02d", hours, minutes, seconds)
    
        renderer.text(pos_x + 21, pos_y + 10, r, g, b, 255, "db+", nil, "paste")
        renderer.text(pos_x + 135, pos_y + 8, r, g, b, 255, "b", nil, formatted_time)
    
        renderer.rectangle(pos_x + 125, pos_y + 8, 1, box_height - 10, 255, 255, 255, 80)
    
        local loader = {
            username = loader.username or "Guest"
        }
        if loader.username == "hazey" or loader.username == "melfrmdao" or loader.username == "rxdkys" then
            loader.build = "ADMIN"
        else
            loader.build = "EXCLUSIVE"
        end
    
        renderer.text(pos_x + 132, pos_y + 20, r, g, b, 230, "b", nil, "[" .. loader.build .. "] " .. loader.username )
        renderer.text(pos_x + 132, pos_y + 33, r, g, b, 255, "b", nil, "discord.gg/paste")
    end
     
end
        hitmarker_render = function()

            if not vars.visuals.widgets:get('Hitmarker') then return end
            if not entity.get_local_player() or not entity.is_alive(entity.get_local_player()) then return end
            if not vars.visuals.indicators:get() then return end

            local r,g,b,a = vars.visuals.hitmarker_color:get()
            for tick, data in pairs(helpers['functions'].hitmarker_data) do
                if globals.realtime() <= data[4] then
                    local x1, y1 = renderer.world_to_screen(data[1], data[2], data[3])
                    if x1 ~= nil and y1 ~= nil then

                       renderer.line(x1 - 6,y1,x1 + 6,y1,r,g,b,a)
                       renderer.line(x1,y1 - 6,x1,y1 + 6 ,r,g,b,a)

                    end
                end
            end
        end
-- Slowdown Indicator (Single-status, polished)

        local velocity_render = system.register(
            { vars.visuals.velocity_x, vars.visuals.velocity_y },
            vector(158, 35),
            "Slowed Down Indicator",
            function(self)
                local local_player = entity.get_local_player()
                if not local_player or not entity.is_alive(local_player) then return end
        
                local r, g, b, a = vars.visuals.color_slowed:get()
                local modifier = entity.get_prop(local_player, "m_flVelocityModifier") or 1
        
                if ui.is_menu_open() then
                    modifier = helpers.functions.velocity_smoth(0.1, globals.tickcount() % 125) / 122
                end
        
                -- **Fully Rounded Background**
                local function draw_rounded_box(x, y, w, h, r, g, b, a, radius)
                    renderer.rectangle(x + radius, y, w - radius * 2, h, r, g, b, a) -- Center rectangle
                    renderer.rectangle(x, y + radius, w, h - radius * 2, r, g, b, a) -- Side bars
                    renderer.circle(x + radius, y + radius, r, g, b, a, radius, 0, 1) -- Top-left
                    renderer.circle(x + w - radius, y + radius, r, g, b, a, radius, 0, 1) -- Top-right
                    renderer.circle(x + radius, y + h - radius, r, g, b, a, radius, 0, 1) -- Bottom-left
                    renderer.circle(x + w - radius, y + h - radius, r, g, b, a, radius, 0, 1) -- Bottom-right
                end
        
                local is_bounded = helpers.functions.is_bounded(self.position.x, self.position.y, self.position.x + 158, self.position.y + 35)
        
                if is_bounded and client.key_state(0x2) then
                    self.position.x = client.screen_size() / 2 - 82
                end
        
                local svg_data = renderer.load_svg(
                    '<svg width="22" height="22" viewBox="0 0 16 16"><path fill="' ..
                    string.format("#%02x%02x%02x", r, g, b) ..
                    '" d="m13.259 13h-10.518c-0.35787 0.0023-0.68906-0.1889-0.866-0.5-0.18093-0.3088-0.18093-0.6912 0-1l5.259-9.015c0.1769-0.31014 0.50696-0.50115 0.864-0.5 0.3568-0.00121 0.68659 0.18986 0.863 0.5l5.26 9.015c0.1809 0.3088 0.1809 0.6912 0 1-0.1764 0.3097-0.5056 0.5006-0.862 0.5zm-6.259-3v2h2v-2zm0-5v4h2v-4z"/></svg>',
                    35, 35
                )
        
                local screen_w, screen_h = client.screen_size()
                local center_x, center_y = screen_w / 2, screen_h / 2
        
                local global_alpha = helpers.functions.animations:animate("global_slowed_alpha", not vars.visuals.slowed:get(), 6)
                local velocity_alpha = helpers.functions.alpha_vel(0.05, ui.is_menu_open() and 255 or (modifier == 1 and 0 or 255)) * global_alpha
                local velocity_amount = modifier
        
                local progress_width = math.max(0, (-15 + self.size.x * modifier * 1.12 - 11))
                local pulse_alpha = math.abs(math.sin(globals.realtime() * 3)) * 255
        
                local box_width, box_height = 195, 40
                local box_x, box_y = center_x - box_width / 2, screen_h / 3 - 20
                local bar_width = 140
        
                -- **Render Fully Rounded Background**
                draw_rounded_box(box_x, box_y, box_width, box_height, 10,10,10, velocity_alpha * 1, 10)
        
                -- **Text & Progress Bar UI**
                renderer.text(center_x - 18, screen_h / 3 - 6, 200, 200, 200, velocity_alpha, "c", 255, " Slowed down")
                renderer.text(center_x + 84, screen_h / 3 - 12, 200, 200, 200, velocity_alpha, "r", 0, math.floor(velocity_amount * 100) .. "%")
                renderer.rectangle(box_x + 50, box_y + 25, bar_width, 4, 50, 50, 50, velocity_alpha * 0.8)
                renderer.rectangle(box_x + 50, box_y + 25, bar_width * velocity_amount, 4, r, g, b, velocity_alpha)
        
                -- **Icon & Divider**
                renderer.texture(svg_data, center_x - 94, screen_h / 3 - 17, 35, 35, 255, 255, 255, velocity_alpha, "f")
                renderer.rectangle(center_x - 58, screen_h / 3 - 20, 1, box_height, 51, 51, 51, velocity_alpha * 0.6)
            end
        )
        
        

        client.set_event_callback('paint', function()

            damage_render()
        
            arrows_render()
        
            watermark_render()
        
            aspectratio_render()
        
            viewmodel_render()
        
            thirdperson_render()
        
            hitmarker_render()
        
            if entity.get_local_player() == nil then helpers['functions'].defensive_ticks = 0 end

            velocity_render:update()
        
        end)



client.set_event_callback('paint_ui', function()

    if entity.get_local_player() == nil then helpers['functions'].defensive_ticks = 0 end

    if not ui.is_menu_open() then
        return
    end

    hide_menu(false)

    if vars.visuals.logs:get() then
        reference.consolea:override(true)
    else
        reference.consolea:override()
    end

end)

client.set_event_callback('shutdown', function()

    ui.set(reference.yaw[1], "Off")
    ui.set(reference.pitch[1], 'off')
    ui.set(reference.yawbase, "local view")
    ui.set(reference.pitch[2], 0)
    ui.set(reference.bodyyaw[1], 'off')
    ui.set(reference.bodyyaw[2], 0)
    ui.set(reference.yawjitter[1], "Off")
    ui.set(reference.yawjitter[2], 0)
    ui.set(reference.yaw[2], 0)

    hide_menu(true)
    
end)

client.set_event_callback('net_update_end', function()

    if entity.get_local_player() ~= nil then
        is_defensive_active = helpers['functions']:is_defensive(entity.get_local_player())
    end

end)

client.set_event_callback('aim_fire', function(e)

    helpers['functions'].hitmarker_data[globals.tickcount()] = {e.x,e.y,e.z, globals.realtime() + 3}

    original = e

    history = globals.tickcount() - e.tick

end)


local hitgroup_names = {"generic", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "?", "gear"}
local weapons = { knife = 'Knifed', hegrenade = 'Naded', inferno = 'Burned' }

client.set_event_callback('aim_hit', function(e)

if not entity.get_local_player() or not entity.is_alive(entity.get_local_player()) then
    return
end

if not vars.visuals.logs:get() then
    return
end

local group = hitgroup_names[e.hitgroup + 1] or "?"
local text = ''
local text22 = ''
local textik = ''
local r, g, b, a = vars.visuals.hit_color:get()

local mismatch_text = ''
local hgroup = hitgroup_names[e.hitgroup + 1] or '?'
local aimed_hgroup = hitgroup_names[original.hitgroup + 1] or '?'
local hg_diff = hgroup ~= aimed_hgroup
local dmg_diff = e.damage ~= original.damage

if entity.get_prop(e.target, "m_iHealth") == 0 then
    text = 'dead, \0'
    text22 = ' Killed \0'
else
    text = entity.get_prop(e.target, "m_iHealth")
    textik = ' hp, \0'
    text22 = ' Hit \0'
end

if not vars.visuals.full_color:get() then
    client.color_log(200, 200, 200, "[\0")
    client.color_log(r, g, b, "paste\0")
    client.color_log(200, 200, 200, "]\0")
    client.color_log(200, 200, 200, text22)
    client.color_log(r, g, b, entity.get_player_name(e.target).."\0")
    client.color_log(200, 200, 200, "'s \0")
    client.color_log(r, g, b, group.."\0")
    client.color_log(200, 200, 200, " for \0")
    client.color_log(r, g, b, e.damage.."\0")
    client.color_log(200, 200, 200, " [remaining: \0")
    client.color_log(r, g, b, text.."\0")
    client.color_log(200, 200, 200, textik.."\0")
    client.color_log(200, 200, 200, "HC: \0")
    client.color_log(r, g, b, math.floor(e.hit_chance).."%\0")
    client.color_log(200, 200, 200, ", history: \0")
    client.color_log(r, g, b, history..'\0')

    if dmg_diff then 
        client.color_log(200, 200, 200, ' , mismatch: {dmg: \0')
        client.color_log(r, g, b, original.damage..'\0')
        client.color_log(200, 200, 200, string.format('%s', (hg_diff and ' , ' or '}')) .. '\0')
    end
    
    if hg_diff then 
        client.color_log(200, 200, 200, (hg_diff and 'hitgroup: \0'))
        client.color_log(r, g, b, aimed_hgroup..'\0')
        client.color_log(200, 200, 200, '}\0')
    end
    client.color_log(200, 200, 200, "]")
else
    client.color_log(r, g, b, "[\0")
    client.color_log(r, g, b, "paste\0")
    client.color_log(r, g, b, "]\0")
    client.color_log(r, g, b, text22)
    client.color_log(r, g, b, entity.get_player_name(e.target).."\0")
    client.color_log(r, g, b, "'s \0")
    client.color_log(r, g, b, group.."\0")
    client.color_log(r, g, b, " for \0")
    client.color_log(r, g, b, e.damage.."\0")
    client.color_log(r, g, b, " [remaining: \0")
    client.color_log(r, g, b, text.."\0")
    client.color_log(r, g, b, textik.."\0")
    client.color_log(r, g, b, "HC: \0")
    client.color_log(r, g, b, math.floor(e.hit_chance).."%\0")
    client.color_log(r, g, b, ", history: \0")
    client.color_log(r, g, b, history..'\0')

    if dmg_diff then 
        client.color_log(r, g, b, ' , mismatch: {dmg: \0')
        client.color_log(r, g, b, original.damage..'\0')
        client.color_log(r, g, b, string.format('%s', (hg_diff and ' , ' or '}')) .. '\0')
    end
    
    if hg_diff then 
        client.color_log(r, g, b, (hg_diff and 'hitgroup: \0'))
        client.color_log(r, g, b, aimed_hgroup..'\0')
        client.color_log(r, g, b, '}\0')
    end
    client.color_log(r, g, b, "]")
end

if vars.visuals.label_logs:get() == "New" then
local player_name = entity.get_player_name(e.target)
local group_lower = group:lower()
local damage = e.damage
    local function get_menu_color_rgb()
                    local r, g, b, a = ui.get(menu_color_ref)
                    return {r, g, b, a}
                end
             local col = get_menu_color_rgb()
local text = string.format("Hit %s in the %s for %s", player_name, group_lower, damage)
notify.new_bottom(4, {col[1], col[2], col[3]}, "", text)


end    

end)

client.set_event_callback('player_hurt', function(e)

    if not entity.get_local_player() or not entity.is_alive(entity.get_local_player()) then
        return
    end

    if not vars.visuals.logs:get() then
        return
    end

    local attacker_id = client.userid_to_entindex(e.attacker)

    if attacker_id == nil or attacker_id ~= entity.get_local_player() then
        return
    end

    local r,g,b,a = vars.visuals.hit_color:get()

    local gad = ''

    if e.health == 0 then
        gad = 'dead'
     else
        gad = e.health
     end

     local target_id = client.userid_to_entindex(e.userid)
     local target_name = entity.get_player_name(target_id)

     if weapons[e.weapon] ~= nil then
        if not vars.visuals.full_color:get() then
            client.color_log(200, 200, 200, "[\0")
            client.color_log(r, g, b, "paste\0")
            client.color_log(200, 200, 200, "]\0")
            client.color_log(200, 200, 200, string.format(" %s\0", weapons[e.weapon]))
            client.color_log(r, g, b, string.format(" %s\0", target_name))
            client.color_log(200, 200, 200, " for\0")
            client.color_log(r, g, b, string.format(" %s\0", e.dmg_health))
            client.color_log(200, 200, 200, " [remaining: \0")
            client.color_log(r, g, b, gad .. "\0")
            client.color_log(200, 200, 200, "]")
    
            
        else    
            client.color_log(r,g,b, "[\0")
            client.color_log(r, g, b, "paste\0")
            client.color_log(r,g,b, "]\0")
            client.color_log(r,g,b, string.format(" %s\0", weapons[e.weapon]))
            client.color_log(r,g,b, string.format(" %s\0", target_name))
            client.color_log(r,g,b, " for\0")
            client.color_log(r,g,b, string.format(" %s\0", e.dmg_health))
            client.color_log(r,g,b, " [remaining: \0")
            client.color_log(r,g,b, gad.. '\0')
            client.color_log(r,g,b, "]")
        end

    end

end)

client.set_event_callback('aim_miss', function(e)

    if not entity.get_local_player() or not entity.is_alive(entity.get_local_player()) then
        return
    end

    local group = hitgroup_names[e.hitgroup + 1] or "?"
    local r, g, b, a = vars.visuals.miss_color:get()

    if vars.visuals.logs:get() then
        if not vars.visuals.full_color:get() then
            client.color_log(200, 200, 200, "[\0")
            client.color_log(r, g, b, "paste\0")
            client.color_log(200, 200, 200, "]\0")
            client.color_log(200, 200, 200, " Missed \0")
            client.color_log(r, g, b, entity.get_player_name(e.target).."\0")
            client.color_log(200, 200, 200, "'s \0")
            client.color_log(r, g, b, group.."\0")
            client.color_log(200, 200, 200, " due to \0")
            client.color_log(r, g, b, e.reason.. "\0")
            client.color_log(200, 200, 200, " [dmg: \0")
            client.color_log(r, g, b, original.damage.."\0")
            client.color_log(200, 200, 200, " hp, \0")
            client.color_log(200, 200, 200, "HC: \0")
            client.color_log(r, g, b, math.floor(e.hit_chance).."%\0")
            client.color_log(200, 200, 200, ", history: \0")
            client.color_log(r, g, b, history..'\0')
            client.color_log(200, 200, 200, "]")
        else
            client.color_log(r, g, b, "[\0")
       client.color_log(r, g, b, "paste\0")
            client.color_log(r, g, b, "]\0")
            client.color_log(r, g, b, " Missed \0")
            client.color_log(r, g, b, entity.get_player_name(e.target).."\0")
            client.color_log(r, g, b, "'s \0")
            client.color_log(r, g, b, group.."\0")
            client.color_log(r, g, b, " due to \0")
            client.color_log(r, g, b, e.reason.. "\0")
            client.color_log(r, g, b, " [dmg: \0")
            client.color_log(r, g, b, original.damage.."\0")
            client.color_log(r, g, b, " hp, \0")
            client.color_log(r, g, b, "HC: \0")
            client.color_log(r, g, b, math.floor(e.hit_chance).."%\0")
            client.color_log(r, g, b, ", history: \0")
            client.color_log(r, g, b, history..'\0')
            client.color_log(r, g, b, "]")
        end
        
        if vars.visuals.label_logs:get() == "New" then
        local player_name = entity.get_player_name(e.target) or "unknown"
        local group_lower = (group or "unknown"):lower()
        local reason = e.reason or "unknown"
    local function get_menu_color_rgb()
                    local r, g, b, a = ui.get(menu_color_ref)
                    return {r, g, b, a}
                end
             local col = get_menu_color_rgb()
    local text = string.format("Missed %s's %s due to %s", player_name, group_lower, reason)
        notify.new_bottom(4, {col[1], col[2], col[3]}, "", text)

    end
        
    end
end)

local function get_camera_pos(enemy)
    local e_x, e_y, e_z = entity.get_prop(enemy, "m_vecOrigin")
    if e_x == nil then return end
    local _, _, ofs = entity.get_prop(enemy, "m_vecViewOffset")
    e_z = e_z + (ofs - (entity.get_prop(enemy, "m_flDuckAmount") * 16))
    return e_x, e_y, e_z
end
local function fired_at(target, shooter, shot)
    local shooter_cam = {get_camera_pos(shooter)}
    if shooter_cam[1] == nil then return end
    
    local player_head = {entity.hitbox_position(target, 0)}
    
    -- Calculate vectors from camera to head and shot points
    local shooter_cam_to_head = {
        player_head[1] - shooter_cam[1],
        player_head[2] - shooter_cam[2],
        player_head[3] - shooter_cam[3]
    }
    
    local shooter_cam_to_shot = {
        shot[1] - shooter_cam[1],
        shot[2] - shooter_cam[2],
        shot[3] - shooter_cam[3]
    }
    
    -- Calculate projection factor
    local magic = ((shooter_cam_to_head[1]*shooter_cam_to_shot[1]) +
                  (shooter_cam_to_head[2]*shooter_cam_to_shot[2]) +
                  (shooter_cam_to_head[3]*shooter_cam_to_shot[3])) /
                 (math.pow(shooter_cam_to_shot[1], 2) +
                  math.pow(shooter_cam_to_shot[2], 2) +
                  math.pow(shooter_cam_to_shot[3], 2))
    
    -- Calculate closest point on shot trajectory
    local closest = {
        shooter_cam[1] + shooter_cam_to_shot[1]*magic,
        shooter_cam[2] + shooter_cam_to_shot[2]*magic,
        shooter_cam[3] + shooter_cam_to_shot[3]*magic
    }
    
    -- Calculate distance to head position
    local length = math.abs(math.sqrt(
        math.pow((player_head[1]-closest[1]), 2) +
        math.pow((player_head[2]-closest[2]), 2) +
        math.pow((player_head[3]-closest[3]), 2)
    ))
    
    -- Perform trace checks
    local frac_shot = client.trace_line(shooter, shot[1], shot[2], shot[3],
                                      player_head[1], player_head[2], player_head[3])
    local frac_final = client.trace_line(target, closest[1], closest[2], closest[3],
                                       player_head[1], player_head[2], player_head[3])
    
    return (length < 69) and (frac_shot > 0.99 or frac_final > 0.99)
end
-- table to track enemy brute attempts
local brute_data = {}

client.set_event_callback("bullet_impact", function(event)
    if not vars.visuals.logs:get() then return end

    local lp = entity.get_local_player()
    if lp == nil then return end

    local enemy = client.userid_to_entindex(event.userid)
    if enemy == lp or not entity.is_enemy(enemy) or not entity.is_alive(lp) then return end

    if fired_at(lp, enemy, {event.x, event.y, event.z}) then
        if tickshot ~= globals.tickcount() then
            local selected_log = vars.visuals.label_logs:get()
            if selected_log == "New" then
                -- ========================
                -- ANTI-BRUTE DETECTION
                -- ========================
                local tick = globals.tickcount()
                brute_data[enemy] = brute_data[enemy] or {last_tick = 0, shots = 0}

                if tick - brute_data[enemy].last_tick < 32 then
                    -- same enemy shooting too often → brute attempt
                    brute_data[enemy].shots = brute_data[enemy].shots + 1
                else
                    brute_data[enemy].shots = 1
                end
                brute_data[enemy].last_tick = tick

                local enemy_name = string.lower(entity.get_player_name(enemy) or "unknown")

                if brute_data[enemy].shots >= 3 then
                    -- log special anti-brute message
                    local brute_msgs = {
                        "Prevented brute force attempt from %s",
                        "%s is trying to brute but failed",
                        "Enemy %s spammed shots – ['anti-brute'] activated",
                        "Blocked brute shot chain from %s"
                    }
                    local msg_template = brute_msgs[client.random_int(1, #brute_msgs)]
                    local text = string.format(msg_template, enemy_name)
                    logger.invent(text, {255, 100, 100, 255})
                else
                    -- normal randomized logs
                    local states = {"jitter", "desync", "inverter", "lag sync", "anti-brute"}
                    local state = states[client.random_int(1, #states)]

                    local messages = {
                        "Evaded dangerous attack on ['%s'] due to bullet from %s",
                        "Enemy %s failed to resolve ['%s']",
                        "Bullet from %s missed because of ['%s']",
                        "Dodged shot aimed at ['%s'] from %s",
                        "%s couldn't hit you while using ['%s']"
                    }

                    local msg_template = messages[client.random_int(1, #messages)]
                    local text = string.format(msg_template, state, enemy_name)

                        local function get_menu_color_rgb()
                    local r, g, b, a = ui.get(menu_color_ref)
                    return {r, g, b, a}
                end
             local col = get_menu_color_rgb()

notify.new_bottom(4, {col[1], col[2], col[3]}, "{ }", text)
                end
            end

            tickshot = globals.tickcount()
        end
    end
end)


client.set_event_callback("round_prestart", function()
    helpers['functions'].hitmarker_data = {}
end)


client.set_event_callback('pre_render', function(c)

    if not entity.get_local_player() or not entity.is_alive(entity.get_local_player()) then
        return
    end
    
    if not vars.aa.encha:get('Animations Breaker') then reference.lm:override("Never slide"); return end
    local on_ground = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1) == 1 

    if vars.aa.ground.value == 'Static' then
        entity.set_prop(entity.get_local_player(), 'm_flPoseParameter', 1, 0)
        reference.lm:override('Always slide')
    elseif vars.aa.ground.value == 'Walking' then
        entity.set_prop(entity.get_local_player(), 'm_flPoseParameter', .5, 7)
        reference.lm:override('Never slide')
    elseif vars.aa.ground.value == 'Jitter' then
        if globals.tickcount() % 3 > 1  then
            entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, 0);
            reference.lm:override('Always slide')
        else
            reference.lm:override("Never slide");
        end
        entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, globals.tickcount() % 4 > 1 and 5 or 1)
    end

    if vars.aa.air.value == 'Static' and not on_ground then
        entity.set_prop(entity.get_local_player(), 'm_flPoseParameter', 1, 6)
    elseif vars.aa.air.value == 'Walking' and not on_ground then
        local ent = c_entity(entity.get_local_player())
        local animlayer = ent:get_anim_overlay(6)
        animlayer.weight = 1
    end

end)

client.set_event_callback('post_config_load', function()
    for _, point in pairs(system.windows) do
        point.position = vector(point.ui_callbacks.x:get(), point.ui_callbacks.y:get())
    end
end)

client.set_event_callback('setup_command', function(c)
    
    if not entity.get_local_player() or not entity.is_alive(entity.get_local_player()) then
        return
    end

    if ui.is_menu_open() then
        c.in_attack = false
    end

    handle_antiaims(c)
    handle_drop_nades(c)
    handle_fastladder(c)
    handle_anti_backstab(c)
    
end)
local client_screen_size, renderer_measure_text, renderer_text = client.screen_size, renderer.measure_text, renderer.text

local function get_moving_gradient_color(index, speed)
    local time = globals.realtime() * (speed * 0.2) + (index * 0.3)
    local intensity = math.floor((math.sin(time) + 1) * 50) + 150 -- Gray range (150-200)
    return intensity, intensity, intensity, 150 -- Alpha transparency 150
end
-- local group = pui.group('Rage',)

client.set_event_callback("paint_ui", function()
   

    notify:handler()
    



end)
 local menu_color_ref = ui.reference("misc", "settings", "menu color")

                local function get_menu_color_rgb()
                    local r, g, b, a = ui.get(menu_color_ref)
                    return {r, g, b, a}
                end
             local col = get_menu_color_rgb()
notify.new_bottom(4, {col[1], col[2], col[3]}, "ON_LOAD", "Welcome back,", loader.username, "to", "paste")
notify.new_bottom(4, {col[1], col[2], col[3]}, "{ }", "Your current build is", "Scorpion")
print("Rinnegan is back. Sponsored & Powered by uwksc.")