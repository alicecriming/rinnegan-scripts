
local ffi = require('ffi')
local vector = require("vector")
local pui = require("gamesense/pui") or error("not have pui.")
local base64 = require("gamesense/base64")
local clipboard = require("gamesense/clipboard")
local entity_lib = require("gamesense/entity")
local trace = require('gamesense/trace')
local csgo_weapons = require("gamesense/csgo_weapons")
local http = require ('gamesense/http')

function getbuild() 
	return "beta"
end

local shots = {
	total = 0,
	hits = 0,
}
local notifys = {
	color = {255, 255, 255},
	offset = 0,
	blured = false,
	glow = 0,
	rounded =0,
	icon = false,
}

local notify =
    (function()
    local b = vector
    local c = function(d, b, c)
        return d + (b - d) * c
    end
    local e = function()
        return b(client.screen_size())
    end
    local f = function(d, ...)
        local c = {...}
        local c = table.concat(c, "")
        return b(renderer.measure_text(d, c))
    end
    local g = {notifications = {bottom = {}}, max = {bottom = 6}}
    g.__index = g
    g.new_bottom = function(h, i, j, ...)
        table.insert(
            g.notifications.bottom,
            {
                started = false,
                instance = setmetatable(
                    {
                        active = false,
                        timeout = 5,
                        color = {["r"] = h, ["g"] = i, ["b"] = j, a = 0},
                        x = e().x / 2,
                        y = e().y,
                        text = ...
                    },
                    g
                )
            }
        )
    end
    function g:handler()
        local d = 0
        local b = 0
        for d, b in pairs(g.notifications.bottom) do
            if not b.instance.active and b.started then
                table.remove(g.notifications.bottom, d)
            end
        end
        for d = 1, #g.notifications.bottom do
            if g.notifications.bottom[d].instance.active then
                b = b + 1
            end
        end
        for c, e in pairs(g.notifications.bottom) do
            if c > g.max.bottom then
                return
            end
            if e.instance.active then
                e.instance:render_bottom(d, b)
                d = d + 1
            end
            if not e.started then
                e.instance:start()
                e.started = true
            end
        end
    end
    function g:start()
        self.active = true
        self.delay = globals.realtime() + self.timeout
    end
    function g:get_text()
        local d = ""
        for b, b in pairs(self.text) do
            local c = f("", b[1])
            local c, e, f = 255, 255, 255
            if b[2] then
                c, e, f = notifys.color[1], notifys.color[2], notifys.color[3]
            end
            d = d .. ("\a%02x%02x%02x%02x%s"):format(c, e, f, self.color.a, b[1])
        end
        return d
    end
    local k =
        (function()
        local d = {}
        d.rec = function(d, b, c, e, f, g, k, l, m)
            m = math.min(d / 2, b / 2, m)
				if notifys.blured == true then 
 
				else
					renderer.rectangle(d, b + m, c, e - m * 2, f, g, k, l)
					renderer.rectangle(d + m, b, c - m * 2, m, f, g, k, l)
					renderer.rectangle(d + m, b + e - m, c - m * 2, m, f, g, k, l)

					renderer.circle(d + m, b + m, f, g, k, l, m, 180, .25) -- left up
					renderer.circle(d - m + c, b + m, f, g, k, l, m, 90, .25) -- right up
					renderer.circle(d - m + c, b - m + e, f, g, k, l, m, 0, .25) -- right down
					renderer.circle(d + m, b - m + e, f, g, k, l, m, -90, .25) -- left down
				end
        end
        d.rec_outline = function(d, b, c, e, f, g, k, l, m, n)
            m = math.min(c / 2, e / 2, m)
				if m == 1 then
					if notifys.blured == true then 
 
					else
						renderer.rectangle(d, b, c, n, f, g, k, l)
						renderer.rectangle(d, b + e - n, c, n, f, g, k, l)
					end
				else
					renderer.rectangle(d + m, b, c - m * 2, n, f, g, k, l)
					renderer.rectangle(d + m, b + e - n, c - m * 2, n, f, g, k, l)
					renderer.rectangle(d, b + m, n, e - m * 2, f, g, k, l)
					renderer.rectangle(d + c - n, b + m, n, e - m * 2, f, g, k, l)
					renderer.circle_outline(d + m, b + m, f, g, k, l, m, 180, .25, n)
					renderer.circle_outline(d + m, b + e - m, f, g, k, l, m, 90, .25, n)
					renderer.circle_outline(d + c - m, b + m, f, g, k, l, m, -90, .25, n)
					renderer.circle_outline(d + c - m, b + e - m, f, g, k, l, m, 0, .25, n)
				end
        end
        d.glow_module_notify = function(b, c, e, f, g, k, l, m, n, o, p, q, r, s, s)
            local t = 1
            local u = 1
            if s then
                d.rec(b, c, e, f, l, m, n, o, k)
            end
            for l = 0, g do
                local m = o / 2 * (l / g) ^ 3
                d.rec_outline(
                    b + (l - g - u) * t,
                    c + (l - g - u) * t,
                    e - (l - g - u) * t * 2,
                    f - (l - g - u) * t * 2,
                    p,
                    q,
                    r,
                    m / 1.5,
                    k + t * (g - l + u),
                    t
                )
            end
        end
        return d
    end)()
    function g:render_bottom(g, l)
        local e = e()
        local m = 16
        local n = "     " .. self:get_text()
        local f = f("", n)
        local o = 8

		if notifys.rounded == false then 
			o = 8
		else
			o = 4
		end

        local p = 2 -- size
        local q = 0 + m + f.x
        local q, r = q + p * 2, 12 + 10 + 1
        local s, t = self.x - q / 2, math.ceil(self.y - 40 + .4)
        local u = globals.frametime()
        if globals.realtime() < self.delay then
            self.y = c(self.y, e.y - notifys.offset - (l - g) * r * 1.4, u * 7)
            self.color.a = c(self.color.a, 255, u * 2)
        else
            self.y = c(self.y, self.y - 10, u * 15)
            self.color.a = c(self.color.a, 0, u * 20)
            if self.color.a <= 1 then
                self.active = false
            end
        end
        local c, e, g, l = self.color.r, self.color.g, self.color.b, self.color.a
		
        k.glow_module_notify(s, t, q, r, notifys.glow, o, 25, 25, 25, l, notifys.color[1], notifys.color[2], notifys.color[3], l, true)
        local k = p + 2
        k = k + 0 + m
		
		if notifys.icon then 

		else
			renderer.text(s+k - 10,t+r/2-f.y/2,notifys.color[1], notifys.color[2], notifys.color[3],l,"b",nil,"O")
		end

        renderer.text(s + k - 10, t + r / 2 - f.y / 2, c, e, g, l, "", nil, n)
    end
    client.set_event_callback(
        "paint_ui",
        function()
            g:handler()
        end
    )
    return g
end)()
local user_name = panorama.open("CSGOHud").MyPersonaAPI.GetName()
notify.new_bottom(255,255,255, {{"Welcome back "}, {user_name, true}, {" to onesense "}, {"beta", true}})

local classptr = ffi.typeof('void***')
local rawientitylist = client.create_interface('client.dll', 'VClientEntityList003') or error('VClientEntityList003 wasnt found', 2)

local ientitylist = ffi.cast(classptr, rawientitylist) or error('rawientitylist is nil', 2)

local get_client_entity = ffi.cast('void*(__thiscall*)(void*, int)', ientitylist[0][3]) or error('get_client_entity is nil', 2)

json.encode_sparse_array(true)

local unpack = unpack
local next = next
local line = renderer.line
local world_to_screen = renderer.world_to_screen
local unpack_vec = vector().unpack

local texts = {"приветики, пукните в пакетики...", "loading a godmode lua", "best луа для anti-aim god", "воу, а ты слыхал про 5way-switch? тут есть они)", "то чувство когда ты загрузил эту луа...", "500$ lua, best anti-aim", "https://discord.gg/zUKBpRrSss"}
local random_text_for = ""

math.randomseed(math.floor(globals.realtime() * 1000))
random_text_for = texts[math.random(1, #texts)]

function get_camera_pos(enemy)
	local e_x, e_y, e_z = entity.get_prop(enemy, "m_vecOrigin")
	if e_x == nil then return end
	local _, _, ofs = entity.get_prop(enemy, "m_vecViewOffset")
	e_z = e_z + (ofs - (entity.get_prop(enemy, "m_flDuckAmount") * 16))
	return e_x, e_y, e_z
end
function fired_at(target, shooter, shot)
	local shooter_cam = { 
		get_camera_pos(shooter)
	}
	if shooter_cam[1] == nil then return end
	local player_head = { entity.hitbox_position(target, 0) }
	local shooter_cam_to_head = { player_head[1] - shooter_cam[1],player_head[2] - shooter_cam[2],player_head[3] - shooter_cam[3] }
	local shooter_cam_to_shot = { shot[1] - shooter_cam[1], shot[2] - shooter_cam[2],shot[3] - shooter_cam[3]}
	local magic = ((shooter_cam_to_head[1]*shooter_cam_to_shot[1]) + (shooter_cam_to_head[2]*shooter_cam_to_shot[2]) + (shooter_cam_to_head[3]*shooter_cam_to_shot[3])) / (math.pow(shooter_cam_to_shot[1], 2) + math.pow(shooter_cam_to_shot[2], 2) + math.pow(shooter_cam_to_shot[3], 2))
	local closest = { shooter_cam[1] + shooter_cam_to_shot[1]*magic, shooter_cam[2] + shooter_cam_to_shot[2]*magic, shooter_cam[3] + shooter_cam_to_shot[3]*magic}
	local length = math.abs(math.sqrt(math.pow((player_head[1]-closest[1]), 2) + math.pow((player_head[2]-closest[2]), 2) + math.pow((player_head[3]-closest[3]), 2)))
	local frac_shot = client.trace_line(shooter, shot[1], shot[2], shot[3], player_head[1], player_head[2], player_head[3])
	local frac_final = client.trace_line(target, closest[1], closest[2], closest[3], player_head[1], player_head[2], player_head[3])
	return (length < 69) and (frac_shot > 0.99 or frac_final > 0.99)
end

local flags = {
	['H'] = {0, 1},
	['K'] = {1, 2},
	['HK'] = {2, 4},
	['ZOOM'] = {3, 8},
	['BLIND'] = {4, 16},
	['RELOAD'] = {5, 32},
	['C4'] = {6, 64},
	['VIP'] = {7, 128},
	['DEFUSE'] = {8, 256},
	['FD'] = {9, 512},
	['PIN'] = {10, 1024},
	['HIT'] = {11, 2048},
	['O'] = {12, 4096},
	['X'] = {13, 8192},
	['DEF'] = {17, 131072}
}

local function entity_has_flag(entindex, flag_name)
	if not entindex or not flag_name then
		return false
	end

	local flag_data = flags[flag_name]

	if flag_data == nil then
		return false
	end

	local esp_data = entity.get_esp_data(entindex) or {}

	return bit.band(esp_data.flags or 0, bit.lshift(1, flag_data[1])) == flag_data[2]
end
local new_class = function()
	local mt, mt_data, this_mt = { }, { }, { }

	mt.__metatable = false
	mt_data.struct = function(self, name)
		assert(type(name) == 'string', 'invalid class name')
		assert(rawget(self, name) == nil, 'cannot overwrite subclass')

		return function(data)
			assert(type(data) == 'table', 'invalid class data')
			rawset(self, name, setmetatable(data, {
				__metatable = false,
				__index = function(self, key)
					return
						rawget(mt, key) or
						rawget(this_mt, key)
				end
			}))

			return this_mt
		end
	end

	this_mt = setmetatable(mt_data, mt)

	return this_mt
end

local ctx = new_class()
	:struct 'globals' {
		states = {"stand", "slow walk", "run", "duck", "duck move", "jump", "duck jump", "fakelag", "hideshots"},
		extended_states = {"global", "stand", "slow walk", "run", "duck", "duck move", "jump", "duck jump", "fakelag", "hideshots"},
		def_ways = {"1-way", "2-way", "3-way", "4-way", "5-way"},
		teams = {"ct", "t"},
		default_cfg = "{onesense:config}:W3sidGFiIjoiY2ZnIiwidGl0bGVfbmFtZV9jIjoiIzhEOEQ4REZGIn0seyJtYW51YWxfYWEiOnRydWUsIm1hbnVhbF9sZWZ0IjpbMiw5MCwifiJdLCJmcmVlc3RhbmRpbmdfaCI6WzEsMTgsIn4iXSwid2FybXVwX2Rpc2FibGVyIjpmYWxzZSwibWFudWFsX3JpZ2h0IjpbMiw2NywifiJdLCJtb2RlIjoiYnVpbGRlciIsIm1hbnVhbF9mb3J3YXJkIjpbMSwwLCJ+Il0sImVkZ2VfeWF3X2giOlsxLDAsIn4iXSwic3RhdGVzIjp7InQiOnsiaGlkZXNob3RzIjp7ImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDIxIjo4OSwiYm9keV95YXciOiJvZmYiLCJkZWZlbnNpdmVfcGl0Y2hfY2xvY2siOjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDEyIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheTMiOjAsInlhd19qaXR0ZXIiOiJvZmYiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDQiOjEsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDIyIjo4OSwieWF3X2FkZCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQzIjoxLCJkZWZlbnNpdmVfeWF3X3dheV9kZWxheSI6NCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDQiOjgsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQzIjo4LCJkZWZlbnNpdmVfZnJlZXN0YW5kIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjUiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMiI6OCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NDIiOjg5LCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gzIjowLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9yYW5kb20iOjAsImRlZmVuc2l2ZV9waXRjaF93YXkyIjowLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluNCI6ZmFsc2UsImJvZHlfeWF3X3NpZGUiOiJsZWZ0IiwiZGVmZW5zaXZlX3lhdyI6ZmFsc2UsImRlZmVuc2l2ZV9jb25kaXRpb25zIjpbIn4iXSwiZGVmZW5zaXZlX3BpdGNoX3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX3BpdGNoX21vZGUiOiJzdGF0aWMiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMSI6OCwiZW5hYmxlIjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQxIjoxLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjUiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MiI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoNCI6MCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW40IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjEiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gyIjowLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMiI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfaml0dGVyX3JhZGl1cyI6MzAsImRlZmVuc2l2ZV9waXRjaF9zcGluX2xpbWl0MiI6MCwieWF3X2ppdHRlcl9hZGQiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDUiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQzIjowLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfc3Bpbl9saW1pdCI6MzYwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ1MSI6ODksIm9wdGlvbnMiOlsifiJdLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDEiOjAsImRlZmVuc2l2ZV95YXdfaml0dGVyX2RlbGF5Ijo2LCJkZWZlbnNpdmVfeWF3X3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDQiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkNSI6MSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfY3VzdG9tIjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNSI6OCwieWF3X2FkZF9yIjowLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjMiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQxMSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDUyIjo4OSwieWF3X2Jhc2UiOiJhdCB0YXJnZXRzIiwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheTQiOjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMiI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfM3dheV9saW1pdCI6MjUsImRlZmVuc2l2ZV95YXdfd2F5X3JhbmRvbWx5IjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5c3Bpbl9jb21ibyI6IjEtd2F5Iiwiaml0dGVyX2RlbGF5IjoxLCJkZWZlbnNpdmVfeWF3X21vZGUiOiJqaXR0ZXIiLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDIiOjEsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQ1IjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fY29tYm8iOiIxLXdheSIsImRlc3luY19tb2RlIjoiZ2FtZXNlbnNlIiwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjEiOmZhbHNlfSwic2xvdyB3YWxrIjp7ImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDIxIjo4OSwiYm9keV95YXciOiJvZmYiLCJkZWZlbnNpdmVfcGl0Y2hfY2xvY2siOjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDEyIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheTMiOi0xLCJ5YXdfaml0dGVyIjoib2ZmIiwiZGVmZW5zaXZlX3BpdGNoX3dheTUiOjgzLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQzMSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDQxIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9yYW5kb21seV92YWx1ZSI6MjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkNCI6MTIsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDIyIjo4OSwieWF3X2FkZCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQzIjoxMCwiZGVmZW5zaXZlX3lhd193YXlfZGVsYXkiOjQsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ0Ijo4LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMyI6OCwiZGVmZW5zaXZlX2ZyZWVzdGFuZCI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW41IjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDIiOjgsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDQyIjo4OSwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMyI6MTgwLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9yYW5kb20iOjAsImRlZmVuc2l2ZV9waXRjaF93YXkyIjotNDksImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW40IjpmYWxzZSwiYm9keV95YXdfc2lkZSI6ImxlZnQiLCJkZWZlbnNpdmVfeWF3Ijp0cnVlLCJkZWZlbnNpdmVfY29uZGl0aW9ucyI6WyJhbHdheXMiLCJ+Il0sImRlZmVuc2l2ZV9waXRjaF9zcGVlZHRpY2siOjYsImRlZmVuc2l2ZV9waXRjaF9tb2RlIjoiNXdheSIsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQxIjo4LCJlbmFibGUiOnRydWUsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMSI6MiwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW41Ijp0cnVlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MiI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoNCI6OTAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluNCI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3JhbmRvbWx5X3ZhbHVlIjoyMCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4xIjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMiI6OTAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfcmFkaXVzIjozMCwiZGVmZW5zaXZlX3BpdGNoX3NwaW5fbGltaXQyIjowLCJ5YXdfaml0dGVyX2FkZCI6MjQsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDUiOjIxNSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDMiOjM2MCwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjMiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3NwaW5fbGltaXQiOjM2MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NTEiOjg5LCJvcHRpb25zIjpbImRlZmVuc2l2ZS15YXciLCJhbnRpIGJhY2tzdGFiIiwic2FmZSBoZWFkIiwifiJdLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDEiOjM2MCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfZGVsYXkiOjYsImRlZmVuc2l2ZV95YXdfc3BlZWR0aWNrIjo2LCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NCI6MzYwLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDUiOjEwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQzMiI6ODksImRlZmVuc2l2ZV9waXRjaF9jdXN0b20iOjQ5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNSI6OCwieWF3X2FkZF9yIjowLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjMiOnRydWUsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDExIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NTIiOjg5LCJ5YXdfYmFzZSI6ImF0IHRhcmdldHMiLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gxIjoyNDAsImRlZmVuc2l2ZV9waXRjaF93YXk0IjotNjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMiI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfM3dheV9saW1pdCI6MjUsImRlZmVuc2l2ZV95YXdfd2F5X3JhbmRvbWx5IjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZSI6dHJ1ZSwiZGVmZW5zaXZlX3lhd193YXlzcGluX2NvbWJvIjoiMy13YXkiLCJqaXR0ZXJfZGVsYXkiOjEsImRlZmVuc2l2ZV95YXdfbW9kZSI6InN3aXRjaCA1d2F5IiwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQyIjoxLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NSI6MzYwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fY29tYm8iOiIxLXdheSIsImRlc3luY19tb2RlIjoiZ2FtZXNlbnNlIiwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjEiOmZhbHNlfSwiZmFrZWxhZyI6eyJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQyMSI6ODksImJvZHlfeWF3Ijoib2ZmIiwiZGVmZW5zaXZlX3BpdGNoX2Nsb2NrIjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQxMiI6ODksImRlZmVuc2l2ZV9waXRjaF93YXkzIjowLCJ5YXdfaml0dGVyIjoiY2VudGVyIiwiZGVmZW5zaXZlX3BpdGNoX3dheTUiOjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDMxIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NDEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5X3ZhbHVlIjoyMCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ0IjoxLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQyMiI6ODksInlhd19hZGQiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMyI6MSwiZGVmZW5zaXZlX3lhd193YXlfZGVsYXkiOjQsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ0Ijo4LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMyI6OCwiZGVmZW5zaXZlX2ZyZWVzdGFuZCI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW41IjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDIiOjgsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDQyIjo4OSwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMyI6MCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfcmFuZG9tIjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5MiI6MCwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjQiOmZhbHNlLCJib2R5X3lhd19zaWRlIjoibGVmdCIsImRlZmVuc2l2ZV95YXciOmZhbHNlLCJkZWZlbnNpdmVfY29uZGl0aW9ucyI6WyJ+Il0sImRlZmVuc2l2ZV9waXRjaF9zcGVlZHRpY2siOjYsImRlZmVuc2l2ZV9waXRjaF9tb2RlIjoic3RhdGljIiwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDEiOjgsImVuYWJsZSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMSI6MSwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW41IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDIiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDQiOjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluNCI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3JhbmRvbWx5X3ZhbHVlIjoyMCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4xIjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMiI6MCwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjIiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9yYWRpdXMiOjMwLCJkZWZlbnNpdmVfcGl0Y2hfc3Bpbl9saW1pdDIiOjAsInlhd19qaXR0ZXJfYWRkIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g1IjowLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MyI6MCwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjMiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3NwaW5fbGltaXQiOjM2MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NTEiOjg5LCJvcHRpb25zIjpbIn4iXSwiZGVmZW5zaXZlX3BpdGNoX3dheV9yYW5kb21seSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQxIjowLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9kZWxheSI6NiwiZGVmZW5zaXZlX3lhd19zcGVlZHRpY2siOjYsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQ0IjowLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDUiOjEsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDMyIjo4OSwiZGVmZW5zaXZlX3BpdGNoX2N1c3RvbSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDUiOjgsInlhd19hZGRfciI6MCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4zIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MTEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ1MiI6ODksInlhd19iYXNlIjoiYXQgdGFyZ2V0cyIsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDEiOjAsImRlZmVuc2l2ZV9waXRjaF93YXk0IjowLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjIiOmZhbHNlLCJkZWZlbnNpdmVfeWF3XzN3YXlfbGltaXQiOjI1LCJkZWZlbnNpdmVfeWF3X3dheV9yYW5kb21seSI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF9lbmFibGUiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheXNwaW5fY29tYm8iOiIxLXdheSIsImppdHRlcl9kZWxheSI6MSwiZGVmZW5zaXZlX3lhd19tb2RlIjoiaml0dGVyIiwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQyIjoxLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2NvbWJvIjoiMS13YXkiLCJkZXN5bmNfbW9kZSI6ImdhbWVzZW5zZSIsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4xIjpmYWxzZX0sInJ1biI6eyJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQyMSI6ODksImJvZHlfeWF3Ijoib2ZmIiwiZGVmZW5zaXZlX3BpdGNoX2Nsb2NrIjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQxMiI6ODksImRlZmVuc2l2ZV9waXRjaF93YXkzIjowLCJ5YXdfaml0dGVyIjoiY2VudGVyIiwiZGVmZW5zaXZlX3BpdGNoX3dheTUiOjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDMxIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NDEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5X3ZhbHVlIjoyMCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ0IjoxLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQyMiI6ODksInlhd19hZGQiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMyI6MSwiZGVmZW5zaXZlX3lhd193YXlfZGVsYXkiOjQsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ0Ijo4LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMyI6OCwiZGVmZW5zaXZlX2ZyZWVzdGFuZCI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW41IjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDIiOjgsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDQyIjo4OSwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMyI6MCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfcmFuZG9tIjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5MiI6MCwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjQiOmZhbHNlLCJib2R5X3lhd19zaWRlIjoibGVmdCIsImRlZmVuc2l2ZV95YXciOnRydWUsImRlZmVuc2l2ZV9jb25kaXRpb25zIjpbIm9uIGRvcm1hbnQgcGVlayIsIn4iXSwiZGVmZW5zaXZlX3BpdGNoX3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX3BpdGNoX21vZGUiOiJleHBsb2l0W2JldGFdIiwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDEiOjgsImVuYWJsZSI6dHJ1ZSwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQxIjoxLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjUiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MiI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoNCI6MCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW40IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjEiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gyIjowLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMiI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfaml0dGVyX3JhZGl1cyI6MzAsImRlZmVuc2l2ZV9waXRjaF9zcGluX2xpbWl0MiI6MCwieWF3X2ppdHRlcl9hZGQiOjc3LCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g1IjowLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MyI6MCwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjMiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3NwaW5fbGltaXQiOjM2MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NTEiOjg5LCJvcHRpb25zIjpbImRlZmVuc2l2ZS15YXciLCJhbnRpIGJhY2tzdGFiIiwic2FmZSBoZWFkIiwifiJdLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDEiOjAsImRlZmVuc2l2ZV95YXdfaml0dGVyX2RlbGF5Ijo2LCJkZWZlbnNpdmVfeWF3X3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDQiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkNSI6MSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfY3VzdG9tIjotODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ1Ijo4LCJ5YXdfYWRkX3IiOjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDExIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NTIiOjg5LCJ5YXdfYmFzZSI6ImF0IHRhcmdldHMiLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gxIjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NCI6MCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwiZGVmZW5zaXZlX3lhd18zd2F5X2xpbWl0IjoyNSwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHkiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlIjp0cnVlLCJkZWZlbnNpdmVfeWF3X3dheXNwaW5fY29tYm8iOiIxLXdheSIsImppdHRlcl9kZWxheSI6MiwiZGVmZW5zaXZlX3lhd19tb2RlIjoiZXhwbG9pdFttaXNzIGVuZW15XSIsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMiI6MSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDUiOjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9jb21ibyI6IjEtd2F5IiwiZGVzeW5jX21vZGUiOiJnYW1lc2Vuc2UiLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMSI6ZmFsc2V9LCJkdWNrIGp1bXAiOnsiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MjEiOjg5LCJib2R5X3lhdyI6Im9mZiIsImRlZmVuc2l2ZV9waXRjaF9jbG9jayI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MTIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5MyI6LTg5LCJ5YXdfaml0dGVyIjoiY2VudGVyIiwiZGVmZW5zaXZlX3BpdGNoX3dheTUiOi0zLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQzMSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDQxIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9yYW5kb21seV92YWx1ZSI6MjksImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkNCI6MSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MjIiOjg5LCJ5YXdfYWRkIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDMiOjEsImRlZmVuc2l2ZV95YXdfd2F5X2RlbGF5Ijo0LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNCI6MTIsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQzIjo4LCJkZWZlbnNpdmVfZnJlZXN0YW5kIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjUiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMiI6OCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NDIiOi04OSwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMyI6OTAsImRlZmVuc2l2ZV95YXdfaml0dGVyX3JhbmRvbSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheTIiOjAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW40Ijp0cnVlLCJib2R5X3lhd19zaWRlIjoibGVmdCIsImRlZmVuc2l2ZV95YXciOnRydWUsImRlZmVuc2l2ZV9jb25kaXRpb25zIjpbImFsd2F5cyIsIn4iXSwiZGVmZW5zaXZlX3BpdGNoX3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX3BpdGNoX21vZGUiOiI1d2F5IiwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDEiOjEyLCJlbmFibGUiOnRydWUsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMSI6MSwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW41Ijp0cnVlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MiI6MzYwLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g0IjoyNDAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluNCI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3JhbmRvbWx5X3ZhbHVlIjo5MiwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4xIjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMiI6MTgwLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMiI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfaml0dGVyX3JhZGl1cyI6MzAsImRlZmVuc2l2ZV9waXRjaF9zcGluX2xpbWl0MiI6MCwieWF3X2ppdHRlcl9hZGQiOjQxLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g1IjoxODAsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQzIjowLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfc3Bpbl9saW1pdCI6MzYwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ1MSI6ODksIm9wdGlvbnMiOlsiZGVmZW5zaXZlLXlhdyIsImFudGkgYmFja3N0YWIiLCJzYWZlIGhlYWQiLCJ+Il0sImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHkiOnRydWUsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQxIjowLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9kZWxheSI6NiwiZGVmZW5zaXZlX3lhd19zcGVlZHRpY2siOjYsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQ0IjowLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDUiOjUsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDMyIjo4OSwiZGVmZW5zaXZlX3BpdGNoX2N1c3RvbSI6LTg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNSI6OCwieWF3X2FkZF9yIjowLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjMiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQxMSI6LTg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ1MiI6ODksInlhd19iYXNlIjoiYXQgdGFyZ2V0cyIsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDEiOjE4MCwiZGVmZW5zaXZlX3BpdGNoX3dheTQiOjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMiI6dHJ1ZSwiZGVmZW5zaXZlX3lhd18zd2F5X2xpbWl0IjoyOSwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHkiOnRydWUsImRlZmVuc2l2ZV9waXRjaF9lbmFibGUiOnRydWUsImRlZmVuc2l2ZV95YXdfd2F5c3Bpbl9jb21ibyI6IjMtd2F5Iiwiaml0dGVyX2RlbGF5IjoyLCJkZWZlbnNpdmVfeWF3X21vZGUiOiJzd2l0Y2ggNXdheSIsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMiI6NSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDUiOjM2MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2NvbWJvIjoiNC13YXkiLCJkZXN5bmNfbW9kZSI6ImdhbWVzZW5zZSIsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4xIjp0cnVlfSwiZ2xvYmFsIjp7ImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDIxIjo4OSwiYm9keV95YXciOiJvZmYiLCJkZWZlbnNpdmVfcGl0Y2hfY2xvY2siOjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDEyIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheTMiOjAsInlhd19qaXR0ZXIiOiJvZmYiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDQiOjEyLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQyMiI6ODksInlhd19hZGQiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMyI6MTIsImRlZmVuc2l2ZV95YXdfd2F5X2RlbGF5Ijo0LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNCI6OCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDMiOjgsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDUxIjo4OSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjUiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMiI6OCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NDIiOjg5LCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gzIjoxNDYsImRlZmVuc2l2ZV95YXdfaml0dGVyX3JhbmRvbSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheTIiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDEiOjE3OCwiYm9keV95YXdfc2lkZSI6ImxlZnQiLCJkZWZlbnNpdmVfeWF3X3NwZWVkdGljayI6MSwiZGVmZW5zaXZlX2NvbmRpdGlvbnMiOlsiYWx3YXlzIiwifiJdLCJkZWZlbnNpdmVfcGl0Y2hfc3BlZWR0aWNrIjo2LCJkZWZlbnNpdmVfcGl0Y2hfbW9kZSI6IjV3YXkiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ1MiI6ODksImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMSI6MTIsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluNSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQyIjozNjAsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDQiOjI3MSwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW40IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjEiOnRydWUsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDIiOjkwLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMiI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfaml0dGVyX3JhZGl1cyI6MzAsImRlZmVuc2l2ZV9waXRjaF9zcGluX2xpbWl0MiI6MCwieWF3X2ppdHRlcl9hZGQiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDUiOjIyMCwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDMiOjM2MCwiZGVzeW5jX21vZGUiOiJnYW1lc2Vuc2UiLCJkZWZlbnNpdmVfeWF3X3NwaW5fbGltaXQiOjM2MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2NvbWJvIjoiMS13YXkiLCJvcHRpb25zIjpbIn4iXSwiZGVmZW5zaXZlX3BpdGNoX3dheV9yYW5kb21seSI6dHJ1ZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDEiOjE4MSwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfZGVsYXkiOjYsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW40IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDQiOjM2MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ1IjoxMiwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfY3VzdG9tIjotMzYsImRlZmVuc2l2ZV95YXciOmZhbHNlLCJ5YXdfYWRkX3IiOjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMyI6dHJ1ZSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MTEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNSI6OCwieWF3X2Jhc2UiOiJhdCB0YXJnZXRzIiwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDEiOjgsImRlZmVuc2l2ZV9waXRjaF93YXk0IjowLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjIiOmZhbHNlLCJkZWZlbnNpdmVfeWF3XzN3YXlfbGltaXQiOjI1LCJkZWZlbnNpdmVfeWF3X3dheV9yYW5kb21seSI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF9lbmFibGUiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheXNwaW5fY29tYm8iOiIxLXdheSIsImppdHRlcl9kZWxheSI6MSwiZGVmZW5zaXZlX3lhd19tb2RlIjoic3dpdGNoIDV3YXkiLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDIiOjEyLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQ1IjozNjAsImRlZmVuc2l2ZV9mcmVlc3RhbmQiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMSI6ZmFsc2V9LCJzdGFuZCI6eyJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQyMSI6ODksImJvZHlfeWF3Ijoib2ZmIiwiZGVmZW5zaXZlX3BpdGNoX2Nsb2NrIjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQxMiI6ODksImRlZmVuc2l2ZV9waXRjaF93YXkzIjotMSwieWF3X2ppdHRlciI6Im9mZiIsImRlZmVuc2l2ZV9waXRjaF93YXk1IjotODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDMxIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NDEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5X3ZhbHVlIjoyMCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ0IjoxMiwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MjIiOjg5LCJ5YXdfYWRkIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDMiOjQsImRlZmVuc2l2ZV95YXdfd2F5X2RlbGF5IjozLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNCI6OCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDMiOjgsImRlZmVuc2l2ZV9mcmVlc3RhbmQiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluNSI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQyIjo4LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MiI6ODksImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDMiOjE4MCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfcmFuZG9tIjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5MiI6LTU1LCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluNCI6ZmFsc2UsImJvZHlfeWF3X3NpZGUiOiJsZWZ0IiwiZGVmZW5zaXZlX3lhdyI6dHJ1ZSwiZGVmZW5zaXZlX2NvbmRpdGlvbnMiOlsiYWx3YXlzIiwifiJdLCJkZWZlbnNpdmVfcGl0Y2hfc3BlZWR0aWNrIjo2LCJkZWZlbnNpdmVfcGl0Y2hfbW9kZSI6IjV3YXkiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMSI6OCwiZW5hYmxlIjp0cnVlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDEiOjIsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluNSI6dHJ1ZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDIiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDQiOjIxNSwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW40IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjEiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gyIjo5MCwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjIiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9yYWRpdXMiOjMwLCJkZWZlbnNpdmVfcGl0Y2hfc3Bpbl9saW1pdDIiOjAsInlhd19qaXR0ZXJfYWRkIjoyNCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoNSI6MzYwLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MyI6MzYwLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfc3Bpbl9saW1pdCI6MzYwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ1MSI6ODksIm9wdGlvbnMiOlsiZGVmZW5zaXZlLXlhdyIsImFudGkgYmFja3N0YWIiLCJzYWZlIGhlYWQiLCJ+Il0sImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHkiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MSI6MzYwLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9kZWxheSI6NiwiZGVmZW5zaXZlX3lhd19zcGVlZHRpY2siOjYsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQ0IjozNjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkNSI6MiwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfY3VzdG9tIjo0OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDUiOjgsInlhd19hZGRfciI6MCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4zIjp0cnVlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQxMSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDUyIjo4OSwieWF3X2Jhc2UiOiJhdCB0YXJnZXRzIiwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMSI6MjQwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NCI6LTYwLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjIiOmZhbHNlLCJkZWZlbnNpdmVfeWF3XzN3YXlfbGltaXQiOjI1LCJkZWZlbnNpdmVfeWF3X3dheV9yYW5kb21seSI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF9lbmFibGUiOnRydWUsImRlZmVuc2l2ZV95YXdfd2F5c3Bpbl9jb21ibyI6IjUtd2F5Iiwiaml0dGVyX2RlbGF5IjoxLCJkZWZlbnNpdmVfeWF3X21vZGUiOiJzd2l0Y2ggNXdheSIsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMiI6MSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDUiOjM2MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2NvbWJvIjoiNC13YXkiLCJkZXN5bmNfbW9kZSI6ImdhbWVzZW5zZSIsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4xIjpmYWxzZX0sImR1Y2siOnsiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MjEiOjg5LCJib2R5X3lhdyI6Im9mZiIsImRlZmVuc2l2ZV9waXRjaF9jbG9jayI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MTIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5MyI6LTEsInlhd19qaXR0ZXIiOiJvZmYiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NSI6MzksImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDMxIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NDEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5X3ZhbHVlIjoyMCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ0Ijo3LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQyMiI6ODksInlhd19hZGQiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMyI6NCwiZGVmZW5zaXZlX3lhd193YXlfZGVsYXkiOjIsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ0Ijo4LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMyI6OCwiZGVmZW5zaXZlX2ZyZWVzdGFuZCI6dHJ1ZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjUiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMiI6OCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NDIiOjg5LCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gzIjoyNDAsImRlZmVuc2l2ZV95YXdfaml0dGVyX3JhbmRvbSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheTIiOi02MSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjQiOmZhbHNlLCJib2R5X3lhd19zaWRlIjoibGVmdCIsImRlZmVuc2l2ZV95YXciOnRydWUsImRlZmVuc2l2ZV9jb25kaXRpb25zIjpbImFsd2F5cyIsIn4iXSwiZGVmZW5zaXZlX3BpdGNoX3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX3BpdGNoX21vZGUiOiI1d2F5IiwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDEiOjgsImVuYWJsZSI6dHJ1ZSwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQxIjo1LCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjUiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MiI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoNCI6OTAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluNCI6dHJ1ZSwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjEiOnRydWUsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDIiOjE2MCwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjIiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9yYWRpdXMiOjMwLCJkZWZlbnNpdmVfcGl0Y2hfc3Bpbl9saW1pdDIiOjAsInlhd19qaXR0ZXJfYWRkIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g1IjozMDAsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQzIjozNjAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4zIjpmYWxzZSwiZGVmZW5zaXZlX3lhd19zcGluX2xpbWl0IjozNjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDUxIjo4OSwib3B0aW9ucyI6WyJkZWZlbnNpdmUteWF3IiwiYW50aSBiYWNrc3RhYiIsInNhZmUgaGVhZCIsIn4iXSwiZGVmZW5zaXZlX3BpdGNoX3dheV9yYW5kb21seSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQxIjoyNTAsImRlZmVuc2l2ZV95YXdfaml0dGVyX2RlbGF5Ijo2LCJkZWZlbnNpdmVfeWF3X3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDQiOjM2MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ1IjoxLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQzMiI6ODksImRlZmVuc2l2ZV9waXRjaF9jdXN0b20iOjYwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNSI6OCwieWF3X2FkZF9yIjowLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjMiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQxMSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDUyIjo4OSwieWF3X2Jhc2UiOiJhdCB0YXJnZXRzIiwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMSI6MjQwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NCI6LTMwLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjIiOmZhbHNlLCJkZWZlbnNpdmVfeWF3XzN3YXlfbGltaXQiOjI1LCJkZWZlbnNpdmVfeWF3X3dheV9yYW5kb21seSI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF9lbmFibGUiOnRydWUsImRlZmVuc2l2ZV95YXdfd2F5c3Bpbl9jb21ibyI6IjQtd2F5Iiwiaml0dGVyX2RlbGF5IjoxLCJkZWZlbnNpdmVfeWF3X21vZGUiOiJzd2l0Y2ggNXdheSIsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMiI6MSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDUiOjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9jb21ibyI6IjEtd2F5IiwiZGVzeW5jX21vZGUiOiJnYW1lc2Vuc2UiLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMSI6ZmFsc2V9LCJkdWNrIG1vdmUiOnsiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MjEiOjg5LCJib2R5X3lhdyI6Im9mZiIsImRlZmVuc2l2ZV9waXRjaF9jbG9jayI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MTIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5MyI6LTEsInlhd19qaXR0ZXIiOiJvZmYiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NSI6ODMsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDMxIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NDEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5X3ZhbHVlIjoyMCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ0IjoxMiwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MjIiOjg5LCJ5YXdfYWRkIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDMiOjEwLCJkZWZlbnNpdmVfeWF3X3dheV9kZWxheSI6NCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDQiOjgsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQzIjo4LCJkZWZlbnNpdmVfZnJlZXN0YW5kIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjUiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMiI6OCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NDIiOjg5LCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gzIjoxODAsImRlZmVuc2l2ZV95YXdfaml0dGVyX3JhbmRvbSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheTIiOi04OSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjQiOmZhbHNlLCJib2R5X3lhd19zaWRlIjoibGVmdCIsImRlZmVuc2l2ZV95YXciOnRydWUsImRlZmVuc2l2ZV9jb25kaXRpb25zIjpbImFsd2F5cyIsIn4iXSwiZGVmZW5zaXZlX3BpdGNoX3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX3BpdGNoX21vZGUiOiI1d2F5IiwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDEiOjgsImVuYWJsZSI6dHJ1ZSwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQxIjoyLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjUiOnRydWUsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQyIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g0Ijo5MCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW40IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjEiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gyIjo5MCwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjIiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9yYWRpdXMiOjMwLCJkZWZlbnNpdmVfcGl0Y2hfc3Bpbl9saW1pdDIiOjAsInlhd19qaXR0ZXJfYWRkIjoyNCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoNSI6MjE1LCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MyI6MzYwLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfc3Bpbl9saW1pdCI6MzYwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ1MSI6ODksIm9wdGlvbnMiOlsiZGVmZW5zaXZlLXlhdyIsImFudGkgYmFja3N0YWIiLCJzYWZlIGhlYWQiLCJ+Il0sImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHkiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MSI6MzYwLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9kZWxheSI6NiwiZGVmZW5zaXZlX3lhd19zcGVlZHRpY2siOjYsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQ0IjozNjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkNSI6MTAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDMyIjo4OSwiZGVmZW5zaXZlX3BpdGNoX2N1c3RvbSI6NDksImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ1Ijo4LCJ5YXdfYWRkX3IiOjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMyI6dHJ1ZSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MTEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ1MiI6ODksInlhd19iYXNlIjoiYXQgdGFyZ2V0cyIsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDEiOjI0MCwiZGVmZW5zaXZlX3BpdGNoX3dheTQiOi02MCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwiZGVmZW5zaXZlX3lhd18zd2F5X2xpbWl0IjoyNSwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHkiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlIjp0cnVlLCJkZWZlbnNpdmVfeWF3X3dheXNwaW5fY29tYm8iOiIxLXdheSIsImppdHRlcl9kZWxheSI6MSwiZGVmZW5zaXZlX3lhd19tb2RlIjoic3dpdGNoIDV3YXkiLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDIiOjEsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQ1IjozNjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9jb21ibyI6IjUtd2F5IiwiZGVzeW5jX21vZGUiOiJnYW1lc2Vuc2UiLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMSI6ZmFsc2V9LCJqdW1wIjp7ImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDIxIjo4OSwiYm9keV95YXciOiJvZmYiLCJkZWZlbnNpdmVfcGl0Y2hfY2xvY2siOjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDEyIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheTMiOi04OSwieWF3X2ppdHRlciI6ImNlbnRlciIsImRlZmVuc2l2ZV9waXRjaF93YXk1IjotMywiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHlfdmFsdWUiOjI5LCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDQiOjEsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDIyIjo4OSwieWF3X2FkZCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQzIjoxLCJkZWZlbnNpdmVfeWF3X3dheV9kZWxheSI6NCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDQiOjEyLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMyI6OCwiZGVmZW5zaXZlX2ZyZWVzdGFuZCI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW41IjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDIiOjgsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDQyIjotODksImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDMiOjkwLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9yYW5kb20iOjAsImRlZmVuc2l2ZV9waXRjaF93YXkyIjowLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluNCI6dHJ1ZSwiYm9keV95YXdfc2lkZSI6ImxlZnQiLCJkZWZlbnNpdmVfeWF3Ijp0cnVlLCJkZWZlbnNpdmVfY29uZGl0aW9ucyI6WyJhbHdheXMiLCJ+Il0sImRlZmVuc2l2ZV9waXRjaF9zcGVlZHRpY2siOjYsImRlZmVuc2l2ZV9waXRjaF9tb2RlIjoiNXdheSIsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQxIjoxMiwiZW5hYmxlIjp0cnVlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDEiOjEsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluNSI6dHJ1ZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDIiOjM2MCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoNCI6MjQwLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjQiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9yYW5kb21seV92YWx1ZSI6OTIsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDIiOjE4MCwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjIiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9yYWRpdXMiOjMwLCJkZWZlbnNpdmVfcGl0Y2hfc3Bpbl9saW1pdDIiOjAsInlhd19qaXR0ZXJfYWRkIjo0MSwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoNSI6MTgwLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MyI6MCwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjMiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3NwaW5fbGltaXQiOjM2MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NTEiOjg5LCJvcHRpb25zIjpbImRlZmVuc2l2ZS15YXciLCJhbnRpIGJhY2tzdGFiIiwic2FmZSBoZWFkIiwifiJdLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5Ijp0cnVlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MSI6MCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfZGVsYXkiOjYsImRlZmVuc2l2ZV95YXdfc3BlZWR0aWNrIjo2LCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ1Ijo1LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQzMiI6ODksImRlZmVuc2l2ZV9waXRjaF9jdXN0b20iOi04OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDUiOjgsInlhd19hZGRfciI6MCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4zIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MTEiOi04OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NTIiOjg5LCJ5YXdfYmFzZSI6ImF0IHRhcmdldHMiLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gxIjoxODAsImRlZmVuc2l2ZV9waXRjaF93YXk0IjowLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjIiOnRydWUsImRlZmVuc2l2ZV95YXdfM3dheV9saW1pdCI6MjksImRlZmVuc2l2ZV95YXdfd2F5X3JhbmRvbWx5Ijp0cnVlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlIjp0cnVlLCJkZWZlbnNpdmVfeWF3X3dheXNwaW5fY29tYm8iOiIzLXdheSIsImppdHRlcl9kZWxheSI6MiwiZGVmZW5zaXZlX3lhd19tb2RlIjoic3dpdGNoIDV3YXkiLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDIiOjUsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQ1IjozNjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9jb21ibyI6IjQtd2F5IiwiZGVzeW5jX21vZGUiOiJnYW1lc2Vuc2UiLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMSI6dHJ1ZX19LCJjdCI6eyJoaWRlc2hvdHMiOnsiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MjEiOjg5LCJib2R5X3lhdyI6Im9mZiIsImRlZmVuc2l2ZV9waXRjaF9jbG9jayI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MTIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5MyI6MCwieWF3X2ppdHRlciI6Im9mZiIsImRlZmVuc2l2ZV9waXRjaF93YXk1IjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQzMSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDQxIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9yYW5kb21seV92YWx1ZSI6MjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkNCI6MSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MjIiOjg5LCJ5YXdfYWRkIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDMiOjEsImRlZmVuc2l2ZV95YXdfd2F5X2RlbGF5Ijo0LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNCI6OCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDMiOjgsImRlZmVuc2l2ZV9mcmVlc3RhbmQiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluNSI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQyIjo4LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MiI6ODksImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDMiOjAsImRlZmVuc2l2ZV95YXdfaml0dGVyX3JhbmRvbSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheTIiOjAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW40IjpmYWxzZSwiYm9keV95YXdfc2lkZSI6ImxlZnQiLCJkZWZlbnNpdmVfeWF3IjpmYWxzZSwiZGVmZW5zaXZlX2NvbmRpdGlvbnMiOlsifiJdLCJkZWZlbnNpdmVfcGl0Y2hfc3BlZWR0aWNrIjo2LCJkZWZlbnNpdmVfcGl0Y2hfbW9kZSI6InN0YXRpYyIsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQxIjo4LCJlbmFibGUiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDEiOjEsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluNSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQyIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g0IjowLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjQiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9yYW5kb21seV92YWx1ZSI6MjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDIiOjAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfcmFkaXVzIjozMCwiZGVmZW5zaXZlX3BpdGNoX3NwaW5fbGltaXQyIjowLCJ5YXdfaml0dGVyX2FkZCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoNSI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDMiOjAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4zIjpmYWxzZSwiZGVmZW5zaXZlX3lhd19zcGluX2xpbWl0IjozNjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDUxIjo4OSwib3B0aW9ucyI6WyJ+Il0sImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHkiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MSI6MCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfZGVsYXkiOjYsImRlZmVuc2l2ZV95YXdfc3BlZWR0aWNrIjo2LCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ1IjoxLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQzMiI6ODksImRlZmVuc2l2ZV9waXRjaF9jdXN0b20iOjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ1Ijo4LCJ5YXdfYWRkX3IiOjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDExIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NTIiOjg5LCJ5YXdfYmFzZSI6ImF0IHRhcmdldHMiLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gxIjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NCI6MCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwiZGVmZW5zaXZlX3lhd18zd2F5X2xpbWl0IjoyNSwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHkiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlIjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlzcGluX2NvbWJvIjoiMS13YXkiLCJqaXR0ZXJfZGVsYXkiOjEsImRlZmVuc2l2ZV95YXdfbW9kZSI6ImppdHRlciIsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMiI6MSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDUiOjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9jb21ibyI6IjEtd2F5IiwiZGVzeW5jX21vZGUiOiJnYW1lc2Vuc2UiLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMSI6ZmFsc2V9LCJzbG93IHdhbGsiOnsiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MjEiOjg5LCJib2R5X3lhdyI6Im9mZiIsImRlZmVuc2l2ZV9waXRjaF9jbG9jayI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MTIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5MyI6LTEsInlhd19qaXR0ZXIiOiJvZmYiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NSI6ODMsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDMxIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NDEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5X3ZhbHVlIjoyMCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ0IjoxMiwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MjIiOjg5LCJ5YXdfYWRkIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDMiOjEwLCJkZWZlbnNpdmVfeWF3X3dheV9kZWxheSI6NCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDQiOjgsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQzIjo4LCJkZWZlbnNpdmVfZnJlZXN0YW5kIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjUiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMiI6OCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NDIiOjg5LCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gzIjoxODAsImRlZmVuc2l2ZV95YXdfaml0dGVyX3JhbmRvbSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheTIiOi00OSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjQiOmZhbHNlLCJib2R5X3lhd19zaWRlIjoibGVmdCIsImRlZmVuc2l2ZV95YXciOnRydWUsImRlZmVuc2l2ZV9jb25kaXRpb25zIjpbImFsd2F5cyIsIn4iXSwiZGVmZW5zaXZlX3BpdGNoX3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX3BpdGNoX21vZGUiOiI1d2F5IiwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDEiOjgsImVuYWJsZSI6dHJ1ZSwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQxIjoyLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjUiOnRydWUsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQyIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g0Ijo5MCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW40IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjEiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gyIjo5MCwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjIiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9yYWRpdXMiOjMwLCJkZWZlbnNpdmVfcGl0Y2hfc3Bpbl9saW1pdDIiOjAsInlhd19qaXR0ZXJfYWRkIjoyNCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoNSI6MjE1LCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MyI6MzYwLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfc3Bpbl9saW1pdCI6MzYwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ1MSI6ODksIm9wdGlvbnMiOlsiZGVmZW5zaXZlLXlhdyIsImFudGkgYmFja3N0YWIiLCJzYWZlIGhlYWQiLCJ+Il0sImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHkiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MSI6MzYwLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9kZWxheSI6NiwiZGVmZW5zaXZlX3lhd19zcGVlZHRpY2siOjYsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQ0IjozNjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkNSI6MTAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDMyIjo4OSwiZGVmZW5zaXZlX3BpdGNoX2N1c3RvbSI6NDksImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ1Ijo4LCJ5YXdfYWRkX3IiOjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMyI6dHJ1ZSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MTEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ1MiI6ODksInlhd19iYXNlIjoiYXQgdGFyZ2V0cyIsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDEiOjI0MCwiZGVmZW5zaXZlX3BpdGNoX3dheTQiOi02MCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwiZGVmZW5zaXZlX3lhd18zd2F5X2xpbWl0IjoyNSwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHkiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlIjp0cnVlLCJkZWZlbnNpdmVfeWF3X3dheXNwaW5fY29tYm8iOiIzLXdheSIsImppdHRlcl9kZWxheSI6MSwiZGVmZW5zaXZlX3lhd19tb2RlIjoic3dpdGNoIDV3YXkiLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDIiOjEsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQ1IjozNjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9jb21ibyI6IjEtd2F5IiwiZGVzeW5jX21vZGUiOiJnYW1lc2Vuc2UiLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMSI6ZmFsc2V9LCJmYWtlbGFnIjp7ImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDIxIjo4OSwiYm9keV95YXciOiJvZmYiLCJkZWZlbnNpdmVfcGl0Y2hfY2xvY2siOjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDEyIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheTMiOjAsInlhd19qaXR0ZXIiOiJjZW50ZXIiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDQiOjEsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDIyIjo4OSwieWF3X2FkZCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQzIjoxLCJkZWZlbnNpdmVfeWF3X3dheV9kZWxheSI6NCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDQiOjgsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQzIjo4LCJkZWZlbnNpdmVfZnJlZXN0YW5kIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjUiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMiI6OCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NDIiOjg5LCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gzIjowLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9yYW5kb20iOjAsImRlZmVuc2l2ZV9waXRjaF93YXkyIjowLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluNCI6ZmFsc2UsImJvZHlfeWF3X3NpZGUiOiJsZWZ0IiwiZGVmZW5zaXZlX3lhdyI6ZmFsc2UsImRlZmVuc2l2ZV9jb25kaXRpb25zIjpbIn4iXSwiZGVmZW5zaXZlX3BpdGNoX3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX3BpdGNoX21vZGUiOiJzdGF0aWMiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMSI6OCwiZW5hYmxlIjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQxIjoxLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjUiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MiI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoNCI6MCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW40IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjEiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gyIjowLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMiI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfaml0dGVyX3JhZGl1cyI6MzAsImRlZmVuc2l2ZV9waXRjaF9zcGluX2xpbWl0MiI6MCwieWF3X2ppdHRlcl9hZGQiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDUiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQzIjowLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfc3Bpbl9saW1pdCI6MzYwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ1MSI6ODksIm9wdGlvbnMiOlsifiJdLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDEiOjAsImRlZmVuc2l2ZV95YXdfaml0dGVyX2RlbGF5Ijo2LCJkZWZlbnNpdmVfeWF3X3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDQiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkNSI6MSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfY3VzdG9tIjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNSI6OCwieWF3X2FkZF9yIjowLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjMiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQxMSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDUyIjo4OSwieWF3X2Jhc2UiOiJhdCB0YXJnZXRzIiwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheTQiOjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMiI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfM3dheV9saW1pdCI6MjUsImRlZmVuc2l2ZV95YXdfd2F5X3JhbmRvbWx5IjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5c3Bpbl9jb21ibyI6IjEtd2F5Iiwiaml0dGVyX2RlbGF5IjoxLCJkZWZlbnNpdmVfeWF3X21vZGUiOiJqaXR0ZXIiLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDIiOjEsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQ1IjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fY29tYm8iOiIxLXdheSIsImRlc3luY19tb2RlIjoiZ2FtZXNlbnNlIiwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjEiOmZhbHNlfSwicnVuIjp7ImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDIxIjo4OSwiYm9keV95YXciOiJvZmYiLCJkZWZlbnNpdmVfcGl0Y2hfY2xvY2siOjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDEyIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheTMiOjAsInlhd19qaXR0ZXIiOiJjZW50ZXIiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDQiOjEsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDIyIjo4OSwieWF3X2FkZCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQzIjoxLCJkZWZlbnNpdmVfeWF3X3dheV9kZWxheSI6NCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDQiOjgsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQzIjo4LCJkZWZlbnNpdmVfZnJlZXN0YW5kIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjUiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMiI6OCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NDIiOjg5LCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gzIjowLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9yYW5kb20iOjAsImRlZmVuc2l2ZV9waXRjaF93YXkyIjowLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluNCI6ZmFsc2UsImJvZHlfeWF3X3NpZGUiOiJsZWZ0IiwiZGVmZW5zaXZlX3lhdyI6dHJ1ZSwiZGVmZW5zaXZlX2NvbmRpdGlvbnMiOlsib24gZG9ybWFudCBwZWVrIiwifiJdLCJkZWZlbnNpdmVfcGl0Y2hfc3BlZWR0aWNrIjo2LCJkZWZlbnNpdmVfcGl0Y2hfbW9kZSI6ImV4cGxvaXRbYmV0YV0iLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMSI6OCwiZW5hYmxlIjp0cnVlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDEiOjEsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluNSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQyIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g0IjowLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjQiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9yYW5kb21seV92YWx1ZSI6MjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDIiOjAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfcmFkaXVzIjozMCwiZGVmZW5zaXZlX3BpdGNoX3NwaW5fbGltaXQyIjowLCJ5YXdfaml0dGVyX2FkZCI6NzcsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDUiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQzIjowLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfc3Bpbl9saW1pdCI6MzYwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ1MSI6ODksIm9wdGlvbnMiOlsiZGVmZW5zaXZlLXlhdyIsImFudGkgYmFja3N0YWIiLCJzYWZlIGhlYWQiLCJ+Il0sImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHkiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MSI6MCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfZGVsYXkiOjYsImRlZmVuc2l2ZV95YXdfc3BlZWR0aWNrIjo2LCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ1IjoxLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQzMiI6ODksImRlZmVuc2l2ZV9waXRjaF9jdXN0b20iOi04OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDUiOjgsInlhd19hZGRfciI6MCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4zIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MTEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ1MiI6ODksInlhd19iYXNlIjoiYXQgdGFyZ2V0cyIsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDEiOjAsImRlZmVuc2l2ZV9waXRjaF93YXk0IjowLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjIiOmZhbHNlLCJkZWZlbnNpdmVfeWF3XzN3YXlfbGltaXQiOjI1LCJkZWZlbnNpdmVfeWF3X3dheV9yYW5kb21seSI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF9lbmFibGUiOnRydWUsImRlZmVuc2l2ZV95YXdfd2F5c3Bpbl9jb21ibyI6IjEtd2F5Iiwiaml0dGVyX2RlbGF5IjoyLCJkZWZlbnNpdmVfeWF3X21vZGUiOiJleHBsb2l0W21pc3MgZW5lbXldIiwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQyIjoxLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2NvbWJvIjoiMS13YXkiLCJkZXN5bmNfbW9kZSI6ImdhbWVzZW5zZSIsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4xIjpmYWxzZX0sImR1Y2sganVtcCI6eyJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQyMSI6ODksImJvZHlfeWF3Ijoib2ZmIiwiZGVmZW5zaXZlX3BpdGNoX2Nsb2NrIjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQxMiI6ODksImRlZmVuc2l2ZV9waXRjaF93YXkzIjotODksInlhd19qaXR0ZXIiOiJjZW50ZXIiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NSI6LTMsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDMxIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NDEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5X3ZhbHVlIjoyOSwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ0IjoxLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQyMiI6ODksInlhd19hZGQiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMyI6MSwiZGVmZW5zaXZlX3lhd193YXlfZGVsYXkiOjQsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ0IjoxMiwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDMiOjgsImRlZmVuc2l2ZV9mcmVlc3RhbmQiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluNSI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQyIjo4LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MiI6LTg5LCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gzIjo5MCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfcmFuZG9tIjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5MiI6MCwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjQiOnRydWUsImJvZHlfeWF3X3NpZGUiOiJsZWZ0IiwiZGVmZW5zaXZlX3lhdyI6dHJ1ZSwiZGVmZW5zaXZlX2NvbmRpdGlvbnMiOlsiYWx3YXlzIiwifiJdLCJkZWZlbnNpdmVfcGl0Y2hfc3BlZWR0aWNrIjo2LCJkZWZlbnNpdmVfcGl0Y2hfbW9kZSI6IjV3YXkiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMSI6MTIsImVuYWJsZSI6dHJ1ZSwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQxIjoxLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjUiOnRydWUsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQyIjozNjAsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDQiOjI0MCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW40IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHlfdmFsdWUiOjkyLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjEiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gyIjoxODAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfcmFkaXVzIjozMCwiZGVmZW5zaXZlX3BpdGNoX3NwaW5fbGltaXQyIjowLCJ5YXdfaml0dGVyX2FkZCI6NDEsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDUiOjE4MCwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDMiOjAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4zIjpmYWxzZSwiZGVmZW5zaXZlX3lhd19zcGluX2xpbWl0IjozNjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDUxIjo4OSwib3B0aW9ucyI6WyJkZWZlbnNpdmUteWF3IiwiYW50aSBiYWNrc3RhYiIsInNhZmUgaGVhZCIsIn4iXSwiZGVmZW5zaXZlX3BpdGNoX3dheV9yYW5kb21seSI6dHJ1ZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDEiOjAsImRlZmVuc2l2ZV95YXdfaml0dGVyX2RlbGF5Ijo2LCJkZWZlbnNpdmVfeWF3X3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDQiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkNSI6NSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfY3VzdG9tIjotODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ1Ijo4LCJ5YXdfYWRkX3IiOjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDExIjotODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDUyIjo4OSwieWF3X2Jhc2UiOiJhdCB0YXJnZXRzIiwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMSI6MTgwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NCI6MCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4yIjp0cnVlLCJkZWZlbnNpdmVfeWF3XzN3YXlfbGltaXQiOjI5LCJkZWZlbnNpdmVfeWF3X3dheV9yYW5kb21seSI6dHJ1ZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZSI6dHJ1ZSwiZGVmZW5zaXZlX3lhd193YXlzcGluX2NvbWJvIjoiMy13YXkiLCJqaXR0ZXJfZGVsYXkiOjIsImRlZmVuc2l2ZV95YXdfbW9kZSI6InN3aXRjaCA1d2F5IiwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQyIjo1LCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NSI6MzYwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fY29tYm8iOiI0LXdheSIsImRlc3luY19tb2RlIjoiZ2FtZXNlbnNlIiwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjEiOnRydWV9LCJnbG9iYWwiOnsiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MjEiOjg5LCJib2R5X3lhdyI6Im9mZiIsImRlZmVuc2l2ZV9waXRjaF9jbG9jayI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MTIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5MyI6MCwieWF3X2ppdHRlciI6Im9mZiIsImRlZmVuc2l2ZV9waXRjaF93YXk1IjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQzMSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDQxIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9yYW5kb21seV92YWx1ZSI6MjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkNCI6MTIsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDIyIjo4OSwieWF3X2FkZCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQzIjoxMiwiZGVmZW5zaXZlX3lhd193YXlfZGVsYXkiOjQsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ0Ijo4LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMyI6OCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NTEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluNSI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQyIjo4LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MiI6ODksImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDMiOjE0NiwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfcmFuZG9tIjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5MiI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMSI6MTc4LCJib2R5X3lhd19zaWRlIjoibGVmdCIsImRlZmVuc2l2ZV95YXdfc3BlZWR0aWNrIjoxLCJkZWZlbnNpdmVfY29uZGl0aW9ucyI6WyJhbHdheXMiLCJ+Il0sImRlZmVuc2l2ZV9waXRjaF9zcGVlZHRpY2siOjYsImRlZmVuc2l2ZV9waXRjaF9tb2RlIjoiNXdheSIsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDUyIjo4OSwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQxIjoxMiwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW41IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDIiOjM2MCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoNCI6MjcxLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjQiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9yYW5kb21seV92YWx1ZSI6MjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMSI6dHJ1ZSwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMiI6OTAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfcmFkaXVzIjozMCwiZGVmZW5zaXZlX3BpdGNoX3NwaW5fbGltaXQyIjowLCJ5YXdfaml0dGVyX2FkZCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoNSI6MjIwLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MyI6MzYwLCJkZXN5bmNfbW9kZSI6ImdhbWVzZW5zZSIsImRlZmVuc2l2ZV95YXdfc3Bpbl9saW1pdCI6MzYwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fY29tYm8iOiIxLXdheSIsIm9wdGlvbnMiOlsifiJdLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5Ijp0cnVlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MSI6MTgxLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9kZWxheSI6NiwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjQiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NCI6MzYwLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDUiOjEyLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQzMiI6ODksImRlZmVuc2l2ZV9waXRjaF9jdXN0b20iOi0zNiwiZGVmZW5zaXZlX3lhdyI6ZmFsc2UsInlhd19hZGRfciI6MCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4zIjp0cnVlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQxMSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ1Ijo4LCJ5YXdfYmFzZSI6ImF0IHRhcmdldHMiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMSI6OCwiZGVmZW5zaXZlX3BpdGNoX3dheTQiOjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMiI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfM3dheV9saW1pdCI6MjUsImRlZmVuc2l2ZV95YXdfd2F5X3JhbmRvbWx5IjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5c3Bpbl9jb21ibyI6IjEtd2F5Iiwiaml0dGVyX2RlbGF5IjoxLCJkZWZlbnNpdmVfeWF3X21vZGUiOiJzd2l0Y2ggNXdheSIsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMiI6MTIsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4zIjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDUiOjM2MCwiZGVmZW5zaXZlX2ZyZWVzdGFuZCI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4xIjpmYWxzZX0sInN0YW5kIjp7ImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDIxIjo4OSwiYm9keV95YXciOiJvZmYiLCJkZWZlbnNpdmVfcGl0Y2hfY2xvY2siOjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDEyIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheTMiOi0xLCJ5YXdfaml0dGVyIjoib2ZmIiwiZGVmZW5zaXZlX3BpdGNoX3dheTUiOi04OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDQiOjEyLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQyMiI6ODksInlhd19hZGQiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMyI6NCwiZGVmZW5zaXZlX3lhd193YXlfZGVsYXkiOjMsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ0Ijo4LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMyI6OCwiZGVmZW5zaXZlX2ZyZWVzdGFuZCI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW41IjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDIiOjgsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDQyIjo4OSwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMyI6MTgwLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9yYW5kb20iOjAsImRlZmVuc2l2ZV9waXRjaF93YXkyIjotNTUsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW40IjpmYWxzZSwiYm9keV95YXdfc2lkZSI6ImxlZnQiLCJkZWZlbnNpdmVfeWF3Ijp0cnVlLCJkZWZlbnNpdmVfY29uZGl0aW9ucyI6WyJhbHdheXMiLCJ+Il0sImRlZmVuc2l2ZV9waXRjaF9zcGVlZHRpY2siOjYsImRlZmVuc2l2ZV9waXRjaF9tb2RlIjoiNXdheSIsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQxIjo4LCJlbmFibGUiOnRydWUsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMSI6MiwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW41Ijp0cnVlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MiI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoNCI6MjE1LCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjQiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9yYW5kb21seV92YWx1ZSI6MjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDIiOjkwLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMiI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfaml0dGVyX3JhZGl1cyI6MzAsImRlZmVuc2l2ZV9waXRjaF9zcGluX2xpbWl0MiI6MCwieWF3X2ppdHRlcl9hZGQiOjI0LCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g1IjozNjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQzIjozNjAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4zIjpmYWxzZSwiZGVmZW5zaXZlX3lhd19zcGluX2xpbWl0IjozNjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDUxIjo4OSwib3B0aW9ucyI6WyJkZWZlbnNpdmUteWF3IiwiYW50aSBiYWNrc3RhYiIsInNhZmUgaGVhZCIsIn4iXSwiZGVmZW5zaXZlX3BpdGNoX3dheV9yYW5kb21seSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQxIjozNjAsImRlZmVuc2l2ZV95YXdfaml0dGVyX2RlbGF5Ijo2LCJkZWZlbnNpdmVfeWF3X3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDQiOjM2MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ1IjoyLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQzMiI6ODksImRlZmVuc2l2ZV9waXRjaF9jdXN0b20iOjQ5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNSI6OCwieWF3X2FkZF9yIjowLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjMiOnRydWUsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDExIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NTIiOjg5LCJ5YXdfYmFzZSI6ImF0IHRhcmdldHMiLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gxIjoyNDAsImRlZmVuc2l2ZV9waXRjaF93YXk0IjotNjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMiI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfM3dheV9saW1pdCI6MjUsImRlZmVuc2l2ZV95YXdfd2F5X3JhbmRvbWx5IjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZSI6dHJ1ZSwiZGVmZW5zaXZlX3lhd193YXlzcGluX2NvbWJvIjoiNS13YXkiLCJqaXR0ZXJfZGVsYXkiOjEsImRlZmVuc2l2ZV95YXdfbW9kZSI6InN3aXRjaCA1d2F5IiwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQyIjoxLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NSI6MzYwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fY29tYm8iOiI0LXdheSIsImRlc3luY19tb2RlIjoiZ2FtZXNlbnNlIiwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjEiOmZhbHNlfSwiZHVjayI6eyJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQyMSI6ODksImJvZHlfeWF3Ijoib2ZmIiwiZGVmZW5zaXZlX3BpdGNoX2Nsb2NrIjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQxMiI6ODksImRlZmVuc2l2ZV9waXRjaF93YXkzIjotMSwieWF3X2ppdHRlciI6Im9mZiIsImRlZmVuc2l2ZV9waXRjaF93YXk1IjozOSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDQiOjcsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDIyIjo4OSwieWF3X2FkZCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQzIjo0LCJkZWZlbnNpdmVfeWF3X3dheV9kZWxheSI6MiwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDQiOjgsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQzIjo4LCJkZWZlbnNpdmVfZnJlZXN0YW5kIjp0cnVlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluNSI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQyIjo4LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MiI6ODksImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDMiOjI0MCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfcmFuZG9tIjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5MiI6LTYxLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluNCI6ZmFsc2UsImJvZHlfeWF3X3NpZGUiOiJsZWZ0IiwiZGVmZW5zaXZlX3lhdyI6dHJ1ZSwiZGVmZW5zaXZlX2NvbmRpdGlvbnMiOlsiYWx3YXlzIiwifiJdLCJkZWZlbnNpdmVfcGl0Y2hfc3BlZWR0aWNrIjo2LCJkZWZlbnNpdmVfcGl0Y2hfbW9kZSI6IjV3YXkiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMSI6OCwiZW5hYmxlIjp0cnVlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDEiOjUsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluNSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQyIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g0Ijo5MCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW40Ijp0cnVlLCJkZWZlbnNpdmVfeWF3X3dheV9yYW5kb21seV92YWx1ZSI6MjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMSI6dHJ1ZSwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMiI6MTYwLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMiI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfaml0dGVyX3JhZGl1cyI6MzAsImRlZmVuc2l2ZV9waXRjaF9zcGluX2xpbWl0MiI6MCwieWF3X2ppdHRlcl9hZGQiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDUiOjMwMCwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDMiOjM2MCwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjMiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3NwaW5fbGltaXQiOjM2MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NTEiOjg5LCJvcHRpb25zIjpbImRlZmVuc2l2ZS15YXciLCJhbnRpIGJhY2tzdGFiIiwic2FmZSBoZWFkIiwifiJdLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDEiOjI1MCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfZGVsYXkiOjYsImRlZmVuc2l2ZV95YXdfc3BlZWR0aWNrIjo2LCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NCI6MzYwLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDUiOjEsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDMyIjo4OSwiZGVmZW5zaXZlX3BpdGNoX2N1c3RvbSI6NjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ1Ijo4LCJ5YXdfYWRkX3IiOjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDExIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NTIiOjg5LCJ5YXdfYmFzZSI6ImF0IHRhcmdldHMiLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gxIjoyNDAsImRlZmVuc2l2ZV9waXRjaF93YXk0IjotMzAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMiI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfM3dheV9saW1pdCI6MjUsImRlZmVuc2l2ZV95YXdfd2F5X3JhbmRvbWx5IjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZSI6dHJ1ZSwiZGVmZW5zaXZlX3lhd193YXlzcGluX2NvbWJvIjoiNC13YXkiLCJqaXR0ZXJfZGVsYXkiOjEsImRlZmVuc2l2ZV95YXdfbW9kZSI6InN3aXRjaCA1d2F5IiwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQyIjoxLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2NvbWJvIjoiMS13YXkiLCJkZXN5bmNfbW9kZSI6ImdhbWVzZW5zZSIsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4xIjpmYWxzZX0sImR1Y2sgbW92ZSI6eyJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQyMSI6ODksImJvZHlfeWF3Ijoib2ZmIiwiZGVmZW5zaXZlX3BpdGNoX2Nsb2NrIjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQxMiI6ODksImRlZmVuc2l2ZV9waXRjaF93YXkzIjotMSwieWF3X2ppdHRlciI6Im9mZiIsImRlZmVuc2l2ZV9waXRjaF93YXk1Ijo4MywiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDQiOjEyLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQyMiI6ODksInlhd19hZGQiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMyI6MTAsImRlZmVuc2l2ZV95YXdfd2F5X2RlbGF5Ijo0LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNCI6OCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDMiOjgsImRlZmVuc2l2ZV9mcmVlc3RhbmQiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluNSI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQyIjo4LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MiI6ODksImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDMiOjE4MCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfcmFuZG9tIjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5MiI6LTg5LCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluNCI6ZmFsc2UsImJvZHlfeWF3X3NpZGUiOiJsZWZ0IiwiZGVmZW5zaXZlX3lhdyI6dHJ1ZSwiZGVmZW5zaXZlX2NvbmRpdGlvbnMiOlsiYWx3YXlzIiwifiJdLCJkZWZlbnNpdmVfcGl0Y2hfc3BlZWR0aWNrIjo2LCJkZWZlbnNpdmVfcGl0Y2hfbW9kZSI6IjV3YXkiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMSI6OCwiZW5hYmxlIjp0cnVlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDEiOjIsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluNSI6dHJ1ZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDIiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDQiOjkwLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjQiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9yYW5kb21seV92YWx1ZSI6MjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDIiOjkwLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMiI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfaml0dGVyX3JhZGl1cyI6MzAsImRlZmVuc2l2ZV9waXRjaF9zcGluX2xpbWl0MiI6MCwieWF3X2ppdHRlcl9hZGQiOjI0LCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g1IjoyMTUsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQzIjozNjAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4zIjpmYWxzZSwiZGVmZW5zaXZlX3lhd19zcGluX2xpbWl0IjozNjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDUxIjo4OSwib3B0aW9ucyI6WyJkZWZlbnNpdmUteWF3IiwiYW50aSBiYWNrc3RhYiIsInNhZmUgaGVhZCIsIn4iXSwiZGVmZW5zaXZlX3BpdGNoX3dheV9yYW5kb21seSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQxIjozNjAsImRlZmVuc2l2ZV95YXdfaml0dGVyX2RlbGF5Ijo2LCJkZWZlbnNpdmVfeWF3X3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDQiOjM2MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ1IjoxMCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfY3VzdG9tIjo0OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDUiOjgsInlhd19hZGRfciI6MCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4zIjp0cnVlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQxMSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDUyIjo4OSwieWF3X2Jhc2UiOiJhdCB0YXJnZXRzIiwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMSI6MjQwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NCI6LTYwLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjIiOmZhbHNlLCJkZWZlbnNpdmVfeWF3XzN3YXlfbGltaXQiOjI1LCJkZWZlbnNpdmVfeWF3X3dheV9yYW5kb21seSI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF9lbmFibGUiOnRydWUsImRlZmVuc2l2ZV95YXdfd2F5c3Bpbl9jb21ibyI6IjEtd2F5Iiwiaml0dGVyX2RlbGF5IjoxLCJkZWZlbnNpdmVfeWF3X21vZGUiOiJzd2l0Y2ggNXdheSIsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMiI6MSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDUiOjM2MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2NvbWJvIjoiNS13YXkiLCJkZXN5bmNfbW9kZSI6ImdhbWVzZW5zZSIsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4xIjpmYWxzZX0sImp1bXAiOnsiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MjEiOjg5LCJib2R5X3lhdyI6Im9mZiIsImRlZmVuc2l2ZV9waXRjaF9jbG9jayI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MTIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5MyI6LTg5LCJ5YXdfaml0dGVyIjoiY2VudGVyIiwiZGVmZW5zaXZlX3BpdGNoX3dheTUiOi0zLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQzMSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDQxIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9yYW5kb21seV92YWx1ZSI6MjksImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkNCI6MSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MjIiOjg5LCJ5YXdfYWRkIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDMiOjEsImRlZmVuc2l2ZV95YXdfd2F5X2RlbGF5Ijo0LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNCI6MTIsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQzIjo4LCJkZWZlbnNpdmVfZnJlZXN0YW5kIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjUiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMiI6OCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NDIiOi04OSwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMyI6OTAsImRlZmVuc2l2ZV95YXdfaml0dGVyX3JhbmRvbSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheTIiOjAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW40Ijp0cnVlLCJib2R5X3lhd19zaWRlIjoibGVmdCIsImRlZmVuc2l2ZV95YXciOnRydWUsImRlZmVuc2l2ZV9jb25kaXRpb25zIjpbImFsd2F5cyIsIn4iXSwiZGVmZW5zaXZlX3BpdGNoX3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX3BpdGNoX21vZGUiOiI1d2F5IiwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDEiOjEyLCJlbmFibGUiOnRydWUsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMSI6MSwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW41Ijp0cnVlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MiI6MzYwLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g0IjoyNDAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluNCI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3JhbmRvbWx5X3ZhbHVlIjo5MiwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4xIjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMiI6MTgwLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMiI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfaml0dGVyX3JhZGl1cyI6MzAsImRlZmVuc2l2ZV9waXRjaF9zcGluX2xpbWl0MiI6MCwieWF3X2ppdHRlcl9hZGQiOjQxLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g1IjoxODAsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQzIjowLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfc3Bpbl9saW1pdCI6MzYwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ1MSI6ODksIm9wdGlvbnMiOlsiZGVmZW5zaXZlLXlhdyIsImFudGkgYmFja3N0YWIiLCJzYWZlIGhlYWQiLCJ+Il0sImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHkiOnRydWUsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQxIjowLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9kZWxheSI6NiwiZGVmZW5zaXZlX3lhd19zcGVlZHRpY2siOjYsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQ0IjowLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDUiOjUsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDMyIjo4OSwiZGVmZW5zaXZlX3BpdGNoX2N1c3RvbSI6LTg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNSI6OCwieWF3X2FkZF9yIjowLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjMiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQxMSI6LTg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ1MiI6ODksInlhd19iYXNlIjoiYXQgdGFyZ2V0cyIsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDEiOjE4MCwiZGVmZW5zaXZlX3BpdGNoX3dheTQiOjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMiI6dHJ1ZSwiZGVmZW5zaXZlX3lhd18zd2F5X2xpbWl0IjoyOSwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHkiOnRydWUsImRlZmVuc2l2ZV9waXRjaF9lbmFibGUiOnRydWUsImRlZmVuc2l2ZV95YXdfd2F5c3Bpbl9jb21ibyI6IjMtd2F5Iiwiaml0dGVyX2RlbGF5IjoyLCJkZWZlbnNpdmVfeWF3X21vZGUiOiJzd2l0Y2ggNXdheSIsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMiI6NSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDUiOjM2MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2NvbWJvIjoiNC13YXkiLCJkZXN5bmNfbW9kZSI6ImdhbWVzZW5zZSIsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4xIjp0cnVlfX19LCJleHBvcnRfZnJvbSI6InNlbGVjdGVkIHRlYW0iLCJ0ZWFtIjoiY3QiLCJzdGF0ZSI6ImR1Y2sganVtcCIsImZyZWVzdGFuZGluZyI6WyJmb3JjZSBzdGF0aWMiLCJ+Il0sImZyZWVzdGFuZGluZ19kaXNhYmxlcnMiOlsifiJdLCJleHBvcnRfdG8iOiJvcHBvc2l0ZSB0ZWFtIn0seyJhbmltYXRpb25zX3BpdGNoIjpmYWxzZSwicHJlZGljdGVkX2NoZWNrIjp0cnVlLCJhbmltYXRpb25zX2JvZHkiOjIsInRyYXNodGFsa19jdXN0b20iOiIiLCJwcmVkaWN0ZWRfc2xpZGVyIjoyLCJ0cmFzaHRhbGtfY2hlY2syIjp0cnVlLCJ0cmFzaHRhbGsiOnRydWUsImFuaW1hdGlvbnNfc2VsZWN0b3IiOlsiYm9keSBsZWFuIiwic3RhdGljIGxlZ3MiLCJqaXR0ZXIgbGVncyBvbiBhaXIiLCJqaXR0ZXIgbGVncyBvbiBsYW5kaW5nIiwifiJdLCJwcmVkaWN0ZWRfY2hlY2tfaCI6WzAsODYsIn4iXSwidHJhc2h0YWxrX3R5cGUiOiIxIE1PRCIsImFuaW1hdGlvbnMiOnRydWV9LHsibm90aWZ5X3ZpYm9yIjpbImJsdXJlZCIsImhpdCIsIm1pc3MiLCJnZXQgaGFybWVkIiwic2hvdCBvcHBvbmVudCIsIn4iXSwiaW5kaWNhdG9yb2Zmc2V0IjoyNSwiaW5kaWNhdG9yX2RtZ193ZWFwb24iOmZhbHNlLCJpbmRpY2F0b3JzIjpmYWxzZSwiaW5kaWNhdG9yX2RtZyI6dHJ1ZSwid2F0ZXJtYXJrX3BvcyI6ImRvd24iLCJub3RpZnlfZ2xvdyI6MjMsIndhdGVybWFya19zdHlsZXMiOiJuZXciLCJub3RpZnlfbWFzdGVyIjp0cnVlLCJub3RpZnlfdGVzdF9uYW1lMSI6IiIsImluZGljYXRvcl9kbWdfYyI6IiNGRkZGRkZGRiIsIm5vdGlmeV9vZmZzZXQiOjQ1LCJiYWNrX3NsaWRlciI6MzcsIm5vdGlmeV90ZXN0X25hbWUyIjoiIiwiYmFja19tIjp0cnVlLCJiYWNrX2JveCI6ImJsYWNrb3V0IiwiaW5kaWNhdG9yZm9udCI6InNtYWxsIiwiaW5kaWNhdG9yX2V4dGVuZGVkIjpmYWxzZSwid2F0ZXJtYXJrX3NwYWNlcyI6dHJ1ZX1d",
		in_ladder = 0,
		def_ways_count = 0,
		nade = 0,
		SECRET_NUMBER = 0,
		ways2 = {},
	}

	:struct 'ref' {
		aa = {
			enabled = {ui.reference("aa", "anti-aimbot angles", "enabled")},
			pitch = {ui.reference("aa", "anti-aimbot angles", "pitch")},
			yaw_base = {ui.reference("aa", "anti-aimbot angles", "Yaw base")},
			yaw = {ui.reference("aa", "anti-aimbot angles", "Yaw")},
			yaw_jitter = {ui.reference("aa", "anti-aimbot angles", "Yaw Jitter")},
			body_yaw = {ui.reference("aa", "anti-aimbot angles", "Body yaw")},
			freestanding_body_yaw = {ui.reference("aa", "anti-aimbot angles", "Freestanding body yaw")},
			freestand = {ui.reference("aa", "anti-aimbot angles", "Freestanding")},
			roll = {ui.reference("aa", "anti-aimbot angles", "Roll")},
			edge_yaw = {ui.reference("aa", "anti-aimbot angles", "Edge yaw")},
			fake_peek = {ui.reference("aa", "other", "Fake peek")},
		},
		misc = {
			knife = {ui.reference("misc", "miscellaneous", "Knifebot")}, 
			clantag =  {ui.reference("misc", "miscellaneous", "Clan tag spammer")}, 
		},
		fakelag = {
			enable = {ui.reference("aa", "fake lag", "enabled")},
			amount = {ui.reference("aa", "fake lag", "amount")},
			variance = {ui.reference("aa", "fake lag", "variance")},
			limit = {ui.reference("aa", "fake lag", "limit")},
		},
		aa_other = {
			sw = {ui.reference("aa", "other", "Slow motion")},
			lg = {ui.reference("aa", "other", "Leg movement")},
			hide_shots = {ui.reference("aa", "other", "On shot anti-aim")},
		},
		rage = {
			dt = {ui.reference("rage", "aimbot", "Double tap")},
			dt_limit = {ui.reference("rage", "aimbot", "Double tap fake lag limit")},
			fd = {ui.reference("rage", "other", "Duck peek assist")},
			os = {ui.reference("aa", "other", "On shot anti-aim")},
			silent = {ui.reference("rage", "Other", "Silent aim")},
			quickpeek = {ui.reference("RAGE", "Other", "Quick peek assist")},
			quickpeek2 = {ui.reference("RAGE", "Other", "Quick peek assist mode")},
			mindmg = {ui.reference('rage', 'aimbot', 'minimum damage')},
			ovr = {ui.reference('rage', 'aimbot', 'minimum damage override')}
		},
		slow_motion = {ui.reference("aa", "other", "Slow motion")},
	}

	:struct 'ui' {
		menu = {
			global = {},
			antiaim = {},
			tools = {},
			cfg = {}
		},

		execute = function(self)
			local group = pui.group("AA", "anti-aimbot angles")
			local group_fl = pui.group("AA", "Fake lag")
			local debug_group = pui.group("AA", "Other")
			local space_text = "\a373737FF‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"

			local p_c = "\a808080FF•\r  "
			local p_d = "\a808080FF—\r  "

			self.menu.global.title_name = group:label("\bA4D2D4\bffadb4[O N E S E N S E]\n", {164, 210, 212})
			self.menu.global.tab = group:combobox("\n tabs", {"antiaim", "tools", "cfg"})

			-- aa
			self.menu.antiaim.mode = group:combobox(p_c.."selected ~ \aA4D2D4FFtab", {"builder", "binds-fl"})

			self.menu.antiaim.space_teweaks = group:label(space_text):depend({self.menu.antiaim.mode, "binds-fl"})
			self.menu.antiaim.freestanding = group:multiselect(p_c.."freestanding", {"force static", "activate disablers"}, 0x0):depend({self.menu.antiaim.mode, "binds-fl"})
			self.menu.antiaim.freestanding_disablers = group:multiselect("\nfreestanding disablers", self.globals.states):depend({self.menu.antiaim.freestanding, "activate disablers"}):depend({self.menu.antiaim.mode, "binds-fl"})

			self.menu.antiaim.edge_yaw = group:label("edge \aA4D2D4FFyaw", 0x0):depend({self.menu.antiaim.mode, "binds-fl"})

			self.menu.antiaim.manual_aa = group:checkbox("manual aa"):depend({self.menu.antiaim.mode, "binds-fl"})
			self.menu.antiaim.manual_left = group:hotkey(p_c.."manual\aA4D2D4FF left"):depend({self.menu.antiaim.manual_aa, true}):depend({self.menu.antiaim.mode, "binds-fl"})
			self.menu.antiaim.manual_right = group:hotkey(p_c.."manual\aA4D2D4FF right"):depend({self.menu.antiaim.manual_aa, true}):depend({self.menu.antiaim.mode, "binds-fl"})
			self.menu.antiaim.manual_forward = group:hotkey(p_c.."manual\aA4D2D4FF forward"):depend({self.menu.antiaim.manual_aa, true}):depend({self.menu.antiaim.mode, "binds-fl"})
			self.menu.antiaim.warmup_disabler = group:checkbox("warmup aa"):depend({self.menu.antiaim.mode, "binds-fl"})

			self.menu.antiaim.state = group:combobox(p_c.."condition", self.globals.extended_states):depend({self.menu.antiaim.mode, "builder"})
			self.menu.antiaim.team = group:combobox("\nteam", self.globals.teams):depend({self.menu.antiaim.mode, "builder"})

			self.menu.antiaim.states = {}

			for _, team in ipairs(self.globals.teams) do
				self.menu.antiaim.states[team] = {}
				for _, state in ipairs(self.globals.extended_states) do
					self.menu.antiaim.states[team][state] = {}
					local menu = self.menu.antiaim.states[team][state]

					if state ~= "global" then
						menu.enable = group:checkbox("activate \aA4D2D4FF" .. state .. "\n" .. team)
					end

					local state_team = "\a666666ff ~ \r\aA4D2D4FF" .. state .. " \r\a808080FF(" .. team .. ")"

					menu.options = debug_group:multiselect(p_c.."tweaks" .. state_team, {'defensive-yaw', 'anti backstab', 'safe head'})
					menu.options2 = debug_group:label(space_text)
					menu.defensive_conditions = group_fl:multiselect("defensive triggers" .. state_team, {'always', 'on weapon switch', 'on reload', 'on hittable', 'on dormant peek', 'on freestand'}):depend({menu.options, 'defensive-yaw'})
					menu.defensive_yaw = group:checkbox("defensive yaw" .. state_team):depend({menu.options, 'defensive-yaw'})--data.defensive_yaw_mode
					menu.defensive_yaw_mode = group:combobox("\ndefensive yaw mode" .. state_team, {'jitter', 'custom spin', '3, 4, 5 way', 'exploit[miss enemy]', 'switch 5way'}):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true})

					menu.defensive_yaw_jitter_radius= group:slider("\n radius of the jitter" .. state_team, -180, 180, 30, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "jitter"})
					menu.defensive_yaw_jitter_delay = group:slider(p_c .. "delayed" .. state_team, 1, 12, 6, true, "t", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "jitter"})
					menu.defensive_yaw_jitter_random= group:slider(p_c .. "randomize" .. state_team, 0, 180, 0, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "jitter"})

					--#start
					menu.defensive_yaw_way_switch1 = group:slider("\n way-1" .. state_team, 0, 360, 30, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_yaw_way_switch2 = group:slider("\n way-2" .. state_team, 0, 360, 30, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_yaw_way_switch3 = group:slider("\n way-3" .. state_team, 0, 360, 30, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_yaw_way_switch4 = group:slider("\n way-4" .. state_team, 0, 360, 30, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_yaw_way_switch5 = group:slider("\n way-5" .. state_team, 0, 360, 30, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"})
					
					menu.defensive_yaw_way_randomly = group:checkbox(p_c.."increase yaw (random) " .. state_team):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_yaw_way_randomly_value = group:slider("\n ramdom yaw value" .. state_team, 0, 360, 20, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"}, {menu.defensive_yaw_way_randomly, true})

					menu.defensive_yaw_way_delay = group:slider(p_c.."interpolation (delay)" .. state_team, 0, 16, 4, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"})

					menu.defensive_yaw_wayspin_combo = group:combobox(p_c.."select spin way yaw" .. state_team, self.globals.def_ways):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"})
					
					menu.defensive_yaw_enable_way_spin1 = group:checkbox("enable spin \n 1" .. state_team):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"}, {menu.defensive_yaw_wayspin_combo, "1-way"})
					menu.defensive_yaw_way_spin_limit1 = group:slider("\n limit  way-1 " .. state_team, 0, 360, 0, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"}, {menu.defensive_yaw_enable_way_spin1, true}, {menu.defensive_yaw_wayspin_combo, "1-way"})
					menu.defensive_yaw_way_speed1 = group:slider("\n speed way-1 " .. state_team, 1, 12, 8, true, "t", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"}, {menu.defensive_yaw_enable_way_spin1, true}, {menu.defensive_yaw_wayspin_combo, "1-way"})
					
					menu.defensive_yaw_enable_way_spin2 = group:checkbox("enable spin \n 2" .. state_team):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"}, {menu.defensive_yaw_wayspin_combo, "2-way"})
					menu.defensive_yaw_way_spin_limit2 = group:slider("\n limit  way-2 " .. state_team, 0, 360, 0, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"}, {menu.defensive_yaw_enable_way_spin2, true}, {menu.defensive_yaw_wayspin_combo, "2-way"})
					menu.defensive_yaw_way_speed2 = group:slider("\n speed way-2 " .. state_team, 1, 12, 8, true, "t", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"}, {menu.defensive_yaw_enable_way_spin2, true}, {menu.defensive_yaw_wayspin_combo, "2-way"})

					menu.defensive_yaw_enable_way_spin3 = group:checkbox("enable spin \n 3 " .. state_team):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"}, {menu.defensive_yaw_wayspin_combo, "3-way"})
					menu.defensive_yaw_way_spin_limit3 = group:slider("\n limit  way-3 " .. state_team, 0, 360, 0, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"}, {menu.defensive_yaw_enable_way_spin3, true}, {menu.defensive_yaw_wayspin_combo, "3-way"})
					menu.defensive_yaw_way_speed3 = group:slider("\n speed way-3 " .. state_team, 1, 12, 8, true, "t", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"}, {menu.defensive_yaw_enable_way_spin3, true}, {menu.defensive_yaw_wayspin_combo, "3-way"})

					menu.defensive_yaw_enable_way_spin4 = group:checkbox("enable spin \n 4 " .. state_team):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"}, {menu.defensive_yaw_wayspin_combo, "4-way"})
					menu.defensive_yaw_way_spin_limit4 = group:slider("\n limit  way-4 " .. state_team, 0, 360, 0, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"}, {menu.defensive_yaw_enable_way_spin4, true}, {menu.defensive_yaw_wayspin_combo, "4-way"})
					menu.defensive_yaw_way_speed4 = group:slider("\n speed way-4 " .. state_team, 1, 12, 8, true, "t", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"}, {menu.defensive_yaw_enable_way_spin4, true}, {menu.defensive_yaw_wayspin_combo, "4-way"})

					menu.defensive_yaw_enable_way_spin5 = group:checkbox("enable spin \n 5 " .. state_team):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"}, {menu.defensive_yaw_wayspin_combo, "5-way"})
					menu.defensive_yaw_way_spin_limit5 = group:slider("\n limit  way-5 " .. state_team, 0, 360, 0, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"}, {menu.defensive_yaw_enable_way_spin5, true}, {menu.defensive_yaw_wayspin_combo, "5-way"})
					menu.defensive_yaw_way_speed5 = group:slider("\n speed way-5 " .. state_team, 1, 12, 8, true, "t", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "switch 5way"}, {menu.defensive_yaw_enable_way_spin5, true}, {menu.defensive_yaw_wayspin_combo, "5-way"})
					--#end
					
					menu.defensive_yaw_spin_limit = group:slider("\n limit spin" .. state_team, 15, 360, 360, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}):depend({menu.defensive_yaw_mode, "custom spin"})
					menu.defensive_yaw_3way_limit = group:slider("\n limit wayssss" .. state_team, 10, 29, 25, true, "°", 1, {[10] = "4-way", [25] = "3-way", [29] = "5-way", [14] = "5-way"}):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "3, 4, 5 way"})

					menu.defensive_yaw_speedtick = group:slider("\n spin speed" .. state_team, 1, 12, 6, true, "t", 0.5):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true}, {menu.defensive_yaw_mode, "custom spin"})

					menu.defensive_pitch_enable = group_fl:checkbox("defensive pitch"  .. state_team):depend({menu.options, 'defensive-yaw'})
					menu.defensive_pitch_mode = group_fl:combobox("\n defensive pitch mode" .. state_team, {'static', 'spin', 'exploit[beta]', 'clock (jitter)', '5way'}):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable, true})
					
					menu.defensive_pitch_spin_limit2 = group_fl:slider("\n spin speed 2" .. state_team, -89, 89, 0, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "spin"})

					--#start
					menu.defensive_pitch_custom = group_fl:slider("\n pitch custom limit" .. state_team, -89, 89, 0, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable, true})
					
					menu.defensive_pitch_speedtick = group_fl:slider("\n spin speed" .. state_team, 0, 12, 6, true, "t", 0.5):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "spin"})

					menu.defensive_pitch_way2 = group_fl:slider("\n pitch way 2" .. state_team, -89, 89, 0, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_pitch_way3 = group_fl:slider("\n pitch way 3" .. state_team, -89, 89, 0, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_pitch_way4 = group_fl:slider("\n pitch way 4" .. state_team, -89, 89, 0, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_pitch_way5 = group_fl:slider("\n pitch way 5" .. state_team, -89, 89, 0, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					
					menu.defensive_pitch_way_randomly = group_fl:checkbox(p_c.."increase pitch (random) " .. state_team):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_pitch_way_randomly_value = group_fl:slider("\n ramdom pitch value" .. state_team, -89, 89, 20, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}, {menu.defensive_pitch_way_randomly, true}):depend({menu.defensive_yaw_mode, "switch 5way"})

					menu.defensive_pitch_way_spin_combo = group_fl:combobox(p_c.."select spin way pitch" .. state_team, self.globals.def_ways):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					
					menu.defensive_pitch_enable_way_spin1 = group_fl:checkbox("enable spin \n 1" .. state_team):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}, {menu.defensive_pitch_way_spin_combo, "1-way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_pitch_way_spin_limit11 = group_fl:slider("\n limit  way-11 " .. state_team, -89, 89, 89, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable_way_spin1, true}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}, {menu.defensive_pitch_way_spin_combo, "1-way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_pitch_way_spin_limit12 = group_fl:slider("\n limit  way-12 " .. state_team, -89, 89, 89, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable_way_spin1, true}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}, {menu.defensive_pitch_way_spin_combo, "1-way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_pitch_way_speed1 = group_fl:slider("\n speed way-1 " .. state_team, 1, 12, 8, true, "t", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable_way_spin1, true}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}, {menu.defensive_pitch_way_spin_combo, "1-way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					
					menu.defensive_pitch_enable_way_spin2 = group_fl:checkbox("enable spin \n 2" .. state_team):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}, {menu.defensive_pitch_way_spin_combo, "2-way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_pitch_way_spin_limit21 = group_fl:slider("\n limit  way-21 " .. state_team, -89, 89, 89, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable_way_spin2, true}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}, {menu.defensive_pitch_way_spin_combo, "2-way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_pitch_way_spin_limit22 = group_fl:slider("\n limit  way-22 " .. state_team, -89, 89, 89, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable_way_spin2, true}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}, {menu.defensive_pitch_way_spin_combo, "2-way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_pitch_way_speed2 = group_fl:slider("\n speed way-2 " .. state_team, 1, 12, 8, true, "t", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable_way_spin2, true}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}, {menu.defensive_pitch_way_spin_combo, "2-way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					
					menu.defensive_pitch_enable_way_spin3 = group_fl:checkbox("enable spin \n 3" .. state_team):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}, {menu.defensive_pitch_way_spin_combo, "3-way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_pitch_way_spin_limit31 = group_fl:slider("\n limit  way-31 " .. state_team, -89, 89, 89, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable_way_spin3, true}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}, {menu.defensive_pitch_way_spin_combo, "3-way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_pitch_way_spin_limit32 = group_fl:slider("\n limit  way-32 " .. state_team, -89, 89, 89, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable_way_spin3, true}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}, {menu.defensive_pitch_way_spin_combo, "3-way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_pitch_way_speed3 = group_fl:slider("\n speed way-3 " .. state_team, 1, 12, 8, true, "t", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable_way_spin3, true}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}, {menu.defensive_pitch_way_spin_combo, "3-way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					
					menu.defensive_pitch_enable_way_spin4 = group_fl:checkbox("enable spin \n 4" .. state_team):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}, {menu.defensive_pitch_way_spin_combo, "4-way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_pitch_way_spin_limit41 = group_fl:slider("\n limit  way-41 " .. state_team, -89, 89, 89, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable_way_spin4, true}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}, {menu.defensive_pitch_way_spin_combo, "4-way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_pitch_way_spin_limit42 = group_fl:slider("\n limit  way-42 " .. state_team, -89, 89, 89, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable_way_spin4, true}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}, {menu.defensive_pitch_way_spin_combo, "4-way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_pitch_way_speed4 = group_fl:slider("\n speed way-4 " .. state_team, 1, 12, 8, true, "t", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable_way_spin4, true}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}, {menu.defensive_pitch_way_spin_combo, "4-way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					
					menu.defensive_pitch_enable_way_spin5 = group_fl:checkbox("enable spin \n 5" .. state_team):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}, {menu.defensive_pitch_way_spin_combo, "5-way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_pitch_way_spin_limit51 = group_fl:slider("\n limit  way-51 " .. state_team, -89, 89, 89, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable_way_spin5, true}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}, {menu.defensive_pitch_way_spin_combo, "5-way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					menu.defensive_pitch_way_spin_limit52 = group_fl:slider("\n limit  way-52 " .. state_team, -89, 89, 89, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable_way_spin5, true}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}, {menu.defensive_pitch_way_spin_combo, "5-way"}):depend({menu.defensive_yaw_mode, "switch 5way"})

					menu.defensive_pitch_way_speed5 = group_fl:slider("\n speed way-5 " .. state_team, 1, 12, 8, true, "t", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable_way_spin5, true}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "5way"}, {menu.defensive_pitch_way_spin_combo, "5-way"}):depend({menu.defensive_yaw_mode, "switch 5way"})
					-- #end
					menu.defensive_pitch_clock = group_fl:slider("\n pitch clock limit" .. state_team, -89, 89, 0, true, "°", 1):depend({menu.options, 'defensive-yaw'}, {menu.defensive_pitch_enable, true}, {menu.defensive_pitch_mode, "clock (jitter)"})

					menu.defensive_freestand = group:checkbox("defensive freestand" .. state_team):depend({menu.options, 'defensive-yaw'}, {menu.defensive_yaw, true})

          			menu.space = group:label(space_text):depend({self.menu.antiaim.mode, "builder"})

					menu.yaw_base = group:combobox(p_c.."yaw" .. state_team, {"at targets", "local view"})
          			menu.yaw_jitter = group:combobox("\nyaw jitter" .. state_team, {"off", "offset", "center", "random", "skitter"})
					menu.yaw_jitter_add = group:slider("\nyaw jitter add" .. state .. team, -180, 180, 0, true, "°", 1):depend({menu.yaw_jitter, "off", true})
					menu.yaw_add = group:slider(p_c.."yaw add (left/right)" .. state_team, -180, 180, 0, true, "°", 1)
					menu.yaw_add_r = group:slider("\n yaw add (r)" .. state_team, -180, 180, 0, true, "°", 1)

					menu.jitter_delay = group:slider(p_c..'yaw delay' .. state_team, 0, 4, 1, true, 'x', 1, {[1] = 'Randomly', [0] = 'Off'})

          			menu.space2 = group:label(space_text):depend({self.menu.antiaim.mode, "builder"})

          			menu.desync_mode = group:combobox(p_c.."fake person" .. state_team, {'gamesense', 'onesense'})
					menu.body_yaw = group:combobox("\n body yaw" .. state_team, {"off", "opposite", "static", "jitter"})
					menu.body_yaw_side = group:combobox(p_c..'body yaw side' .. state_team, {'left', 'right', 'freestanding'}):depend({menu.body_yaw, "static", false})

					for _, v in pairs(menu) do
						local arr =  { {self.menu.antiaim.state, state}, {self.menu.antiaim.team, team}, {self.menu.antiaim.mode, "builder"} }
						if _ ~= "enable" and state ~= "global" then
							arr =  { {self.menu.antiaim.state, state}, {self.menu.antiaim.team, team}, {self.menu.antiaim.mode, "builder"}, {menu.enable, true} }
						end

							v:depend(table.unpack(arr))
							end
						end
					end

				self.menu.antiaim.export_from = debug_group:combobox(p_d.."\aA4D2D4FFexport:", {"selected condition", "selected team"}):depend({self.menu.antiaim.mode, "builder"})
				self.menu.antiaim.export_to = debug_group:combobox(p_d.."\aA4D2D4FFto:", {"opposite team", "clipboard"}):depend({self.menu.antiaim.mode, "builder"})
				self.menu.antiaim.export = debug_group:button("export", function ()
					local type = "team"
					local team = self.menu.antiaim.team:get() == "ct" and "t" or "ct"
					if self.menu.antiaim.export_from:get() == "selected condition" then
						type = "state"
					end

					data = self.config:export(type, self.menu.antiaim.team:get(), self.menu.antiaim.state:get())

					if self.menu.antiaim.export_to:get() == "clipboard" then
						clipboard.set(data)
					else
						self.config:import(data, type, team, self.menu.antiaim.state:get())
					end
				end):depend({self.menu.antiaim.mode, "builder"})
				self.menu.antiaim.import = debug_group:button("import", function ()
					local data = clipboard.get()
					local type = data:match("{onesense:(.+)}")
							self.config:import(data, type, self.menu.antiaim.team:get(), self.menu.antiaim.state:get())
				end):depend({self.menu.antiaim.mode, "builder"})

			local x, y = client.screen_size()
			local up_vertical = -y + y-28
			local down_vertical = y-y+833

			self.menu.tools.subtub = group_fl:combobox(p_c.."active tab", {"tools","misc"})

			local tab = self.menu.tools.subtub

			self.menu.tools.spas4 = group_fl:label(space_text):depend({tab, "tools"})
			self.menu.tools.watermark_styles = group_fl:combobox(p_c.."watermark(style)", {"onesense","new"}):depend({tab, "tools"})
			self.menu.tools.watermark_pos = group_fl:combobox("\n watermark position", {"down", "left", "right"}):depend({self.menu.tools.watermark_styles, "new"}):depend({tab, "tools"})
			self.menu.tools.watermark_spaces = group_fl:checkbox("without spaces"):depend({self.menu.tools.watermark_styles, "new"}):depend({tab, "tools"})

			self.menu.tools.indicators = group:checkbox("crosshair indicators"):depend({tab, "tools"})
			self.menu.tools.indicatorfont = group:combobox(p_c .. "indicator font", {"small", "normal", "bold"}):depend({self.menu.tools.indicators, true}):depend({tab, "tools"})
			self.menu.tools.indicatoroffset = group:slider("\n offset indcator ", -90, 90, 25, true, "px", 0.1):depend({self.menu.tools.indicators, true}):depend({tab, "tools"})
			self.menu.tools.indicator_extended = group:checkbox(p_c .. "indicator follows the speed, etc."):depend({self.menu.tools.indicators, true}):depend({tab, "tools"})
			self.menu.tools.indicator1337 = group:label(space_text):depend({self.menu.tools.indicators, true}):depend({tab, "tools"})

			self.menu.tools.indicator_dmg = group:checkbox("damage indicator", {255, 255, 255}):depend({tab, "tools"})
			self.menu.tools.indicator_dmg_weapon = group:checkbox(p_c .. "only min damage"):depend({self.menu.tools.indicator_dmg, true}):depend({tab, "tools"})

			self.menu.tools.hit_rate = group:checkbox("hitrate indicator"):depend({tab, "tools"})

			self.menu.tools.notify_master = group:checkbox("logging"):depend({tab, "tools"})
			self.menu.tools.notify_vibor = group:multiselect("\n log type", {"blured", "no rounded", "hit", "miss", "get harmed", "shot opponent", "test visible"}):depend({self.menu.tools.notify_master, true}):depend({tab, "tools"})
			self.menu.tools.notify_icon = group:checkbox(p_c.."with icon"):depend({self.menu.tools.notify_master, true}):depend({tab, "tools"})
			self.menu.tools.notify_glow = group:slider("glow radius", 15, 60, 15, true, "px", 1):depend({self.menu.tools.notify_master, true}):depend({tab, "tools"})
			self.menu.tools.notify_offset = group:slider("\n offset notifys ", up_vertical, down_vertical, 45, true, "px", 1):depend({self.menu.tools.notify_master, true}):depend({tab, "tools"})
			self.menu.tools.notify_test_name1 = group:textbox("text general part"):depend({self.menu.tools.notify_vibor, "test visible"}, {self.menu.tools.notify_master, true}):depend({tab, "tools"})
			self.menu.tools.notify_test_name2 = group:textbox("text accent color"):depend({self.menu.tools.notify_vibor, "test visible"}, {self.menu.tools.notify_master, true}):depend({tab, "tools"})
			
			self.menu.tools.notify_test = group:button("test log view", function()  
				notify.new_bottom(255,255,255, { { self.menu.tools.notify_test_name1:get() .. " " }, { self.menu.tools.notify_test_name2:get() .. "", true }, })
			end):depend({self.menu.tools.notify_vibor, "test visible"}, {self.menu.tools.notify_master, true}):depend({tab, "tools"})

			self.menu.tools.back_m = group:checkbox("background menu show"):depend({tab, "tools"})
			self.menu.tools.back_box = group:combobox(p_c.."effect", {"-", "blackout"}):depend({self.menu.tools.back_m, true}):depend({tab, "tools"})
			self.menu.tools.back_slider = group:slider("\n effect mnozitel", 5, 100, 20, true, "* ", 1):depend({self.menu.tools.back_m, true}, {self.menu.tools.back_box, "blackout"}):depend({tab, "tools"})
			
			self.menu.tools.hud_enable = group:checkbox("custom hud") :depend({tab, "tools"})
			self.menu.tools.hud_select = group:multiselect("\n custom hud select", {"h-a", "red screen on damage", "crosshair", "keybinds & icons"}):depend({self.menu.tools.hud_enable, true}):depend({tab, "tools"})
			self.menu.tools.hud_radius = group:slider(p_c.."radius crosshair", 15, 20, 15, true, "*", 1):depend({self.menu.tools.hud_enable, true}, {self.menu.tools.hud_select, "crosshair"}):depend({tab, "tools"})

			self.menu.tools.hud_predict = group:checkbox(p_c.."[icon] predict"):depend({self.menu.tools.hud_enable, true}, {self.menu.tools.hud_select, "keybinds & icons"}):depend({tab, "tools"})
			self.menu.tools.hud_dt = group:checkbox(p_c.."[icon] double tap"):depend({self.menu.tools.hud_enable, true}, {self.menu.tools.hud_select, "keybinds & icons"}):depend({tab, "tools"})
			self.menu.tools.hud_hd = group:checkbox(p_c.."[icon] hideshot"):depend({self.menu.tools.hud_enable, true}, {self.menu.tools.hud_select, "keybinds & icons"}):depend({tab, "tools"})
			self.menu.tools.hud_dmg = group:checkbox(p_c.."[icon] min damage"):depend({self.menu.tools.hud_enable, true}, {self.menu.tools.hud_select, "keybinds & icons"}):depend({tab, "tools"})
			self.menu.tools.hud_fd = group:checkbox(p_c.."[icon] fake duck"):depend({self.menu.tools.hud_enable, true}, {self.menu.tools.hud_select, "keybinds & icons"}):depend({tab, "tools"})

			self.menu.tools.hud_hp = group:checkbox(p_c.."health"):depend({self.menu.tools.hud_enable, true}, {self.menu.tools.hud_select, "h-a"}):depend({tab, "tools"})
			self.menu.tools.hud_armor = group:checkbox(p_c.."armor"):depend({self.menu.tools.hud_enable, true}, {self.menu.tools.hud_select, "h-a"}):depend({tab, "tools"})
			self.menu.tools.hud_reda = group:slider(p_c.."red screen alpha", 15, 255, 60, true, "*", 1):depend({self.menu.tools.hud_enable, true}, {self.menu.tools.hud_select, "red screen on damage"}):depend({tab, "tools"})

			self.menu.tools.predicted_check = group:checkbox("prediction system"):depend({tab, "misc"})
			self.menu.tools.predicted_bind = group:hotkey(p_c.."hotkey"):depend({self.menu.tools.predicted_check, true}):depend({tab, "misc"})
			self.menu.tools.predicted_indicator = group:checkbox(p_c.."indicator \n predict"):depend({self.menu.tools.predicted_check, true}):depend({tab, "misc"})
			self.menu.tools.predicted_slider = group:slider("\n body lean ", 1, 3, 1, true, "x", 1, {[1] = "Wingman", [2] = "Competitive", [3] = "Expiremental"}):depend({self.menu.tools.predicted_check, true}):depend({tab, "misc"})

			self.menu.tools.animations = group:checkbox("animations breakers"):depend({tab, "misc"})
			self.menu.tools.animations_selector = group:multiselect("\n animations", {"reset pitch on land", "body lean", "static legs", "jitter legs on air", "jitter legs on landing"}):depend({self.menu.tools.animations, true}):depend({tab, "misc"})
			self.menu.tools.animations_body = group:slider("\n body lean ", 0, 100, 74, true, ""):depend({self.menu.tools.animations, true}):depend({self.menu.tools.animations_selector, "body lean"}):depend({tab, "misc"})
			self.menu.tools.autobuy = group:checkbox("auto buy"):depend({tab, "misc"})
			self.menu.tools.autobuy_v = group:combobox("\n auto buy vibor", {"awp", "scar/g3sg1", "scout"}):depend({self.menu.tools.autobuy, true}):depend({tab, "misc"})
			self.menu.tools.trashtalk = group:checkbox("trashtalk"):depend({tab, "misc"})
			self.menu.tools.trashtalk_type = group:combobox("\n trashtalk type", {"default type", "custom phrase", "1 MOD"}):depend({self.menu.tools.trashtalk, true}):depend({tab, "misc"})
			self.menu.tools.trashtalk_check2 = group:checkbox(p_c.."with player name (enemy)"):depend({self.menu.tools.trashtalk, true}, {self.menu.tools.trashtalk_type, "1 MOD"}):depend({tab, "misc"})
			self.menu.tools.trashtalk_custom = group:textbox("\n phrase"):depend({self.menu.tools.trashtalk, true}, {self.menu.tools.trashtalk_type, "custom phrase"}):depend({tab, "misc"})
			self.menu.tools.clantag = group:checkbox("clantag"):depend({tab, "misc"})
			self.menu.tools.ai_peek = group:checkbox("\bA4D2D4\bffadb4[AI Peek]"):depend({tab, "misc"})
			self.menu.tools.ai_peek_boxing = group:checkbox(p_c.."visual part", {255,255,255,255}):depend({tab, "misc"}, {self.menu.tools.ai_peek, true})
			self.menu.tools.ai_peek_hotkey = group:hotkey(p_c.."hotkey"):depend({tab, "misc"}, {self.menu.tools.ai_peek, true})
			self.menu.tools.ai_peek_distance = group:slider(p_c.."distance peek", 1, 250, 50, true, "cm"):depend({tab, "misc"}, {self.menu.tools.ai_peek, true})

			--config
			self.menu.cfg.list = group:listbox("configs", {})
			self.menu.cfg.list:set_callback(function() self.config:update_name() end)
			self.menu.cfg.name = group:textbox("config name")
			self.menu.cfg.load = group:button("load", function() self.config:load() end)
			self.menu.cfg.save = group:button("save", function() self.config:save() end)
			self.menu.cfg.delete = group:button("delete", function() self.config:delete() end)

			self.menu.cfg.label2 = group_fl:label(p_c.."config\a808080FF action (1)\r")
			self.menu.cfg.defaylt = group_fl:button("default", function() self.config:import(self.globals.default_cfg, "config") end)

			self.menu.cfg.label1 = debug_group:label(p_c.."config\a808080FF action (2)\r")
			self.menu.cfg.export = debug_group:button("export", function() clipboard.set(self.config:export("config")) end)
			self.menu.cfg.import = debug_group:button("import", function() self.config:import(clipboard.get(), "config") end)


			for tab, arr in pairs(self.menu) do
				if type(arr) == "table" and tab ~= "global" then
					Loop = function (arr, tab)
						for _, v in pairs(arr) do
							if type(v) == "table" then
								if v.__type == "pui::element" then
									v:depend({self.menu.global.tab, tab})
								else
									Loop(v, tab)
								end
							end
						end
					end

					Loop(arr, tab)
				end
			end
		end,

		shutdown = function(self)
			self.helpers:menu_visibility(true)
		end
	}

	:struct 'helpers' {
    	last_eye_yaw = 0,
		was_in_air = true,
		last_tick = globals.tickcount(),

		contains = function(self, tbl, val)
			for k, v in pairs(tbl) do
				if v == val then
					return true
				end
			end
			return false
		end,

		math_lerp = function(a, b, percentage)
			return a + (b - a) * percentage
		end,

		math_anim = function(self, a, b, speed)
			return self.math_lerp(a, b, globals.frametime() * (speed or 8))
		end,

		rgba_to_hex = function(self, r, g, b, a)
			return bit.tohex(
			(math.floor(r + 0.5) * 16777216) + 
			(math.floor(g + 0.5) * 65536) + 
			(math.floor(b + 0.5) * 256) + 
			(math.floor(a + 0.5))
			)
		end,

		easeInOut = function(self, t)
			return (t > 0.5) and 4*((t-1)^3)+1 or 4*t^3;
		end,

		animate_text = function(self, time, string, r, g, b, a)
			local t_out, t_out_iter = { }, 1

			local l = string:len( ) - 1
	
			local r_add = (255 - r)
			local g_add = (255 - g)
			local b_add = (255 - b)
			local a_add = (155 - a)
	
			for i = 1, #string do
				local iter = (i - 1)/(#string - 1) + time
				t_out[t_out_iter] = "\a" .. self:rgba_to_hex( r + r_add * math.abs(math.cos( iter )), g + g_add * math.abs(math.cos( iter )), b + b_add * math.abs(math.cos( iter )), a + a_add * math.abs(math.cos( iter )) )
	
				t_out[t_out_iter + 1] = string:sub( i, i )
	
				t_out_iter = t_out_iter + 2
			end
	
			return t_out
		end,

		clamp = function(self, val, lower, upper)
			assert(val and lower and upper, "not very useful error message here")
			if lower > upper then lower, upper = upper, lower end -- swap if boundaries supplied the wrong way
			return math.max(lower, math.min(upper, val))
		end,

		get_damage = function(self)
			local mindmg = ui.get(self.ref.rage.mindmg[1])
			if ui.get(self.ref.rage.ovr[1]) and ui.get(self.ref.rage.ovr[2]) then
				return ui.get(self.ref.rage.ovr[3])
			else
				return mindmg
			end
		end,

		normalize = function(self, angle)
			angle =  angle % 360 
			angle = (angle + 360) % 360
			if (angle > 180)  then
				angle = angle - 360
			end
			return angle
		end,

		time_to_ticks = function(self, t)
			return math.floor(0.5 + (t / globals.tickinterval()))
		end,

		menu_visibility = function(self, visible)
			for _, v in pairs(self.ref.aa) do
				for _, item in ipairs(v) do
					ui.set_visible(item, visible)
				end
			end
		end,

		in_ladder = function(self)
			local me = entity.get_local_player()

			if entity.is_alive(me) then
				if entity.get_prop(me, "m_MoveType") == 9 then
					self.globals.in_ladder = globals.tickcount() + 8
				end
			else
				self.globals.in_ladder = 0
			end

		end,

		in_air = function(self, ent)
			local flags = entity.get_prop(ent, "m_fFlags")
			return bit.band(flags, 1) == 0
		end,

		in_duck = function(self, ent)
			local flags = entity.get_prop(ent, "m_fFlags")
			return bit.band(flags, 4) == 4
		end,

    get_eye_yaw = function (self, ent)
      if ent == nil then
        return
      end

      local player_ptr = get_client_entity(ientitylist, ent)
      if player_ptr == nil then
        return
      end

      if globals.chokedcommands() == 0 then
	      self.last_eye_yaw = ffi.cast("float*", ffi.cast("char*", ffi.cast("void**", ffi.cast("char*", player_ptr) + 0x9960)[0]) + 0x78)[0]
      end

      return self.last_eye_yaw
    end,

    get_closest_angle = function(self, max, min, dir, ang)
      -- Calculate the absolute angular difference between d and a, b, and c
      max = self.helpers:normalize(max)
      min = self.helpers:normalize(min)
      dir = self.helpers:normalize(dir)
      ang = self.helpers:normalize(ang)

      --check if ang is between max and min and also in the same side as dir
      local diff_maxang = math.abs((max - ang + 180) % 360 - 180)
      local diff_minang = math.abs((min - ang + 180) % 360 - 180)
      local diff_maxdir = math.abs((max - dir + 180) % 360 - 180)
      local diff_mindir = math.abs((min - dir + 180) % 360 - 180)
      local diff_minmax = math.abs((min - max + 180) % 360 - 180)

      local ang_side = diff_maxang > diff_minmax or diff_minang > diff_minmax

      local dir_side = diff_maxdir > diff_minmax or diff_mindir > diff_minmax

      if dir_side ~= ang_side then
        if diff_minang < diff_maxang then
          return 0
        else
          return 1
        end
        return
      end

      return 2
    end,

		get_freestanding_side = function(self, data)
			local me = entity.get_local_player()
			local target = client.current_threat()
			local _, yaw = client.camera_angles()
			local pos = vector(client.eye_position())

      if not target then
        return 2
      end
			
			_, yaw = (pos - vector(entity.get_origin(target))):angles()
			
			local yaw_offset = data.offset
			local yaw_jitter_type = string.lower(data.type)
			local yaw_jitter_amount = data.value
			
			local offset = math.abs(yaw_jitter_amount)
			
			if yaw_jitter_type == 'skitter' then
				offset = math.abs(yaw_jitter_amount) + 33
			elseif yaw_jitter_type == 'offset' then
				offset = math.max(0, yaw_jitter_amount)
			elseif yaw_jitter_type == 'center' then
				offset = math.abs(yaw_jitter_amount)/2
			end
			
			local max_yaw = self.helpers:normalize(yaw + yaw_offset + offset)
			
			local min_offset = offset
			if yaw_jitter_type == 'offset' then
				min_offset = math.abs(math.min(0, yaw_jitter_amount))
			end
			
			local min_yaw = self.helpers:normalize(yaw + yaw_offset - min_offset)
			
			local current_yaw = self:get_eye_yaw(me)

      local left_offset = max_yaw - current_yaw
      local right_offset = min_yaw - current_yaw

      local closest = self:get_closest_angle(min_yaw, max_yaw, yaw, current_yaw)
			
      return closest
		end,

		get_state = function(self)
			local me = entity.get_local_player()
			local velocity = vector(entity.get_prop(me, "m_vecVelocity")):length2d()
			local duck = self:in_duck(me) or ui.get(self.ref.rage.fd[1])

			local state = velocity > 1.5 and "run" or "stand"
			
			if self:in_air(me) or self.was_in_air then
				state = duck and "duck jump" or "jump"
			elseif velocity > 1.5 and duck then
				state = "duck move"
			elseif ui.get(self.ref.slow_motion[1]) and ui.get(self.ref.slow_motion[2]) then
				state = "slow walk"
			elseif duck then
				state = "duck"
			end
			if globals.tickcount() ~= self.last_tick then
				self.was_in_air = self:in_air(me)
				self.last_tick = globals.tickcount()
			end
			return state
		end,

		get_team = function(self)
			local me = entity.get_local_player()
			local index = entity.get_prop(me, "m_iTeamNum")

			return index == 2 and "t" or "ct"
		end,

		loop = function (arr, func)
			if type(arr) == "table" and arr.__type == "pui::element" then
				func(arr)
			else
				for k, v in pairs(arr) do
					loop(v, func)
				end
			end
		end,

		get_charge = function ()
			local me = entity.get_local_player()
			local simulation_time = entity.get_prop(entity.get_local_player(), "m_flSimulationTime")
			return (globals.tickcount() - simulation_time/globals.tickinterval())
		end,
	}

	:struct 'internet' {
		
	}
	:struct 'config' {
		configs = {},

		write_file = function (self, path, data)
			if not data or type(path) ~= "string" then
				return
			end

			return writefile(path, json.stringify(data))
		end,

		update_name = function (self)
			local index = self.ui.menu.cfg.list()+1
			local i = 1

			for k, v in pairs(self.configs) do
				if index == i or index == 0 then
					return self.ui.menu.cfg.name(k)
				end
				i = i + 1
			end
		end,

		update_configs = function (self)
			local names = {}
			for k, v in pairs(self.configs) do
				table.insert(names, k)
			end
			
			if #names > 0 then
				self.ui.menu.cfg.list:update(names)
			end
			self:write_file("onesense_configs.txt", self.configs)
			self:update_name()
		end,

		setup = function (self)
			local data = readfile('onesense_configs.txt')
			if data == nil then
				self.configs = {}
				return
			end

			self.configs = json.parse(data)

			self:update_configs()

			self:update_name()
		end,

		export_config = function(self, ...)
			local name = self.ui.menu.cfg.name()
			local config = pui.setup({self.ui.menu.global, self.ui.menu.antiaim, self.ui.menu.tools})

			local data = config:save()
			local encrypted = base64.encode( json.stringify(data) )

			notify.new_bottom(255,255,255, { { 'Cfg export ' }, { name.."!", true }, })
			return encrypted
		end,

		export_state = function (self, team, state)
			local config = pui.setup({self.ui.menu.antiaim.states[team][state]})

			local data = config:save()
			local encrypted = base64.encode( json.stringify(data) )

			notify.new_bottom(255,255,255, { { 'Condition export' }, { "!", true }, })
			return encrypted
		end,

		export_team = function (self, team)
			local config = pui.setup({self.ui.menu.antiaim.states[team]})

			local data = config:save()
			local encrypted = base64.encode( json.stringify(data) )

			notify.new_bottom(255,255,255, { { 'Team export' }, { "!", true }, })
			return encrypted
		end,

		export = function (self, type, ...)
			local success, result = pcall(self['export_' .. type], self, ...)
			if not success then
				print(result)
				return
			end
			
			print("Succsess")
			return "{onesense:" .. type .. "}:" .. result
		end,

		import_config = function (self, encrypted)
			local data = json.parse(base64.decode(encrypted))

			local config = pui.setup({self.ui.menu.global, self.ui.menu.antiaim, self.ui.menu.tools})
			config:load(data)
			notify.new_bottom(255,255,255, { { 'Cfg import' }, { "!", true }, })
		end,

		import_state = function (self, encrypted, team, state)
			local data = json.parse(base64.decode(encrypted))

			local config = pui.setup({self.ui.menu.antiaim.states[team][state]})
			config:load(data)
			notify.new_bottom(255,255,255, { { 'Condition import' }, { "!", true }, })
		end,

		import_team = function (self, encrypted, team)
			local data = json.parse(base64.decode(encrypted))

			local config = pui.setup({self.ui.menu.antiaim.states[team]})
			config:load(data)
			notify.new_bottom(255,255,255, { { 'Team import' }, { "!", true }, })
		end,

		import = function (self, data, type, ...)
			local name = data:match("{onesense:(.+)}")
			if not name or name ~= type then
				notify.new_bottom(255,255,255, { { 'Error: ' }, { "This not onesense config", true }, })
				return error('This not onesense config')
			end

			local success, err = pcall(self['import_'..name], self, data:gsub("{onesense:" .. name .. "}:", ""), ...)
			if not success then
				print(err)
				notify.new_bottom(255,255,255, { { 'Error: ' }, { "Failed data onesense", true }, })
				return error('Failed data onesense') 
			end
		end,

		save = function (self)
			local name = self.ui.menu.cfg.name()
			if name:match("%w") == nil then
				return print("Invalid config name")
			end

			local data = self:export("config")

			self.configs[name] = data
			notify.new_bottom(255,255,255, { { 'Saved cfg ' }, { name, true }, })

			self:update_configs()
		end,

		load = function (self)
			local name = self.ui.menu.cfg.name()
			local data = self.configs[name]

			if not data then
				notify.new_bottom(255,255,255, { { 'Invalid cfg ' }, { "name", true }, })
				return error("Inval. cfg name")--
			end

			self:import(data, "config")
			notify.new_bottom(255,255,255, { { 'Loaded cfg ' }, { name, true }, })
		end,

		delete = function(self)
			local name = self.ui.menu.cfg.name()
			local data = self.configs[name]
			if not data then
				return error("Invalid config name")
			end

			self.configs[name] = nil

			notify.new_bottom(255,255,255, { { 'Delete cfg ' }, { name, true }, })
			self:update_configs()
		end,
	}
	
	:struct 'prediction' {
		run = function (self, ent, ticks)
			local origin = vector(entity.get_origin(ent))
			local velocity = vector(entity.get_prop(ent, 'm_vecVelocity'))
			velocity.z = 0
			local predicted = origin + velocity * globals.tickinterval() * ticks
			
			return {
				origin = predicted
			}
		end,
		calculate_lerp = function ()
			local interp = cvar.cl_interp:get_float()
			local interp_ratio = cvar.cl_interp_ratio:get_float()
			return math.max(interp, interp_ratio * globals.tickinterval())
		end,
		time_to_ticks = function (time)
			return math.floor(time / globals.tickinterval())
		end,
		ticks_to_time = function (tick)
			return tick * globals.tickinterval()
		end,
		interp_values = {
			[1] = 0.018,
			[2] = 0.026, 
			[3] = 0.031 
		},
		configure_client_interp = function (self)
			if not self.ui.menu.tools.predicted_check:get() then
				cvar.cl_interp:set_float(0.001)
				return
			end
		
			local mode_selected = self.ui.menu.tools.predicted_slider:get()
			local interp_value = self.interp_values[mode_selected]
		
			if interp_value then
				cvar.cl_interp:set_float(interp_value)
				if self.ui.menu.tools.predicted_indicator:get() and self.ui.menu.tools.predicted_bind:get() then 
					renderer.indicator(255, 255, 255, 200, 'PREDICTION')
				end
			end
		
			cvar.cl_interp_ratio:set_float(1)
			cvar.cl_interpolate:set_int(1)
		end,
		compensate_lag = function (self, cmd)
			local lerp = self.calculate_lerp()
			local target_tick = globals.tickcount() - self.time_to_ticks(lerp)
			local correct_time = self.helpers:clamp(client.real_latency() + lerp, 0, cvar.sv_maxunlag:get_float())
		
			if math.abs(correct_time - self.ticks_to_time(globals.tickcount() - target_tick)) > 0.2 then
				target_tick = globals.tickcount() - self.time_to_ticks(correct_time)
			end
		
			local lerp_remainder = math.fmod(client.real_latency(), globals.tickinterval())
			local real_target_time = self.ticks_to_time(target_tick)
		
			if lerp_remainder > 0 then
				real_target_time = real_target_time + globals.tickinterval() - lerp_remainder
			end
		
			local target_ticks = math.floor(real_target_time / globals.tickinterval())
			local tick_count = globals.tickcount() + target_ticks 
		end
	}

	:struct 'fakelag' {
		send_packet = true,

		get_limit = function (self)
			if not ui.get(self.ref.fakelag.enable[1]) then
				return 1
			end

			local limit = ui.get(self.ref.fakelag.limit[1])
			local charge = self.helpers:get_charge()

      local dt = ui.get(self.ref.rage.dt[1]) and ui.get(self.ref.rage.dt[2])
      local os = ui.get(self.ref.rage.os[1]) and ui.get(self.ref.rage.os[2])

			if (dt or os) and not ui.get(self.ref.rage.fd[1]) then
				if charge > 0 then
					limit = 1
				else
					limit = ui.get(self.ref.rage.dt_limit[1])
				end
			end
			
			return limit
		end,

		run = function (self, cmd)
			local limit = self:get_limit()

			if cmd.chokedcommands < limit and (not cmd.no_choke or (cmd.chokedcommands == 0 and limit == 1)) then
				self.send_packet = false
				cmd.no_choke = false
			else
				cmd.no_choke = true
				self.send_packet = true
			end

			cmd.allow_send_packet = self.send_packet

			return self.send_packet
		end
	}

	:struct 'desync' {
		switch_move = true,

		get_yaw_base = function (self, base)
			local threat = client.current_threat()
			local _, yaw = client.camera_angles()
			if base == "at targets" and threat then
				local pos = vector(entity.get_origin(entity.get_local_player()))
				local epos = vector(entity.get_origin(threat))
		
				_, yaw = pos:to(epos):angles()
			end
		
			return yaw
		end,

		do_micromovements = function(self, cmd, send_packet)
			local me = entity.get_local_player()
			local speed = 1.01
			local vel = vector(entity.get_prop(me, "m_vecVelocity")):length2d()

			if vel > 3 then
				return
			end

			if self.helpers:in_duck(me) or ui.get(self.ref.rage.fd[1]) then
				speed = speed * 2.94117647
			end

			self.switch_move = self.switch_move or false

			if self.switch_move then
				cmd.sidemove = cmd.sidemove + speed
			else
				cmd.sidemove = cmd.sidemove - speed
			end

			self.switch_move = not self.switch_move
		end,

		can_desync = function (self, cmd)
			local me = entity.get_local_player()

			if cmd.in_use == 1 then
				return false
			end
			local weapon_ent = entity.get_player_weapon(me)

			if cmd.in_attack == 1 then
				local weapon = entity.get_classname(weapon_ent)

				if weapon == nil then
					return false
				end
          if weapon:find("Grenade") or weapon:find('Flashbang') then
            self.globals.nade = globals.tickcount()
				  else
					if math.max(entity.get_prop(weapon_ent, "m_flNextPrimaryAttack"), entity.get_prop(me, "m_flNextAttack")) - globals.tickinterval() - globals.curtime() < 0 then
						return false
					end
				end
			end
			local throw = entity.get_prop(weapon_ent, "m_fThrowTime")

			if self.globals.nade + 15 == globals.tickcount() or (throw ~= nil and throw ~= 0) then 
        return false 
      end
			if entity.get_prop(entity.get_game_rules(), "m_bFreezePeriod") == 1 then
				return false
			end
		
			if entity.get_prop(me, "m_MoveType") == 9 or self.globals.in_ladder > globals.tickcount() then
				return false
			end
			if entity.get_prop(me, "m_MoveType") == 10 then
				return false
			end
		
			return true
		end,

		run = function (self, cmd, send_packet, data)
			if not self:can_desync(cmd) then
				return
			end

			self:do_micromovements(cmd, send_packet)

			local yaw = self:get_yaw_base(data.base)

			if send_packet then
				cmd.pitch = data.pitch or 88.9
				cmd.yaw = yaw + 180 + data.offset
			else
				cmd.pitch = 88.9
				cmd.yaw = yaw + 180 + data.offset + (data.side == 2 and 0 or (data.side == 0 and 120 or -120))
			end
		end
	}

	:struct 'antiaim' {
		side = 0,
		last_rand = 0,
		skitter_counter = 0,
		last_skitter = 0,
		last_count = 0,
		cycle = 0,

		manual_side = 0,
    freestanding_side = 0,

		anti_backstab = function (self)
			local me = entity.get_local_player()
			local target = client.current_threat()
			if not target then
				return false
			end

			local weapon_ent = entity.get_player_weapon(target)

			if not weapon_ent then
				return false
			end

			local weapon_name = entity.get_classname(weapon_ent)

			if not weapon_name:find('Knife') then
				return false
			end

			local lpos = vector(entity.get_origin(me))
			local epos = vector(entity.get_origin(target))

			local predicted = self.prediction:run(target, 16)

			return epos:dist2d(lpos) < 128 or predicted.origin:dist2d(lpos) < 128
		end,

		calculate_additional_states = function (self, team, state)
			local dt = (ui.get(self.ref.rage.dt[1]) and ui.get(self.ref.rage.dt[2]))
			local os = (ui.get(self.ref.rage.os[1]) and ui.get(self.ref.rage.os[2]))
			local fd = ui.get(self.ref.rage.fd[1])

			if self.ui.menu.antiaim.states[team]['fakelag'].enable() and ((not dt and not os) or fd) then
				state = 'fakelag'
			end

			if self.ui.menu.antiaim.states[team]['hideshots'].enable() and os and not dt and not fd then
				state = 'hideshots'
			end

			return state
		end,

		get_best_side = function (self, opposite)
			local me = entity.get_local_player()
			local eye = vector(client.eye_position())
			local target = client.current_threat()
			local _, yaw = client.camera_angles()

			local epos
			if target then
				epos = vector(entity.get_origin(target)) + vector(0,0,64)
				_, yaw = (epos - eye):angles()
			end

			local angles = {60,45,30,-30,-45,-60}
			local data = {left = 0, right = 0}

			for _, angle in ipairs(angles) do
				local forward = vector():init_from_angles(0, yaw + 180 + angle, 0)

				if target then
					local vec = eye + forward:scaled(128)
					local _, dmg = client.trace_bullet(target, epos.x, epos.y, epos.z, vec.x, vec.y, vec.z, me)
					data[angle < 0 and 'left' or 'right'] = data[angle < 0 and 'left' or 'right'] + dmg
				else
					local vec = eye + forward:scaled(8192)
					local fraction = client.trace_line(me, eye.x, eye.y, eye.z, vec.x, vec.y, vec.z)
					data[angle < 0 and 'left' or 'right'] = data[angle < 0 and 'left' or 'right'] + fraction
				end
			end

			if data.left == data.right then
				return 2
			elseif data.left > data.right then
				return opposite and 1 or 0
			else
				return opposite and 0 or 1
			end
		end,

		get_manual = function (self)
			local me = entity.get_local_player()

			if not self.ui.menu.antiaim.manual_aa:get() then
				return
			end

			local left = self.ui.menu.antiaim.manual_left:get()
			local right = self.ui.menu.antiaim.manual_right:get()
			local forward = self.ui.menu.antiaim.manual_forward:get()

			if self.last_forward == nil then
				self.last_forward, self.last_right, self.last_left = forward, right, left
			end

			if left ~= self.last_left then
				if self.manual_side == 1 then
					self.manual_side = nil
				else
					self.manual_side = 1
				end
			end

			if right ~= self.last_right then
				if self.manual_side == 2 then
					self.manual_side = nil
				else
					self.manual_side = 2
				end
			end

			if forward ~= self.last_forward then
				if self.manual_side == 3 then
					self.manual_side = nil
				else
					self.manual_side = 3
				end
			end

			self.last_forward, self.last_right, self.last_left = forward, right, left

			if not self.manual_side then
				return
			end

			return ({-90, 90, 180})[self.manual_side]
		end,

		run = function (self, cmd)
			local me = entity.get_local_player()

			if not entity.is_alive(me) then
				return
			end

			local state = self.helpers:get_state()
			local team = self.helpers:get_team()
			state = self:calculate_additional_states(team, state)

			self:set_builder(cmd, state, team)

		end,

		set_builder = function (self, cmd, state, team)
			if not self.ui.menu.antiaim.states[team][state].enable() then
				state = "global"
			end
		
			local data = {}

			for k, v in pairs(self.ui.menu.antiaim.states[team][state]) do
				data[k] = v()
			end
			
			self:set(cmd, data)
		end,

		animations_helper = function(self, cmd)
			local me = entity.get_local_player()
			local activate = self.ui.menu.tools.animations:get()

			if not entity.is_alive(me) or not activate then
				return
			end

			local legs_get = ui.reference("AA", "other", "leg movement")

			if self.helpers:contains(self.ui.menu.tools.animations_selector:get(), "jitter legs on landing") then -- leg movement
				ui.set(legs_get, cmd.command_number % 3 == 0 and "Off" or "Always slide")
			end
		end,

		animations = function(self)
			local me = entity.get_local_player()
			local activate = self.ui.menu.tools.animations:get()

			if not entity.is_alive(me) or not activate then
				return
			end

			local self_index = entity_lib.new(me)
			local self_anim_overlay = self_index:get_anim_state()
			local body_lean_value = self.ui.menu.tools.animations_body:get()
			
			if not self_anim_overlay then
				return
			end

			local state = self.helpers:get_state()
			local x_velocity = entity.get_prop(me, "m_vecVelocity[0]")

			if self.helpers:contains(self.ui.menu.tools.animations_selector:get(), "body lean") then
				local self_anim_overlay = self_index:get_anim_overlay(12)

				if not self_anim_overlay then
					return
				end

				if math.abs(x_velocity) >= 3 then
					self_anim_overlay.weight = body_lean_value / 100
				end
			end

			if self.helpers:contains(self.ui.menu.tools.animations_selector:get(), "static legs") then
				entity.set_prop(me, "m_flPoseParameter", 1, 6) 
			end

			if self.helpers:contains(self.ui.menu.tools.animations_selector:get(), "jitter legs on landing") then
				entity.set_prop(me, "m_flPoseParameter", 1, globals.tickcount() % 4 > 1 and 5 / 10 or 1)
			end

			if self.helpers:contains(self.ui.menu.tools.animations_selector:get(), "jitter legs on air") then
				entity.set_prop(me, "m_flPoseParameter", 10 / 10,  6)
			end

			if self.helpers:contains(self.ui.menu.tools.animations_selector:get(), "reset pitch on land") then 
				if not self_anim_overlay.hit_in_ground_animation then
					return
				end
		
				entity.set_prop(me, "m_flPoseParameter", 0.5, 12)
			end
		end,
		check_in = 0,
		get_defensive = function (self, conditions, state, event)
			local target = client.current_threat()
			local me = entity.get_local_player()

			if self.helpers:contains(conditions, 'always') then
				return true
			end

			if self.helpers:contains(conditions, 'on weapon switch') then
				local next_attack = entity.get_prop(me, 'm_flNextAttack') - globals.curtime()
				if next_attack / globals.tickinterval() > self.defensive.defensive + 2 then
					return true
				end
			end

			if self.helpers:contains(conditions, 'on reload') then
				local weapon = entity.get_player_weapon(me)
				if weapon then
					local next_attack = entity.get_prop(me, 'm_flNextAttack') - globals.curtime()
					local next_primary_attack = entity.get_prop(weapon, 'm_flNextPrimaryAttack') - globals.curtime()

					if next_attack > 0 and next_primary_attack > 0 and next_attack * globals.tickinterval() > self.defensive.defensive then
						return true
					end
				end
			end

			if self.helpers:contains(conditions, 'on hittable') and entity_has_flag(target, 'HIT') then
				return true
			end

			if self.helpers:contains(conditions, 'on dormant peek') and target then
				local weapon_ent = entity.get_player_weapon(target)
				if entity.is_dormant(target) and weapon_ent then
					if entity_has_flag(me, 'HIT') then
						return true
					end

					local weapon = csgo_weapons(weapon_ent)

					local predicted = self.prediction:run(me, 14).origin
					local origin = vector(entity.get_origin(me))
					
					local offset = predicted - origin
					local biggest_damage = 0

					for i = 2, 8 do
						local to = vector(entity.hitbox_position(me, i)) + offset
						local from = vector(entity.get_origin(target)) + vector(0,0, 64)

						local _, dmg = client.trace_bullet(target, from.x, from.y, from.z, to.x, to.y, to.z, target)

						if dmg > biggest_damage then
							biggest_damage = dmg
						end
					end

					if biggest_damage > weapon.damage / 3 then
						return true
					end
				end
			end

			if self.helpers:contains(conditions, 'on freestand') and self.ui.menu.antiaim.freestanding:get_hotkey() and not (self.ui.menu.antiaim.freestanding:get('activate disablers') and self.ui.menu.antiaim.freestanding_disablers:get(state)) then
				return true
			end
		end,
		spin_yaw = 0,
		current_way = 1,
		SPIN2 = 0,
		SPIN3 = 0,
		JITTER =0,
		spin_way =0,
		spin_pitch = 0,
		last_way = 0,
		ran1 = 0,
		ran2 = 0,
		set = function (self, cmd, data)
      local state = self.helpers:get_state()
			local delay = {math.random(1, math.random(3, 4)), 2, 4, 5}
			local manual = self:get_manual()
			local delayed = true

			if data.jitter_delay == 0 then 
				delay[data.jitter_delay] = 1 
			end 

      if globals.chokedcommands() == 0 and self.cycle == delay[data.jitter_delay] then
        delayed = false
        self.side = self.side == 1 and 0 or 1
      end

			local best_side = self:get_best_side()
      local side = self.side
      local body_yaw = data.body_yaw
      local pitch = 'default'

      if body_yaw == "jitter" then
        body_yaw = "static"
      else
        if data.body_yaw_side == "left" then
          side = 1
        elseif data.body_yaw_side == "right" then
          side = 0
        else
          side = best_side
        end
      end

			
			local yaw_offset = 0
      if data.yaw_jitter == 'offset' then
        if self.side == 1 then
        yaw_offset = yaw_offset + data.yaw_jitter_add
        end
      elseif data.yaw_jitter == 'center' then
        yaw_offset = yaw_offset + (self.side == 1 and data.yaw_jitter_add/2 or -data.yaw_jitter_add/2)
      elseif data.yaw_jitter == 'random' then
        local rand = (math.random(0, data.yaw_jitter_add) - data.yaw_jitter_add/2)
        if not delayed then
          yaw_offset = yaw_offset + rand

          self.last_rand = rand
        else
          yaw_offset = yaw_offset + self.last_rand
        end
      elseif data.yaw_jitter == 'skitter' then
        local sequence = {0, 2, 1, 0, 2, 1, 0, 1, 2, 0, 1, 2, 0, 1, 2}

        local next_side
        if self.skitter_counter == #sequence then
          self.skitter_counter = 1
      	elseif not delayed then
          self.skitter_counter = self.skitter_counter + 1
        end

        next_side = sequence[self.skitter_counter]

        self.last_skitter = next_side

        if data.body_yaw == "jitter" then
          side = next_side
        end

        if next_side == 0 then
          yaw_offset = yaw_offset - 16 - math.abs(data.yaw_jitter_add)/2
        elseif next_side == 1 then
          yaw_offset = yaw_offset + 16 + math.abs(data.yaw_jitter_add)/2
        end
      end

      yaw_offset = yaw_offset + (side == 0 and data.yaw_add_r or (side == 1 and data.yaw_add or 0))

			if self.helpers:contains(data.options, 'defensive-yaw') and self:get_defensive(data.defensive_conditions, state) then
				cmd.force_defensive = true
			end

			ui.set(self.ref.aa.freestand[1], false)
			ui.set(self.ref.aa.edge_yaw[1], self.ui.menu.antiaim.edge_yaw:get_hotkey())
			ui.set(self.ref.aa.freestand[2], 'Always on')

			if self.helpers:contains(data.options, 'safe head') then
				local me = entity.get_local_player()
				local target = client.current_threat()
				if target then
					local weapon = entity.get_player_weapon(me)
					if weapon and (entity.get_classname(weapon):find('Knife') or entity.get_classname(weapon):find('Taser')) then
						yaw_offset = 0
						side = 2
					end
				end
			end

			if manual then
				yaw_offset = manual
			elseif self.ui.menu.antiaim.freestanding:get_hotkey() and not (self.ui.menu.antiaim.freestanding:get('activate disablers') and self.ui.menu.antiaim.freestanding_disablers:get(state)) then
        data.desync_mode = 'gamesense'
        ui.set(self.ref.aa.freestand[1], true)

			  if self.ui.menu.antiaim.freestanding:get("force static") then
			  	yaw_offset = 0
			  	side = 0
			  end
      elseif self.helpers:contains(data.options, 'anti backstab') and self:anti_backstab() then
				yaw_offset = yaw_offset + 180
			end

			local defensive = self.defensive.ticks * self.defensive.defensive > 0 and math.max(self.defensive.defensive, self.defensive.ticks) or 0

			if data.defensive_yaw and self.helpers:contains(data.options, 'defensive-yaw') then
				local defensive_freestand = false

				if data.defensive_freestand and ui.get(self.ref.aa.freestand[1]) then
					if defensive == 1 then
      		  self.freestanding_side = self.helpers:get_freestanding_side({
      		    offset = 0,
      		    type = data.yaw_jitter,
      		    value = data.yaw_jitter_add,
      		    base = data.yaw_base
      		  })
      		end

					if self.freestanding_side ~= 2 then
						defensive_freestand = true
					
        	  if defensive > 0 then
        	    yaw_offset = yaw_offset + (self.freestanding_side == 1 and 120 or -120)
        	    pitch = 0
        	    ui.set(self.ref.aa.freestand[1], false)
        	  end
					end
				end

				local ways_data = {
					{speed = data.defensive_yaw_way_speed1, spin_limit = data.defensive_yaw_way_spin_limit1, enable_spin = data.defensive_yaw_enable_way_spin1, switch_value = data.defensive_yaw_way_switch1},
					{speed = data.defensive_yaw_way_speed2, spin_limit = data.defensive_yaw_way_spin_limit2, enable_spin = data.defensive_yaw_enable_way_spin2, switch_value = data.defensive_yaw_way_switch2},
					{speed = data.defensive_yaw_way_speed3, spin_limit = data.defensive_yaw_way_spin_limit3, enable_spin = data.defensive_yaw_enable_way_spin3, switch_value = data.defensive_yaw_way_switch3},
					{speed = data.defensive_yaw_way_speed4, spin_limit = data.defensive_yaw_way_spin_limit4, enable_spin = data.defensive_yaw_enable_way_spin4, switch_value = data.defensive_yaw_way_switch4},
					{speed = data.defensive_yaw_way_speed5, spin_limit = data.defensive_yaw_way_spin_limit5, enable_spin = data.defensive_yaw_enable_way_spin5, switch_value = data.defensive_yaw_way_switch5}
				}

				local t_w_i = 16
				local paa1 = math.random(-100,100)
				if data.defensive_yaw_mode == 'jitter' and defensive > 0 and not defensive_freestand then -- self.JITTER
					local deg3 = (globals.tickcount() % t_w_i*2)
					local radius = data.defensive_yaw_jitter_radius
					local delay = data.defensive_yaw_jitter_delay
					local ran1 = data.defensive_yaw_jitter_random

					if deg3 <= 2 + delay*2 then 
						self.JITTER = radius + math.random(-ran1, ran1)
					else
						self.JITTER = -radius - math.random(-ran1, ran1)
					end
						yaw_offset = self.JITTER
				elseif data.defensive_yaw_mode == 'custom spin' and defensive > 0 then -- data.defensive_yaw_spin_limit
					self.SPIN3 = self.SPIN3 + 8 * (data.defensive_yaw_speedtick / 5)

					if self.SPIN3 >= data.defensive_yaw_spin_limit then 
						self.SPIN3 = 0
					end

					yaw_offset = self.SPIN3
				elseif data.defensive_yaw_mode == '3, 4, 5 way' and defensive > 0 then
					yaw_offset = math.abs(yaw_offset) + defensive * (data.defensive_yaw_3way_limit * 20 - math.abs(yaw_offset) * 2) / 14
				elseif data.defensive_yaw_mode == 'exploit[miss enemy]' and defensive > 0 then
					yaw_offset = math.random(63,79)
				elseif data.defensive_yaw_mode == 'switch 5way' and defensive > 0 then
					local deg = (globals.tickcount() % t_w_i*2)
					if deg >= 29 + math.random(0,data.defensive_yaw_way_delay) then
						self.current_way = self.current_way + 1
						self.ran1 = math.random(-data.defensive_yaw_way_randomly_value, data.defensive_yaw_way_randomly_value)
					else
						yaw_offset = self.last_way

						if self.current_way == #ways_data then
						 self.current_way = 0
						end
					end
					if self.current_way >= 0 and self.current_way < #ways_data then
						local way_data = ways_data[self.current_way + 1]
				
						self.spin_way = self.spin_way + 8 * (way_data.speed / 5)
				
						if self.spin_way >= way_data.spin_limit then
							self.spin_way = 0
						end
				
						if not way_data.enable_spin then 
							if data.defensive_yaw_way_randomly then
								yaw_offset = way_data.switch_value + self.ran1
								self.last_way = way_data.switch_value + self.ran1
							else
								yaw_offset = way_data.switch_value
								self.last_way = way_data.switch_value
							end
						else
							yaw_offset = self.spin_way
							self.last_way = self.spin_way
						end
					 else
						if self.current_way == #ways_data then
						  self.current_way = 0
						end
					end
				end
			end

			local ways_data2 = {
				{speed = data.defensive_pitch_way_speed1, spin_limit1 = data.defensive_pitch_way_spin_limit11, spin_limit2 = data.defensive_pitch_way_spin_limit12, enable_spin = data.defensive_pitch_enable_way_spin1, switch_value = data.defensive_pitch_custom},
				{speed = data.defensive_pitch_way_speed2, spin_limit1 = data.defensive_pitch_way_spin_limit21, spin_limit2 = data.defensive_pitch_way_spin_limit22, enable_spin = data.defensive_pitch_enable_way_spin2, switch_value = data.defensive_pitch_way2},
				{speed = data.defensive_pitch_way_speed3, spin_limit1 = data.defensive_pitch_way_spin_limit31, spin_limit2 = data.defensive_pitch_way_spin_limit32, enable_spin = data.defensive_pitch_enable_way_spin3, switch_value = data.defensive_pitch_way3},
				{speed = data.defensive_pitch_way_speed4, spin_limit1 = data.defensive_pitch_way_spin_limit41, spin_limit2 = data.defensive_pitch_way_spin_limit42, enable_spin = data.defensive_pitch_enable_way_spin4, switch_value = data.defensive_pitch_way4},
				{speed = data.defensive_pitch_way_speed5, spin_limit1 = data.defensive_pitch_way_spin_limit51, spin_limit2 = data.defensive_pitch_way_spin_limit52, enable_spin = data.defensive_pitch_enable_way_spin5, switch_value = data.defensive_pitch_way5}
			}

				if data.defensive_pitch_mode == 'static' and defensive > 0 then 
					pitch = data.defensive_pitch_custom
				elseif data.defensive_pitch_mode == 'clock (jitter)' and defensive > 0 then 
					if math.random(0,20) >= 10 then
						pitch = data.defensive_pitch_clock
					else
						pitch = data.defensive_pitch_custom
					end
				elseif data.defensive_pitch_mode == 'spin' and defensive > 0 then

					if data.defensive_pitch_custom < 0 then 
						self.SPIN2 = self.SPIN2 - 8 * (data.defensive_pitch_speedtick / 5)
					else
						self.SPIN2 = self.SPIN2 + 8 * (data.defensive_pitch_speedtick / 5)
					end

					if data.defensive_pitch_custom < 0 then 
						if self.SPIN2 <= data.defensive_pitch_custom then 
							self.SPIN2 = data.defensive_pitch_spin_limit2
						end
					else
						if self.SPIN2 >= data.defensive_pitch_custom then 
							self.SPIN2 = data.defensive_pitch_spin_limit2
						end
					end

					pitch = self.SPIN2

				elseif data.defensive_pitch_mode == 'exploit[beta]' and defensive > 0 then
					local deg = (globals.tickcount() % 16*2)
					if deg >= 28 then 
						self.spin_yaw = self.spin_yaw + 15 
					end
					if self.spin_yaw >= 89 then 
						self.spin_yaw = -89
					end
					pitch = self.spin_yaw
				elseif data.defensive_pitch_mode == '5way' and defensive > 0 then -- pitch
					local deg = (globals.tickcount() % 16*2)
					if deg >= 29 + math.random(0,data.defensive_yaw_way_delay) then
						--self.current_way = self.current_way + 1
						self.ran2 = math.random(-data.defensive_pitch_way_randomly_value, data.defensive_pitch_way_randomly_value)
					else
						pitch = self.last_way
					end
					if self.current_way >= 0 and self.current_way < #ways_data2 then
						local way_data2 = ways_data2[self.current_way + 1]
				
						if way_data2.spin_limit2 < 0 then 
							self.spin_pitch = self.spin_pitch - 8 * (way_data2.speed / 5)
						else
							self.spin_pitch = self.spin_pitch + 8 * (way_data2.speed / 5)
						end

						if way_data2.spin_limit2 < 0 then 
							if self.spin_pitch <= way_data2.spin_limit2 then
								self.spin_pitch = way_data2.spin_limit1
							end
						else
							if self.spin_pitch >= way_data2.spin_limit2 then
								self.spin_pitch = way_data2.spin_limit1
							end
						end
				
						if not way_data2.enable_spin then
							if data.defensive_pitch_way_randomly then 
								pitch = self.ran2
								self.last_way = self.ran2
							else 
								pitch = way_data2.switch_value
								self.last_way = way_data2.switch_value
							end
						else
							pitch = self.spin_pitch
							self.last_way = self.spin_pitch
						end
					end
				end
      if data.desync_mode == 'gamesense' then
        ui.set(self.ref.aa.enabled[1], true)
        ui.set(self.ref.aa.pitch[1], pitch == 'default' and pitch or 'custom')
        ui.set(self.ref.aa.pitch[2], type(pitch) == "number" and pitch or 0)
        ui.set(self.ref.aa.yaw_base[1], data.yaw_base)
        ui.set(self.ref.aa.yaw[1], 180)
        ui.set(self.ref.aa.yaw[2], self.helpers:normalize(yaw_offset))
        ui.set(self.ref.aa.yaw_jitter[1], 'off')
        ui.set(self.ref.aa.yaw_jitter[2], 0)
        ui.set(self.ref.aa.body_yaw[1], body_yaw)
        ui.set(self.ref.aa.body_yaw[2], (side == 2) and 0 or (side == 1 and 90 or -90))
			elseif data.desync_mode == 'onesense' then
        local send_packet = self.fakelag:run(cmd)

        if pitch == 'default' then
          pitch = nil
        end
        
        self.desync:run(cmd, send_packet, {
          pitch = pitch,
          base = data.yaw_base,
          side = side,
          offset = yaw_offset,
        })
      end

      self.last_count = globals.tickcount()

      if globals.chokedcommands() == 0 then
      	if self.cycle >= delay[data.jitter_delay] then
        self.cycle = 1
        else
        	self.cycle = self.cycle + 1
        end
      end
            
    end,
	}

	:struct 'defensive' {
		cmd = 0,
		check = 0,
		defensive = 0,
		player_data = {},
		sim_time = globals.tickcount(),
		active_until = 0,
		ticks = 0,
		active = false,

		defensive_active = function(self)
    	local me = entity.get_local_player()
    	local tickcount = globals.tickcount()
    	local sim_time = entity.get_prop(me, "m_flSimulationTime")
    	local sim_diff = toticks(sim_time - self.sim_time)

    	if sim_diff < 0 then
    	  self.active_until = tickcount + math.abs(sim_diff)
    	end

			self.ticks = self.helpers:clamp(self.active_until - tickcount, 0, 16)
    	self.active = self.active_until > tickcount

			self.sim_time = sim_time
		end,

		predict = function(self)
			local tickbase = entity.get_prop(entity.get_local_player(), "m_nTickBase")
			self.defensive = math.abs(tickbase - self.check)
			self.check = math.max(tickbase, self.check or 0)
			self.cmd = 0
		end,

		reset = function(self)
			self.check, self.defensive = 0, 0
		end,

		defensivestatus = function(self)
			local player = entity.get_local_player()
			if not entity.is_alive(player) then
				return
			end

			local origin = vector(entity.get_prop(entity.get_local_player(), "m_vecOrigin"))
			local simtime = entity.get_prop(player, "m_flSimulationTime")
			local sim_time = self.helpers:time_to_ticks(simtime)
			local player_data = self.player_data[player]
			if player_data == nil then
				self.player_data[player] = {
					last_sim_time = sim_time,
					defensive_active_until = 0,
					origin = origin
				}
			else
				local delta = sim_time - player_data.last_sim_time
				if delta < 0 then
					player_data.defensive_active_until = globals.tickcount() + math.abs(delta)
				elseif delta > 0 then
					player_data.breaking_lc = (player_data.origin - origin):length2dsqr() > 4096
					player_data.origin = origin
				end
				player_data.last_sim_time = sim_time    
			end
		end
	}

	:struct 'predict' {

		accelerate = function (self, forward, target_speed, velocity)
			local current_speed = velocity.x * forward.x + velocity.y * forward.y + velocity.z * forward.z

			local speed_delta = target_speed - current_speed

			if speed_delta > 0 then
				local acceleration_speed = cvar.sv_accelerate:get_float() * globals.tickinterval() * math.max(250, target_speed)
			
				if acceleration_speed > speed_delta then
					acceleration_speed = speed_delta
				end
			
				velocity = velocity + (acceleration_speed * forward)
			end
		
			return velocity
		end,

		calculate_velocity = function (self, forward, velocity)
			local me = entity.get_local_player()
			local target_speed = 450
			local max_speed = entity.get_prop(me, "m_flMaxspeed")
		
			--local target_velocity = forward:normalized() * math.min(max_speed, target_speed)
		
			velocity = self:accelerate(forward, target_speed, velocity)
		
			if velocity:lengthsqr() > max_speed^2 then
				velocity = (velocity / velocity:length()) * max_speed
			end
		
			return velocity
		end,

		run = function (self, origin, ticks, ent, forward)
			local velocity = vector(entity.get_prop(ent, 'm_vecVelocity'))

			local positions = {}
			for i = 1, ticks do
				velocity = self:calculate_velocity(forward, velocity)
				origin = origin + (velocity * globals.tickinterval())
				positions[i] = origin
			end

			return positions
		end,
	}

	:struct 'tools' {
		active_fraction2 = 0,
		enabled_fraction = 0,
		origin = vector(),
		point = vector(),
		hitbox = vector(),
		max_delta = 0,
		delta = 0,
		scoped = 0,
		active_fraction = 0,
		inactive_fraction = 0,
		hide_fraction = 0,
		scoped_fraction = 0,
		ap_fraction = 0,
		weapon_fraction = 0,
		fraction = 0,
		ANIM = 0,

		dop_x = 0,
		dop_y= 0,
		vel_a = 0,
		smooth_a = 0,

		menu_vis = function(self)
			for _, v in pairs(self.ref.fakelag) do
				for _, item in ipairs(v) do
					if (self.ui.menu.global.tab:get() == "antiaim" and self.ui.menu.antiaim.mode:get() == "builder") or self.ui.menu.global.tab:get() == "cfg" or self.ui.menu.global.tab:get() == "tools" then
						ui.set_visible(item, false)
					else
						ui.set_visible(item, true)
					end
				end
			end
			for _, v in pairs(self.ref.aa_other) do
				for _, item in ipairs(v) do
					if (self.ui.menu.global.tab:get() == "antiaim" and self.ui.menu.antiaim.mode:get() == "builder") or self.ui.menu.global.tab:get() == "cfg" then
						ui.set_visible(item, false)
					else
						ui.set_visible(item, true)
					end
				end
			end
		end,

		notify_cfg = function(self)
			local r, g, b, a = self.ui.menu.global.title_name:get_color()
			local offset_n = self.ui.menu.tools.notify_offset:get()

			notifys.color[1] = r
			notifys.color[2] = g
			notifys.color[3] = b
			notifys.offset = offset_n
			notifys.glow = self.ui.menu.tools.notify_glow:get()

			if self.ui.menu.tools.notify_vibor:get("blured") then 
				notifys.blured = true
			else
				notifys.blured = false
			end
			if self.ui.menu.tools.notify_vibor:get("no rounded") then 
				notifys.rounded = true
			else
				notifys.rounded = false
			end
			if self.ui.menu.tools.notify_icon:get() then 
				notifys.icon = true 
			else
				notifys.icon = false
			end
		end,
		
		hit_rate = function(self)
			if not self.ui.menu.tools.hit_rate:get() then return end

			local hit_rate = shots.total ~= 0 and (shots.hits / shots.total * 100) or 100

			renderer.indicator(255, 255, 255, 200, string.format('%s%d%%', hit_rate <= 50 and '' or '', hit_rate))
		end,

		render = function(self)
			local me = entity.get_local_player()

			if not me or not entity.is_alive(me) then
				return
			end
			local state = self.helpers:get_state()

			local ss = {client.screen_size()}
			self.ss = {
				x = ss[1],
				y = ss[2]
			}

			local r, g, b, a = self.ui.menu.global.title_name:get_color()
			local w_s = self.ui.menu.tools.watermark_styles:get()

			local r2, g2, b2, a2 = 55,55,55,255
			local highlight_fraction =  (globals.realtime() / 2 % 1.2 * 2) - 1.2
			local output = ""
			local text_to_draw = " S E N S E"

			if w_s == "onesense" then 
				renderer.text(self.ss.x/2 - 23, self.ss.y/2 * 1.97, 255, 255, 255, 255, "b", 0, "onesense") -- hex
			else
				for idx = 1, #text_to_draw do
					local character = text_to_draw:sub(idx, idx)
					local width, height = client.screen_size()
					local character_fraction = idx / #text_to_draw
					local r1, g1, b1, a1 = 255, 255, 255, 255
					local highlight_delta = (character_fraction - highlight_fraction)
					if highlight_delta >= 0 and highlight_delta <= 1.4 then
						if highlight_delta > 0.7 then
							highlight_delta = 1.4 - highlight_delta
						end
						local r_fraction, g_fraction, b_fraction, a_fraction = r2 - r1, g2 - g1, b2 - b1
						r1 = r1 + r_fraction * highlight_delta / 0.8
						g1 = g1 + g_fraction * highlight_delta / 0.8
						b1 = b1 + b_fraction * highlight_delta / 0.8
					end
					output = output .. ('\a%02x%02x%02x%02x%s'):format(r1, g1, b1, 255, text_to_draw:sub(idx, idx))
				end
				output = "O N E" .. output
	
				if self.ui.menu.tools.watermark_spaces:get() then
					output = output:gsub(" ", "")
				end
				if getbuild() == "beta" then 
					output = output .. ("\a%x%x%x%x"):format(200, 69, 69, 255) .. " [BETA] "
				end

                if self.ui.menu.tools.watermark_pos:get() == "down" then
                    renderer.text(self.ss.x/2 +1, self.ss.y - 20, r,g,b, 255, "c", 0, output)
                elseif self.ui.menu.tools.watermark_pos:get() == "right" then
                    renderer.text(self.ss.x - 69, self.ss.y/2 + 15, r,g,b, 255, "c", 0, output)
                elseif self.ui.menu.tools.watermark_pos:get() == "left" then
                    renderer.text(69, self.ss.y/2 + 15, r,g,b, 255, "c", 0, output)
				end
			end

			local scoped_frac

			if entity.get_prop(me, "m_bIsScoped") == 1 then
				self.scoped = self.helpers:clamp(self.scoped + globals.frametime()/0.2, 0, 1)
				scoped_frac = self.scoped ^ (1/2)
			else
				self.scoped = self.helpers:clamp(self.scoped - globals.frametime()/0.2, 0, 1)
				scoped_frac = self.scoped ^ 2
			end

      		local style = "default"
	  		local first_velocity = entity.get_prop(me, "m_vecVelocity[0]")
			local second_velocity = entity.get_prop(me, "m_vecVelocity[1]")
			local velf = math.floor(math.sqrt(first_velocity*first_velocity+second_velocity*second_velocity))
			local check_5 = self.ui.menu.tools.indicator_extended:get()

			local l514
			local rkl = math.random(-10,11)

			if velf > 1 and check_5 then 
				l514=rkl
			else
				l514=rkl
				self.dop_x =0
				self.dop_y=0
			end
			
      --#region crosshair
      	if style == "default" then
        		if not self.ui.menu.tools.indicators:get() then
			  		return
			  	end
        	  local visual_size = self.ui.menu.tools.indicatorfont:get()
			  self.ANIM = self.helpers:math_anim(self.ANIM, self.ui.menu.tools.indicatoroffset:get(), 16) -- + self.dop_x + self.dop_y
			  self.vel_a = self.helpers:math_anim(self.vel_a, velf, 32) 
			  self.smooth_a = self.helpers:math_anim(self.smooth_a, l514, 32) 

			if velf and check_5 then
				local forward_speed = -first_velocity
				local side_speed = -second_velocity
			
				local x_offset = side_speed / 15 + self.smooth_a
				local y_offset = forward_speed / 15 + self.smooth_a
				self.dop_x = self.helpers:math_anim(self.dop_x, x_offset, 32)  
			  	self.dop_y = self.helpers:math_anim(self.dop_y, y_offset, 32) 
			end
			  
       		 --self.ui.menu.tools.indicator_extended
			  local size = ""
			  if visual_size == "small" then
			  	size = "-"
			  elseif visual_size == "bold" then
			  	size = "b"
			  elseif visual_size == "normal" then
			  	size = "c"
			  end

			  local func = string[size == "-" and "upper" or "lower"]

			  local strike_w, strike_h = renderer.measure_text(size, func"onesense beta")

			  local weapon_ent = entity.get_player_weapon(me)
			  local weapon = entity.get_classname(weapon_ent)
			  if weapon ~= nil then
			  	if weapon:find("Grenade") then
			  		self.weapon_fraction = self.helpers:clamp(self.weapon_fraction + globals.frametime()/0.15, 0, 1)
			  	else
			  		self.weapon_fraction = self.helpers:clamp(self.weapon_fraction - globals.frametime()/0.15, 0, 1)
			  	end
			  end
			  	--ctx.m_render:glow_module(x/2 + ((strike_w + 2)/2) * scoped_frac - strike_w/2 + 4, y/2 + 20, strike_w - 3, 0, 10, 0, {r, g, b, 100 * math.abs(math.cos(globals.curtime()*2))}, {r, g, b, 100 * math.abs(math.cos(globals.curtime()*2))})
			  renderer.text(self.ss.x/2 + ((strike_w + 2)/2) * scoped_frac + self.dop_x, self.ss.y/2 + self.ANIM+ self.dop_y, 255, 255, 255, 255-(150*self.weapon_fraction), size .. "c", 0, func"onesense ", func("\a" .. self.helpers:rgba_to_hex( r, g, b, ((255-(150*self.weapon_fraction)) * math.abs(math.cos(globals.curtime()*2)))) .. "beta"))

			  local next_attack = entity.get_prop(me, "m_flNextAttack")
			  local next_primary_attack = entity.get_prop(entity.get_player_weapon(me), "m_flNextPrimaryAttack")

			  local dt_toggled = ui.get(self.ref.rage.dt[1]) and ui.get(self.ref.rage.dt[2])
			  local dt_active = not (math.max(next_primary_attack, next_attack) > globals.curtime()) --or (ctx.helpers.defensive and ctx.helpers.defensive > ui.get(ctx.ref.dt_fl))

			  if dt_toggled and dt_active then
			  	self.active_fraction = self.helpers:clamp(self.active_fraction + globals.frametime()/0.15, 0, 1)
			  else
			  	self.active_fraction = self.helpers:clamp(self.active_fraction - globals.frametime()/0.15, 0, 1)
			  end

			  if dt_toggled and not dt_active then
			  	self.inactive_fraction = self.helpers:clamp(self.inactive_fraction + globals.frametime()/0.15, 0, 1)
			  else
			  	self.inactive_fraction = self.helpers:clamp(self.inactive_fraction - globals.frametime()/0.15, 0, 1)
			  end

			  if ui.get(self.ref.rage.os[1]) and ui.get(self.ref.rage.os[2]) and not dt_toggled then
			  	self.hide_fraction = self.helpers:clamp(self.hide_fraction + globals.frametime()/0.15, 0, 1)
			  else
			  	self.hide_fraction = self.helpers:clamp(self.hide_fraction - globals.frametime()/0.15, 0, 1)
			  end

			  if math.max(self.hide_fraction, self.inactive_fraction, self.active_fraction) > 0 then
			  	self.fraction = self.helpers:clamp(self.fraction + globals.frametime()/0.2, 0, 1)
			  else
			  	self.fraction = self.helpers:clamp(self.fraction - globals.frametime()/0.2, 0, 1)
			  end

			  local dt_size, dt_h = renderer.measure_text(size, func"DT ")
			  local ready_size = renderer.measure_text(size, func"READY")
			  renderer.text(self.ss.x/2 + ((dt_size + ready_size + 2)/2) * scoped_frac + self.dop_x, self.ss.y/2 + self.ANIM+ self.dop_y + strike_h, 255, 255, 255, self.active_fraction * (255 - (150*self.weapon_fraction)), size .. "c", dt_size + self.active_fraction * ready_size + 1, func"DT ", func("\a" .. self.helpers:rgba_to_hex(155, 255, 155, 255 * self.active_fraction - (150*self.weapon_fraction)) .. "READY"))

			  local charging_size = renderer.measure_text(size, func"CHARGING")
			  local ret = self.helpers:animate_text(globals.curtime(), func"CHARGING", 255, 100, 100, 255 - (150*self.weapon_fraction))
			  renderer.text(self.ss.x/2 + ((dt_size + charging_size + 2)/2) * scoped_frac + self.dop_x, self.ss.y/2 + self.ANIM+ self.dop_y + strike_h, 255, 255, 255, self.inactive_fraction * (255 - (150*self.weapon_fraction)), size .. "c", dt_size + self.inactive_fraction * charging_size + 1, func"DT ", unpack(ret))

			  local hide_size = renderer.measure_text(size, func"HIDE ")
			  local active_size = renderer.measure_text(size, func"ACTIVE")
			  renderer.text(self.ss.x/2 + ((hide_size + active_size + 2)/2) * scoped_frac + self.dop_x, self.ss.y/2 + self.ANIM+ self.dop_y + strike_h, 255, 255, 255, self.hide_fraction * (255 - (150*self.weapon_fraction)), size .. "c", hide_size + self.hide_fraction * active_size + 1, func"HIDE ", func("\a" .. self.helpers:rgba_to_hex(155, 155, 200, (255 - (150*self.weapon_fraction)) * self.hide_fraction) .. "ACTIVE"))
      
			  local ap_size, ap_h = renderer.measure_text(size, func'a-p ')
			  renderer.text(self.ss.x/2 + ((ap_size + 2)/2) * scoped_frac + self.dop_x, self.ss.y/2 + self.ANIM+ self.dop_y + strike_h + dt_h * self.helpers:easeInOut(self.fraction), 255, 255, 255, (255 - (150*self.weapon_fraction)) * self.ap_fraction, size .. "c", ap_size * self.ap_fraction, func('a-p'))
      
			  local state_size = renderer.measure_text(size, '- ' .. func(state) .. ' -')
			  renderer.text(self.ss.x/2 + ((state_size + 2)/2) * scoped_frac + self.dop_x, self.ss.y/2 + self.ANIM+ self.dop_y + (strike_h + dt_h * self.helpers:easeInOut(self.fraction)) + (ap_h * self.helpers:easeInOut(self.ap_fraction)), 255, 255, 255, 255 - (150*self.weapon_fraction), size .. "c", 0, func('- ' .. state .. ' -'))
      	end
	end,
	alphaaa = 0,
		background = function(self)
			if not self.ui.menu.tools.back_m:get() then return end 
			local gt = self.ui.menu.tools.back_slider:get() * 2,55
			local gt2 = self.ui.menu.tools.back_box:get()
			local w, h = client.screen_size()

			self.alphaaa = self.helpers:math_anim(self.alphaaa, ui.is_menu_open() and gt or 0, 16)  

			if gt2 == "-" then 
				print("ERR: Сори не доделал. Pls report to developer")
			else
				renderer.gradient(0,0,w,h,0,0,0,self.alphaaa,0,0,0,self.alphaaa,false)
			end
		end,
			alpha_value = 0,
			text_alpha = 0,
			text_alpha2 = 0,
			timer = 0, 
			display_time = 2, 
			is_displaying = false,
			is_displaying2 = false,
			anim_text = 0,
		zactavka = function(self)
			local w, h = client.screen_size()
			local r, g, b, a = self.ui.menu.global.title_name:get_color()
			
			self.alpha_value = self.helpers:math_anim(self.alpha_value, self.is_displaying and 145 or 0, 6) 
			self.text_alpha = self.helpers:math_anim(self.text_alpha, self.is_displaying and 255 or 0, 6)
			self.text_alpha2 = self.helpers:math_anim(self.text_alpha2, self.is_displaying2 and 255 or 0, 6)
			self.anim_text = self.helpers:math_anim(self.anim_text, h/2+345, 6)

			renderer.gradient(0,0,w,h,0,0,0,self.alpha_value,0,0,0,self.alpha_value,false)
			renderer.text(w/2, -300 + self.anim_text, 255, 255, 255, self.text_alpha, "c", 0, "ONESENSE \a", self.helpers:rgba_to_hex(r, g, b, self.text_alpha) .. "BETA")
			renderer.text(w/2, h/2+75, 255, 255, 255, self.text_alpha2, "c", 0, random_text_for .. "")

			if self.is_displaying and globals.realtime() - self.timer > self.display_time then
				self.is_displaying = false
				self.is_displaying2 = false
			elseif not self.is_displaying and self.timer == 0 then
				self.timer, self.is_displaying = globals.realtime(), true
				client.delay_call(0.7, function()
					self.is_displaying2 = true
				end)
			end
		end,
	}

	:struct 'round_reset' {
		auto_buy = function(self)
			if not self.ui.menu.tools.autobuy:get() then 
				return 
			end 

			if self.ui.menu.tools.autobuy_v:get() == "awp" then 
				client.exec("buy awp")
			elseif self.ui.menu.tools.autobuy_v:get() == "scar/g3sg1" then 
				if team == "t" then 
					client.exec("buy g3sg1")
				else
					client.exec("buy scar20")
				end
			elseif self.ui.menu.tools.autobuy_v:get() == "scout" then 
				client.exec("buy ssg08") 
			end
		end
	}

	:struct 'ai_peek' {
		render = function(self)
			return
		end,
	}

	:struct 'misc' {

		table_clantag = {
			"", 
			"o",
			"on",
			"one",
			"one$", 
			"ones", 
			"onese", 
			"onesen", 
			"onesen$", 
			"onesens", 

			"onesense", 
			"one$ense", 
			"onesense", 

			"onesens", 
			"onesen", 
			"onese", 
			"ones", 
			"one", 
			"on", 
			"o", 
			"",
		},
		a1312= 1, 
		clantag_time = 0, 
		clantag_direction = 1,

		return_to_string = function(self)
			local kk = 3
			return kk
		end,

		clantag = function(self)
			ui.set(self.ref.misc.clantag[1], false)
			if not self.ui.menu.tools.clantag:get() then 
				client.set_clan_tag("") 
				return 
			end

			local ct = globals.curtime()
			if self.clantag_time + 0.3 < ct then
                local current_clantag = self.table_clantag[self.a1312]
                client.set_clan_tag(current_clantag)
                self.a1312 = self.a1312 + self.clantag_direction
 
                if self.a1312 == #self.table_clantag then self.clantag_direction = -1 end
                if self.a1312 == 1 then self.clantag_direction = 1 end

				self.clantag_time = ct
			end
		end,

		chat_spamme = {
			phrases = {
				kill = {
					{"ОПЯТЬ УМЕР ОТ КОРОЛЯ", "ONESENSE ЗНАЕТ ПОЧЕМУ ТЫ УМЕР...)", "УШАСТЫЙ ПИДОРАС ПОЧЕМУ ОПЯТЬ УМЕР?"},
					{"ХАХАХАХАХАВАХВХАХВАХ", "БИЧ СНОВА УМЕР", "СОСИ ЛОШПЕДУС"},
					{"1 раб ебаный", "я те всю семью вырезал", "уебище ебаное блять"},
					{"пизда те", "немощ ты", "ебаный"},
					{"мммм АХАХАХАХХА", "ЕБУ ТЯ БОМЖИК НЕ ПУКАЙ", "бичуган"},
					{"1", "соси дальше", "бичара"},
					{"как ты так слился? бот отраханный by onesense", "1, bot ebanui", "СКАЧАЙ УЖЕ ONESENSE BETA А ТО ТЫ УМИРАЕШЬ"},
					{"уебище хочешь также разваливать?", "тогда купи 'onesense'", "1"},
					{"one", "onesense делает грязьь", "бомж без onesense еще умеет wasd нажимать(("},
					{"хохол ебливый, прикупи уже onesense", "а то че как ты умер вообще", "Бичуган ебаный, у тебя полюбому luasense либо angelwings xD"},
				},
			
				death = {
					{"щас моя братва к тебе приедет", "и вырежут тебе мать, лакерное чудовище"},
					{"играй пока тебе везёт...)))", "как ты меня убил ты же кроме wasd не умеешь ниче нажимать"},
					{"НУ ГДЕ ТИМА ЕБАНАЯ", "СУКА Я ТЕБЕ МАТЬ ВЫРЕЖУ ЩА ПИДОРАС"},
					{"К А К Т Е Б Е В Е З Ё Т", "Л А К Е Р Н О Е С У Щ Е С Т В О"},
				}
			},

			phrase_count = {
				death = 0,
				kill = 0,
			},
		},


		handle = function(self, e)

			if not self.ui.menu.tools.trashtalk:get() then
				return
			end

			local player = entity.get_local_player()

			if player == nil then
				return
			end
		
			local victim = client.userid_to_entindex(e.userid)
			local attacker = client.userid_to_entindex(e.attacker)

			self.chat_spamme.phrase_count.death = self.chat_spamme.phrase_count.death + 1

			if self.chat_spamme.phrase_count.death > #self.chat_spamme.phrases.death then
				self.chat_spamme.phrase_count.death = 1
			end
		
			self.chat_spamme.phrase_count.kill = self.chat_spamme.phrase_count.kill + 1

			if self.chat_spamme.phrase_count.kill > #self.chat_spamme.phrases.kill then
				self.chat_spamme.phrase_count.kill = 1
			end

			phrase = {
				death = self.chat_spamme.phrases.death[self.chat_spamme.phrase_count.death],
				kill = self.chat_spamme.phrases.kill[self.chat_spamme.phrase_count.kill],
			}

			if attacker == player and victim ~= player then -- Kill
				for i = 1, #phrase.kill do
					if self.ui.menu.tools.trashtalk_type:get() == "default type" then 
						client.exec(("say %s"):format(phrase.kill[i]))
						client.delay_call(1, function()
							client.exec(("say %s"):format(phrase.kill[i+1]))
						end)
						client.delay_call(2, function()
							client.exec(("say %s"):format(phrase.kill[i+2]))
						end)
					elseif self.ui.menu.tools.trashtalk_type:get() == "1 MOD" then 
						if self.ui.menu.tools.trashtalk_check2:get() then 
							client.exec(("say %s, 1"):format(entity.get_player_name(victim)))
						else
							client.exec("say 1")
						end
					elseif self.ui.menu.tools.trashtalk_type:get() == "custom phrase" then 
						client.exec("say " .. self.ui.menu.tools.trashtalk_custom:get())
					end
				end
			end
			if attacker ~= player and victim == player then -- Death 
				for i = 1, #phrase.death do
						client.exec(("say %s"):format(phrase.death[i]))
					client.delay_call(1, function()
						client.exec(("say %s"):format(phrase.death[i+1]))
					end)
				end
			end
		end
	}

	:struct "custom_hud" { 
		anim1 = 0,
		anim2 = 0,
		redc = 0,
		armc = 0,
		x1=10,
		x2=48,

		last_dmg = 0,
		alpha_dmg = 0,
		sed32 = false,
		crosshair_exec_done = false,

		cehck_dmg = function(self, event)
			local me = entity.get_local_player() 
			local hp1 = entity.get_prop(me, "m_iHealth")

			self.last_dmg = hp1

			return hp1
		end,

		red_screen = function(self)
			local me = entity.get_local_player() 
			local hp1 = entity.get_prop(me, "m_iHealth")

			if self.last_dmg > hp1 then 
				self.sed32 = true 
				client.delay_call(0.4, function()
					self.last_dmg = hp1
				end)
				client.delay_call(0.70, function()
					self.sed32 = false
				end)
			end

			if not self.ui.menu.tools.hud_enable:get() then return end
			if not self.ui.menu.tools.hud_select:get("red screen on damage")  then return end

			local ss = {client.screen_size()}
			self.ss = {
				x = ss[1],
				y = ss[2]
			}
			local a = self.ui.menu.tools.hud_reda:get()

			self.alpha_dmg = self.helpers:math_anim(self.alpha_dmg, self.sed32 and a or 0, 16)
			renderer.rectangle(0, 0, self.ss.x, self.ss.y, 235, 30, 50, self.alpha_dmg)
		end,

		crosshair = function(self)
			if not self.ui.menu.tools.hud_enable:get() then
				if not self.crosshair_exec_done then
					client.exec("cl_crosshairalpha 255")
					self.crosshair_exec_done = true
				end
				return
			end

			local me = entity.get_local_player()
			if not me or not entity.is_alive(me) then
				return 
			end 

			local scoped = entity.get_prop(me, "m_bIsScoped")

			if not self.ui.menu.tools.hud_select:get("crosshair") then
				if not self.crosshair_exec_done then
					client.exec("cl_crosshairalpha 255")
					self.crosshair_exec_done = true
				end
			else
			   self.crosshair_exec_done = false
			end

			local ss = {client.screen_size()}
			self.ss = {
				x = ss[1],
				y = ss[2]
			}

			if scoped == 1 then return end
			if self.crosshair_exec_done == false then --::REGION :: CODE ::

				local offset = self.ui.menu.tools.hud_radius:get()
				local w,w1,w2 = 190,190,190

				renderer.circle(self.ss.x/2 + 1, self.ss.y/2, 255,255,255, 65, 2, 0, 1)
				renderer.circle(self.ss.x/2, self.ss.y/2, 255,255,255, 65, 2, 0, 1)

				renderer.circle(self.ss.x/2 + 1, self.ss.y/2 + 1, 255,255,255, 65, 2, 0, 1)
				renderer.circle(self.ss.x/2, self.ss.y/2 + 1, 255,255,255, 65, 2, 0, 1)

				renderer.circle_outline(self.ss.x/2, self.ss.y/2, 255,255,255, 40, offset + 4, 255, 1, 2)

				---@#region down
					renderer.circle(self.ss.x/2, self.ss.y/2 + offset + 1, w,w1,w2, 255, 3, 40, .25)
					renderer.circle(self.ss.x/2, self.ss.y/2 + offset + 1, w,w1,w2, 255, 3, -130, .25)
					renderer.circle(self.ss.x/2, self.ss.y/2 + offset + 2, w,w1,w2, 255, 3, 145, .25) -- up
					renderer.circle(self.ss.x/2, self.ss.y/2 + offset + 1, w,w1,w2, 255, 3, -45, .25) -- down

					renderer.circle(self.ss.x/2+1, self.ss.y/2 + offset + 5, w,w1,w2, 255, 3, 240, .25) -- R
					renderer.circle(self.ss.x/2-1, self.ss.y/2 + offset + 5, w,w1,w2, 255, 3, 30, .25) -- left
					renderer.circle(self.ss.x/2-2, self.ss.y/2 + offset + 7, w,w1,w2, 255, 3, 30, .25) -- end
				---@#end

				---@#region up
					renderer.circle(self.ss.x/2, self.ss.y/2 - offset - 2, w,w1,w2, 255, 3, 40, .25)
					renderer.circle(self.ss.x/2, self.ss.y/2 - offset - 1, w,w1,w2, 255, 3, -130, .25)
					renderer.circle(self.ss.x/2, self.ss.y/2 - offset - 2, w,w1,w2, 255, 3, -20, .25) -- up
					renderer.circle(self.ss.x/2, self.ss.y/2 - offset - 1, w,w1,w2, 255, 3, 135, .25) -- down

					renderer.circle(self.ss.x/2-1, self.ss.y/2 - offset - 5, w,w1,w2, 255, 3, 50, .25) -- R
					renderer.circle(self.ss.x/2+1, self.ss.y/2 - offset - 5, w,w1,w2, 255, 3, -160, .25) -- left
					renderer.circle(self.ss.x/2+2, self.ss.y/2 - offset - 7, w,w1,w2, 255, 3, -160, .25) -- end
				---@#end


				---@#region left
					renderer.circle(self.ss.x/2 - offset, self.ss.y/2, w,w1,w2, 255, 3, -45, .25)
					renderer.circle(self.ss.x/2 - offset, self.ss.y/2, w,w1,w2, 255, 3, 135, .25)
					renderer.circle(self.ss.x/2 - offset - 1, self.ss.y/2, w,w1,w2, 255, 3, -310, .25)
					renderer.circle(self.ss.x/2 - offset , self.ss.y/2, w,w1,w2, 255, 3, -140, .25)

					renderer.circle(self.ss.x/2 - offset - 4, self.ss.y/2-1, w,w1,w2, 255, 3, -65, .25)
					renderer.circle(self.ss.x/2 - offset - 4, self.ss.y/2+1, w,w1,w2, 255, 3, 155, .25)
					renderer.circle(self.ss.x/2 - offset - 6, self.ss.y/2+2, w,w1,w2, 255, 3, 155, .25)
				---@#end


				---@#region right
					renderer.circle(self.ss.x/2 + offset, self.ss.y/2, w,w1,w2, 255, 3, -45, .25)
					renderer.circle(self.ss.x/2 + offset, self.ss.y/2, w,w1,w2, 255, 3, 135, .25)
					renderer.circle(self.ss.x/2 + offset + 1, self.ss.y/2, w,w1,w2, 255, 3, -135, .25)
					renderer.circle(self.ss.x/2 + offset , self.ss.y/2, w,w1,w2, 255, 3, 45, .25)

					renderer.circle(self.ss.x/2 + offset + 4, self.ss.y/2-1, w,w1,w2, 255, 3, -30, .25) -- R down
					renderer.circle(self.ss.x/2 + offset + 4, self.ss.y/2+1, w,w1,w2, 255, 3, 120, .25)
					renderer.circle(self.ss.x/2 + offset + 6, self.ss.y/2+2, w,w1,w2, 255, 3, 120, .25) -- R up

				---@#end

 
				client.exec("cl_crosshairalpha 0")
			end
		end,

		health_armor = function (self) 
			local me = entity.get_local_player() 

			local ss = {client.screen_size()}
			local widght = 100
			local a_back = 100
			local widght_hp = 15
			local ran1 = math.random(-5,5)

			local r,g,b = 140, 180, 50
			local r2,g2,b2 = 0, 0, 0
			local rh, gh, bh = 25, 122, 157

			self.ss = {
				x = ss[1],
				y = ss[2]
			}
			
			if not me or not entity.is_alive(me) then
				return 
			end 

			if not self.ui.menu.tools.hud_enable:get() then return end

			local hp = entity.get_prop(me, "m_iHealth")
			local armor = entity.get_prop(me, "m_ArmorValue")

			if self.sed32 then 
				ran1 = math.random(-3,3)
			else
				ran1 = 0
			end

			-- default part

			if hp >= 100 then 
				hp = 100
				self.x2 = self.helpers:math_anim(self.x2, 48, 8)
			elseif hp < 100 and hp > 9 then  
				self.x2 = self.helpers:math_anim(self.x2, 37, 8)
			elseif hp <= 9 then
				self.x2 = self.helpers:math_anim(self.x2, 26, 8)
			end

			if armor >= 100 then 
				armor = 100
				self.x1 = self.helpers:math_anim(self.x1, 48, 8)
			elseif armor < 100 and armor > 9 then  
				self.x1 = self.helpers:math_anim(self.x1, 37, 8)
			elseif armor <= 9 then
				self.x1 = self.helpers:math_anim(self.x1, 26, 8)
			end

			-- COLOR PART

			if hp >= 87 then
				r, g, b = 140, 180, 50  -- зеленый
				r2, g2, b2 = 14, 14, 14
			elseif hp <= 34 then
				r, g, b = 255, 50, 80 -- красный
				r2, g2, b2 = 14, 0, 0 
			else
				r, g, b = 169, 162, 80 -- желтый
				r2, g2, b2 = 20, 20, 12
			end

			self.anim1 = self.helpers:math_anim(self.anim1, hp, 7)
			self.anim2 = self.helpers:math_anim(self.anim2, armor, 5)
			self.redc = self.helpers:math_anim(self.redc, hp, 4)
			self.armc = self.helpers:math_anim(self.armc, armor, 4)

			if self.ui.menu.tools.hud_select:get("h-a") then
				---@region #hp start
				if self.ui.menu.tools.hud_hp:get() then
					renderer.rectangle(self.ss.x/2 + ran1 - widght, self.ss.y/2 + 342 + ran1, widght *2, widght_hp - 1, r2,g2,b2, a_back) -- hp

					renderer.circle_outline(self.ss.x/2 + ran1 - widght + self.redc * 1.9 + 10, self.ss.y/2 + 349 + ran1, 255, 50, 80, 255, 7, -90, .25, 7) -- up right | move dmg
					renderer.circle_outline(self.ss.x/2 + ran1 - widght + self.redc * 1.9 + 10, self.ss.y/2 + 349 + ran1, 255, 50, 80, 255, 7, 0, .25, 7) -- down right | move dmg 

					renderer.rectangle(self.ss.x/2 + ran1 - widght, self.ss.y/2 + 342 + ran1, self.redc * 1.9 + 11, widght_hp - 1, 255, 50, 80, 255) -- red hp damage
					renderer.rectangle(self.ss.x/2 + ran1 - widght, self.ss.y/2 + 342 + ran1, self.anim1 * 1.9 + 11, widght_hp - 1, r,g,b, 255) -- hp fill

					renderer.circle_outline(self.ss.x/2 + ran1 - widght, self.ss.y/2 + 349 + ran1, r, g, b, 255, 7, 180, .25, 7) -- up left
					renderer.circle_outline(self.ss.x/2 + ran1 - widght, self.ss.y/2 + 349 + ran1, r, g, b, 255, 7, 90, .25, 7) -- down left
					
					renderer.circle_outline(self.ss.x/2 + ran1 - widght + 200, self.ss.y/2 + 349 + ran1, r2,g2,b2, a_back, 7, -90, .25, 7) -- up right
					renderer.circle_outline(self.ss.x/2 + ran1 - widght + 200, self.ss.y/2 + 349 + ran1, r2,g2,b2, a_back, 7, 0, .25, 7) -- down right

					renderer.circle_outline(self.ss.x/2 + ran1 - widght + self.anim1 * 1.9 + 10, self.ss.y/2 + 349 + ran1, r, g, b, 255, 7, -90, .25, 7) -- up right | move
					renderer.circle_outline(self.ss.x/2 + ran1 - widght + self.anim1 * 1.9 + 10, self.ss.y/2 + 349 + ran1, r, g, b, 255, 7, 0, .25, 7) -- down right | move

					renderer.text(self.ss.x/2 - 10 + ran1, self.ss.y/2 + 332 + ran1, 255, 255, 255, 255, "+", nil, " / 100")
					renderer.text(self.ss.x/2 - self.x2 + ran1, self.ss.y/2 + 332 + ran1, 255, 255, 255, 255, "+", nil, hp)
				end
				---@region #hp end

				---@region #armor start
				if self.ui.menu.tools.hud_armor:get() then
					renderer.rectangle(self.ss.x/2 - widght + ran1, self.ss.y/2 + 365 + ran1, widght *2, widght_hp - 1, 14, 14, 14, a_back) -- background armor

					renderer.circle_outline(self.ss.x/2 + ran1 - widght + self.anim2 * 1.9 + 11, self.ss.y/2 + 372 + ran1, rh,gh,bh, 255, 7, -90, .25, 7) -- up right | move dmg
					renderer.circle_outline(self.ss.x/2 + ran1 - widght + self.anim2 * 1.9 + 11, self.ss.y/2 + 372 + ran1, rh,gh,bh, 255, 7, 0, .25, 7) -- down right | move dmg
					
					renderer.rectangle(self.ss.x/2 - widght + ran1, self.ss.y/2 + 365 + ran1, self.anim2 * 1.9 + 11, widght_hp - 1, rh,gh,bh, 255) -- ar fill
					
					renderer.circle_outline(self.ss.x/2 + ran1 - widght, self.ss.y/2 + 372 + ran1, rh,gh,bh, 255, 7, 180, .25, 7) -- up left
					renderer.circle_outline(self.ss.x/2 + ran1 - widght, self.ss.y/2 + 372 + ran1, rh,gh,bh, 255, 7, 90, .25, 7) -- down left
					renderer.circle_outline(self.ss.x/2 + ran1 - widght + 200, self.ss.y/2 + 372 + ran1, 14,14,14, a_back, 7, -90, .25, 7) -- up right
					renderer.circle_outline(self.ss.x/2 + ran1 - widght + 200, self.ss.y/2 + 372 + ran1, 14,14,14, a_back, 7, 0, .25, 7) -- down right
					
					renderer.circle_outline(self.ss.x/2 + ran1 - widght + self.anim2 * 1.9 + 10, self.ss.y/2 + 372 + ran1, rh, gh, bh, 255, 7, -90, .25, 7) -- up right | move
					renderer.circle_outline(self.ss.x/2 + ran1 - widght + self.anim2 * 1.9 + 10, self.ss.y/2 + 372 + ran1, rh, gh, bh, 255, 7, 0, .25, 7) -- down right | move
					
					renderer.text(self.ss.x/2 - 10 + ran1, self.ss.y/2 + 355 + ran1, 255, 255, 255, 255, "+", nil, " / 100")
					renderer.text(self.ss.x/2 - self.x1 + ran1, self.ss.y/2 + 355 + ran1, 255, 255, 255, 255, "+", nil, armor)--]]
				end
				---@region #armor end
			end
		end, 
	} 

	:struct "logs" {

		hitboxes = { [0] = 'body', 'head', 'chest', 'stomach', 'left arm', 'right arm', 'left leg', 'right leg', 'neck', '?', 'gear'},
		missed = "",

		miss = function(self, shot)

			if not self.ui.menu.tools.notify_master:get() then 
				return 
			end

			local me = entity.get_local_player()
			local first_velocity = entity.get_prop(me, "m_vecVelocity[0]")
			local second_velocity = entity.get_prop(me, "m_vecVelocity[1]")
			local velocity = math.floor(math.sqrt(first_velocity*first_velocity+second_velocity*second_velocity))

			if self.ui.menu.tools.notify_vibor:get("miss") then
		
				local target = entity.get_player_name(shot.target)
				local hitbox = self.hitboxes[shot.hitgroup] or "?"

				self.missed = shot.reason

				if self.missed == "spread" and self.helpers:in_air(me) then 
					self.missed = "air spread"
				elseif self.missed == "spread" and velocity > 194 then
				    self.missed = "spread"
				elseif self.missed == "spread" and velocity > 87 and velocity < 193 then
					self.missed = "enemy lucky"
				elseif self.missed == "?" then 
					self.missed = "unknown"
				end
		
				notify.new_bottom(255,255,255, { { "Missed " }, {target, true}, {"'s in "}, {hitbox, true}, {" due "}, { self.missed, true }})
			end
		end,
		hit = function(self, shot)
			if not self.ui.menu.tools.notify_master:get() then
				return 
			end

			if self.ui.menu.tools.notify_vibor:get("hit") then
				local target = entity.get_player_name(shot.target)
				local hitbox = self.hitboxes[shot.hitgroup] or "?"
		
				notify.new_bottom(255,255,255, {{ "Hit " }, {target, true}, {"'s in "}, {hitbox, true}, {" for "}, { shot.damage, true }})
			end
		end,
		shot = 0,
		evade = function(self, event)
			if not self.ui.menu.tools.notify_master:get() then return end

			local lp = entity.get_local_player()
		
			if lp == nil then 
				return 
			end
		
			local enemy = client.userid_to_entindex(event.userid)
			local enemy_name = entity.get_player_name(enemy)

			if enemy == entity.get_local_player() or not entity.is_enemy(enemy) or not entity.is_alive(lp) then return nil end
			if fired_at(lp, enemy, {event.x, event.y, event.z}) then
				if self.shot ~= globals.tickcount() then
					if self.ui.menu.tools.notify_vibor:get("shot opponent") then
						notify.new_bottom(255,255,255, {{enemy_name, true}, {"'s "}, {"shot ",true},{"at you"}})
					end
					self.shot = globals.tickcount()
				end
			end
		end,

		harmed = function(self, event)
			if not self.ui.menu.tools.notify_master:get() then return end

			local lp = entity.get_local_player()
			local attacker = client.userid_to_entindex(event.attacker)
			local us_id = client.userid_to_entindex(event.userid)
			local damaged = event.dmg_health
			local name_attack = entity.get_player_name(attacker)
			local group = self.hitboxes[event.hitgroup]

			if attacker == lp then return end 
			if us_id ~= lp then return end

			if self.ui.menu.tools.notify_vibor:get("get harmed") then
				notify.new_bottom(255,255,255, { { "Get " .. damaged .. " damage by " }, { name_attack .. "'s in " .. group, true }, })
			end
		end
	}

	:struct "ind_dmg" {

		ss = {client.screen_size()},

		run = function(self)

			if not self.ui.menu.tools.indicator_dmg:get() then 
				return
			end

			local lp = entity.get_local_player()

			if not entity.is_alive(lp) then 
				return 
			end

			local r, g, b, a = self.ui.menu.tools.indicator_dmg:get_color()
			local only_md = self.ui.menu.tools.indicator_dmg_weapon:get()
			local output = ""

			if self.ref.rage.ovr[2] then

				if only_md then 
					if ui.get(self.ref.rage.ovr[2]) then
						output = self.helpers:get_damage() .. ""
					else
						output = ""
					end
				else
					output = self.helpers:get_damage() .. ""
				end
			end
			renderer.text(self.ss[1] / 2 + 5, self.ss[2] / 2 - 17, r, g, b, a, "d", 0, output .. "") 
		end
	}

for _, eid in ipairs({
	{
		"load", function()
			ctx.ui:execute()
			ctx.config:setup()
		end
	},
	{
		"aim_miss", function(shot)
			ctx.logs:miss(shot)
		end
	},
	{
		"aim_fire", function()
			shots.total = shots.total + 1
		end
	},
	{
		"aim_hit", function(shot)
			ctx.logs:hit(shot)
			shots.hits = shots.hits + 1
		end
	},
	{
		"player_connect_full", function(e)
			if client.userid_to_entindex(e['userid']) ~= entity.get_local_player() then
				return
			end

			shots.hits = 0
			shots.total = 0
		end
	},
	{
		"bullet_impact", function(event)
			ctx.logs:evade(event)
		end
	},
	{
		"player_death", function(e)
			ctx.misc:handle(e)
		end
	},
	{
		"player_hurt", function(event)
			ctx.logs:harmed(event)
			ctx.custom_hud:cehck_dmg(event)
		end
	},
	{
		"setup_command", function(cmd)
			--cmd.force_defensive = 1
			ctx.antiaim:run(cmd)
			ctx.antiaim:animations_helper(cmd)
			ctx.prediction:compensate_lag(cmd)
		end
	},
	{
		"shutdown", function()
			ctx.ui:shutdown()
		end
	},
	{
		"run_command", function()
			ctx.helpers:in_ladder()
		end
	},
	{
		"paint", function()
			if not ctx.ui.menu.tools.clantag:get() then
				client.set_clan_tag("")
			else
				ctx.misc:clantag()
			end
			ctx.ai_peek:render()
			ctx.custom_hud:red_screen()
			ctx.tools:render()
			ctx.tools:background()
			ctx.custom_hud:health_armor()
			ctx.custom_hud:crosshair()
			ctx.ind_dmg:run()
		end
	},
	{
		"paint_ui", function()
			ctx.helpers:menu_visibility(false)
			ctx.tools:hit_rate()
			ctx.tools:menu_vis()
			ctx.prediction:configure_client_interp()
			ctx.tools:notify_cfg()
			ctx.tools:zactavka()
		end
	},
	{
		"pre_render", function()
			ctx.antiaim:animations()
		end
	},
	{
		"round_prestart", function()
			ctx.round_reset:auto_buy()
		end
	},
	{
		"predict_command", function()
			ctx.defensive:predict()
		end
	},
	{
		"level_init", function()
			ctx.defensive:reset()
			ctx.antiaim.peeked = 0
			ctx.globals.in_ladder = 0
		end
	},
	{
		"net_update_end", function()
			ctx.defensive:defensivestatus()
			ctx.defensive:defensive_active()
		end
	},
}) do
	if eid[1] == "load" then
		eid[2]()
	else
		client.set_event_callback(eid[1], eid[2])
	end
end

database.flush()