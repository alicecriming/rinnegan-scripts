---@libs
local vector = require 'vector'
local clipboard = require 'gamesense/clipboard'
local json = require 'json'
local base64 = require 'gamesense/base64'
local c_entity = require 'gamesense/entity'
local weapons = require 'gamesense/csgo_weapons'
---@end

---@ref_start
local ref = {} 
do
    local function init_refs()
        ref = {
            enabled = ui.reference("AA", "Anti-Aimbot angles", "Enabled"),
            pitch     = { ui.reference("AA", "Anti-Aimbot angles", "Pitch") },
            yaw_base  = ui.reference("AA", "Anti-Aimbot angles", "Yaw base"),
            yaw       = { ui.reference("AA", "Anti-Aimbot angles", "Yaw") },
            yaw_jitter = { ui.reference("AA", "Anti-Aimbot angles", "Yaw jitter") },
            body_yaw  = { ui.reference("AA", "Anti-Aimbot angles", "Body yaw") },
            freestanding_body_yaw = ui.reference("AA", "Anti-Aimbot angles", "Freestanding body yaw"),
            edge_yaw  = ui.reference("AA", "Anti-Aimbot angles", "Edge yaw"),
            freestand = { ui.reference("AA", "Anti-Aimbot angles", "Freestanding") },
            roll      = ui.reference("AA", "Anti-Aimbot angles", "Roll"),
            slow_walk = { ui.reference("AA", "Other", "Slow motion") },
            dt        = { ui.reference("RAGE", "Aimbot", "Double Tap") },
            hs        = { ui.reference("AA", "Other", "On shot anti-aim") },
            fd        = ui.reference("RAGE", "Other", "Duck peek assist"),
            min_damage = ui.reference("RAGE", "Aimbot", "Minimum damage"),
            min_damage_override = { ui.reference("RAGE", "Aimbot", "Minimum damage override") },
            rage_cb   = { ui.reference("RAGE", "Aimbot", "Enabled") },
            menu_color = ui.reference("MISC", "Settings", "Menu color"),
            fakelag_limit = ui.reference("AA", "Fake lag", "Limit"),
            variability   = ui.reference("AA", "Fake lag", "Variance"),
            aimbot        = ui.reference("RAGE", "Aimbot", "Enabled")
        }
    end
    init_refs()
end
---@ref_end

---@region tools
local tools = {
    lerp = function(a, b, t)
        return a + (b - a) * t
    end,
    to_hex = function(r, g, b, a)
        return string.format("%02x%02x%02x%02x", r, g, b, a)
    end,
    clamp = function(value, min, max)
        return math.max(min, math.min(max, value))
    end,
    time_to_ticks = function(t)
        return math.floor(0.5 + (t / globals.tickinterval()))
    end
}

local function contains(table, val)
    for i = 1, #table do
        if table[i] == val then
            return true
        end
    end
    return false
end
---@end

---@skeet_elements_hider_start
local function on_load()
    local skeet_refs = {
        ref.enabled, ref.pitch[1], ref.pitch[2], ref.yaw_base, ref.yaw[1], ref.yaw[2],
        ref.yaw_jitter[1], ref.yaw_jitter[2], ref.body_yaw[1], ref.body_yaw[2],
        ref.freestanding_body_yaw, ref.edge_yaw, ref.freestand[1], ref.freestand[2],
        ref.roll
    }
    for _, ref_item in ipairs(skeet_refs) do
        ui.set_visible(ref_item, false)
    end
end

local function on_unload()
    local skeet_refs = {
        ref.enabled, ref.pitch[1], ref.pitch[2], ref.yaw_base, ref.yaw[1], ref.yaw[2],
        ref.yaw_jitter[1], ref.yaw_jitter[2], ref.body_yaw[1], ref.body_yaw[2],
        ref.freestanding_body_yaw, ref.edge_yaw, ref.freestand[1], ref.freestand[2],
        ref.roll
    }
    for _, ref_item in ipairs(skeet_refs) do
        ui.set_visible(ref_item, true)
    end
end
---@skeet_elements_hider_end

---@lua_menu_start
local cur_tab
local states = {"Global", "Stand", "Running", "Air", "Air-Duck", "Slow-walk", "Duck", "Duck-Running"}
local lua_menu = {}
do
    function lua_menu.init()
        lua_menu.labels = {
            ui.new_label("AA", "Anti-aimbot angles", "                  \aFFFFFFFF   " ..
                "\a0FA6E0FFA\a15b3efFFd\a33bcf0FFj\a41c0f1FFu\a4bc3f1FFs\a59c8f3FFt \rcrack" ..
                "\aFFFFFFFF "),
            ui.new_label("AA", "Anti-aimbot angles", " "),
            ui.new_label("AA", "Anti-aimbot angles", "                     \aC0C0C0FFdebug"),
            ui.new_label("AA", "Anti-aimbot angles", "  ")
        }

        cur_tab = 1 -- 1 = main, 2 = aa, 3 = visuals, 4 = misc, 5 = discloser, 6 = config

        lua_menu.buttons = {
            back = ui.new_button("AA", "Anti-Aimbot angles", "\aC0C0C0FFBack", function()
                cur_tab = 1
                lua_menu.group_visibility()
            end),
            aa = ui.new_button("AA", "Anti-Aimbot angles", "\aC0C0C0FFAnti-Aim", function()
                cur_tab = 2
                lua_menu.group_visibility()
            end),
            discloser = ui.new_button("AA", "Anti-Aimbot angles", "\aC0C0C0FFTweaks / Discloser", function()
                cur_tab = 5
                lua_menu.group_visibility()
            end),
            visuals = ui.new_button("AA", "Anti-Aimbot angles", "\aC0C0C0FFVisuals", function()
                cur_tab = 3
                lua_menu.group_visibility()
            end),
            misc = ui.new_button("AA", "Anti-Aimbot angles", "\aC0C0C0FFMisc", function()
                cur_tab = 4
                lua_menu.group_visibility()
            end),
            config = ui.new_button("AA", "Anti-Aimbot angles", "\aC0C0C0FFConfig", function()
                cur_tab = 6
                lua_menu.group_visibility()
            end),
        }

        lua_menu.checkboxes = {
            clantag             = ui.new_checkbox("AA", "Anti-Aimbot angles", "Clantag"),
            console_filter      = ui.new_checkbox("AA", "Anti-Aimbot angles", "Console Filter"),
            fix_hideshots       = ui.new_checkbox("AA", "Anti-Aimbot angles", "Fix OSAA"),


            revolver_helper     = ui.new_checkbox("AA", "Anti-Aimbot angles", "Revolver Helper"),
            damage_indicator    = ui.new_checkbox("AA", "Anti-Aimbot angles", "Damage indicator"),
            damage_indicator_font = ui.new_combobox("AA", "Anti-Aimbot angles", "Damage indicator font", "Pixel", "Verdana"),
            animfix             = ui.new_multiselect("AA", "Anti-aimbot angles", "Anim Breakers", "Jitter legs on ground", "Body lean", "0 pitch on landing", "Static in Air", "Kangaroo")
        }

        lua_menu.discloser = {
            label5       = ui.new_label("AA", "Anti-Aimbot angles", "To make Micro yaw flicks work use"),
            label4       = ui.new_label("AA", "Anti-Aimbot angles", "\aFFFFFFFFDiscloser yaw type"),
            label6       =ui.new_label("AA", "Anti-Aimbot angles", "      "),
            micro_yaw    = ui.new_checkbox("AA", "Anti-Aimbot angles", "Micro yaw flicks"),
            first_flick  = ui.new_slider("AA", "Anti-Aimbot angles", "First angle", -30, 30, 0),
            second_flick = ui.new_slider("AA", "Anti-Aimbot angles", "Second angle", -30, 30, 0),
            fake_lag_addon = ui.new_checkbox("AA", "Anti-Aimbot angles", "Fake Lag Addons"),
            label1       = ui.new_label("AA", "Anti-Aimbot angles", "   "),
            label2       = ui.new_label("AA", "Anti-Aimbot angles", "\a696969FF ------------------------------------------"),
            label3       = ui.new_label("AA", "Anti-Aimbot angles", "     "),
            recharge_fix = ui.new_checkbox("AA", "Anti-Aimbot angles", "Recharge fix"),
            safehead     = ui.new_checkbox("AA", "Anti-Aimbot angles", "Safe Head"),
            e_spam       = ui.new_checkbox("AA", "Anti-Aimbot angles", "E-Spam"),
            legit_aa     = ui.new_checkbox("AA", "Anti-Aimbot angles", "Legit AA and Bombsite e-fix"),
            anti_stab       = ui.new_checkbox("AA", "Anti-Aimbot angles", "Avoid Backstab"),
            warmup_aa       = ui.new_checkbox("AA", "Anti-Aimbot angles", "Warmup AA"),
            label8       = ui.new_label("AA", "Anti-Aimbot angles", "     "),
            label7       = ui.new_label("AA", "Anti-Aimbot angles", "\a696969FF ------------------------------------------"),
            label9       = ui.new_label("AA", "Anti-Aimbot angles", "    "),
            freestand    = ui.new_hotkey("AA", "Anti-Aimbot angles", "Auto Direction"),
            left         = ui.new_hotkey("AA", "Anti-Aimbot angles", "Manual Left"),
            right        = ui.new_hotkey("AA", "Anti-Aimbot angles", "Manual Right"),
            forward        = ui.new_hotkey("AA", "Anti-Aimbot angles", "Manual Forward"),
            edge_yaw     = ui.new_hotkey("AA", "Anti-Aimbot angles", "Edge Yaw")
        }

        lua_menu.aa = {
            state_selector = ui.new_combobox("AA", "Anti-Aimbot angles", "State selector", states)
        }

        lua_menu.group_visibility()
    end

    function lua_menu.group_visibility()
        ui.set_visible(lua_menu.buttons.back, cur_tab ~= 1)

        -- AA tab
        ui.set_visible(lua_menu.aa.state_selector, cur_tab == 2)

        -- Discloser tab
        ui.set_visible(lua_menu.discloser.micro_yaw, cur_tab == 5)
        ui.set_visible(lua_menu.discloser.label1, cur_tab == 5)
        ui.set_visible(lua_menu.discloser.label2, cur_tab == 5)
        ui.set_visible(lua_menu.discloser.label3, cur_tab == 5)
        ui.set_visible(lua_menu.discloser.label4, cur_tab == 5)
        ui.set_visible(lua_menu.discloser.label5, cur_tab == 5)
        ui.set_visible(lua_menu.discloser.label6, cur_tab == 5)
        ui.set_visible(lua_menu.discloser.safehead, cur_tab == 5)
        ui.set_visible(lua_menu.discloser.freestand, cur_tab == 5)
        ui.set_visible(lua_menu.discloser.left, cur_tab == 5)
        ui.set_visible(lua_menu.discloser.right, cur_tab == 5)
        ui.set_visible(lua_menu.discloser.legit_aa, cur_tab == 5)
        ui.set_visible(lua_menu.discloser.edge_yaw, cur_tab == 5)
        ui.set_visible(lua_menu.discloser.label8, cur_tab == 5)
        ui.set_visible(lua_menu.discloser.label7, cur_tab == 5)
        ui.set_visible(lua_menu.discloser.label9, cur_tab == 5)
        ui.set_visible(lua_menu.discloser.anti_stab, cur_tab == 5)
        ui.set_visible(lua_menu.discloser.fake_lag_addon, cur_tab == 5)
        ui.set_visible(lua_menu.discloser.warmup_aa, cur_tab == 5)
        ui.set_visible(lua_menu.discloser.recharge_fix, cur_tab == 5)
        ui.set_visible(lua_menu.discloser.forward, cur_tab == 5)

        -- Visuals tab
        ui.set_visible(lua_menu.checkboxes.revolver_helper, cur_tab == 3)
        ui.set_visible(lua_menu.checkboxes.animfix, cur_tab == 3)
        ui.set_visible(lua_menu.checkboxes.damage_indicator, cur_tab == 3)
    
        -- Misc tab
        ui.set_visible(lua_menu.checkboxes.clantag, cur_tab == 4)
        ui.set_visible(lua_menu.checkboxes.fix_hideshots, cur_tab == 4)
        ui.set_visible(lua_menu.checkboxes.console_filter, cur_tab == 4)

        -- Main tab
        ui.set_visible(lua_menu.buttons.aa, cur_tab == 1)
        ui.set_visible(lua_menu.buttons.visuals, cur_tab == 1)
        ui.set_visible(lua_menu.buttons.misc, cur_tab == 1)
        ui.set_visible(lua_menu.buttons.discloser, cur_tab == 1)
        ui.set_visible(lua_menu.buttons.config, cur_tab == 1)
    end
end

lua_menu.init()

local function visuals_visibility()
    ui.set_visible(lua_menu.checkboxes.damage_indicator_font, ui.get(lua_menu.checkboxes.damage_indicator) and cur_tab == 3)

    ui.set_visible(lua_menu.discloser.first_flick, ui.get(lua_menu.discloser.micro_yaw) and cur_tab == 5)
    ui.set_visible(lua_menu.discloser.second_flick, ui.get(lua_menu.discloser.micro_yaw) and cur_tab == 5)
    ui.set_visible(lua_menu.discloser.e_spam, ui.get(lua_menu.discloser.safehead) and cur_tab == 5)
end
visuals_visibility()

for _, state_name in ipairs(states) do
    local prefix = "\a0FA6E0FF" .. state_name .. " \aC0C0C0FF"
    if state_name ~= "Global" then
        lua_menu.aa[state_name] = {
            allow          = ui.new_checkbox("AA", "Anti-Aimbot angles", "Allow " .. prefix),
            yaw_select     = ui.new_combobox("AA", "Anti-Aimbot angles", prefix .. "yaw type", "180", "Delayed", "Layered", "Discloser"),
            yaw_180        = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "yaw", -180, 180, 0, true, "°"),
            yaw_l          = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "yaw left", -180, 180, 0, true, "°"),
            yaw_r          = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "yaw right", -180, 180, 0, true, "°"),
            yaw_d          = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "delay", 1, 14, 1, true, "t"),
            yaw_rd         = ui.new_checkbox("AA", "Anti-Aimbot angles", prefix .. "randomize delay"),
            yaw_rds        = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "delay", 1, 10, 1, true, "t"),
            yaw_jitter     = ui.new_combobox("AA", "Anti-Aimbot angles", prefix .. "yaw jitter", "Off", "Offset", "Center", "Random", "Skitter"),
            yaw_jitter_value = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "yaw jitter value", -180, 180, 0, true, "°"),
            yaw_bodyselect = ui.new_combobox("AA", "Anti-Aimbot angles", prefix .. "body yaw type", "Off", "GameSense", "Custom"),
            yaw_bodytype   = ui.new_combobox("AA", "Anti-Aimbot angles", prefix .. "body yaw", "Static", "Jitter"),
            yaw_bodyvalue  = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "body yaw value", -60, 60, 0, true, "°"),
            break_type     = ui.new_combobox("AA", "Anti-Aimbot angles", prefix .. "break lc", "On Peek", "Always"),
            defensive_aa   = ui.new_checkbox("AA", "Anti-Aimbot angles", prefix .. "defensive anti-aim setup"),
            defensive_pitch = ui.new_combobox("AA", "Anti-Aimbot angles", prefix .. "defensive pitch", "Off", "Static", "Jitter"),
            defensive_pitch_slider = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "defensive pitch angle", -89, 89, 0, true, "°"),
            defensive_pitch_slider_2 = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "defensive second pitch angle", -89, 89, 0, true, "°"),
            defensive_yaw = ui.new_combobox("AA", "Anti-Aimbot angles", prefix .. "defensive yaw", "Off", "Static", "Jitter", "Spin"),
            defensive_yaw_slider = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "defensive yaw angle", -180, 180, 0, true, "°"),
            defensive_yaw_slider_2 = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "defensive second yaw angle", -180, 180, 0, true, "°"),
            defensive_yaw_speed = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "defensive yaw speed", 1, 100, 0, true, "/s"),
        }
    else
        lua_menu.aa[state_name] = {
            yaw_select     = ui.new_combobox("AA", "Anti-Aimbot angles", prefix .. "yaw type", "180", "Delayed", "Layered", "Discloser"),
            yaw_180        = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "yaw", -180, 180, 0, true, "°"),
            yaw_l          = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "yaw left", -180, 180, 0, true, "°"),
            yaw_r          = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "yaw right", -180, 180, 0, true, "°"),
            yaw_d          = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "delay", 1, 14, 1, true, "t"),
            yaw_rd         = ui.new_checkbox("AA", "Anti-Aimbot angles", prefix .. "randomize delay"),
            yaw_rds        = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "randomize value", 1, 10, 1, true, "t"),
            yaw_jitter     = ui.new_combobox("AA", "Anti-Aimbot angles", prefix .. "yaw jitter", "Off", "Offset", "Center", "Random", "Skitter"),
            yaw_jitter_value = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "yaw jitter value", -180, 180, 0, true, "°"),
            yaw_bodyselect = ui.new_combobox("AA", "Anti-Aimbot angles", prefix .. "body yaw type", "Off", "GameSense", "Custom"),
            yaw_bodytype   = ui.new_combobox("AA", "Anti-Aimbot angles", prefix .. "body yaw", "Static", "Jitter"),
            yaw_bodyvalue  = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "body yaw value", -60, 60, 0, true, "°"),
            break_type     = ui.new_combobox("AA", "Anti-Aimbot angles", prefix .. "break lc", "On Peek", "Always"),
            defensive_aa   = ui.new_checkbox("AA", "Anti-Aimbot angles", prefix .. "defensive anti-aim setup"),
            defensive_pitch = ui.new_combobox("AA", "Anti-Aimbot angles", prefix .. "defensive pitch", "Off", "Static", "Jitter"),
            defensive_pitch_slider = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "defensive pitch angle", -89, 89, 0, true, "°"),
            defensive_pitch_slider_2 = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "defensive second pitch angle", -89, 89, 0, true, "°"),
            defensive_yaw = ui.new_combobox("AA", "Anti-Aimbot angles", prefix .. "defensive yaw", "Off", "Static", "Jitter", "Spin"),
            defensive_yaw_slider = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "defensive yaw angle", -180, 180, 0, true, "°"),
            defensive_yaw_slider_2 = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "defensive second yaw angle", -180, 180, 0, true, "°"),
            defensive_yaw_speed = ui.new_slider("AA", "Anti-Aimbot angles", prefix .. "defensive yaw speed", 1, 100, 0, true, "/s"),
        }
    end
end

local function aa_visibility()
    local selected_state = ui.get(lua_menu.aa.state_selector)
    for _, state_name in ipairs(states) do
        local state = lua_menu.aa[state_name]
        local is_current = (state_name == selected_state and cur_tab == 2)
        local is_allowed = (state_name == "Global" or (state.allow and ui.get(state.allow)))

        if state.allow then ui.set_visible(state.allow, is_current) end
        if state.yaw_select then
            ui.set_visible(state.yaw_select, is_current and is_allowed)
        end
        if state.yaw_180 then
            ui.set_visible(state.yaw_180, is_current and is_allowed and (ui.get(state.yaw_select) == "180"))
        end
        if state.yaw_l then
            local sel = ui.get(state.yaw_select)
            ui.set_visible(state.yaw_l, is_current and is_allowed and (sel == "Delayed" or sel == "Layered" or sel == "Discloser"))
        end
        if state.yaw_r then
            local sel = ui.get(state.yaw_select)
            ui.set_visible(state.yaw_r, is_current and is_allowed and (sel == "Delayed" or sel == "Layered" or sel == "Discloser"))
        end
        if state.yaw_d then
            local sel = ui.get(state.yaw_select)
            ui.set_visible(state.yaw_d, is_current and is_allowed and (sel == "Delayed" or sel == "Discloser"))
        end
        if state.yaw_rd then
            local sel = ui.get(state.yaw_select)
            ui.set_visible(state.yaw_rd, is_current and is_allowed and (sel == "Delayed" or sel == "Discloser"))
        end
        if state.yaw_rds then
            local sel = ui.get(state.yaw_select)
            ui.set_visible(state.yaw_rds, is_current and is_allowed and (sel == "Delayed" or sel == "Discloser") and ui.get(state.yaw_rd))
        end
        if state.yaw_jitter then
            ui.set_visible(state.yaw_jitter, is_current and is_allowed and ui.get(state.yaw_select) ~= "Discloser")
        end
        if state.yaw_jitter_value then
            ui.set_visible(state.yaw_jitter_value, is_current and is_allowed and ui.get(state.yaw_jitter) ~= "Off" and ui.get(state.yaw_select) ~= "Discloser")
        end
        if state.yaw_bodyselect then
            ui.set_visible(state.yaw_bodyselect, is_current and is_allowed)
        end
        if state.yaw_bodytype then
            ui.set_visible(state.yaw_bodytype, is_current and is_allowed and ui.get(state.yaw_bodyselect) ~= "Off")
        end
        if state.yaw_bodyvalue then
            ui.set_visible(state.yaw_bodyvalue, is_current and is_allowed and ui.get(state.yaw_bodyselect) ~= "Off")
        end
        if state.break_type then
            ui.set_visible(state.break_type, is_current and is_allowed)
        end
        if state.defensive_aa then
            ui.set_visible(state.defensive_aa, is_current and is_allowed)
        end
        if state.defensive_pitch then
            ui.set_visible(state.defensive_pitch, is_current and is_allowed and ui.get(state.defensive_aa))
        end
        if state.defensive_yaw then
            ui.set_visible(state.defensive_yaw, is_current and is_allowed and ui.get(state.defensive_aa))
        end
        if state.defensive_pitch_slider then
            ui.set_visible(state.defensive_pitch_slider, is_current and is_allowed and ui.get(state.defensive_aa) and (ui.get(state.defensive_pitch) == "Static" or ui.get(state.defensive_pitch) == "Jitter"))
        end
        if state.defensive_pitch_slider_2 then
            ui.set_visible(state.defensive_pitch_slider_2, is_current and is_allowed and ui.get(state.defensive_aa) and ui.get(state.defensive_pitch) == "Jitter")
        end
        if state.defensive_yaw_slider then
            ui.set_visible(state.defensive_yaw_slider, is_current and is_allowed and ui.get(state.defensive_aa) and (ui.get(state.defensive_yaw) == "Static" or ui.get(state.defensive_yaw) == "Jitter"))
        end
        if state.defensive_yaw_slider_2 then
            ui.set_visible(state.defensive_yaw_slider_2, is_current and is_allowed and ui.get(state.defensive_aa) and (ui.get(state.defensive_yaw) == "Jitter"))
        end
        if state.defensive_yaw_speed then
            ui.set_visible(state.defensive_yaw_speed, is_current and is_allowed and ui.get(state.defensive_aa) and (ui.get(state.defensive_yaw) == "Spin"))
        end
    end
end

aa_visibility()
---@lua_menu_end

---@anti-aim handle
local pred_value = { chokedcommands = 1, silent_shift = 1, tickcount = 1 }
local command_number = 1

local function update_command_number(cmd)
    command_number = cmd.command_number
end

local function update_pred_value(cmd)
    pred_value.chokedcommands = cmd.chokedcommands
    pred_value.silent_shift = cvar.sv_maxusrcmdprocessticks:get_float() - pred_value.chokedcommands - 1
    pred_value.tickcount = globals.tickcount()
end

local jitter_switch, delay_timer = false, 0

local function delayjitter(switchyaw1, switchyaw2, speed, yawrandom)
    speed = speed + 1
    local random_left  = math.random(0, switchyaw1 * yawrandom / 100)
    local random_right = math.random(0, switchyaw2 * yawrandom / 100)

    if globals.chokedcommands() == 0 and (command_number % 2 >= math.abs(math.sin(globals.chokedcommands()))) then
        delay_timer = delay_timer + 1
        if delay_timer % speed == 0 then
            jitter_switch = not jitter_switch
        end
    end

    local final_yaw = jitter_switch and (switchyaw1 + random_left) or (switchyaw2 - random_right)
    return tools.clamp(final_yaw, -180, 180)
end

is_on_ground = false
local function get_player_state(cmd)
    local lp = entity.get_local_player()
    if not lp or not entity.is_alive(lp) then
        return "Unknown"
    end

    local vecvelocity = { entity.get_prop(lp, 'm_vecVelocity') }
    local flags = entity.get_prop(lp, 'm_fFlags')
    local velocity = vector(entity.get_prop(lp, "m_vecAbsVelocity")):length2d()
    local in_grounded = bit.band(flags, 1) == 1
    local jump = bit.band(flags, 1) == 0 or cmd.in_jump == 1
    local ducked = entity.get_prop(lp, 'm_flDuckAmount') > 0.7
    local duck = ducked
    local is_slowwalk = ui.get(ref.slow_walk[1]) and ui.get(ref.slow_walk[2])
    is_on_ground = in_grounded

    if jump and duck then
        return "Air-Duck"
    elseif jump then
        return "Air"
    elseif duck and velocity > 10 then
        return "Duck-Running"
    elseif duck and velocity < 10 then
        return "Duck"
    elseif in_grounded and is_slowwalk and velocity > 10 then
        return "Slow-walk"
    elseif in_grounded and velocity > 5 then
        return "Running"
    elseif in_grounded and velocity < 5 then
        return "Stand"
    else
        return "Unknown"
    end
end

---@defensive check
local defensive_system = {
    ticks_count = 0,
    max_tick_base = 0,
    is_defensive = false
}

local function defensiveCheck(cmd)

    local lp = entity.get_local_player()
    if not lp or not entity.is_alive(lp) then return end

    local current_tick = globals.tickcount()
    local tick_base = entity.get_prop(lp, "m_nTickBase") or 0
    local can_exploit = current_tick > tick_base

    if math.abs(tick_base - defensive_system.max_tick_base) > 64 and can_exploit then
        defensive_system.max_tick_base = 0
    end

    if tick_base > defensive_system.max_tick_base then
        defensive_system.max_tick_base = tick_base
    elseif defensive_system.max_tick_base > tick_base then
        defensive_system.ticks_count = can_exploit and math.min(14, math.max(0, defensive_system.max_tick_base - tick_base - 1)) or 0
    end

    defensive_system.is_defensive = (defensive_system.ticks_count > 2
        and defensive_system.ticks_count < 13)
end

local defensive_data = {
    pitch = 0,
    yaw = 0
}

local current_tick = tools.time_to_ticks(globals.realtime())
local function on_setup_command(cmd)
    cmd.allow_send_packet = true
    ui.set(ref.enabled, true)
    ui.set(ref.yaw_base, "At Targets")
    ui.set(ref.pitch[1], "Minimal")
    ui.set(ref.yaw[1], "180")
    ui.set(ref.yaw_jitter[1], "Off")
    ui.set(ref.freestanding_body_yaw, false)

    local condition = get_player_state(cmd)
    local settings = lua_menu.aa[condition]
    if not settings or (condition ~= "Global" and not ui.get(settings.allow)) then
        settings = lua_menu.aa["Global"]
    end

    if not entity.is_alive(entity.get_local_player()) then 
        return 
    end

    local yawSelect   = ui.get(settings.yaw_select)
    local yaw_l       = ui.get(settings.yaw_l)
    local yaw_r       = ui.get(settings.yaw_r)
    local yaw_d       = ui.get(settings.yaw_d)
    local yaw_rd      = ui.get(settings.yaw_rd)
    local yaw_rds     = ui.get(settings.yaw_rds)
    local delay_total = yaw_rd and (yaw_d + math.random(0, yaw_rds)) or yaw_d
    local switch_ticks = tools.time_to_ticks(globals.realtime()) - current_tick
    local switch

    if yawSelect == "180" then
        ui.set(ref.yaw[2], ui.get(settings.yaw_180))
    elseif yawSelect == "Delayed" or yawSelect == "Discloser" then
        ui.set(ref.yaw[2], delayjitter(yaw_l, yaw_r, delay_total, 0))
    elseif yawSelect == "Layered" then
            
        if switch_ticks * 2 >= 3 then
            switch = true
        else
            switch = false
        end
        if switch_ticks >= 3 then
            current_tick = tools.time_to_ticks(globals.realtime())
        end
        ui.set(ref.yaw[2], switch and yaw_l or yaw_r)
    end

    local bodySelect = ui.get(settings.yaw_bodyselect)
    local bodyType   = ui.get(settings.yaw_bodytype)
    local bodyValue  = ui.get(settings.yaw_bodyvalue)

    if bodySelect == "GameSense" then
        if bodyType == "Jitter" then
            if yawSelect == "Delayed" or yawSelect == "Discloser" then
                ui.set(ref.body_yaw[1], "Static")
                ui.set(ref.body_yaw[2], delayjitter(-bodyValue, bodyValue, delay_total, 0))
            elseif yawSelect == "Layered" then
                ui.set(ref.body_yaw[1], "Static")
                ui.set(ref.body_yaw[2], switch and -bodyValue or bodyValue)
            else
                ui.set(ref.body_yaw[1], "Static")
                ui.set(ref.body_yaw[2], delayjitter(-bodyValue, bodyValue, 1, 0))
            end
        elseif bodyType == "Static" then
            ui.set(ref.body_yaw[1], "Static")
            ui.set(ref.body_yaw[2], bodyValue)
        end
    elseif bodySelect == "Off" then
        ui.set(ref.body_yaw[1], "Off")
    elseif bodySelect == "Custom" then
        if bodyType == "Static" then
            ui.set(ref.body_yaw[1], "Static")
            local custom_val = ((not ui.get(ref.dt[2]) and not ui.get(ref.hs[2]) or ui.get(ref.fd)) and bodyValue) or 0
            ui.set(ref.body_yaw[2], custom_val)
            if globals.chokedcommands() > 0 then
                cmd.allow_send_packet = true
            else
                cmd.allow_send_packet = false
                ui.set(ref.yaw[2], -bodyValue)
            end
        elseif bodyType == "Jitter" then
            if yawSelect == "Delayed" then
                ui.set(ref.body_yaw[1], "Static")
                local jitter_val = (not ui.get(ref.dt[2]) and not ui.get(ref.hs[2]) or ui.get(ref.fd))
                                  and delayjitter(-bodyValue, bodyValue, delay_total, 0) or 0
                ui.set(ref.body_yaw[2], jitter_val)
                if globals.chokedcommands() > 0 then
                    cmd.allow_send_packet = true
                else
                    cmd.allow_send_packet = false
                    ui.set(ref.yaw[2], delayjitter(bodyValue, -bodyValue, delay_total, 0))
                end
            elseif yawSelect == "Discloser" then
                ui.set(ref.body_yaw[1], "Static")
                local jitter_val = (not ui.get(ref.dt[2]) and not ui.get(ref.hs[2]) or ui.get(ref.fd))
                                  and delayjitter(-bodyValue, bodyValue, delay_total, 0) or 0
                ui.set(ref.body_yaw[2], jitter_val)
                if globals.chokedcommands() > 0 then
                    cmd.allow_send_packet = true
                else
                    cmd.allow_send_packet = false
                    ui.set(ref.yaw[2], delayjitter(bodyValue, -bodyValue, delay_total, 0))
                end
            elseif yawSelect == "Layered" then
                ui.set(ref.body_yaw[1], "Static")
                local condition = (not ui.get(ref.dt[2]) and not ui.get(ref.hs[2])) or ui.get(ref.fd)
                local layered_val = condition and (switch and -bodyValue or bodyValue) or 0
                ui.set(ref.body_yaw[2], layered_val)
                if globals.chokedcommands() > 0 then
                    cmd.allow_send_packet = true
                else
                    cmd.allow_send_packet = false
                    ui.set(ref.yaw[2], switch and -bodyValue or bodyValue)
                end
            else
                ui.set(ref.body_yaw[1], "Static")
                local jitter_val = (not ui.get(ref.dt[2]) and not ui.get(ref.hs[2]) or ui.get(ref.fd))
                                  and delayjitter(-bodyValue, bodyValue, 1, 0) or 0
                ui.set(ref.body_yaw[2], jitter_val)
                if globals.chokedcommands() > 0 then
                    cmd.allow_send_packet = true
                else
                    cmd.allow_send_packet = false
                    ui.set(ref.yaw[2], delayjitter(bodyValue, -bodyValue, 1, 0))
                end
            end
        end
    end

    if yawSelect ~= "Discloser" then
        ui.set(ref.yaw_jitter[1], ui.get(settings.yaw_jitter))
        ui.set(ref.yaw_jitter[2], ui.get(settings.yaw_jitter_value))
    end

    if yawSelect == "Discloser" then
        if ui.get(lua_menu.discloser.micro_yaw) then
            if globals.chokedcommands() > 0 then
                ui.set(ref.yaw_jitter[1], "Random")
                ui.set(ref.yaw_jitter[2], ui.get(lua_menu.discloser.first_flick))
            else
                ui.set(ref.yaw_jitter[1], "Offset")
                ui.set(ref.yaw_jitter[2], ui.get(lua_menu.discloser.second_flick))
            end
        end
    end

    ---defensive aa
    local break_   = ui.get(settings.break_type)

    cmd.force_defensive = break_ == "Always" and true or false

    if ui.get(settings.defensive_aa) then
        if ui.get(settings.defensive_pitch) == "Static" then
            defensive_data.pitch = ui.get(settings.defensive_pitch_slider)
        elseif ui.get(settings.defensive_pitch) == "Jitter" then
            defensive_data.pitch = delayjitter(ui.get(settings.defensive_pitch_slider), ui.get(settings.defensive_pitch_slider_2), delay_total, 0)
        end

        if ui.get(settings.defensive_yaw) == "Static" then
            defensive_data.yaw = ui.get(settings.defensive_yaw_slider)
        elseif ui.get(settings.defensive_yaw) == "Jitter" then
            defensive_data.yaw = delayjitter(ui.get(settings.defensive_yaw_slider), ui.get(settings.defensive_yaw_slider_2), delay_total, 0)
        elseif ui.get(settings.defensive_yaw) == "Spin" then
            defensive_data.yaw = ui.get(settings.defensive_yaw_speed)
        end
    end

    if defensive_system.is_defensive and ui.get(settings.defensive_aa) then
        ui.set(ref.yaw_jitter[1], "Off")
        if ui.get(settings.defensive_pitch) ~= "Off" then
            ui.set(ref.pitch[1], "Custom")
            ui.set(ref.pitch[2], defensive_data.pitch)
        end
        if ui.get(settings.defensive_yaw) ~= "Off" and ui.get(settings.defensive_yaw) ~= "Spin" then
            ui.set(ref.yaw[1], "180")
            ui.set(ref.yaw[2], defensive_data.yaw)
        elseif ui.get(settings.defensive_yaw) == "Spin" then
            ui.set(ref.yaw[1], "Spin")
            ui.set(ref.yaw[2], defensive_data.yaw)
        end
    end
end
---@end

---@freestand
local function freestanding()    
    if ui.get(lua_menu.discloser.freestand) then
        ui.set(ref.freestand[1], true)   
        ui.set(ref.freestand[2], "Always On")
    else
        ui.set(ref.freestand[1], false)
        ui.set(ref.freestand[2], "On Hotkey")
    end
end
---@end

---@safehead
local function safehead(cmd)
    if not ui.get(lua_menu.discloser.safehead) then
        return
    end
    local player = entity.get_local_player()
    if not player or not entity.is_alive(player) then
        return
    end

    local state = get_player_state(cmd)
    if state == "Air-Duck" then
        local active_weapon = entity.get_prop(player, "m_hActiveWeapon")
        if active_weapon and entity.get_classname(active_weapon) == "CKnife" then
            ui.set(ref.yaw[1], "180")
            ui.set(ref.yaw[2], 0)
            ui.set(ref.body_yaw[2], -60)
            ui.set(ref.pitch[2], 89)
            ui.set(ref.yaw_jitter[1], "Off")
            if ui.get(lua_menu.discloser.e_spam) then
                cmd.force_defensive = true
                if defensive_system.is_defensive then
                    ui.set(ref.yaw[1], "180")
                    ui.set(ref.yaw[2], -180)
                    ui.set(ref.pitch[1], "Custom")
                    ui.set(ref.pitch[2], math.random(-2, 2))
                end
            end
        end
    end
end
---@end

---@manual
local yaw_direction = 0
local last_press_t_dir = 0

local yawDirectionMapping = {
    { keyFunc = function() return ui.get(lua_menu.discloser.right) end, value = 90 },
    { keyFunc = function() return ui.get(lua_menu.discloser.left) end, value = -90 },
    { keyFunc = function() return ui.get(lua_menu.discloser.forward) end, value = -180 }
}

local function manual_yaw()
    local curtime = globals.curtime()
    
    for _, mapping in ipairs(yawDirectionMapping) do
        if mapping.keyFunc() and (last_press_t_dir + 0.13 < curtime) then
            yaw_direction = (yaw_direction == mapping.value) and 0 or mapping.value
            last_press_t_dir = curtime
            break
        end
    end

    if last_press_t_dir > curtime then
        last_press_t_dir = curtime
    end

    if yaw_direction ~= 0 then
        ui.set(ref.yaw_base, "Local view")
        ui.set(ref.yaw[1], "180")
        ui.set(ref.yaw[2], yaw_direction)
        ui.set(ref.yaw_jitter[1], "Off")
    end
end
---@end


---@manual indicators
local transition_progress = 1
local last_yaw_direction = 0
local scope_offset = 0

local function render_manual()
    local screenW, screenH = client.screen_size()
    local centerX, centerY = screenW / 2, screenH / 2
    local lp = entity.get_local_player()
    local isScoped = lp and (entity.get_prop(lp, "m_bIsScoped") == 1)

    if yaw_direction ~= last_yaw_direction then
        transition_progress = math.max(transition_progress - 0.1, 0)
        if transition_progress == 0 then
            last_yaw_direction = yaw_direction
        end
    elseif transition_progress < 1 then
        transition_progress = math.min(transition_progress + 0.1, 1)
    end

    local alpha = 255 * transition_progress
    if alpha < 1 then return end

    local base_offset = (last_yaw_direction ~= 0) and 60 or 40
    local animated_offset = base_offset * transition_progress
    local target_scope_offset = ((last_yaw_direction == -90 or last_yaw_direction == 90) and isScoped) and 30 or 0
    scope_offset = tools.lerp(scope_offset, target_scope_offset, 0.1)
    local animated_scope_offset = scope_offset * transition_progress

    local r, g, b, a = 255, 255, 255, alpha
    local arrowWidth, arrowHeight = 15, 15

    if last_yaw_direction == -90 then
        local cx = centerX - animated_offset
        local cy = centerY - animated_scope_offset
        local tipX = cx - arrowWidth / 2
        local tipY = cy
        local topX = cx + arrowWidth / 2
        local topY = cy - arrowHeight / 2
        local bottomX = cx + arrowWidth / 2
        local bottomY = cy + arrowHeight / 2
        renderer.line(tipX, tipY, topX, topY, r, g, b, a)
        renderer.line(topX, topY, bottomX, bottomY, r, g, b, a)
        renderer.line(bottomX, bottomY, tipX, tipY, r, g, b, a)
    elseif last_yaw_direction == 90 then
        local cx = centerX + animated_offset
        local cy = centerY - animated_scope_offset
        local tipX = cx + arrowWidth / 2
        local tipY = cy
        local topX = cx - arrowWidth / 2
        local topY = cy - arrowHeight / 2
        local bottomX = cx - arrowWidth / 2
        local bottomY = cy + arrowHeight / 2
        renderer.line(tipX, tipY, topX, topY, r, g, b, a)
        renderer.line(topX, topY, bottomX, bottomY, r, g, b, a)
        renderer.line(bottomX, bottomY, tipX, tipY, r, g, b, a)
    end
end
---@end

---@clantag
local clan_tags = {"A", "Ad", "Adj", "Adju", "Adjus", "Adjust", "Adjus", "Adju", "Adj", "Ad", "A", ""}
local last_step = -1
local frame_interval = 16

local function clantag()
    local enabled = ui.get(lua_menu.checkboxes.clantag)
    local server_tick = globals.tickcount()
    local current_step = math.floor(server_tick / frame_interval)

    if not enabled then
        if last_step ~= -1 then
            client.set_clan_tag("")
            last_step = -1
        end
        return
    end
    
    if last_step == current_step then return end
    
    local new_index = (current_step % #clan_tags) + 1
    client.set_clan_tag(clan_tags[new_index])
    last_step = current_step
end
---@end


---@config_system

local function export_config()
    local config_data = {
        aa = {},
        discloser = {
            micro_yaw = ui.get(lua_menu.discloser.micro_yaw),
            first_flick = ui.get(lua_menu.discloser.first_flick),
            second_flick = ui.get(lua_menu.discloser.second_flick),
            safehead = ui.get(lua_menu.discloser.safehead),
            espam = ui.get(lua_menu.discloser.e_spam),
            legitaa = ui.get(lua_menu.discloser.legit_aa),
            anti_stab = ui.get(lua_menu.discloser.anti_stab),
            fake_lag_addon = ui.get(lua_menu.discloser.fake_lag_addon),
            warmup_aa = ui.get(lua_menu.discloser.warmup_aa)
        },
        visuals = {
            revolver_helper = ui.get(lua_menu.checkboxes.revolver_helper),
            animfix = ui.get(lua_menu.checkboxes.animfix)
        },
        misc = {
            clantag = ui.get(lua_menu.checkboxes.clantag),
            fix_hideshots = ui.get(lua_menu.checkboxes.fix_hideshots)
        }
    }

    for _, state_name in ipairs(states) do
        local state_config = {}
        
        if state_name ~= "Global" then
            state_config.allow = ui.get(lua_menu.aa[state_name].allow)
        end

        local ui_elements = {
            "yaw_select", "yaw_180", "yaw_l", "yaw_r", "yaw_d", "yaw_rd", "yaw_rds", 
            "yaw_jitter", "yaw_jitter_value", "yaw_bodyselect", "yaw_bodytype", 
            "yaw_bodyvalue", "break_type", "defensive_aa", "defensive_pitch", 
            "defensive_pitch_slider", "defensive_pitch_slider_2", "defensive_yaw", 
            "defensive_yaw_slider", "defensive_yaw_slider_2", "defensive_yaw_speed"
        }

        for _, element in ipairs(ui_elements) do
            state_config[element] = ui.get(lua_menu.aa[state_name][element])
        end

        config_data.aa[state_name] = state_config
    end
   
    local json_data = json.stringify(config_data)
    local base64_data = base64.encode(json_data)
    clipboard.set(base64_data)
end

local function import_config(base64_data)
    local json_data = base64.decode(base64_data or clipboard.get())
    local config_data = json.parse(json_data)

    for k, v in pairs(config_data.discloser or {}) do
        if lua_menu.discloser[k] then
            ui.set(lua_menu.discloser[k], v)
        end
    end

    for k, v in pairs(config_data.visuals or {}) do
        if lua_menu.checkboxes[k] then
            ui.set(lua_menu.checkboxes[k], v)
        end
    end

    for k, v in pairs(config_data.misc or {}) do
        if lua_menu.checkboxes[k] then
            ui.set(lua_menu.checkboxes[k], v)
        end
    end
    
    for _, state_name in ipairs(states) do
        local state_config = config_data.aa and config_data.aa[state_name] or {}

        if state_name ~= "Global" and state_config.allow ~= nil then
            ui.set(lua_menu.aa[state_name].allow, state_config.allow)
        end

        local ui_elements = {
            "yaw_select", "yaw_180", "yaw_l", "yaw_r", "yaw_d", "yaw_rd", "yaw_rds", 
            "yaw_jitter", "yaw_jitter_value", "yaw_bodyselect", "yaw_bodytype", 
            "yaw_bodyvalue", "break_type", "defensive_aa", "defensive_pitch", 
            "defensive_pitch_slider", "defensive_pitch_slider_2", "defensive_yaw", 
            "defensive_yaw_slider", "defensive_yaw_slider_2", "defensive_yaw_speed"
        }

        for _, element in ipairs(ui_elements) do
            if state_config[element] ~= nil and lua_menu.aa[state_name][element] then
                ui.set(lua_menu.aa[state_name][element], state_config[element])
            end
        end
    end
end
import = ui.new_button("AA", "Anti-Aimbot angles", "Import", function() import_config() end)
export = ui.new_button("AA", "Anti-Aimbot angles", "Export", function() export_config() end)

local function config_visibillity()
    ui.set_visible(import, cur_tab == 6)
    ui.set_visible(export, cur_tab == 6)
end
config_visibillity()
---@end

---@e fix + legit AA-s
classnames = {
"CWorld",
"CCSPlayer",
"CFuncBrush"
}
local function distance3d(x1, y1, z1, x2, y2, z2)
	return math.sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1))
end

local function entity_has_c4(ent)
	local bomb = entity.get_all("CC4")[1]
	return bomb ~= nil and entity.get_prop(bomb, "m_hOwnerEntity") == ent
end

local function aa_on_use(cmd)
	if ui.get(lua_menu.discloser.legit_aa) then

        if cmd.in_use == 1 then
            ui.set(ref.pitch[1], "Off")
            ui.set(ref.yaw_base, "Local view")
            ui.set(ref.yaw[1], "180")
            ui.set(ref.yaw[2], 180)
            ui.set(ref.yaw_jitter[1], "Offset")
            ui.set(ref.yaw_jitter[2], 0)
            ui.set(ref.body_yaw[1], "Opposite")
            ui.set(ref.freestanding_body_yaw, true)
        end

		local plocal = entity.get_local_player()
		
		local distance = 100
		local bomb = entity.get_all("CPlantedC4")[1]
		local bomb_x, bomb_y, bomb_z = entity.get_prop(bomb, "m_vecOrigin")

		if bomb_x ~= nil then
			local player_x, player_y, player_z = entity.get_prop(plocal, "m_vecOrigin")
			distance = distance3d(bomb_x, bomb_y, bomb_z, player_x, player_y, player_z)
		end
		
		local team_num = entity.get_prop(plocal, "m_iTeamNum")
		local defusing = team_num == 3 and distance < 62

		local on_bombsite = entity.get_prop(plocal, "m_bInBombZone")

		local has_bomb = entity_has_c4(plocal)
        local cat = 3
		local trynna_plant = on_bombsite ~= 0 and team_num == 2 and has_bomb and cat ~= 3
		
		local px, py, pz = client.eye_position()
		local pitch, yaw = client.camera_angles()
	
		local sin_pitch = math.sin(math.rad(pitch))
		local cos_pitch = math.cos(math.rad(pitch))
		local sin_yaw = math.sin(math.rad(yaw))
		local cos_yaw = math.cos(math.rad(yaw))

		local dir_vec = { cos_pitch * cos_yaw, cos_pitch * sin_yaw, -sin_pitch }

		local fraction, entindex = client.trace_line(plocal, px, py, pz, px + (dir_vec[1] * 8192), py + (dir_vec[2] * 8192), pz + (dir_vec[3] * 8192))

		local using = true

		for i=0, #classnames do
			if entity.get_classname(entindex) == classnames[i] then
				using = false
			end
		end

		if not using and not trynna_plant and not defusing then
			cmd.in_use = 0
		end
	end
end
---@end

---@revolver helper
local function is_revolver(weapon)
	local weapon_id = entity.get_prop(weapon, "m_iItemDefinitionIndex")
	return weapon_id == 64
end

local function check_revolver_distance3d(player, victim)
	if player == nil or victim == nil then return 0 end

	local weapon = entity.get_prop(player, "m_hActiveWeapon")
	if weapon == nil or not is_revolver(weapon) then return 0 end

	local player_x, player_y, player_z = entity.get_origin(player)
	local victim_x, victim_y, victim_z = entity.get_origin(victim)

	if player_x == nil or victim_x == nil then
		return 0
	end

	local units = distance3d(player_x, player_y, player_z, victim_x, victim_y, victim_z)
	local no_kevlar = entity.get_prop(victim, "m_ArmorValue") == 0
	local height_difference = player_z - victim_z

	if height_difference > 100 and units < 300 then
		return "DMG+"
	elseif units > 585 then
		return "DMG-"
	elseif units < 585 and units > 511 then
		return "DMG"
	elseif units <= 511 and no_kevlar then
		return "DMG+"
	else
		return "DMG"
	end
end

local function draw_status(player, status)
	local x1, y1, x2, y2, alpha_multiplier = entity.get_bounding_box(player)

	if x1 == nil or alpha_multiplier == 0 then
		return
	end
	
	local x_center = (x1 + x2) / 2
	local y_position = y1 - 20

	local color = {255, 0, 0}
	if status == "DMG" then
		color = {255, 255, 0}
	elseif status == "DMG+" then
		color = {50, 205, 50}
	end

	renderer.text(x_center, y_position, color[1], color[2], color[3], 255, "cb", 0, status)
end

local function rev_helper()
    if not ui.get(lua_menu.checkboxes.revolver_helper) then return end
   
    local lp = entity.get_local_player()
    if lp == nil or not entity.is_alive(lp) then return end
   
    local weapon = entity.get_prop(lp, "m_hActiveWeapon")
    if weapon == nil or not is_revolver(weapon) then
        return
    end
    local players = entity.get_players(true)
    if #players == 0 then
        return
    end
   
    for i = 1, #players do
        local entindex = players[i]
        if entindex ~= lp then
            local status = check_revolver_distance3d(lp, entindex)
            if status ~= 0 then
                draw_status(entindex, status)
            end
        end
    end
end
---@end

---@region animfix

local function animfix_setup()
    local animfix_values = ui.get(lua_menu.checkboxes.animfix)
    local self = entity.get_local_player()
    if not self or not entity.is_alive(self) then
        return
    end

    local self_index = c_entity.new(self)
    local self_anim_state = self_index:get_anim_state()


    if not self_anim_state then
        return
    end

    if contains(animfix_values, "Body lean") then
        local self_anim_overlay = self_index:get_anim_overlay(12)
        if not self_anim_overlay then
            return
        end
        local x_velocity = entity.get_prop(self, "m_vecVelocity[0]")
        if math.abs(x_velocity) >= 3 then
            self_anim_overlay.weight = 1
        end
    end

    if contains(animfix_values, "Jitter legs on ground") and is_on_ground then

        ui.set(ui.reference("AA", "other", "leg movement"), command_number % 3 == 0 and "Off" or "Always slide")
        entity.set_prop(self, "m_flPoseParameter", 1, globals.tickcount() % 4 > 1 and 5 / 10 or 1)

    end

    if contains(animfix_values, "Static in Air") and not is_on_ground then

        entity.set_prop(self, "m_flPoseParameter", 1 , 6)

    end

    if contains(animfix_values, "Kangaroo") then

        entity.set_prop(self, "m_flPoseParameter", math.random(0, 10)/10, 3)
        entity.set_prop(self, "m_flPoseParameter", math.random(0, 10)/10, 7)
        entity.set_prop(self, "m_flPoseParameter", math.random(0, 10)/10, 6)

    end

    if contains(animfix_values, "0 pitch on landing") then
        if not self_anim_state.hit_in_ground_animation or not is_on_ground then
            return
        end

        entity.set_prop(self, "m_flPoseParameter", 0.5, 12)
    end
end
---@end

---@edge yaw
local function edge_yaw()
    ui.set(ref.edge_yaw, ui.get(lua_menu.discloser.edge_yaw))
end
---@end

---@avoid backstab
local function anti_stab()
    if not ui.get(lua_menu.discloser.anti_stab) then return end
    
    local lp = entity.get_local_player()
    if not lp or not entity.is_alive(lp) then return end
    
    local lp_origin = vector(entity.get_origin(lp))
    local enemies = entity.get_players(true)
    
    for i = 1, #enemies do
        local enemy = enemies[i]
        local enemy_weapon = entity.get_player_weapon(enemy)
        
        if enemy_weapon and entity.get_classname(enemy_weapon) == "CKnife" then
            if vector(entity.get_origin(enemy)):dist2d(lp_origin) < 250 then
                ui.set(ref.yaw[1], "180")
                ui.set(ref.yaw[2], 180)
                return
            end
        end
    end
end
---@end

---@fix hideshots
local original_fakelag_limit = 0

local function hideshots_fix()
    local fix_enabled = ui.get(lua_menu.checkboxes.fix_hideshots)
    local hs_enabled = ui.get(ref.hs[2])
    
    if fix_enabled and hs_enabled then
        if original_fakelag_limit == 0 then
            original_fakelag_limit = ui.get(ref.fakelag_limit)
        end
        ui.set(ref.fakelag_limit, 1)
        return
    end
    
    if original_fakelag_limit > 0 then
        ui.set(ref.fakelag_limit, original_fakelag_limit)
        original_fakelag_limit = 0
    end
end
---@end

---@fakelag addons
local original_variability = nil
local function fake_lag()
    local variability = 15 + 2 * math.random(0, (45 - 10) / 2)
    local addon_enabled = ui.get(lua_menu.discloser.fake_lag_addon)
   
    if addon_enabled then
        if original_variability == nil then
            original_variability = ui.get(ref.variability)
        end
        ui.set(ref.variability, variability)
        return
    end
   
    if original_variability ~= nil then
        ui.set(ref.variability, original_variability)
        original_variability = nil
    end
end
---@end

---@warmup aa
local function warmup()
    local player = entity.get_local_player()
    if not player then return end

    local gamerulesproxy = entity.get_all("CCSGameRulesProxy")[1]
    if not gamerulesproxy or entity.get_prop(gamerulesproxy, "m_bWarmupPeriod") ~= 1 then return end

    if ui.get(lua_menu.discloser.warmup_aa) then
        ui.set(ref.body_yaw[1], 'Off')
        ui.set(ref.yaw[1], "Spin")
        ui.set(ref.yaw[2], 15)
        ui.set(ref.pitch[1], "Custom")
        ui.set(ref.pitch[2], 0)
    end
end
---@end

---@damage indicator
local displayed_min_damage = 0
local function render_damage_indicator()
    if not ui.get(lua_menu.checkboxes.damage_indicator) then
        return
    end

    local player = entity.get_local_player()
    if not player or not entity.is_alive(player) then
        return
    end

    local screen_x, screen_y = client.screen_size()
    local x = screen_x / 2 + 15
    local y = screen_y / 2 - 11

    local min_damage = ui.get(ref.min_damage)
    if ui.get(ref.min_damage_override[2]) then
        min_damage = ui.get(ref.min_damage_override[3])
    end

    displayed_min_damage = tools.lerp(displayed_min_damage, min_damage, 0.12)

    local font = ui.get(lua_menu.checkboxes.damage_indicator_font)

    if font == "Verdana" then
        renderer.text(x, y, 255, 255, 255, 255, "c", nil, string.format("%.0f", displayed_min_damage))
    elseif font == "Pixel" then
        renderer.text(x - 5, y + 2, 255, 255, 255, 255, "c-", nil, string.format("%.0f", displayed_min_damage))
    end
end
---@end

---@recharge
local timer = globals.tickcount()
local recharge_delay = 11

local function handle_recharge()
    local lp = entity.get_local_player()
    if not entity.is_alive(lp) then return end
    
    local lp_weapon = entity.get_player_weapon(lp)
    if not lp_weapon then return end
    
    recharge_delay = weapons(lp_weapon).is_revolver and 18 or 11
 
    if ( ui.get(ref.dt[2]) or ui.get(ref.hs[2]) ) and ui.get(lua_menu.discloser.recharge_fix) then
        if globals.tickcount() >= timer + recharge_delay then
            ui.set(ref.aimbot, true)
        else
            ui.set(ref.aimbot, false)
        end
    else
        timer = globals.tickcount()
        ui.set(ref.aimbot, true)
    end
end
---@end

---@watermark
local function hsv_to_rgb(h, s, v)
    local c, x = v * s, v * s * (1 - math.abs((h * 6) % 2 - 1))
    local m = v - c
    local r, g, b = 0, 0, 0

    if h < 1/6 then r, g, b = c, x, 0
    elseif h < 2/6 then r, g, b = x, c, 0
    elseif h < 3/6 then r, g, b = 0, c, x
    elseif h < 4/6 then r, g, b = 0, x, c
    elseif h < 5/6 then r, g, b = x, 0, c
    else r, g, b = c, 0, x
    end

    return math.floor((r + m) * 255), math.floor((g + m) * 255), math.floor((b + m) * 255)
end

---local function fade_alpha(min_alpha, max_alpha, speed)
---    local time = globals.realtime() * speed
---    return math.floor(min_alpha + (max_alpha - min_alpha) * (math.sin(time) * 0.5 + 0.5))
---end

local function gradient_text(color1, color2, text, speed)
    local time = globals.realtime() * speed
    local gradient_str = ""
    local text_length = #text
    
    for i = 1, text_length do
        local char = text:sub(i, i)
        local t = (math.sin(time + (i / text_length) * math.pi) + 1) / 2
        local r = math.floor(color1[1] * t + color2[1] * (1 - t))
        local g = math.floor(color1[2] * t + color2[2] * (1 - t))
        local b = math.floor(color1[3] * t + color2[3] * (1 - t))
        gradient_str = gradient_str .. string.format("\a%02X%02X%02XFF%s", r, g, b, char)
    end
    
    return gradient_str
end

local function render_watermark()
    local screen_x, screen_y = client.screen_size()
    local start_x = screen_x / 2
    local y = screen_y - 15
    local text = gradient_text({56, 152, 255}, {152, 245, 249}, "adjust debug", 3.33)
    renderer.text(start_x, y, 255, 255, 255, 255, "dc", nil, text)
end
---@end

---@console filter
local function console_filter()
    if ui.get(lua_menu.checkboxes.console_filter) then
        cvar.con_filter_enable:set_int(1)
        cvar.con_filter_text:set_string("IrWL5106TZZKNFPz4P4Gl3pSN?J370f5hi373ZjPg%VOVh6lN")
    else
        cvar.con_filter_enable:set_int(0)
        cvar.con_filter_text:set_string("")
    end
end

ui.set_callback(lua_menu.checkboxes.console_filter, console_filter)
---@end













---@callbacks_start
client.set_event_callback("pre_render", function()
    animfix_setup()
    if ui.is_menu_open() then
        on_load()
        visuals_visibility()
        aa_visibility()
        config_visibillity()
    end
end)

client.set_event_callback("setup_command", function(cmd)
    on_setup_command(cmd)
    update_command_number(cmd)
    freestanding()
    safehead(cmd)
    manual_yaw()
    aa_on_use(cmd)
    edge_yaw()
    anti_stab()
    hideshots_fix()
    fake_lag()
    warmup()
    handle_recharge()
end)

client.set_event_callback("paint", function()
    render_manual()
    rev_helper()
    clantag()
    render_damage_indicator()
    render_watermark()
end)

client.set_event_callback("run_command", function(cmd)
    update_pred_value(cmd)
end)

client.set_event_callback("predict_command", function(cmd)
    defensiveCheck(cmd)
end)

client.set_event_callback("shutdown", function()
    on_unload()

    cvar.con_filter_enable:set_int(0)
    cvar.con_filter_text:set_string("")
end)

client.set_event_callback('level_init', function()
    timer = globals.tickcount()
end)
---@callbacks_end