-- cracked by lordhakkai / ty 4raws for exploiting the discord by abuse

local ffi = require 'ffi'
local vector = require 'vector'
local c_entity = require 'gamesense/entity'
--local http = require 'gamesense/http'
local base64 = require 'gamesense/base64'
local clipboard = require 'gamesense/clipboard'
local steamworks = require 'gamesense/steamworks'
local easing = require 'gamesense/easing'
local trace = require("gamesense/trace")
local entitylib = require 'gamesense/entity'
local images = require("gamesense/images")
local json = require("json")
local weapons = require 'gamesense/csgo_weapons'

local client_set_event_callback, client_unset_event_callback = client.set_event_callback, client.unset_event_callback
local entity_get_local_player, entity_get_player_weapon, entity_get_prop = entity.get_local_player, entity.get_player_weapon, entity.get_prop
local ui_get, ui_set, ui_set_callback, ui_set_visible, ui_reference = ui.get, ui.set, ui.set_callback, ui.set_visible, ui.reference

local utility do
    utility = {}
    
    function utility.clamp(value, min, max)
        if value < min then return min
        elseif value > max then return max
        else return value end
    end
    
    function utility.contains(source, target)
        for _, name in pairs(ui.get(source)) do
            if name == target then return true end
        end
        return false
    end
    
    function utility.lerp(start, finish, t)
        return (finish - start) * t + start
    end
    
    function utility.smooth_lerp(current, target, speed)
        speed = speed or 0.005
        speed = utility.clamp(globals.frametime() * speed * 175, 0.01, 1)
        local interpolated = utility.lerp(current, target, speed)
        
        if target == 0 and interpolated < 0.01 and interpolated > -0.01 then
            interpolated = 0
        elseif target == 1 and interpolated < 1.01 and interpolated > 0.99 then
            interpolated = 1
        end
        
        return interpolated
    end
    
    function utility.rgba_to_hex(r, g, b, a)
        return bit.tohex((math.floor(r + 0.5) * 16777216) + (math.floor(g + 0.5) * 65536) + 
                        (math.floor(b + 0.5) * 256) + (math.floor(a + 0.5)))
    end
    function utility.is_defensive(index)
        cheked_ticks = math.max(entity.get_prop(index, 'm_nTickBase'), cheked_ticks or 0)
        return math.abs(entity.get_prop(index, 'm_nTickBase') - cheked_ticks) > 2 and math.abs(entity.get_prop(index, 'm_nTickBase') - cheked_ticks) < 14
    end
    function utility.random_int(min, max)
        if min > max then
            min, max = max, min
        end

        return client.random_int(min, max)
    end
    function utility.random_float(min, max)
        if min > max then
            min, max = max, min
        end

        return client.random_float(min, max)
    end
    function utility.jitter_value()
        local currentTime = globals.tickcount() / 10
        local jitterFrequency = 7  
        local jitterFactor = 0.5 + 0.5 * math.sin(currentTime * jitterFrequency)
        return jitterFactor * 100
    end
    function utility.vec_3( _x, _y, _z ) 
        return { x = _x or 0, y = _y or 0, z = _z or 0 } 
    end
    function utility.get_vector_prop(idx, prop, array)
        local v1, v2, v3 = entity.get_prop(idx, prop, array)
        return {x = v1, y = v2, z = v3}
    end
    function utility.get_address(idx)
        return get_client_entity_fn(entity_list_ptr, idx)
    end
    function utility.get_animstate(idx)
        local addr = utility.get_address(idx)
        if not addr then return nil end
        return ffi.cast("c_animstate*", ffi.cast("uintptr_t", addr) + 0x9960)
    end
    function utility.get_animlayer(idx)
        local addr = utility.get_address(idx)
        if not addr then return nil end
        return ffi.cast("C_AnimationLayer**", ffi.cast("uintptr_t", addr) + 0x9960)[0]
    end
    function utility.find_layer(ent, act)
        local layers = utility.get_animlayer(ent)
        if not layers then return -1 end

        for i = 0, 13 do
            local layer = layers[i]
            if layer.m_activity == act then
                return i
            end
        end
        return -1
    end
    function utility.normalize_angle(angle)
        if angle == nil then return 0 end
        while angle > 180 do angle = angle - 360 end
        while angle < -180 do angle = angle + 360 end
        return angle
    end
    function utility.vec_length2d(vec)
        return math.sqrt(vec.x * vec.x + vec.y * vec.y)
    end

    function utility.angle_diff(dest, src)
        local delta = (dest - src + 540) % 360 - 180
        return delta
    end

    function utility.approach_angle(target, value, speed)
        target = utility.normalize_angle(target)
        value = utility.normalize_angle(value)

        delta = utility.angle_diff(target, value)
        speed = math.abs(speed)

        if delta > speed then
            value = value + speed
        elseif delta < -speed then
            value = value - speed
        else
            value = target
        end

        return utility.normalize_angle(value)
    end
    function utility.ticks_to_time()
        return globals.tickinterval( ) * 16
    end 
    function utility.player_will_peek()
        local enemies = entity.get_players( true )
        if not enemies then
            return false
        end
        
        local eye_position = utility.vec_3( client.eye_position( ) )
        local velocity_prop_local = utility.vec_3( entity.get_prop( entity.get_local_player( ), "m_vecVelocity" ) )
        local predicted_eye_position = utility.vec_3( eye_position.x + velocity_prop_local.x * utility.ticks_to_time( predicted ), eye_position.y + velocity_prop_local.y * utility.ticks_to_time( predicted ), eye_position.z + velocity_prop_local.z * utility.ticks_to_time( predicted ) )

        for i = 1, #enemies do
            local player = enemies[ i ]
            
            local velocity_prop = utility.vec_3( entity.get_prop( player, "m_vecVelocity" ) )
            
            local origin = utility.vec_3( entity.get_prop( player, "m_vecOrigin" ) )
            local predicted_origin = utility.vec_3( origin.x + velocity_prop.x * utility.ticks_to_time(), origin.y + velocity_prop.y * utility.ticks_to_time(), origin.z + velocity_prop.z * utility.ticks_to_time() )
            
            entity.get_prop( player, "m_vecOrigin", predicted_origin )
            
            local head_origin = utility.vec_3( entity.hitbox_position( player, 0 ) )
            local predicted_head_origin = utility.vec_3( head_origin.x + velocity_prop.x * utility.ticks_to_time(), head_origin.y + velocity_prop.y * utility.ticks_to_time(), head_origin.z + velocity_prop.z * utility.ticks_to_time() )
            local trace_entity, damage = client.trace_bullet( entity.get_local_player( ), predicted_eye_position.x, predicted_eye_position.y, predicted_eye_position.z, predicted_head_origin.x, predicted_head_origin.y, predicted_head_origin.z )
            entity.get_prop( player, "m_vecOrigin", origin )
            if damage > 0 then
                return true
            end
        end
        
        return false
    end
end

local script_info do
    script_info = {}

    local function d(t)
        local s = ""
        for i = 1, #t do
            s = s .. string.char(t[i] - 1)
        end
        return s
    end

    script_info.username = _USER_NAME or d({105, 98, 108, 108, 98, 106})
    script_info.name = _SCRIPT_NAME or d({
        84, 105, 106, 117, 111, 102, 123, 123, 98, 33,
        69, 102, 119
    })
end

local ilocalize do
    ilocalize = { }

    local ConvertAnsiToUnicode = vtable_bind(
        'localize.dll', 'Localize_001', 15, 'int(__thiscall*)(void*, const char *ansi, wchar_t *unicode, int buffer_size)'
    )

    function ilocalize.ansi_to_unicode(ansi, unicode, buffer_size)
        return ConvertAnsiToUnicode(ansi, unicode, buffer_size)
    end
end
local surface do
    surface = { }

    local wide = ffi.new 'int[1]'
    local tall = ffi.new 'int[1]'

    local SetColor = vtable_bind('vguimatsurface.dll', 'VGUI_Surface031', 15, 'void(__thiscall*)(void* thisptr, int r, int g, int b, int a)')

    local SetTextFont = vtable_bind('vguimatsurface.dll', 'VGUI_Surface031', 23, 'void(__thiscall*)(void*, unsigned int font_id)')
    local SetTextColor = vtable_bind('vguimatsurface.dll', 'VGUI_Surface031', 25, 'void(__thiscall*)(void*, int r, int g, int b, int a)')
    local SetTextPos = vtable_bind('vguimatsurface.dll', 'VGUI_Surface031', 26, 'void(__thiscall*)(void*, int x, int y)')
    local DrawPrintText = vtable_bind('vguimatsurface.dll', 'VGUI_Surface031', 28, 'void(__thiscall*)(void*, const wchar_t *text, int maxlen, int draw_type)')

    local GetFontTall = vtable_bind('vguimatsurface.dll', 'VGUI_Surface031', 74, 'int(__thiscall*)(void*, unsigned int font)')
    local GetTextSize = vtable_bind('vguimatsurface.dll', 'VGUI_Surface031', 79, 'void(__thiscall*)(void*, unsigned int font, const wchar_t *text, int &wide, int &tall)')

    local DrawFilledRectFade = vtable_bind('vguimatsurface.dll', 'VGUI_Surface031', 123, 'void(__thiscall*)(void*, int x0, int y0, int x1, int y1, unsigned int alpha0, unsigned int alpha1, bool bHorizontal)')

    function surface.text_tall(font)
        return GetFontTall(font)
    end

    function surface.measure_text(font, text)
        local buffer = ffi.new 'wchar_t[2048]'

        ilocalize.ansi_to_unicode(text, buffer, 2048)
        GetTextSize(font, buffer, wide, tall)

        return wide[0], tall[0]
    end

    function surface.text(font, x, y, r, g, b, a, text)
        local len = #text

        if len <= 0 then
            return
        end

        local buffer = ffi.new 'wchar_t[2048]'

        ilocalize.ansi_to_unicode(text, buffer, 2048)

        SetTextFont(font)

        SetTextPos(x, y)
        SetTextColor(r, g, b, a)

        DrawPrintText(buffer, len, 0)
    end

    function surface.fade(x, y, w, h, r0, g0, b0, a0, r1, g1, b1, a1, horizontal)
        SetColor(r0, g0, b0, a0)
        DrawFilledRectFade(x, y, x + w, y + h, 255, 0, horizontal)

        SetColor(r1, g1, b1, a1)
        DrawFilledRectFade(x, y, x + w, y + h, 0, 255, horizontal)
    end
end

local exploit do
    exploit = { }

    local BREAK_LAG_COMPENSATION_DISTANCE_SQR = 32 * 32

    local max_tickbase = 0
    local run_command_number = 0

    local data = {
        old_origin = vector(),
        old_simtime = 0.0,

        shift = false,
        breaking_lc = false,

        defensive = {
            force = false,
            left = 0,
            max = 0,
        },

        lagcompensation = {
            distance = 0.0,
            teleport = false
        }
    }

    local function update_tickbase(me)
        data.shift = globals.tickcount() > entity.get_prop(me, 'm_nTickBase')
    end

    local function update_teleport(old_origin, new_origin)
        local delta = new_origin - old_origin
        local distance = delta:lengthsqr()

        local is_teleport = distance > BREAK_LAG_COMPENSATION_DISTANCE_SQR

        data.breaking_lc = is_teleport

        data.lagcompensation.distance = distance
        data.lagcompensation.teleport = is_teleport
    end

    local function update_lagcompensation(me)
        local old_origin = data.old_origin
        local old_simtime = data.old_simtime

        local origin = vector(entity.get_origin(me))
        local simtime = toticks(entity.get_prop(me, 'm_flSimulationTime'))

        if old_simtime ~= nil then
            local delta = simtime - old_simtime

            if delta < 0 or delta > 0 and delta <= 64 then
                update_teleport(old_origin, origin)
            end
        end

        data.old_origin = origin
        data.old_simtime = simtime
    end

    local function update_defensive_tick(me)
        local tickbase = entity.get_prop(me, 'm_nTickBase')

        if math.abs(tickbase - max_tickbase) > 64 then
            max_tickbase = 0
        end

        local defensive_ticks_left = 0

        if tickbase > max_tickbase then
            max_tickbase = tickbase
        elseif max_tickbase > tickbase then
            defensive_ticks_left = math.min(14, math.max(0, max_tickbase - tickbase - 1))
        end

        if defensive_ticks_left > 0 then
            data.breaking_lc = true
            data.defensive.left = defensive_ticks_left

            if data.defensive.max == 0 then
                data.defensive.max = defensive_ticks_left
            end
        else
            data.defensive.left = 0
            data.defensive.max = 0
        end
    end

    function exploit.get()
        return data
    end

    local function on_predict_command(cmd)
        local me = entity.get_local_player()

        if me == nil then
            return
        end

        if cmd.command_number == run_command_number then
            update_defensive_tick(me)
            run_command_number = nil
        end
    end

    local function on_setup_command(cmd)

    end

    local function on_run_command(e)
        local me = entity.get_local_player()

        if me == nil then
            return
        end

        update_tickbase(me)

        run_command_number = e.command_number
    end

    local function on_net_update_start()
        local me = entity.get_local_player()

        if me == nil then
            return
        end

        update_lagcompensation(me)
    end

    client.set_event_callback('predict_command', on_predict_command)
    client.set_event_callback('setup_command', on_setup_command)
    client.set_event_callback('run_command', on_run_command)

    client.set_event_callback('net_update_start', on_net_update_start)
end

local reference
do
    reference = {
        double_tap = {ui.reference('RAGE', 'Aimbot', 'Double tap')},
        duck_peek_assist = ui.reference('RAGE', 'Other', 'Duck peek assist'),
        pitch = {ui.reference('AA', 'Anti-aimbot angles', 'Pitch')},
        yaw_base = ui.reference('AA', 'Anti-aimbot angles', 'Yaw base'),
        yaw = {ui.reference('AA', 'Anti-aimbot angles', 'Yaw')},
        yaw_jitter = {ui.reference('AA', 'Anti-aimbot angles', 'Yaw jitter')},
        body_yaw = {ui.reference('AA', 'Anti-aimbot angles', 'Body yaw')},
        freestanding_body_yaw = ui.reference('AA', 'Anti-aimbot angles', 'Freestanding body yaw'),
        edge_yaw = ui.reference('AA', 'Anti-aimbot angles', 'Edge yaw'),
        freestanding = {ui.reference('AA', 'Anti-aimbot angles', 'Freestanding')},
        roll = ui.reference('AA', 'Anti-aimbot angles', 'Roll'),
        on_shot_anti_aim = {ui.reference('AA', 'Other', 'On shot anti-aim')},
        slow_motion = {ui.reference('AA', 'Other', 'Slow motion')},
        fakelag = {ui.reference('AA', 'Fake lag', 'Enabled')},
        fakelag_amount = ui.reference('AA', 'Fake lag', 'Amount'),
        fakelag_variance = ui.reference('AA', 'Fake lag', 'Variance'),
        fakelag_limit = ui.reference('AA', 'Fake lag', 'Limit'),
        leg_movement = ui.reference('AA', 'Other', 'Leg movement'),
        fake_peek = {ui.reference('AA', 'Other', 'Fake peek')},
        min_damage = ui.reference('RAGE', 'Aimbot', 'Minimum damage'),
        min_damage_override = {ui.reference('RAGE', 'Aimbot', 'Minimum damage override')},
        force_safe_point = ui.reference('RAGE', 'Aimbot', 'Force safe point'),
        force_body_aim = ui.reference('RAGE', 'Aimbot', 'Force body aim'),
        menu_color =  { ui.reference('MISC', 'Settings', 'Menu color') },
        scope_overlay = ui.reference('VISUALS', 'Effects', 'Remove scope overlay'),
    }
end


local ui_settings do
    ui_settings = {}
    local r, g, b, a = ui.get(reference.menu_color[1])
    local hex_color = utility.rgba_to_hex(r, g, b, a)
    local width, height = client.screen_size()

    ui_settings.current_tab = ui.new_combobox('AA', 'Anti-aimbot angles', '\a' .. hex_color .. ' \aFFFFFFFF Tabs', {'Home', 'Anti-Aim', 'Tennezza'})
    ui_settings.text9 = ui.new_label('AA', 'Anti-aimbot angles', '\a' .. hex_color .. '━━━━━━━━━━━━━━━━━━━━━━━━━━━')


    ui_settings.fake_lag_tab_antiaim = ui.new_combobox('AA', 'Fake lag', '\a' .. hex_color .. ' \aFFFFFFFF AA Tabs', {'Fake Lags', 'Keybinds', 'Utilities'})
    
    --fakelag
    ui_settings.fakelag_switch = ui.new_checkbox('AA', 'Fake lag', '\aFFFFFFFFFake lag \a' .. hex_color .. 'Enabled')
    ui_settings.fakelag_amount_combobox = ui.new_combobox('AA', 'Fake lag', '\aFFFFFFFFAmount', 'Dynamic', 'Maximum', 'Fluctuate')
    ui_settings.fakelag_variance_slider = ui.new_slider('AA', 'Fake lag', '\aFFFFFFFFVariance', 0, 100, 0, true, '%')
    ui_settings.fakelag_limit_slider = ui.new_slider('AA', 'Fake lag', '\aFFFFFFFFLimit', 1, 15, 0, true)

    --keybind
    ui_settings.warmup_disabler = ui.new_checkbox('AA', 'Fake lag', '\a' .. hex_color .. ' ⚡︎ \aFFFFFFFFWarmup disabler')
    ui_settings.avoid_backstab = ui.new_checkbox('AA', 'Fake lag', '\a' .. hex_color .. ' ⚡︎ \aFFFFFFFFAvoid backstab')
    ui_settings.safe_head_in_air = ui.new_checkbox('AA', 'Fake lag', '\a' .. hex_color .. ' ⚡︎ \aFFFFFFFFSafe head in air')
    ui_settings.manual_forward = ui.new_hotkey('AA', 'Fake lag', '\aFFFFFFFFManual \a' .. hex_color .. '⚡\aFFFFFFFF forward \a' .. hex_color .. ' ↑')
    ui_settings.manual_right = ui.new_hotkey('AA', 'Fake lag', '\aFFFFFFFFManual \a' .. hex_color .. '⚡\aFFFFFFFF right \a' .. hex_color .. ' →')
    ui_settings.manual_left = ui.new_hotkey('AA', 'Fake lag', '\aFFFFFFFFManual \a' .. hex_color .. '⚡ \aFFFFFFFFleft \a' .. hex_color .. ' ←')
    ui_settings.manual_reset = ui.new_hotkey('AA', 'Fake lag', '\aFFFFFFFFManual \a' .. hex_color .. '⚡ \aFFFFFFFFreset \a' .. hex_color .. ' ♻️')
    ui_settings.manual_left_checkbox = ui.new_checkbox('AA', 'Fake lag', ' ')
    ui_settings.manual_right_checkbox = ui.new_checkbox('AA', 'Fake lag', ' ')
    ui_settings.manual_forward_checkbox = ui.new_checkbox('AA', 'Fake lag', ' ')
    ui.set_visible(ui_settings.manual_left_checkbox, false)
    ui.set_visible(ui_settings.manual_right_checkbox, false)
    ui.set_visible(ui_settings.manual_forward_checkbox, false)
    ui_settings.edge_yaw = ui.new_hotkey('AA', 'Fake lag', '\aFFFFFFFFEdge \a' .. hex_color .. '⚡\aFFFFFFFF yaw')
    ui_settings.freestanding = ui.new_hotkey('AA', 'Fake lag', '\aFFFFFFFFFreestanding \a' .. hex_color .. '⚡\aFFFFFFFF yaw')
    ui_settings.freestanding_conditions = ui.new_multiselect('AA', 'Fake lag', '\nFreestanding', 'Standing', 'Moving', 'Slow motion', 'Crouching', 'In air')
    ui_settings.tweaks = ui.new_multiselect('AA', 'Fake lag', '\nTweaks', 'Off jitter while freestanding', 'Off jitter on manual')

    --utilities
    ui_settings.resolver = ui.new_checkbox('AA', 'Fake lag', '\aFFFFFFFFTennezza \a' .. hex_color .. 'Body yaw fix')
    ui_settings.dt_fix = ui.new_checkbox('AA', 'Fake lag', '\aFFFFFFFFTennezza \a' .. hex_color .. 'Lag compensation \aFFFFFFFFFix')
    ui_settings.dt_fix_indicator = ui.new_checkbox('AA', 'Fake lag', '\aFFFFFFFFTennezza \a' .. hex_color .. 'Lag compensation \aFFFFFFFFFix Indicator')
    ui_settings.offdtonhs = ui.new_checkbox('AA', 'Fake lag', '\aFFFFFFFFOff \a' .. hex_color .. ' Double tap \aFFFFFFFFon \a' .. hex_color .. 'Hide shots')
    
    ui_settings.unsafe_recharge_ref = ui.new_checkbox('AA', 'Fake lag', '\aFFFFFFFFUnsafe recharge')


    ui_settings.other_tab_antiaim = ui.new_combobox('AA', 'Other', '\a' .. hex_color .. ' \aFFFFFFFF Misc Tabs', {'Anti BruteForce', 'Defensive Builder', 'Gamesense'})



    -- Home
    ui_settings.text2 = ui.new_label('AA', 'Fake lag', '\aFFFFFFFF⚡ \a' .. hex_color .. ' S H I T N E Z Z A \aFFFFFFFF~ \a' .. hex_color .. 'Stable', 'string')
    ui_settings.text4 = ui.new_label('AA', 'Fake lag', '\aFFFFFFFF⚡ \a' .. hex_color .. 'Your Username: \aFFFFFFFF' .. script_info.username, 'string')
    ui_settings.text12 = ui.new_label('AA', 'Fake lag', '\a' .. hex_color .. '━━━━━━━━━━━━━━━━━━━━━━━━━━━')
    ui_settings.coder = ui.new_label('AA', 'Fake lag', '\aFFFFFFFF⚡ \a' .. hex_color .. 'Coder: \aFFFFFFFFСын шлюхи', 'string')
    ui_settings.owner = ui.new_label('AA', 'Fake lag', '\aFFFFFFFF⚡ \a' .. hex_color .. 'Owner: \aFFFFFFFFСын шлюхи 2', 'string')

    ui_settings.update_log = ui.new_label('AA', 'Other', '\aFFFFFFFF⚡ \a' .. hex_color .. 'Update \aFFFFFFFFLog', 'string')
    ui_settings.update_log_poloska = ui.new_label('AA', 'Other', '\a' .. hex_color .. '━━━━━━━━━━━━━━━━━━━━━━━━━━━')

    ui_settings.update_log_1 = ui.new_label('AA', 'Other', '\aFFFFFFFFNew menu visual when loading', 'string')
    ui_settings.update_log_2 = ui.new_label('AA', 'Other', '\aFFFFFFFFUpdate resolver', 'string')
    ui_settings.update_log_3 = ui.new_label('AA', 'Other', '\aFFFFFFFFFixed and new style "Modern" hitlog', 'string')
    ui_settings.update_log_4 = ui.new_label('AA', 'Other', '\aFFFFFFFFFixed Defensive Anti-aim', 'string')

    

    
    
    -- Anti-Aim
    
    local anti_aim_different = {'', ' ', '  ', '   ', '    ', '     ', '      ', '       ', '        ', '         ', '          '}
    local anti_aim_states = {'Global', 'Standing', 'Moving', 'Slow motion', 'Crouching', 'Crouching & moving', 'In air', 'In air & crouching', 'On use', 'On peek'}
    ui_settings.anti_aim_state = ui.new_combobox('AA', 'Anti-aimbot angles', '\a' .. hex_color .. '⚡︎ \aFFFFFFFFAnti-aimbot state', anti_aim_states)

    ui_settings.anti_aim_settings = {}
    ui_settings.anti_aim_settings = {}
    for i = 1, #anti_aim_states do
        ui_settings.anti_aim_settings[i] = {
            override_state = ui.new_checkbox('AA', 'Anti-aimbot angles', '\a' .. hex_color .. '⚡︎ \aFFFFFFFFOverride ' .. string.lower(anti_aim_states[i])),
            yaw_base = ui.new_combobox('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Yaw \aFFFFFFFF ⚡︎ base' .. anti_aim_different[i], 'Local view', 'At targets'),
            yaw_left = ui.new_slider('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Yaw \aFFFFFFFF left degree' .. anti_aim_different[i], -180, 180, 0, true, '°'),
            yaw_right = ui.new_slider('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Yaw \aFFFFFFFF right degree' .. anti_aim_different[i], -180, 180, 0, true, '°'),
            yaw_random_checkbox = ui.new_checkbox('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Yaw \aFFFFFFFF ⚡︎ Randomization \a' .. hex_color .. 'Enabled' .. anti_aim_different[i]),
            yaw_left_random = ui.new_slider('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Yaw \aFFFFFFFF ⚡︎ left randomization' .. anti_aim_different[i], 0, 180, 0, true, '°', 1, {[0] = 'Off'}),
            yaw_right_random = ui.new_slider('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Yaw \aFFFFFFFF ⚡︎ right randomization' .. anti_aim_different[i], 0, 180, 0, true, '°', 1, {[0] = 'Off'}),
            yaw_jitter_type = ui.new_combobox('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Yaw\aFFFFFFFF ⚡︎ jitter' .. anti_aim_different[i], 'Off', 'Offset', 'Skitter', 'Center', '3-Ways', '5-Ways'),
            yaw_jitter_offset = ui.new_slider('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Yaw\aFFFFFFFF jitter offset' .. anti_aim_different[i], -180, 180, 0, true, '°'),
            yaw_way1 = ui.new_slider('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Way ⚡︎ \aFFFFFFFF1 Offset' .. anti_aim_different[i], -180, 180, 0, true, '°'),
            yaw_way2 = ui.new_slider('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Way ⚡︎ \aFFFFFFFF2 Offset' .. anti_aim_different[i], -180, 180, 0, true, '°'),
            yaw_way3 = ui.new_slider('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Way ⚡︎ \aFFFFFFFF3 Offset' .. anti_aim_different[i], -180, 180, 0, true, '°'),
            yaw_way4 = ui.new_slider('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Way ⚡︎ \aFFFFFFFF4 Offset' .. anti_aim_different[i], -180, 180, 0, true, '°'),
            yaw_way5 = ui.new_slider('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Way ⚡︎ \aFFFFFFFF5 Offset' .. anti_aim_different[i], -180, 180, 0, true, '°'),
            yaw_random = ui.new_slider('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Yaw\aFFFFFFFF Jitter randomization' .. anti_aim_different[i], 0, 180, 0, true, '°', 1, {[0] = 'Off'}),
            text = ui.new_label('AA', 'Anti-aimbot angles', '\a' .. hex_color .. '━━━━━━━━━━━━━━━━━━━━━━━━━━━', 'string'),
            body_yaw_type = ui.new_combobox('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Body\aFFFFFFFF ⚡︎ yaw' .. anti_aim_different[i], 'Off', 'Opposite', 'Jitter', 'Static', 'Sway'),
            body_yaw_value = ui.new_slider('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Body\aFFFFFFFF Yaw degree' .. anti_aim_different[i], -180, 180, 0, true, '°'),
            yaw_delay = ui.new_slider('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Body \aFFFFFFFF Jitter delay' .. anti_aim_different[i], 1, 16, 1, true, 't', 1, {[1] = 'Off'}),
            body_checkbox = ui.new_checkbox('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Body \aFFFFFFFF⚡︎ Randomization enabled' .. anti_aim_different[i]),
            yaw_delay_random = ui.new_slider('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Body \aFFFFFFFFJitter delay \a' .. hex_color .. 'Randomization' .. anti_aim_different[i], 0, 16, 0, true, 't', 1, {[0] = 'Off'}),
            body_yaw_value_random = ui.new_slider('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Body \aFFFFFFFFYaw degree \a' .. hex_color .. 'Randomization' .. anti_aim_different[i], 0, 180, 0, true, '°', 1, {[0] = 'Off'}),
            freestanding_body_yaw = ui.new_checkbox('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Body\aFFFFFFFF freestanding yaw' .. anti_aim_different[i]),
            force_defensive = ui.new_checkbox('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Force \aFFFFFFFFdefensive' .. anti_aim_different[i]),
            options = ui.new_multiselect('AA', 'Anti-aimbot angles', '\aFFFFFFFFOptions \a' .. hex_color .. 'AA', {'Avoid Overlap', 'Smart hide real yaw'}),
            smart_hide_strength = ui.new_slider('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Smart hide \aFFFFFFFFstrength' .. anti_aim_different[i], 0, 100, 100, true, '%'),
            override_defensive = ui.new_checkbox('AA', 'Other', '\a' .. hex_color .. 'Defensive \aFFFFFFFFAA' .. anti_aim_different[i]),
            defensive_jitter_type = ui.new_combobox('AA', 'Other', '\a' .. hex_color .. 'Defensive \aFFFFFFFFYaw \a' .. hex_color .. '⚡︎ \aFFFFFFFFjitter' .. anti_aim_different[i], 'Off', 'Static' ,'Offset', 'Skitter', 'Center', '3-Ways', 'Random', 'Spin'),
            defensive_jitter_offset = ui.new_slider('AA', 'Other', '\a' .. hex_color .. 'Defensive \aFFFFFFFFYaw jitter \a' .. hex_color .. 'offset' .. anti_aim_different[i], -180, 180, 0, true, '°'),
            defensive_yaw_random = ui.new_slider('AA', 'Other', '\a' .. hex_color .. 'Defensive \aFFFFFFFFYaw Jitter \a' .. hex_color .. 'randomization' .. anti_aim_different[i], 0, 180, 0, true, '°', 1, {[0] = 'Off'}),
            defensive_jitter_delay = ui.new_slider('AA', 'Other', '\a' .. hex_color .. 'Defensive \aFFFFFFFFYaw Jitter \a' .. hex_color .. 'delay' .. anti_aim_different[i], 1, 16, 1, true, 't', 1, {[1] = 'Off'}),
            defensive_jitter_delay_random = ui.new_slider('AA', 'Other', '\a' .. hex_color .. 'Defensive \aFFFFFFFFYaw Jitter delay \a' .. hex_color .. 'Randomization' .. anti_aim_different[i], 0, 16, 0, true, 't', 1, {[0] = 'Off'}),
            defensive_pitch_type = ui.new_combobox('AA', 'Other', '\a' .. hex_color .. 'Defensive \aFFFFFFFF⚡︎ pitch \a' .. hex_color .. 'Type' .. anti_aim_different[i], 'Off', 'Custom', 'Jitter', 'Sway', 'Random'),
            defensive_pitch_offset = ui.new_slider('AA', 'Other', '\a' .. hex_color .. 'Defensive \aFFFFFFFFpitch \a' .. hex_color .. 'offset' .. anti_aim_different[i], -89, 89, 0, true, '°'),
            defensive_pitch_offset_speed = ui.new_slider('AA', 'Other', '\a' .. hex_color .. 'Defensive \aFFFFFFFFpitch offset \a' .. hex_color .. 'Speed' .. anti_aim_different[i], 0, 100, 0, true),
            defensive_pitch_jitter_1 = ui.new_slider('AA', 'Other', '\a' .. hex_color .. 'Defensive \aFFFFFFFFpitch \a' .. hex_color .. '1' .. anti_aim_different[i], -89, 89, 0, true, '°'),
            defensive_pitch_jitter_2 = ui.new_slider('AA', 'Other', '\a' .. hex_color .. 'Defensive \aFFFFFFFFpitch \a' .. hex_color .. '2' .. anti_aim_different[i], -89, 89, 0, true, '°'),
            defensive_pitch_random = ui.new_slider('AA', 'Other', '\a' .. hex_color .. 'Defensive \aFFFFFFFFpitch \a' .. hex_color .. 'Randomization' .. anti_aim_different[i], -89, 89, 0, true, '°'),
            defensive_pitch_delay = ui.new_slider('AA', 'Other', '\a' .. hex_color .. 'Defensive \aFFFFFFFFpitch Jitter \a' .. hex_color .. 'delay' .. anti_aim_different[i], 1, 16, 1, true, 't', 1, {[1] = 'Off'}),
            defensive_pitch_delay_random = ui.new_slider('AA', 'Other', '\a' .. hex_color .. 'Defensive \aFFFFFFFFpitch Jitter \a' .. hex_color .. 'delay \aFFFFFFFFRandomization' .. anti_aim_different[i], 1, 16, 1, true, 't', 1, {[1] = 'Off'}),
            anti_brute_force_enabled = ui.new_checkbox('AA', 'Other', '\aFFFFFFFF Anti BruteForce \a' .. hex_color .. 'enabled'),
            anti_brute_force_mode = ui.new_combobox('AA', 'Other', '\aFFFFFFFFAnti BruteForce \a' .. hex_color .. 'Mode', {'Smart', 'Aggressive', 'Passive', 'Adaptive'}),
            anti_brute_force_strength = ui.new_slider('AA', 'Other', '\aFFFFFFFFAnti BruteForce \a' .. hex_color .. 'Strength', 1, 100, 50, true, '%'),
            anti_brute_force_reset_delay = ui.new_slider('AA', 'Other', '\aFFFFFFFFAnti BruteForce \a' .. hex_color .. 'Reset delay', 1, 64, 1, true, 'ticks'),
            anti_brute_force_miss_threshold = ui.new_slider('AA', 'Other', '\aFFFFFFFFAnti BruteForce \a' .. hex_color .. 'Miss threshold', 1, 10, 3, true, 'misses'),
            anti_brute_force_jitter_strength = ui.new_slider('AA', 'Other', '\aFFFFFFFFAnti BruteForce \a' .. hex_color .. 'Jitter strength', 0, 100, 30, true, '%'),
            anti_brute_force_yaw_range = ui.new_slider('AA', 'Other', '\aFFFFFFFFAnti BruteForce \a' .. hex_color .. 'Yaw range', 10, 180, 60, true, '°'),
        }
    end

    
    -- Keybinds
    ui_settings.other_tab_misc = ui.new_combobox('AA', 'Fake lag', '\a' .. hex_color .. ' \aFFFFFFFF V & M Tabs', {'Other', 'Visuals'})
    ui_settings.text10 = ui.new_label('AA', 'Fake lag', '\a' .. hex_color .. '━━━━━━━━━━━━━━━━━━━━━━━━━━━')
    
    --visuals
    
    ui_settings.console_filter = ui.new_checkbox('AA', 'Anti-aimbot angles', '\aFFFFFFFFConsole \a' .. hex_color .. 'Filter')
    ui_settings.minimumdamage = ui.new_checkbox('AA', 'Anti-aimbot angles', '\aFFFFFFFFDamage \a' .. hex_color .. 'indicator')
    ui_settings.minimumdamage_font = ui.new_combobox('AA', 'Anti-aimbot angles', '\aFFFFFFFFDamage \a' .. hex_color .. 'indicator \aFFFFFFFFFont', {'Bold', 'Small', 'Default'})
    ui_settings.hitmarker = ui.new_checkbox('AA', 'Anti-aimbot angles', '\aFFFFFFFF3D \a' .. hex_color .. 'Hit \aFFFFFFFFMarker')
    ui_settings.aspectratio = ui.new_slider('AA', 'Anti-aimbot angles', '\aFFFFFFFFAspect \a' .. hex_color .. 'Ratio', 0, 200, 0, true, nil, 0.01, {[0] = "Off"})
    ui_settings.thirdperson = ui.new_slider('AA', 'Anti-aimbot angles', '\aFFFFFFFFThird \a' .. hex_color .. 'Person', 30, 200, 50)
    ui_settings.userwatermark = ui.new_checkbox('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'User \aFFFFFFFFWatermark')
    ui_settings.pos1 = ui.new_slider('AA', 'Anti-aimbot angles', '\aFFFFFFFFPos \a'.. hex_color.. 'X', width-width, width, width/2, true)
    ui_settings.pos2 = ui.new_slider('AA', 'Anti-aimbot angles', '\aFFFFFFFFPos \a'.. hex_color.. 'Y', height-height, height, height/2, true)
    ui_settings.watermarkpos = ui.new_combobox('AA', 'Anti-aimbot angles', '\aFFFFFFFF Custom \a'.. hex_color.. 'Watermark', {'Off', 'Right', 'Left', 'Top', 'Bottom'})
    ui_settings.watermark_name = ui.new_textbox('AA', 'Anti-aimbot angles', 'Watermark name')
    ui_settings.watermark_color = ui.new_color_picker('AA', 'Anti-aimbot angles', '\n watermark_color_picker', 0, 0, 0, 255)
    ui_settings.watermarkpos_font = ui.new_combobox('AA', 'Anti-aimbot angles', '\aFFFFFFFF Custom \a'.. hex_color.. 'Watermark \aFFFFFFFFFont', {'Bold', 'Small', 'Default'})
    ui_settings.indicators = ui.new_checkbox('AA', 'Anti-aimbot angles', '\aFFFFFFFFIndicators under \a' .. hex_color .. 'Crosshair')
    ui_settings.indicators_color_picker = ui.new_color_picker('AA', 'Anti-aimbot angles', '\n indicators_color_picker', 0, 0, 0, 255)
    ui_settings.indicators_exclude = ui.new_multiselect('AA', 'Anti-aimbot angles', '\aFFFFFFFFIndicators \a' .. hex_color .. 'Render', {'Double Tap', 'Hide Shots', 'Stances', 'Freestanding', 'Body Aim'})
    ui.set(ui_settings.watermark_name, 'T E N N E Z Z A')
    ui_settings.zoom_animation = ui.new_checkbox('AA', 'Anti-aimbot angles', '\aFFFFFFFFAnimate zoom \a'.. hex_color.. 'FOV')
    ui_settings.camera_animation = ui.new_multiselect('AA', 'Anti-aimbot angles', 'Animate camera', {"X", "Y", "Z", "Pitch", "Yaw"})
    ui_settings.anim_breakerx = ui.new_checkbox('AA', 'Fake lag', '\aFFFFFFFFSkeet \a'.. hex_color.. 'leg \aFFFFFFFFfucker')
    ui_settings.m_elements = ui.new_multiselect('AA', 'Fake lag', "\aFFFFFFFFAnim Breaker", {"earthquake", "airbreak", "kangaroo", "zero pitch on land", 'static legs in air', 'Pacan4ik'})

    ui_settings.staticlegweight = ui.new_slider('AA', 'Fake lag', "Static legs weight", 0, 100, 100, true)
    ui_settings.legoffset1 = ui.new_slider('AA', 'Fake lag', "Leg offset 1", 0, 100, 100, true)
    ui_settings.legoffset2 = ui.new_slider('AA', 'Fake lag', "Leg offset 2", 0, 100, 100, true)

    ui_settings.custom_scope = ui.new_checkbox('AA', 'Anti-aimbot angles', '\aFFFFFFFFCustom \a'.. hex_color.. 'scope')
    ui_settings.color_picker = ui.new_color_picker('AA', 'Anti-aimbot angles', '\n scope_lines_color_picker', 0, 0, 0, 255)
    ui_settings.overlay_position = ui.new_slider('AA', 'Anti-aimbot angles', '\n scope_lines_initial_pos', 0, 500, 190)
    ui_settings.overlay_offset = ui.new_slider('AA', 'Anti-aimbot angles', '\n scope_lines_offset', 0, 500, 15)
    ui_settings.scope_pos = ui.new_multiselect('AA', 'Anti-aimbot angles', 'Exclude \a'.. hex_color.. 'scope', {"Left", "Right", "Top", "Bottom"})
    ui_settings.scope_spin_enabled = ui.new_checkbox('AA', 'Anti-aimbot angles', '\aFFFFFFFFSpin \a' .. hex_color .. 'scope')
    ui_settings.scope_spin_speed = ui.new_slider('AA', 'Anti-aimbot angles', '\aFFFFFFFFSpin \a' .. hex_color .. 'scope \aFFFFFFFFSpeed', 1, 100, 20, true, '%')
    ui_settings.scope_spin_direction = ui.new_combobox('AA', 'Anti-aimbot angles', '\aFFFFFFFFSpin \a' .. hex_color .. 'scope \aFFFFFFFFDirection', 'Clockwise', 'Counter-clockwise')
    

    
    -- Miscellaneous
    
    
    ui_settings.trashtalk = ui.new_checkbox('AA', 'Anti-aimbot angles', '\aFFFFFFFFTrash Talk')
    ui_settings.trashtalk_type = ui.new_multiselect('AA', 'Anti-aimbot angles', "\aFFFFFFFFTrash Talk\a" ..hex_color .. " Types", {"Death", "Kill"})
    ui_settings.clantagchanger = ui.new_checkbox('AA', 'Anti-aimbot angles', '\aFFFFFFFFClan Tag')
    ui_settings.fastladder = ui.new_checkbox('AA', 'Anti-aimbot angles', '\aFFFFFFFFFast Ladder')
    ui_settings.autostop_fix = ui.new_checkbox('AA', 'Fake lag', '\a'..hex_color..'Fix \aFFFFFFFFAutostop')
    ui_settings.fps_boost = ui.new_multiselect('AA', 'Anti-aimbot angles', "\aFFFFFFFFFPS \a"..hex_color.."Boost", {
        "cl_disablefreezecam", "cl_disablehtmlmotd", "r_dynamic", "r_3dsky", "r_shadows", "cl_csm_static_prop_shadows", "cl_csm_world_shadows", 
        "cl_foot_contact_shadows", "cl_csm_viewmodel_shadows", "cl_csm_rope_shadows", "cl_csm_sprite_shadows","cl_freezecameffects_showholiday", 
        "cl_showhelp", "cl_autohelp", "mat_postprocess_enable", "fog_enable_water_fog", "gameinstructor_enable", "cl_csm_world_shadows_in_viewmodelcascade", "cl_disable_ragdolls"
    })
    ui_settings.enemy_chat_reveal = ui.new_checkbox('AA', 'Anti-aimbot angles', '\aFFFFFFFFReveal \a' .. hex_color .. 'Enemy \aFFFFFFFFTeamchat')
    
    ui_settings.logaimbotcheckbox = ui.new_checkbox('AA', 'Anti-aimbot angles', '\aFFFFFFFFLog \a' .. hex_color .. 'Aimbot \aFFFFFFFFShots')
    ui_settings.logaimbot = ui.new_multiselect('AA', 'Anti-aimbot angles', "\aFFFFFFFFHitlogs \a"..hex_color.."Types", {"Console", "Under crosshair"})
    ui_settings.logaimbot_pos_y = ui.new_slider('AA', 'Anti-aimbot angles', '\aFFFFFFFFHitlogs pos \a' .. hex_color .. 'Y', 300, 600, 350, true)
    ui_settings.logaimbot_text1 = ui.new_label('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Miss \aFFFFFFFFcolor', 'string')
    ui_settings.miss_color = ui.new_color_picker('AA', 'Anti-aimbot angles', '\n hit_logs_miss_color', 0, 0, 0, 255)
    ui_settings.logaimbot_text2 = ui.new_label('AA', 'Anti-aimbot angles', '\a' .. hex_color .. 'Hit \aFFFFFFFFcolor', 'string')
    ui_settings.hit_color = ui.new_color_picker('AA', 'Anti-aimbot angles', '\n hit_logs_hit_color', 0, 0, 0, 255)
    ui_settings.hitlog_style = ui.new_combobox('AA', 'Anti-aimbot angles', '\aFFFFFFFF Hit logs \a'.. hex_color.. 'Type', {"Classic", "Modern"})

    ui_settings.grenade_trail_master = ui.new_checkbox('AA', 'Other', '\aFFFFFFFFEnhanced \a' .. hex_color .. 'Grenade \aFFFFFFFFTrail')
    ui_settings.grenade_trail_color = ui.new_color_picker('AA', 'Other', '\n grenade_trail_color', 131, 139, 163, 250)
    ui_settings.grenade_trail_thickness = ui.new_slider('AA', 'Other', '\aFFFFFFFFLine \a' .. hex_color .. 'Thickness', 0, 5, 0)
    ui_settings.grenade_trail_glow = ui.new_slider('AA', 'Other', '\aFFFFFFFFGlow \a' .. hex_color .. 'Intensity', 0, 15, 13)
    ui_settings.grenade_trail_fade = ui.new_slider('AA', 'Other', '\aFFFFFFFFFade \a' .. hex_color .. 'Speed', 1, 50, 29, true, 'sec')


    
end

local Yaw_cache = {}
for i = 1, 64 do Yaw_cache[i] = {}end
local ffi = require 'ffi'

local m_flDesync_c = {}
ffi.cdef([[
    struct c_animstate {
        char pad[ 3 ];
        char m_bForceWeaponUpdate; //0x4
        char pad1[ 91 ];
        void* m_pBaseEntity; //0x60
        void* m_pActiveWeapon; //0x64
        void* m_pLastActiveWeapon; //0x68
        float m_flLastClientSideAnimationUpdateTime; //0x6C
        int m_iLastClientSideAnimationUpdateFramecount; //0x70
        float m_flAnimUpdateDelta; //0x74
        float m_flEyeYaw; //0x78
        float m_flPitch; //0x7C
        float m_flGoalFeetYaw; //0x80
        float m_flCurrentFeetYaw; //0x84
        float m_flCurrentTorsoYaw; //0x88
        float m_flUnknownVelocityLean; //0x8C
        float m_flLeanAmount; //0x90
        char pad2[ 4 ];
        float m_flFeetCycle; //0x98
        float m_flFeetYawRate; //0x9C
        char pad3[ 4 ];
        float m_fDuckAmount; //0xA4
        float m_fLandingDuckAdditiveSomething; //0xA8
        char pad4[ 4 ];
        float m_vOriginX; //0xB0
        float m_vOriginY; //0xB4
        float m_vOriginZ; //0xB8
        float m_vLastOriginX; //0xBC
        float m_vLastOriginY; //0xC0
        float m_vLastOriginZ; //0xC4
        float m_vVelocityX; //0xC8
        float m_vVelocityY; //0xCC
        char pad5[ 4 ];
        float m_flUnknownFloat1; //0xD4
        char pad6[ 8 ];
        float m_flUnknownFloat2; //0xE0
        float m_flUnknownFloat3; //0xE4
        float m_flUnknown; //0xE8
        float m_flSpeed2D; //0xEC
        float m_flUpVelocity; //0xF0
        float m_flSpeedNormalized; //0xF4
        float m_flFeetSpeedForwardsOrSideWays; //0xF8
        float m_flFeetSpeedUnknownForwardOrSideways; //0xFC
        float m_flTimeSinceStartedMoving; //0x100
        float m_flTimeSinceStoppedMoving; //0x104
        bool m_bOnGround; //0x108
        bool m_bInHitGroundAnimation; //0x109
        float m_flTimeSinceInAir; //0x10A
        float m_flLastOriginZ; //0x10E
        float m_flHeadHeightOrOffsetFromHittingGroundAnimation; //0x112
        float m_flStopToFullRunningFraction; //0x116
        char pad7[ 4 ]; //0x11A
        float m_flMagicFraction; //0x11E
        char pad8[ 60 ]; //0x122
        float m_flWorldForce; //0x15E
        char pad9[ 462 ]; //0x162
        float m_flMinYaw; //0x330
        float m_flMaxYaw; //0x334

        float velocity_subtract_x; //0x0330 
        float velocity_subtract_y; //0x0334 
        float velocity_subtract_z; //0x0338 
    };

    typedef void*(__thiscall* get_client_entity_t)(void*, int);

    typedef struct
    {
        float   m_anim_time;		
        float   m_fade_out_time;	
        int     m_flags;			
        int     m_activity;			
        int     m_priority;			
        int     m_order;			
        int     m_sequence;			
        float   m_prev_cycle;		
        float   m_weight;			
        float   m_weight_delta_rate;
        float   m_playback_rate;	
        float   m_cycle;			
        void* m_owner;			
        int     m_bits;				
    } C_AnimationLayer;

    typedef uintptr_t (__thiscall* GetClientEntityHandle_4242425_t)(void*, uintptr_t);
]])
function clamp(value, min, max)
    return math.min(math.max(value, min), max)
end
resolver = {layers = {[0] = {}, [1] = {}, [2] = {}, [3] = {}, [4] = {}, [5] = {}, [6] = {}, [7] = {}, [8] = {}, [9] = {}, [10] = {}, [11] = {}, [12] = {}, [13] = {}, [14] = {}, [15] = {}, [16] = {}, [17] = {}, [18] = {}, [19] = {}, [20] = {}, [21] = {}, [22] = {}, [23] = {}, [24] = {}, [25] = {}, [26] = {}, [27] = {}, [28] = {}, [29] = {}, [30] = {}, [31] = {}, [32] = {}, [33] = {}, [34] = {}, [35] = {}, [36] = {}, [37] = {}, [38] = {}, [39] = {}, [40] = {}, [40] = {}, [41] = {}, [42] = {}, [43] = {}, [44] = {}, [45] = {}, [46] = {}, [47] = {}, [48] = {}, [49] = {}, [50] = {}, [51] = {}, [52] = {}, [53] = {}, [54] = {}, [55] = {}, [56] = {}, [57] = {}, [58] = {}, [59] = {}, [60] = {}, [61] = {}, [62] = {}, [63] = {}, [64] = {}}, safepoints = {},cache = {}}
function Approach(target, value, speed)
	target = AngleModifier(target)
	value = AngleModifier(value)
	local delta = target - value
	if speed < 0 then
        speed = -speed
    end
	if delta < -180 then
        delta = delta + 360
	elseif delta > 180 then
        delta = delta - 360
    end
	if delta > speed then
        value = value + speed
	elseif delta < -speed then
        value = value - speed
    else
        value = target
	end
	return value
end
function NormalizeAngle(angle)
    if angle == nil then
        return 0
    end
	while angle > 180 do
        angle = angle - 360
    end
	while angle < -180 do
        angle = angle + 360
    end
	return angle
end
function AngleDifference(dest_angle, src_angle)
	local delta = math.fmod(dest_angle - src_angle, 360)
	if dest_angle > src_angle then
		if delta >= 180 then
            delta = delta - 360
        end
	else
		if delta <= -180 then
            delta = delta + 360
        end
	end
	return delta
end
RawIEntityList = ffi.cast("void***", client.create_interface("client.dll","VClientEntityList003"))
IEntityList = ffi.cast("GetClientEntityHandle_4242425_t", RawIEntityList[0][3])
function GetAddress(idx)
    if not idx then
        return
    end
    return IEntityList(RawIEntityList, idx)
end
GetAnimState = function(ent)
    if not ent then
        return
    end
    return ffi.cast("struct c_animstate**", GetAddress(ent) + 0x9960)[0]
end
GetMaxDesync = function(player)
    local Animstate = GetAnimState(player)
    if not Animstate then
        return 0
    end
    local speedfactor = clamp(Animstate.m_flFeetSpeedForwardsOrSideWays or 0, 0, 1)
    local avg_speedfactor = (Animstate.m_flStopToFullRunningFraction * -0.3 - 0.2) * speedfactor + 1
    local duck_amount = Animstate.m_fDuckAmount
    if duck_amount > 0 then avg_speedfactor = avg_speedfactor + ((duck_amount * speedfactor) * (0.5 - avg_speedfactor)) end
    return clamp(avg_speedfactor or 0, 0.5, 1) or 0
end
GetSimulationTime = function(ent)
    local pointer = GetAddress(ent)
    if pointer and pointer ~= nil then
        return entity.get_prop(player, "m_flSimulationTime", 3), ffi.cast("float*", ffi.cast("uintptr_t", pointer) + 0x26C)[0]
    else
        return 0
    end
end
GetChokedPackets = function(player)
    local CurrentSimulationTime, PreviousSimulationTime = GetSimulationTime(player)
    local SimulationTimeDifference = toticks(entity.get_prop(player, "m_nTickBase")) - (CurrentSimulationTime or 0)
    local ChokedCommands = clamp(toticks(SimulationTimeDifference - client.latency()) or 0, 0, cvar["sv_maxusrcmdprocessticks"]:get_string() - 2)
    return ChokedCommands
end
function AntiaimCorrection(idx, m_flEyeYaw)
	if not idx or not entity.get_prop(idx, "m_angEyeAngles[1]") or not client.current_threat() or not globals.tickcount() or not m_flEyeYaw or not entity.get_local_player() then return 0 end
    Yaw_cache[idx][globals.tickcount()] = entity.get_prop(idx, "m_angEyeAngles[1]") or 0
    return (Yaw_cache[idx][globals.tickcount() - GetChokedPackets(idx)] or m_flEyeYaw) - m_flEyeYaw
end
GetAnimlayers = function (ent, layer)
    if not ent then
        return
    end
    return ffi.cast("C_AnimationLayer**", ffi.cast('uintptr_t', GetAddress(ent)) + 0x9960)[0]
end
function AngleModifier(a)
    return (360 / 65536) * bit.band(math.floor(a * (65536 / 360)), 65535)
end
C_updateLayers = function(idx)
    resolver.layers[idx] = GetAnimlayers(idx)
    if not resolver.layers[idx] then
        return
    end
    for i = 1, 12 do
        local layer = resolver.layers[idx][i]
        if layer and layer.m_sequence and layer.m_playback_rate then
            if not resolver.layers[idx][i] then
                resolver.layers[idx][i] = {}
            end
            resolver.layers[idx][i].m_playback_rate = layer.m_playback_rate or resolver.layers[idx][i].m_playback_rate
            resolver.layers[idx][i].m_sequence = layer.m_sequence or resolver.layers[idx][i].m_sequence
            break
        end
    end
end
C_updateSafety = function(idx, side, desync)
    if not idx or not side or not desync then
        return
    end
    if not resolver.safepoints[idx] then
        resolver.safepoints[idx] = {}
    end
    for i = 1, 3 do
        if resolver.safepoints[idx][i] == nil or resolver.safepoints[idx][i].m_playback_rate == nil or resolver.safepoints[idx][i].m_flDesync == nil then
            resolver.safepoints[idx][i] = {}
            resolver.safepoints[idx][i].m_playback_rate = resolver.layers[idx][6].m_playback_rate
            resolver.safepoints[idx][i].m_flDesync = desync
        end
    end
    if side < 0 then
        resolver.safepoints[idx][3].m_flDesync = -desync
        if math.abs(resolver.safepoints[idx][3].m_flDesync) <= desync then
            resolver.safepoints[idx][3].m_flDesync = -desync
            resolver.safepoints[idx][3].m_playback_rate = resolver.layers[idx][6].m_playback_rate
        end
        resolver.safepoints[idx][3].m_playback_rate = resolver.layers[idx][6].m_playback_rate
    elseif side > 0 then
        resolver.safepoints[idx][2].m_flDesync = desync
        if resolver.safepoints[idx][2].m_flDesync >= desync then
            resolver.safepoints[idx][2].m_flDesync = desync
            resolver.safepoints[idx][2].m_playback_rate = resolver.layers[idx][6].m_playback_rate
        end
        resolver.safepoints[idx][2].m_playback_rate = resolver.layers[idx][6].m_playback_rate
    else
        m_flDesync = side * desync
        resolver.safepoints[idx][1].m_flDesync = m_flDesync
        if math.abs(resolver.safepoints[idx][1].m_flDesync) >= desync then
            resolver.safepoints[idx][1].m_flDesync = m_flDesync
            resolver.safepoints[idx][1].m_playback_rate = resolver.layers[idx][6].m_playback_rate
        end
        resolver.safepoints[idx][1].m_playback_rate = resolver.layers[idx][6].m_playback_rate
    end
    if resolver.safepoints[idx][2].m_playback_rate and resolver.safepoints[idx][3].m_playback_rate then
        m_flDesync = side * desync
        if m_flDesync >= resolver.safepoints[idx][3].m_flDesync then
            if m_flDesync <= resolver.safepoints[idx][2].m_flDesync then
                resolver.safepoints[idx][1].m_flDesync = m_flDesync
                if math.abs(resolver.safepoints[idx][1].m_flDesync) >= desync then
                    resolver.safepoints[idx][1].m_flDesync = m_flDesync
                    resolver.safepoints[idx][1].m_playback_rate = resolver.layers[idx][6].m_playback_rate
                end
                resolver.safepoints[idx][1].m_playback_rate = resolver.layers[idx][6].m_playback_rate 
            end
        end
    end
end
C_Transition = function(m_flWalkToRunTransition, m_bWalkToRunTransitionState, m_flLastUpdateIncrement, m_flVelocityLengthXY)
    local ANIM_TRANSITION_WALK_TO_RUN = false
    local ANIM_TRANSITION_RUN_TO_WALK = true
    local CSGO_ANIM_WALK_TO_RUN_TRANSITION_SPEED = 2.0
    local CS_PLAYER_SPEED_RUN = 260.0
    local CS_PLAYER_SPEED_DUCK_MODIFIER = 0.34
    local CS_PLAYER_SPEED_WALK_MODIFIER = 0.52
    if m_flWalkToRunTransition > 0 and m_flWalkToRunTransition < 1 then
        if m_bWalkToRunTransitionState == ANIM_TRANSITION_WALK_TO_RUN then
            m_flWalkToRunTransition = m_flWalkToRunTransition + m_flLastUpdateIncrement * CSGO_ANIM_WALK_TO_RUN_TRANSITION_SPEED
        else
            m_flWalkToRunTransition = m_flWalkToRunTransition - m_flLastUpdateIncrement * CSGO_ANIM_WALK_TO_RUN_TRANSITION_SPEED
        end
        m_flWalkToRunTransition = clamp(m_flWalkToRunTransition, 0, 1)
    end
    if m_flVelocityLengthXY > (CS_PLAYER_SPEED_RUN * CS_PLAYER_SPEED_WALK_MODIFIER) and m_bWalkToRunTransitionState == ANIM_TRANSITION_RUN_TO_WALK then
        m_bWalkToRunTransitionState = ANIM_TRANSITION_WALK_TO_RUN
        m_flWalkToRunTransition = math.max(0.01, m_flWalkToRunTransition)
    elseif m_flVelocityLengthXY < (CS_PLAYER_SPEED_RUN * CS_PLAYER_SPEED_WALK_MODIFIER) and m_bWalkToRunTransitionState == ANIM_TRANSITION_WALK_TO_RUN then
        m_bWalkToRunTransitionState = ANIM_TRANSITION_RUN_TO_WALK
        m_flWalkToRunTransition = math.min(0.99, m_flWalkToRunTransition)
    end
    return m_flWalkToRunTransition, m_bWalkToRunTransitionState
end
C_predictedFootYaw = function(m_flFootYawLast, m_flEyeYaw, m_flLowerBodyYawTarget, m_flWalkToRunTransition, m_vecVelocity, m_flMinBodyYaw, m_flMaxBodyYaw)
    local m_flVelocityLengthXY = math.min((m_vecVelocity), 260.0)
    local m_flFootYaw = clamp(m_flFootYawLast, -360, 360)
    local flEyeFootDelta = AngleDifference(m_flEyeYaw, m_flFootYaw)
    if flEyeFootDelta > m_flMaxBodyYaw then
        m_flFootYaw = m_flEyeYaw - math.abs(m_flMaxBodyYaw)
    elseif flEyeFootDelta < m_flMinBodyYaw then
        m_flFootYaw = m_flEyeYaw + math.abs(m_flMinBodyYaw)
    end
    m_flFootYaw = NormalizeAngle(m_flFootYaw)
    local m_flLastUpdateIncrement = globals.tickinterval()
    if m_flVelocityLengthXY > 0.1 or m_vecVelocity > 100 then
        m_flFootYaw = Approach(m_flEyeYaw, m_flFootYaw, m_flLastUpdateIncrement * (30.0 + 20.0 * m_flWalkToRunTransition))
    else
        m_flFootYaw = Approach(m_flLowerBodyYawTarget, m_flFootYaw, m_flLastUpdateIncrement * 100)
    end

    return m_flFootYaw
end
C_ResolverInstance = function(idx)
    local animstate = GetAnimState(idx)
    local ent = idx
    if not entity.get_local_player() or not entity.is_alive(entity.get_local_player())then
        return 0
    end
    if not ent or not entity.is_alive(ent) or not animstate then
        return 0
    end
    C_updateLayers(idx)
    if not resolver.cache[idx] then
        resolver.cache[idx] = {}
    end
    local side = 0
    local side2 = 0
    local latest = 0
    local latest2 = 0
    local m_flMaxDesyncDelta = GetMaxDesync(idx)
    local m_flDesync = m_flMaxDesyncDelta * 57.2957795131
    local m_flEyeYaw = animstate.m_flEyeYaw
    local m_flAngleDiff = AngleDifference(m_flEyeYaw, plist.get(idx, "Force body yaw value"))
    local m_flAbsAngleDiff = math.abs(m_flAngleDiff)
	local m_flMaxYawModifier = m_flMaxDesyncDelta * animstate.m_flMaxYaw
    local m_flMinYawModifier = m_flMaxDesyncDelta * animstate.m_flMinYaw
    if m_flAngleDiff < 0 then
        side = -1
        latest = 1
    elseif m_flAngleDiff > 0 then
        side = 1
        latest = -1
    elseif m_flAngleDiff == 0 then
        side = latest
    end
    if m_flAbsAngleDiff > 0 or (resolver.cache[idx].m_flAbsAngleDiff or 0) > 0 then
        m_flCurrentAngle = math.max(m_flAbsAngleDiff, resolver.cache[idx].m_flAbsAngleDiff or 1)
        if m_flAbsAngleDiff <= 10 and (resolver.cache[idx].m_flAbsAngleDiff or 0) <= 10 then
            m_flDesync = m_flCurrentAngle
        elseif m_flAbsAngleDiff <= 35 and (resolver.cache[idx].m_flAbsAngleDiff or 0) <= 35 then
            m_flDesync = math.max(29, m_flCurrentAngle)
        else
            m_flDesync = clamp(m_flCurrentAngle, 29, 57.2957795131)
        end
    end
    resolver.cache[idx].m_flAbsAngleDiff = m_flAbsAngleDiff
    m_flDesync = clamp(m_flDesync, 1, m_flMaxDesyncDelta * 57.2957795131)
    C_updateSafety(idx, side, m_flDesync)
    if side ~= 0 and resolver.safepoints[idx] then
        if resolver.safepoints[idx][1] and resolver.safepoints[idx][2] and resolver.safepoints[idx][3] then
            if resolver.safepoints[idx][1].m_playback_rate and resolver.safepoints[idx][2].m_playback_rate and resolver.safepoints[idx][3].m_playback_rate then
                local server_playback = resolver.layers[idx][6].m_playback_rate
                local center_playback = resolver.safepoints[idx][1].m_playback_rate
                local left_playback = resolver.safepoints[idx][2].m_playback_rate
                local right_playback = resolver.safepoints[idx][3].m_playback_rate
                local m_layer_delta1 = math.abs(server_playback - center_playback)
                local m_layer_delta2 = math.abs(server_playback - left_playback)
                local m_layer_delta3 = math.abs(server_playback - right_playback)
                if m_layer_delta2 - m_layer_delta3 > m_layer_delta1 then
                    side2 = 1
                    latest2 = -1
                else
                    if m_layer_delta2 - m_layer_delta3 ~= m_layer_delta1 then
                        side2 = -1
                        latest2 = 1
                    else
                        side2 = latest2
                    end
                end
            end
        end
    end
    local m_vecVelocity = entity.get_prop(ent, "m_vecVelocity")
    resolver.cache[idx].m_flWalkToRunTransition, resolver.cache[idx].m_bWalkToRunTransitionState = C_Transition(resolver.cache[idx].m_flWalkToRunTransition or 0, resolver.cache[idx].m_bWalkToRunTransitionState or false, globals.tickinterval(), math.min((m_vecVelocity), 260))
    m_flDesync_c[idx] = m_flDesync * side2
    return C_predictedFootYaw(plist.get(idx, "Force body yaw value"), m_flEyeYaw - m_flDesync * side2, entity.get_prop(ent, "m_flLowerBodyYawTarget") - m_flDesync * side2, resolver.cache[idx].m_flWalkToRunTransition, m_vecVelocity, m_flMinYawModifier, m_flMaxYawModifier)
end
resolver_mode = 3
local modes = {"main", "beta", "experemental"}
local rgba_to_hex = function(r, g, b, a)
    return string.format('%02x%02x%02x%02x', r, g, b, a)
end

local is_auto = true
local current_r_p = 1
local modes_c = {}
local resultr = false
local best_mode = 1
for i = 1, #modes do
	modes_c[i] = {h=0,m=0}
end
local modes_text = ""
for i = 1, #modes do
	if i ~= #modes then
		modes_text = modes_text..modes[i].." or "
	else
		modes_text = modes_text..modes[i]
	end
end

last_angles = {}
local get_last_angles = function(pl)
	return last_angles[pl] or entity.get_prop(player, "m_angEyeAngles[1]") or 0
end
function Resolving()
    local lp = entity.get_local_player()
    if not lp then return end
	for _, player in pairs(entity.get_players(true)) do
        if ui.get(ui_settings.resolver) then
            plist.set(player, "Force body yaw", false)
            plist.set(player, "Force body yaw value", 0)
            return
        end
		local animstate = GetAnimState(player)
		if is_auto == false and resolver_mode == 1 or (resultr == false and current_r_p == 1 or best_mode == 1) then
			if animstate then
				local JitterCorrection = AntiaimCorrection(player, animstate.m_flEyeYaw)
				local bodyaw_correnction = NormalizeAngle(C_ResolverInstance(player) - JitterCorrection)
				if NormalizeAngle(C_ResolverInstance(player) - JitterCorrection) > 58 or NormalizeAngle(C_ResolverInstance(player) - JitterCorrection) < -58 then
					plist.set(player, "Force body yaw", false)
				else
					plist.set(player, "Force body yaw", true)
					if entity.get_steam64(player) ~= 0 then
						plist.set(player, "Force body yaw value", clamp(-58, bodyaw_correnction, 58))
					else
						plist.set(player, "Force body yaw value", 0)
					end
				end
			end
		elseif is_auto == false and resolver_mode == 2 or (resultr == false and current_r_p == 2 or best_mode == 2) then
			if entity.is_dormant(player) or not entity.is_alive(player) or not animstate then return end
			
			local goal_feet_yaw = animstate.m_flGoalFeetYaw
			local eye_yaw = entity.get_prop(player, "m_angEyeAngles[1]") or 0
			local speed = entity.get_prop(player, "m_vecVelocity[0]") or 0
			
			local last_angle = get_last_angles(player)
			local predicted_yaw = last_angle or eye_yaw
			
			local delta_yaw = NormalizeAngle(eye_yaw - goal_feet_yaw)
			if math.abs(delta_yaw) > 35 then
				predicted_yaw = goal_feet_yaw
			end
			
			local normalized_speed = math.min(math.abs(speed) / 260, 1)
			predicted_yaw = predicted_yaw * (1 - normalized_speed * 0.5) + goal_feet_yaw * (normalized_speed * 0.5)
			
			local angle_delta = NormalizeAngle(predicted_yaw - last_angle)
				
			if math.abs(angle_delta) > 10 then
				predicted_yaw = last_angle + angle_delta * 0.25
			else
				predicted_yaw = last_angle + angle_delta * 0.5
			end
			
			last_angles[player] = (delta_yaw / 2) + angle_delta

			plist.set(player, "Force body yaw", true)
			plist.set(player, "Force body yaw value", clamp(-58, 58, NormalizeAngle(predicted_yaw)))
		elseif is_auto == false and resolver_mode == 3 or (resultr == false and current_r_p == 3 or best_mode == 3) then
			local eye_yaw = entity.get_prop(player, "m_angEyeAngles[1]")
			plist.set(player, "Force body yaw", true)
			local goal_feet_yaw = animstate.m_flGoalFeetYaw
			plist.set(player, "Force body yaw value", clamp(-58, 58, NormalizeAngle(eye_yaw-goal_feet_yaw)))
        end
	end
end
client.set_event_callback("net_update_start", function()
	if not entity.get_local_player() or not entity.is_alive(entity.get_local_player()) or not entity.get_players(true) then return end
	Resolving()
end)
local rper_m = 0
misses_r, hit_r = 0, 0
client.set_event_callback("aim_miss", function()
	if is_auto == true then modes_c[current_r_p].m = modes_c[current_r_p].m + 1 return end
	misses_r = misses_r + 1
end)
client.set_event_callback("aim_hit", function()
	if is_auto == true then modes_c[current_r_p].h = modes_c[current_r_p].h + 1 return end
	hit_r = hit_r + 1
end)
client.set_event_callback("round_end", function()
	if is_auto == true then rper_m = rper_m + 1 return end
	if misses_r+1 < hit_r and misses_r+1 > 1 then return end
	for i = 1, 64 do Yaw_cache[i] = {}end
	misses_r = 0 hit_r = 0
end)



local anti_aim do
    anti_aim = {
        current_tickcount = 0,
        current_tickcount_defensive = 0,
        current_tickcount_defensive_pitch = 0,
        last_rand = 0,
        jitterstate = 1,
        jitterstate_defensive = 1,
        jitterstate_defensive_pitch = 1,
        direction = 0,
        anti_aim_on_use_direction = 0,
        is_on_ground = false,
        final_yaw = 0,
        was_defensive_active = false,
        defensive_ticks_remaining = 0,
        current_stance = 'global',
        last_defensive_pitch_random = 0,
        last_defensive_yaw_random = 0,
    }

    local mleft_state = false
    local mright_state = false
    local mforward_state = false
    local mleft_prev_state = false
    local mright_prev_state = false
    local mforward_prev_state = false

    function anti_aim.is_double_tap_active()
        return ui.get(reference.double_tap[1]) and ui.get(reference.double_tap[2])
    end
    
    function anti_aim.is_on_shot_antiaim_active()
        return ui.get(reference.on_shot_anti_aim[1]) and ui.get(reference.on_shot_anti_aim[2])
    end

    function anti_aim.is_defensive_active(state_id)
        local settings = ui_settings.anti_aim_settings[state_id]
        local defensive_data = exploit.get().defensive
        
        if defensive_data.left ~= 0 then
            anti_aim.defensive_ticks_remaining = defensive_data.left
        else
            anti_aim.defensive_ticks_remaining = 0
        end
        
        
        if ui.get(settings.override_defensive) and defensive_data.left ~= 0 and (anti_aim.is_double_tap_active() or anti_aim.is_on_shot_antiaim_active()) then
            return true
        end
        
        
        return false
    end

    local function get_defensive_yaw(state_id)
        local settings = ui_settings.anti_aim_settings[state_id]
        local defensive_jitter_type = ui.get(settings.defensive_jitter_type)
        
        if defensive_jitter_type == 'Off' then
            return 0
        end
        
        local defensive_offset = ui.get(settings.defensive_jitter_offset)
        local defensive_random = anti_aim.last_defensive_yaw_random
        
        local current_delay = ui.get(settings.defensive_jitter_delay)
        current_delay = current_delay + utility.random_int(0, ui.get(settings.defensive_jitter_delay_random))
        
        local tick = globals.tickcount()
        local tick_group = math.floor(tick / current_delay)
        if defensive_jitter_type == 'Static' then
            return utility.normalize_angle(defensive_offset + defensive_random)
        elseif defensive_jitter_type == 'Offset' then
            if anti_aim.jitterstate_defensive == 1 then
                return utility.normalize_angle(defensive_offset + defensive_random)
            else
                return utility.normalize_angle(0 + defensive_random)
            end
        elseif defensive_jitter_type == 'Center' then
            return utility.normalize_angle(defensive_offset * anti_aim.jitterstate_defensive + defensive_random)
        elseif defensive_jitter_type == 'Skitter' then
            local pattern = tick_group % 3
            
            if pattern == 0 then
                return utility.normalize_angle(-defensive_offset + defensive_random)
            elseif pattern == 1 then
                return utility.normalize_angle(defensive_offset + defensive_random)
            else
                return utility.normalize_angle(0 + defensive_random)
            end
        elseif defensive_jitter_type == '3-Ways' then
            local pattern = tick_group % 3
            
            if pattern == 0 then
                return utility.normalize_angle(defensive_offset * -1 + defensive_random)
            elseif pattern == 1 then
                return utility.normalize_angle(0 + defensive_random) * 2
            else
                return utility.normalize_angle(defensive_offset + defensive_random)
            end
        elseif defensive_jitter_type == 'Random' then
            return utility.normalize_angle(utility.random_int(-defensive_offset, defensive_offset))
        elseif defensive_jitter_type == 'Spin' then
            local spin_speed = defensive_offset
            local spin_angle = (tick * spin_speed) % 360
            return utility.normalize_angle(spin_angle - 180 + defensive_random)
        end
        
        return 0
    end

    local function get_defensive_pitch(state_id)
        local settings = ui_settings.anti_aim_settings[state_id]
        local defensive_pitch_type = ui.get(settings.defensive_pitch_type)
        
        if defensive_pitch_type == 'Off' then
            return nil, 'Off'
        end
        
        if defensive_pitch_type == 'Custom' then
            return utility.clamp(ui.get(settings.defensive_pitch_offset) + utility.random_int(ui.get(settings.defensive_pitch_random) * -1, ui.get(settings.defensive_pitch_random)), -89, 89), 'Custom'
        elseif defensive_pitch_type == 'Jitter' then
            local tick = globals.tickcount()
            local pitch_delay = ui.get(settings.defensive_pitch_delay)
            pitch_delay = pitch_delay + utility.random_int(0, ui.get(settings.defensive_pitch_delay_random))
            
            if anti_aim.jitterstate_defensive_pitch == 1 then
                return utility.clamp(ui.get(settings.defensive_pitch_jitter_2) + anti_aim.last_defensive_pitch_random, -89, 89), 'Custom'
            else
                return utility.clamp(ui.get(settings.defensive_pitch_jitter_1) + anti_aim.last_defensive_pitch_random, -89, 89) , 'Custom'
            end

        elseif defensive_pitch_type == 'Sway' then
            local sway_angle = math.sin(globals.tickcount() * ui.get(settings.defensive_pitch_offset_speed) / 100) * ui.get(settings.defensive_pitch_offset)
            return utility.clamp(utility.normalize_angle(sway_angle + utility.random_int(ui.get(settings.defensive_pitch_random) * -1, ui.get(settings.defensive_pitch_random))), -89, 89), 'Custom'
        elseif defensive_pitch_type == 'Random' then
            return utility.clamp(utility.random_int(ui.get(settings.defensive_pitch_jitter_1), ui.get(settings.defensive_pitch_jitter_2)), -89, 89), 'Custom'
        end
        
        return nil, 'Off'
    end

    local function set_yaw_jitter_type(state_id, offset, yaw)
        local settings = ui_settings.anti_aim_settings[state_id]
        local jitter_type = ui.get(settings.yaw_jitter_type)
        local current_delay = ui.get(settings.yaw_delay)

        local is_defensive = anti_aim.is_defensive_active(state_id)
        if is_defensive and ui.get(settings.defensive_jitter_type) ~= 'Off' and ui.get(settings.override_defensive) then
            return get_defensive_yaw(state_id)
        end

        if not anti_aim.is_double_tap_active() and not anti_aim.is_on_shot_antiaim_active() then
            current_delay = current_delay + 3
        end

        local tick = globals.tickcount()
        
        local tick_group = math.floor(tick / current_delay)
        
        if jitter_type == 'Center' then
            return offset * anti_aim.jitterstate + yaw
        elseif jitter_type == 'Offset' then
            if anti_aim.jitterstate == 1 then
                return offset
            else
                return 0
            end
        elseif jitter_type == 'Skitter' then
            local pattern = tick_group % 3
            
            if pattern == 0 then
                return offset * -1 + yaw
            elseif pattern == 1 then
                return offset + yaw
            else
                return 0 + yaw
            end
        elseif jitter_type == '3-Ways' then
            local pattern = tick_group % 3
            
            if pattern == 0 then
                return ui.get(settings.yaw_way1) + yaw
            elseif pattern == 1 then
                return ui.get(settings.yaw_way2) + yaw
            else
                return ui.get(settings.yaw_way3) + yaw
            end
        elseif jitter_type == '5-Ways' then
            local pattern = tick_group % 5
            
            if pattern == 0 then
                return ui.get(settings.yaw_way1) + yaw
            elseif pattern == 1 then
                return ui.get(settings.yaw_way2) + yaw
            elseif pattern == 2 then
                return ui.get(settings.yaw_way3) + yaw
            elseif pattern == 3 then 
                return ui.get(settings.yaw_way4) + yaw
            else
                return ui.get(settings.yaw_way5) + yaw
            end
        else
            return 0 + yaw
        end
    end
    
    local function set_desync(state_id)
        local settings = ui_settings.anti_aim_settings[state_id]
        local desync_type = ui.get(settings.body_yaw_type)
        
        local is_defensive = anti_aim.is_defensive_active(state_id) and ui.get(settings.override_defensive)
        
        if is_defensive then
            ui.set(reference.body_yaw[1], 'Static')
            
            local defensive_yaw = get_defensive_yaw(state_id)
            if defensive_yaw ~= 0 then
                ui.set(reference.body_yaw[2], utility.normalize_angle(defensive_yaw))
            else
                if (anti_aim.direction == -90 or anti_aim.direction == 90 or anti_aim.direction == 180) and utility.contains(ui_settings.tweaks, 'Off jitter on manual') then
                    ui.set(reference.body_yaw[1], 'Static')
                    if ui.get(settings.body_checkbox) then
                        ui.set(reference.body_yaw[2], utility.normalize_angle(ui.get(settings.body_yaw_value) + utility.random_int(0, ui.get(settings.body_yaw_value_random))))
                    else
                        ui.set(reference.body_yaw[2], utility.normalize_angle(ui.get(settings.body_yaw_value)))
                    end
                elseif desync_type == 'Jitter' then
                    ui.set(reference.body_yaw[1], 'Static')
                    if ui.get(settings.body_checkbox) then
                        ui.set(reference.body_yaw[2], utility.normalize_angle(ui.get(settings.body_yaw_value) * anti_aim.jitterstate + utility.random_int(0, ui.get(settings.body_yaw_value_random))))
                    else
                        ui.set(reference.body_yaw[2], utility.normalize_angle(ui.get(settings.body_yaw_value) * anti_aim.jitterstate))
                    end
                else
                    ui.set(reference.body_yaw[1], desync_type)
                    if ui.get(settings.body_checkbox) then
                        ui.set(reference.body_yaw[2], utility.normalize_angle(ui.get(settings.body_yaw_value) + utility.random_int(0, ui.get(settings.body_yaw_value_random))))
                    else
                        ui.set(reference.body_yaw[2], utility.normalize_angle(ui.get(settings.body_yaw_value)))
                    end
                end
            end
        elseif (anti_aim.direction == -90 or anti_aim.direction == 90 or anti_aim.direction == 180) and utility.contains(ui_settings.tweaks, 'Off jitter on manual') then
            ui.set(reference.body_yaw[1], 'Static')
            if ui.get(settings.body_checkbox) then
                ui.set(reference.body_yaw[2], utility.normalize_angle(ui.get(settings.body_yaw_value) + utility.random_int(0, ui.get(settings.body_yaw_value_random))))
            else
                ui.set(reference.body_yaw[2], utility.normalize_angle(ui.get(settings.body_yaw_value)))
            end
        elseif desync_type == 'Jitter' then
            ui.set(reference.body_yaw[1], 'Static')
            if ui.get(settings.body_checkbox) then
                ui.set(reference.body_yaw[2], utility.normalize_angle(ui.get(settings.body_yaw_value) * anti_aim.jitterstate + utility.random_int(0, ui.get(settings.body_yaw_value_random))))
            else
                ui.set(reference.body_yaw[2], utility.normalize_angle(ui.get(settings.body_yaw_value) * anti_aim.jitterstate))
            end
        elseif desync_type == 'Sway' then
            local sway_angle = math.sin(globals.tickcount() * 5) * utility.normalize_angle(ui.get(settings.body_yaw_value) + utility.random_int(0, ui.get(settings.body_yaw_value_random))) + 1 * anti_aim.jitterstate
            ui.set(reference.body_yaw[1], 'Static')
            ui.set(reference.body_yaw[2], utility.normalize_angle(sway_angle + utility.random_int(0, ui.get(settings.body_yaw_value_random))))
        else
            ui.set(reference.body_yaw[1], desync_type)
            if ui.get(settings.body_checkbox) then
                ui.set(reference.body_yaw[2], utility.normalize_angle(ui.get(settings.body_yaw_value) + utility.random_int(0, ui.get(settings.body_yaw_value_random))))
            else
                ui.set(reference.body_yaw[2], utility.normalize_angle(ui.get(settings.body_yaw_value)))
            end
        end
        
        ui.set(reference.freestanding_body_yaw, ui.get(settings.freestanding_body_yaw))
    end
    
    local function get_stance(cmd)
        local self = entity_get_local_player()
        if not self then return 1 end
        
        local using = false
        local is_planting = entity_get_prop(self, 'm_bInBombZone') == 1 and 
                          entity.get_classname(entity_get_player_weapon(self)) == 'CC4' and 
                          entity_get_prop(self, 'm_iTeamNum') == 2
        
        local CPlantedC4 = entity.get_all('CPlantedC4')[1]
        local is_defusing = false
        
        if CPlantedC4 ~= nil then
            local dist_to_c4 = vector(entity_get_prop(self, 'm_vecOrigin')):dist(
                vector(entity_get_prop(CPlantedC4, 'm_vecOrigin')))
            if entity_get_prop(CPlantedC4, 'm_bBombDefused') == 1 then 
                dist_to_c4 = 56 
            end
            is_defusing = dist_to_c4 < 56 and entity_get_prop(self, 'm_iTeamNum') == 3
        end
        
        local eye_x, eye_y, eye_z = client.eye_position()
        local pitch, yaw = client.camera_angles()
        local sin_pitch = math.sin(math.rad(pitch))
        local cos_pitch = math.cos(math.rad(pitch))
        local sin_yaw = math.sin(math.rad(yaw))
        local cos_yaw = math.cos(math.rad(yaw))
        local direction_vector = {cos_pitch * cos_yaw, cos_pitch * sin_yaw, -sin_pitch}
        local fraction, entity_index = client.trace_line(self, eye_x, eye_y, eye_z, 
            eye_x + (direction_vector[1] * 8192), 
            eye_y + (direction_vector[2] * 8192), 
            eye_z + (direction_vector[3] * 8192))
        
        if entity_index ~= -1 then
            if vector(entity_get_prop(self, 'm_vecOrigin')):dist(
                vector(entity_get_prop(entity_index, 'm_vecOrigin'))) < 146 then
                local classname = entity.get_classname(entity_index)
                using = classname ~= 'CWorld' and 
                       classname ~= 'CFuncBrush' and 
                       classname ~= 'CCSPlayer'
            end
        end
        
        if cmd.in_use == 1 and not using and not is_planting and not is_defusing and 
           ui.get(ui_settings.anti_aim_settings[9].override_state) then
            cmd.buttons = bit.band(cmd.buttons, bit.bnot(bit.lshift(1, 5)))
            anti_aim.on_use = true
            anti_aim.in_jump_state = false
            return 9 -- On use
        elseif utility.player_will_peek() and ui.get(ui_settings.anti_aim_settings[10].override_state) then
            anti_aim.in_jump_state = false
            anti_aim.on_use = false
            return 10 -- On peek
        elseif (cmd.in_jump == 1 or bit.band(entity_get_prop(self, 'm_fFlags'), 1) == 0) and 
               entity_get_prop(self, 'm_flDuckAmount') > 0.8 and 
               ui.get(ui_settings.anti_aim_settings[8].override_state) then
            anti_aim.in_jump_state = true
            anti_aim.on_use = false
            return 8 -- In air & crouching
        elseif (cmd.in_jump == 1 or bit.band(entity_get_prop(self, 'm_fFlags'), 1) == 0) and 
               entity_get_prop(self, 'm_flDuckAmount') < 0.8 and 
               ui.get(ui_settings.anti_aim_settings[7].override_state) then
            anti_aim.in_jump_state = true
            anti_aim.on_use = false
            return 7 -- In air
        elseif bit.band(entity_get_prop(self, 'm_fFlags'), 1) ~= 0 and 
               (entity_get_prop(self, 'm_flDuckAmount') > 0.8 or ui.get(reference.duck_peek_assist)) and 
               vector(entity_get_prop(self, 'm_vecVelocity')):length() > 2 and 
               ui.get(ui_settings.anti_aim_settings[6].override_state) then
            anti_aim.in_jump_state = false
            anti_aim.on_use = false
            return 6 -- Crouching & moving
        elseif bit.band(entity_get_prop(self, 'm_fFlags'), 1) ~= 0 and 
               entity_get_prop(self, 'm_flDuckAmount') > 0.8 and 
               vector(entity_get_prop(self, 'm_vecVelocity')):length() < 2 and 
               ui.get(ui_settings.anti_aim_settings[5].override_state) then
            anti_aim.in_jump_state = false
            anti_aim.on_use = false
            return 5 -- Crouching
        elseif bit.band(entity_get_prop(self, 'm_fFlags'), 1) ~= 0 and 
               vector(entity_get_prop(self, 'm_vecVelocity')):length() > 2 and 
               entity_get_prop(self, 'm_flDuckAmount') < 0.8 and 
               (ui.get(reference.slow_motion[1]) and ui.get(reference.slow_motion[2])) == true and 
               ui.get(ui_settings.anti_aim_settings[4].override_state) then
            anti_aim.in_jump_state = false
            anti_aim.on_use = false
            return 4 -- Slow motion
        elseif bit.band(entity_get_prop(self, 'm_fFlags'), 1) ~= 0 and 
               vector(entity_get_prop(self, 'm_vecVelocity')):length() > 2 and 
               entity_get_prop(self, 'm_flDuckAmount') < 0.8 and 
               (ui.get(reference.slow_motion[1]) and ui.get(reference.slow_motion[2])) == false and 
               ui.get(ui_settings.anti_aim_settings[3].override_state) then
            anti_aim.in_jump_state = false
            anti_aim.on_use = false
            return 3 -- Moving
        elseif bit.band(entity_get_prop(self, 'm_fFlags'), 1) ~= 0 and 
               vector(entity_get_prop(self, 'm_vecVelocity')):length() < 2 and 
               entity_get_prop(self, 'm_flDuckAmount') < 0.8 and 
               ui.get(ui_settings.anti_aim_settings[2].override_state) then
            anti_aim.in_jump_state = false
            anti_aim.on_use = false
            return 2 -- Standing
        else
            anti_aim.in_jump_state = false
            anti_aim.on_use = false
            return 1 -- Global
        end
    end

    local miss_tracker = {}
    local brute_sequence = {2, -2, 4, -4, 0}
    local brute_index = 1
    local last_brute_tick = 0
    local brute_reset_tick = 0

    function anti_aim.setup_command(cmd)
        local self = entity_get_local_player()
        if not self or entity_get_player_weapon(self) == nil then return end
        
        local state_id = get_stance(cmd)
        local anti_aim_states = {'GLOBAL ', 'STANDING', 'MOVING', 'WALKING ', 'CROUCH  ', 'CROUCHING', 'AIR   ', 'AIRCROUCH', 'ONUSE', 'ONPEEK'}
        local settings = ui_settings.anti_aim_settings[state_id]
        local options = ui.get(settings.options) or {}
        anti_aim.current_stance = anti_aim_states[state_id]
        
        if state_id ~= 1 and not ui.get(settings.override_state) then
            state_id = 1
            settings = ui_settings.anti_aim_settings[state_id]
        end
        
        local current_delay = ui.get(settings.yaw_delay)
        if ui.get(settings.body_checkbox) then
            current_delay = current_delay + utility.random_int(0, ui.get(settings.yaw_delay_random))
        else
            current_delay = ui.get(settings.yaw_delay)
        end
        
        if globals.tickcount() > anti_aim.current_tickcount + current_delay then
            if cmd.chokedcommands == 0 then
                anti_aim.jitterstate = anti_aim.jitterstate * -1
                anti_aim.current_tickcount = globals.tickcount()
                anti_aim.last_rand = utility.random_int(ui.get(settings.yaw_random) * -1, ui.get(settings.yaw_random))
                if ui.get(settings.yaw_random_checkbox) then
                    anti_aim.last_left_rand = utility.random_int(0, ui.get(settings.yaw_left_random))
                    anti_aim.last_right_rand = utility.random_int(0, ui.get(settings.yaw_right_random))
                else
                    anti_aim.last_left_rand = 0
                    anti_aim.last_right_rand = 0
                end
            end
        end
        if globals.tickcount() > anti_aim.current_tickcount_defensive + ui.get(settings.defensive_jitter_delay) + utility.random_int(0, ui.get(settings.defensive_jitter_delay_random)) then
            if cmd.chokedcommands == 0 then
                anti_aim.jitterstate_defensive = anti_aim.jitterstate_defensive * -1
                anti_aim.current_tickcount_defensive = globals.tickcount()
                anti_aim.last_defensive_yaw_random = utility.random_int(-ui.get(settings.defensive_yaw_random), ui.get(settings.defensive_yaw_random))
            end
        end
        if globals.tickcount() > anti_aim.current_tickcount_defensive_pitch + ui.get(settings.defensive_pitch_delay) + utility.random_int(0, ui.get(settings.defensive_pitch_delay_random)) then
            if cmd.chokedcommands == 0 then
                anti_aim.jitterstate_defensive_pitch = anti_aim.jitterstate_defensive_pitch * -1
                anti_aim.current_tickcount_defensive_pitch = globals.tickcount()
                anti_aim.last_defensive_pitch_random = utility.random_int(ui.get(settings.defensive_pitch_random) * -1, ui.get(settings.defensive_pitch_random))
            end
        end


        local inverted = entity.get_prop(self, "m_flPoseParameter", 11) * 120 - 60
        local current_yaw = 0
        local current_random = 0
        local last_random = anti_aim.last_rand or 0
        
        if ui.get(settings.body_yaw_type) == "Jitter" then
            if anti_aim.jitterstate == 1 then
                current_yaw = ui.get(settings.yaw_left)
                current_random = anti_aim.last_left_rand or 0
            else
                current_yaw = ui.get(settings.yaw_right)
                current_random = anti_aim.last_right_rand or 0
            end
        elseif inverted > 0 then
            current_yaw = ui.get(settings.yaw_left)
            current_random = anti_aim.last_left_rand or 0
        else
            current_yaw = ui.get(settings.yaw_right)
            current_random = anti_aim.last_right_rand or 0
        end
        
        ui.set(ui_settings.manual_forward, 'On hotkey')
        ui.set(ui_settings.manual_right, 'On hotkey')
        ui.set(ui_settings.manual_left, 'On hotkey')
        ui.set(ui_settings.manual_reset, 'On hotkey')

        local current_mleft = ui.get(ui_settings.manual_left)
        local current_mright = ui.get(ui_settings.manual_right)
        local current_mforward = ui.get(ui_settings.manual_forward)
        
        if current_mleft then
            if not mleft_prev_state then
                if mleft_state then
                    mleft_state = false
                else
                    mleft_state = true
                    mright_state = false
                    mforward_state = false
                end
            end
        end
        
        if current_mright then
            if not mright_prev_state then
                if mright_state then
                    mright_state = false
                else
                    mright_state = true
                    mleft_state = false
                    mforward_state = false
                end
            end
        end
        
        if current_mforward then
            if not mforward_prev_state then
                if mforward_state then
                    mforward_state = false
                else
                    mforward_state = true
                    mleft_state = false
                    mright_state = false
                end
            end
        end

        cmd.force_defensive = settings.force_defensive
        
        if ui.get(ui_settings.manual_reset) then
            mleft_state = false
            mright_state = false
            mforward_state = false
        end

        mleft_prev_state = current_mleft
        mright_prev_state = current_mright
        mforward_prev_state = current_mforward
        
        ui.set(ui_settings.manual_left_checkbox, mleft_state)
        ui.set(ui_settings.manual_right_checkbox, mright_state)
        ui.set(ui_settings.manual_forward_checkbox, mforward_state)

        anti_aim.direction = 0
        if mleft_state then
            anti_aim.direction = -90
        elseif mright_state then
            anti_aim.direction = 90
        elseif mforward_state then
            anti_aim.direction = 180
        end

        local is_defensive = anti_aim.is_defensive_active(state_id)
        if is_defensive then
            local pitch_value, pitch_type = get_defensive_pitch(state_id)
            if pitch_value then
                ui.set(reference.pitch[1], pitch_type)
                if pitch_value > 88 then
                    pitch_value = 89
                elseif pitch_value < -88 then
                    pitch_value = -89
                end
                ui.set(reference.pitch[2], pitch_value)
            else
                if not anti_aim.on_use then
                    ui.set(reference.pitch[1], 'Down')
                else
                    ui.set(reference.pitch[1], 'Off')
                end
            end
        else
            if not anti_aim.on_use then
                ui.set(reference.pitch[1], 'Down')
            else
                ui.set(reference.pitch[1], 'Off')
            end
        end

        ui.set(reference.fakelag[1], ui.get(ui_settings.fakelag_switch))
        ui.set(reference.fakelag[2], 'Always on')
        ui.set(reference.fakelag_amount, ui.get(ui_settings.fakelag_amount_combobox))
        ui.set(reference.fakelag_variance, ui.get(ui_settings.fakelag_variance_slider))
        ui.set(reference.fakelag_limit, ui.get(ui_settings.fakelag_limit_slider))

        anti_aim.final_yaw = set_yaw_jitter_type(state_id, ui.get(settings.yaw_jitter_offset), current_yaw + current_random + anti_aim.last_rand)
        if utility.contains(settings.options, 'Avoid Overlap') then
            local overlap_threshold = 25
            local current_body_yaw = ui.get(reference.body_yaw[2]) or 0
            
            if math.abs(anti_aim.final_yaw - current_body_yaw) < overlap_threshold then
                local adjustment = overlap_threshold - math.abs(anti_aim.final_yaw - current_body_yaw)
                if anti_aim.final_yaw > current_body_yaw then
                    anti_aim.final_yaw = anti_aim.final_yaw + adjustment
                else
                    anti_aim.final_yaw = anti_aim.final_yaw - adjustment
                end
                
                anti_aim.final_yaw = utility.normalize_angle(anti_aim.final_yaw)
                
                if not (anti_aim.direction == -90 or anti_aim.direction == 90 or anti_aim.direction == 180) then
                    ui.set(reference.yaw[2], utility.normalize_angle(anti_aim.final_yaw) / 2)
                end
            end
        end

        if anti_aim.direction == -90 or anti_aim.direction == 90 or anti_aim.direction == 180 and not anti_aim.on_use then
            ui.set(reference.yaw[1], '180')
            if utility.contains(ui_settings.tweaks, 'Off jitter on manual') then
                ui.set(reference.yaw[2], 0)
                anti_aim.final_yaw = 0   
            end
            ui.set(reference.yaw[2], utility.normalize_angle(anti_aim.direction + (anti_aim.final_yaw / 2)))
        else
            ui.set(reference.yaw_base, ui.get(settings.yaw_base))
            ui.set(reference.yaw[1], '180')
            if not is_defensive then
                ui.set(reference.yaw[2], utility.normalize_angle(anti_aim.final_yaw) / (state_id ~= 9 and 2 or 1))
            else
                ui.set(reference.yaw[2], utility.normalize_angle(anti_aim.final_yaw))
            end
        end
        
        set_desync(state_id)
        if utility.contains(settings.options, 'Smart hide real yaw') then
            local local_player = entity.get_local_player()
            if local_player then
                local velocity = entity.get_prop(local_player, "m_vecVelocity")
                local speed = vector(velocity):length()
                local current_body_yaw = ui.get(reference.body_yaw[2]) or 0
                local strength = ui.get(settings.smart_hide_strength) / 100
                
                local current_side = current_body_yaw >= 0 and 1 or -1
                local original_body_yaw = ui.get(settings.body_yaw_value) or 0
                
                if ui.get(settings.body_checkbox) then
                    original_body_yaw = original_body_yaw + utility.random_int(0, ui.get(settings.body_yaw_value_random))
                end
                
                if speed > 150 then
                    local desync_factor = math.min(1.0, 1.0 - ((speed - 150) / 100))
                    strength = strength * desync_factor
                elseif speed > 30 and speed <= 150 then
                    local desync_factor = math.min(1.0, 1.0 - ((speed - 30) / 120))
                    strength = strength * desync_factor
                end
                
                if not anti_aim.is_on_ground then
                    strength = strength * 0.5
                end
                
                local hidden_yaw = original_body_yaw * (1 - strength)
                
                local adaptive_hidden_yaw
                
                if math.abs(original_body_yaw) < 58 then
                    adaptive_hidden_yaw = hidden_yaw
                else
                    adaptive_hidden_yaw = original_body_yaw * (1 - strength * 1.5)
                end
                
                adaptive_hidden_yaw = utility.normalize_angle(adaptive_hidden_yaw)
                adaptive_hidden_yaw = utility.clamp(adaptive_hidden_yaw, -58, 58)
                
                ui.set(reference.body_yaw[2], adaptive_hidden_yaw)
            end
        end
        
        if ui.get(settings.anti_brute_force_enabled) then
            local tick = globals.tickcount()
            local brute_protection_interval = ui.get(settings.anti_brute_force_reset_delay)
            local miss_threshold = ui.get(settings.anti_brute_force_miss_threshold)
            local strength = ui.get(settings.anti_brute_force_strength) / 100
            local mode = ui.get(settings.anti_brute_force_mode)
            local jitter_strength = ui.get(settings.anti_brute_force_jitter_strength) / 100
            local yaw_range = ui.get(settings.anti_brute_force_yaw_range)
            
            local players = entity.get_players(true)
            local should_apply_brute = false
            local total_misses = 0
            
            if players then
                for _, player in ipairs(players) do
                    if entity.is_alive(player) then
                        local player_index = player
                        if not miss_tracker[player_index] then
                            miss_tracker[player_index] = {miss_count = 0, last_miss_tick = 0, hit_count = 0}
                        end
                        
                        if tick - miss_tracker[player_index].last_miss_tick > brute_protection_interval then
                            miss_tracker[player_index].miss_count = 0
                            miss_tracker[player_index].hit_count = 0
                        end
                        
                        if miss_tracker[player_index].miss_count >= miss_threshold and 
                        tick - miss_tracker[player_index].last_miss_tick < brute_protection_interval then
                            should_apply_brute = true
                            total_misses = total_misses + miss_tracker[player_index].miss_count
                        end
                    end
                end
            end
            
            if should_apply_brute then
                local current_time = globals.curtime()
                local brute_delay = 0.5 * (1 / strength)
                
                if mode == "Smart" then
                    local intensity = math.min(total_misses / 10, 1.0)
                    local adaptive_range = yaw_range * intensity
                    
                    if current_time - last_brute_tick > brute_delay then
                        local sequence_index = math.floor((tick / 16) % #brute_sequence) + 1
                        local brute_offset = brute_sequence[sequence_index] * adaptive_range / 60
                        
                        local current_yaw = ui.get(reference.yaw[2]) or 0
                        local new_yaw = utility.normalize_angle(current_yaw + brute_offset)
                        ui.set(reference.yaw[2], new_yaw)
                        
                        if jitter_strength > 0 then
                            local jitter_offset = utility.random_int(-yaw_range/2, yaw_range/2) * jitter_strength
                            ui.set(reference.body_yaw[2], utility.normalize_angle((ui.get(reference.body_yaw[2]) or 0) + jitter_offset) / 2)
                        end
                        
                        last_brute_tick = current_time
                        brute_reset_tick = tick + brute_protection_interval
                    end
                    
                elseif mode == "Aggressive" then
                    if current_time - last_brute_tick > brute_delay * 0.5 then
                        local random_offset = utility.random_int(-yaw_range, yaw_range)
                        local current_yaw = ui.get(reference.yaw[2]) or 0
                        local new_yaw = utility.normalize_angle(current_yaw + random_offset)
                        ui.set(reference.yaw[2], new_yaw / 2)
                        
                        if jitter_strength > 0 then
                            ui.set(reference.body_yaw[2], utility.random_int(-58, 58))
                        end
                        
                        last_brute_tick = current_time
                        brute_reset_tick = tick + brute_protection_interval / 2
                    end
                    
                elseif mode == "Passive" then
                    if current_time - last_brute_tick > brute_delay * 2 then
                        local small_offset = utility.random_int(-yaw_range/3, yaw_range/3)
                        local current_yaw = ui.get(reference.yaw[2]) or 0
                        local new_yaw = utility.normalize_angle(current_yaw + small_offset)
                        ui.set(reference.yaw[2], new_yaw / 2)
                        
                        last_brute_tick = current_time
                        brute_reset_tick = tick + brute_protection_interval
                    end
                    
                elseif mode == "Adaptive" then
                    local velocity = vector(entity.get_prop(entity.get_local_player(), "m_vecVelocity")):length()
                    local speed_factor = math.min(velocity / 250, 1.0)
                    
                    if current_time - last_brute_tick > brute_delay * (1 + speed_factor) then
                        local adaptive_offset = brute_sequence[brute_index] * yaw_range / 60 * (1 - speed_factor * 0.5)
                        local current_yaw = ui.get(reference.yaw[2]) or 0
                        local new_yaw = utility.normalize_angle(current_yaw + adaptive_offset)
                        ui.set(reference.yaw[2], new_yaw / 2)
                        
                        brute_index = brute_index + 1
                        if brute_index > #brute_sequence then
                            brute_index = 1
                        end
                        
                        last_brute_tick = current_time
                        brute_reset_tick = tick + brute_protection_interval
                    end
                end
                
            elseif brute_reset_tick > 0 and tick > brute_reset_tick then
                local original_yaw = 0
                if anti_aim.jitterstate == 1 then
                    original_yaw = ui.get(settings.yaw_left) or 0
                else
                    original_yaw = ui.get(settings.yaw_right) or 0
                end
                
                ui.set(reference.yaw[2], utility.normalize_angle(original_yaw) / 2)
                brute_index = 1
                brute_reset_tick = 0
            end
            
            if vector(entity.get_prop(entity.get_local_player(), "m_vecVelocity")):length() < 5 then
                local standing_time = tick % 64
                if standing_time > 48 then
                    local current_desync = ui.get(reference.body_yaw[2]) or 0
                    local jitter_factor = (standing_time - 48) / 16
                    local extra_desync = current_desync * (0.5 + jitter_factor * jitter_strength)
                    ui.set(reference.body_yaw[2], utility.normalize_angle(extra_desync))
                end
            end
        end

        if ui.get(ui_settings.safe_head_in_air) and 
           (cmd.in_jump == 1 or bit.band(entity_get_prop(self, 'm_fFlags'), 1) == 0) and 
           entity_get_prop(self, 'm_flDuckAmount') > 0.8 and 
           not (anti_aim.direction == -90 or anti_aim.direction == 90 or anti_aim.direction == 180) and not anti_aim.on_use then
            
            local weapon_class = entity.get_classname(entity_get_player_weapon(self))
            if weapon_class == 'CKnife' or weapon_class == 'CWeaponTaser' then
                ui.set(reference.pitch[1], 'Down')
                ui.set(reference.yaw[1], '180')
                ui.set(reference.yaw[2], 0)
                ui.set(reference.yaw_jitter[1], 'Off')
                ui.set(reference.body_yaw[1], 'Off')
                ui.set(reference.roll, 0)
            end
        end
        if ui.get(ui_settings.avoid_backstab) then
            local players = entity.get_players(true)
            if players ~= nil then
                for i, enemy in ipairs(players) do
                    if entity.is_alive(enemy) then
                        local enemy_weapon = entity.get_player_weapon(enemy)
                        if enemy_weapon ~= nil then
                            local weapon_classname = entity.get_classname(enemy_weapon)
                            if weapon_classname == 'CKnife' then
                                local self_origin = vector(entity_get_prop(entity.get_local_player(), 'm_vecOrigin'))
                                local enemy_origin = vector(entity_get_prop(enemy, 'm_vecOrigin'))
                                local distance = self_origin:dist(enemy_origin)
                                if distance < 250 then
                                    ui.set(reference.yaw[1], '180')
                                    ui.set(reference.yaw[2], 180)
                                end
                            end
                        end
                    end
                end
            end
        end
        
        
        
        local freestanding_state_id = 1
        if cmd.in_jump == 1 or bit.band(entity_get_prop(self, 'm_fFlags'), 1) == 0 then
            freestanding_state_id = 5
        elseif (entity_get_prop(self, 'm_flDuckAmount') > 0.8 or ui.get(reference.duck_peek_assist)) and 
               bit.band(entity_get_prop(self, 'm_fFlags'), 1) ~= 0 then
            freestanding_state_id = 4
        elseif bit.band(entity_get_prop(self, 'm_fFlags'), 1) ~= 0 and 
               vector(entity_get_prop(self, 'm_vecVelocity')):length() > 2 and 
               (ui.get(reference.slow_motion[1]) and ui.get(reference.slow_motion[2])) == true then
            freestanding_state_id = 3
        elseif bit.band(entity_get_prop(self, 'm_fFlags'), 1) ~= 0 and 
               vector(entity_get_prop(self, 'm_vecVelocity')):length() > 2 and 
               (ui.get(reference.slow_motion[1]) and ui.get(reference.slow_motion[2])) == false then
            freestanding_state_id = 2
        end
        
        if ui.get(ui_settings.freestanding) and 
           ((utility.contains(ui_settings.freestanding_conditions, 'Standing') and freestanding_state_id == 1) or 
            (utility.contains(ui_settings.freestanding_conditions, 'Moving') and freestanding_state_id == 2) or 
            (utility.contains(ui_settings.freestanding_conditions, 'Slow motion') and freestanding_state_id == 3) or 
            (utility.contains(ui_settings.freestanding_conditions, 'Crouching') and freestanding_state_id == 4) or 
            (utility.contains(ui_settings.freestanding_conditions, 'In air') and freestanding_state_id == 5)) and 
           not (anti_aim.direction == -90 or anti_aim.direction == 90 or anti_aim.direction == 180) and not anti_aim.on_use then
            
            ui.set(reference.freestanding[1], true)
            ui.set(reference.freestanding[2], 'Always on')
            
            if utility.contains(ui_settings.tweaks, 'Off jitter while freestanding') then
                ui.set(reference.yaw[1], '180')
                ui.set(reference.yaw[2], 0)
                ui.set(reference.yaw_jitter[1], 'Off')
                ui.set(reference.body_yaw[1], 'Opposite')
                ui.set(reference.body_yaw[2], 0)
                ui.set(reference.freestanding_body_yaw, true)
            end
        else
            ui.set(reference.freestanding[1], false)
            ui.set(reference.freestanding[2], 'On hotkey')
        end
        
        ui.set(reference.edge_yaw, ui.get(ui_settings.edge_yaw))
        
        anti_aim.is_on_ground = cmd.in_jump == 0
    end
    client.set_event_callback("aim_miss", function(e)
        if e.target and entity.is_alive(e.target) then
            local target_index = e.target
            if not miss_tracker[target_index] then
                miss_tracker[target_index] = {miss_count = 0, last_miss_tick = 0}
            end
            
            miss_tracker[target_index].miss_count = miss_tracker[target_index].miss_count + 1
            miss_tracker[target_index].last_miss_tick = globals.tickcount()
            
            -- client.color_log(255, 100, 100, string.format("[Anti-Brute] Miss from player %d, count: %d", target_index, miss_tracker[target_index].miss_count))
        end
    end)

    client.set_event_callback("player_death", function(e)
        local victim = client.userid_to_entindex(e.userid)
        if victim and miss_tracker[victim] then
            miss_tracker[victim] = nil
        end
    end)

    client.set_event_callback("round_start", function()
        miss_tracker = {}
        brute_index = 1
        last_brute_tick = 0
        brute_reset_tick = 0
    end)
    local warmup do
        warmup = { }
        function warmup.on_setup_command()
            if entity.get_local_player() == nil then return end
            
            local gamerulesproxy = entity.get_all("CCSGameRulesProxy")[1]
            local warmup_period = entity.get_prop(gamerulesproxy, "m_bWarmupPeriod")
            
            if ui.get(ui_settings.warmup_disabler) and warmup_period == 1 then
                ui.set(reference.body_yaw[1], 'Off')
                ui.set(reference.yaw[2], math.random(-180, 180))
                ui.set(reference.yaw_jitter[1], 'Random')
                ui.set(reference.pitch[1], 'Off')
            end
        end
    end
    
    anti_aim.warmup = warmup
end

client.set_event_callback("setup_command", anti_aim.setup_command)
client.set_event_callback("setup_command", anti_aim.warmup.on_setup_command)


local visuals do
    visuals = { }
    local console_filter do
        console_filter = {}
        
        function console_filter.on_toggle()
            cvar.con_filter_text:set_string("cool text")
            cvar.con_filter_enable:set_int(1)
        end
        
        ui.set_callback(ui_settings.console_filter, console_filter.on_toggle)
    end
    visuals.console_filter = console_filter
    local damage_indicator do
        damage_indicator = {}
        
        local current_damage = 0
        local target_damage = 0
        local animation_start_time = 0
        local animation_duration = 0.5
        
        function damage_indicator.on_paint()
            local width, height = client.screen_size()
            if not entity.is_alive(entity_get_local_player()) then return end
            if not ui.get(ui_settings.minimumdamage) then
                return
            end
            local flags = ''
            if ui.get(ui_settings.minimumdamage_font) == 'Default' then
                flags = 'l'
            elseif ui.get(ui_settings.minimumdamage_font) == 'Bold' then
                flags = 'lb'
            elseif ui.get(ui_settings.minimumdamage_font) == 'Small' then
                flags = 'l-'
            end


            local min_damage = ui.get(reference.min_damage)
            local override_enabled = ui.get(reference.min_damage_override[2])
            local override_damage = ui.get(reference.min_damage_override[3])
            
            local new_target_damage
            if override_enabled then
                new_target_damage = override_damage
            else
                new_target_damage = min_damage
            end
            
            if new_target_damage ~= target_damage then
                animation_start_time = globals.realtime()
                target_damage = new_target_damage
            end
            
            local elapsed = globals.realtime() - animation_start_time
            local progress = math.min(elapsed / animation_duration, 1.0)
            
            local ease_progress = progress * progress * (3 - 2 * progress)

            current_damage = current_damage + (target_damage - current_damage) * ease_progress

            renderer.text(
                width / 2 + 5, 
                height / 2 - 15, 
                255, 255, 255, 255, 
                flags, 0, 
                string.format("%d", math.floor(current_damage + 0.5))
            )
        end
    end
    visuals.damage_indicator = damage_indicator
    local aspect_ratio do
        aspect_ratio = {}
        
        function aspect_ratio.on_paint()
            cvar.r_aspectratio:set_float(ui.get(ui_settings.aspectratio)/100)
        end
    end
    visuals.aspect_ratio = aspect_ratio
    local third_person do
        third_person = {}
        
        local function tpdistance()
            client.exec("cam_idealdist ", ui.get(ui_settings.thirdperson))
        end
        client.set_event_callback('paint', tpdistance)
    end
    local fps_boost do
        local cvars = {
            {name = "cl_disablefreezecam", value = 1, default = 0},
            {name = "cl_disablehtmlmotd", value = 1, default = 0},
            {name = "r_dynamic", value = 0, default = 1},
            {name = "r_3dsky", value = 0, default = 1},
            {name = "r_shadows", value = 0, default = 1},
            {name = "cl_csm_static_prop_shadows", value = 0, default = 1},
            {name = "cl_csm_world_shadows", value = 0, default = 1},
            {name = "cl_foot_contact_shadows", value = 0, default = 1},
            {name = "cl_csm_viewmodel_shadows", value = 0, default = 1},
            {name = "cl_csm_rope_shadows", value = 0, default = 1},
            {name = "cl_csm_sprite_shadows", value = 0, default = 1},
            {name = "cl_freezecampanel_position_dynamic", value = 0, default = 1},
            {name = "cl_freezecameffects_showholiday", value = 0, default = 1},
            {name = "cl_showhelp", value = 0, default = 1},
            {name = "cl_autohelp", value = 0, default = 1},
            {name = "mat_postprocess_enable", value = 0, default = 1},
            {name = "fog_enable_water_fog", value = 0, default = 1},
            {name = "gameinstructor_enable", value = 0, default = 1},
            {name = "cl_csm_world_shadows_in_viewmodelcascade", value = 0, default = 1},
            {name = "cl_disable_ragdolls", value = 0, default = 0}
        }

        function set_fps_boost()
            for _, cvar_data in ipairs(cvars) do
                if utility.contains(ui_settings.fps_boost, cvar_data.name) then
                    cvar[cvar_data.name]:set_float(cvar_data.value)
                else
                    cvar[cvar_data.name]:set_float(cvar_data.default)
                end
            end
        end
        ui.set_callback(ui_settings.fps_boost, set_fps_boost)
    end
    
    local watermark do
        watermark = {}
        
        function watermark.animate_text(time, string, r, g, b, a, r2, g2, b2, a2)
            local m, n, o, p = r2, g2, b2, a2
            local t_out = {}
            local l = string:len() - 1
            local r_add = (m - r)
            local g_add = (n - g)
            local b_add = (o - b)
            local a_add = (p - a)

            for i = 1, #string do
                local iter = (i - 1) / (#string - 1) + time
                t_out[#t_out + 1] = "\a" .. utility.rgba_to_hex(r + r_add * math.abs(math.cos(iter)), g + g_add * math.abs(math.cos(iter)), b + b_add * math.abs(math.cos(iter)), a + a_add * math.abs(math.cos(iter)))
                t_out[#t_out + 1] = string:sub(i, i)
            end

            return table.concat(t_out)
        end
        
        function watermark.animate_color(time, r, g, b, a, r2, g2, b2, a2)
            local finished = false
            local newR, newG, newB, newA = r, g, b, a
            if newR == r2 and newG == g2 and newB == b2 and newA == a2 then
                newR = utility.lerp(r, r2, time)
                newG = utility.lerp(g, g2, time)
                newB = utility.lerp(b, b2, time)
                newA = utility.lerp(a, a2, time)
            else
                newR = utility.lerp(r2, r, time)
                newG = utility.lerp(g2, g, time)
                newB = utility.lerp(b2, b, time)
                newA = utility.lerp(a2, a, time)
            end
            return newR, newG, newB, newA
        end
        function watermark.animation(check, start_val, end_val, speed)
            if check then
                return math.max(start_val + (end_val - start_val) * globals.frametime() * speed, 0)
            else
                return math.max(start_val - (end_val + start_val) * globals.frametime() * speed / 2, 0)
            end
        end
        
        local x_add_lua = 0
        local x_add_stance = 0
        local x_add_dtfshs = 0
        local x_add_baim = 0
        
        function watermark.on_paint()
            local me = entity_get_local_player()
            if me == nil then return end
            
            local watermarkpos = ui.get(ui_settings.watermarkpos)
            local width, height = client.screen_size()
            local color_watermark = {ui.get(ui_settings.watermark_color)}
            local r2, g2, b2, a2 = color_watermark[1], color_watermark[2], color_watermark[3], color_watermark[4]
            local color_ui = { ui.get(ui_settings.indicators_color_picker) }
            local highlight_fraction = (globals.realtime() / 2 % 1.2 * 2) - 1.2
            local output = ""
            local indicators_output = ""
            local r, g, b, a = ui.get(reference.menu_color[1])
            local hex_color = utility.rgba_to_hex(r, g, b, a)
            local text_to_draw = ui.get(ui_settings.watermark_name) or "T E N N E Z Z A"
            local text_to_draw_indicators = "TENNEZZA"
            local x = width / 2
            local y = height / 2
            
            for idx = 1, #text_to_draw do
                local character = text_to_draw:sub(idx, idx)
                local character_fraction = idx / #text_to_draw
                local r1, g1, b1, a1 = 255, 255, 255, 255
                local r11, g11, b11, a11 = 255, 255, 255, 255
                local highlight_delta = (character_fraction - highlight_fraction)
                
                if highlight_delta >= 0 and highlight_delta <= 1.4 then
                    if highlight_delta > 0.7 then
                        highlight_delta = 1.4 - highlight_delta
                    end
                    
                    local r_fraction, g_fraction, b_fraction, a_fraction = r2 - r1, g2 - g1, b2 - b1, a2 - a1
                    r1 = r1 + r_fraction * highlight_delta / 0.8
                    g1 = g1 + g_fraction * highlight_delta / 0.8
                    b1 = b1 + b_fraction * highlight_delta / 0.8
                    a1 = a1 + a_fraction * highlight_delta / 0.8
                    local r_fraction_1, g_fraction_1, b_fraction_1, a_fraction_1 = color_ui[1] - r11, color_ui[2] - g11, color_ui[3] - b11, color_ui[4] - a11
                    r11 = r11 + r_fraction_1 * highlight_delta / 0.8
                    g11 = g11 + g_fraction_1 * highlight_delta / 0.8
                    b11 = b11 + b_fraction_1 * highlight_delta / 0.8
                    a11 = a11 + a_fraction_1 * highlight_delta / 0.8
                end
                
                output = output .. ('\a%02x%02x%02x%02x%s'):format(r1, g1, b1, a1, text_to_draw:sub(idx, idx))
                if ui.get(ui_settings.indicators) then
                    indicators_output = indicators_output .. ('\a%02x%02x%02x%02x%s'):format(r11, g11, b11, a11, text_to_draw_indicators:sub(idx, idx))
                end
            end
            
            if ui.get(ui_settings.indicators) then
                local scoped = entity.get_prop(entity_get_local_player(), "m_bIsScoped") == 1
                local exploit_data = exploit.get()
                local charge = exploit_data.shift
                local text_width = renderer.measure_text("", anti_aim.current_stance)
                local dtfshs_text = ''
                
                x_add_lua = watermark.animation(scoped, x_add_lua, 18, 10) or 0
                if anti_aim.current_stance == 'AIRCROUCH' then
                    x_add_stance = watermark.animation(scoped, x_add_stance, text_width * 0.4 + 1, 10) or 0
                else
                    x_add_stance = watermark.animation(scoped, x_add_stance, text_width * 0.4, 10) or 0
                end
                x_add_baim = watermark.animation(scoped, x_add_baim, 10, 10) or 0
                local add_y = 0
                
                renderer.text(x + x_add_lua, y + 20 + add_y, 255, 255, 255, 255, "c-", 0, indicators_output)
                add_y = add_y + 10
                if utility.contains(ui_settings.indicators_exclude, 'Stances') then
                    renderer.text(x + x_add_stance, y + 20 + add_y, 255, 255, 255, 255, "c-", 0, anti_aim.current_stance)
                    add_y = add_y + 10
                end
                local dtfshs_n = 0
                if anti_aim.is_double_tap_active() and utility.contains(ui_settings.indicators_exclude, 'Double Tap') then
                    if not charge then
                        dtfshs_text = dtfshs_text .. '\aff3434FFDT'
                        dtfshs_n = dtfshs_n + 1
                    else
                        dtfshs_text = dtfshs_text .. '\aFFFFFFFFDT'
                        dtfshs_n = dtfshs_n + 1
                    end
                elseif utility.contains(ui_settings.indicators_exclude, 'Double Tap') then
                    dtfshs_text = dtfshs_text .. '\a8f8f8fFFDT'
                    dtfshs_n = dtfshs_n + 1
                end

                
                if anti_aim.is_on_shot_antiaim_active() and utility.contains(ui_settings.indicators_exclude, 'Hide Shots') then
                    dtfshs_text = dtfshs_text .. '\aFFFFFFFFHS'
                    dtfshs_n = dtfshs_n + 1
                elseif utility.contains(ui_settings.indicators_exclude, 'Hide Shots') then
                    dtfshs_text = dtfshs_text .. '\a8f8f8fFFHS'
                    dtfshs_n = dtfshs_n + 1
                end

                if ui.get(reference.freestanding[1]) and ui.get(reference.freestanding[2]) and utility.contains(ui_settings.indicators_exclude, 'Freestanding') then
                    dtfshs_text = dtfshs_text .. '\aFFFFFFFFFS'
                    dtfshs_n = dtfshs_n + 1
                elseif utility.contains(ui_settings.indicators_exclude, 'Freestanding') then
                    dtfshs_text = dtfshs_text .. '\a8f8f8fFFFS'
                    dtfshs_n = dtfshs_n + 1
                end
                if dtfshs_n == 1 then
                    x_add_dtfshs = watermark.animation(scoped, x_add_dtfshs, 6, 10) or 0
                elseif dtfshs_n == 2 then
                    x_add_dtfshs = watermark.animation(scoped, x_add_dtfshs, 10, 10) or 0
                else
                    x_add_dtfshs = watermark.animation(scoped, x_add_dtfshs, 16, 10) or 0
                end
                renderer.text(x + x_add_dtfshs, y + 20 + add_y, 255, 255, 255, 255, "c-", 0, dtfshs_text)
                if utility.contains(ui_settings.indicators_exclude, 'Freestanding') or utility.contains(ui_settings.indicators_exclude, 'Hide Shots') or utility.contains(ui_settings.indicators_exclude, 'Double Tap') then
                    add_y = add_y + 10
                end
                if utility.contains(ui_settings.indicators_exclude, 'Body Aim') then
                    if ui.get(reference.force_body_aim) then
                        renderer.text(x + x_add_baim, y + 20 + add_y, 255, 255, 255, 255, "c-", 0, 'BAIM')
                    else
                        renderer.text(x + x_add_baim, y + 20 + add_y, 150, 150, 150, 255, "c-", 0, 'BAIM')
                    end
                    add_y = add_y + 10
                end
            end


            if ui.get(ui_settings.userwatermark) then
                if ui.get(ui_settings.pos1) < width / 2 then
                    renderer.text(ui.get(ui_settings.pos1), ui.get(ui_settings.pos2), r, g, b, a, "lb", 0, ' ' .. script_info.username)
                    renderer.text(ui.get(ui_settings.pos1), ui.get(ui_settings.pos2) + 10, 242, 240, 255,255, "lb", 0, 'Build: \a66c47bFFgamesense')
                    renderer.text(ui.get(ui_settings.pos1), ui.get(ui_settings.pos2) + 20, 242, 240, 255, 255, "lb", 0, 'Script: ' .. script_info.name)
                else
                    renderer.text(ui.get(ui_settings.pos1), ui.get(ui_settings.pos2), r, g, b, a, "rb", 0, ' ' .. script_info.username)
                    renderer.text(ui.get(ui_settings.pos1), ui.get(ui_settings.pos2) + 10, 242, 240, 255,255, "rb", 0, 'Build: \a66c47bFFgamesense')
                    renderer.text(ui.get(ui_settings.pos1), ui.get(ui_settings.pos2) + 20, 242, 240, 255, 255, "rb", 0, 'Script: ' .. script_info.name)
                end
            end
            local flags = ''
            if ui.get(ui_settings.watermarkpos_font) == 'Default' then
                flags = 'c'
            elseif ui.get(ui_settings.watermarkpos_font) == 'Bold' then
                flags = 'cb'
            elseif ui.get(ui_settings.watermarkpos_font) == 'Small' then
                flags = 'c-'
            end

            
            if watermarkpos == 'Top' then
            renderer.text(width / 2, height - (height - 100), 87, 235, 61, 255, flags, 0, output)
            elseif watermarkpos == 'Bottom' then
                renderer.text(width / 2, height - 15, 87, 235, 61, 255, flags, 0, output)
            elseif watermarkpos == 'Right' then
                renderer.text(width - 75, height / 2, 87, 235, 61, 255, flags, 0, output)
            elseif watermarkpos == 'Left' then
                renderer.text(width - (width - 75), height / 2, 87, 235, 61, 255, flags, 0, output)
            end
        end
    end
    visuals.watermark = watermark
    local animation do
        animation = {
            base_speed = 0.095,
            values = {}
        }
        
        function animation.animate(key, target, speed, start)
            speed = speed or animation.base_speed
            animation.values[key] = animation.values[key] or start or 0
            animation.values[key] = utility.smooth_lerp(animation.values[key], target, speed)
            return animation.values[key]
        end
        
        function animation.animate_camera(camera_data)
            if not camera_data then return end
            
            local local_player = entity_get_local_player()
            if not local_player or not entity.is_alive(local_player) then
                return
            end

            local zoom_anim_enabled = ui.get(ui_settings.zoom_animation)
            local override_fov_ref = ui.reference("Misc", "Miscellaneous", "Override FOV")
            local override_zoom_fov_ref = ui.reference("Misc", "Miscellaneous", "Override zoom FOV")
            local fov_value = ui.get(override_fov_ref)
            local zoom_fov_value = ui.get(override_zoom_fov_ref) * 0.5
            
            local weapon = entity_get_player_weapon(local_player)
            if not weapon then return end
            
            local zoom_level = entity_get_prop(weapon, "m_zoomLevel")
            local is_scoped = entity_get_prop(local_player, "m_bIsScoped") == 1

            if zoom_anim_enabled then
                local zoom_factor = is_scoped and (zoom_level == 1 and 1 or 2) or 0
                local zoom_progress = animation.animate("zoom_anim", zoom_factor, 0.07)
                local fov_progress = animation.animate("fov_anim", fov_value, 0.07)
                
                camera_data.fov = fov_progress - zoom_fov_value * zoom_progress
            end

            local cam_anim_values = ui.get(ui_settings.camera_animation) or {}
            local is_anim_selected = {}
            for _, value in ipairs(cam_anim_values) do
                is_anim_selected[value] = true
            end

            if is_anim_selected["Yaw"] then
                camera_data.yaw = animation.animate("cam_yaw", camera_data.yaw, 0.07)
            end
            
            if is_anim_selected["Pitch"] then
                camera_data.pitch = animation.animate("cam_pitch", camera_data.pitch, 0.07)
            end
            
            if is_anim_selected["X"] then
                camera_data.x = animation.animate("cam_x", camera_data.x, 0.07)
            end
            
            if is_anim_selected["Y"] then
                camera_data.y = animation.animate("cam_y", camera_data.y, 0.07)
            end
            
            if is_anim_selected["Z"] then
                camera_data.z = animation.animate("cam_z", camera_data.z, 0.07)
            end
        end
    end
    visuals.animation = animation
    local hit_marker do
        hit_marker = {}
        
        local hit_marker_queue = {}
        
        function hit_marker.on_aim_fire(c)
            hit_marker_queue[globals.tickcount()] = {c.x, c.y, c.z, globals.curtime() + 2}
        end
        
        function hit_marker.on_paint()
            if not ui.get(ui_settings.hitmarker) then return end
            
            for tick, data in pairs(hit_marker_queue) do
                if globals.curtime() <= data[4] then
                    local x1, y1 = renderer.world_to_screen(data[1], data[2], data[3])
                    if x1 ~= nil and y1 ~= nil then
                        renderer.line(x1 - 6, y1, x1 + 6, y1, 34, 214, 132, 255)
                        renderer.line(x1, y1 - 6, x1, y1 + 6, 108, 182, 203, 255)
                    end
                end
            end
        end
        
        function hit_marker.clear()
            hit_marker_queue = {}
        end
    end
    visuals.hit_marker = hit_marker
    local anim_breaker do
        anim_breaker = {}
        
        local E_POSE_PARAMETERS = {
            STRAFE_YAW = 0,
            STAND = 1,
            LEAN_YAW = 2,
            SPEED = 3,
            LADDER_YAW = 4,
            LADDER_SPEED = 5,
            JUMP_FALL = 6,
            MOVE_YAW = 7,
            MOVE_BLEND_CROUCH = 8,
            MOVE_BLEND_WALK = 9,
            MOVE_BLEND_RUN = 10,
            BODY_YAW = 11,
            BODY_PITCH = 12,
            AIM_BLEND_STAND_IDLE = 13,
            AIM_BLEND_STAND_WALK = 14,
            AIM_BLEND_STAND_RUN = 14,
            AIM_BLEND_CROUCH_IDLE = 16,
            AIM_BLEND_CROUCH_WALK = 17,
            DEATH_YAW = 18
        }
        
        function anim_breaker.pre_render()
            if ui.get(ui_settings.anim_breakerx) then
                local local_player = entity.get_local_player()
                if not entity.is_alive(local_player) then return end

                entity.set_prop(local_player, "m_flPoseParameter", utility.random_float(0.8/10, 1), 0)
                ui.set(reference.leg_movement, utility.random_int(1, 2) == 1 and "Off" or "Always slide")
            end
        end
        
        function anim_breaker.setup_command(e)
            if not ui.get(ui_settings.anim_breakerx) then return end

            local local_player = entity.get_local_player()
            if not entity.is_alive(local_player) then return end

            ui.set(reference.leg_movement, 'Always slide')
        end
        
        function anim_breaker.on_pre_render()
            local self = entity.get_local_player()
            if not self or not entity.is_alive(self) then
                return
            end

            local self_index = c_entity.new(self)
            local self_anim_state = self_index:get_anim_state()

            if not self_anim_state then
                return
            end

            if ui.get(ui_settings.anim_breakerx) then
                entity.set_prop(self, "m_flPoseParameter", E_POSE_PARAMETERS.STAND, globals.tickcount() % 4 > 1 and 5 / 10 or 1)
            
                local self_anim_overlay = self_index:get_anim_overlay(12)
                if not self_anim_overlay then
                    return
                end

                local x_velocity = entity.get_prop(self, "m_vecVelocity[0]")
                if math.abs(x_velocity) >= 3 then
                    self_anim_overlay.weight = 100 / 100
                end
            end
        end
        
        function anim_breaker.on_pre_render_advanced()
            local self = entity.get_local_player()
            if not self or not entity.is_alive(self) then
                return
            end

            local self_index = c_entity.new(self)
            local self_anim_state = self_index:get_anim_state()

            if not self_anim_state then
                return
            end

            if utility.contains(ui_settings.m_elements, "kangaroo") then
                entity.set_prop(entity.get_local_player(), "m_flPoseParameter", math.random(0, 10)/10, 3)
                entity.set_prop(entity.get_local_player(), "m_flPoseParameter", math.random(0, 10)/10, 7)
                entity.set_prop(entity.get_local_player(), "m_flPoseParameter", math.random(0, 10)/10, 6)
            end

            if utility.contains(ui_settings.m_elements, "airbreak") then
                entity.set_prop(self, "m_flPoseParameter", globals.tickcount() % 4 > 1 and math.random(0, 10) / 10, E_POSE_PARAMETERS.JUMP_FALL)
            end
            
            if utility.contains(ui_settings.m_elements, "earthquake") then
                local self_anim_overlay = self_index:get_anim_overlay(12)
                if not self_anim_overlay then
                    return
                end

                if globals.tickcount() % 10 > 1 then
                    self_anim_overlay.weight = utility.jitter_value() / 100
                end
            end


            if utility.contains(ui_settings.m_elements, "Pacan4ik") then
                local offset_1 = ui.get(ui_settings.legoffset1) * 0.01
                local offset_2 = ui.get(ui_settings.legoffset2) * 0.01

                local leg_movement = utility.random_int(0, 1) == 0
                    and 'Off' or 'Always slide'

                entity.set_prop(self, 'm_flPoseParameter', utility.random_float(offset_1, offset_2), 0)
                ui.set(reference.leg_movement, leg_movement)
            end

            if utility.contains(ui_settings.m_elements, "zero pitch on land") then
                if self_anim_state.hit_in_ground_animation and anti_aim.in_jump_state == false then
                    entity.set_prop(self, 'm_flPoseParameter', 0.5, 12)
                end
            end
            
            if utility.contains(ui_settings.m_elements, "static legs in air") and not anti_aim.is_on_ground then
                local weight = ui.get(ui_settings.staticlegweight)
                entity.set_prop(self, 'm_flPoseParameter', weight * 0.01, 6)
            end
        end
    end
    visuals.anim_breaker = anim_breaker
    local grenade_trail do
        grenade_trail = { }
        
        local grenade_histories = {}
        local standard_grenades_ref = ui.reference("Visuals", "Other ESP", "Grenades")
        
        local function draw_enhanced_line(x1, y1, x2, y2, r, g, b, a, thickness, glow)
            if a <= 0 then return end
            
            local final_alpha = a
            if thickness == 0 then
                final_alpha = a * 0.4
                renderer.line(x1, y1, x2, y2, r, g, b, final_alpha)
            else
                for i = 0, thickness - 1 do
                    renderer.line(x1 + i, y1, x2 + i, y2, r, g, b, a)
                end
            end

            if glow > 0 then
                for i = 1, glow do
                    local glow_a = math.floor(final_alpha * (1 - (i / glow)^0.6) * 0.15)
                    if glow_a > 0 then
                        renderer.line(x1, y1 - i, x2, y2 - i, r, g, b, glow_a)
                        renderer.line(x1, y1 + i, x2, y2 + i, r, g, b, glow_a)
                        renderer.line(x1 - i, y1, x2 - i, y2, r, g, b, glow_a)
                        renderer.line(x1 + i, y1, x2 + i, y2, r, g, b, glow_a)
                    end
                end
            end
        end
        
        function grenade_trail.on_paint()
            if not ui.get(ui_settings.grenade_trail_master) then return end

            local r, g, b, a_base = ui.get(ui_settings.grenade_trail_color)
            local thickness = ui.get(ui_settings.grenade_trail_thickness)
            local glow = ui.get(ui_settings.grenade_trail_glow)
            local max_lifetime = ui.get(ui_settings.grenade_trail_fade) / 10
            local curtime = globals.curtime()

            local classes = {
                "CBaseCSGrenadeProjectile", 
                "CSmokeGrenadeProjectile", 
                "CMolotovProjectile", 
                "CIncendiaryGrenadeProjectile", 
                "CDecoyProjectile"
            }
            
            local active_ents = {}
            for i=1, #classes do
                local found = entity.get_all(classes[i])
                if found then
                    for j=1, #found do active_ents[found[j]] = true end
                end
            end

            for ent, path in pairs(grenade_histories) do
                if active_ents[ent] then
                    local x, y, z = entity.get_prop(ent, "m_vecOrigin")
                    if x then
                        table.insert(path, {x = x, y = y, z = z, time = curtime})
                    end
                end

                if #path > 1 then
                    for i = #path, 2, -1 do
                        local p1, p2 = path[i-1], path[i]
                        local age = curtime - p1.time
                        local time_factor = 1 - (age / max_lifetime)

                        if time_factor > 0 then
                            local dynamic_alpha = math.floor(a_base * time_factor)
                            local sx1, sy1 = renderer.world_to_screen(p1.x, p1.y, p1.z)
                            local sx2, sy2 = renderer.world_to_screen(p2.x, p2.y, p2.z)

                            if sx1 and sx2 then
                                draw_enhanced_line(sx1, sy1, sx2, sy2, r, g, b, dynamic_alpha, thickness, glow)
                            end
                        else
                            table.remove(path, i-1)
                        end
                    end
                end

                if not active_ents[ent] and #path <= 1 then
                    grenade_histories[ent] = nil
                end
            end

            for ent, _ in pairs(active_ents) do
                if not grenade_histories[ent] then
                    grenade_histories[ent] = {}
                end
            end
        end
        
        function grenade_trail.on_round_start()
            grenade_histories = {}
        end
        
        function grenade_trail.manage_standard_grenades()
            if ui.get(ui_settings.grenade_trail_master) then
                ui.set(standard_grenades_ref, false)
            end
        end
        
        ui.set_callback(ui_settings.grenade_trail_master, function()
            grenade_trail.manage_standard_grenades()
        end)
    end

    visuals.grenade_trail = grenade_trail
    local custom_scope do
        custom_scope = { }
        m_alpha = 0
        
        local rotation_angle = 0
        
        local g_paint_ui = function()
            if not ui.get(ui_settings.custom_scope) then return end
            ui.set(reference.scope_overlay, true)
        end
        
        local function draw_rotated_line(x1, y1, x2, y2, r, g, b, a, center_x, center_y, angle_rad)
            local cos_a = math.cos(angle_rad)
            local sin_a = math.sin(angle_rad)
            
            local rel_x1 = x1 - center_x
            local rel_y1 = y1 - center_y
            local rel_x2 = x2 - center_x
            local rel_y2 = y2 - center_y
            
            local rot_x1 = center_x + rel_x1 * cos_a - rel_y1 * sin_a
            local rot_y1 = center_y + rel_x1 * sin_a + rel_y1 * cos_a
            local rot_x2 = center_x + rel_x2 * cos_a - rel_y2 * sin_a
            local rot_y2 = center_y + rel_x2 * sin_a + rel_y2 * cos_a
            
            renderer.line(rot_x1, rot_y1, rot_x2, rot_y2, r, g, b, a)
        end
        
        local function draw_rotated_gradient_line(x1, y1, x2, y2, r1, g1, b1, a1, r2, g2, b2, a2, 
                                                center_x, center_y, angle_rad, horizontal)
            local segments = 20
            local segment_length_x = (x2 - x1) / segments
            local segment_length_y = (y2 - y1) / segments
            
            for i = 1, segments do
                local seg_x1 = x1 + segment_length_x * (i-1)
                local seg_y1 = y1 + segment_length_y * (i-1)
                local seg_x2 = x1 + segment_length_x * i
                local seg_y2 = y1 + segment_length_y * i
                
                local progress = (i-1) / segments
                local seg_r = r1 + (r2 - r1) * progress
                local seg_g = g1 + (g2 - g1) * progress
                local seg_b = b1 + (b2 - b1) * progress
                local seg_a = a1 + (a2 - a1) * progress
                
                draw_rotated_line(seg_x1, seg_y1, seg_x2, seg_y2, 
                                seg_r, seg_g, seg_b, math.floor(seg_a), 
                                center_x, center_y, angle_rad)
            end
        end
        
        local g_paint = function()
            if not ui.get(ui_settings.custom_scope) then return end
            ui.set(reference.scope_overlay, false)
            
            local width, height = client.screen_size()
            local offset, initial_position, speed, color =
                ui.get(ui_settings.overlay_offset) * height / 1080, 
                ui.get(ui_settings.overlay_position) * height / 1080, 
                20, { ui.get(ui_settings.color_picker) }

            local me = entity_get_local_player()
            local wpn = entity_get_player_weapon(me)

            local scope_level = entity_get_prop(wpn, 'm_zoomLevel')
            local scoped = entity_get_prop(me, 'm_bIsScoped') == 1
            local resume_zoom = entity_get_prop(me, 'm_bResumeZoom') == 1

            local is_valid = entity.is_alive(me) and wpn ~= nil and scope_level ~= nil
            local act = is_valid and scope_level > 0 and scoped and not resume_zoom

            local FT = speed > 3 and globals.frametime() * speed or 1
            local alpha = easing.linear(m_alpha, 0, 1, 1)
            
            local spin_enabled = ui.get(ui_settings.scope_spin_enabled)
            local spin_speed = ui.get(ui_settings.scope_spin_speed) / 100 * 360
            local spin_direction = ui.get(ui_settings.scope_spin_direction)
            
            local center_x = width / 2
            local center_y = height / 2
            
            if spin_enabled and act then
                local direction_multiplier = 1
                if spin_direction == 'Counter-clockwise' then
                    direction_multiplier = -1
                end
                
                rotation_angle = rotation_angle + (spin_speed * globals.frametime() * direction_multiplier)
                
                rotation_angle = rotation_angle % 360
            else
                rotation_angle = 0
            end
            
            local angle_rad = math.rad(rotation_angle)
            local current_alpha = math.floor(alpha * color[4])
            
            if act and current_alpha > 0 then
                local line_length = initial_position - offset
                
                if not utility.contains(ui_settings.scope_pos, 'Left') then
                    local x1 = center_x - initial_position
                    local y1 = center_y
                    local x2 = center_x - offset
                    local y2 = center_y
                    
                    if spin_enabled then
                        draw_rotated_gradient_line(x1, y1, x2, y2, 
                            color[1], color[2], color[3], 0,
                            color[1], color[2], color[3], current_alpha,
                            center_x, center_y, angle_rad, true)
                    else
                        renderer.gradient(x1, y1, x2 - x1, 1, 
                            color[1], color[2], color[3], 0, 
                            color[1], color[2], color[3], current_alpha, 
                            true)
                    end
                end
                
                if not utility.contains(ui_settings.scope_pos, 'Right') then
                    local x1 = center_x + offset
                    local y1 = center_y
                    local x2 = center_x + initial_position
                    local y2 = center_y
                    
                    if spin_enabled then
                        draw_rotated_gradient_line(x1, y1, x2, y2, 
                            color[1], color[2], color[3], current_alpha,
                            color[1], color[2], color[3], 0,
                            center_x, center_y, angle_rad, true)
                    else
                        renderer.gradient(x1, y1, x2 - x1, 1, 
                            color[1], color[2], color[3], current_alpha, 
                            color[1], color[2], color[3], 0, 
                            true)
                    end
                end
                
                if not utility.contains(ui_settings.scope_pos, 'Top') then
                    local x1 = center_x
                    local y1 = center_y - initial_position
                    local x2 = center_x
                    local y2 = center_y - offset
                    
                    if spin_enabled then
                        draw_rotated_gradient_line(x1, y1, x2, y2, 
                            color[1], color[2], color[3], 0,
                            color[1], color[2], color[3], current_alpha,
                            center_x, center_y, angle_rad, false)
                    else
                        renderer.gradient(x1, y1, 1, y2 - y1, 
                            color[1], color[2], color[3], 0, 
                            color[1], color[2], color[3], current_alpha, 
                            false)
                    end
                end
                
                if not utility.contains(ui_settings.scope_pos, 'Bottom') then
                    local x1 = center_x
                    local y1 = center_y + offset
                    local x2 = center_x
                    local y2 = center_y + initial_position
                    
                    if spin_enabled then
                        draw_rotated_gradient_line(x1, y1, x2, y2, 
                            color[1], color[2], color[3], current_alpha,
                            color[1], color[2], color[3], 0,
                            center_x, center_y, angle_rad, false)
                    else
                        renderer.gradient(x1, y1, 1, y2 - y1, 
                            color[1], color[2], color[3], current_alpha, 
                            color[1], color[2], color[3], 0, 
                            false)
                    end
                end
                
                if spin_enabled then
                    local indicator_size = 3
                    renderer.line(center_x - indicator_size, center_y, 
                                center_x + indicator_size, center_y, 
                                255, 255, 255, math.floor(current_alpha * 0.7))
                    renderer.line(center_x, center_y - indicator_size, 
                                center_x, center_y + indicator_size, 
                                255, 255, 255, math.floor(current_alpha * 0.7))
                    
                    local arrow_size = 10
                    local arrow_angle = angle_rad + math.rad(90)
                    
                    if spin_direction == 'Counter-clockwise' then
                        arrow_angle = angle_rad - math.rad(90)
                    end
                    
                    local arrow_x = center_x + arrow_size * math.cos(arrow_angle)
                    local arrow_y = center_y + arrow_size * math.sin(arrow_angle)
                    
                end
            end
            
            m_alpha = utility.clamp(m_alpha + (act and FT or -FT), 0, 1)
        end
        
        client.set_event_callback('paint', g_paint)
        client.set_event_callback('paint_ui', g_paint_ui)
    end
end

local modern_hit_logs = {
    entries = {},
    max_entries = 15,
    display_time = 5,
    animation_speed = 0.3,
    fade_speed = 0.8,
    entry_spacing = 5,
    bg_opacity = 200,
    shadow_offset = 2,
    border_width = 1
}
local hit_logs = {
    entries = {},
    max_entries = 15,
    display_time = 5,
    animation_speed = 0.5,
    entry_spacing = 5,
    bg_opacity = 130
}
local miscellaneous do
    miscellaneous = { }
    local fast_ladder do
        fast_ladder = {}
        
        function fast_ladder.on_setup_command(cmd)
            if not ui.get(ui_settings.fastladder) then return end
            
            local pitch, yaw = client.camera_angles()
            if entity_get_prop(entity_get_local_player(), "m_MoveType") == 9 then
                cmd.yaw = math.floor(cmd.yaw + 0.5)
                cmd.roll = 0
                
                if cmd.forwardmove > 0 then
                    if pitch < 45 then
                        cmd.pitch = 89
                        cmd.in_moveright = 1
                        cmd.in_moveleft = 0
                        cmd.in_forward = 0
                        cmd.in_back = 1

                        if cmd.sidemove == 0 then
                            cmd.yaw = cmd.yaw + 90
                        end

                        if cmd.sidemove < 0 then
                            cmd.yaw = cmd.yaw + 150
                        end

                        if cmd.sidemove > 0 then
                            cmd.yaw = cmd.yaw + 30
                        end
                    end 
                end

                if cmd.forwardmove < 0 then
                    cmd.pitch = 89
                    cmd.in_moveleft = 1
                    cmd.in_moveright = 0
                    cmd.in_forward = 1
                    cmd.in_back = 0
                    if cmd.sidemove == 0 then
                        cmd.yaw = cmd.yaw + 90
                    end
                    if cmd.sidemove > 0 then
                        cmd.yaw = cmd.yaw + 150
                    end
                    if cmd.sidemove < 0 then
                        cmd.yaw = cmd.yaw + 30
                    end
                end
            end
        end
    end
    miscellaneous.fast_ladder = fast_ladder
    local off_dt_on_hs do
        off_dt_on_hs = {}
        
        function off_dt_on_hs.on_paint()
            if not ui.get(ui_settings.offdtonhs) then return end
            if (ui.get(reference.on_shot_anti_aim[1]) and ui.get(reference.on_shot_anti_aim[2])) then
                ui.set(reference.double_tap[1], false)
            else
                ui.set(reference.double_tap[1], true)
            end
        end
    end
    miscellaneous.off_dt_on_hs = off_dt_on_hs
    local autostop_fix do
        autostop_fix = {}
        local autostop = {ui.reference("RAGE", "Aimbot", "Quick stop")}
        local ref_autostop = autostop[1]

        local enable_fix = ui_settings.autostop_fix

        local should_stop_early = false
        local early_stop_time = 0
        local last_enemy_distance = 9999
        local last_fire_time = 0

        local function get_local_velocity()
            local local_player = entity_get_local_player()
            if local_player == nil then return 0 end
            
            local velocity_x = entity_get_prop(local_player, "m_vecVelocity[0]") or 0
            local velocity_y = entity_get_prop(local_player, "m_vecVelocity[1]") or 0
            
            return math.sqrt(velocity_x * velocity_x + velocity_y * velocity_y)
        end

        local function is_firing()
            local local_player = entity_get_local_player()
            if local_player == nil then return false end
            
            local active_weapon = entity_get_prop(local_player, "m_hActiveWeapon")
            if active_weapon == nil then return false end
            
            local weapon_entity = entity_get_prop(active_weapon, "m_hActiveWeapon")
            if weapon_entity == nil then return false end
            
            local next_attack = entity_get_prop(local_player, "m_flNextAttack") or 0
            local next_primary_attack = entity_get_prop(weapon_entity, "m_flNextPrimaryAttack") or 0
            
            local firing = next_primary_attack <= globals.curtime() and next_attack <= globals.curtime()
            
            if firing then
                last_fire_time = globals.curtime()
            end
            
            return firing
        end

        local function get_closest_enemy_distance()
            local local_player = entity_get_local_player()
            if local_player == nil then return 9999 end
            
            local local_x, local_y, local_z = entity_get_prop(local_player, "m_vecOrigin")
            if not local_x then return 9999 end
            
            local players = entity.get_players(true)
            local closest_distance = 9999
            
            for i = 1, #players do
                local player = players[i]
                if entity_get_prop(player, "m_iHealth") > 0 then
                    local enemy_x, enemy_y, enemy_z = entity_get_prop(player, "m_vecOrigin")
                    if enemy_x then
                        local dx = enemy_x - local_x
                        local dy = enemy_y - local_y
                        local distance = math.sqrt(dx*dx + dy*dy)
                        
                        if distance < closest_distance then
                            closest_distance = distance
                        end
                    end
                end
            end
            
            last_enemy_distance = closest_distance
            return closest_distance
        end

        local function fix_autostop()
            if not ui.get(enable_fix) then
                return
            end
            
            local local_player = entity_get_local_player()
            if local_player == nil then return end
            
            local velocity = get_local_velocity()
            
            if velocity < 5 then
                should_stop_early = false
                return
            end
            
            local enemy_distance = get_closest_enemy_distance()
            local is_firing_now = is_firing()
            
            local should_early_stop = false
            
            if enemy_distance < 350 and velocity > 30 then
                should_early_stop = true
            end
            
            if should_early_stop then
                should_stop_early = true
                early_stop_time = globals.curtime() + 0.5
                ui.set(ref_autostop, true)
            elseif should_stop_early then
                if globals.curtime() < early_stop_time and velocity > 10 then
                    ui.set(ref_autostop, true)
                else
                    should_stop_early = false
                    if velocity < 2 then
                        ui.set(ref_autostop, false)
                    end
                end
            else
                ui.set(ref_autostop, true)
            end
        end

        client.set_event_callback("setup_command", fix_autostop)
    end
    local trash_talk do
        trash_talk = {}
        
        local killsay_phrases = {
            {"пидор не думай что это трештолк", "я просто твой нос спермой заливал"},
            {"эй гоблин ебаный", "щас твою семейку орков трахнем "},
            {"защекан ебаный тухлодырый", "я этим киллом жопу твой драл"},
            {"приватнее сетов на Tenneza lua", "у тебя даже секса с мамой не будет"},
            {"Owned by 𝐓𝐄𝐍𝐍𝐄𝐙𝐙𝐀.𝐋𝐔𝐀", "𐓏 𝑻𝒉𝒆 𝒃𝒆𝒔𝒕 𝒍𝒖𝒂 𝒇𝒐𝒓 3$ 𐓏"},
            {"1 ", "лох я этим киллом снес правую сиську твоей мамы", "подбери за маринуй"},
            {"твой дом зачастую называется харчевней"},
            {"1", "даун самосвальный"},
            {"ладно даун", "сядь жопой на хуй", "и поскакал галопом отсюда"},
            {"овчарка ебучая", "я щас твою будку нахуй переверну "},
            {"не подьедай гавно за своей гей-мамой", "играй уже"},
            {"угостись залупой конской", "хуйпаклык с еблом ослиным"},
            {"эй косолапый пидор это ты называешь игрой?", "выглядит как минет засохшему куску дерьма"},
            {"ты че там упал пидор? ", "представляешь как с хуя соскачил?"},
            {"купи луаху(tennezza)", "дурень"},
            {"от тенезы не убежать хуесос"},
            {"ебать у тебя хуевый лц брик", 'вгетай тенеза луа бомж', 'брикать хоть нормально будешь'},
            {"возьми трубу хуесос", "тебе теннезза звонит"},
            {"ты", "пидорас"},
            {"у меня читуха за километр таких пидарасав как ты чует", "сразу аашки фиксит нахуй"},
            {"узник ебаного луасенса", "нахуй с сервера вышел пидр"},
            {"твой гей папа снова сидит под моим пенисом", "пусть волосики перебирает"},
        }

        local death_say = {
            {'хорошо даун', 'твое языковое попадание на хуй не назвать более чем везенее'},
            {'я - будучи потомков иисуса спустился с креста и одарил тебя единождным везение', 'пользуйся случаем'},
            {'тупее кила не видел', 'встал со своей биты который ты называешь "стулом" и иди нахуй'},
            {',kz', 'скажи где такие ники штампуют', 'от тебя реально смешно умирать'},
            {'нихуево ты раком встал начал из жопы мамкиными зубами стреляться', 'зацепил меня сученак'},
            {'это че за ебаный тараканий рой развелся', 'наскочили я от испуга умер нахуй'},
            {'щас батька с танков тя снарядом уебет', 'тухлодырый ппидор бля'},
            {"нихуевый у тебя кил хуесос", "я же знаю что ты искуственный интелект", "чмо ебано"},
            {"у меня читуха на дух таких как ты не переносит", "везучему пидару свыше выдался момент"},
        }
        
        function trash_talk.on_player_death(e)
            local delayed_msg = function(delay, msg)
                return client.delay_call(delay, function() client.exec('say ' .. msg) end)
            end

            local me = entity_get_local_player()
            local victim = client.userid_to_entindex(e.userid)
            local attacker = client.userid_to_entindex(e.attacker)

            local killsay_delay = 0
            local deathsay_delay = 0

            if entity_get_local_player() == nil then return end

            local gamerulesproxy = entity.get_all("CCSGameRulesProxy")[1]
            local warmup_period = entity_get_prop(gamerulesproxy, "m_bWarmupPeriod")
            if warmup_period == 1 then return end

            if not ui.get(ui_settings.trashtalk) then return end



            if (victim ~= attacker and attacker == me) and utility.contains(ui_settings.trashtalk_type, "Kill") then
                local phase_block = killsay_phrases[math.random(1, #killsay_phrases)]
                for i = 1, #phase_block do
                    local phase = phase_block[i]
                    local interphrase_delay = 1.5
                    killsay_delay = killsay_delay + interphrase_delay
                    delayed_msg(killsay_delay, phase)
                end
            end
                    
            if (victim == me and attacker ~= me) and utility.contains(ui_settings.trashtalk_type, "Death") then
                local phase_block = death_say[math.random(1, #death_say)]
                for i = 1, #phase_block do
                    local phase = phase_block[i]
                    local interphrase_delay = #phase_block[i] / 20 * 1.3
                    deathsay_delay = deathsay_delay + interphrase_delay
                    delayed_msg(deathsay_delay, phase)
                end
            end
        end
    end
    miscellaneous.trash_talk = trash_talk
    local clan_tag do
        clan_tag = {}
        
        local clantag_data = {
            steam = steamworks.ISteamFriends,
            prev_ct = "",
            orig_ct = "",
            enb = false,
        }
        
        function clan_tag.get_original_clantag()
            local clan_id = cvar.cl_clanid.get_int()
            if clan_id == 0 then return "\0" end

            local clan_count = clantag_data.steam.GetClanCount()
            for i = 0, clan_count do 
                local group_id = clantag_data.steam.GetClanByIndex(i)
                if group_id == clan_id then
                    return clantag_data.steam.GetClanTag(group_id)
                end
            end
            return "\0"
        end
        
        function clan_tag.clantag_anim(text, indices)
            local time_to_ticks = function(t)
                return math.floor(0.5 + (t / globals.tickinterval()))
            end

            local text_anim = "               " .. text .. "" 
            local tickinterval = globals.tickinterval()
            local tickcount = globals.tickcount() + time_to_ticks(client.latency())
            local i = tickcount / time_to_ticks(0.3)
            i = math.floor(i % #indices)
            i = indices[i+1]+1
            return string.sub(text_anim, i, i+15)
        end
        
        function clan_tag.update()
            local lua_name = "Tennezza "
            if ui.get(ui_settings.clantagchanger) then
                if ui.get(ui.reference("Misc", "Miscellaneous", "Clan tag spammer")) then 
                    ui.set(ui.reference("Misc", "Miscellaneous", "Clan tag spammer"), false) 
                end

                local clan_tag_text = clan_tag.clantag_anim(lua_name, {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 11, 11, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25})

                if entity_get_prop(entity.get_game_rules(), "m_gamePhase") == 5 then
                    clan_tag_text = clan_tag.clantag_anim('Tennezza ', {13})
                    client.set_clan_tag(clan_tag_text)
                elseif entity_get_prop(entity.get_game_rules(), "m_timeUntilNextPhaseStarts") ~= 0 then
                    clan_tag_text = clan_tag.clantag_anim('Tennezza ', {13})
                    client.set_clan_tag(clan_tag_text)
                elseif clan_tag_text ~= clantag_data.prev_ct then
                    client.set_clan_tag(clan_tag_text)
                end

                clantag_data.prev_ct = clan_tag_text
                clantag_data.enb = true
            elseif clantag_data.enb == true then
                client.set_clan_tag(clan_tag.get_original_clantag())
                clantag_data.enb = false
            end
        end
        
        function clan_tag.on_paint()
            if entity_get_local_player() ~= nil then
                if globals.tickcount() % 2 == 0 then
                    clan_tag.update()
                end
            end
        end
        
        function clan_tag.on_run_command(e)
            if entity_get_local_player() ~= nil then 
                if e.chokedcommands == 0 then
                    clan_tag.update()
                end
            end
        end
        
        function clan_tag.on_player_connect_full(e)
            if client.userid_to_entindex(e.userid) == entity_get_local_player() then 
                clantag_data.orig_ct = clan_tag.get_original_clantag()
            end
        end
        
        function clan_tag.on_shutdown()
            client.set_clan_tag(clan_tag.get_original_clantag())
        end
    end
    miscellaneous.clan_tag = clan_tag
    local double_tap_fix do 
        double_tap_fix = { }
        local width, height = client.screen_size()
        local lc = false
        local lefttick = 0
        function double_tap_fix.setup_command(cmd)
            if not ui.get(ui_settings.dt_fix) then return end
            local exploit_data = exploit.get()
            lc = exploit_data.lagcompensation.teleport
            lefttick = exploit_data.defensive.left
            if lc then
                cmd.force_defensive = true
            elseif lefttick < 0 then
                cmd.force_defensive = false
            end
        end
        local enable_lc_indicator = ui_settings.dt_fix_indicator
        local positions = {}
        local lc = false

        client.set_event_callback("setup_command", function(cmd)
            if not ui.get(enable_lc_indicator) then return end

            local plocal = entity.get_local_player()
            if not plocal or not entity.is_alive(plocal) then return end

            local origin = vector(entity.get_origin(plocal))
            local time = 1 / globals.tickinterval()

            if cmd.chokedcommands == 0 then
                positions[#positions + 1] = origin

                if #positions >= time then
                    local record = positions[time]
                    lc = (origin - record):lengthsqr() > 4096
                end
            end

            if #positions > time then
                table.remove(positions, 1)
            end   
        end)

        client.set_event_callback("paint", function()
            if not ui.get(enable_lc_indicator) then return end

            local plocal = entity.get_local_player()
            if not plocal or not entity.is_alive(plocal) then return end

            local flags = entity.get_prop(plocal, "m_fFlags")

            if bit.band(flags, 1) == 1 and not lc then
                return
            end

            local r, g, b, a = 240, 15, 15, 240

            if lc then
                r, g, b = 160, 202, 43
            end
            
            renderer.indicator(r, g, b, a, "LC")
        end)
    end
    miscellaneous.double_tap_fix = double_tap_fix

    local hitgroup_names = {"generic", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "?", "gear"}
    local weapon_to_verb = { knife = 'Knifed', hegrenade = 'Naded', inferno = 'Burned' }
    
    local hit_logs = {
        entries = {},
        max_entries = 15,
        display_time = 5,
        animation_speed = 0.5,
        fade_speed = 0.8,
        entry_spacing = 5,
        bg_opacity = 130
    }
    
    local fireData = {}
    
    local current_miss_color = {255, 50, 50, 255}  
    local current_hit_color = {124, 252, 0, 255}

    local hit_log do
        hit_log = {}
        
        local classic_hitlog = {}
        
        function hit_log.update_hitlog_colors()
            local miss_color_table = {ui.get(ui_settings.miss_color)}
            local hit_color_table = {ui.get(ui_settings.hit_color)}
            
            if miss_color_table and #miss_color_table >= 4 then
                current_miss_color = {miss_color_table[1], miss_color_table[2], miss_color_table[3], miss_color_table[4]}
            end
            
            if hit_color_table and #hit_color_table >= 4 then
                current_hit_color = {hit_color_table[1], hit_color_table[2], hit_color_table[3], hit_color_table[4]}
            end
        end
        
        function hit_log.draw_rounded_rect(x, y, width, height, alpha, type, is_icon)
            if alpha <= 0 then return end
            
            local shadow_offset = 2
            
            for i = 1, shadow_offset do
                local shadow_alpha = math.floor(alpha * 0.12 * (1 - i / (shadow_offset + 1)))
                renderer.rectangle(x + i, y + i, width, height, 0, 0, 0, shadow_alpha)
            end
            
            local bg_top_r, bg_top_g, bg_top_b = 18, 18, 24
            local bg_bot_r, bg_bot_g, bg_bot_b = 28, 28, 35
            
            for i = 0, height - 1 do
                local progress = i / height
                local r = math.floor(bg_top_r + (bg_bot_r - bg_top_r) * progress)
                local g = math.floor(bg_top_g + (bg_bot_g - bg_top_g) * progress)
                local b = math.floor(bg_top_b + (bg_bot_b - bg_top_b) * progress)
                renderer.blur(x, y + i, width, 1, alpha, 1)
            end
            
            local accent_color
            if type == 'hit' then
                accent_color = current_hit_color
            elseif type == 'miss' then
                accent_color = current_miss_color
            else
                accent_color = current_hit_color
            end
            
            renderer.rectangle(x, y, 3, height, accent_color[1], accent_color[2], accent_color[3], alpha)
            
            renderer.rectangle(x + width - 3, y, 3, height, accent_color[1], accent_color[2], accent_color[3], alpha)
            
            if is_icon then
                for i = 0, 2 do
                    local glow_alpha = math.floor(alpha * 0.3 * (1 - i / 3))
                    renderer.rectangle(x, y + i, width, 1, accent_color[1], accent_color[2], accent_color[3], glow_alpha)
                end
            end
            
        end
        
        function hit_log.hitloglerp(start, finish, fraction)
            if fraction >= 1 then return finish end
            if fraction <= 0 then return start end
            return start + (finish - start) * fraction
        end
        
        function hit_log.ease_out_quad(t)
            return t * (2 - t)
        end
        
        function hit_log.ease_out_cubic(t)
            local t1 = t - 1
            return t1 * t1 * t1 + 1
        end

        function hit_log.draw_horizontal_gradient_background(x, y, width, height, alpha, type, is_symbol)
            if alpha <= 0 then return end
            
            local corner_radius = 4
            local outline_r, outline_g, outline_b
            
            outline_r, outline_g, outline_b = 230, 230, 230  -- Серый
            
            renderer.circle(x + corner_radius, y + corner_radius, 0, 0, 0, alpha, corner_radius, 180, 0.25, true)
            renderer.circle_outline(x + corner_radius, y + corner_radius, outline_r, outline_g, outline_b, alpha, corner_radius, 180, 0.25, 1)
            
            renderer.circle(x + width - corner_radius, y + corner_radius, 0, 0, 0, alpha, corner_radius, 90, 0.25, true)
            renderer.circle_outline(x + width - corner_radius, y + corner_radius, outline_r, outline_g, outline_b, alpha, corner_radius, 270, 0.25, 1)
            
            renderer.circle(x + corner_radius, y + height - corner_radius, 0, 0, 0, alpha, corner_radius, 270, 0.25, true)
            renderer.circle_outline(x + corner_radius, y + height - corner_radius, outline_r, outline_g, outline_b, alpha, corner_radius, 90, 0.25, 1)
            
            renderer.circle(x + width - corner_radius, y + height - corner_radius, 0, 0, 0, alpha, corner_radius, 0, 0.25, true)
            renderer.circle_outline(x + width - corner_radius, y + height - corner_radius, outline_r, outline_g, outline_b, alpha, corner_radius, 0, 0.25, 1)
            
            renderer.rectangle(x + corner_radius, y, width - corner_radius * 2, corner_radius, 0, 0, 0, alpha)
            renderer.rectangle(x + corner_radius, y + height - corner_radius, width - corner_radius * 2, corner_radius, 0, 0, 0, alpha)
            renderer.rectangle(x, y + corner_radius, corner_radius, height - corner_radius * 2, 0, 0, 0, alpha)
            renderer.rectangle(x + width - corner_radius, y + corner_radius, corner_radius, height - corner_radius * 2, 0, 0, 0, alpha)
            renderer.rectangle(x + corner_radius, y + corner_radius, width - corner_radius * 2, height - corner_radius * 2, 0, 0, 0, alpha)
            
            renderer.line(x + corner_radius, y, x + width - corner_radius, y, outline_r, outline_g, outline_b, alpha)
            renderer.line(x + corner_radius, y + height, x + width - corner_radius, y + height, outline_r, outline_g, outline_b, alpha)
            renderer.line(x, y + corner_radius, x, y + height - corner_radius, outline_r, outline_g, outline_b, alpha)
            renderer.line(x + width, y + corner_radius, x + width, y + height - corner_radius, outline_r, outline_g, outline_b, alpha)
        end
        
        function classic_hitlog.hitloglerp(start, finish, fraction)
            return hit_log.hitloglerp(start, finish, fraction)
        end
        
        function classic_hitlog.calculate_entry_height(entry)
            if entry.type == 'hit' or entry.type == 'miss' then
                return 36
            elseif entry.type == 'weapon' then
                local weapon = entry.data.weapon
                if weapon == "knife" or weapon == "hegrenade" or weapon == "inferno" or weapon == "molotov" then
                    return 36
                end
            end
            return 0
        end
        
        function classic_hitlog.draw_horizontal_gradient_background(x, y, width, height, alpha, type, is_symbol)
            if alpha <= 0 then return end
                
            local corner_radius = 4
            local outline_r, outline_g, outline_b
                
            outline_r, outline_g, outline_b = 255, 255, 255
                
            renderer.circle(x + corner_radius, y + corner_radius, 0, 0, 0, alpha, corner_radius, 180, 0.25, true)
            renderer.circle_outline(x + corner_radius, y + corner_radius, outline_r, outline_g, outline_b, alpha, corner_radius, 180, 0.25, 1)
                
            renderer.circle(x + width - corner_radius, y + corner_radius, 0, 0, 0, alpha, corner_radius, 90, 0.25, true)
            renderer.circle_outline(x + width - corner_radius, y + corner_radius, outline_r, outline_g, outline_b, alpha, corner_radius, 270, 0.25, 1)
                
            renderer.circle(x + corner_radius, y + height - corner_radius, 0, 0, 0, alpha, corner_radius, 270, 0.25, true)
            renderer.circle_outline(x + corner_radius, y + height - corner_radius, outline_r, outline_g, outline_b, alpha, corner_radius, 90, 0.25, 1)
                
            renderer.circle(x + width - corner_radius, y + height - corner_radius, 0, 0, 0, alpha, corner_radius, 0, 0.25, true)
            renderer.circle_outline(x + width - corner_radius, y + height - corner_radius, outline_r, outline_g, outline_b, alpha, corner_radius, 0, 0.25, 1)
                
            renderer.rectangle(x + corner_radius, y, width - corner_radius * 2, corner_radius, 0, 0, 0, alpha)
            renderer.rectangle(x + corner_radius, y + height - corner_radius, width - corner_radius * 2, corner_radius, 0, 0, 0, alpha)
            renderer.rectangle(x, y + corner_radius, corner_radius, height - corner_radius * 2, 0, 0, 0, alpha)
            renderer.rectangle(x + width - corner_radius, y + corner_radius, corner_radius, height - corner_radius * 2, 0, 0, 0, alpha)
            renderer.rectangle(x + corner_radius, y + corner_radius, width - corner_radius * 2, height - corner_radius * 2, 0, 0, 0, alpha)
                
            renderer.line(x + corner_radius, y, x + width - corner_radius, y, outline_r, outline_g, outline_b, alpha)
            renderer.line(x + corner_radius, y + height, x + width - corner_radius, y + height, outline_r, outline_g, outline_b, alpha)
            renderer.line(x, y + corner_radius, x, y + height - corner_radius, outline_r, outline_g, outline_b, alpha)
            renderer.line(x + width, y + corner_radius, x + width, y + height - corner_radius, outline_r, outline_g, outline_b, alpha)
        end

        function hit_log.draw_symbol_cell(x, y, symbol, alpha, type, opacity_multiplier)
            local symbol_width = renderer.measure_text("", symbol)
            local padding = 10
            local cell_width = symbol_width + padding * 2
            local cell_height = 26
            local cell_x = x - cell_width / 2
            local cell_y = y - cell_height / 2
                
            local bg_alpha = math.floor(alpha * (opacity_multiplier / 255))
                
            classic_hitlog.draw_horizontal_gradient_background(cell_x, cell_y, cell_width, cell_height, bg_alpha, type, true)
                
            renderer.text(x, y - 3, 255, 255, 255, alpha, "c+", 0, symbol)
                
            return cell_width
        end
            
        function hit_log.add_log_entry(type, data)
            local timestamp = globals.realtime()
            local current_time = globals.realtime()
                
            local _, screen_height = client.screen_size()
            local base_y_offset = ui.get(ui_settings.logaimbot_pos_y)
            local new_entry_height = classic_hitlog.calculate_entry_height({type = type, data = data})
                
            if new_entry_height == 0 then return end
                
            local entry = {
                type = type,
                data = data,
                timestamp = timestamp,
                alpha = 0,
                current_y = screen_height / 2 + base_y_offset, 
                start_y = screen_height / 2 + base_y_offset,   
                anim_start_time = current_time,
                animating = true,
                height = new_entry_height
            }

                
            for i, existing_entry in ipairs(hit_logs.entries) do
                existing_entry.start_y = existing_entry.current_y
                existing_entry.animating = true
                existing_entry.anim_start_time = current_time
            end
                
            table.insert(hit_logs.entries, 1, entry)
                
            local base_y = screen_height / 2 + 100
            local current_target_y = base_y
                
            for i, existing_entry in ipairs(hit_logs.entries) do
                if i == 1 then
                    existing_entry.target_y = current_target_y
                else
                    local prev_entry = hit_logs.entries[i-1]
                    current_target_y = current_target_y + prev_entry.height + hit_logs.entry_spacing
                    existing_entry.target_y = current_target_y
                end
            end
                
            if #hit_logs.entries > hit_logs.max_entries then
                for i = hit_logs.max_entries + 1, #hit_logs.entries do
                    hit_logs.entries[i] = nil
                end
            end
        end
            
        function classic_hitlog.on_aim_fire(e)
            local flags = {}
            if e.teleported then table.insert(flags, "LC") end
            if e.interpolated then table.insert(flags, "I") end
            if e.extrapolated then table.insert(flags, "EX") end
            if e.high_priority then table.insert(flags, "HP") end

            fireData[e.id] = {
                tick = e.tick,
                predicted_damage = e.damage,
                predicted_hitgroup = e.hitgroup,
                hit_chance = e.hit_chance,
                backtrack_ticks = globals.tickcount() - e.tick,
                flags = #flags > 0 and table.concat(flags) or nil,
                timestamp = client.timestamp(),
                server_tick = globals.servertickcount()
            }
        end
            
        function classic_hitlog.on_aim_hit(e)
            if not ui.get(ui_settings.logaimbotcheckbox) then return end
            
            hit_log.update_hitlog_colors()
                
            local stored = fireData[e.id]
            if not stored then return end

            local group = hitgroup_names[e.hitgroup + 1] or "?"

            if utility.contains(ui_settings.logaimbot, "Console") then
                client.color_log(current_hit_color[1], current_hit_color[2], current_hit_color[3], "[Tennezza]\0")
                client.color_log(255, 255, 255, " Hit\0")
                client.color_log(current_hit_color[1], current_hit_color[2], current_hit_color[3], string.format(" %s\0", entity.get_player_name(e.target)))
                client.color_log(255, 255, 255, " in the\0")
                client.color_log(current_hit_color[1], current_hit_color[2], current_hit_color[3], string.format(" %s\0", group))
                if group ~= hitgroup_names[stored.predicted_hitgroup + 1] then
                    client.color_log(255, 255, 255, "(\0")
                    client.color_log(current_hit_color[1], current_hit_color[2], current_hit_color[3], string.format("%s\0", hitgroup_names[stored.predicted_hitgroup + 1]))
                    client.color_log(255, 255, 255, " ) \0")
                end
                client.color_log(255, 255, 255, " for\0")
                client.color_log(current_hit_color[1], current_hit_color[2], current_hit_color[3], string.format(" %s\0", e.damage))
                client.color_log(255, 255, 255, " dmg\0")
                if e.damage ~= stored.predicted_damage then
                    client.color_log(255, 255, 255, "(\0")
                    client.color_log(current_hit_color[1], current_hit_color[2], current_hit_color[3], string.format("%s\0", stored.predicted_damage))
                    client.color_log(255, 255, 255, " ) \0")
                end
                if entity_get_prop(e.target, "m_iHealth") ~= 0 then
                    client.color_log(255, 255, 255, "(\0")
                    client.color_log(current_hit_color[1], current_hit_color[2], current_hit_color[3], string.format("%s\0", entity_get_prop(e.target, "m_iHealth")))
                    client.color_log(255, 255, 255, "HP left) \0")
                end
                client.color_log(current_hit_color[1], current_hit_color[2], current_hit_color[3], string.format(" %s\0", stored.backtrack_ticks))
                client.color_log(255, 255, 255, " bt \0")
                client.color_log(current_hit_color[1], current_hit_color[2], current_hit_color[3], string.format(" %s\0", math.floor(stored.hit_chance)))
                client.color_log(255, 255, 255, " hc")
            end
                
            local log_data = {
                target_name = entity.get_player_name(e.target),
                hit_group = group,
                damage = e.damage or 0,
                remaining_hp = entity.get_prop(e.target, "m_iHealth"),
                hit_chance = math.floor(stored.hit_chance) or 0,
                backtrack_ticks = stored.backtrack_ticks or 0
            }
                
            hit_log.add_log_entry('hit', log_data)
            fireData[e.id] = nil
        end
            
        function classic_hitlog.on_aim_miss(e)
            if not ui.get(ui_settings.logaimbotcheckbox) then return end
                
            hit_log.update_hitlog_colors()
                
            local stored = fireData[e.id]
            if not stored then return end

            local group = hitgroup_names[e.hitgroup + 1] or "?"
            if utility.contains(ui_settings.logaimbot, "Console") then
                client.color_log(current_miss_color[1], current_miss_color[2], current_miss_color[3], "[Tennezza]\0")
                client.color_log(255, 255, 255, " Missed\0")
                client.color_log(current_miss_color[1], current_miss_color[2], current_miss_color[3], string.format(" %s\0", entity.get_player_name(e.target)))
                client.color_log(255, 255, 255, " due to\0")
                client.color_log(current_miss_color[1], current_miss_color[2], current_miss_color[3], string.format(" %s\0", e.reason))
                client.color_log(255, 255, 255, " in\0")
                client.color_log(current_miss_color[1], current_miss_color[2], current_miss_color[3], string.format(" %s\0", group))
                client.color_log(255, 255, 255, "(\0")
                client.color_log(current_miss_color[1], current_miss_color[2], current_miss_color[3], string.format("%s\0", stored.predicted_damage))
                client.color_log(255, 255, 255, " dmg) \0")
                client.color_log(current_miss_color[1], current_miss_color[2], current_miss_color[3], string.format("%s\0", stored.backtrack_ticks))
                client.color_log(255, 255, 255, " bt \0")
                client.color_log(current_miss_color[1], current_miss_color[2], current_miss_color[3], string.format("%s\0", math.floor(stored.hit_chance)))
                client.color_log(255, 255, 255, " hc")
            end
                
            local log_data = {
                target_name = entity.get_player_name(e.target),
                hit_group = group,
                reason = e.reason,
                hit_chance = math.floor(stored.hit_chance) or 0,
                backtrack_ticks = stored.backtrack_ticks or 0
            }
                
            hit_log.add_log_entry('miss', log_data)
            fireData[e.id] = nil
        end
            
        function classic_hitlog.on_player_hurt(e)
            if not ui.get(ui_settings.logaimbotcheckbox) then return end
                
            hit_log.update_hitlog_colors()
                
            local attacker_id = client.userid_to_entindex(e.attacker)

            if attacker_id == nil or attacker_id ~= entity.get_local_player() then
                return
            end

            if weapon_to_verb[e.weapon] ~= nil then
                local target_id = client.userid_to_entindex(e.userid)
                local target_name = entity.get_player_name(target_id)

                if utility.contains(ui_settings.logaimbot, "Console") then
                    client.color_log(current_hit_color[1], current_hit_color[2], current_hit_color[3], "[Tennezza]\0")
                    client.color_log(255, 255, 255, " \0")
                    client.color_log(current_hit_color[1], current_hit_color[2], current_hit_color[3], string.format("%s\0", weapon_to_verb[e.weapon]))
                    client.color_log(255, 255, 255, " \0")
                    client.color_log(current_hit_color[1], current_hit_color[2], current_hit_color[3], string.format("%s\0", target_name))
                    client.color_log(255, 255, 255, " for\0")
                    client.color_log(current_hit_color[1], current_hit_color[2], current_hit_color[3], string.format(" %s\0", e.dmg_health))
                    client.color_log(255, 255, 255, " damage (\0")
                    client.color_log(current_hit_color[1], current_hit_color[2], current_hit_color[3], string.format(" %s\0", e.health))
                    client.color_log(255, 255, 255, " HP left)")
                end
                    
                local log_data = {
                    target_name = target_name,
                    weapon = e.weapon,
                    damage = e.dmg_health,
                    remaining_hp = e.health
                }
                
                hit_log.add_log_entry('weapon', log_data)
            end
        end
        
        function classic_hitlog.on_paint()
            if entity.get_local_player() == nil then return end
            if not utility.contains(ui_settings.logaimbot, "Under crosshair") then return end
            if ui.get(ui_settings.hitlog_style) ~= "Classic" then return end
            
            hit_log.update_hitlog_colors()
            
            local width, height = client.screen_size()
            local current_time = globals.realtime()
            local center_x = width / 2
            local fixed_left_margin = 100
            local base_y_offset = ui.get(ui_settings.logaimbot_pos_y)
            local spacing = hit_logs.entry_spacing
            local opacity = hit_logs.bg_opacity

            for i = #hit_logs.entries, 1, -1 do
                local entry = hit_logs.entries[i]
                
                if current_time - entry.timestamp > hit_logs.display_time then
                    entry.alpha = math.max(0, entry.alpha - 15)
                    if entry.alpha <= 0 then
                        table.remove(hit_logs.entries, i)
                    end
                else
                    local time_left = hit_logs.display_time - (current_time - entry.timestamp)

                    if time_left < 1.0 then
                        entry.alpha = math.floor(255 * (time_left / 1.0))
                    elseif entry.alpha < 255 then
                        entry.alpha = math.min(255, entry.alpha + 15)
                    end

                    if entry.animating and entry.target_y then
                        local anim_progress = (current_time - entry.anim_start_time) / hit_logs.animation_speed
                        
                        if anim_progress >= 1 then
                            entry.current_y = entry.target_y
                            entry.animating = false
                            entry.alpha = 255
                        else
                            local ease_progress = 1 - math.pow(1 - anim_progress, 3)
                            entry.current_y = hit_log.hitloglerp(entry.start_y, entry.target_y, ease_progress)
                            
                            if entry.alpha < 255 then
                                entry.alpha = math.min(255, math.floor(255 * ease_progress))
                            end
                        end
                    elseif not entry.target_y then
                        entry.target_y = entry.current_y
                    end
                end
            end
            
            local base_y = height / 2 + base_y_offset
            
            for i, entry in ipairs(hit_logs.entries) do
                if entry.alpha > 0 then
                    if i == 1 then
                        entry.target_y = base_y
                    else
                        local prev_entry = hit_logs.entries[i-1]
                        entry.target_y = prev_entry.target_y + prev_entry.height + spacing
                    end
                    
                    if not entry.animating then
                        entry.current_y = entry.target_y
                    end
                    
                    local current_y = entry.current_y
                    
                    local text_color, symbol_color
                    if entry.type == 'hit' then
                        text_color = current_hit_color
                        symbol_color = current_hit_color
                    elseif entry.type == 'miss' then
                        text_color = current_miss_color
                        symbol_color = current_miss_color
                    else
                        text_color = current_hit_color
                        symbol_color = current_hit_color
                    end
                    
                    local symbol_x = center_x - fixed_left_margin
                    local symbol_cell_width = hit_log.draw_symbol_cell(symbol_x, current_y, "⚡︎", entry.alpha, entry.type, opacity)
                    
                    local text_start_x = symbol_x + symbol_cell_width/2 + 15
                    
                    local log_text = ""
                    
                    if entry.type == 'hit' then
                        log_text = log_text .. "\a" .. utility.rgba_to_hex(text_color[1], text_color[2], text_color[3], entry.alpha) .. "Hit "
                        log_text = log_text .. "\a" .. utility.rgba_to_hex(255, 255, 255, entry.alpha) .. entry.data.target_name
                        log_text = log_text .. "\a" .. utility.rgba_to_hex(text_color[1], text_color[2], text_color[3], entry.alpha) .. " in "
                        log_text = log_text .. "\a" .. utility.rgba_to_hex(255, 255, 255, entry.alpha) .. entry.data.hit_group
                        log_text = log_text .. "\a" .. utility.rgba_to_hex(text_color[1], text_color[2], text_color[3], entry.alpha) .. " for "
                        log_text = log_text .. "\a" .. utility.rgba_to_hex(255, 255, 255, entry.alpha) .. tostring(entry.data.damage)
                        log_text = log_text .. "\a" .. utility.rgba_to_hex(text_color[1], text_color[2], text_color[3], entry.alpha) .. " damage"
                        
                    elseif entry.type == 'miss' then
                        log_text = log_text .. "\a" .. utility.rgba_to_hex(text_color[1], text_color[2], text_color[3], entry.alpha) .. "Missed "
                        log_text = log_text .. "\a" .. utility.rgba_to_hex(255, 255, 255, entry.alpha) .. entry.data.target_name
                        log_text = log_text .. "\a" .. utility.rgba_to_hex(text_color[1], text_color[2], text_color[3], entry.alpha) .. " due to "
                        log_text = log_text .. "\a" .. utility.rgba_to_hex(255, 255, 255, entry.alpha) .. entry.data.reason
                        log_text = log_text .. "\a" .. utility.rgba_to_hex(text_color[1], text_color[2], text_color[3], entry.alpha) .. " in "
                        log_text = log_text .. "\a" .. utility.rgba_to_hex(255, 255, 255, entry.alpha) .. entry.data.hit_group
                        
                    elseif entry.type == 'weapon' then
                        local weapon_verb = "Hurt"
                        if entry.data.weapon == "knife" then 
                            weapon_verb = "Knifed"
                        elseif entry.data.weapon == "hegrenade" then 
                            weapon_verb = "Naded"
                        elseif entry.data.weapon == "inferno" or entry.data.weapon == "molotov" then 
                            weapon_verb = "Burned"
                        end
                        
                        log_text = log_text .. "\a" .. utility.rgba_to_hex(text_color[1], text_color[2], text_color[3], entry.alpha) .. weapon_verb .. ' '
                        log_text = log_text .. "\a" .. utility.rgba_to_hex(255, 255, 255, entry.alpha) .. entry.data.target_name
                        log_text = log_text .. "\a" .. utility.rgba_to_hex(text_color[1], text_color[2], text_color[3], entry.alpha) .. " for "
                        log_text = log_text .. "\a" .. utility.rgba_to_hex(255, 255, 255, entry.alpha) .. tostring(entry.data.damage)
                        log_text = log_text .. "\a" .. utility.rgba_to_hex(text_color[1], text_color[2], text_color[3], entry.alpha) .. " damage"
                    end
                    
                    local bg_alpha = math.floor(entry.alpha * (opacity / 255))
                    if bg_alpha > 0 then
                        local text_width = renderer.measure_text("", log_text)
                        local padding = 8
                        local bg_width = text_width + padding * 2
                        local bg_height = 26
                        local bg_x = text_start_x - padding
                        local bg_y = current_y - bg_height / 2
                        
                        hit_log.draw_horizontal_gradient_background(bg_x, bg_y, bg_width, bg_height, bg_alpha, entry.type, false)
                    end
                    
                    renderer.text(text_start_x, current_y - 6, 255, 255, 255, entry.alpha, "", 0, log_text)
                end
            end
        end
        hit_log.classic_hitlog = classic_hitlog
        function hit_log.reset_animation()
            local current_time = globals.realtime()
            local _, screen_height = client.screen_size()
            local base_y_offset = ui.get(ui_settings.logaimbot_pos_y)
            
            for i, entry in ipairs(hit_logs.entries) do
                entry.start_y = entry.current_y
                entry.anim_start_time = current_time
                entry.animating = true
                
                if i == 1 then
                    entry.target_y = screen_height / 2 + base_y_offset
                else
                    local prev_entry = hit_logs.entries[i-1]
                    entry.target_y = prev_entry.target_y + prev_entry.height + hit_logs.entry_spacing
                end
            end
        end

        ui.set_callback(ui_settings.logaimbot_pos_y, function()
            hit_log.reset_animation()
        end)
        
        function hit_log.clear()
            hit_logs.entries = {}
            fireData = {}
        end
    end

    local modern_hitlog = {}
    
    local icons = {
        hit = "⚡︎",
        miss = "⚡︎",
        weapon = "⚡︎",
        skull = "⚡︎",
        crosshair = "⚡︎"
    }
    
    
    
    local modern_fireData = {}
    
    function modern_hitlog.hitloglerp(start, finish, fraction)
        if fraction >= 1 then return finish end
        if fraction <= 0 then return start end
        return start + (finish - start) * fraction
    end
    
    function modern_hitlog.calculate_entry_height(entry)
        if entry.type == 'hit' or entry.type == 'miss' then
            return 28
        elseif entry.type == 'weapon' then
            local weapon = entry.data.weapon
            if weapon == "knife" or weapon == "hegrenade" or weapon == "inferno" or weapon == "molotov" then
                return 28
            end
        end
        return 0
    end
    
    function modern_hitlog.draw_horizontal_gradient_background(x, y, width, height, alpha, type, is_symbol)
        if alpha <= 0 then return end
            
        local corner_radius = 4
        local outline_r, outline_g, outline_b
            
        outline_r, outline_g, outline_b = 255, 255, 255
            
        renderer.circle(x + corner_radius, y + corner_radius, 0, 0, 0, alpha, corner_radius, 180, 0.25, true)
        renderer.circle_outline(x + corner_radius, y + corner_radius, outline_r, outline_g, outline_b, alpha, corner_radius, 180, 0.25, 1)
            
        renderer.circle(x + width - corner_radius, y + corner_radius, 0, 0, 0, alpha, corner_radius, 90, 0.25, true)
        renderer.circle_outline(x + width - corner_radius, y + corner_radius, outline_r, outline_g, outline_b, alpha, corner_radius, 270, 0.25, 1)
            
        renderer.circle(x + corner_radius, y + height - corner_radius, 0, 0, 0, alpha, corner_radius, 270, 0.25, true)
        renderer.circle_outline(x + corner_radius, y + height - corner_radius, outline_r, outline_g, outline_b, alpha, corner_radius, 90, 0.25, 1)
            
        renderer.circle(x + width - corner_radius, y + height - corner_radius, 0, 0, 0, alpha, corner_radius, 0, 0.25, true)
        renderer.circle_outline(x + width - corner_radius, y + height - corner_radius, outline_r, outline_g, outline_b, alpha, corner_radius, 0, 0.25, 1)
            
        renderer.rectangle(x + corner_radius, y, width - corner_radius * 2, corner_radius, 0, 0, 0, alpha)
        renderer.rectangle(x + corner_radius, y + height - corner_radius, width - corner_radius * 2, corner_radius, 0, 0, 0, alpha)
        renderer.rectangle(x, y + corner_radius, corner_radius, height - corner_radius * 2, 0, 0, 0, alpha)
        renderer.rectangle(x + width - corner_radius, y + corner_radius, corner_radius, height - corner_radius * 2, 0, 0, 0, alpha)
        renderer.rectangle(x + corner_radius, y + corner_radius, width - corner_radius * 2, height - corner_radius * 2, 0, 0, 0, alpha)
            
        renderer.line(x + corner_radius, y, x + width - corner_radius, y, outline_r, outline_g, outline_b, alpha)
        renderer.line(x + corner_radius, y + height, x + width - corner_radius, y + height, outline_r, outline_g, outline_b, alpha)
        renderer.line(x, y + corner_radius, x, y + height - corner_radius, outline_r, outline_g, outline_b, alpha)
        renderer.line(x + width, y + corner_radius, x + width, y + height - corner_radius, outline_r, outline_g, outline_b, alpha)
    end

    function modern_hitlog.draw_icon_cell(x, y, icon, alpha, type, opacity_multiplier)
        local icon_size = 24
        local cell_x = x - icon_size / 2
        local cell_y = y - icon_size / 2
            
        local bg_alpha = math.floor(alpha * (opacity_multiplier / 255))
            
            
        renderer.text(x + 1, y - 4 + 1, 0, 0, 0, math.floor(alpha * 0.5), "c+b", 0, icon)
            
        local icon_color
        if type == 'hit' then
            icon_color = current_hit_color
        elseif type == 'miss' then
            icon_color = current_miss_color
        else
            icon_color = current_hit_color
        end
            
        renderer.text(x, y - 5, icon_color[1], icon_color[2], icon_color[3], alpha, "c+b", 0, icon)
            
        return icon_size
    end
        
    function modern_hitlog.on_paint()
        if entity.get_local_player() == nil then return end
        if not utility.contains(ui_settings.logaimbot, "Under crosshair") then return end
        if ui.get(ui_settings.hitlog_style) ~= "Modern" then return end
        
        hit_log.update_hitlog_colors()
        
        local width, height = client.screen_size()
        local current_time = globals.realtime()
        local center_x = width / 2
        local base_y_offset = ui.get(ui_settings.logaimbot_pos_y)
        local spacing = hit_logs.entry_spacing
        local opacity = hit_logs.bg_opacity
        local icon_size = 24  

        local entries_to_remove = {}
        
        for i = #hit_logs.entries, 1, -1 do
            local entry = hit_logs.entries[i]
            local time_elapsed = current_time - entry.timestamp
            
            if time_elapsed > hit_logs.display_time and not entry.fading_out then
                entry.fading_out = true
                entry.fade_start_time = current_time
                entry.fade_start_alpha = entry.alpha
                entry.fade_start_y = entry.current_y
                entry.target_fade_y = height + 100
                entry.fade_start_scale_x = entry.scale_x or 1.0
                entry.target_scale_x = 0.0
            end
            
            if entry.fading_out then
                local fade_elapsed = current_time - entry.fade_start_time
                local fade_progress = math.min(fade_elapsed / hit_logs.fade_speed, 1.0)
                local ease_progress = hit_log.ease_out_quad(fade_progress)
                
                entry.alpha = math.floor(entry.fade_start_alpha * (1 - ease_progress))
                
                if entry.fade_start_y and entry.target_fade_y then
                    entry.current_y = hit_log.hitloglerp(entry.fade_start_y, entry.target_fade_y, ease_progress)
                end
                
                if entry.fade_start_scale_x and entry.target_scale_x then
                    entry.scale_x = hit_log.hitloglerp(entry.fade_start_scale_x, entry.target_scale_x, ease_progress)
                end
                
                if entry.alpha <= 0 then
                    table.insert(entries_to_remove, i)
                end
            else
                if entry.alpha < 255 then
                    local fade_in_speed = 15
                    entry.alpha = math.min(255, entry.alpha + fade_in_speed)
                end
                
                if not entry.anim_start_scale_time then
                    entry.anim_start_scale_time = current_time
                    entry.anim_start_scale_x = 0.0
                    entry.anim_target_scale_x = 1.0
                end
                
                local scale_elapsed = current_time - entry.anim_start_scale_time
                local scale_progress = math.min(scale_elapsed / hit_logs.animation_speed, 1.0)
                local ease_scale_progress = hit_log.ease_out_cubic(scale_progress)
                
                entry.scale_x = hit_log.hitloglerp(entry.anim_start_scale_x, entry.anim_target_scale_x, ease_scale_progress)
            end

            if entry.animating and entry.target_y and not entry.fading_out then
                local anim_progress = (current_time - entry.anim_start_time) / hit_logs.animation_speed
                
                if anim_progress >= 1 then
                    entry.current_y = entry.target_y
                    entry.animating = false
                else
                    local ease_progress = hit_log.ease_out_cubic(anim_progress)
                    entry.current_y = hit_log.hitloglerp(entry.start_y, entry.target_y, ease_progress)
                end
            elseif not entry.target_y and not entry.fading_out then
                entry.target_y = entry.current_y
            end
        end
        
        for _, index in ipairs(entries_to_remove) do
            table.remove(hit_logs.entries, index)
        end
        
        local total_height = 0
        local visible_entries = {}
        
        for i, entry in ipairs(hit_logs.entries) do
            if not entry.fading_out then
                table.insert(visible_entries, entry)
                if #visible_entries > 1 then
                    total_height = total_height + spacing
                end
                total_height = total_height + entry.height
            end
        end
        
        local start_y = height / 2 + base_y_offset - total_height / 2
        
        for i, entry in ipairs(visible_entries) do
            if i == 1 then
                entry.target_y = start_y
            else
                local prev_entry = visible_entries[i-1]
                entry.target_y = prev_entry.target_y + prev_entry.height + spacing
            end
            
            if not entry.animating and not entry.fading_out then
                entry.current_y = entry.target_y
            elseif not entry.fading_out then
                entry.start_y = entry.current_y
                entry.animating = true
                entry.anim_start_time = current_time
            end
        end
        
        local function get_scaled_text(original_text, scale_x, entry_type, entry_alpha, text_color, entry_data)
            if scale_x >= 0.9 then
                if entry_type == 'hit' then
                    return "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry_alpha) .. "HIT " ..
                        "\a" .. string.format("%02x%02x%02x%02x", 220, 220, 220, entry_alpha) .. entry_data.target_name .. " " ..
                        "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry_alpha) .. entry_data.hit_group .. " " ..
                        "\a" .. string.format("%02x%02x%02x%02x", 255, 255, 255, entry_alpha) .. tostring(entry_data.damage) .. " HP"
                        
                elseif entry_type == 'miss' then
                    return "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry_alpha) .. "MISSED " ..
                        "\a" .. string.format("%02x%02x%02x%02x", 220, 220, 220, entry_alpha) .. entry_data.target_name .. " • " ..
                        "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry_alpha) .. entry_data.reason:upper()
                        
                elseif entry_type == 'weapon' then
                    local weapon_verb = "HURT"
                    if entry_data.weapon == "knife" then 
                        weapon_verb = "KNIFED"
                    elseif entry_data.weapon == "hegrenade" then 
                        weapon_verb = "NADED"
                    elseif entry_data.weapon == "inferno" or entry_data.weapon == "molotov" then 
                        weapon_verb = "BURNED"
                    end
                    
                    return "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry_alpha) .. weapon_verb .. " " ..
                        "\a" .. string.format("%02x%02x%02x%02x", 220, 220, 220, entry_alpha) .. entry_data.target_name .. " " ..
                        "\a" .. string.format("%02x%02x%02x%02x", 255, 255, 255, entry_alpha) .. tostring(entry_data.damage) .. " DMG"
                end
                
            elseif scale_x >= 0.8 then
                if entry_type == 'hit' then
                    return "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry_alpha) .. "HIT " ..
                        "\a" .. string.format("%02x%02x%02x%02x", 220, 220, 220, entry_alpha) .. entry_data.target_name .. " " ..
                        "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry_alpha) .. entry_data.hit_group .. " " ..
                        "\a" .. string.format("%02x%02x%02x%02x", 255, 255, 255, entry_alpha) .. tostring(entry_data.damage)
                        
                elseif entry_type == 'miss' then
                    return "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry_alpha) .. "MISS " ..
                        "\a" .. string.format("%02x%02x%02x%02x", 220, 220, 220, entry_alpha) .. entry_data.target_name .. " • " ..
                        "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry_alpha) .. entry_data.reason:upper()
                        
                elseif entry_type == 'weapon' then
                    local weapon_verb = "HURT"
                    if entry_data.weapon == "knife" then 
                        weapon_verb = "KNIFED"
                    elseif entry_data.weapon == "hegrenade" then 
                        weapon_verb = "NADED"
                    elseif entry_data.weapon == "inferno" or entry_data.weapon == "molotov" then 
                        weapon_verb = "BURNED"
                    end
                    
                    return "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry_alpha) .. weapon_verb .. " " ..
                        "\a" .. string.format("%02x%02x%02x%02x", 220, 220, 220, entry_alpha) .. entry_data.target_name .. " " ..
                        "\a" .. string.format("%02x%02x%02x%02x", 255, 255, 255, entry_alpha) .. tostring(entry_data.damage)
                end
                
            elseif scale_x >= 0.7 then
                if entry_type == 'hit' then
                    local name = entry_data.target_name
                    if string.len(name) > 10 then
                        name = string.sub(name, 1, 8) .. ".."
                    end
                    
                    return "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry_alpha) .. "HIT " ..
                        "\a" .. string.format("%02x%02x%02x%02x", 220, 220, 220, entry_alpha) .. name .. " " ..
                        "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry_alpha) .. entry_data.hit_group .. " " ..
                        "\a" .. string.format("%02x%02x%02x%02x", 255, 255, 255, entry_alpha) .. tostring(entry_data.damage)
                        
                elseif entry_type == 'miss' then
                    local name = entry_data.target_name
                    if string.len(name) > 10 then
                        name = string.sub(name, 1, 8) .. ".."
                    end
                    
                    return "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry_alpha) .. "MISS " ..
                        "\a" .. string.format("%02x%02x%02x%02x", 220, 220, 220, entry_alpha) .. name .. " " ..
                        "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry_alpha) .. entry_data.reason:upper()
                        
                elseif entry_type == 'weapon' then
                    local weapon_verb = "HURT"
                    if entry_data.weapon == "knife" then 
                        weapon_verb = "KNIFE"
                    elseif entry_data.weapon == "hegrenade" then 
                        weapon_verb = "NADE"
                    elseif entry_data.weapon == "inferno" or entry_data.weapon == "molotov" then 
                        weapon_verb = "BURN"
                    end
                    
                    local name = entry_data.target_name
                    if string.len(name) > 10 then
                        name = string.sub(name, 1, 8) .. ".."
                    end
                    
                    return "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry_alpha) .. weapon_verb .. " " ..
                        "\a" .. string.format("%02x%02x%02x%02x", 220, 220, 220, entry_alpha) .. name .. " " ..
                        "\a" .. string.format("%02x%02x%02x%02x", 255, 255, 255, entry_alpha) .. tostring(entry_data.damage)
                end
                
            elseif scale_x >= 0.6 then
                if entry_type == 'hit' then
                    local name = string.sub(entry_data.target_name, 1, 8)
                    if string.len(entry_data.target_name) > 8 then name = name .. ".." end
                    
                    local group_short = {
                        ["head"] = "HD",
                        ["chest"] = "CH",
                        ["stomach"] = "ST",
                        ["left arm"] = "LA",
                        ["right arm"] = "RA",
                        ["left leg"] = "LL",
                        ["right leg"] = "RL"
                    }
                    
                    local hit_group_text = group_short[entry_data.hit_group] or string.sub(entry_data.hit_group, 1, 2)
                    
                    return "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry_alpha) .. "HIT " ..
                        "\a" .. string.format("%02x%02x%02x%02x", 220, 220, 220, entry_alpha) .. name .. " " ..
                        "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry_alpha) .. hit_group_text .. 
                        "\a" .. string.format("%02x%02x%02x%02x", 255, 255, 255, entry_alpha) .. " " .. tostring(entry_data.damage)
                end
                
            elseif scale_x >= 0.5 then
                if entry_type == 'hit' then
                    local name = string.sub(entry_data.target_name, 1, 6)
                    if string.len(entry_data.target_name) > 6 then name = name .. "." end
                    
                    return "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry_alpha) .. "H:" ..
                        "\a" .. string.format("%02x%02x%02x%02x", 220, 220, 220, entry_alpha) .. name .. " " ..
                        "\a" .. string.format("%02x%02x%02x%02x", 255, 255, 255, entry_alpha) .. tostring(entry_data.damage)
                end
                
            elseif scale_x >= 0.4 then
                if entry_type == 'hit' then
                    return "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry_alpha) .. "HIT " ..
                        "\a" .. string.format("%02x%02x%02x%02x", 255, 255, 255, entry_alpha) .. tostring(entry_data.damage)
                elseif entry_type == 'kill' then
                    return "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry_alpha) .. "KILL " ..
                        "\a" .. string.format("%02x%02x%02x%02x", 255, 255, 255, entry_alpha) .. string.sub(entry_data.target_name, 1, 4)
                end
                
            elseif scale_x >= 0.3 then
                if entry_type == 'hit' then
                    local symbol = "⚡︎"
                    if entry_data.headshot then symbol = "⚡︎" end
                    if entry_data.wallbang then symbol = "⚡︎" end
                    
                    return symbol .. "\a" .. string.format("%02x%02x%02x%02x", 255, 255, 255, entry_alpha) .. tostring(entry_data.damage)
                elseif entry_type == 'kill' then
                    local symbol = "⚡︎"
                    if entry_data.headshot then symbol = "⚡︎" end
                    
                    return symbol .. "\a" .. string.format("%02x%02x%02x%02x", 255, 255, 255, entry_alpha) .. string.sub(entry_data.target_name, 1, 3)
                elseif entry_type == 'miss' then
                    return "⚡︎"
                elseif entry_type == 'weapon' then
                    local symbol = "⚡︎"
                    if entry_data.weapon == "hegrenade" then symbol = "⚡︎" end
                    if entry_data.weapon == "inferno" then symbol = "⚡︎" end
                    if entry_data.weapon == "knife" then symbol = "⚡︎" end
                    
                    return symbol .. "\a" .. string.format("%02x%02x%02x%02x", 255, 255, 255, entry_alpha) .. tostring(entry_data.damage)
                end
                
            elseif scale_x >= 0.2 then
                if entry_type == 'hit' then
                    local color_code = entry_data.headshot and "FFD700" or "FFFFFF"
                    return "\a" .. string.format("%02x%02x%02x%02x", 
                        entry_data.headshot and 255 or text_color[1], 
                        entry_data.headshot and 215 or text_color[2], 
                        entry_data.headshot and 0 or text_color[3], 
                        entry_alpha) .. tostring(entry_data.damage)
                elseif entry_type == 'kill' then
                    return "⚡︎"
                elseif entry_type == 'miss' then
                    return "⚡︎"
                end
                
            elseif scale_x >= 0.1 then
                if entry_type == 'hit' then
                    return tostring(entry_data.damage)
                elseif entry_type == 'kill' then
                    return "⚡︎"
                elseif entry_type == 'miss' then
                    return "⚡︎"
                end
            else
                if entry_type == 'hit' or entry_type == 'weapon' then
                    return tostring(entry_data.damage)
                elseif entry_type == 'kill' then
                    return "⚡︎"
                elseif entry_type == 'miss' then
                    return "⚡︎"
                end
            end
            
            if entry_data and entry_data.damage then
                return tostring(entry_data.damage)
            end
            
            return ""
        end
        
        for i, entry in ipairs(hit_logs.entries) do
            if entry.alpha > 0 then
                local current_y = entry.current_y
                local scale_x = entry.scale_x or 1.0
                
                local text_color
                if entry.type == 'hit' then
                    text_color = current_hit_color
                elseif entry.type == 'miss' then
                    text_color = current_miss_color
                else
                    text_color = current_hit_color
                end
                
                local icon = entry.type == 'hit' and icons.hit or (entry.type == 'miss' and icons.miss or icons.weapon)
                
                local original_text = ""
                
                if entry.type == 'hit' then
                    original_text = original_text .. "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry.alpha) .. "HIT "
                    original_text = original_text .. "\a" .. string.format("%02x%02x%02x%02x", 220, 220, 220, entry.alpha) .. entry.data.target_name
                    original_text = original_text .. "\a" .. string.format("%02x%02x%02x%02x", 140, 140, 150, entry.alpha) .. " in "
                    original_text = original_text .. "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry.alpha) .. entry.data.hit_group
                    original_text = original_text .. "\a" .. string.format("%02x%02x%02x%02x", 140, 140, 150, entry.alpha) .. " for "
                    original_text = original_text .. "\a" .. string.format("%02x%02x%02x%02x", 255, 255, 255, entry.alpha) .. tostring(entry.data.damage)
                    original_text = original_text .. "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry.alpha) .. " DMG"
                    
                elseif entry.type == 'miss' then
                    original_text = original_text .. "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry.alpha) .. "MISS "
                    original_text = original_text .. "\a" .. string.format("%02x%02x%02x%02x", 220, 220, 220, entry.alpha) .. entry.data.target_name
                    original_text = original_text .. "\a" .. string.format("%02x%02x%02x%02x", 140, 140, 150, entry.alpha) .. " • "
                    original_text = original_text .. "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry.alpha) .. entry.data.reason:upper()
                    
                elseif entry.type == 'weapon' then
                    local weapon_verb = "HURT"
                    if entry.data.weapon == "knife" then 
                        weapon_verb = "KNIFED"
                    elseif entry.data.weapon == "hegrenade" then 
                        weapon_verb = "NADED"
                    elseif entry.data.weapon == "inferno" or entry.data.weapon == "molotov" then 
                        weapon_verb = "BURNED"
                    end
                    
                    original_text = original_text .. "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry.alpha) .. weapon_verb .. " "
                    original_text = original_text .. "\a" .. string.format("%02x%02x%02x%02x", 220, 220, 220, entry.alpha) .. entry.data.target_name
                    original_text = original_text .. "\a" .. string.format("%02x%02x%02x%02x", 140, 140, 150, entry.alpha) .. " for "
                    original_text = original_text .. "\a" .. string.format("%02x%02x%02x%02x", 255, 255, 255, entry.alpha) .. tostring(entry.data.damage)
                    original_text = original_text .. "\a" .. string.format("%02x%02x%02x%02x", text_color[1], text_color[2], text_color[3], entry.alpha) .. " DMG"
                end
                
                local log_text = get_scaled_text(original_text, scale_x, entry.type, entry.alpha, text_color, entry.data)
                
                local text_width = renderer.measure_text("", log_text)
                local spacing_icon_text = 8
                local padding_x = 15
                local padding_left_for_icon = 12 
                
                local original_width = icon_size + spacing_icon_text + text_width + padding_x * 2
                
                local scaled_width = original_width * scale_x
                local bg_height = 28
                
                local bg_x = center_x - scaled_width / 2
                local bg_y = current_y - bg_height / 2
                
                local scale_factor = scaled_width / original_width
                local scaled_padding_left = padding_left_for_icon * scale_factor
                local scaled_icon_size = icon_size * scale_factor
                local scaled_spacing = spacing_icon_text * scale_factor
                
                local icon_x = bg_x + scaled_padding_left + scaled_icon_size / 2
                local text_x = bg_x + scaled_padding_left + scaled_icon_size + scaled_spacing
                
                local bg_alpha = math.floor(entry.alpha * (opacity / 255))
                if bg_alpha > 0 and scaled_width > 5 then 
                    hit_log.draw_rounded_rect(bg_x, bg_y, scaled_width, bg_height, bg_alpha, entry.type, false)
                end
                
                local icon_alpha = entry.alpha
                if icon_alpha > 0 and scaled_width > icon_size * 0.5 then
                    local icon_y = current_y
                    
                    local icon_scale = math.max(0.1, scale_factor)
                    
                    renderer.text(icon_x + 1, icon_y - 4 + 1, 0, 0, 0, math.floor(icon_alpha * 0.5), "c+b", 0, icon)
                    
                    local icon_color
                    if entry.type == 'hit' then
                        icon_color = current_hit_color
                    elseif entry.type == 'miss' then
                        icon_color = current_miss_color
                    else
                        icon_color = current_hit_color
                    end
                    
                    renderer.text(icon_x, icon_y - 5, icon_color[1], icon_color[2], icon_color[3], icon_alpha, "c+b", 0, icon)
                end
                
                if scaled_width > original_width * 0.1 and text_width > 5 then
                    renderer.text(text_x, current_y - 7, 255, 255, 255, entry.alpha, "", 0, log_text)
                end
            end
        end
    end
    hit_log.modern_hitlog = modern_hitlog


    function hit_log.reset_animation()
        local current_time = globals.realtime()
        local width, height = client.screen_size()
        local base_y_offset = ui.get(ui_settings.logaimbot_pos_y)
        
        local total_height = 0
        local visible_entries = {}
        
        for i, entry in ipairs(hit_logs.entries) do
            if not entry.fading_out then
                table.insert(visible_entries, entry)
                if #visible_entries > 1 then
                    total_height = total_height + hit_logs.entry_spacing
                end
                total_height = total_height + entry.height
            end
        end
        
        local start_y = height / 2 + base_y_offset - total_height / 2
        
        for i, entry in ipairs(visible_entries) do
            entry.start_y = entry.current_y
            entry.animating = true
            entry.anim_start_time = current_time
            
            if i == 1 then
                entry.target_y = start_y
            else
                local prev_entry = visible_entries[i-1]
                entry.target_y = prev_entry.target_y + prev_entry.height + hit_logs.entry_spacing
            end
        end
    end

    ui.set_callback(ui_settings.logaimbot_pos_y, function()
        hit_log.reset_animation()
    end)
    
    function hit_log.clear()
        hit_logs.entries = {}
        fireData = {}
    end
    miscellaneous.hit_log = hit_log
    local unsafe_recharge do
        unsafe_recharge = {}
        
        local ref_enabled = ui.reference("Rage", "Aimbot", "Enabled")
        local prev_state = false
        local should_override = false
        
        function unsafe_recharge.is_double_tap_active()
            return ui.get(reference.double_tap[1]) and ui.get(reference.double_tap[2])
        end
        
        function unsafe_recharge.is_on_shot_antiaim_active()
            return ui.get(reference.on_shot_anti_aim[1]) and ui.get(reference.on_shot_anti_aim[2])
        end
        
        function unsafe_recharge.is_tickbase_changed(player)
            local current_tickcount = globals.tickcount()
            local player_tickbase = entity.get_prop(player, "m_nTickBase")
            return (current_tickcount - player_tickbase) > 0
        end
        
        function unsafe_recharge.should_change(me, weapon)
            if me == nil or weapon == nil then
                return false
            end

            local threat = client.current_threat()
            if threat ~= nil then
                local esp_data = entity.get_esp_data(threat)
                if esp_data ~= nil and esp_data.flags ~= nil then
                    if bit.band(esp_data.flags, 2048) == 0 then
                        return false
                    end
                else
                    return false
                end
            else
                return false
            end

            if ui.get(reference.duck_peek_assist) then
                return false
            end

            local state = unsafe_recharge.is_double_tap_active() or unsafe_recharge.is_on_shot_antiaim_active()
            local exploit_data = exploit.get()
            local charged = exploit_data.shift

            if prev_state ~= state then
                if state and not charged then
                    prev_state = state
                    return true
                end
                prev_state = state
            end

            if unsafe_recharge.is_on_shot_antiaim_active() then
                if unsafe_recharge.is_tickbase_changed(me) then
                    prev_state = false
                    return false
                end
            end

            if unsafe_recharge.is_double_tap_active() then
                if charged then
                    prev_state = false
                    return false
                end
            end

            return prev_state and not charged
        end
        
        function unsafe_recharge.update_values()
            ui.set(ref_enabled, false)
        end
        
        function unsafe_recharge.restore_values()
            ui.set(ref_enabled, true)
        end
        
        function unsafe_recharge.on_shutdown()
            if should_override then
                unsafe_recharge.restore_values()
                should_override = false
            end
        end
        
        function unsafe_recharge.on_setup_command()
            if not ui.get(ui_settings.unsafe_recharge_ref) then return end
            local me = entity.get_local_player()
            local weapon = entity.get_player_weapon(me)

            if unsafe_recharge.should_change(me, weapon) then
                if not should_override then
                    unsafe_recharge.update_values()
                    should_override = true
                end
            else
                if should_override then
                    unsafe_recharge.restore_values()
                    should_override = false
                end
            end
        end
    end
    miscellaneous.unsafe_recharge = unsafe_recharge
    local enemy_chat_reveal do
        enemy_chat_reveal = { }
        
        local chat = require "gamesense/chat"
        local localize = require "gamesense/localize"
        
        local GameStateAPI = panorama.open().GameStateAPI
        local lastChatMessage = {}
        
        local function on_play_say(e)
            if not ui.get(ui_settings.enemy_chat_reveal) then return end
            
            local sender = client.userid_to_entindex(e.userid)
            if not entity.is_enemy(sender) then return end

            if GameStateAPI.IsSelectedPlayerMuted(GameStateAPI.GetPlayerXuidStringFromEntIndex(sender)) then return end

            client.delay_call(0.2, function()
                if lastChatMessage[sender] ~= nil and math.abs(globals.realtime() - lastChatMessage[sender]) < 0.4 then
                    return
                end

                local enemyTeamName = entity.get_prop(entity.get_player_resource(), "m_iTeam", sender) == 2 and "T" or "CT"

                local placeName = entity.get_prop(sender, "m_szLastPlaceName")
                local enemyName = entity.get_player_name(sender)
                
                local localizeStr = ("Cstrike_Chat_%s_%s"):format(enemyTeamName, entity.is_alive(sender) and "Loc" or "Dead")
                local msg = localize(localizeStr, {
                    s1 = enemyName,
                    s2 = e.text,
                    s3 = localize(placeName ~= "" and placeName or "UI_Unknown")
                })

                chat.print_player(sender, msg)
            end)
        end
        
        local function on_play_chat(e)
            if not ui.get(ui_settings.enemy_chat_reveal) then return end
            
            if not entity.is_enemy(e.entity) then return end
            lastChatMessage[e.entity] = globals.realtime()
        end
        
        function enemy_chat_reveal.on_toggle()
            local update_callback = ui.get(ui_settings.enemy_chat_reveal) and client.set_event_callback or client.unset_event_callback
            update_callback("player_say", on_play_say)
            update_callback("player_chat", on_play_chat)
        end
        
        function enemy_chat_reveal.on_shutdown()
            client.unset_event_callback("player_say", on_play_say)
            client.unset_event_callback("player_chat", on_play_chat)
        end
        
        ui.set_callback(ui_settings.enemy_chat_reveal, enemy_chat_reveal.on_toggle)
    end

    miscellaneous.enemy_chat_reveal = enemy_chat_reveal
end

local ui_visibility do
    ui_visibility = {}
    
    function ui_visibility.on_paint_ui()
        if ui.is_menu_open() then
            
            ui.set_visible(reference.leg_movement, false)
            ui.set_visible(reference.pitch[1], false)
            ui.set_visible(reference.pitch[2], false)
            ui.set_visible(reference.yaw_base, false)
            ui.set_visible(reference.yaw[1], false)
            ui.set_visible(reference.yaw[2], false)
            ui.set_visible(reference.yaw_jitter[1], false)
            ui.set_visible(reference.yaw_jitter[2], false)
            ui.set_visible(reference.body_yaw[1], false)
            ui.set_visible(reference.body_yaw[2], false)
            ui.set_visible(reference.freestanding_body_yaw, false)
            ui.set_visible(reference.roll, false)
            ui.set_visible(reference.edge_yaw, false)
            ui.set_visible(reference.freestanding[1], false)
            ui.set_visible(reference.freestanding[2], false)

            ui.set_visible(reference.fake_peek[1], false)
            ui.set_visible(reference.fake_peek[2], false)
            ui.set_visible(reference.on_shot_anti_aim[1], false)
            ui.set_visible(reference.on_shot_anti_aim[2], false)
            ui.set_visible(reference.leg_movement, false)
            ui.set_visible(reference.slow_motion[1], false)
            ui.set_visible(reference.slow_motion[2], false)
            ui.set_visible(reference.fakelag[1], false)
            ui.set_visible(reference.fakelag[2], false)
            ui.set_visible(reference.fakelag_amount, false)
            ui.set_visible(reference.fakelag_variance, false)
            ui.set_visible(reference.fakelag_limit, false)

            local current_tab = ui.get(ui_settings.current_tab)
            local tab_aa = ui.get(ui_settings.fake_lag_tab_antiaim)
            
            ui.set_visible(ui_settings.fake_lag_tab_antiaim, current_tab == 'Anti-Aim')

            ui.set_visible(ui_settings.text2, current_tab == 'Home')
            ui.set_visible(ui_settings.text4, current_tab == 'Home')
            ui.set_visible(ui_settings.text12, current_tab == 'Home')
            ui.set_visible(ui_settings.coder, current_tab == 'Home')
            ui.set_visible(ui_settings.owner, current_tab == 'Home')
            ui.set_visible(ui_settings.update_log, current_tab == 'Home')
            ui.set_visible(ui_settings.update_log_1, current_tab == 'Home')
            ui.set_visible(ui_settings.update_log_2, current_tab == 'Home')
            ui.set_visible(ui_settings.update_log_3, current_tab == 'Home')
            ui.set_visible(ui_settings.update_log_4, current_tab == 'Home')
            ui.set_visible(ui_settings.update_log_poloska, current_tab == 'Home')

            ui.set_visible(ui_settings.import_config_btn, current_tab == 'Home')
            ui.set_visible(ui_settings.export_config_btn, current_tab == 'Home')
            ui.set_visible(ui_settings.config_name_input, current_tab == 'Home')
            ui.set_visible(ui_settings.config_list, current_tab == 'Home')
            ui.set_visible(ui_settings.load_config_btn, current_tab == 'Home')
            ui.set_visible(ui_settings.delete_config_btn, current_tab == 'Home')
            ui.set_visible(ui_settings.save_config_btn, current_tab == 'Home')
            
            ui.set_visible(ui_settings.anti_aim_state, current_tab == 'Anti-Aim')
            
            ui.set_visible(ui_settings.warmup_disabler, current_tab == 'Anti-Aim' and tab_aa == 'Keybinds')
            ui.set_visible(ui_settings.avoid_backstab, current_tab == 'Anti-Aim' and tab_aa == 'Keybinds')
            ui.set_visible(ui_settings.safe_head_in_air, current_tab == 'Anti-Aim' and tab_aa == 'Keybinds')
            ui.set_visible(ui_settings.manual_forward, current_tab == 'Anti-Aim' and tab_aa == 'Keybinds')
            ui.set_visible(ui_settings.manual_right, current_tab == 'Anti-Aim' and tab_aa == 'Keybinds')
            ui.set_visible(ui_settings.manual_left, current_tab == 'Anti-Aim' and tab_aa == 'Keybinds')
            ui.set_visible(ui_settings.manual_reset, current_tab == 'Anti-Aim' and tab_aa == 'Keybinds')
            ui.set_visible(ui_settings.edge_yaw, current_tab == 'Anti-Aim' and tab_aa == 'Keybinds')
            ui.set_visible(ui_settings.freestanding, current_tab == 'Anti-Aim' and tab_aa == 'Keybinds')
            ui.set_visible(ui_settings.freestanding_conditions, current_tab == 'Anti-Aim' and tab_aa == 'Keybinds')
            ui.set_visible(ui_settings.tweaks, current_tab == 'Anti-Aim' and tab_aa == 'Keybinds')

            ui.set_visible(ui_settings.fakelag_switch, current_tab == 'Anti-Aim' and tab_aa == 'Fake Lags')
            ui.set_visible(ui_settings.fakelag_amount_combobox, current_tab == 'Anti-Aim' and tab_aa == 'Fake Lags')
            ui.set_visible(ui_settings.fakelag_variance_slider, current_tab == 'Anti-Aim' and tab_aa == 'Fake Lags')
            ui.set_visible(ui_settings.fakelag_limit_slider, current_tab == 'Anti-Aim' and tab_aa == 'Fake Lags')
            
            local anti_aim_states = {'Global', 'Standing', 'Moving', 'Slow motion', 'Crouching', 
                            'Crouching & moving', 'In air', 'In air & crouching', 'On use', 'On peek'}

            local current_state = ui.get(ui_settings.anti_aim_state)
            local other_tab_aa = ui.get(ui_settings.other_tab_antiaim)
            local other_tab_misc = ui.get(ui_settings.other_tab_misc)
            ui.set_visible(ui_settings.other_tab_misc, current_tab == 'Tennezza')
            ui.set_visible(ui_settings.text10, current_tab == 'Tennezza')
             for i = 1, #anti_aim_states do
                local is_current_state = current_state == anti_aim_states[i] and current_tab == 'Anti-Aim'
                local settings = ui_settings.anti_aim_settings[i]
                
                ui.set_visible(settings.override_state, is_current_state and i ~= 1)
                ui.set_visible(settings.yaw_random, is_current_state and ui.get(settings.yaw_jitter_type) ~= 'Off')
                ui.set_visible(settings.yaw_random_checkbox, is_current_state)
                ui.set_visible(settings.text, is_current_state)
                ui.set_visible(settings.yaw_left_random, is_current_state and ui.get(settings.yaw_random_checkbox))
                ui.set_visible(settings.yaw_right_random, is_current_state and ui.get(settings.yaw_random_checkbox))
                ui.set_visible(settings.yaw_base, is_current_state)
                ui.set_visible(settings.yaw_left, is_current_state)
                ui.set_visible(settings.yaw_right, is_current_state)
                ui.set_visible(settings.yaw_jitter_type, is_current_state)
                ui.set_visible(settings.yaw_jitter_offset, is_current_state and ui.get(settings.yaw_jitter_type) ~= '5-Ways' and ui.get(settings.yaw_jitter_type) ~= '3-Ways' and ui.get(settings.yaw_jitter_type) ~= 'Off')
                ui.set_visible(settings.yaw_way1, is_current_state and (ui.get(settings.yaw_jitter_type) == '3-Ways' or ui.get(settings.yaw_jitter_type) == '5-Ways'))
                ui.set_visible(settings.yaw_way2, is_current_state and (ui.get(settings.yaw_jitter_type) == '3-Ways' or ui.get(settings.yaw_jitter_type) == '5-Ways'))
                ui.set_visible(settings.yaw_way3, is_current_state and (ui.get(settings.yaw_jitter_type) == '3-Ways' or ui.get(settings.yaw_jitter_type) == '5-Ways'))
                ui.set_visible(settings.yaw_way4, is_current_state and ui.get(settings.yaw_jitter_type) == '5-Ways')
                ui.set_visible(settings.yaw_way5, is_current_state and ui.get(settings.yaw_jitter_type) == '5-Ways')
                
                ui.set_visible(settings.body_yaw_type, is_current_state)
                ui.set_visible(settings.body_yaw_value, is_current_state and (ui.get(settings.body_yaw_type) == 'Static' or ui.get(settings.body_yaw_type) == 'Jitter' or ui.get(settings.body_yaw_type) == 'Sway'))
                ui.set_visible(settings.yaw_delay, is_current_state and ui.get(settings.body_yaw_type) ~= 'Off' and ui.get(settings.body_yaw_type) ~= 'Sway')
                ui.set_visible(settings.body_checkbox, is_current_state and ui.get(settings.body_yaw_type) ~= 'Off')
                ui.set_visible(settings.yaw_delay_random, is_current_state and ui.get(settings.body_checkbox) and ui.get(settings.body_yaw_type) ~= 'Sway')
                ui.set_visible(settings.body_yaw_value_random, is_current_state and ui.get(settings.body_checkbox))
                ui.set_visible(settings.freestanding_body_yaw, is_current_state)
                ui.set_visible(settings.force_defensive, is_current_state and i ~= 9)
                ui.set_visible(settings.override_defensive, is_current_state and other_tab_aa == "Defensive Builder")
                ui.set_visible(settings.options, is_current_state)
                ui.set_visible(settings.smart_hide_strength, is_current_state and utility.contains(settings.options, 'Smart hide real yaw'))
                ui.set_visible(settings.defensive_jitter_type, is_current_state and other_tab_aa == "Defensive Builder" and ui.get(settings.override_defensive))
                ui.set_visible(settings.defensive_jitter_offset, is_current_state and other_tab_aa == "Defensive Builder" and ui.get(settings.override_defensive) and ui.get(settings.defensive_jitter_type) ~= 'Off')
                ui.set_visible(settings.defensive_yaw_random, is_current_state and other_tab_aa == "Defensive Builder" and ui.get(settings.override_defensive) and ui.get(settings.defensive_jitter_type) ~= 'Off')
                ui.set_visible(settings.defensive_jitter_delay, is_current_state and other_tab_aa == "Defensive Builder" and ui.get(settings.override_defensive) and (ui.get(settings.defensive_jitter_type) ~= 'Off' and ui.get(settings.defensive_jitter_type) ~= 'Static' and ui.get(settings.defensive_jitter_type) ~= 'Spin' and ui.get(settings.defensive_jitter_type) ~= 'Random'))
                ui.set_visible(settings.defensive_jitter_delay_random, is_current_state and other_tab_aa == "Defensive Builder" and ui.get(settings.override_defensive) and (ui.get(settings.defensive_jitter_type) ~= 'Off' and ui.get(settings.defensive_jitter_type) ~= 'Static' and ui.get(settings.defensive_jitter_type) ~= 'Spin' and ui.get(settings.defensive_jitter_type) ~= 'Random'))
                ui.set_visible(settings.defensive_pitch_type, is_current_state and other_tab_aa == "Defensive Builder" and ui.get(settings.override_defensive))
                ui.set_visible(settings.defensive_pitch_offset, is_current_state and other_tab_aa == "Defensive Builder" and ui.get(settings.override_defensive) and (ui.get(settings.defensive_pitch_type) == 'Custom' or ui.get(settings.defensive_pitch_type) == 'Sway'))
                ui.set_visible(settings.defensive_pitch_offset_speed, is_current_state and other_tab_aa == "Defensive Builder" and ui.get(settings.override_defensive) and ui.get(settings.defensive_pitch_type) == 'Sway')
                ui.set_visible(settings.defensive_pitch_jitter_1, is_current_state and other_tab_aa == "Defensive Builder" and ui.get(settings.override_defensive) and (ui.get(settings.defensive_pitch_type) ~= 'Custom' and ui.get(settings.defensive_pitch_type) ~= 'Sway' and ui.get(settings.defensive_pitch_type) ~= 'Off'))
                ui.set_visible(settings.defensive_pitch_jitter_2, is_current_state and other_tab_aa == "Defensive Builder" and ui.get(settings.override_defensive) and (ui.get(settings.defensive_pitch_type) ~= 'Custom' and ui.get(settings.defensive_pitch_type) ~= 'Sway' and ui.get(settings.defensive_pitch_type) ~= 'Off'))
                ui.set_visible(settings.defensive_pitch_random, is_current_state and other_tab_aa == "Defensive Builder" and ui.get(settings.override_defensive) and ui.get(settings.defensive_pitch_type) ~= 'Off')
                ui.set_visible(settings.defensive_pitch_delay, is_current_state and other_tab_aa == "Defensive Builder" and ui.get(settings.override_defensive) and ui.get(settings.defensive_pitch_type) == 'Jitter')
                ui.set_visible(settings.defensive_pitch_delay_random, is_current_state and other_tab_aa == "Defensive Builder" and ui.get(settings.override_defensive) and ui.get(settings.defensive_pitch_type) == 'Jitter')
                ui.set_visible(settings.anti_brute_force_enabled, is_current_state and other_tab_aa == "Anti BruteForce")
                ui.set_visible(settings.anti_brute_force_enabled, is_current_state and other_tab_aa == "Anti BruteForce")
                ui.set_visible(settings.anti_brute_force_mode, is_current_state and other_tab_aa == "Anti BruteForce" and ui.get(settings.anti_brute_force_enabled))
                ui.set_visible(settings.anti_brute_force_strength, is_current_state and other_tab_aa == "Anti BruteForce" and ui.get(settings.anti_brute_force_enabled))
                ui.set_visible(settings.anti_brute_force_reset_delay, is_current_state and other_tab_aa == "Anti BruteForce" and ui.get(settings.anti_brute_force_enabled))
                ui.set_visible(settings.anti_brute_force_miss_threshold, is_current_state and other_tab_aa == "Anti BruteForce" and ui.get(settings.anti_brute_force_enabled))
                ui.set_visible(settings.anti_brute_force_jitter_strength, is_current_state and other_tab_aa == "Anti BruteForce" and ui.get(settings.anti_brute_force_enabled))
                ui.set_visible(settings.anti_brute_force_yaw_range, is_current_state and other_tab_aa == "Anti BruteForce" and ui.get(settings.anti_brute_force_enabled))
            end

            ui.set_visible(ui_settings.other_tab_antiaim, current_tab == 'Anti-Aim')
            
            ui.set_visible(ui_settings.text9, true)
            ui.set_visible(ui_settings.console_filter, current_tab == 'Tennezza' and other_tab_misc == 'Other')
            ui.set_visible(ui_settings.minimumdamage, current_tab == 'Tennezza' and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.minimumdamage_font, current_tab == 'Tennezza' and ui.get(ui_settings.minimumdamage) and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.hitmarker, current_tab == 'Tennezza' and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.aspectratio, current_tab == 'Tennezza' and other_tab_misc == 'Other')
            ui.set_visible(ui_settings.thirdperson, current_tab == 'Tennezza' and other_tab_misc == 'Other')
            ui.set_visible(ui_settings.watermarkpos, current_tab == 'Tennezza' and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.watermark_color, current_tab == 'Tennezza' and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.watermarkpos_font, current_tab == 'Tennezza' and ui.get(ui_settings.watermarkpos) ~= 'Off' and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.userwatermark, current_tab == 'Tennezza' and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.pos1, current_tab == 'Tennezza' and ui.get(ui_settings.userwatermark) and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.pos2, current_tab == 'Tennezza' and ui.get(ui_settings.userwatermark) and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.watermark_name, current_tab == 'Tennezza' and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.zoom_animation, current_tab == 'Tennezza' and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.camera_animation, current_tab == 'Tennezza' and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.anim_breakerx, current_tab == 'Tennezza')
            ui.set_visible(ui_settings.m_elements, current_tab == 'Tennezza')
            ui.set_visible(ui_settings.custom_scope, current_tab == 'Tennezza' and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.color_picker, current_tab == 'Tennezza' and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.indicators_color_picker, current_tab == 'Tennezza' and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.overlay_position, current_tab == 'Tennezza' and ui.get(ui_settings.custom_scope) and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.overlay_offset, current_tab == 'Tennezza' and ui.get(ui_settings.custom_scope) and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.scope_pos, current_tab == 'Tennezza' and ui.get(ui_settings.custom_scope) and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.scope_spin_enabled, current_tab == 'Tennezza' and other_tab_misc == 'Visuals' and ui.get(ui_settings.custom_scope))
            ui.set_visible(ui_settings.scope_spin_speed, current_tab == 'Tennezza' and other_tab_misc == 'Visuals' and ui.get(ui_settings.custom_scope) and ui.get(ui_settings.scope_spin_enabled))
            ui.set_visible(ui_settings.scope_spin_direction, current_tab == 'Tennezza' and other_tab_misc == 'Visuals' and ui.get(ui_settings.custom_scope) and ui.get(ui_settings.scope_spin_enabled))


            if ui.get(ui_settings.other_tab_antiaim) == 'Gamesense' and ui.get(ui_settings.current_tab) == 'Anti-Aim' then
                ui.set_visible(reference.fake_peek[1], true)
                ui.set_visible(reference.fake_peek[2], true)
                ui.set_visible(reference.on_shot_anti_aim[1], true)
                ui.set_visible(reference.on_shot_anti_aim[2], true)
                ui.set_visible(reference.slow_motion[1], true)
                ui.set_visible(reference.slow_motion[2], true)
            else
                ui.set_visible(reference.fake_peek[1], false)
                ui.set_visible(reference.fake_peek[2], false)
                ui.set_visible(reference.on_shot_anti_aim[1], false)
                ui.set_visible(reference.on_shot_anti_aim[2], false)
                ui.set_visible(reference.slow_motion[1], false)
                ui.set_visible(reference.slow_motion[2], false)
            end

            ui.set_visible(ui_settings.resolver, current_tab == 'Anti-Aim' and tab_aa == 'Utilities')
            ui.set_visible(ui_settings.dt_fix, current_tab == 'Anti-Aim' and tab_aa == 'Utilities')
            ui.set_visible(ui_settings.dt_fix_indicator, current_tab == 'Anti-Aim' and ui.get(ui_settings.dt_fix) and tab_aa == 'Utilities')
            ui.set_visible(ui_settings.offdtonhs, current_tab == 'Anti-Aim' and tab_aa == 'Utilities')
            ui.set_visible(ui_settings.fastladder, current_tab == 'Tennezza' and other_tab_misc == 'Other')
            ui.set_visible(ui_settings.autostop_fix, current_tab == 'Anti-Aim' and tab_aa == 'Utilities')
            ui.set_visible(ui_settings.fps_boost, current_tab == 'Tennezza' and other_tab_misc == 'Other')
            ui.set_visible(ui_settings.unsafe_recharge_ref, current_tab == 'Anti-Aim' and tab_aa == 'Utilities')
            ui.set_visible(ui_settings.trashtalk, current_tab == 'Tennezza' and other_tab_misc == 'Other')
            ui.set_visible(ui_settings.trashtalk_type, current_tab == 'Tennezza' and ui.get(ui_settings.trashtalk) and other_tab_misc == 'Other')
            ui.set_visible(ui_settings.clantagchanger, current_tab == 'Tennezza' and other_tab_misc == 'Other')
            ui.set_visible(ui_settings.enemy_chat_reveal, current_tab == 'Tennezza' and other_tab_misc == 'Other')

            
            ui.set_visible(ui_settings.logaimbotcheckbox, current_tab == 'Tennezza' and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.logaimbot_pos_y, current_tab == 'Tennezza' and ui.get(ui_settings.logaimbotcheckbox) and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.logaimbot, current_tab == 'Tennezza' and ui.get(ui_settings.logaimbotcheckbox) and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.logaimbot_text1, current_tab == 'Tennezza' and ui.get(ui_settings.logaimbotcheckbox) and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.logaimbot_text2, current_tab == 'Tennezza' and ui.get(ui_settings.logaimbotcheckbox) and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.miss_color, current_tab == 'Tennezza' and ui.get(ui_settings.logaimbotcheckbox) and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.hit_color, current_tab == 'Tennezza' and ui.get(ui_settings.logaimbotcheckbox) and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.hitlog_style, current_tab == 'Tennezza' and ui.get(ui_settings.logaimbotcheckbox) and other_tab_misc == 'Visuals')


            ui.set_visible(ui_settings.anti_aim_settings[1].override_state, false)
            ui.set_visible(ui_settings.anti_aim_settings[9].force_defensive, false)
            
            ui.set_visible(ui_settings.staticlegweight, utility.contains(ui_settings.m_elements, "static legs in air") and current_tab == 'Tennezza')
            ui.set_visible(ui_settings.legoffset1, utility.contains(ui_settings.m_elements, "Pacan4ik") and current_tab == 'Tennezza')
            ui.set_visible(ui_settings.legoffset2, utility.contains(ui_settings.m_elements, "Pacan4ik") and current_tab == 'Tennezza')

            ui.set_visible(ui_settings.watermark_name, ui.get(ui_settings.watermarkpos) ~= 'Off' and current_tab == 'Tennezza' and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.indicators, current_tab == 'Tennezza' and other_tab_misc == 'Visuals')
            ui.set_visible(ui_settings.indicators_exclude, current_tab == 'Tennezza' and ui.get(ui_settings.indicators) and other_tab_misc == 'Visuals')

            ui.set_visible(ui_settings.grenade_trail_master, current_tab == 'Tennezza')
            ui.set_visible(ui_settings.grenade_trail_color, current_tab == 'Tennezza' and ui.get(ui_settings.grenade_trail_master))
            ui.set_visible(ui_settings.grenade_trail_thickness, current_tab == 'Tennezza' and ui.get(ui_settings.grenade_trail_master))
            ui.set_visible(ui_settings.grenade_trail_glow, current_tab == 'Tennezza' and ui.get(ui_settings.grenade_trail_master))
            ui.set_visible(ui_settings.grenade_trail_fade, current_tab == 'Tennezza' and ui.get(ui_settings.grenade_trail_master))
        end
    end
end
local config_to_load = nil




local config_manager do
    config_manager = {}
    
    local CONFIG_FILE = "tennezza_config.json"
    local configs = {}
    local current_config_name = nil
    
    local data = { 
        integers = {
            ui_settings.anti_aim_state,
            ui_settings.anti_aim_settings[1].override_state, 
            ui_settings.anti_aim_settings[2].override_state, 
            ui_settings.anti_aim_settings[3].override_state, 
            ui_settings.anti_aim_settings[4].override_state, 
            ui_settings.anti_aim_settings[5].override_state, 
            ui_settings.anti_aim_settings[6].override_state, 
            ui_settings.anti_aim_settings[7].override_state, 
            ui_settings.anti_aim_settings[8].override_state, 
            ui_settings.anti_aim_settings[9].override_state, 
            ui_settings.anti_aim_settings[10].override_state, 
            ui_settings.anti_aim_settings[1].force_defensive, 
            ui_settings.anti_aim_settings[2].force_defensive, 
            ui_settings.anti_aim_settings[3].force_defensive, 
            ui_settings.anti_aim_settings[4].force_defensive,
            ui_settings.anti_aim_settings[5].force_defensive, 
            ui_settings.anti_aim_settings[6].force_defensive, 
            ui_settings.anti_aim_settings[7].force_defensive, 
            ui_settings.anti_aim_settings[8].force_defensive, 
            ui_settings.anti_aim_settings[9].force_defensive, 
            ui_settings.anti_aim_settings[10].force_defensive,
            ui_settings.anti_aim_settings[1].yaw_base, 
            ui_settings.anti_aim_settings[2].yaw_base, 
            ui_settings.anti_aim_settings[3].yaw_base, 
            ui_settings.anti_aim_settings[4].yaw_base, 
            ui_settings.anti_aim_settings[5].yaw_base, 
            ui_settings.anti_aim_settings[6].yaw_base, 
            ui_settings.anti_aim_settings[7].yaw_base, 
            ui_settings.anti_aim_settings[8].yaw_base,
            ui_settings.anti_aim_settings[9].yaw_base, 
            ui_settings.anti_aim_settings[10].yaw_base,
            ui_settings.anti_aim_settings[1].yaw_left, 
            ui_settings.anti_aim_settings[2].yaw_left, 
            ui_settings.anti_aim_settings[3].yaw_left, 
            ui_settings.anti_aim_settings[4].yaw_left, 
            ui_settings.anti_aim_settings[5].yaw_left, 
            ui_settings.anti_aim_settings[6].yaw_left, 
            ui_settings.anti_aim_settings[7].yaw_left, 
            ui_settings.anti_aim_settings[8].yaw_left, 
            ui_settings.anti_aim_settings[9].yaw_left, 
            ui_settings.anti_aim_settings[10].yaw_left, 
            ui_settings.anti_aim_settings[1].yaw_left_random, 
            ui_settings.anti_aim_settings[2].yaw_left_random, 
            ui_settings.anti_aim_settings[3].yaw_left_random, 
            ui_settings.anti_aim_settings[4].yaw_left_random, 
            ui_settings.anti_aim_settings[5].yaw_left_random, 
            ui_settings.anti_aim_settings[6].yaw_left_random, 
            ui_settings.anti_aim_settings[7].yaw_left_random, 
            ui_settings.anti_aim_settings[8].yaw_left_random, 
            ui_settings.anti_aim_settings[9].yaw_left_random, 
            ui_settings.anti_aim_settings[10].yaw_left_random, 
            ui_settings.anti_aim_settings[1].yaw_random_checkbox, 
            ui_settings.anti_aim_settings[2].yaw_random_checkbox, 
            ui_settings.anti_aim_settings[3].yaw_random_checkbox, 
            ui_settings.anti_aim_settings[4].yaw_random_checkbox, 
            ui_settings.anti_aim_settings[5].yaw_random_checkbox, 
            ui_settings.anti_aim_settings[6].yaw_random_checkbox, 
            ui_settings.anti_aim_settings[7].yaw_random_checkbox, 
            ui_settings.anti_aim_settings[8].yaw_random_checkbox, 
            ui_settings.anti_aim_settings[9].yaw_random_checkbox, 
            ui_settings.anti_aim_settings[10].yaw_random_checkbox, 
            ui_settings.anti_aim_settings[1].yaw_right, 
            ui_settings.anti_aim_settings[2].yaw_right, 
            ui_settings.anti_aim_settings[3].yaw_right, 
            ui_settings.anti_aim_settings[4].yaw_right, 
            ui_settings.anti_aim_settings[5].yaw_right, 
            ui_settings.anti_aim_settings[6].yaw_right, 
            ui_settings.anti_aim_settings[7].yaw_right, 
            ui_settings.anti_aim_settings[8].yaw_right, 
            ui_settings.anti_aim_settings[9].yaw_right, 
            ui_settings.anti_aim_settings[10].yaw_right, 
            ui_settings.anti_aim_settings[1].yaw_right_random, 
            ui_settings.anti_aim_settings[2].yaw_right_random, 
            ui_settings.anti_aim_settings[3].yaw_right_random, 
            ui_settings.anti_aim_settings[4].yaw_right_random, 
            ui_settings.anti_aim_settings[5].yaw_right_random, 
            ui_settings.anti_aim_settings[6].yaw_right_random, 
            ui_settings.anti_aim_settings[7].yaw_right_random, 
            ui_settings.anti_aim_settings[8].yaw_right_random, 
            ui_settings.anti_aim_settings[9].yaw_right_random, 
            ui_settings.anti_aim_settings[10].yaw_right_random, 
            ui_settings.anti_aim_settings[1].yaw_delay, 
            ui_settings.anti_aim_settings[2].yaw_delay, 
            ui_settings.anti_aim_settings[3].yaw_delay, 
            ui_settings.anti_aim_settings[4].yaw_delay, 
            ui_settings.anti_aim_settings[5].yaw_delay, 
            ui_settings.anti_aim_settings[6].yaw_delay, 
            ui_settings.anti_aim_settings[7].yaw_delay, 
            ui_settings.anti_aim_settings[8].yaw_delay, 
            ui_settings.anti_aim_settings[9].yaw_delay, 
            ui_settings.anti_aim_settings[10].yaw_delay,
            ui_settings.anti_aim_settings[1].yaw_jitter_offset,   
            ui_settings.anti_aim_settings[2].yaw_jitter_offset, 
            ui_settings.anti_aim_settings[3].yaw_jitter_offset, 
            ui_settings.anti_aim_settings[4].yaw_jitter_offset, 
            ui_settings.anti_aim_settings[5].yaw_jitter_offset, 
            ui_settings.anti_aim_settings[6].yaw_jitter_offset, 
            ui_settings.anti_aim_settings[7].yaw_jitter_offset, 
            ui_settings.anti_aim_settings[8].yaw_jitter_offset, 
            ui_settings.anti_aim_settings[9].yaw_jitter_offset, 
            ui_settings.anti_aim_settings[10].yaw_jitter_offset, 
            ui_settings.anti_aim_settings[1].yaw_jitter_type, 
            ui_settings.anti_aim_settings[2].yaw_jitter_type, 
            ui_settings.anti_aim_settings[3].yaw_jitter_type, 
            ui_settings.anti_aim_settings[4].yaw_jitter_type, 
            ui_settings.anti_aim_settings[5].yaw_jitter_type, 
            ui_settings.anti_aim_settings[6].yaw_jitter_type, 
            ui_settings.anti_aim_settings[7].yaw_jitter_type, 
            ui_settings.anti_aim_settings[8].yaw_jitter_type, 
            ui_settings.anti_aim_settings[9].yaw_jitter_type, 
            ui_settings.anti_aim_settings[10].yaw_jitter_type, 
            ui_settings.anti_aim_settings[1].yaw_way1, 
            ui_settings.anti_aim_settings[2].yaw_way1, 
            ui_settings.anti_aim_settings[3].yaw_way1, 
            ui_settings.anti_aim_settings[4].yaw_way1, 
            ui_settings.anti_aim_settings[5].yaw_way1, 
            ui_settings.anti_aim_settings[6].yaw_way1, 
            ui_settings.anti_aim_settings[7].yaw_way1, 
            ui_settings.anti_aim_settings[8].yaw_way1, 
            ui_settings.anti_aim_settings[9].yaw_way1, 
            ui_settings.anti_aim_settings[10].yaw_way1, 
            ui_settings.anti_aim_settings[1].yaw_way2, 
            ui_settings.anti_aim_settings[2].yaw_way2, 
            ui_settings.anti_aim_settings[3].yaw_way2, 
            ui_settings.anti_aim_settings[4].yaw_way2, 
            ui_settings.anti_aim_settings[5].yaw_way2, 
            ui_settings.anti_aim_settings[6].yaw_way2,
            ui_settings.anti_aim_settings[7].yaw_way2, 
            ui_settings.anti_aim_settings[8].yaw_way2, 
            ui_settings.anti_aim_settings[9].yaw_way2, 
            ui_settings.anti_aim_settings[10].yaw_way2, 
            ui_settings.anti_aim_settings[1].yaw_way3, 
            ui_settings.anti_aim_settings[2].yaw_way3, 
            ui_settings.anti_aim_settings[3].yaw_way3, 
            ui_settings.anti_aim_settings[4].yaw_way3, 
            ui_settings.anti_aim_settings[5].yaw_way3, 
            ui_settings.anti_aim_settings[6].yaw_way3, 
            ui_settings.anti_aim_settings[7].yaw_way3, 
            ui_settings.anti_aim_settings[8].yaw_way3, 
            ui_settings.anti_aim_settings[9].yaw_way3, 
            ui_settings.anti_aim_settings[10].yaw_way3, 
            ui_settings.anti_aim_settings[1].yaw_way4, 
            ui_settings.anti_aim_settings[2].yaw_way4, 
            ui_settings.anti_aim_settings[3].yaw_way4, 
            ui_settings.anti_aim_settings[4].yaw_way4, 
            ui_settings.anti_aim_settings[5].yaw_way4, 
            ui_settings.anti_aim_settings[6].yaw_way4, 
            ui_settings.anti_aim_settings[7].yaw_way4, 
            ui_settings.anti_aim_settings[8].yaw_way4, 
            ui_settings.anti_aim_settings[9].yaw_way4, 
            ui_settings.anti_aim_settings[10].yaw_way4, 
            ui_settings.anti_aim_settings[1].yaw_way5, 
            ui_settings.anti_aim_settings[2].yaw_way5, 
            ui_settings.anti_aim_settings[3].yaw_way5, 
            ui_settings.anti_aim_settings[4].yaw_way5, 
            ui_settings.anti_aim_settings[5].yaw_way5, 
            ui_settings.anti_aim_settings[6].yaw_way5, 
            ui_settings.anti_aim_settings[7].yaw_way5, 
            ui_settings.anti_aim_settings[8].yaw_way5, 
            ui_settings.anti_aim_settings[9].yaw_way5, 
            ui_settings.anti_aim_settings[10].yaw_way5, 
            ui_settings.anti_aim_settings[1].body_yaw_type, 
            ui_settings.anti_aim_settings[2].body_yaw_type, 
            ui_settings.anti_aim_settings[3].body_yaw_type, 
            ui_settings.anti_aim_settings[4].body_yaw_type, 
            ui_settings.anti_aim_settings[5].body_yaw_type, 
            ui_settings.anti_aim_settings[6].body_yaw_type, 
            ui_settings.anti_aim_settings[7].body_yaw_type, 
            ui_settings.anti_aim_settings[8].body_yaw_type, 
            ui_settings.anti_aim_settings[9].body_yaw_type, 
            ui_settings.anti_aim_settings[10].body_yaw_type, 
            ui_settings.anti_aim_settings[1].body_yaw_value, 
            ui_settings.anti_aim_settings[2].body_yaw_value, 
            ui_settings.anti_aim_settings[3].body_yaw_value, 
            ui_settings.anti_aim_settings[4].body_yaw_value, 
            ui_settings.anti_aim_settings[5].body_yaw_value, 
            ui_settings.anti_aim_settings[6].body_yaw_value, 
            ui_settings.anti_aim_settings[7].body_yaw_value, 
            ui_settings.anti_aim_settings[8].body_yaw_value,
            ui_settings.anti_aim_settings[9].body_yaw_value,
            ui_settings.anti_aim_settings[10].body_yaw_value,
            ui_settings.anti_aim_settings[1].freestanding_body_yaw, 
            ui_settings.anti_aim_settings[2].freestanding_body_yaw, 
            ui_settings.anti_aim_settings[3].freestanding_body_yaw, 
            ui_settings.anti_aim_settings[4].freestanding_body_yaw, 
            ui_settings.anti_aim_settings[5].freestanding_body_yaw, 
            ui_settings.anti_aim_settings[6].freestanding_body_yaw, 
            ui_settings.anti_aim_settings[7].freestanding_body_yaw, 
            ui_settings.anti_aim_settings[8].freestanding_body_yaw, 
            ui_settings.anti_aim_settings[9].freestanding_body_yaw, 
            ui_settings.anti_aim_settings[10].freestanding_body_yaw, 
            ui_settings.anti_aim_settings[1].body_checkbox, 
            ui_settings.anti_aim_settings[2].body_checkbox, 
            ui_settings.anti_aim_settings[3].body_checkbox, 
            ui_settings.anti_aim_settings[4].body_checkbox, 
            ui_settings.anti_aim_settings[5].body_checkbox, 
            ui_settings.anti_aim_settings[6].body_checkbox, 
            ui_settings.anti_aim_settings[7].body_checkbox, 
            ui_settings.anti_aim_settings[8].body_checkbox, 
            ui_settings.anti_aim_settings[9].body_checkbox, 
            ui_settings.anti_aim_settings[10].body_yaw_value_random, 
            ui_settings.anti_aim_settings[1].body_yaw_value_random, 
            ui_settings.anti_aim_settings[2].body_yaw_value_random, 
            ui_settings.anti_aim_settings[3].body_yaw_value_random, 
            ui_settings.anti_aim_settings[4].body_yaw_value_random, 
            ui_settings.anti_aim_settings[5].body_yaw_value_random, 
            ui_settings.anti_aim_settings[6].body_yaw_value_random, 
            ui_settings.anti_aim_settings[7].body_yaw_value_random, 
            ui_settings.anti_aim_settings[8].body_yaw_value_random, 
            ui_settings.anti_aim_settings[9].body_yaw_value_random, 
            ui_settings.anti_aim_settings[10].body_yaw_value_random, 
            ui_settings.anti_aim_settings[1].yaw_delay_random, 
            ui_settings.anti_aim_settings[2].yaw_delay_random, 
            ui_settings.anti_aim_settings[3].yaw_delay_random, 
            ui_settings.anti_aim_settings[4].yaw_delay_random, 
            ui_settings.anti_aim_settings[5].yaw_delay_random, 
            ui_settings.anti_aim_settings[6].yaw_delay_random, 
            ui_settings.anti_aim_settings[7].yaw_delay_random, 
            ui_settings.anti_aim_settings[8].yaw_delay_random, 
            ui_settings.anti_aim_settings[9].yaw_delay_random, 
            ui_settings.anti_aim_settings[10].yaw_delay_random, 
            ui_settings.avoid_backstab,
            ui_settings.safe_head_in_air,
            ui_settings.freestanding_conditions,
            ui_settings.tweaks, ui_settings.logaimbot,
            ui_settings.logaimbotcheckbox, 
            ui_settings.console_filter, ui_settings.trashtalk, 
            ui_settings.aspectratio, ui_settings.hitmarker, 
            ui_settings.fastladder, ui_settings.clantagchanger, 
            ui_settings.warmup_disabler,
            ui_settings.zoom_animation, 
            ui_settings.camera_animation, 
            ui_settings.watermarkpos, 
            ui_settings.minimumdamage,
            ui_settings.offdtonhs, 
            ui_settings.anim_breakerx, 
            ui_settings.m_elements, 
            ui_settings.staticlegweight, 
            ui_settings.legoffset1, 
            ui_settings.legoffset2, 
            ui_settings.unsafe_recharge_ref,
            ui_settings.resolver,
            ui_settings.watermark_name,
            ui_settings.userwatermark,
            ui_settings.pos1,
            ui_settings.pos2,
            ui_settings.custom_scope,
            ui_settings.overlay_position,
            ui_settings.overlay_offset,
            ui_settings.scope_pos,
            ui_settings.anti_aim_settings[1].override_defensive, 
            ui_settings.anti_aim_settings[2].override_defensive, 
            ui_settings.anti_aim_settings[3].override_defensive, 
            ui_settings.anti_aim_settings[4].override_defensive, 
            ui_settings.anti_aim_settings[5].override_defensive, 
            ui_settings.anti_aim_settings[6].override_defensive, 
            ui_settings.anti_aim_settings[7].override_defensive, 
            ui_settings.anti_aim_settings[8].override_defensive, 
            ui_settings.anti_aim_settings[9].override_defensive, 
            ui_settings.anti_aim_settings[10].override_defensive, 
            ui_settings.anti_aim_settings[1].defensive_jitter_type, 
            ui_settings.anti_aim_settings[2].defensive_jitter_type, 
            ui_settings.anti_aim_settings[3].defensive_jitter_type, 
            ui_settings.anti_aim_settings[4].defensive_jitter_type, 
            ui_settings.anti_aim_settings[5].defensive_jitter_type, 
            ui_settings.anti_aim_settings[6].defensive_jitter_type, 
            ui_settings.anti_aim_settings[7].defensive_jitter_type, 
            ui_settings.anti_aim_settings[8].defensive_jitter_type, 
            ui_settings.anti_aim_settings[9].defensive_jitter_type, 
            ui_settings.anti_aim_settings[10].defensive_jitter_type, 
            ui_settings.anti_aim_settings[1].defensive_jitter_offset, 
            ui_settings.anti_aim_settings[2].defensive_jitter_offset, 
            ui_settings.anti_aim_settings[3].defensive_jitter_offset, 
            ui_settings.anti_aim_settings[4].defensive_jitter_offset, 
            ui_settings.anti_aim_settings[5].defensive_jitter_offset, 
            ui_settings.anti_aim_settings[6].defensive_jitter_offset, 
            ui_settings.anti_aim_settings[7].defensive_jitter_offset, 
            ui_settings.anti_aim_settings[8].defensive_jitter_offset, 
            ui_settings.anti_aim_settings[9].defensive_jitter_offset, 
            ui_settings.anti_aim_settings[10].defensive_jitter_offset, 
            ui_settings.anti_aim_settings[1].defensive_yaw_random, 
            ui_settings.anti_aim_settings[2].defensive_yaw_random, 
            ui_settings.anti_aim_settings[3].defensive_yaw_random, 
            ui_settings.anti_aim_settings[4].defensive_yaw_random, 
            ui_settings.anti_aim_settings[5].defensive_yaw_random, 
            ui_settings.anti_aim_settings[6].defensive_yaw_random, 
            ui_settings.anti_aim_settings[7].defensive_yaw_random, 
            ui_settings.anti_aim_settings[8].defensive_yaw_random, 
            ui_settings.anti_aim_settings[9].defensive_yaw_random, 
            ui_settings.anti_aim_settings[10].defensive_yaw_random, 
            ui_settings.anti_aim_settings[1].defensive_jitter_delay, 
            ui_settings.anti_aim_settings[2].defensive_jitter_delay, 
            ui_settings.anti_aim_settings[3].defensive_jitter_delay, 
            ui_settings.anti_aim_settings[4].defensive_jitter_delay, 
            ui_settings.anti_aim_settings[5].defensive_jitter_delay, 
            ui_settings.anti_aim_settings[6].defensive_jitter_delay, 
            ui_settings.anti_aim_settings[7].defensive_jitter_delay, 
            ui_settings.anti_aim_settings[8].defensive_jitter_delay, 
            ui_settings.anti_aim_settings[9].defensive_jitter_delay, 
            ui_settings.anti_aim_settings[10].defensive_jitter_delay, 
            ui_settings.anti_aim_settings[1].defensive_jitter_delay_random, 
            ui_settings.anti_aim_settings[2].defensive_jitter_delay_random, 
            ui_settings.anti_aim_settings[3].defensive_jitter_delay_random, 
            ui_settings.anti_aim_settings[4].defensive_jitter_delay_random, 
            ui_settings.anti_aim_settings[5].defensive_jitter_delay_random, 
            ui_settings.anti_aim_settings[6].defensive_jitter_delay_random, 
            ui_settings.anti_aim_settings[7].defensive_jitter_delay_random, 
            ui_settings.anti_aim_settings[8].defensive_jitter_delay_random, 
            ui_settings.anti_aim_settings[9].defensive_jitter_delay_random, 
            ui_settings.anti_aim_settings[10].defensive_jitter_delay_random, 
            ui_settings.anti_aim_settings[1].defensive_pitch_type, 
            ui_settings.anti_aim_settings[2].defensive_pitch_type, 
            ui_settings.anti_aim_settings[3].defensive_pitch_type, 
            ui_settings.anti_aim_settings[4].defensive_pitch_type, 
            ui_settings.anti_aim_settings[5].defensive_pitch_type, 
            ui_settings.anti_aim_settings[6].defensive_pitch_type, 
            ui_settings.anti_aim_settings[7].defensive_pitch_type, 
            ui_settings.anti_aim_settings[8].defensive_pitch_type, 
            ui_settings.anti_aim_settings[9].defensive_pitch_type, 
            ui_settings.anti_aim_settings[10].defensive_pitch_type, 
            ui_settings.anti_aim_settings[1].defensive_pitch_offset, 
            ui_settings.anti_aim_settings[2].defensive_pitch_offset, 
            ui_settings.anti_aim_settings[3].defensive_pitch_offset, 
            ui_settings.anti_aim_settings[4].defensive_pitch_offset, 
            ui_settings.anti_aim_settings[5].defensive_pitch_offset, 
            ui_settings.anti_aim_settings[6].defensive_pitch_offset, 
            ui_settings.anti_aim_settings[7].defensive_pitch_offset, 
            ui_settings.anti_aim_settings[8].defensive_pitch_offset, 
            ui_settings.anti_aim_settings[9].defensive_pitch_offset, 
            ui_settings.anti_aim_settings[10].defensive_pitch_offset, 
            ui_settings.anti_aim_settings[1].defensive_pitch_offset_speed, 
            ui_settings.anti_aim_settings[2].defensive_pitch_offset_speed, 
            ui_settings.anti_aim_settings[3].defensive_pitch_offset_speed, 
            ui_settings.anti_aim_settings[4].defensive_pitch_offset_speed, 
            ui_settings.anti_aim_settings[5].defensive_pitch_offset_speed, 
            ui_settings.anti_aim_settings[6].defensive_pitch_offset_speed, 
            ui_settings.anti_aim_settings[7].defensive_pitch_offset_speed, 
            ui_settings.anti_aim_settings[8].defensive_pitch_offset_speed, 
            ui_settings.anti_aim_settings[9].defensive_pitch_offset_speed, 
            ui_settings.anti_aim_settings[10].defensive_pitch_offset_speed, 
            ui_settings.anti_aim_settings[1].defensive_pitch_jitter_1, 
            ui_settings.anti_aim_settings[2].defensive_pitch_jitter_1, 
            ui_settings.anti_aim_settings[3].defensive_pitch_jitter_1, 
            ui_settings.anti_aim_settings[4].defensive_pitch_jitter_1, 
            ui_settings.anti_aim_settings[5].defensive_pitch_jitter_1, 
            ui_settings.anti_aim_settings[6].defensive_pitch_jitter_1, 
            ui_settings.anti_aim_settings[7].defensive_pitch_jitter_1, 
            ui_settings.anti_aim_settings[8].defensive_pitch_jitter_1, 
            ui_settings.anti_aim_settings[9].defensive_pitch_jitter_1, 
            ui_settings.anti_aim_settings[10].defensive_pitch_jitter_1, 
            ui_settings.anti_aim_settings[1].defensive_pitch_jitter_2, 
            ui_settings.anti_aim_settings[2].defensive_pitch_jitter_2, 
            ui_settings.anti_aim_settings[3].defensive_pitch_jitter_2, 
            ui_settings.anti_aim_settings[4].defensive_pitch_jitter_2, 
            ui_settings.anti_aim_settings[5].defensive_pitch_jitter_2, 
            ui_settings.anti_aim_settings[6].defensive_pitch_jitter_2, 
            ui_settings.anti_aim_settings[7].defensive_pitch_jitter_2, 
            ui_settings.anti_aim_settings[8].defensive_pitch_jitter_2, 
            ui_settings.anti_aim_settings[9].defensive_pitch_jitter_2, 
            ui_settings.anti_aim_settings[10].defensive_pitch_jitter_2, 
            ui_settings.anti_aim_settings[1].defensive_pitch_random, 
            ui_settings.anti_aim_settings[2].defensive_pitch_random, 
            ui_settings.anti_aim_settings[3].defensive_pitch_random, 
            ui_settings.anti_aim_settings[4].defensive_pitch_random, 
            ui_settings.anti_aim_settings[5].defensive_pitch_random, 
            ui_settings.anti_aim_settings[6].defensive_pitch_random, 
            ui_settings.anti_aim_settings[7].defensive_pitch_random, 
            ui_settings.anti_aim_settings[8].defensive_pitch_random, 
            ui_settings.anti_aim_settings[9].defensive_pitch_random, 
            ui_settings.anti_aim_settings[10].defensive_pitch_random, 
            ui_settings.anti_aim_settings[1].defensive_pitch_delay, 
            ui_settings.anti_aim_settings[2].defensive_pitch_delay, 
            ui_settings.anti_aim_settings[3].defensive_pitch_delay, 
            ui_settings.anti_aim_settings[4].defensive_pitch_delay, 
            ui_settings.anti_aim_settings[5].defensive_pitch_delay, 
            ui_settings.anti_aim_settings[6].defensive_pitch_delay, 
            ui_settings.anti_aim_settings[7].defensive_pitch_delay, 
            ui_settings.anti_aim_settings[8].defensive_pitch_delay, 
            ui_settings.anti_aim_settings[9].defensive_pitch_delay, 
            ui_settings.anti_aim_settings[10].defensive_pitch_delay, 
            ui_settings.anti_aim_settings[1].defensive_pitch_delay_random, 
            ui_settings.anti_aim_settings[2].defensive_pitch_delay_random, 
            ui_settings.anti_aim_settings[3].defensive_pitch_delay_random, 
            ui_settings.anti_aim_settings[4].defensive_pitch_delay_random, 
            ui_settings.anti_aim_settings[5].defensive_pitch_delay_random, 
            ui_settings.anti_aim_settings[6].defensive_pitch_delay_random, 
            ui_settings.anti_aim_settings[7].defensive_pitch_delay_random, 
            ui_settings.anti_aim_settings[8].defensive_pitch_delay_random, 
            ui_settings.anti_aim_settings[9].defensive_pitch_delay_random, 
            ui_settings.anti_aim_settings[10].defensive_pitch_delay_random, 
            ui_settings.indicators,
            ui_settings.indicators_exclude,
            ui_settings.dt_fix,
            ui_settings.dt_fix_indicator,
            ui_settings.minimumdamage_font,
            ui_settings.anti_aim_settings[1].options,
            ui_settings.anti_aim_settings[2].options,
            ui_settings.anti_aim_settings[3].options,
            ui_settings.anti_aim_settings[4].options,
            ui_settings.anti_aim_settings[5].options,
            ui_settings.anti_aim_settings[6].options,
            ui_settings.anti_aim_settings[7].options,
            ui_settings.anti_aim_settings[8].options,
            ui_settings.anti_aim_settings[9].options,
            ui_settings.anti_aim_settings[10].options,
            ui_settings.logaimbot_pos_y,
            ui_settings.anti_aim_settings[1].smart_hide_strength,
            ui_settings.anti_aim_settings[2].smart_hide_strength,
            ui_settings.anti_aim_settings[3].smart_hide_strength,
            ui_settings.anti_aim_settings[4].smart_hide_strength,
            ui_settings.anti_aim_settings[5].smart_hide_strength,
            ui_settings.anti_aim_settings[6].smart_hide_strength,
            ui_settings.anti_aim_settings[7].smart_hide_strength,
            ui_settings.anti_aim_settings[8].smart_hide_strength,
            ui_settings.anti_aim_settings[9].smart_hide_strength,
            ui_settings.anti_aim_settings[10].smart_hide_strength,
            ui_settings.anti_aim_settings[1].anti_brute_force_enabled,
            ui_settings.anti_aim_settings[2].anti_brute_force_enabled,
            ui_settings.anti_aim_settings[3].anti_brute_force_enabled,
            ui_settings.anti_aim_settings[4].anti_brute_force_enabled,
            ui_settings.anti_aim_settings[5].anti_brute_force_enabled,
            ui_settings.anti_aim_settings[6].anti_brute_force_enabled,
            ui_settings.anti_aim_settings[7].anti_brute_force_enabled,
            ui_settings.anti_aim_settings[8].anti_brute_force_enabled,
            ui_settings.anti_aim_settings[9].anti_brute_force_enabled,
            ui_settings.anti_aim_settings[10].anti_brute_force_enabled,
            ui_settings.anti_aim_settings[1].anti_brute_force_mode,
            ui_settings.anti_aim_settings[2].anti_brute_force_mode,
            ui_settings.anti_aim_settings[3].anti_brute_force_mode,
            ui_settings.anti_aim_settings[4].anti_brute_force_mode,
            ui_settings.anti_aim_settings[5].anti_brute_force_mode,
            ui_settings.anti_aim_settings[6].anti_brute_force_mode,
            ui_settings.anti_aim_settings[7].anti_brute_force_mode,
            ui_settings.anti_aim_settings[8].anti_brute_force_mode,
            ui_settings.anti_aim_settings[9].anti_brute_force_mode,
            ui_settings.anti_aim_settings[10].anti_brute_force_mode,
            ui_settings.anti_aim_settings[1].anti_brute_force_strength,
            ui_settings.anti_aim_settings[2].anti_brute_force_strength,
            ui_settings.anti_aim_settings[3].anti_brute_force_strength,
            ui_settings.anti_aim_settings[4].anti_brute_force_strength,
            ui_settings.anti_aim_settings[5].anti_brute_force_strength,
            ui_settings.anti_aim_settings[6].anti_brute_force_strength,
            ui_settings.anti_aim_settings[7].anti_brute_force_strength,
            ui_settings.anti_aim_settings[8].anti_brute_force_strength,
            ui_settings.anti_aim_settings[9].anti_brute_force_strength,
            ui_settings.anti_aim_settings[10].anti_brute_force_strength,
            ui_settings.anti_aim_settings[1].anti_brute_force_reset_delay,
            ui_settings.anti_aim_settings[2].anti_brute_force_reset_delay,
            ui_settings.anti_aim_settings[3].anti_brute_force_reset_delay,
            ui_settings.anti_aim_settings[4].anti_brute_force_reset_delay,
            ui_settings.anti_aim_settings[5].anti_brute_force_reset_delay,
            ui_settings.anti_aim_settings[6].anti_brute_force_reset_delay,
            ui_settings.anti_aim_settings[7].anti_brute_force_reset_delay,
            ui_settings.anti_aim_settings[8].anti_brute_force_reset_delay,
            ui_settings.anti_aim_settings[9].anti_brute_force_reset_delay,
            ui_settings.anti_aim_settings[10].anti_brute_force_reset_delay,
            ui_settings.anti_aim_settings[1].anti_brute_force_miss_threshold,
            ui_settings.anti_aim_settings[2].anti_brute_force_miss_threshold,
            ui_settings.anti_aim_settings[3].anti_brute_force_miss_threshold,
            ui_settings.anti_aim_settings[4].anti_brute_force_miss_threshold,
            ui_settings.anti_aim_settings[5].anti_brute_force_miss_threshold,
            ui_settings.anti_aim_settings[6].anti_brute_force_miss_threshold,
            ui_settings.anti_aim_settings[7].anti_brute_force_miss_threshold,
            ui_settings.anti_aim_settings[8].anti_brute_force_miss_threshold,
            ui_settings.anti_aim_settings[9].anti_brute_force_miss_threshold,
            ui_settings.anti_aim_settings[10].anti_brute_force_miss_threshold,
            ui_settings.anti_aim_settings[1].anti_brute_force_jitter_strength,
            ui_settings.anti_aim_settings[2].anti_brute_force_jitter_strength,
            ui_settings.anti_aim_settings[3].anti_brute_force_jitter_strength,
            ui_settings.anti_aim_settings[4].anti_brute_force_jitter_strength,
            ui_settings.anti_aim_settings[5].anti_brute_force_jitter_strength,
            ui_settings.anti_aim_settings[6].anti_brute_force_jitter_strength,
            ui_settings.anti_aim_settings[7].anti_brute_force_jitter_strength,
            ui_settings.anti_aim_settings[8].anti_brute_force_jitter_strength,
            ui_settings.anti_aim_settings[9].anti_brute_force_jitter_strength,
            ui_settings.anti_aim_settings[10].anti_brute_force_jitter_strength,
            ui_settings.anti_aim_settings[1].anti_brute_force_yaw_range,
            ui_settings.anti_aim_settings[2].anti_brute_force_yaw_range,
            ui_settings.anti_aim_settings[3].anti_brute_force_yaw_range,
            ui_settings.anti_aim_settings[4].anti_brute_force_yaw_range,
            ui_settings.anti_aim_settings[5].anti_brute_force_yaw_range,
            ui_settings.anti_aim_settings[6].anti_brute_force_yaw_range,
            ui_settings.anti_aim_settings[7].anti_brute_force_yaw_range,
            ui_settings.anti_aim_settings[8].anti_brute_force_yaw_range,
            ui_settings.anti_aim_settings[9].anti_brute_force_yaw_range,
            ui_settings.anti_aim_settings[10].anti_brute_force_yaw_range,
            ui_settings.fakelag_switch,
            ui_settings.fakelag_amount_combobox,
            ui_settings.fakelag_variance_slider,
            ui_settings.fakelag_limit_slider,
            ui_settings.autostop_fix,
            ui_settings.thirdperson,
            ui_settings.fps_boost,
            ui_settings.grenade_trail_master,
            ui_settings.grenade_trail_thickness,
            ui_settings.grenade_trail_glow,
            ui_settings.grenade_trail_fade,
            ui_settings.enemy_chat_reveal,
            ui_settings.scope_spin_enabled,
            ui_settings.scope_spin_speed,
            ui_settings.scope_spin_direction,
            ui_settings.hitlog_style,


        },
        
        color_elements = {
            { element = ui_settings.watermark_color, key = "watermark_color" },
            { element = ui_settings.color_picker, key = "color_picker" },
            { element = ui_settings.indicators_color_picker, key = "indicators_color_picker" },
            { element = ui_settings.miss_color, key = "miss_color" },
            { element = ui_settings.hit_color, key = "hit_color" },
            { element = ui_settings.grenade_trail_color, key = "grenade_trail_color" },
        }
    }
    
    local r, g, b, a = ui.get(reference.menu_color[1])
    local hex_color = utility.rgba_to_hex(r, g, b, a)
    
    function config_manager.load_configs()
        local success, content = pcall(readfile, CONFIG_FILE)
        if success and content and content ~= "" then
            local success_parse, parsed = pcall(json.parse, content)
            if success_parse and parsed then
                configs = parsed
                
                if not configs["Empty"] then
                    configs["Empty"] = config_manager.export_settings()
                    config_manager.save_configs()
                end
                
                return true
            end
        end
        
        configs = {
            ["Empty"] = config_manager.export_settings()
        }
        
        local success_save = config_manager.save_configs()
        if not success_save then
            client.color_log(255, 0, 0, "[Tennezza] Failed to create config file")
        end
        
        return false
    end

    function config_manager.save_configs()
        local existing_configs = {}
        local success, content = pcall(readfile, CONFIG_FILE)
        if success and content and content ~= "" then
            local success_parse, parsed = pcall(json.parse, content)
            if success_parse and parsed then
                existing_configs = parsed
            end
        end
        
        for name, settings in pairs(configs) do
            existing_configs[name] = settings
        end
        
        local success, json_str = pcall(json.stringify, existing_configs)
        if success then
            writefile(CONFIG_FILE, json_str)
            return true
        end
        return false
    end
    
    function config_manager.get_config_list()
        local config_names = {}
        
        if configs["Empty"] then
            table.insert(config_names, "Empty")
        end
        
        for name, _ in pairs(configs) do
            if name ~= "Empty" then
                table.insert(config_names, name)
            end
        end
        
        table.sort(config_names, function(a, b)
            if a == "Empty" then return true end
            if b == "Empty" then return false end
            return a:lower() < b:lower()
        end)
        
        return config_names
    end
    
    function config_manager.update_ui_list()
        local config_list = config_manager.get_config_list()
        if ui_settings.config_list then
            ui.update(ui_settings.config_list, config_list)
        end
        
        if current_config_name then
            for i, name in ipairs(config_list) do
                if name == current_config_name then
                    ui.set(ui_settings.config_list, i - 1)
                    break
                end
            end
        elseif #config_list > 0 then
            ui.set(ui_settings.config_list, 0)
            current_config_name = config_list[1]
        end
    end
    
    function config_manager.export_settings()
        local settings = {}
        
        for i, element in ipairs(data.integers) do
            if element ~= nil then
                settings["standard_" .. i] = ui.get(element)
            end
        end
        
        for i, color_data in ipairs(data.color_elements) do
            if color_data.element ~= nil then
                local r, g, b, a = ui.get(color_data.element)
                settings[color_data.key .. "_r"] = r
                settings[color_data.key .. "_g"] = g
                settings[color_data.key .. "_b"] = b
                settings[color_data.key .. "_a"] = a
            end
        end
        
        return settings
    end
    
    function config_manager.apply_settings(settings)
        if not settings then return false end
        
        for i, element in ipairs(data.integers) do
            local key = "standard_" .. i
            if element and settings[key] ~= nil then
                ui.set(element, settings[key])
            end
        end
        
        for i, color_data in ipairs(data.color_elements) do
            if color_data.element then
                local r = settings[color_data.key .. "_r"]
                local g = settings[color_data.key .. "_g"]
                local b = settings[color_data.key .. "_b"]
                local a = settings[color_data.key .. "_a"]
                
                if r and g and b and a then
                    ui.set(color_data.element, r, g, b, a)
                end
            end
        end
        
        return true
    end

    function config_manager.encode_base64(data)
        local success, encoded = pcall(base64.encode, data)
        if success then
            return "tennezza_" .. encoded
        end
        return nil
    end
    
    function config_manager.decode_base64(encoded_data)
        if string.find(encoded_data, "tennezza_") then
            encoded_data = string.gsub(encoded_data, "tennezza_", "")
        end
        local success, decoded = pcall(base64.decode, encoded_data)
        return success and decoded or nil
    end
    
    function config_manager.load()
        local config_names = config_manager.get_config_list()
        local selected_idx = ui.get(ui_settings.config_list) + 1
        if selected_idx < 1 or selected_idx > #config_names then
            client.color_log(255, 0, 0, "[Tennezza] Invalid config selection")
            return
        end
        
        local config_name = config_names[selected_idx]
        local settings = configs[config_name]
        
        if config_manager.apply_settings(settings) then
            current_config_name = config_name
            client.color_log(124, 252, 0, "[Tennezza] \0")
            client.color_log(255, 255, 255, "Config '" .. config_name .. "' loaded successfully!")
        else
            client.color_log(255, 0, 0, "[Tennezza] Failed to load config '" .. config_name .. "'")
        end
    end
    
    function config_manager.save()
        local config_name = ui.get(ui_settings.config_name_input)
        
        if not config_name or config_name == "" then
            local config_names = config_manager.get_config_list()
            local selected_idx = ui.get(ui_settings.config_list) + 1
            
            if selected_idx < 1 or selected_idx > #config_names then
                return
            end
            
            config_name = config_names[selected_idx]
        end
        
        local settings = config_manager.export_settings()
        
        local existing_configs = {}
        local success, content = pcall(readfile, CONFIG_FILE)
        if success and content and content ~= "" then
            local success_parse, parsed = pcall(json.parse, content)
            if success_parse and parsed then
                existing_configs = parsed
            end
        end
        
        existing_configs[config_name] = settings
        
        local success, json_str = pcall(json.stringify, existing_configs)
        if success then
            writefile(CONFIG_FILE, json_str)
            configs = existing_configs  
            current_config_name = config_name
            config_manager.update_ui_list()
            
            local config_names = config_manager.get_config_list()
            for i, name in ipairs(config_names) do
                if name == config_name then
                    ui.set(ui_settings.config_list, i - 1)
                    break
                end
            end
            
            local encoded = config_manager.encode_base64(json.stringify(settings))
            if encoded then
                client.color_log(124, 252, 0, "[Tennezza] \0")
                client.color_log(255, 255, 255, "Config '" .. config_name .. "' saved successfully!")
            end
        else
            client.color_log(255, 0, 0, "[Tennezza] Failed to save config '" .. config_name .. "'")
        end
    end
    
    function config_manager.delete()
        local config_names = config_manager.get_config_list()
        local selected_idx = ui.get(ui_settings.config_list) + 1
        if selected_idx < 1 or selected_idx > #config_names then
            client.color_log(255, 0, 0, "[Tennezza] Invalid config selection")
            return
        end
        
        local config_name = config_names[selected_idx]
        if config_name == "Empty" then
            client.color_log(255, 0, 0, "[Tennezza] Cannot delete Empty config")
            return
        end
        
        local existing_configs = {}
        local success, content = pcall(readfile, CONFIG_FILE)
        if success and content and content ~= "" then
            local success_parse, parsed = pcall(json.parse, content)
            if success_parse and parsed then
                existing_configs = parsed
            end
        end
        
        existing_configs[config_name] = nil
        
        local success, json_str = pcall(json.stringify, existing_configs)
        if success then
            writefile(CONFIG_FILE, json_str)
            configs = existing_configs 
            config_manager.update_ui_list()
            client.color_log(124, 252, 0, "[Tennezza] \0")
            client.color_log(255, 255, 255, "Config '" .. config_name .. "' deleted successfully!")
        else
            client.color_log(255, 0, 0, "[Tennezza] Failed to delete config '" .. config_name .. "'")
        end
    end
    
    function config_manager.import()
        local clipboard_text = clipboard.get()
        if not clipboard_text then
            client.color_log(255, 0, 0, "[Tennezza] Clipboard is empty")
            return
        end
        
        local settings_json = nil
        
        if string.find(clipboard_text, "tennezza_") then
            settings_json = config_manager.decode_base64(clipboard_text)
        else
            local success, parsed = pcall(json.parse, clipboard_text)
            if success then
                settings_json = clipboard_text
            end
        end
        
        if settings_json then
            local success, settings = pcall(json.parse, settings_json)
            if success and settings then
                if config_manager.apply_settings(settings) then
                    client.color_log(124, 252, 0, "[Tennezza] \0")
                    client.color_log(255, 255, 255, "Settings imported successfully!")
                else
                    client.color_log(255, 0, 0, "[Tennezza] Failed to apply imported settings")
                end
            else
                client.color_log(255, 0, 0, "[Tennezza] Invalid JSON in clipboard")
            end
        else
            client.color_log(255, 0, 0, "[Tennezza] Invalid clipboard content")
        end
    end
    
    function config_manager.export()
        local settings = config_manager.export_settings()
        local success, json_str = pcall(json.stringify, settings)
        if success then
            local encoded = config_manager.encode_base64(json_str)
            if encoded then
                clipboard.set(encoded)
                client.color_log(124, 252, 0, "[Tennezza] \0")
                client.color_log(255, 255, 255, "Settings exported to clipboard with base64 encoding!")
            else
                client.color_log(255, 0, 0, "[Tennezza] Failed to encode settings")
            end
        else
            client.color_log(255, 0, 0, "[Tennezza] Failed to export settings")
        end
    end
    
    function config_manager.refresh()
        config_manager.load_configs()
        config_manager.update_ui_list()
        client.color_log(124, 252, 0, "[Tennezza] \0")
        client.color_log(255, 255, 255, "Config list refreshed!")
    end
    
    function config_manager.init()
        local loaded = config_manager.load_configs()
        
        if not ui_settings.config_list then
            local config_names = config_manager.get_config_list()
            ui_settings.config_list = ui.new_listbox('AA', 'Anti-aimbot angles', 'Config list', config_names)
            ui_settings.config_name_input = ui.new_textbox('AA', 'Anti-aimbot angles', 'Config name')
            ui_settings.load_config_btn = ui.new_button('AA', 'Anti-aimbot angles', '\a' .. hex_color .. ' \aFFFFFFFFLoad config', config_manager.load)
            ui_settings.save_config_btn = ui.new_button('AA', 'Anti-aimbot angles', '\a' .. hex_color .. ' \aFFFFFFFFSave config', config_manager.save)
            ui_settings.delete_config_btn = ui.new_button('AA', 'Anti-aimbot angles', '\a' .. hex_color .. ' \aFFFFFFFFDelete config', config_manager.delete)
            ui_settings.import_config_btn = ui.new_button('AA', 'Anti-aimbot angles', '\a' .. hex_color .. ' \aFFFFFFFFImport from clipboard', config_manager.import)
            ui_settings.export_config_btn = ui.new_button('AA', 'Anti-aimbot angles', '\a' .. hex_color .. ' \aFFFFFFFFExport to clipboard', config_manager.export)
        end
        
        config_manager.update_ui_list()
    end
    
    config_manager.init()
end





function on_shutdown()
    ui.set_visible(reference.fake_peek[1], true)
    ui.set_visible(reference.fake_peek[2], true)
    ui.set_visible(reference.on_shot_anti_aim[1], true)
    ui.set_visible(reference.on_shot_anti_aim[2], true)
    ui.set_visible(reference.slow_motion[1], true)
    ui.set_visible(reference.slow_motion[2], true)
    ui.set_visible(reference.leg_movement, true)
    ui.set_visible(reference.fakelag[1], true)
    ui.set_visible(reference.fakelag[2], true)
    ui.set_visible(reference.fakelag_amount, true)
    ui.set_visible(reference.fakelag_variance, true)
    ui.set_visible(reference.fakelag_limit, true)
    ui.set_visible(reference.pitch[1], true)
    ui.set_visible(reference.pitch[2], true)
    ui.set_visible(reference.yaw_base, true)
    ui.set_visible(reference.yaw[1], true)
    ui.set_visible(reference.yaw[2], true)
    ui.set_visible(reference.yaw_jitter[1], true)
    ui.set_visible(reference.yaw_jitter[2], true)
    ui.set_visible(reference.body_yaw[1], true)
    ui.set_visible(reference.body_yaw[2], true)
    ui.set_visible(reference.freestanding_body_yaw, true)
    ui.set_visible(reference.roll, true)
    ui.set_visible(reference.edge_yaw, true)
    ui.set_visible(reference.freestanding[1], true)
    ui.set_visible(reference.freestanding[2], true)
    ui.set_visible(reference.roll, true)

    cvar.r_aspectratio:set_float(0)
    ui.set(reference.pitch[1], 'Off')
    ui.set(reference.pitch[2], 0)
    ui.set(reference.yaw_base, 'Local view')
    ui.set(reference.yaw[1], 'Off')
    ui.set(reference.yaw[2], 0)
    ui.set(reference.yaw_jitter[1], 'Off')
    ui.set(reference.yaw_jitter[2], 0)
    ui.set(reference.body_yaw[1], 'Off')
    ui.set(reference.body_yaw[2], 0)
    ui.set(reference.freestanding_body_yaw, false)
    ui.set(reference.edge_yaw, false)
    ui.set(reference.freestanding[1], false)
    ui.set(reference.freestanding[2], 'On hotkey')
    ui.set(reference.roll, 0)
end


client.set_event_callback("setup_command", miscellaneous.fast_ladder.on_setup_command)
client.set_event_callback("setup_command", miscellaneous.unsafe_recharge.on_setup_command)

client.set_event_callback("paint_ui", ui_visibility.on_paint_ui)
client.set_event_callback("paint", visuals.damage_indicator.on_paint)
client.set_event_callback("paint", miscellaneous.off_dt_on_hs.on_paint)
client.set_event_callback("paint", visuals.aspect_ratio.on_paint)
client.set_event_callback("paint", visuals.hit_marker.on_paint)
client.set_event_callback("paint", miscellaneous.hit_log.classic_hitlog.on_paint)
client.set_event_callback("paint", miscellaneous.hit_log.modern_hitlog.on_paint)
client.set_event_callback("paint", visuals.watermark.on_paint)

client.set_event_callback("pre_render", visuals.anim_breaker.pre_render)
client.set_event_callback("pre_render", visuals.anim_breaker.on_pre_render)
client.set_event_callback("pre_render", visuals.anim_breaker.on_pre_render_advanced)

client.set_event_callback("paint", visuals.grenade_trail.on_paint)
client.set_event_callback("round_start", visuals.grenade_trail.on_round_start)

client.set_event_callback("aim_fire", visuals.hit_marker.on_aim_fire)
client.set_event_callback("aim_fire", miscellaneous.hit_log.classic_hitlog.on_aim_fire)
client.set_event_callback("aim_hit", miscellaneous.hit_log.classic_hitlog.on_aim_hit)
client.set_event_callback("aim_miss", miscellaneous.hit_log.classic_hitlog.on_aim_miss)
client.set_event_callback("player_hurt", miscellaneous.hit_log.classic_hitlog.on_player_hurt)

client.set_event_callback("paint", miscellaneous.clan_tag.on_paint)
client.set_event_callback("run_command", miscellaneous.clan_tag.on_run_command)
client.set_event_callback("player_connect_full", miscellaneous.clan_tag.on_player_connect_full)

client.set_event_callback("override_view", visuals.animation.animate_camera)

client.set_event_callback("round_prestart", function()
    visuals.hit_marker.clear()
    miscellaneous.hit_log.clear()
end)

client.set_event_callback("player_death", function(e)
    miscellaneous.trash_talk.on_player_death(e)
    anti_aim.current_tickcount = 0
    anti_aim.current_tickcount_defensive = 0
    anti_aim.current_tickcount_defensive_pitch = 0
end)

client.set_event_callback("shutdown", function()
    on_shutdown()
    miscellaneous.enemy_chat_reveal.on_shutdown()
    miscellaneous.clan_tag.on_shutdown()
    miscellaneous.unsafe_recharge.on_shutdown()
end)
client.delay_call(0.1, function()
    if ui.get(ui_settings.enemy_chat_reveal) then
        miscellaneous.enemy_chat_reveal.on_toggle()
    end
end)

--[[function auto_change_aa_icon()
    local tabs = {"RAGE", "AA", "LEGIT", "VISUALS", "MISC", "SKINS", "PLIST", "Tab"}
    
    local tabsptr = ffi.cast("int**", 0x434799AC + 0x54)[0]
    
    local tabsinfo = {}
    
    for i = 0, #tabs - 1 do
        local tab = tabsptr[i]  
        
        tabsinfo[i] = {
            id = ffi.cast("int*", tab + 0x80),
            offset = ffi.cast("int*", tab + 0x84),
            width = ffi.cast("int*", tab + 0x8C),
            height = ffi.cast("int*", tab + 0x90)
        }
    end
    
    local icon_url = "https://cdn.discordapp.com/attachments/1459537514602958978/1466130464795529502/f8fe87afafad28f1.png?ex=6982e026&is=69818ea6&hm=673e0ccc55a02677d9cdf83d7b0487aef335714b60e2cf3452a4ab477914c849&"
    
    http.get(icon_url, function(status, response)
        if status and response.body then
            local texture_id = renderer.load_png(response.body, 48, 48)
            if texture_id and texture_id > 0 then
                for i = 0, #tabs - 1 do
                    if tabs[i + 1] == "AA" then
                        tabsinfo[i].id[0] = texture_id
                        break
                    end
                end
            end
        end
    end)
end

auto_change_aa_icon()]]


local menu_color_ref = { ui.reference('MISC', 'Settings', 'Menu color') }

local state = {
    loading = true,
    start_time = globals.realtime(),
    visible = true,
    fade_alpha = 0,
    pulse_alpha = 100,
    pulse_dir = 1,
    text_offset = 0,
    fade_start_time = nil,
    current_color = {18, 220, 130},  
    appear_progress = 0,
    animation_started = false
}

local function get_menu_color()
    if menu_color_ref and menu_color_ref[1] then
        local r, g, b = ui.get(menu_color_ref[1])
        if r and g and b then
            state.current_color = {r, g, b}
            return r, g, b
        end
    end
    return state.current_color[1], state.current_color[2], state.current_color[3]
end

local function update_animations()
    get_menu_color()
    
    if state.loading and state.appear_progress < 1 then
        state.appear_progress = math.min(state.appear_progress + globals.frametime() * 2.5, 1)
        local t = state.appear_progress
        state.fade_alpha = math.floor(255 * (1 - (1 - t) * (1 - t) * (1 - t)))
    end
    
    if state.loading and state.appear_progress >= 1 then
        state.pulse_alpha = state.pulse_alpha + (state.pulse_dir * globals.frametime() * 180)
        if state.pulse_alpha <= 100 then
            state.pulse_alpha = 100
            state.pulse_dir = 1
        elseif state.pulse_alpha >= 255 then
            state.pulse_alpha = 255
            state.pulse_dir = -1
        end
    end
    
    if state.appear_progress > 0.5 then
        state.text_offset = math.sin(globals.realtime() * 2) * (state.appear_progress * 2)
    end
end

local function start_fade_out()
    if state.fade_start_time then return end
    
    state.fade_start_time = globals.realtime()
    state.loading = false
    local menu_r, menu_g, menu_b = get_menu_color()
    client.color_log(menu_r, menu_g, menu_b, "[Tennezza] Loaded succesfully!")
end

local function get_current_alpha(base_alpha)
    local appear_alpha = math.floor(base_alpha * (state.fade_alpha / 255))
    
    if not state.fade_start_time then
        return appear_alpha
    end
    
    local fade_time = globals.realtime() - state.fade_start_time
    local fade_duration = 1.5
    
    if fade_time >= fade_duration then
        state.visible = false
        return 0
    end
    
    local t = fade_time / fade_duration
    local fade_progress = 1 - (1 - t) * (1 - t) * (1 - t)
    
    return math.floor(appear_alpha * (1 - fade_progress))
end

local function get_appear_multiplier(element_delay)
    element_delay = element_delay or 0
    local appear_t = math.max(0, (state.appear_progress - element_delay) / (1 - element_delay))
    
    if appear_t <= 0 then return 0 end
    if appear_t >= 1 then return 1 end
    
    local c1 = 1.70158
    local c3 = c1 + 1
    return 1 + c3 * math.pow(appear_t - 1, 3) + c1 * math.pow(appear_t - 1, 2)
end

local function draw_text(x, y, r, g, b, a, text, align, bold, shadow, element_delay)
    local appear_mult = get_appear_multiplier(element_delay)
    if appear_mult <= 0 then return end
    
    local current_alpha = get_current_alpha(a)
    local scaled_alpha = math.floor(current_alpha * appear_mult)
    
    if scaled_alpha <= 0 then return end
    
    align = align or "c"
    local font_flag = bold and 1 or 0
    
    local anim_y = y - 20 * (1 - appear_mult)
    
    if shadow then
        local shadow_alpha = math.floor(scaled_alpha * 0.6)
        if shadow_alpha > 0 then
            renderer.text(x + 2, anim_y + 2, 0, 0, 0, shadow_alpha, align, font_flag, text)
        end
    end
    
    renderer.text(x, anim_y, r, g, b, scaled_alpha, align, font_flag, text)
end

local function draw_large_text(x, y, r, g, b, a, text, align, element_delay)
    local appear_mult = get_appear_multiplier(element_delay)
    if appear_mult <= 0 then return end
    
    local current_alpha = get_current_alpha(a)
    local scaled_alpha = math.floor(current_alpha * appear_mult)
    
    if scaled_alpha <= 0 then return end
    
    align = align or "c"
    
    local scale_mult = 0.5 + 0.5 * appear_mult
    local anim_y = y - 30 * (1 - appear_mult)
    
    local shadow_alpha = math.floor(scaled_alpha * 0.7)
    if shadow_alpha > 0 then
        renderer.text(x + 2, anim_y + 2, 0, 0, 0, shadow_alpha, align, 0, text)
    end
    
    
    local elapsed = globals.realtime() - state.start_time
    local progress = math.min(elapsed / 2.5, 1)
    if globals.tickcount() % 100 ~= 0 and globals.tickcount() % 20 == 0 and progress < 1 then
        renderer.text(x, anim_y, r, g, b, scaled_alpha, align, 0, text)
    elseif progress == 1 then
        renderer.text(x, anim_y, r, g, b, scaled_alpha, align, 0, text)
    end
end

local function draw_fading_rect(x, y, w, h, r, g, b, a, element_delay)
    local appear_mult = get_appear_multiplier(element_delay)
    if appear_mult <= 0 then return end
    
    local scaled_alpha = math.floor(get_current_alpha(a) * appear_mult)
    if scaled_alpha > 0 then
        renderer.rectangle(x, y, w, h, r, g, b, scaled_alpha)
    end
end

local function draw_menu_color_progress_bar(x, y, w, h, progress, element_delay)
    local appear_mult = get_appear_multiplier(element_delay)
    if appear_mult <= 0 then return end
    
    local current_alpha = math.floor(get_current_alpha(255) * appear_mult)
    if current_alpha <= 0 then return end
    
    local r, g, b = get_menu_color()
    
    local anim_y = y - 10 * (1 - appear_mult)
    
    renderer.rectangle(x, anim_y, w, h, 20, 20, 20, math.floor(current_alpha * 0.3))
    
    local anim_progress = progress * appear_mult
    local fill_width = w * anim_progress
    
    if fill_width > 0 then
        local bar_alpha = math.floor(current_alpha * 0.85)
        if bar_alpha > 0 then
            renderer.rectangle(x, anim_y, fill_width, h, r, g, b, bar_alpha)
            
            if state.loading and appear_mult >= 1 then
                local glow_alpha = math.floor(state.pulse_alpha * appear_mult * 0.4)
                if glow_alpha > 0 then
                    renderer.rectangle(x, anim_y, fill_width, h, 255, 255, 255, glow_alpha)
                end
            end
        end
    end
end

local function on_paint_ui()
    if not state.visible then return end
    
    local screen_w, screen_h = client.screen_size()
    local center_x = math.floor(screen_w / 2)
    local center_y = math.floor(screen_h / 2)
    
    local elapsed = globals.realtime() - state.start_time
    local progress = math.min(elapsed / 2.5, 1)
    
    update_animations()
    
    draw_fading_rect(0, 0, screen_w, screen_h, 0, 0, 0, 180, 0)
    
    local menu_r, menu_g, menu_b = get_menu_color()
    
    local base_y = center_y + state.text_offset
    
    local title_y = base_y - 40     
    local subtitle_y = base_y       
    local loading_y = base_y + 30    
    local progress_y = base_y + 55  
    local status_y = base_y + 80    
    
    local current_alpha = get_current_alpha(255)
    
    if current_alpha <= 0 then return end
    
    draw_large_text(center_x, subtitle_y, menu_r, menu_g, menu_b, 255, 
        "TENNEZZA", "c+", 0)
    
    draw_text(center_x, subtitle_y, 240, 240, 240, 220, 
        "LUA FRAMEWORK", "c", true, false, 0.1)
    
    local loading_dots = string.rep(".", math.floor(elapsed * 4) % 4)
    local loading_text = string.format("INITIALIZING%s %02d%%", loading_dots, math.floor(progress * 100))
    
    draw_text(center_x, loading_y, menu_r, menu_g, menu_b, 220, 
        loading_text, "c", true, false, 0.2)
    
    draw_menu_color_progress_bar(center_x - 140, progress_y, 280, 4, progress, 0.3)
    
    local status_text = progress < 1 and "LOADING MODULES" or "READY"
    status_r, status_g, status_b = menu_r, menu_g, menu_b
    
    draw_text(center_x, status_y, status_r, status_g, status_b, 180, 
        "v1.0.0 | " .. status_text, "c", false, false, 0.4)
    
    if current_alpha > 50 and state.appear_progress > 0.5 then
        local deco_length = 70 * state.appear_progress
        local deco_y = subtitle_y
        local deco_alpha = math.floor(get_current_alpha(120) * state.appear_progress)
        
        if deco_alpha > 0 then
            renderer.gradient(center_x - 180, deco_y, deco_length, 1, 
                255, 255, 255, 0, 
                menu_r, menu_g, menu_b, deco_alpha, false)
        end
        
        if deco_alpha > 0 then
            renderer.gradient(center_x + 180 - deco_length, deco_y, deco_length, 1, 
                menu_r, menu_g, menu_b, deco_alpha, 
                255, 255, 255, 0, false)
        end
    end
    
    if state.loading and current_alpha > 100 and state.appear_progress > 0.7 then
        local dot_alpha = math.floor(get_current_alpha(state.pulse_alpha) * state.appear_progress)
        local dot_size = 4
        local dot_y = progress_y
        
        if dot_alpha > 0 then
            renderer.rectangle(center_x - 143, dot_y, dot_size, dot_size, menu_r, menu_g, menu_b, dot_alpha)
            renderer.rectangle(center_x + 139, dot_y, dot_size, dot_size, menu_r, menu_g, menu_b, dot_alpha)
        end
    end
    
    
    if progress >= 1 and state.loading and state.appear_progress >= 1 then
        client.delay_call(0.8, start_fade_out)
    end
end

local function initialize()
    local menu_r, menu_g, menu_b = get_menu_color()
    client.color_log(menu_r, menu_g, menu_b, "╔═══════════════════════════════════════╗")
    client.color_log(menu_r, menu_g, menu_b, "║               TENNEZZA LUA            ║")
    client.color_log(menu_r, menu_g, menu_b, "╚═══════════════════════════════════════╝")
    client.color_log(menu_r, menu_g, menu_b, "[*] Initializing tennezza...")
    
    state.appear_progress = 0
    state.fade_alpha = 0
    state.animation_started = true
    state.start_time = globals.realtime()
    
    client.set_event_callback("paint_ui", on_paint_ui)
end

client.delay_call(0.05, initialize)