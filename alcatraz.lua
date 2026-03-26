local pui = require("gamesense/pui")
local base64 = require("gamesense/base64")
local clipboard = require("gamesense/clipboard")
local vector = require("vector")
local color = require("gamesense/color")
local antiaim_funcs = require("gamesense/antiaim_funcs")
local ent = require("gamesense/entity")
local ffi = require 'ffi'
local csgo_weapons = require "gamesense/csgo_weapons"
local images = require 'gamesense/images'
local http = require 'gamesense/http'


local menu_element = {}
local manuals_table = {}
local defensive_additional = {}
local _entity = {}
local screen = client.screen_size
local group_fakelag = {"AA", "Fake lag"}
local group_anti_aimbot = {"AA", "Anti-aimbot angles"}
local group_other = {"AA", "Other"}
local information = {user = 'чмо', id = '1', version = 'debug'}
local hitgroup_names = {'generic', 'head', 'chest', 'stomach', 'left arm', 'right arm', 'left leg', 'right leg', 'neck', '?', 'gear'}
local rage, visuals, anti_aim, misc = {}, {}, {}, {}

local condition_states = {
    'Shared',
    'Standing',
    'Moving',
    'Walking',
    'Crouching',
    'Air',
    'Air-C',
    'Freestanding',
}

local lua_banner = [[                                                                                                           
     █████╗ ██╗      ██████╗ █████╗ ████████╗██████╗  █████╗ ███████╗
    ██╔══██╗██║     ██╔════╝██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗╚══███╔╝
    ███████║██║     ██║     ███████║   ██║   ██████╔╝███████║  ███╔╝ 
    ██╔══██║██║     ██║     ██╔══██║   ██║   ██╔══██╗██╔══██║ ███╔╝  
    ██║  ██║███████╗╚██████╗██║  ██║   ██║   ██║  ██║██║  ██║███████╗
    ╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝  
    
    
    dont buy this lua
    free trial$$$$$
]]

local native_get_client_entity = vtable_bind("client.dll", "VClientEntityList003", 3, "void*(__thiscall*)(void*, int)")
local animstate_t = ffi.typeof 'struct { char pad0[0x18]; float anim_update_timer; char pad1[0xC]; float started_moving_time; float last_move_time; char pad2[0x10]; float last_lby_time; char pad3[0x8]; float run_amount; char pad4[0x10]; void* entity; void* active_weapon; void* last_active_weapon; float last_client_side_animation_update_time; int  last_client_side_animation_update_framecount; float eye_timer; float eye_angles_y; float eye_angles_x; float goal_feet_yaw; float current_feet_yaw; float torso_yaw; float last_move_yaw; float lean_amount; char pad5[0x4]; float feet_cycle; float feet_yaw_rate; char pad6[0x4]; float duck_amount; float landing_duck_amount; char pad7[0x4]; float current_origin[3]; float last_origin[3]; float velocity_x; float velocity_y; char pad8[0x4]; float unknown_float1; char pad9[0x8]; float unknown_float2; float unknown_float3; float unknown; float m_velocity; float jump_fall_velocity; float clamped_velocity; float feet_speed_forwards_or_sideways; float feet_speed_unknown_forwards_or_sideways; float last_time_started_moving; float last_time_stopped_moving; bool on_ground; bool hit_in_ground_animation; char pad10[0x4]; float time_since_in_air; float last_origin_z; float head_from_ground_distance_standing; float stop_to_full_running_fraction; char pad11[0x4]; float magic_fraction; char pad12[0x3C]; float world_force; char pad13[0x1CA]; float min_yaw; float max_yaw; } **'
local animlayer_t = ffi.typeof 'struct { char pad_0x0000[0x18]; uint32_t sequence; float prev_cycle; float weight; float weight_delta_rate; float playback_rate; float cycle;void *entity;char pad_0x0038[0x4]; } **'

math.round = function (v)  return math.floor(v + 0.5)  end
math.roundb = function (v, d)  return math.floor(v + 0.5) / (d or 0) ^ 1  end
math.clamp = function (x, a, b) if a > x then return a elseif b < x then return b else return x end end
math.lerp = function (a, b, w)  return a + (b - a) * w  end
math.normalize_yaw = function (yaw) return (yaw + 180) % -360 + 180 end
math.normalize_pitch = function (pitch) return math.clamp(pitch, -89, 89) end

_entity.get_pointer = function (ent)
    return native_get_client_entity(ent)
end

_entity.get_animstate = function (ent)
    local pointer = native_get_client_entity(ent)
    if pointer then return ffi.cast(animstate_t, ffi.cast("char*", ffi.cast("void***", pointer)) + 0x9960)[0] end
end

_entity.get_animlayer = function (ent, layer)
    local pointer = native_get_client_entity(ent)
    if pointer then return ffi.cast(animlayer_t, ffi.cast('char*', ffi.cast("void***", pointer)) + 0x3914)[0][layer or 0] end
end

_entity.get_simtime = function (ent)
    local pointer = native_get_client_entity(ent)
    if pointer then return entity.get_prop(ent, "m_flSimulationTime"), ffi.cast("float*", ffi.cast("uintptr_t", pointer) + 0x26C)[0] else return 0 end
end

_entity.get_max_desync = function (animstate)
    local speedfactor = math.clamp(animstate.feet_speed_forwards_or_sideways, 0, 1)
    local avg_speedfactor = (animstate.stop_to_full_running_fraction * -0.3 - 0.2) * speedfactor + 1

    local duck_amount = animstate.duck_amount
    if duck_amount > 0 then
        local duck_speed = duck_amount * speedfactor

        avg_speedfactor = avg_speedfactor + (duck_speed * (0.5 - avg_speedfactor))
    end

    return math.clamp(avg_speedfactor, .5, 1)
end

local safe_function = function (...) return ... end

function get_localplayer(type)
    local localplayer = type == 1 and entity.get_local_player() or ent.get_local_player()
    local me = localplayer
    if not me then return end
    return me
end

--[[local native_GetClientEntity = vtable_bind('client.dll', 'VClientEntityList003', 3, 'void*(__thiscall*)(void*, int)')

function handle_defensive()
    local lp = entity.get_local_player()

    if lp == nil or not entity.is_alive(lp) then
        return
    end

    local Entity = native_GetClientEntity(lp)
    local m_flOldSimulationTime = ffi.cast("float*", ffi.cast("uintptr_t", Entity) + 0x26C)[0]
    local m_flSimulationTime = entity.get_prop(lp, "m_flSimulationTime")

    local delta = m_flOldSimulationTime - m_flSimulationTime

    if delta > 0 then
        restore_values.defensive = globals.tickcount() + toticks(delta - (client.real_latency() * 0.8))-- - client.real_latency()
        return
    end
end]]

function is_vulnerable()
    for _ , iv in ipairs(entity.get_players(true)) do
        local flags = (entity.get_esp_data(iv)).flags

        if bit.band(flags, bit.lshift(1, 11)) ~= 0 then
            return true
        end
    end

    return false
end

local function lerp(x, v, t)
    if type(x) == 'table' then
        return lerp(x[1], v[1], t), lerp(x[2], v[2], t), lerp(x[3], v[3], t), lerp(x[4], v[4], t)
    end

    local delta = v - x

    if type(delta) == 'number' then
        if math.abs(delta) < 0.005 then
            return v
        end
    end

    return delta * t + x
end

local function breathe(offset, multiplier)
    local speed = globals.realtime() * (multiplier or 1.0);
    local factor = speed % math.pi;

    local sin = math.sin(factor + (offset or 0));
    local abs = math.abs(sin);

    return abs
end

function colored_text(element,text, main_color, back_colork)
    if element ~= nil then
        if not ui.is_menu_open() then
            return
        end
    end

    local text = text
    local length = #text + 1
    local light = ''

    local main_color = { main_color[1], main_color[2], main_color[3], main_color[4]--[[ref.misc.color:get()]] }
    local back_color = { back_colork[1], back_colork[2], back_colork[3], back_colork[4] }
    local side = -1

    for idx = 1, length do
        local letter = text:sub(idx, idx)

        local factor = (idx - 1) / length
        local breathe = breathe(side * factor * 1.5, 1.5)

        local r, g, b, a = lerp({ back_color[1], back_color[2], back_color[3], back_color[4] }, { main_color[1], main_color[2], main_color[3], main_color[4] }, breathe)

        local hex_color = color(r, g, b, a):to_hex()
        light = light .. '\a' .. (hex_color .. letter)
    end
    if element == nil then
        return light
    else
        element:set(light)
    end
end

rgba_to_hex = function(b, c, d, e) e = e or 255 return string.format('%02x%02x%02x%02x', b, c, d, e) end
hex_to_rgba = function(hex) return tonumber('0x' .. hex:sub(1, 2)), tonumber('0x' .. hex:sub(3, 4)), tonumber('0x' .. hex:sub(5, 6)), tonumber('0x' .. hex:sub(7, 8)) or 255 end

function on_ground()
    local flags = entity.get_prop(get_localplayer(1), "m_fFlags")
    return bit.band(flags, bit.lshift(1, 0)) == bit.lshift(1, 0)
end

function set_visible(x, b)
    if type(x) == 'table' then
        for k, v in pairs(x) do
            v:set_visible(b)
        end
        return
    end
    x:set_visible(b)
end

--pui.accent = --'A998FFFF'

local ignored_elements = {
    settings = {
        enable = true,
        label = true,
        selection = true,
    },
    anti_aim = {
        label_selection = true,
        space = true,
        selection = true,
    },
    fakelag = {
        space = true,
        enable = true,
        label = true
    }
}

local selection_names = {
    home = "Home",
    settings = "Settings",
    anti_aim = "Anti-Aim",
}

local selection_names_anti_aim = {
    features = "Features",
    builder = "Builder",
}

local label_names = {
    ragebot = 'Ragebot', visuals = 'Visuals', misc = 'Misc'
}

local cfg_tbl = {
    {
        name = "Default",
        data = "eyJlbmFibGUiOnRydWUsInNlbGVjdGlvbiI6IkhvbWUiLCJhbnRpX2FpbSI6eyJidWlsZGVyIjp7ImVuYWJsZSI6dHJ1ZSwiY29uZGl0aW9uIjoiQ3JvdWNoaW5nIiwiZGVmZW5zaXZlIjpbeyJlbmFibGUiOmZhbHNlLCJ5YXdfdHlwZSI6IlNwaW4iLCJwaXRjaCI6Ilplcm8iLCJvbl9vbnNob3QiOmZhbHNlLCJwaXRjaF92YWx1ZSI6LTg5LCJ5YXdfdmFsdWUiOjIzfSx7ImVuYWJsZSI6ZmFsc2UsInlhd190eXBlIjoiMTgwIiwicGl0Y2giOiJVcCIsIm9uX29uc2hvdCI6ZmFsc2UsInBpdGNoX3ZhbHVlIjowLCJ5YXdfdmFsdWUiOjB9LHsiZW5hYmxlIjp0cnVlLCJ5YXdfdHlwZSI6IlNwaW4iLCJwaXRjaCI6IlVwIiwib25fb25zaG90IjpmYWxzZSwicGl0Y2hfdmFsdWUiOjAsInlhd192YWx1ZSI6MjN9LHsiZW5hYmxlIjpmYWxzZSwieWF3X3R5cGUiOiJPZmYiLCJwaXRjaCI6Ik9mZiIsIm9uX29uc2hvdCI6ZmFsc2UsInBpdGNoX3ZhbHVlIjowLCJ5YXdfdmFsdWUiOjB9LHsiZW5hYmxlIjp0cnVlLCJ5YXdfdHlwZSI6IlNpZGUtV2F5cyIsInBpdGNoIjoiVXAiLCJvbl9vbnNob3QiOnRydWUsInBpdGNoX3ZhbHVlIjowLCJ5YXdfdmFsdWUiOjIzfSx7ImVuYWJsZSI6dHJ1ZSwieWF3X3R5cGUiOiJTaWRlLVdheXMiLCJwaXRjaCI6IlVwIiwib25fb25zaG90Ijp0cnVlLCJwaXRjaF92YWx1ZSI6MCwieWF3X3ZhbHVlIjo0NH0seyJlbmFibGUiOnRydWUsInlhd190eXBlIjoiU2lkZS1XYXlzIiwicGl0Y2giOiJVcCIsIm9uX29uc2hvdCI6dHJ1ZSwicGl0Y2hfdmFsdWUiOjAsInlhd192YWx1ZSI6NDV9LHsiZW5hYmxlIjp0cnVlLCJ5YXdfdHlwZSI6IjE4MCIsInBpdGNoIjoiVXAiLCJvbl9vbnNob3QiOmZhbHNlLCJwaXRjaF92YWx1ZSI6MCwieWF3X3ZhbHVlIjoxODB9XSwiZWxlbWVudCI6W3sieWF3X3R5cGUiOiJEZWxheWVkIiwicGl0Y2giOiJEZWZhdWx0IiwiYm9keV95YXciOiJPZmYiLCJqaXR0ZXJfdmFsdWUiOjAsImZvcmNlX2xhZ2NvbXAiOnRydWUsImZzX2JvZHlfeWF3Ijp0cnVlLCJ5YXciOiIxODAiLCJib2R5X3lhd192YWx1ZSI6LTEsImxlZnRfeWF3X3ZhbHVlIjotMTUsImRlbGF5IjozLCJ5YXdfaml0dGVyIjoiT2ZmIiwicmlnaHRfeWF3X3ZhbHVlIjoyMCwieWF3X2Jhc2UiOiJBdCB0YXJnZXRzIiwib3ZlcnJpZGVfc3RhdGUiOnRydWV9LHsieWF3X3R5cGUiOiJEZWxheWVkIiwicGl0Y2giOiJEZWZhdWx0IiwiYm9keV95YXciOiJKaXR0ZXIiLCJqaXR0ZXJfdmFsdWUiOjAsImZvcmNlX2xhZ2NvbXAiOnRydWUsImZzX2JvZHlfeWF3IjpmYWxzZSwieWF3IjoiMTgwIiwiYm9keV95YXdfdmFsdWUiOi0xLCJsZWZ0X3lhd192YWx1ZSI6LTIwLCJkZWxheSI6NCwieWF3X2ppdHRlciI6Ik9mZiIsInJpZ2h0X3lhd192YWx1ZSI6MjAsInlhd19iYXNlIjoiQXQgdGFyZ2V0cyIsIm92ZXJyaWRlX3N0YXRlIjp0cnVlfSx7Inlhd190eXBlIjoiRGVmYXVsdCIsInBpdGNoIjoiRGVmYXVsdCIsImJvZHlfeWF3IjoiSml0dGVyIiwiaml0dGVyX3ZhbHVlIjo1MiwiZm9yY2VfbGFnY29tcCI6ZmFsc2UsImZzX2JvZHlfeWF3Ijp0cnVlLCJ5YXciOiIxODAiLCJib2R5X3lhd192YWx1ZSI6MSwibGVmdF95YXdfdmFsdWUiOi0xMCwiZGVsYXkiOjQsInlhd19qaXR0ZXIiOiJPZmYiLCJyaWdodF95YXdfdmFsdWUiOjEwLCJ5YXdfYmFzZSI6IkF0IHRhcmdldHMiLCJvdmVycmlkZV9zdGF0ZSI6dHJ1ZX0seyJ5YXdfdHlwZSI6IkRlZmF1bHQiLCJwaXRjaCI6Ik9mZiIsImJvZHlfeWF3IjoiT2ZmIiwiaml0dGVyX3ZhbHVlIjowLCJmb3JjZV9sYWdjb21wIjpmYWxzZSwiZnNfYm9keV95YXciOmZhbHNlLCJ5YXciOiJPZmYiLCJib2R5X3lhd192YWx1ZSI6MCwibGVmdF95YXdfdmFsdWUiOjAsImRlbGF5IjoyLCJ5YXdfaml0dGVyIjoiT2ZmIiwicmlnaHRfeWF3X3ZhbHVlIjowLCJ5YXdfYmFzZSI6IkxvY2FsIHZpZXciLCJvdmVycmlkZV9zdGF0ZSI6ZmFsc2V9LHsieWF3X3R5cGUiOiJEZWxheWVkIiwicGl0Y2giOiJEZWZhdWx0IiwiYm9keV95YXciOiJPZmYiLCJqaXR0ZXJfdmFsdWUiOjAsImZvcmNlX2xhZ2NvbXAiOnRydWUsImZzX2JvZHlfeWF3IjpmYWxzZSwieWF3IjoiMTgwIiwiYm9keV95YXdfdmFsdWUiOjAsImxlZnRfeWF3X3ZhbHVlIjotMTUsImRlbGF5IjoyLCJ5YXdfaml0dGVyIjoiT2ZmIiwicmlnaHRfeWF3X3ZhbHVlIjoyNSwieWF3X2Jhc2UiOiJBdCB0YXJnZXRzIiwib3ZlcnJpZGVfc3RhdGUiOnRydWV9LHsieWF3X3R5cGUiOiJEZWZhdWx0IiwicGl0Y2giOiJEZWZhdWx0IiwiYm9keV95YXciOiJKaXR0ZXIiLCJqaXR0ZXJfdmFsdWUiOjI3LCJmb3JjZV9sYWdjb21wIjp0cnVlLCJmc19ib2R5X3lhdyI6dHJ1ZSwieWF3IjoiMTgwIiwiYm9keV95YXdfdmFsdWUiOi0xLCJsZWZ0X3lhd192YWx1ZSI6MCwiZGVsYXkiOjQsInlhd19qaXR0ZXIiOiJPZmYiLCJyaWdodF95YXdfdmFsdWUiOjAsInlhd19iYXNlIjoiQXQgdGFyZ2V0cyIsIm92ZXJyaWRlX3N0YXRlIjp0cnVlfSx7Inlhd190eXBlIjoiRGVmYXVsdCIsInBpdGNoIjoiRGVmYXVsdCIsImJvZHlfeWF3IjoiSml0dGVyIiwiaml0dGVyX3ZhbHVlIjoyNywiZm9yY2VfbGFnY29tcCI6dHJ1ZSwiZnNfYm9keV95YXciOnRydWUsInlhdyI6IjE4MCIsImJvZHlfeWF3X3ZhbHVlIjotMSwibGVmdF95YXdfdmFsdWUiOjAsImRlbGF5Ijo0LCJ5YXdfaml0dGVyIjoiT2ZmIiwicmlnaHRfeWF3X3ZhbHVlIjowLCJ5YXdfYmFzZSI6IkF0IHRhcmdldHMiLCJvdmVycmlkZV9zdGF0ZSI6dHJ1ZX0seyJ5YXdfdHlwZSI6IkRlZmF1bHQiLCJwaXRjaCI6IkRlZmF1bHQiLCJib2R5X3lhdyI6IkppdHRlciIsImppdHRlcl92YWx1ZSI6MCwiZm9yY2VfbGFnY29tcCI6dHJ1ZSwiZnNfYm9keV95YXciOnRydWUsInlhdyI6IjE4MCIsImJvZHlfeWF3X3ZhbHVlIjotMSwibGVmdF95YXdfdmFsdWUiOi0zNCwiZGVsYXkiOjIsInlhd19qaXR0ZXIiOiJPZmYiLCJyaWdodF95YXdfdmFsdWUiOjM0LCJ5YXdfYmFzZSI6IkF0IHRhcmdldHMiLCJvdmVycmlkZV9zdGF0ZSI6dHJ1ZX1dfSwic2VsZWN0aW9uIjoiQnVpbGRlciIsImZlYXR1cmVzIjp7Im92ZXJyaWRlX2RlZmVuc2l2ZSI6dHJ1ZSwiZWRnZV95YXdfa2V5X2giOlsyLDg2LCJ+Il0sImxpc3QiOlsiQXZvaWQgQmFja3N0YWIiLCJEZWZlbnNpdmUgYW50aS1haW0iLCJTYWZlIEhlYWQiLCJGYXN0IGxhZGRlciIsIk5vIGNob2tpbmciLCJ+Il0sImZyZWVzdGFuZGluZ19rZXlfaCI6WzEsNiwifiJdLCJhbmltYXRpb24iOnsiZW5hYmxlIjp0cnVlLCJzZWxlY3Rpb24iOlsiTGFuZGluZyBsZWdzIiwiQWlyIGxlZ3MiLCJNb3ZlIGxlYW4iLCJQZXJmZWN0IGZha2UgZHVjayIsIn4iXSwibGFuZGluZ19sZWdzX3R5cGUiOiJLaW5ndXJ1IiwiYWlyX2xlZ3NfdHlwZSI6Iktpbmd1cnUiLCJsZWFuX211bHRpcGxpZSI6MTAwfSwibWFudWFscyI6eyJiaW5kcyI6eyJyaWdodF9oIjpbMSwwLCJ+Il0sImxlZnRfaCI6WzEsMCwifiJdLCJmb3J3YXJkX2giOlsxLDAsIn4iXX19LCJzYWZlX2hlYWRfY29uZGl0aW9uYWwiOlsiS25pZmUiLCJaZXVzIiwifiJdLCJmYWtlbGFnIjp7ImVuYWJsZSI6dHJ1ZSwibGltaXQiOjE0LCJmYWtlbGFnX2Rpc2FibGVycyI6WyJEb3VibGV0YXAiLCJPbi1zaG90IGFudGktYWltIiwifiJdLCJhbW91bnQiOiJEeW5hbWljIiwidmFyaWFuY2UiOjE1fX19LCJob21lIjp7ImFjY2VudF9jb2xvcl9jIjoiIzgyNzhGOEZGIiwiY2ZnX2xpc3QiOjEsImNmZ19uYW1lX3RleHQiOiIifSwic2V0dGluZ3MiOnsicmFnZWJvdCI6eyJwcmVmZXJfYmFpbSI6dHJ1ZSwiZm9yY2VfY2hhcmdlIjp0cnVlLCJmb3JjZV9wcmVkaWN0X2giOlsxLDAsIn4iXSwidGVsZXBvcnRfaW5fYWlyX3R5cGUiOiJEZWZhdWx0IiwiYWltYm90X2xvZ2dpbmciOnRydWUsImZvcmNlX3ByZWRpY3QiOmZhbHNlLCJ0ZWxlcG9ydF9pbl9haXIiOmZhbHNlLCJyZXNvbHZlciI6dHJ1ZX0sInZpc3VhbHMiOnsiZmFkZV9jb2xvcl8yX2MiOiIjODc3REZGRkYiLCJhc3BlY3RfcmF0aW8iOnRydWUsIndhdGVybWFya19jb2xvcl9jIjoiI0ZGRkZGRkZGIiwiZmFkZV9jb2xvcl9jIjoiI0ZGRkZGRkZGIiwid2F0ZXJtYXJrIjpmYWxzZSwic2NyZWVuX2luZGljYXRpb24iOmZhbHNlLCJhc3BlY3RfcmF0aW9fdiI6MTAwLCJkYW1hZ2VfaW5kaWNhdGlvbiI6ZmFsc2UsIndhdGVybWFya19wb3NpdGlvbiI6IkxlZnQifSwibWlzYyI6eyJjb25zb2xlX2ZpbHRlciI6dHJ1ZSwiZmFrZV9waW5nIjpmYWxzZSwiZmFrZV9waW5nX3ZhbHVlIjoyMDB9fX0="
    }
}

menu_element = {
    enable = pui.checkbox(group_anti_aimbot, '\n alcaraz main checkbox'), --'\b' .. pui.accent.. '\b685F95[alcatraz]'
    label = pui.label(group_anti_aimbot, 'alcaraz'),
    selection = pui.combobox(group_anti_aimbot, '\n selection', {'Home', 'Settings', 'Anti-Aim'}, false),
    home = {
        pui.label(group_fakelag, '\n'),
        info = pui.label(group_fakelag, '\a'.. pui.accent .. '•\r Information'),
        pui.label(group_fakelag, '\a464646CC¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯'),
        build = pui.label(group_fakelag, '\a'.. pui.accent .. '•\r Version: crack'),
        user = pui.label(group_fakelag, '\a'.. pui.accent .. '•\r User: wxhs'),
        pui.label(group_fakelag, '\a464646CC¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯'),
        setting = pui.label(group_fakelag, '\a'.. pui.accent .. '•\r Setting'),
        pui.label(group_fakelag, '\a464646CC¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯'),
        accent_color = pui.label(group_fakelag, 'Accent color', {135, 125, 255}),

        pui.label(group_anti_aimbot, "\n"),
        lc_cfg = pui.label(group_anti_aimbot, '\a'.. pui.accent .. '•\r Local Configs'),
        cfg_list = pui.listbox(group_anti_aimbot, 'Cfg List', 'None', false),
        selected_cfg = pui.label(group_anti_aimbot, "Selected Config: \v-"),
        load_button = pui.button(group_anti_aimbot, "Load", function() end),
        save_button = pui.button(group_anti_aimbot, "Save", function() end),
        del_button= pui.button(group_anti_aimbot, "\aFF6969FFDelete", function() end),

        pui.label(group_other, "\n"),
        cfg_name_label = pui.label(group_other, "Config name"),
        cfg_name_text =  pui.textbox(group_other, 'Config name'),
        create_button = pui.button(group_other, "Create", function() end),
        import_button = pui.button(group_other, "Import", function() end),
        export_button = pui.button(group_other, "Export", function() end),
    },
    settings = {
        ragebot = {
            pui.label(group_anti_aimbot, '\n'),
            clr_label = pui.label(group_anti_aimbot, '\valcaraz ~\r Ragebot'),
            pui.label(group_anti_aimbot, '\a464646CC¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯'), --¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
            resolver = pui.checkbox(group_anti_aimbot, 'Jitter resolver'),

            prefer_baim = pui.checkbox(group_anti_aimbot, 'Prefer baim'),

            aimbot_logging = pui.checkbox(group_anti_aimbot, 'Aimbot logging'), 

            teleport_in_air = pui.checkbox(group_anti_aimbot, 'Teleport in air'),           
            teleport_in_air_type = pui.combobox(group_anti_aimbot, '\aC3C6FFFF ~ type', {'Default', 'Hard'}),

            force_charge = pui.checkbox(group_anti_aimbot, 'Enable  unsafe charge in air'),     

            force_predict = pui.checkbox(group_anti_aimbot, 'Force predict', 0x0), 

            --no_choking = pui.checkbox(group_anti_aimbot, 'No choking'),
        },
        visuals = {
            pui.label(group_fakelag, '\n'),
            clr_label = pui.label(group_fakelag, '\valcaraz ~\r Visuals'),
            pui.label(group_fakelag, '\a464646CC¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯'), --¯¯¯¯¯¯¯¯¯¯¯¯¯¯
            watermark = pui.checkbox(group_fakelag, 'Static watermark'),
            watermark_position = pui.combobox(group_fakelag, '\n watermark position', {'Left', 'Bottom', 'Right'}),
            watermark_color = pui.label(group_fakelag, 'Watermark accent color', {255, 255, 255}),
            damage_indication = pui.checkbox(group_fakelag, 'Damage indication'),
            screen_indication = pui.checkbox(group_fakelag, 'Screen indication'),
            fade_color = pui.label(group_fakelag, 'First color', {255, 255, 255}),
            fade_color_2 = pui.label(group_fakelag, 'Second color', {135, 125, 255}),
            aspect_ratio = pui.checkbox(group_fakelag, 'Aspect ratio'),
            aspect_ratio_v = pui.slider(group_fakelag, '\n aspect ratio value', 50, 200, 100, true, "", 0.01, {
                [100] = 'gamesense',
                [133] = "4:3",
                [160] = "16:10",
                [178] = "16:9",
                [150] = "3:2",
                [125] = "5:4"
            }),
        },
        misc = {
            pui.label(group_other, '\n'),
            clr_label = pui.label(group_other, '\valcaraz ~\r Misc'),
            pui.label(group_other, '\a464646CC¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯'), -- ¯¯¯¯¯¯¯¯¯¯¯¯
            fake_ping = pui.checkbox(group_other, 'Increase ping spike'),
            fake_ping_value = pui.slider(group_other, '\n Increase ping spike value', 200, 1000, 200, true, 'ms'),
            console_filter = pui.checkbox(group_other, 'Console Filter'),
        },
    },
    anti_aim = {
        label_selection = pui.label(group_fakelag, '\a'.. pui.accent .. '•\r Tab Selection'),
        space = pui.label(group_fakelag, '\a464646CC¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯'),
        selection  = pui.combobox(group_fakelag, '\n selection', {'Builder', 'Features'}),
        features = {
            list = pui.multiselect(group_anti_aimbot, 'Features', {'Avoid Backstab', 'Defensive anti-aim', 'Safe Head', 'Manual anti-aim', 'Fast ladder', 'No choking'}),
            safe_head_conditional = pui.multiselect(group_anti_aimbot, 'Safe Head active on', {'Knife', 'Zeus'}),
            override_defensive = pui.checkbox(group_anti_aimbot, 'Override defensive anti-aim'),
            manuals = {
                binds = {
                    left = pui.label(group_anti_aimbot, "Left", 0x0),
                    right = pui.label(group_anti_aimbot, "Right", 0x0),
                    forward = pui.label(group_anti_aimbot, "Forward", 0x0),
                },
                current_manual = pui.combobox(group_anti_aimbot, "\n", {"None", "Left", "Right", "Forward"}, nil, false):set_visible(false),
            },
            fakelag = {
                space = pui.label(group_fakelag, '\n'),
                enable = pui.checkbox(group_fakelag, '\n Enable fakelag'),
                label = pui.label(group_fakelag, '\a' .. pui.accent ..  'FL \rEnable'),
                amount = pui.combobox(group_fakelag, 'Amount\n', {'Dynamic', 'Maximum', 'Fluctuate'}),
                variance = pui.slider(group_fakelag, 'Variance\n', 0, 100, 0, true, '%'),
                limit = pui.slider(group_fakelag, 'Limit\n', 1, 15, 1),
                fakelag_disablers = pui.multiselect(group_fakelag, 'Disable fakelag', {'Doubletap', 'On-shot anti-aim'}),
                --force_fl_on_dt = pui.checkbox(group_anti_aimbot, 'Doubletap fix \n'),
            },
            edge_yaw_key = pui.label(group_anti_aimbot, "Edge yaw \n", 0x0),
            freestanding_key = pui.label(group_anti_aimbot, "Freestanding \n", 0x0),

            animation = {
                enable = pui.checkbox(group_anti_aimbot, 'Enable anim. breakers'),
                selection = pui.multiselect(group_anti_aimbot, '\n Anim. breakers selection', {'Landing legs', 'Air legs', 'Move lean', 'Perfect fake duck'}),
                landing_legs_type = pui.combobox(group_anti_aimbot, 'Type \nAnimation move', {'Static', 'Walking', 'Kinguru'}),
                air_legs_type = pui.combobox(group_anti_aimbot, 'Type \nAnimation air', {'Static', 'Walking', 'Kinguru'}),
                lean_multiplie = pui.slider(group_anti_aimbot, 'Lean multiplier', 0 , 100, 25, true, '%', 1, {[0] = 'Minimal', [100] = 'Maximum'}),
            },
        },
        builder = {
            enable = pui.checkbox(group_anti_aimbot, 'Enable Anti-Aim'),
            condition = pui.combobox(group_anti_aimbot, 'Condition select', condition_states), 
            element = {},
            defensive = {},
        },
    },
}

for value, data in pairs(condition_states) do
    menu_element.anti_aim.builder.element[value] = {}
    menu_element.anti_aim.builder.element[value].override_state = pui.checkbox(group_anti_aimbot, 'Override ' .. data:lower(), false)
    menu_element.anti_aim.builder.element[value].pitch = pui.combobox(group_anti_aimbot, 'Pitch \n' .. data, {'Off', 'Default', 'Up', 'Down', 'Minimal', 'Random'})
    menu_element.anti_aim.builder.element[value].yaw_base = pui.combobox(group_anti_aimbot, 'Yaw \n' .. data, {'Local view', 'At targets'})
    menu_element.anti_aim.builder.element[value].yaw = pui.combobox(group_anti_aimbot, 'Yaw \n' .. data, {'Off', '180', 'Spin', 'Static', '180 Z', 'Crosshair'})
    menu_element.anti_aim.builder.element[value].yaw_type = pui.combobox(group_anti_aimbot, 'Yaw type \n' .. data, {'Default', 'Delayed'})

    menu_element.anti_aim.builder.element[value].left_yaw_value = pui.slider(group_anti_aimbot, 'Left yaw \n' .. data, -180, 180, 0, true, '', 1)
    menu_element.anti_aim.builder.element[value].right_yaw_value = pui.slider(group_anti_aimbot, 'Right yaw \n' .. data, -180, 180, 0, true, '', 1)
    menu_element.anti_aim.builder.element[value].delay = pui.slider(group_anti_aimbot, 'Yaw switch delay \n' .. data, 2, 14, 0, true, 't', 1)
    
    menu_element.anti_aim.builder.element[value].yaw_jitter = pui.combobox(group_anti_aimbot, 'Jitter yaw \n' .. data, {'Off', 'Offset', 'Center', 'Random', '180 Z', 'Skitter'})
    menu_element.anti_aim.builder.element[value].jitter_value = pui.slider(group_anti_aimbot, 'Jitter value \n' .. data, -180, 180, 0, true, '', 1)
    
    menu_element.anti_aim.builder.element[value].body_yaw = pui.combobox(group_anti_aimbot, 'Body yaw \n' .. data, {'Off', 'Opposite', 'Static', 'Jitter'})
    menu_element.anti_aim.builder.element[value].body_yaw_value = pui.slider(group_anti_aimbot, 'Body yaw value \n' .. data, -180, 180, 0, true, '', 1)
    menu_element.anti_aim.builder.element[value].fs_body_yaw = pui.checkbox(group_anti_aimbot, 'Freestanding body yaw \n' .. data)

    menu_element.anti_aim.builder.element[value].force_lagcomp = pui.checkbox(group_anti_aimbot, 'Force LC \n' .. data)

    menu_element.anti_aim.builder.defensive[value] = {}
    menu_element.anti_aim.builder.defensive[value].enable = pui.checkbox(group_anti_aimbot, 'Defensive anti-aim \n' .. data)

    menu_element.anti_aim.builder.defensive[value].pitch = pui.combobox(group_anti_aimbot, 'Pitch \n defensive' .. data, {'Off', 'Up', 'Semi-Up', 'Zero', 'Semi-Down', 'Down', 'Random', 'Adaptive', 'Custom'})
    menu_element.anti_aim.builder.defensive[value].pitch_value = pui.slider(group_anti_aimbot, '\n Pitch value defensive' .. data, -89, 89, 0, true, '', 1, {[-89] = 'Up', [0] = 'Zero', [89] = 'Down'})

    menu_element.anti_aim.builder.defensive[value].yaw_type = pui.combobox(group_anti_aimbot, 'Yaw type \ndefensive' .. data, {'Off', '180', 'Spin', 'Side-Ways'})
    menu_element.anti_aim.builder.defensive[value].yaw_value = pui.slider(group_anti_aimbot, '\nYaw value defensive' .. data, -180, 180, 0, true, '', 1)

    menu_element.anti_aim.builder.defensive[value].on_onshot = pui.checkbox(group_anti_aimbot, 'Enable on on shot anti-aim \n'.. data)

    --menu_element.anti_aim.builder.defensive[value].time = pui.slider(group_anti_aimbot, 'Defensive delay \n' .. data, -6, 6, 2, true, "t", 1, {[-6] = "Always On", [0] = "Off", [2] = "Default", [6] = "1 tick"})
end

pui.accent = rgba_to_hex(menu_element.home.accent_color.color:get())
menu_element.home.accent_color.color:set_callback(function(self)
    pui.accent = rgba_to_hex(menu_element.home.accent_color.color:get())
    menu_element.home.info:set('\a'.. pui.accent .. '•\r Information')
    menu_element.home.build:set('\a'.. pui.accent .. '•\r Version: debug')
    menu_element.home.user:set('\a'.. pui.accent .. '•\r User: чмо ')
    menu_element.home.setting:set('\a'.. pui.accent .. '•\r Setting')
    menu_element.home.lc_cfg:set('\a'.. pui.accent .. '•\r Local Configs')
    menu_element.anti_aim.features.fakelag.label:set('\a' .. pui.accent ..  'FL \rEnable')
    menu_element.anti_aim.label_selection:set('\a'.. pui.accent .. '•\r Tab Selection')
end)

local ref = {
    ragebot = {
        aimbot = {
            enabled = pui.reference('RAGE', 'Aimbot', 'Enabled'),
            min_damage = pui.reference('RAGE', 'Aimbot', 'Minimum damage'),
            min_damage_override = {pui.reference('RAGE', 'Aimbot', 'Minimum damage override')},
            force_safe_point = pui.reference('RAGE', 'Aimbot', 'Force safe point'),
            force_body_aim = pui.reference('RAGE', 'Aimbot', 'Force body aim'),
            doubletap = pui.reference('RAGE', 'Aimbot', 'Double tap'),
            doubletap_fakelag_limit = pui.reference('RAGE', 'Aimbot', 'Double tap fake lag limit'),
        },

        other = {
            quick_peek_assist = pui.reference('RAGE', 'Other', 'Quick peek assist'),
            quick_peek_assist_mode = {pui.reference('RAGE', 'Other', 'Quick peek assist mode')},
            duck_peek_assist = pui.reference('RAGE', 'Other', 'Duck peek assist'),
        },
    },
    anti_aim = {
        angles = {
            enabled = pui.reference('AA', 'Anti-aimbot angles', 'Enabled'),
            pitch = pui.reference('AA', 'Anti-aimbot angles', 'Pitch'),
            pitch_value = select(2, pui.reference('AA', 'Anti-aimbot angles', 'Pitch')),
            yaw_base = pui.reference('AA', 'Anti-aimbot angles', 'Yaw base'),
            yaw = pui.reference('AA', 'Anti-aimbot angles', 'Yaw'),
            yaw_value = select(2, pui.reference('AA', 'Anti-aimbot angles', 'Yaw')),
            yaw_jitter = pui.reference('AA', 'Anti-aimbot angles', 'Yaw jitter'),
            yaw_jitter_value = select(2, pui.reference('AA', 'Anti-aimbot angles', 'Yaw jitter')),
            body_yaw = pui.reference('AA', 'Anti-aimbot angles', 'Body yaw'),
            body_yaw_value = select(2, pui.reference('AA', 'Anti-aimbot angles', 'Body yaw')),
            freestanding_body_yaw = pui.reference('AA', 'Anti-aimbot angles', 'Freestanding body yaw'),
            edge_yaw = pui.reference('AA', 'Anti-aimbot angles', 'Edge yaw'),
            freestanding = pui.reference('AA', 'Anti-aimbot angles', 'Freestanding'),
            roll = pui.reference('AA', 'Anti-aimbot angles', 'Roll'),
        },

        fakelag = {
            enabled = pui.reference('AA', 'Fake lag', 'Enabled'),
            amount = pui.reference('AA', 'Fake lag', 'Amount'),
            variance = pui.reference('AA', 'Fake lag', 'Variance'),
            limit = pui.reference('AA', 'Fake lag', 'Limit'),
        },

        other = {
            slow_motion = pui.reference('AA', 'Other', 'Slow motion'),
            leg_movement = pui.reference('AA', 'Other', 'Leg movement'),
            on_shot_antiaim = pui.reference('AA', 'Other', 'On shot anti-aim'),
            fake_peek = pui.reference('AA', 'Other', 'Fake peek'),
        },
    },

    misc = {
        clantag = pui.reference('Misc', 'Miscellaneous', 'Clan tag spammer'),
        ping_spike = {pui.reference('Misc', 'Miscellaneous', 'Ping spike')},
        color = pui.reference('Misc', 'Settings', 'Menu color'),
    },
}

function get_state()
    if get_localplayer(1) == nil then return end
    local speed = vector(entity.get_prop(get_localplayer(1), 'm_vecVelocity')):length()
    if not speed then return end
    local flags = entity.get_prop(get_localplayer(1), 'm_fFlags')
    if not flags then return end
    if (ref.anti_aim.angles.freestanding:get() and ref.anti_aim.angles.freestanding.hotkey:get()) --[[and is_vulnerable()]] and menu_element.anti_aim.builder.element[8].override_state.value--[[8]] then
        return 8
    elseif (bit.band(flags, 1) == 1) then
        if ((bit.band(flags, 4) == 4) or ref.ragebot.other.duck_peek_assist:get()) and menu_element.anti_aim.builder.element[5].override_state.value--[[5]] then 
            return 5
        elseif (speed <= 4) and menu_element.anti_aim.builder.element[2].override_state.value--[[2]] and not (bit.band(flags, 4) == 4) then
            return 2
        elseif ref.anti_aim.other.slow_motion.hotkey:get() and (speed > 4) and not (bit.band(flags, 4) == 4) and menu_element.anti_aim.builder.element[4].override_state.value--[[4]] then
            return 4
        elseif (speed > 4) and not (ref.anti_aim.other.slow_motion.hotkey:get() or (bit.band(flags, 4) == 4)) and menu_element.anti_aim.builder.element[3].override_state.value--[[3]] then
            return 3
        end
    elseif (bit.band(flags, 1) == 0) then
        if (bit.band(flags, 4) == 4) and menu_element.anti_aim.builder.element[7].override_state.value--[[7]] then
            return 7
        elseif menu_element.anti_aim.builder.element[6].override_state.value--[[6]] and not (bit.band(flags, 4) == 4) then
            return 6
        end
    end
    return 1
end

function get_state_int()
    if get_localplayer(1) == nil then return end
    local speed = vector(entity.get_prop(get_localplayer(1), 'm_vecVelocity')):length()
    if not speed then return end
    local flags = entity.get_prop(get_localplayer(1), 'm_fFlags')
    if not flags then return end
    if (ref.anti_aim.angles.freestanding:get() and ref.anti_aim.angles.freestanding.hotkey:get()) --[[and is_vulnerable()]] then
        return 8
    elseif (bit.band(flags, 1) == 1) then
        if ((bit.band(flags, 4) == 4) or ref.ragebot.other.duck_peek_assist:get()) then 
            return 5
        elseif (speed <= 4) and not (bit.band(flags, 4) == 4) then
            return 2
        elseif ref.anti_aim.other.slow_motion.hotkey:get() and (speed > 4) and not (bit.band(flags, 4) == 4) then
            return 4
        elseif (speed > 4) and not (ref.anti_aim.other.slow_motion.hotkey:get() or (bit.band(flags, 4) == 4)) then
            return 3
        end
    elseif (bit.band(flags, 1) == 0) then
        if (bit.band(flags, 4) == 4) then
            return 7
        else
            return 6
        end
    end
    return 1
end

function gui_setup()
    pui.traverse(menu_element, function(element, path)
        if not ignored_elements.settings[path[1]] then
            element:depend(menu_element.enable, {menu_element.selection, selection_names[path[1]]})
        end
    end)

    menu_element.selection:depend(menu_element.enable)

    menu_element.settings.ragebot.teleport_in_air_type:depend(menu_element.settings.ragebot.teleport_in_air)

    menu_element.settings.visuals.watermark_position:depend(menu_element.settings.visuals.watermark)
    menu_element.settings.visuals.watermark_color:depend(menu_element.settings.visuals.watermark)

    menu_element.settings.visuals.fade_color:depend(menu_element.settings.visuals.screen_indication)
    menu_element.settings.visuals.fade_color_2:depend(menu_element.settings.visuals.screen_indication)

    menu_element.settings.visuals.aspect_ratio_v:depend(menu_element.settings.visuals.aspect_ratio)

    menu_element.settings.misc.fake_ping_value:depend(menu_element.settings.misc.fake_ping)


    pui.traverse(menu_element.anti_aim, function(element, path)
        if not ignored_elements.anti_aim[path[1]] then
            element:depend({menu_element.anti_aim.selection, selection_names_anti_aim[path[1]]})
        end
    end)

    pui.traverse(menu_element.anti_aim.features.fakelag, function(element, path)
        if not ignored_elements.fakelag[path[1]] then
            element:depend(menu_element.anti_aim.features.fakelag.enable)
        end
    end)

    menu_element.anti_aim.features.safe_head_conditional:depend({menu_element.anti_aim.features.list, 'Safe Head'})
    menu_element.anti_aim.features.override_defensive:depend({menu_element.anti_aim.features.list, 'Safe Head'}, {menu_element.anti_aim.features.list, 'Defensive anti-aim'})

    pui.traverse(menu_element.anti_aim.features.manuals, function(element, path)
        element:depend({menu_element.anti_aim.features.list, 'Manual anti-aim'})
    end)

    pui.traverse(menu_element.anti_aim.features.animation, function(element, path)
        if path[1] ~= "enable" then
            element:depend(menu_element.anti_aim.features.animation.enable)
        end
    end)

    menu_element.anti_aim.features.animation.air_legs_type:depend({menu_element.anti_aim.features.animation.selection, 'Air legs'})
    menu_element.anti_aim.features.animation.landing_legs_type:depend({menu_element.anti_aim.features.animation.selection, 'Landing legs'})
    menu_element.anti_aim.features.animation.lean_multiplie:depend({menu_element.anti_aim.features.animation.selection, 'Move lean'})

    pui.traverse(menu_element.anti_aim.builder.element, function(element, path)
        if not ignored_elements.anti_aim[path[1]] then
            element:depend(menu_element.enable, {menu_element.selection, 'Anti-Aim'}, {menu_element.anti_aim.selection, 'Builder'}, {menu_element.anti_aim.builder.condition, condition_states[path[1]]})
        end
    end)
    pui.traverse(menu_element.anti_aim.builder.defensive, function(element, path)
        if not ignored_elements.anti_aim[path[1]] then
            element:depend(menu_element.enable, {menu_element.selection, 'Anti-Aim'}, {menu_element.anti_aim.selection, 'Builder'}, {menu_element.anti_aim.builder.condition, condition_states[path[1]]}, {menu_element.anti_aim.features.list, 'Defensive anti-aim'})
        end
    end)
    for value, data in pairs(condition_states) do
        pui.traverse(menu_element.anti_aim.builder.element[value], function(element, path)
            if path[1] ~= "override_state" then
                element:depend(menu_element.anti_aim.builder.element[value].override_state)
            end
        end)
        pui.traverse(menu_element.anti_aim.builder.defensive[value], function(element, path)
            if path[1] ~= "enable" then
                element:depend(menu_element.anti_aim.builder.defensive[value].enable, menu_element.anti_aim.builder.element[value].override_state)
            else
                element:depend(menu_element.anti_aim.builder.element[value].override_state)
            end
        end)
        menu_element.anti_aim.builder.element[value].yaw_type:depend({menu_element.anti_aim.builder.element[value].yaw, 'Off', true})

        menu_element.anti_aim.builder.element[value].left_yaw_value:depend({menu_element.anti_aim.builder.element[value].yaw, 'Off', true})
        menu_element.anti_aim.builder.element[value].right_yaw_value:depend({menu_element.anti_aim.builder.element[value].yaw, 'Off', true})
        menu_element.anti_aim.builder.element[value].delay:depend({menu_element.anti_aim.builder.element[value].yaw, 'Off', true}, {menu_element.anti_aim.builder.element[value].yaw_type, 'Delayed', false})

        menu_element.anti_aim.builder.element[value].yaw_jitter:depend({menu_element.anti_aim.builder.element[value].yaw_type, 'Delayed', true})
        menu_element.anti_aim.builder.element[value].jitter_value:depend({menu_element.anti_aim.builder.element[value].yaw_jitter, 'Off', true}, {menu_element.anti_aim.builder.element[value].yaw_type, 'Delayed', true})

        menu_element.anti_aim.builder.element[value].body_yaw:depend({menu_element.anti_aim.builder.element[value].yaw_type, 'Delayed', true})
        menu_element.anti_aim.builder.element[value].body_yaw_value:depend({menu_element.anti_aim.builder.element[value].body_yaw, 'Off', true}, {menu_element.anti_aim.builder.element[value].yaw_type, 'Delayed', true})
        menu_element.anti_aim.builder.element[value].fs_body_yaw:depend({menu_element.anti_aim.builder.element[value].body_yaw, 'Off', true}, {menu_element.anti_aim.builder.element[value].yaw_type, 'Delayed', true})

        menu_element.anti_aim.builder.defensive[value].pitch_value:depend({menu_element.anti_aim.builder.defensive[value].pitch, 'Custom'})
        
        menu_element.anti_aim.builder.defensive[value].yaw_value:depend({menu_element.anti_aim.builder.defensive[value].yaw_type, 'Off', true}, {menu_element.anti_aim.builder.defensive[value].yaw_type, 'Side-Ways', true})
    end
end

gui_setup()

function colored_label()
    local accent = {hex_to_rgba(pui.accent)}
    colored_text(menu_element.label, 'alcaraz', accent, {accent[1],accent[2],accent[3], 75})
    for a, b in pairs(menu_element.settings) do
        colored_text(menu_element.settings[a].clr_label, 'alcaraz ~ ' .. label_names[a], accent, {accent[1],accent[2],accent[3], 75})
    end
end



 rage.resolver = {
  records = {},
    pitch_records = {},
     data = {},
     main_function = safe_function(function ()
        local self = rage.resolver
        client.update_player_list()

        local players = entity.get_players(true)
        for i, entindex in pairs(players) do
            local v = players[i]
            if entity.is_enemy(v) then
                local st_cur, st_pre = _entity.get_simtime(v)
                st_cur, st_pre = toticks(st_cur), toticks(st_pre)

                if not self.records[v] then self.records[v] = setmetatable({}, {__mode = "kv"}) end
                if not self.pitch_records[v] then self.records[v] = setmetatable({}, {__mode = "kv"}) end
                local slot = self.records[v]

                 slot[st_cur] = {
                    pose = entity.get_prop(v, "m_flPoseParameter", 11) * 120 - 60,
                   eye = select(2, entity.get_prop(v, "m_angEyeAngles")),
                   pitch
                 }

                 local value
                local allow = (slot[st_pre] and slot[st_cur]) ~= nil
                if allow then
                   local animstate = _entity.get_animstate(v)
                    if animstate then 
                        local max_desync = _entity.get_max_desync(animstate)                    
                            if (slot[st_pre] and slot[st_cur]) and max_desync < .85 and (st_cur - st_pre < 2) then
                             local side = math.clamp(math.normalize_yaw(animstate.goal_feet_yaw - slot[st_cur].eye), -1, 1)
                             value = slot[st_pre] and (slot[st_pre].pose * side * max_desync) or nil
                         end
                     end
                     --e fix
                     if entity.get_prop(v, 'm_flPoseParameter', 12) > 0.2 and entity.get_prop(v, 'm_flPoseParameter', 12) < 0.8 then value = 0.5 end
                     if value then plist.set(v, "Force body yaw value", math.floor(value)) end

                 end
                 plist.set(v, "Force body yaw", value ~= nil) --
                 plist.set(v, "Correction active", true)
             end
         end
     end),
     restore = safe_function(function()
         local self = rage.resolver
         for i = 1, 64 do
             plist.set(i, "Force body yaw", false)
         end
         self.records = {}
     end),
     run = safe_function(function (self)
         menu_element.settings.ragebot.resolver:set_event("net_update_end", self.main_function)
         menu_element.settings.ragebot.resolver:set_callback(function (this)
             if not this.value then self.restore() end
         end)
         defer(self.restore)
     end)
 }


rage.body_aim = {
    hitbox_indices = {2, 3, 4, 5, 6, 7, 8},
    get_highest_baim_damage = safe_function(function(local_player, trace_position, enemy)
        local self = rage.body_aim
        local highest_damage = 0
        for i = 1, #self.hitbox_indices do
            local enemy_hitbox_pos = vector(enemy:hitbox_position(self.hitbox_indices[i]))
            local _, damage = local_player:trace_bullet(trace_position.x, trace_position.y, trace_position.z, enemy_hitbox_pos.x, enemy_hitbox_pos.y, enemy_hitbox_pos.z, false)
            if damage > highest_damage then
                highest_damage = damage
            end
        end
        return highest_damage
    end),
    should = safe_function(function(local_player, threat_health, highest_baim_damage)
        local weapon_ent = entity.get_player_weapon(get_localplayer(1))
        local weapon_name = (entity.get_classname(weapon_ent) or ""):gsub("CWeapon", "")

        local is_scar20_g3sg1_auto = (weapon_name == "SCAR20" or weapon_name == "G3SG1")
        local is_ssg08_selected = weapon_name == "SSG08"
        local is_doubletap_charged = ref.ragebot.aimbot.doubletap.hotkey:get() and rage.unsafe_charge.is_exploit_charged

        if is_scar20_g3sg1_auto and is_doubletap_charged then
            threat_health = threat_health / 2
        end

        return highest_baim_damage >= threat_health
    end),
    main_function = safe_function(function()
        local self = rage.body_aim
        client.update_player_list()
        local threat = ent.new(client.current_threat())
        if threat == nil then
            return
        end

        local threat_idx = threat:get_entindex()
        local eye_pos_local = vector(client.eye_position())
        local trace_pos = eye_pos_local
        local local_player = get_localplayer(0)
        local highest_baim_damage = self.get_highest_baim_damage(local_player, trace_pos, threat)
        local threat_health = threat:get_prop("m_iHealth")
        local weapon_ent = local_player:get_player_weapon()
        if not weapon_ent then return end
        local weapon_data = csgo_weapons(weapon_ent:get_entindex())
        local should_enable = self.should(weapon_data, threat_health, highest_baim_damage)
        if self.last_target ~= nil and self.last_target ~= threat_idx then
            plist.set(self.last_target, "Override prefer body aim", "-")
        end

        plist.set(threat_idx, "Override prefer body aim", should_enable and 'Force' or "-")
    end),
    restore = safe_function(function()
        local self = rage.body_aim
        for i = 1, 64 do
            plist.set(i, "Override prefer body aim", '-')
        end
        self.records = {}
    end),
    run = safe_function(function (self)
        menu_element.settings.ragebot.prefer_baim:set_event("net_update_end", self.main_function)
        menu_element.settings.ragebot.prefer_baim:set_callback(function (this)
            if not this.value then self.restore() end
        end)
        defer(self.restore)
    end),
    restore = safe_function(function()
        local self = rage.body_aim
        for i = 1, 64 do
            plist.set(i, "Override prefer body aim", '-')
        end
        self.records = {}
    end),
    run = safe_function(function (self)
        menu_element.settings.ragebot.prefer_baim:set_event("net_update_end", self.main_function)
        menu_element.settings.ragebot.prefer_baim:set_callback(function (this)
            if not this.value then self.restore() end
        end)
        defer(self.restore)
    end)
}
--[[]]

    --[[main_function = safe_function(function()
        local self = rage.body_aim
        client.update_player_list()
        local threat = ent.new(client.current_threat())
        if threat == nil then
            return
        end
        local threat_idx = threat:get_entindex()
        local eye_pos_local = vector(client.eye_position())
        local local_player = get_localplayer(0)
        local highest_baim_damage = self.get_highest_baim_damage(local_player, eye_pos_local, threat)
        local threat_health = threat:get_prop("m_iHealth")
        local weapon_ent = local_player:get_player_weapon()
        if not weapon_ent then return end
        local weapon_data = csgo_weapons(weapon_ent:get_entindex())
        local players = entity.get_players(true)
        local enable = self.should(weapon_data, threat_health, highest_baim_damage)
        for i, entindex in pairs(players) do
            local enemy = players[i]
            if enemy then
                if entity.is_enemy(enemy) then
                    plist.set(enemy, "Override prefer body aim",  enable and 'Force' or '-') 
                end
            end
        end
    end),]]

rage.aimbot_logging = {
    wanted_damage = {},
    backtrack = {},
    hitgroup = {},
    id = 0,
    aim_hit = safe_function(function(e)
        rage.body_aim.last_target = e.target
        local self = rage.aimbot_logging
        if not menu_element.settings.ragebot.aimbot_logging:get() then return end
        local group = hitgroup_names[e.hitgroup + 1] or '?'
        local wanted_group = hitgroup_names[self.hitgroup[self.id] + 1] or '?' 
        local difference_dmg = (self.wanted_damage[self.id] > e.damage)
        local difference_group = (wanted_group ~= group)
        local all_dif = (difference_dmg or difference_group)
        local color = all_dif and {255, 200, 0} or {115, 190, 25}
        local hitchance = math.floor(e.hit_chance) > 0 and (math.floor(e.hit_chance) .. '%, ') or ""

        client.color_log(color[1], color[2], color[3], (all_dif and '[~] ' or '[+] ') .. '\0')
        client.color_log(255, 255, 255, 'Hit \0')
        client.color_log(color[1], color[2], color[3], entity.get_player_name(e.target) .. '\0')
        client.color_log(255, 255, 255, ' in the ' .. '\0')
        client.color_log(color[1], color[2], color[3], group .. '\0')
        if difference_group then
            client.color_log(color[1], color[2], color[3],  ' (' .. wanted_group .. ')\0')
        end

        client.color_log(255, 255, 255, ' for ' .. '\0')
        client.color_log(color[1], color[2], color[3], e.damage .. '\0')
        if difference_dmg then
            client.color_log(color[1], color[2], color[3], ' (' .. self.wanted_damage[self.id] .. ')\0')
        end
        client.color_log(255, 255, 255, ' damage (' .. '\0')
        client.color_log(color[1], color[2], color[3], entity.get_prop(e.target, 'm_iHealth') .. '\0')
        client.color_log(255, 255, 255, ' health remaining)\0')
        client.color_log(color[1], color[2], color[3], ' (' .. hitchance .. self.backtrack[self.id] .. 't)')
    end),
    aim_miss = safe_function(function(e)
        local self = rage.aimbot_logging
        if not menu_element.settings.ragebot.aimbot_logging:get() then return end
        local group = hitgroup_names[e.hitgroup + 1] or '?'
        local reason = e.reason
        local hitchance = math.floor(e.hit_chance) > 0 and (math.floor(e.hit_chance) .. '%, ') or ''
        local target = e.target
        local color = {225, 0, 75}

        client.color_log(color[1], color[2], color[3], '[-] \0')
        client.color_log(255, 255, 255, 'Missed \0')
        client.color_log(color[1], color[2], color[3], entity.get_player_name(target) .. '\0')
        client.color_log(255, 255, 255, '`s ' .. '\0')
        client.color_log(color[1], color[2], color[3], group .. ' (' .. self.wanted_damage[self.id] .. ')\0')
        client.color_log(255, 255, 255, ' due to ' .. '\0')
        client.color_log(color[1], color[2], color[3], reason .. ' (' .. hitchance .. self.backtrack[self.id] .. 't)')
    end),
    aim_fire = safe_function(function(e)
        local self = rage.aimbot_logging
        table.insert(self.wanted_damage, e.damage)
        table.insert(self.backtrack, globals.tickcount() - e.tick)
        table.insert(self.hitgroup, e.hitgroup) 
        self.id = self.id + 1
    end),
}

rage.unsafe_charge = {
    is_charge = false,
    check_charge = safe_function(function()
        local self = rage.unsafe_charge
        local m_nTickBase = entity.get_prop(get_localplayer(1), "m_nTickBase")
        local client_latency = client.latency()
        local shift = math.floor(m_nTickBase - globals.tickcount() - 3 - toticks(client_latency) * .5 + .5 * (client_latency * 10))
        local wanted = -14 + (ref.ragebot.aimbot.doubletap_fakelag_limit:get() - 1) + 3 --error margin
        self.is_exploit_charged =  shift <= wanted
    end),
    run = safe_function(function()
        local self = rage.unsafe_charge
        if not menu_element.settings.ragebot.force_charge:get() then return end
        if not ref.ragebot.aimbot.doubletap.hotkey:get() or not ref.ragebot.aimbot.doubletap:get() then
            ref.ragebot.aimbot.enabled:set(true)
            if self.is_charge then
                client.set_event_callback('run_command', self.check_charge)
                self.is_charge = false
            end
            return
        end
        if not self.is_charge then
            client.set_event_callback('run_command', self.check_charge)
            self.is_charge = true
        end
        if self.is_exploit_charged and ref.ragebot.aimbot.enabled:get() == false then
            ref.ragebot.aimbot.enabled:set(true)
        end
        local threat = client.current_threat()
        if not self.is_exploit_charged
        and threat 
        and bit.band(entity.get_prop(get_localplayer(1), 'm_fFlags'), 1) == 0 
        and bit.band(entity.get_esp_data(threat).flags, bit.lshift(1, 11)) == 2048 then
            ref.ragebot.aimbot.enabled:set(false)
        end
    end)
}

local current_value, old_val = menu_element.settings.visuals.aspect_ratio_v:get()/100

visuals.main = {
    aspect_ratio = {
        main = safe_function(function()
            if not menu_element.settings.visuals.aspect_ratio:get() or ("%.2f"):format(current_value) == ("%.2f"):format(menu_element.settings.visuals.aspect_ratio_v:get()/100) then return end
            current_value = lerp(current_value, menu_element.settings.visuals.aspect_ratio_v:get()/100, 0.05)
            client.set_cvar("r_aspectratio", current_value)
        end),
        on_unload = safe_function(function()
            if menu_element.settings.visuals.aspect_ratio:get() then client.set_cvar("r_aspectratio", current_value) return end
            client.set_cvar("r_aspectratio", 0);
            current_value = menu_element.settings.visuals.aspect_ratio_v:get()/100;
        end)
    },
}

menu_element.settings.visuals.aspect_ratio:set_callback(visuals.main.aspect_ratio.on_unload)

misc = {
    ping_spike = {

    },
    console_filter = {
        run = safe_function(function()
            cvar.con_filter_enable:set_int(menu_element.settings.misc.console_filter.value and 1 or 0)
            cvar.con_filter_text:set_string(menu_element.settings.misc.console_filter.value and "alcaraz" or "")
        end),
    },
}

menu_element.settings.misc.console_filter:set_callback(misc.console_filter.run)

anti_aim.main = {
    delayed_jitter = false,
    side = false,
    last_sim_time = 0,
    defensive_value = 0,
    pitch_modifier = 89,
    is_avoid_backstabbing = safe_function(function(cmd)
        if not menu_element.anti_aim.features.list:get('Avoid Backstab') then
            return false 
        end

        local players = entity.get_players(true)
        local eye = vector(client.eye_position())

        local target = {
            idx = nil,
            distance = 300,
            visible = false
        }

        for _, entindex in pairs(players) do
            local weapon = entity.get_player_weapon(entindex)
            if not weapon or entity.get_classname(weapon) ~= 'CKnife' then 
                goto skip 
            end

            -- Calculate distance between eye and target
            local origin = vector(entity.get_origin(entindex))
            local distance = eye:dist(origin)
            if distance > target.distance then 
                goto skip 
            end

            target.idx = entindex
            target.distance = distance

            ::skip::
        end

        if not target.idx then 
            return false 
        end

        return true
    end),
    is_safe_heading = safe_function(function(cmd)
        if not menu_element.anti_aim.features.list:get('Safe Head') then
            return false 
        end

        local select = menu_element.anti_aim.features.safe_head_conditional

        local weapon = entity.get_player_weapon(get_localplayer(1))
        if not weapon then 
            return false 
        end

        local weapon_name = entity.get_classname(weapon)
        if not weapon_name then 
            return false 
        end

        if not ((weapon_name == 'CKnife' and select:get('Knife')) or (weapon_name == 'CWeaponTaser' and select:get('Zeus'))) then 
            return false 
        end

        if bit.band(entity.get_prop(get_localplayer(1), 'm_fFlags'), bit.lshift(1, 0)) ~= 0 then 
            return false 
        end

        return true
    end),
    is_defensive = safe_function(function(state)
        local self = anti_aim.main
        local lp = entity.get_local_player()

        if lp == nil or not entity.is_alive(lp) then
            return
        end
        if not ((ref.ragebot.aimbot.doubletap.hotkey:get() and ref.ragebot.aimbot.doubletap:get()) or (menu_element.anti_aim.builder.defensive[state].on_onshot:get() and ref.anti_aim.other.on_shot_antiaim.hotkey:get())) then
            return 
        end
        if ref.ragebot.other.duck_peek_assist:get() or (self.is_safe_heading() and menu_element.anti_aim.features.override_defensive.value) or self.is_avoid_backstabbing() then 
            return
        end
        local tickcount = globals.tickcount()
        local latency = math.floor(client.latency() * 100) / 100

        local sim_time = toticks(entity.get_prop(lp, "m_flSimulationTime"))
        local diff = sim_time - self.last_sim_time 

        if diff < 0 then
            self.defensive_value = tickcount + math.abs(diff) - toticks(latency)
        end

        self.last_sim_time = sim_time

        return tickcount + 2 --[[menu_element.anti_aim.builder.defensive[state].time.value]] < self.defensive_value
    end),
    run = safe_function(function(cmd)
        local self = anti_aim.main
        local state = get_state()

        local body_yaw_value = entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11) * 120 - 60
        local inverted = body_yaw_value >= 0 and 1 or -1

        if cmd.command_number % menu_element.anti_aim.builder.element[state].delay:get() + 1 > menu_element.anti_aim.builder.element[state].delay:get() - 1 then
            self.delayed_jitter = not self.delayed_jitter
        end
        if menu_element.anti_aim.builder.element[state].yaw_type:get() == 'Delayed' then
            self.side = self.delayed_jitter
        else
            self.side = inverted == 1
        end

        ref.anti_aim.angles.enabled:set(menu_element.anti_aim.builder.enable:get())
        ref.anti_aim.angles.pitch:set(menu_element.anti_aim.builder.element[state].pitch:get())
        ref.anti_aim.angles.pitch_value:set(0)
        ref.anti_aim.angles.yaw_base:set(menu_element.anti_aim.builder.element[state].yaw_base:get())
        ref.anti_aim.angles.yaw:set(menu_element.anti_aim.builder.element[state].yaw:get())
        ref.anti_aim.angles.yaw_value:set(self.side == true and menu_element.anti_aim.builder.element[state].left_yaw_value:get() or menu_element.anti_aim.builder.element[state].right_yaw_value:get())
        ref.anti_aim.angles.yaw_jitter:set(menu_element.anti_aim.builder.element[state].yaw_jitter:get())
        ref.anti_aim.angles.yaw_jitter_value:set(menu_element.anti_aim.builder.element[state].jitter_value:get())
        ref.anti_aim.angles.body_yaw:set(menu_element.anti_aim.builder.element[state].body_yaw:get())
        ref.anti_aim.angles.body_yaw_value:set(menu_element.anti_aim.builder.element[state].body_yaw_value:get())
        ref.anti_aim.angles.freestanding_body_yaw:set(menu_element.anti_aim.builder.element[state].fs_body_yaw:get())
        
        if menu_element.anti_aim.builder.element[state].yaw_type:get() == 'Delayed' then
            ref.anti_aim.angles.yaw_jitter:override('Off')
            ref.anti_aim.angles.body_yaw:override('Off')
        end

        if self.is_safe_heading() then
            ref.anti_aim.angles.yaw_value:override(0)
            ref.anti_aim.angles.yaw_jitter:override('Off')
            ref.anti_aim.angles.body_yaw:override('Off')
        end

        if self.is_avoid_backstabbing() then
            ref.anti_aim.angles.yaw_value:override(180)
            ref.anti_aim.angles.yaw_jitter:override('Off')
            ref.anti_aim.angles.body_yaw:override('Off')
        end

        cmd.force_defensive = menu_element.anti_aim.builder.element[state].force_lagcomp.value

        ref.anti_aim.angles.freestanding:set(menu_element.anti_aim.features.freestanding_key.hotkey:get() and true or false)
        ref.anti_aim.angles.freestanding.hotkey:set(menu_element.anti_aim.features.freestanding_key.hotkey:get() and 'Always on' or 'On hotkey')
        ref.anti_aim.angles.edge_yaw:set(menu_element.anti_aim.features.edge_yaw_key.hotkey:get() and true or false)
    end),
    defensive = safe_function(function(cmd)
        local self = anti_aim.main
        local state = get_state()

        self.pitch_modifier = self.pitch_modifier + 8.9 * (self.pitch_modifier < 89 and 1 or -1)
        if self.pitch_modifier >= 89 or self.pitch_modifier <= -89 then
            self.pitch_modifier = -89
        end

        local pitch_variable = {
            ['Up'] = -89, 
            ['Semi-Up'] = -45, 
            ['Zero'] = -0, 
            ['Semi-Down'] = 45, 
            ['Down'] = 89,
            ['Random'] = math.random(-89, 89), 
            ['Adaptive'] = self.pitch_modifier, 
            ['Custom'] = menu_element.anti_aim.builder.defensive[state].pitch_value.value
        }
        local yaw_variable = {
            ['Up'] = -89, 
            ['Semi-Up'] = -45, 
            ['Zero'] = -0, 
            ['Semi-Down'] = 45, 
            ['Down'] = 89,
            ['Random'] = math.random(-89, 89), 
            ['Adaptive'] = 0, 
            ['Custom'] = menu_element.anti_aim.builder.defensive[state].yaw_value.value
        }
        if not menu_element.anti_aim.features.list:get('Defensive anti-aim') then
            return false 
        end
        if not menu_element.anti_aim.builder.defensive[state].enable.value then
            return
        end
        if not self.is_defensive(state) then 
            return
        end
        ref.anti_aim.angles.pitch:override(menu_element.anti_aim.builder.defensive[state].pitch.value == 'Off' and 'Off' or 'Custom')
        ref.anti_aim.angles.pitch_value:override(pitch_variable[menu_element.anti_aim.builder.defensive[state].pitch.value])
        --menu_element.anti_aim.builder.defensive[state].yaw_value
        if menu_element.anti_aim.builder.defensive[state].yaw_type.value == 'Off' or menu_element.anti_aim.builder.defensive[state].yaw_type.value == '180' or menu_element.anti_aim.builder.defensive[state].yaw_type.value == 'Spin' then
            ref.anti_aim.angles.yaw:override(menu_element.anti_aim.builder.defensive[state].yaw_type.value)
            ref.anti_aim.angles.yaw_value:override(menu_element.anti_aim.builder.defensive[state].yaw_value:get())
        else
            ref.anti_aim.angles.yaw:override('180')
            ref.anti_aim.angles.yaw_value:override(self.side == true and -90 or 90)
        end
        ref.anti_aim.angles.body_yaw:override('Opposite')
    end)
}

anti_aim.features = {
    fakelag = safe_function(function()
        local fakelag_setting = menu_element.anti_aim.features.fakelag
        local disablers = fakelag_setting.fakelag_disablers
        ref.anti_aim.fakelag.enabled:set(fakelag_setting.enable.value)

        ref.anti_aim.fakelag.amount:set(fakelag_setting.amount.value)
        ref.anti_aim.fakelag.variance:set(fakelag_setting.variance.value)
        ref.anti_aim.fakelag.limit:set(fakelag_setting.limit.value)
        
        if (disablers:get('Doubletap') and ref.ragebot.aimbot.doubletap.hotkey:get() and not ref.ragebot.other.duck_peek_assist:get()) or
        (disablers:get('On-shot anti-aim') and ref.anti_aim.other.on_shot_antiaim.hotkey:get() and not (ref.ragebot.aimbot.doubletap.hotkey:get() or ref.ragebot.other.duck_peek_assist:get())) then
            ref.anti_aim.fakelag.limit:override(1)
        end
    end),
    animation = safe_function(function()
        local lp = get_localplayer(1)
        local lp2 = ent.get_local_player()
        if not lp then return end
        if not lp2 then return end
        local my_animlayer_6 = lp2:get_anim_overlay(6)
        local my_animlayer_12 = lp2:get_anim_overlay(12)
        local speed = vector(entity.get_prop(lp, 'm_vecVelocity')):length()
        if not menu_element.anti_aim.features.animation.enable.value then
            return
        end
        local selection, air_leg, landing_leg, move_v = menu_element.anti_aim.features.animation.selection, menu_element.anti_aim.features.animation.air_legs_type.value, menu_element.anti_aim.features.animation.landing_legs_type.value, menu_element.anti_aim.features.animation.lean_multiplie.value
        
        if selection:get('Air legs') then
            if not on_ground() then
                if air_leg == 'Static' then
                    entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, 6)
                elseif air_leg == 'Walking' then
                    if speed > 10 then
                        my_animlayer_6.weight = 1 
                    end
                elseif air_leg == 'Kinguru' then
                    entity.set_prop(entity.get_local_player(), "m_flPoseParameter", math.random(0, 10)/10, 6)
                end
            end
        end

        if selection:get('Landing legs') then
            if on_ground() then
                if landing_leg == 'Static' then
                    entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, 0)
                    ref.anti_aim.other.leg_movement:override('Always slide')
                elseif landing_leg == 'Walking' then
                    if speed > 10 then
                        entity.set_prop(lp, 'm_flPoseParameter', 0, 7)
                    end
                    ref.anti_aim.other.leg_movement:override('Never slide')
                elseif landing_leg == 'Kinguru' then
                    entity.set_prop(entity.get_local_player(), "m_flPoseParameter", math.random(0, 10)/10, 3)
                    entity.set_prop(entity.get_local_player(), "m_flPoseParameter", math.random(0, 10)/10, 7)
                    --entity.set_prop(entity.get_local_player(), "m_flPoseParameter", math.random(0, 10)/10, 9)
                    --entity.set_prop(entity.get_local_player(), "m_flPoseParameter", math.random(0, 10)/10, 10)
                    ref.anti_aim.other.leg_movement:override('Never slide')
                end
            end
        end

        if selection:get('Move lean') and speed > 10 then
            my_animlayer_12.weight = move_v / 100
        end
        if selection:get('Perfect fake duck') then
            if ref.ragebot.other.duck_peek_assist:get() then
                entity.set_prop(entity.get_local_player(), "m_flPoseParameter", math.random(0, 10)/10, 9)
                entity.set_prop(entity.get_local_player(), "m_flPoseParameter", math.random(0, 10)/10, 10)
            end
        end
    end),

    fast_ladder = safe_function(function(cmd)
        if not menu_element.anti_aim.features.list:get('Fast ladder') then
            return false 
        end
        
        local lp = get_localplayer(1)

        if entity.get_prop(lp, 'm_MoveType') ~= 9 then
            return 
        end
        

        local weapon = entity.get_player_weapon(lp)
        if weapon == nil then
            return  
        end

        local throw_time = entity.get_prop(weapon, 'm_fThrowTime')
        if throw_time ~= nil and throw_time ~= 0 then
            return
        end

        if cmd.forwardmove > 0 then
            if cmd.pitch < 45 then
                cmd.pitch = 89
                cmd.in_moveright = 1
                cmd.in_moveleft = 0
                cmd.in_forward = 0
                cmd.in_back = 1

                if cmd.sidemove == 0 then
                    cmd.yaw = cmd.yaw + 90
                elseif cmd.sidemove < 0 then
                    cmd.yaw = cmd.yaw + 150
                elseif cmd.sidemove > 0 then
                    cmd.yaw = cmd.yaw + 30
                end
            end
        elseif cmd.forwardmove < 0 then
            cmd.pitch = 89
            cmd.in_moveleft = 1
            cmd.in_moveright = 0
            cmd.in_forward = 1
            cmd.in_back = 0

            if cmd.sidemove == 0 then
                cmd.yaw = cmd.yaw + 90
            elseif cmd.sidemove > 0 then
                cmd.yaw = cmd.yaw + 150
            elseif cmd.sidemove < 0 then
                cmd.yaw = cmd.yaw + 30
            end
        end
    end),
    no_choking = safe_function(function(cmd)
        if not menu_element.anti_aim.features.list:get('No choking') then
            return
        end
        local lp = entity.get_local_player()
        if not lp then return end
        local weapon = entity.get_player_weapon(lp)
        if not weapon then return end
        if (ref.ragebot.aimbot.doubletap.hotkey:get() or ref.anti_aim.other.on_shot_antiaim.hotkey:get()) then return end
        local last_shot_time = entity.get_prop(weapon, 'm_fLastShotTime')
        local time_difference = globals.curtime() - last_shot_time
        if time_difference <= 0.025 then
            cmd.no_choke = true
        end
    end)
}

rage.resolver.run(rage.resolver)
rage.body_aim.run(rage.body_aim)

client.set_event_callback("setup_command", function(cmd)

    anti_aim.main.run(cmd)
    anti_aim.main.defensive(cmd)

    anti_aim.features.fakelag()
    anti_aim.features.fast_ladder(cmd)
    anti_aim.features.no_choking(cmd)

    if ui.is_menu_open() then
        cmd.in_attack = false
    end
end)

client.set_event_callback("run_command", function(cmd)
end)

client.set_event_callback("paint", function(cmd)

    visuals.main.aspect_ratio.main()
end)

client.set_event_callback("paint_ui", function(cmd)
    colored_label()

    set_visible(ref.anti_aim.angles, not menu_element.enable.value)
    set_visible(ref.anti_aim.fakelag, not menu_element.enable.value)
    --set_visible(ref.anti_aim.fakelag, (menu_element.enable.value and menu_element.selection:get() == 'Anti-Aim') or not menu_element.enable.value)
end)

client.set_event_callback("shutdown", function(cmd)
    set_visible(ref.anti_aim.angles, true)
    set_visible(ref.anti_aim.fakelag, true)
end)

client.set_event_callback("aim_fire", function(handle)
    rage.aimbot_logging.aim_fire(handle)
end)

client.set_event_callback("aim_miss", function(handle)
    rage.aimbot_logging.aim_miss(handle)
end)

client.set_event_callback("aim_hit", function(handle)
    rage.aimbot_logging.aim_hit(handle)
end)

client.set_event_callback("round_prestart", function()

end)
client.set_event_callback("pre_render", function(cmd)
    anti_aim.features.animation()
end)

client.set_event_callback("level_init", function()

end)

client.set_event_callback('net_update_end', function()
    rage.unsafe_charge.run()
end)


local package = pui.setup(menu_element)

local cfg_manager = function(tbl)
    menu_element.home.cfg_list:update(tbl)
end
 
local error_func = function()
    print("If this error continues to popup please contact the staff")
end

local config_data = database.read("alcatraz_local_configs") or {}
local list_tbl = {}

local delay_value = 3
local handle_names = function(_, value, delay)
    local delay = delay or 0
    if value ~= nil then menu_element.home.selected_cfg:set(value) end
    client.delay_call(delay, function()
        local selected = menu_element.home.cfg_list:get()+1
        local name = list_tbl[selected] or "-"
        menu_element.home.selected_cfg:set("Selected Config: \v" .. name)
    end)
end

config_system = {
    get_cfg_list = function()
        local update_tbl = {}
        for _, data in pairs(cfg_tbl) do
            table.insert(update_tbl, data.name)
            data.data = json.parse(base64.decode(data.data))
        end
        xpcall(function() for name, data in pairs(config_data) do table.insert(update_tbl, name) end end, error_func)

        cfg_manager(update_tbl)
        list_tbl = update_tbl
    end,

    create_button_callback = function()
        local name = menu_element.home.cfg_name_text:get()
        if #name <= 0 then handle_names(nil, "\aFF5151FFERROR: \rCan't use an empty name!", delay_value) return end
        if config_data[name] ~= nil then handle_names(nil, "\aFF5151FFERROR: \rConfig with this name already exists!", delay_value) return end
        
        local list, cfg = list_tbl, package:save()
        list[#list+1] = name
        config_data[name] = cfg
        database.write("alcatraz_local_configs", config_data)
        cfg_manager(list)
    end,

    save_button_callback = function()
        local list, selected = list_tbl, menu_element.home.cfg_list:get()+1
        local sel_name = list[selected]
        if selected > #cfg_tbl then
            config_data[sel_name] = package:save()
            database.write("alcatraz_local_configs", config_data)
            handle_names(nil, "\v" .. sel_name ..  "\r config has been saved!", delay_value)
        else
            handle_names(nil, "\aFF5151FFERROR: \r" .. sel_name ..  " is a built-in config!", delay_value)
            client.exec("play resource/warning.wav")
        end
        cfg_manager(list)
    end,

    load_button_callback = function()
        local selected = menu_element.home.cfg_list:get()+1
        local sel_name = list_tbl[selected]
        local s = pcall(function()
            if selected <= #cfg_tbl then
                package:load(cfg_tbl[selected].data)
            else
                package:load(config_data[sel_name])
            end
        end)
        if s then
            client.exec("play survival/buy_item_01.wav")
            handle_names(nil, "\v" .. sel_name ..  "\r config has been loaded!", delay_value)
        else
            client.exec("play resource/warning.wav")
            handle_names(nil, "\aFF5151FFERROR: \r" .. sel_name ..  " config is broken!", delay_value)
        end
    end,

    del_button_callback = function()
        local list = list_tbl
        local selected = menu_element.home.cfg_list:get()+1
        local sel_name = list[selected]
        if #list > 1 and selected > #cfg_tbl then
            table.remove(list, selected)
            config_data[sel_name] = nil
            database.write("gloriosa_cfgs", config_data)
            handle_names(nil, "\v" .. sel_name ..  "\r config has been deleted!", delay_value)
        else
            handle_names(nil, "\aFF5151FFERROR: \r" .. sel_name ..  " is a built-in config!", delay_value)
        end
        cfg_manager(list)
    end,

    export = function()
        local data = package:save()
        local config = base64.encode(json.stringify(data))
        clipboard.set(config)
        print("Exported config")
    end,

    import_config = function(data)
        local decoded, error_message
        local decrypted_success, decrypted_data = pcall(function() 
            local decoded = base64.decode(data)
            return json.parse(decoded)
        end)
        if decrypted_success then
            decoded = decrypted_data
            package:load(decoded)
            print("Imported Config")
        else 
            client.error_log("You can't load this config.")
        end
    end
}

config_system.get_cfg_list()
handle_names()

menu_element.home.export_button:set_callback(function()config_system.export()end)
menu_element.home.import_button:set_callback(function()config_system.import_config(clipboard.get())end)

menu_element.home.cfg_list:set_callback(handle_names)
menu_element.home.create_button:set_callback(config_system.create_button_callback)
menu_element.home.import_button:set_callback(config_system.import_callback)
menu_element.home.export_button:set_callback(config_system.export_callback)
menu_element.home.save_button:set_callback(config_system.save_button_callback)
menu_element.home.load_button:set_callback(config_system.load_button_callback)
menu_element.home.del_button:set_callback(config_system.del_button_callback)