local pui = require("gamesense/pui")

local ref = {
    aimbot = pui.reference('RAGE', 'Aimbot', 'Enabled'),
    dt = {pui.reference('RAGE', 'Aimbot', 'Double tap')},
    hs = pui.reference("AA", "Other", "On shot anti-aim"),
}

local was_disabled = true
local shot_tick = 0
local ticking = 0

function tickcount_shot(cmd)
    shot_tick = globals.tickcount()
end

function logic()
    local lp = entity.get_local_player()
    if(globals.chokedcommands() == 0 and lp ~= nil and entity.is_alive(lp)) then
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
        if lp_weapon ~= nil then
            local weapon_id = bit.band(entity.get_prop(entity.get_player_weapon(lp), "m_iItemDefinitionIndex"), 0xFFFF)
            if weapon_id == 64 then
                ref.aimbot:set(true)
                if ticking <= 2 then
                    ticking = ticking + 1
                end
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
end

client.set_event_callback('setup_command', logic)
client.set_event_callback('weapon_fire', tickcount_shot)