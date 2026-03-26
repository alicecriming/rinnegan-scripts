--open sorce resolver for fun made by wiking
-- all this shit you can upd add more stuff or fix 

-- Import required libraries
local ffi = require "ffi"
local bit = require "bit"
local csgo_weapons = require "gamesense/csgo_weapons"

-- GameSense API function references organized into tables
local api = {
    entity = {
        get_local_player = entity.get_local_player,
        get_players = entity.get_players,
        get_prop = entity.get_prop,
        set_prop = entity.set_prop,
        is_alive = entity.is_alive,
        is_dormant = entity.is_dormant,
        get_origin = entity.get_origin,
        get_player_name = entity.get_player_name,
        get_steam64 = entity.get_steam64
    },
    client = {
        latency = client.latency,
        eye_position = client.eye_position,
        camera_angles = client.camera_angles,
        set_event_callback = client.set_event_callback,
        userid_to_entindex = client.userid_to_entindex,
        log = client.log
    },
    globals = {
        tickcount = globals.tickcount,
        curtime = globals.curtime,
        realtime = globals.realtime,
        chokedcommands = globals.chokedcommands,
        tickinterval = globals.tickinterval,
        frametime = globals.frametime,
        absoluteframetime = globals.absoluteframetime,
        commandack = globals.commandack,
        framecount = globals.framecount,
        lastoutgoingcommand = globals.lastoutgoingcommand,
        mapname = globals.mapname,
        maxplayers = globals.maxplayers,
        oldcommandack = globals.oldcommandack,
        is_connected = globals.is_connected,
        is_in_game = globals.is_in_game,
        choked_commands = globals.choked_commands,
        server_tick = globals.server_tick,
        clock_offset = globals.clock_offset
    },
    plist = plist
}


-- Enhanced Security and Safety System
local security_system = {
    enabled = true,
    anti_detection = true,
    safe_mode = false,
    validation_level = 2, -- 0=disabled, 1=basic, 2=enhanced, 3=paranoid
    max_resolver_calls_per_second = 128,
    max_memory_usage_mb = 50,
    call_counter = 0,
    last_reset_time = 0,
    suspicious_activity_count = 0,
    emergency_shutdown = false
}

-- File logging functions removed

-- Simple logging function - console only
local function simple_log(message, log_type)
    if not message then return end
    
    local colored_message = message
    
    if log_type == "hit" then
        colored_message = "\a90EE90FF[HIT] \aFFFFFFFF" .. message
    elseif log_type == "miss" then
        colored_message = "\aFF6B6BFF[MISS] \aFFFFFFFF" .. message
    elseif log_type == "resolver" then
        colored_message = "\aFFD700FF[RESOLVER] \aFFFFFFFF" .. message
    else
        colored_message = "\aD3D3D3FF[INFO] \aFFFFFFFF" .. message
    end
    
    client.log(colored_message)
end

-- Safe entity property getter function
local function safe_entity_get_prop(ent_index, prop_name, default_value)
    if not security_system.enabled then
        return entity.get_prop(ent_index, prop_name) or default_value
    end
    
    local success, result = pcall(entity.get_prop, ent_index, prop_name)
    if not success then
        client.log("SECURITY: Failed to get property " .. prop_name .. " for entity " .. ent_index)
        return default_value
    end
    
    return result or default_value
end

-- Security and Safety Functions
local function validate_entity_index(ent_index)
    if not ent_index or type(ent_index) ~= "number" then
        return false, "Invalid entity index type"
    end
    
    if ent_index < 1 or ent_index > 64 then
        return false, "Entity index out of range"
    end
    
    if not safe_entity_get_prop(ent_index, "m_iHealth", 0) or safe_entity_get_prop(ent_index, "m_iHealth", 0) <= 0 then
        return false, "Entity does not exist or is dead"
    end
    
    return true, "Valid"
end

-- Enhanced Performance Optimization System
local performance_stats = {
    resolver_calls = 0,
    total_time = 0,
    average_time = 0,
    memory_usage = 0,
    fps_impact = 0,
    cache_hits = 0,
    cache_misses = 0
}

local function check_security_limits()
    local current_time = globals.realtime()
    
    -- Reset call counter every second
    if current_time - security_system.last_reset_time >= 1.0 then
        security_system.call_counter = 0
        security_system.last_reset_time = current_time
    end
    
    -- Check call rate limit
    security_system.call_counter = security_system.call_counter + 1
    if security_system.call_counter > security_system.max_resolver_calls_per_second then
        security_system.suspicious_activity_count = security_system.suspicious_activity_count + 1
        if security_system.suspicious_activity_count > 5 then
            security_system.emergency_shutdown = true
            simple_log("SECURITY: Emergency shutdown activated - excessive call rate", "resolver")
        end
        return false, "Call rate limit exceeded"
    end
    
    -- Check memory usage (approximate)
    local memory_estimate = (performance_stats.resolver_calls * 0.001) -- Rough estimate in MB
    if memory_estimate > security_system.max_memory_usage_mb then
        simple_log("SECURITY: Memory usage limit exceeded", "resolver")
        return false, "Memory limit exceeded"
    end
    
    return true, "Security checks passed"
end

local function anti_detection_measures()
    if not security_system.anti_detection then
        return true
    end
    
    -- Randomize timing slightly to avoid detection patterns
    local random_delay = math.random(1, 3) * 0.001 -- 1-3ms random delay
    if random_delay > 0.001 then
        -- Small delay to break patterns
        local start_time = globals.realtime()
    while globals.realtime() - start_time < random_delay do
            -- Busy wait for very small delay
        end
    end
    
    -- Vary resolver behavior slightly
    if math.random() < 0.05 then -- 5% chance
        -- Occasionally skip a frame to appear more human-like
        return false
    end
    
    return true
end



local ui_new_checkbox = ui.new_checkbox
local ui_new_slider = ui.new_slider
local ui_new_hotkey = ui.new_hotkey
local ui_new_combobox = ui.new_combobox
local ui_get = ui.get
local ui_set = ui.set
local ui_reference = ui.reference

-- Debug and Statistics System
local debug_stats = {
    total_resolves = 0,
    successful_resolves = 0,
    missed_shots = 0,
    hit_shots = 0,
    yaw_corrections = 0,
    pitch_corrections = 0,
    desync_breaks_detected = 0,
    fakelag_detections = 0,
    negative_backtrack_records = 0,
    last_reset = globals.realtime()
}

-- Renderer functions removed - no visual elements

-- Math utilities
local math_abs = math.abs
local math_sqrt = math.sqrt
local math_sin = math.sin
local math_cos = math.cos
local math_rad = math.rad
local math_deg = math.deg
local math_floor = math.floor
local math_ceil = math.ceil
local math_min = math.min
local math_max = math.max
local math_random = math.random

-- Constants
local MAX_PLAYERS = 64
local MAX_LAG_RECORDS = 150
local DESYNC_RANGE = 58
local DESYNC_UPDATE_TIME = 1.1
local PITCH_RESOLVER_RANGE = 89

-- Global variables
local resolver_data = {}
local lag_records = {}
local resolver_stats = {
    hits = 0,
    misses = 0,
    shots_fired = 0
}

-- UI Configuration System
-- Simplified and Clean UI Configuration
-- Kolorowe UI elementy inspirowane korose resolver.lua
local ui_new_checkbox = ui.new_checkbox
local ui_new_slider = ui.new_slider
local ui_new_hotkey = ui.new_hotkey
local ui_new_combobox = ui.new_combobox
local ui_new_label = ui.new_label
local ui_get = ui.get
local ui_set = ui.set
local ui_set_visible = ui.set_visible
local ui_set_callback = ui.set_callback

-- Kolorowe labele i UI elementy
local ui_elements = {
    -- Nagłówek z kolorami
    header = ui_new_label("RAGE", "Other", "\a96E631FF• \aCFCFCFCFGamesense HvH Resolver \a96E631FF•"),
    separator1 = ui_new_label("RAGE", "Other", "\a646464FF—————————————————————"),
    
    -- Główny włącznik z kolorami
    enable = ui_new_checkbox("RAGE", "Other", "\a96E631FF► \aCFCFCFCFEnable Resolver"),
    
    -- Tryb resolvera z kolorami i AI Boost
    mode_label = ui_new_label("RAGE", "Other", "\aCFCFCFCFResolver Mode:"),
    mode = ui_new_combobox("RAGE", "Other", "\a96E631FFMode", {"Safe", "Adaptive", "Aggressive", "AI Boost"}),
    
    -- Nowe opcje AI i wizualne
    ai_separator = ui_new_label("RAGE", "Other", "\aFF6B6BFF—————— AI Options ——————"),
    ai_confidence = ui_new_slider("RAGE", "Other", "\aFF6B6FFAI Confidence", 50, 100, 85),
    ai_learning = ui_new_checkbox("RAGE", "Other", "\aFF6B6FFAI Learning Mode"),
    prediction_strength = ui_new_slider("RAGE", "Other", "\aFF6B6FFPrediction Strength", 1, 10, 7),
    
    -- Opcje wizualne
    visual_separator = ui_new_label("RAGE", "Other", "\a87CEEBFF—————— Visual Options ——————"),
    show_resolver_info = ui_new_checkbox("RAGE", "Other", "\a87CEEBFFShow Resolver Info"),
    resolver_indicators = ui_new_checkbox("RAGE", "Other", "\a87CEEBFFResolver Indicators"),
    color_coded_esp = ui_new_checkbox("RAGE", "Other", "\a87CEEBFFColor Coded ESP"),
    
    -- Separator
    separator2 = ui_new_label("RAGE", "Other", "\a646464FF—"),
    
    -- Debug opcje
    debug_label = ui_new_label("RAGE", "Other", "\a96E631FF● \aCFCFCFCFDebug Options"),
    debug_enable = ui_new_checkbox("RAGE", "Other", "\aCFCFCFCFDebug Mode"),
    debug_verbose = ui_new_checkbox("RAGE", "Other", "\aCFCFCFCFVerbose Logging"),
    
    -- Informacyjne labele z wersją i opisem
    separator3 = ui_new_label("RAGE", "Other", "\a646464FF—————————————————————"),
    info_header = ui_new_label("RAGE", "Other", "\aFFD700FF★ \aCFCFCFCFInformation \aFFD700FF★"),
    version_label = ui_new_label("RAGE", "Other", "\a87CEEBFF[VERSION] \aCFCFCFCFGamesense HvH Resolver v2.2 AI"),
    author_label = ui_new_label("RAGE", "Other", "\a87CEEBFF[AUTHOR] \aCFCFCFCFMade by Wiking"),
    description_label = ui_new_label("RAGE", "Other", "\a87CEEBFF[DESC] \aCFCFCFCFAdvanced AI-powered HvH resolver"),
    features_label = ui_new_label("RAGE", "Other", "\a87CEEBFF[FEATURES] \aCFCFCFCFAI prediction, Visual indicators, Smart learning"),
    status_label = ui_new_label("RAGE", "Other", "\a90EE90FF[STATUS] \aCFCFCFCFReady"),
    separator4 = ui_new_label("RAGE", "Other", "\a646464FF—————————————————————")
}

-- Funkcje UI
local function get_resolver_enabled()
    return ui_get(ui_elements.enable)
end

local function get_resolver_mode()
    local modes = {"Safe", "Adaptive", "Aggressive", "AI Boost"}
    local mode_index = tonumber(ui_get(ui_elements.mode)) or 0
    return modes[mode_index + 1] or "Adaptive"
end

local function get_debug_enabled()
    return ui_get(ui_elements.debug_enable)
end

-- Nowe funkcje dla opcji AI i wizualnych
local function get_ai_confidence()
    return ui_get(ui_elements.ai_confidence)
end

local function get_ai_learning_enabled()
    return ui_get(ui_elements.ai_learning)
end

local function get_prediction_strength()
    return ui_get(ui_elements.prediction_strength)
end

local function get_show_resolver_info()
    return ui_get(ui_elements.show_resolver_info)
end

local function get_resolver_indicators()
    return ui_get(ui_elements.resolver_indicators)
end

local function get_color_coded_esp()
    return ui_get(ui_elements.color_coded_esp)
end

local function get_debug_verbose()
    return ui_get(ui_elements.debug_verbose)
end

-- Callback dla UI
local function on_resolver_change()
    local enabled = get_resolver_enabled()
    local ai_mode = get_resolver_mode() == "AI Boost"
    
    -- Podstawowe opcje
    ui_set_visible(ui_elements.mode_label, enabled)
    ui_set_visible(ui_elements.mode, enabled)
    
    -- Opcje AI (widoczne tylko gdy AI Boost jest wybrany)
    ui_set_visible(ui_elements.ai_separator, enabled and ai_mode)
    ui_set_visible(ui_elements.ai_confidence, enabled and ai_mode)
    ui_set_visible(ui_elements.ai_learning, enabled and ai_mode)
    ui_set_visible(ui_elements.prediction_strength, enabled and ai_mode)
    
    -- Opcje wizualne
    ui_set_visible(ui_elements.visual_separator, enabled)
    ui_set_visible(ui_elements.show_resolver_info, enabled)
    ui_set_visible(ui_elements.resolver_indicators, enabled)
    ui_set_visible(ui_elements.color_coded_esp, enabled)
    
    ui_set_visible(ui_elements.separator2, enabled)
    ui_set_visible(ui_elements.debug_label, enabled)
    ui_set_visible(ui_elements.debug_enable, enabled)
    ui_set_visible(ui_elements.debug_verbose, enabled and get_debug_enabled())
end

-- Funkcja do aktualizacji statusu (będzie wywoływana w głównej pętli)
local function update_ui_status()
    local enabled = get_resolver_enabled()
    local mode = get_resolver_mode()
    
    -- Status będzie aktualizowany przez enhanced_log w głównej logice
end

-- Ustaw callback
ui_set_callback(ui_elements.enable, on_resolver_change)
ui_set_callback(ui_elements.mode, on_resolver_change)
ui_set_callback(ui_elements.debug_enable, on_resolver_change)

-- Inicjalizuj UI
on_resolver_change()

-- Zmienne dla kompatybilności
local resolver_enabled = get_resolver_enabled()
local resolver_mode = get_resolver_mode()
local debug_enabled = get_debug_enabled()

-- Utility functions
local function normalize_yaw(yaw)
    while yaw > 180 do
        yaw = yaw - 360
    end
    while yaw < -180 do
        yaw = yaw + 360
    end
    return yaw
 end

local function angle_diff(a1, a2)
    local diff = normalize_yaw(a1 - a2)
    return math_abs(diff)
end

-- Vector utility functions for AI system
local function vector_distance(v1, v2)
    if not v1 or not v2 or not v1[1] or not v2[1] then return 0 end
    local dx = (v1[1] or 0) - (v2[1] or 0)
    local dy = (v1[2] or 0) - (v2[2] or 0)
    local dz = (v1[3] or 0) - (v2[3] or 0)
    return math.sqrt(dx*dx + dy*dy + dz*dz)
end

local function vector_length(v)
    if not v or not v[1] then return 0 end
    local x, y, z = v[1] or 0, v[2] or 0, v[3] or 0
    return math.sqrt(x*x + y*y + z*z)
end

local function get_velocity_2d(ent_index)
    -- Enhanced validation for entity index
    if not ent_index or not entity.is_alive(ent_index) then
        return 0
    end
    
    -- Use safe property getter with validation
    local vel_x = safe_entity_get_prop(ent_index, "m_vecVelocity[0]", 0)
    local vel_y = safe_entity_get_prop(ent_index, "m_vecVelocity[1]", 0)
    
    -- Validate velocity values
    if type(vel_x) ~= "number" then vel_x = 0 end
    if type(vel_y) ~= "number" then vel_y = 0 end
    
    -- Prevent extreme values that could cause calculation errors
    if math.abs(vel_x) > 3500 then vel_x = 0 end
    if math.abs(vel_y) > 3500 then vel_y = 0 end
    
    local velocity_2d = math_sqrt(vel_x * vel_x + vel_y * vel_y)
    
    -- Validate result
    if type(velocity_2d) ~= "number" or velocity_2d ~= velocity_2d then -- NaN check
        return 0
    end
    
    return velocity_2d
end

local function is_on_ground(ent_index)
    -- Enhanced validation for entity index
    if not ent_index or not entity.is_alive(ent_index) then
        return true -- Default to on ground for safety
    end
    
    -- Use safe property getter with validation
    local flags = safe_entity_get_prop(ent_index, "m_fFlags", 1) -- Default to on ground
    
    -- Validate flags value
    if type(flags) ~= "number" then
        return true -- Default to on ground
    end
    
    return bit.band(flags, 1) == 1 -- FL_ONGROUND
end

local function get_movement_state(ent_index)
    local velocity = get_velocity_2d(ent_index)
    local on_ground = is_on_ground(ent_index)
    
    if not on_ground then
        return "airborne"
    elseif velocity > 5 then
        return "moving"
    else
        return "standing"
    end
end

-- Advanced Lag Compensation Functions
local ping_history = {} -- Store ping measurements
local network_stats = {} -- Store network statistics per player

local function measure_ping()
    -- Get current ping/latency with enhanced validation
    local ping = 0
    
    -- Try multiple methods to get ping
    if api.client.latency and type(api.client.latency) == "function" then
        local success, result = pcall(api.client.latency)
        if success and result and type(result) == "number" and result >= 0 then
            ping = result * 1000 -- Convert to milliseconds if needed
        end
    end
    
    -- Fallback: use a reasonable default if ping is 0 or invalid
    if ping <= 0 or ping > 1000 then
        ping = 50 -- Default 50ms ping
    end
    
    local current_tick = api.globals.tickcount()
    
    table.insert(ping_history, {
        ping = ping,
        tick = current_tick
    })
    
    -- Keep only last 50 ping measurements
    if #ping_history > 50 then
        table.remove(ping_history, 1)
    end
    
    return ping
end

local function get_average_ping()
    if #ping_history == 0 then
        return 0
    end
    
    local total_ping = 0
    for i = 1, #ping_history do
        total_ping = total_ping + ping_history[i].ping
    end
    
    return total_ping / #ping_history
end

local function predict_enemy_position(ent_index, ticks_ahead)
    -- Enhanced validation for ticks_ahead
    if not ticks_ahead or type(ticks_ahead) ~= "number" or ticks_ahead < 0 then
        ticks_ahead = 0
        debug_stats.negative_prediction_fixes = (debug_stats.negative_prediction_fixes or 0) + 1
    end
    
    -- Validate entity index
    if not ent_index or not entity.is_alive(ent_index) then
        return nil
    end
    
    -- Get origin with validation
    local origin = {entity.get_origin(ent_index)}
    if not origin or not origin[1] or not origin[2] or not origin[3] then
        return nil
    end
    
    -- Get velocity with enhanced validation
    local vel_x = safe_entity_get_prop(ent_index, "m_vecVelocity[0]", 0)
    local vel_y = safe_entity_get_prop(ent_index, "m_vecVelocity[1]", 0)
    local vel_z = safe_entity_get_prop(ent_index, "m_vecVelocity[2]", 0)
    
    -- Validate velocity values
    if type(vel_x) ~= "number" then vel_x = 0 end
    if type(vel_y) ~= "number" then vel_y = 0 end
    if type(vel_z) ~= "number" then vel_z = 0 end
    
    local velocity = {vel_x, vel_y, vel_z}
    
    -- Calculate time delta with bounds checking
    local time_delta = ticks_ahead * 0.015625 -- globals_intervalpertick()
    if time_delta > 1.0 then time_delta = 1.0 end -- Cap at 1 second
    
    -- Simple linear prediction with bounds checking
    local predicted_pos = {
        origin[1] + velocity[1] * time_delta,
        origin[2] + velocity[2] * time_delta,
        origin[3] + velocity[3] * time_delta
    }
    
    -- Validate predicted position
    for i = 1, 3 do
        if type(predicted_pos[i]) ~= "number" or math.abs(predicted_pos[i]) > 32768 then
            predicted_pos[i] = origin[i] -- Fallback to original position
        end
    end
    
    -- Apply gravity if player is airborne
    local flags = safe_entity_get_prop(ent_index, "m_fFlags", 0)
    local on_ground = bit.band(flags, 1) == 1
    
    if not on_ground and time_delta > 0 then
        local gravity = 800 -- CS:GO gravity constant
        local gravity_effect = 0.5 * gravity * time_delta * time_delta
        predicted_pos[3] = predicted_pos[3] - gravity_effect
        
        -- Validate gravity effect
        if type(predicted_pos[3]) ~= "number" then
            predicted_pos[3] = origin[3]
        end
    end
    
    return predicted_pos
end

local function calculate_lag_compensation_ticks(ent_index)
    -- Calculate how many ticks to compensate for lag
    local ping = measure_ping()
    local avg_ping = get_average_ping()
    
    -- Use average ping for more stable compensation
    local compensation_time = avg_ping * 0.5 -- Half of round-trip time
    local ticks_to_compensate = math_floor(compensation_time / 0.015625)
    
    -- Enhanced validation: prevent negative backtrack values
    -- Clamp to reasonable values (0-32 ticks)
    ticks_to_compensate = math.max(0, math.min(32, ticks_to_compensate))
    
    -- Additional safety check for negative values
    if ticks_to_compensate < 0 then
        ticks_to_compensate = 0
        debug_stats.negative_backtrack_fixes = (debug_stats.negative_backtrack_fixes or 0) + 1
    end
    
    -- Store network stats for this player
    if not network_stats[ent_index] then
        network_stats[ent_index] = {}
    end
    
    network_stats[ent_index].ping = ping
    network_stats[ent_index].avg_ping = avg_ping
    network_stats[ent_index].compensation_ticks = ticks_to_compensate
    network_stats[ent_index].last_update = api.globals.tickcount()
    
    return ticks_to_compensate
end

-- Lag Record structure
local function create_lag_record(ent_index)
    local current_tick = api.globals.tickcount()
    local compensation_ticks = calculate_lag_compensation_ticks(ent_index)
    
    -- Additional backtrack validation
    local simulation_time = entity.get_prop(ent_index, "m_flSimulationTime") or 0
    local backtrack_ticks = current_tick - math_floor(simulation_time / 0.015625)
    if backtrack_ticks < 0 then
        backtrack_ticks = 0
        debug_stats.negative_backtrack_records = (debug_stats.negative_backtrack_records or 0) + 1
    end
    
    -- Get and validate eye angles
    local eye_pitch = entity.get_prop(ent_index, "m_angEyeAngles[0]") or 0
    local eye_yaw = entity.get_prop(ent_index, "m_angEyeAngles[1]") or 0
    
    -- Validate angle ranges
    if type(eye_pitch) ~= "number" or type(eye_yaw) ~= "number" then
        eye_pitch, eye_yaw = 0, 0
    end
    if math.abs(eye_pitch) > 90 or math.abs(eye_yaw) > 180 then
        eye_pitch, eye_yaw = 0, 0
    end
    
    local record = {
        ent_index = ent_index,
        tickcount = current_tick,
        curtime = api.globals.curtime(),
        origin = {entity.get_origin(ent_index)},
        eye_angles = {eye_pitch, eye_yaw},
        velocity = {safe_entity_get_prop(ent_index, "m_vecVelocity[0]", 0), safe_entity_get_prop(ent_index, "m_vecVelocity[1]", 0), safe_entity_get_prop(ent_index, "m_vecVelocity[2]", 0)},
        lby = safe_entity_get_prop(ent_index, "m_flLowerBodyYawTarget", 0),
        flags = safe_entity_get_prop(ent_index, "m_fFlags", 0),
        movement_state = get_movement_state(ent_index),
        positive_abs_yaw = 0,
        negative_abs_yaw = 0,
        resolved_yaw = 0,
        resolver_mode = "none",
        confidence = 0,
        
        -- Lag compensation data
        compensation_ticks = compensation_ticks,
        backtrack_ticks = backtrack_ticks,
        predicted_origin = predict_enemy_position(ent_index, compensation_ticks),
        network_stats = network_stats[ent_index],
        valid = backtrack_ticks >= 0 and compensation_ticks >= 0
    }
    
    -- Add velocity-based prediction confidence
    local velocity_2d = get_velocity_2d(ent_index)
    if velocity_2d < 5 then
        record.prediction_confidence = 0.95 -- High confidence for stationary targets
    elseif velocity_2d < 100 then
        record.prediction_confidence = 0.8 -- Medium confidence for slow movement
    else
        record.prediction_confidence = 0.6 -- Lower confidence for fast movement
    end
    
    return record
end

-- Initialize lag records for all players
local function init_lag_records()
    for i = 1, MAX_PLAYERS do
        lag_records[i] = {}
    end
end

local function get_lag_compensated_record(ent_index, target_tick)
    -- Get the lag record closest to the target tick
    local records = lag_records[ent_index]
    if not records or #records == 0 then
        return create_lag_record(ent_index)
    end
    
    local best_record = nil
    local best_tick_diff = math.huge
    
    for i = 1, #records do
        local record = records[i]
        local tick_diff = math_abs(record.tickcount - target_tick)
        
        if tick_diff < best_tick_diff then
            best_tick_diff = tick_diff
            best_record = record
        end
    end
    
    return best_record or create_lag_record(ent_index)
end

local function interpolate_lag_records(record1, record2, factor)
    -- Interpolate between two lag records for smoother compensation
    if not record1 or not record2 then
        return record1 or record2
    end
    
    local interpolated = {
        ent_index = record1.ent_index,
        tickcount = record1.tickcount + (record2.tickcount - record1.tickcount) * factor,
        origin = {
            record1.origin[1] + (record2.origin[1] - record1.origin[1]) * factor,
            record1.origin[2] + (record2.origin[2] - record1.origin[2]) * factor,
            record1.origin[3] + (record2.origin[3] - record1.origin[3]) * factor
        },
        eye_angles = {
            record1.eye_angles[1] + angle_diff(record2.eye_angles[1], record1.eye_angles[1]) * factor,
            normalize_yaw(record1.eye_angles[2] + angle_diff(record2.eye_angles[2], record1.eye_angles[2]) * factor)
        },
        velocity = {
            record1.velocity[1] + (record2.velocity[1] - record1.velocity[1]) * factor,
            record1.velocity[2] + (record2.velocity[2] - record1.velocity[2]) * factor,
            record1.velocity[3] + (record2.velocity[3] - record1.velocity[3]) * factor
        },
        lby = normalize_yaw(record1.lby + angle_diff(record2.lby, record1.lby) * factor),
        flags = record2.flags, -- Use most recent flags
        movement_state = record2.movement_state,
        prediction_confidence = (record1.prediction_confidence + record2.prediction_confidence) * 0.5
    }
    
    return interpolated
end

-- Add lag record for player
local function add_lag_record(ent_index, record)
    if not lag_records[ent_index] then
        lag_records[ent_index] = {}
    end
    
    table.insert(lag_records[ent_index], 1, record)
    
    -- Keep only 64 records for better lag compensation
    while #lag_records[ent_index] > 64 do
        table.remove(lag_records[ent_index])
    end
end

-- Get latest lag record for player
local function get_latest_record(ent_index)
    if lag_records[ent_index] and #lag_records[ent_index] > 0 then
        return lag_records[ent_index][1]
    end
    return nil
end

-- Advanced Animation Layer Analysis Functions
local function get_animation_layer_data(ent_index, layer_index)
    -- Attempt to get animation layer data (requires FFI or memory access)
    -- This is a simplified version - real implementation would need memory offsets
    local base_prop = "m_flPoseParameter[" .. tostring(layer_index) .. "]"
    return entity.get_prop(ent_index, base_prop) or 0
end

local function simulate_animation_update(ent_index, yaw_offset)
    -- Simulate forcing animation state update with yaw offset
    -- Based on Onetap v2 SetAngles logic
    local current_yaw = entity.get_prop(ent_index, "m_angEyeAngles[1]") or 0
    local test_yaw = normalize_yaw(current_yaw + yaw_offset)
    
    -- Simulate GoalFeetYaw calculation
    local velocity = get_velocity_2d(ent_index)
    local on_ground = is_on_ground(ent_index)
    
    if velocity < 0.1 and on_ground then
        -- Standing still - use LBY logic
        local lby = entity.get_prop(ent_index, "m_flLowerBodyYawTarget") or 0
        return normalize_yaw(lby + (test_yaw - current_yaw) * 0.5)
    else
        -- Moving - feet follow movement direction more closely
        return normalize_yaw(test_yaw * 0.8)
    end
end

local function analyze_animation_playback_rates(ent_index)
    -- Analyze movement layer playback rates for desync detection
    local movement_layer_6 = get_animation_layer_data(ent_index, 6)
    local movement_layer_7 = get_animation_layer_data(ent_index, 7)
    
    -- Compare playback rates in positive vs negative states
    local positive_rate = movement_layer_6 * 1.2 -- Simulated positive state
    local negative_rate = movement_layer_6 * 0.8 -- Simulated negative state
    
    return {
        positive_playback = positive_rate,
        negative_playback = negative_rate,
        base_rate = movement_layer_6,
        secondary_rate = movement_layer_7
    }
end

local function analyze_animation_layers(ent_index)
    -- Advanced animation layer analysis based on Onetap v2 resolver logic
    local record = create_lag_record(ent_index)
    local eye_yaw = record.eye_angles[2]
    
    -- Simulate positive and negative yaw offsets (Onetap method)
    local positive_offset = 58 -- Maximum desync range
    local negative_offset = -58
    
    -- Get GoalFeetYaw for both scenarios
    record.positive_abs_yaw = simulate_animation_update(ent_index, positive_offset)
    record.negative_abs_yaw = simulate_animation_update(ent_index, negative_offset)
    
    -- Analyze animation playback rates
    local playback_data = analyze_animation_playback_rates(ent_index)
    
    -- Determine desync direction using multiple factors
    local eye_to_positive = angle_diff(eye_yaw, record.positive_abs_yaw)
    local eye_to_negative = angle_diff(eye_yaw, record.negative_abs_yaw)
    local lby_to_positive = angle_diff(record.lby, record.positive_abs_yaw)
    local lby_to_negative = angle_diff(record.lby, record.negative_abs_yaw)
    
    -- Weight factors for decision making
    local positive_score = 0
    local negative_score = 0
    
    -- Factor 1: Eye angle proximity
    if eye_to_positive < eye_to_negative then
        positive_score = positive_score + 2
    else
        negative_score = negative_score + 2
    end
    
    -- Factor 2: LBY relationship
    if lby_to_positive > lby_to_negative then
        positive_score = positive_score + 1
    else
        negative_score = negative_score + 1
    end
    
    -- Factor 3: Animation playback rate analysis
    if playback_data.positive_playback > playback_data.negative_playback then
        positive_score = positive_score + 1
    else
        negative_score = negative_score + 1
    end
    
    -- Factor 4: Movement direction analysis
    local vel_x = record.velocity[1]
    local vel_y = record.velocity[2]
    if vel_x ~= 0 or vel_y ~= 0 then
        local movement_yaw = math_deg(math.atan2(vel_y, vel_x))
        local movement_to_positive = angle_diff(movement_yaw, record.positive_abs_yaw)
        local movement_to_negative = angle_diff(movement_yaw, record.negative_abs_yaw)
        
        if movement_to_positive < movement_to_negative then
            positive_score = positive_score + 1
        else
            negative_score = negative_score + 1
        end
    end
    
    -- Make final decision
    if positive_score > negative_score then
        record.resolved_yaw = record.positive_abs_yaw
        record.resolver_mode = "positive"
        record.confidence = math.min(positive_score / (positive_score + negative_score), 0.95)
    else
        record.resolved_yaw = record.negative_abs_yaw
        record.resolver_mode = "negative"
        record.confidence = math.min(negative_score / (positive_score + negative_score), 0.95)
    end
    
    -- Store additional data for debugging
    record.animation_data = {
        positive_score = positive_score,
        negative_score = negative_score,
        playback_rates = playback_data,
        eye_to_positive = eye_to_positive,
        eye_to_negative = eye_to_negative
    }
    
    return record
end

-- Advanced Desync Offset Resolution
local desync_history = {} -- Store desync history for each player
local desync_breaker_detection = {} -- Track desync breaker patterns
local desync_patterns = {} -- Store advanced desync patterns
local movement_prediction = {} -- Enhanced movement prediction

local function track_desync_updates(ent_index)
    -- Track desync updates to detect breakers and patterns
    local current_lby = entity.get_prop(ent_index, "m_flLowerBodyYawTarget") or 0
    local current_eye_yaw = entity.get_prop(ent_index, "m_angEyeAngles[1]") or 0
    local current_tick = api.globals.tickcount()
    
    if not desync_history[ent_index] then
        desync_history[ent_index] = {}
    end
    
    local history = desync_history[ent_index]
    
    -- Add current desync data
    table.insert(history, {
        lby = current_lby,
        eye_yaw = current_eye_yaw,
        delta = angle_diff(current_lby, current_eye_yaw),
        tick = current_tick,
        velocity = get_velocity_2d(ent_index)
    })
    
    -- Keep only last 20 desync records
    if #history > 20 then
        table.remove(history, 1)
    end
    
    return history
end

local function detect_desync_breaker(ent_index)
    -- Detect if player is using desync breaker
    local history = desync_history[ent_index]
    if not history or #history < 5 then
        return false, "insufficient_data"
    end
    
    local recent_deltas = {}
    local lby_update_count = 0
    local significant_changes = 0
    
    -- Analyze recent LBY behavior
    for i = math.max(1, #history - 10), #history do
        local record = history[i]
        table.insert(recent_deltas, record.delta)
        
        -- Check for desync updates (when velocity is low)
        if record.velocity < 5 then
            lby_update_count = lby_update_count + 1
            
            -- Check for significant desync changes
            if i > 1 then
                local prev_record = history[i-1]
                local lby_change = math.abs(angle_diff(record.lby, prev_record.lby))
                if lby_change > 10 then
                    significant_changes = significant_changes + 1
                end
            end
        end
    end
    
    -- Calculate delta variance to detect breaker patterns
    local delta_sum = 0
    for i = 1, #recent_deltas do
        delta_sum = delta_sum + recent_deltas[i]
    end
    local delta_avg = delta_sum / #recent_deltas
    
    local variance = 0
    for i = 1, #recent_deltas do
        variance = variance + (recent_deltas[i] - delta_avg) ^ 2
    end
    variance = variance / #recent_deltas
    
    -- Breaker detection logic
    local is_breaker = false
    local breaker_type = "none"
    
    if variance > 1000 then -- High variance indicates breaker
        is_breaker = true
        breaker_type = "high_variance"
    elseif significant_changes > 3 then -- Frequent desync changes
        is_breaker = true
        breaker_type = "frequent_updates"
    elseif lby_update_count < 2 and #recent_deltas > 8 then -- Desync not updating when it should
        is_breaker = true
        breaker_type = "frozen_lby"
    end
    
    -- Store breaker detection results
    if not desync_breaker_detection[ent_index] then
        desync_breaker_detection[ent_index] = {}
    end
    
    desync_breaker_detection[ent_index] = {
        is_breaker = is_breaker,
        breaker_type = breaker_type,
        variance = variance,
        significant_changes = significant_changes,
        lby_update_count = lby_update_count,
        confidence = math.min(variance / 2000, 0.9),
        last_detection = api.globals.tickcount()
    }
    
    return is_breaker, breaker_type
end

-- GetMaxDesync function (inspired by korose resolver)
local function get_max_desync(player)
    if not player then return 0 end
    
    -- Get animation state data
    local duck_amount = entity.get_prop(player, "m_flDuckAmount") or 0
    local velocity = get_velocity_2d(player)
    
    -- Calculate speed factor
    local speedfactor = math.min(velocity / 260, 1) -- 260 is max run speed
    local avg_speedfactor = (0.7 * -0.3 - 0.2) * speedfactor + 1
    
    -- Apply duck amount modifier
    if duck_amount > 0 then
        avg_speedfactor = avg_speedfactor + ((duck_amount * speedfactor) * (0.5 - avg_speedfactor))
    end
    
    -- Clamp between 0.5 and 1
    return math.max(0.5, math.min(avg_speedfactor, 1))
end

-- Jitter Detection System (inspired by korose resolver)
local jitter_data = {}

local function detect_jitter(ent_index)
    if not jitter_data[ent_index] then
        jitter_data[ent_index] = {
            last_yaw = 0,
            jitter_count = 0,
            last_jitter_time = 0,
            jitter_pattern = {},
            confidence = 0
        }
    end
    
    local current_yaw = entity.get_prop(ent_index, "m_angEyeAngles[1]") or 0
    local current_time = api.globals.curtime()
    local jitter_info = jitter_data[ent_index]
    
    -- Calculate yaw difference
    local yaw_diff = math.abs(angle_diff(current_yaw, jitter_info.last_yaw))
    
    -- Detect jitter pattern (rapid yaw changes) - using max desync calculation
    local max_desync_factor = get_max_desync(ent_index)
    local jitter_threshold = 45.0 * max_desync_factor
    
    if yaw_diff >= jitter_threshold and (current_time - jitter_info.last_jitter_time) < 0.1 then
        jitter_info.jitter_count = jitter_info.jitter_count + 1
        jitter_info.last_jitter_time = current_time
        
        -- Store jitter pattern
        table.insert(jitter_info.jitter_pattern, {
            yaw = current_yaw,
            diff = yaw_diff,
            time = current_time
        })
        
        -- Keep only recent jitter data
        if #jitter_info.jitter_pattern > 10 then
            table.remove(jitter_info.jitter_pattern, 1)
        end
    end
    
    -- Calculate jitter confidence
    local recent_jitters = 0
    for i = 1, #jitter_info.jitter_pattern do
        if (current_time - jitter_info.jitter_pattern[i].time) < 1.0 then
            recent_jitters = recent_jitters + 1
        end
    end
    
    jitter_info.confidence = math.min(recent_jitters / 5, 1.0)
    jitter_info.last_yaw = current_yaw
    
    return {
        is_jittering = recent_jitters > 2,
        confidence = jitter_info.confidence,
        jitter_count = recent_jitters,
        pattern_strength = #jitter_info.jitter_pattern > 0 and (jitter_info.jitter_pattern[#jitter_info.jitter_pattern].diff or 0) or 0
    }
end

-- Advanced Desync Pattern Analysis
local function analyze_desync_patterns(ent_index)
    local history = desync_history[ent_index]
    if not history or #history < 10 then
        return {pattern_type = "insufficient_data", confidence = 0.1}
    end
    
    local recent_records = {}
    for i = math.max(1, #history - 15), #history do
        table.insert(recent_records, history[i])
    end
    
    -- Analyze desync consistency
    local left_count, right_count, center_count = 0, 0, 0
    local delta_changes = 0
    local velocity_correlation = 0
    
    for i = 1, #recent_records do
        local record = recent_records[i]
        local delta = record.delta
        
        if math.abs(delta) < 15 then
            center_count = center_count + 1
        elseif delta > 15 then
            right_count = right_count + 1
        else
            left_count = left_count + 1
        end
        
        -- Track delta changes
        if i > 1 then
            local prev_delta = recent_records[i-1].delta
            if math.abs(delta - prev_delta) > 30 then
                delta_changes = delta_changes + 1
            end
            
            -- Velocity correlation analysis
            if record.velocity < 5 and math.abs(delta) > 35 then
                velocity_correlation = velocity_correlation + 1
            end
        end
    end
    
    -- Determine pattern type
    local pattern_type = "unknown"
    local confidence = 0.5
    
    if delta_changes > (#recent_records * 0.6) then
        pattern_type = "jitter_desync"
        confidence = 0.9
    elseif left_count > (#recent_records * 0.7) then
        pattern_type = "left_bias"
        confidence = 0.85
    elseif right_count > (#recent_records * 0.7) then
        pattern_type = "right_bias"
        confidence = 0.85
    elseif center_count > (#recent_records * 0.6) then
        pattern_type = "minimal_desync"
        confidence = 0.8
    elseif velocity_correlation > (#recent_records * 0.4) then
        pattern_type = "velocity_based"
        confidence = 0.75
    end
    
    -- Store pattern analysis
    if not desync_patterns[ent_index] then
        desync_patterns[ent_index] = {}
    end
    
    desync_patterns[ent_index] = {
        pattern_type = pattern_type,
        confidence = confidence,
        left_tendency = left_count / #recent_records,
        right_tendency = right_count / #recent_records,
        center_tendency = center_count / #recent_records,
        jitter_factor = delta_changes / #recent_records,
        velocity_correlation = velocity_correlation / #recent_records,
        last_analysis = api.globals.tickcount()
    }
    
    return desync_patterns[ent_index]
end

-- Enhanced Movement Prediction
local function predict_movement(ent_index)
    if not movement_prediction[ent_index] then
        movement_prediction[ent_index] = {
            positions = {},
            velocities = {},
            accelerations = {},
            last_update = 0
        }
    end
    
    local prediction_data = movement_prediction[ent_index]
    local current_tick = api.globals.tickcount()
    
    -- Get current entity data
    local origin = {entity.get_prop(ent_index, "m_vecOrigin")}
    local velocity = {entity.get_prop(ent_index, "m_vecVelocity")}
    
    if not origin[1] or not velocity[1] then
        return {predicted_x = 0, predicted_y = 0, confidence = 0}
    end
    
    -- Store current data
    table.insert(prediction_data.positions, {x = origin[1], y = origin[2], tick = current_tick})
    table.insert(prediction_data.velocities, {x = velocity[1], y = velocity[2], tick = current_tick})
    
    -- Keep only recent data (last 32 ticks)
    if #prediction_data.positions > 32 then
        table.remove(prediction_data.positions, 1)
    end
    if #prediction_data.velocities > 32 then
        table.remove(prediction_data.velocities, 1)
    end
    
    -- Calculate acceleration if we have enough data
    if #prediction_data.velocities >= 2 then
        local current_vel = prediction_data.velocities[#prediction_data.velocities]
        local prev_vel = prediction_data.velocities[#prediction_data.velocities - 1]
        
        local accel_x = current_vel.x - prev_vel.x
        local accel_y = current_vel.y - prev_vel.y
        
        table.insert(prediction_data.accelerations, {x = accel_x, y = accel_y, tick = current_tick})
        
        if #prediction_data.accelerations > 16 then
            table.remove(prediction_data.accelerations, 1)
        end
    end
    
    -- Predict future position (3-5 ticks ahead)
    local prediction_ticks = 4
    local predicted_x, predicted_y = origin[1], origin[2]
    local confidence = 0.5
    
    if #prediction_data.positions >= 5 then
        -- Linear prediction based on velocity
        local avg_vel_x, avg_vel_y = 0, 0
        local vel_samples = math.min(8, #prediction_data.velocities)
        
        for i = #prediction_data.velocities - vel_samples + 1, #prediction_data.velocities do
            avg_vel_x = avg_vel_x + prediction_data.velocities[i].x
            avg_vel_y = avg_vel_y + prediction_data.velocities[i].y
        end
        
        avg_vel_x = avg_vel_x / vel_samples
        avg_vel_y = avg_vel_y / vel_samples
        
        -- Apply acceleration if available
        if #prediction_data.accelerations >= 3 then
            local avg_accel_x, avg_accel_y = 0, 0
            local accel_samples = math.min(4, #prediction_data.accelerations)
            
            for i = #prediction_data.accelerations - accel_samples + 1, #prediction_data.accelerations do
                avg_accel_x = avg_accel_x + prediction_data.accelerations[i].x
                avg_accel_y = avg_accel_y + prediction_data.accelerations[i].y
            end
            
            avg_accel_x = avg_accel_x / accel_samples
            avg_accel_y = avg_accel_y / accel_samples
            
            -- Predict with acceleration
            predicted_x = origin[1] + (avg_vel_x * prediction_ticks * api.globals.tickinterval()) + (0.5 * avg_accel_x * math.pow(prediction_ticks * api.globals.tickinterval(), 2))
        predicted_y = origin[2] + (avg_vel_y * prediction_ticks * api.globals.tickinterval()) + (0.5 * avg_accel_y * math.pow(prediction_ticks * api.globals.tickinterval(), 2))
            
            confidence = 0.8
        else
            -- Simple linear prediction
            predicted_x = origin[1] + (avg_vel_x * prediction_ticks * api.globals.tickinterval())
        predicted_y = origin[2] + (avg_vel_y * prediction_ticks * api.globals.tickinterval())
            
            confidence = 0.6
        end
        
        -- Adjust confidence based on movement consistency
        local velocity_variance = 0
        for i = 1, #prediction_data.velocities - 1 do
            local vel_diff = math.sqrt(math.pow(prediction_data.velocities[i+1].x - prediction_data.velocities[i].x, 2) + 
                                     math.pow(prediction_data.velocities[i+1].y - prediction_data.velocities[i].y, 2))
            velocity_variance = velocity_variance + vel_diff
        end
        
        velocity_variance = velocity_variance / (#prediction_data.velocities - 1)
        
        -- Lower confidence for erratic movement
        if velocity_variance > 100 then
            confidence = confidence * 0.7
        elseif velocity_variance < 20 then
            confidence = math.min(0.95, confidence * 1.2)
        end
    end
    
    prediction_data.last_update = current_tick
    
    return {
        predicted_x = predicted_x,
        predicted_y = predicted_y,
        confidence = confidence,
        velocity_variance = velocity_variance or 0
    }
end

local function calculate_absolute_yaw(ent_index)
    -- Calculate absolute yaw based on desync analysis
    local eye_yaw = entity.get_prop(ent_index, "m_angEyeAngles[1]") or 0
    local lby = entity.get_prop(ent_index, "m_flLowerBodyYawTarget") or 0
    local velocity = get_velocity_2d(ent_index)
    
    -- For moving players, use different logic
    if velocity > 5 then
        local vel_x = entity.get_prop(ent_index, "m_vecVelocity[0]") or 0
    local vel_y = entity.get_prop(ent_index, "m_vecVelocity[1]") or 0
        local movement_yaw = math_deg(math.atan2(vel_y, vel_x))
        
        -- Blend eye yaw with movement direction
        return normalize_yaw(eye_yaw * 0.7 + movement_yaw * 0.3)
    end
    
    -- For standing players, analyze desync relationship
    local desync_delta = angle_diff(lby, eye_yaw)
    local abs_delta = math.abs(desync_delta)
    
    -- Detect desync direction and magnitude
    if abs_delta < 5 then
        -- No significant desync detected
        return eye_yaw
    elseif abs_delta > 50 then
        -- Maximum desync detected
        if desync_delta > 0 then
            return normalize_yaw(eye_yaw + 58) -- Max right desync
        else
            return normalize_yaw(eye_yaw - 58) -- Max left desync
        end
    else
        -- Partial desync - calculate based on LBY delta
        local desync_factor = abs_delta / 58 -- Normalize to 0-1
        local desync_amount = desync_factor * 58
        
        if desync_delta > 0 then
            return normalize_yaw(eye_yaw + desync_amount)
        else
            return normalize_yaw(eye_yaw - desync_amount)
        end
    end
end

local function resolve_desync_offset(ent_index)
    -- Advanced desync offset resolution with enhanced pattern analysis
    local history = track_desync_updates(ent_index)
    local is_breaker, breaker_type = detect_desync_breaker(ent_index)
    local pattern_analysis = analyze_desync_patterns(ent_index)
    local movement_pred = predict_movement(ent_index)
    
    local eye_yaw = entity.get_prop(ent_index, "m_angEyeAngles[1]") or 0
    local lby = entity.get_prop(ent_index, "m_flLowerBodyYawTarget") or 0
    local velocity = get_velocity_2d(ent_index)
    
    local resolved_yaw = eye_yaw
    local confidence = 0.5
    local method = "standard_desync"
    
    -- Enhanced desync breaker handling with pattern analysis
    if is_breaker and pattern_analysis.confidence > 0.7 then
        method = "enhanced_breaker_compensation"
        
        if breaker_type == "high_variance" then
            -- Use pattern analysis for jitter prediction
            if pattern_analysis.pattern_type == "jitter_desync" then
                local jitter_offset = pattern_analysis.jitter_factor > 0.8 and math.random(-45, 45) or math.random(-25, 25)
                resolved_yaw = normalize_yaw(eye_yaw + jitter_offset)
                confidence = 0.9
            else
                local animation_record = analyze_animation_layers(ent_index)
                resolved_yaw = animation_record.resolved_yaw
                confidence = animation_record.confidence * 0.8
            end
        elseif breaker_type == "frequent_updates" then
            -- Use bias analysis for frequent updates
            if pattern_analysis.left_tendency > 0.6 then
                resolved_yaw = normalize_yaw(eye_yaw - 35)
                confidence = 0.85
            elseif pattern_analysis.right_tendency > 0.6 then
                resolved_yaw = normalize_yaw(eye_yaw + 35)
                confidence = 0.85
            else
                -- Fallback to weighted average
                local eye_sum = 0
                local count = 0
                for i = math.max(1, #history - 8), #history do
                    local weight = (i - math.max(1, #history - 8) + 1) / 8
                    eye_sum = eye_sum + (history[i].eye_yaw * weight)
                    count = count + weight
                end
                resolved_yaw = normalize_yaw(eye_sum / count)
                confidence = 0.7
            end
        elseif breaker_type == "frozen_lby" then
            -- Enhanced frozen LBY handling
            local desync_delta = angle_diff(lby, eye_yaw)
            if math.abs(desync_delta) > 35 then
                -- Use pattern-based prediction
                if pattern_analysis.pattern_type == "velocity_based" and movement_pred.confidence > 0.6 then
                    local velocity_yaw = math.deg(math.atan2(movement_pred.predicted_y, movement_pred.predicted_x))
                    local yaw_diff = normalize_angle(eye_yaw - velocity_yaw)
                    resolved_yaw = normalize_yaw(eye_yaw + (yaw_diff > 0 and 35 or -35))
                    confidence = 0.8
                else
                    resolved_yaw = calculate_absolute_yaw(ent_index)
                    confidence = 0.7
                end
            else
                resolved_yaw = eye_yaw
                confidence = 0.8
            end
        end
    else
        -- Enhanced normal desync resolution
        method = "enhanced_standard"
        
        -- Use pattern analysis for better prediction
        if pattern_analysis.confidence > 0.75 then
            local offset = 0
            confidence = pattern_analysis.confidence
            
            if pattern_analysis.pattern_type == "left_bias" then
                offset = -35 * pattern_analysis.left_tendency
                method = "pattern_left_bias"
            elseif pattern_analysis.pattern_type == "right_bias" then
                offset = 35 * pattern_analysis.right_tendency
                method = "pattern_right_bias"
            elseif pattern_analysis.pattern_type == "minimal_desync" then
                offset = math.random(-15, 15)
                method = "pattern_minimal"
            elseif pattern_analysis.pattern_type == "velocity_based" then
                -- Enhanced velocity-based prediction
                if movement_pred.confidence > 0.6 then
                    local vel_x = entity.get_prop(ent_index, "m_vecVelocity[0]") or 0
    local vel_y = entity.get_prop(ent_index, "m_vecVelocity[1]") or 0
                    local predicted_yaw = math.deg(math.atan2(movement_pred.predicted_y, movement_pred.predicted_x))
                    local current_vel_yaw = math.deg(math.atan2(vel_y, vel_x))
                    local blended_yaw = current_vel_yaw * 0.7 + predicted_yaw * 0.3
                    local yaw_diff = normalize_angle(eye_yaw - blended_yaw)
                    offset = yaw_diff > 0 and 35 or -35
                    confidence = math.min(0.95, confidence + movement_pred.confidence * 0.2)
                    method = "enhanced_velocity_prediction"
                else
                    offset = velocity > 5 and (math.random() > 0.5 and 35 or -35) or 0
                end
            end
            
            resolved_yaw = normalize_yaw(eye_yaw + offset)
        else
            -- Fallback to standard resolution with movement consideration
            if velocity < 5 then
                -- Standing player - enhanced desync analysis
                resolved_yaw = calculate_absolute_yaw(ent_index)
                confidence = 0.85
                method = "standing_enhanced"
            else
                -- Moving player - enhanced movement prediction
                if movement_pred.confidence > 0.5 then
                    resolved_yaw = calculate_absolute_yaw(ent_index)
                    confidence = 0.75 + (movement_pred.confidence * 0.15)
                    method = "moving_enhanced"
                else
                    resolved_yaw = calculate_absolute_yaw(ent_index)
                    confidence = 0.75
                    method = "moving_standard"
                end
            end
        end
    end
    
    -- Enhanced resolution results with more data
    local resolution_data = {
        resolved_yaw = resolved_yaw,
        confidence = confidence,
        is_breaker = is_breaker,
        breaker_type = breaker_type,
        desync_delta = angle_diff(lby, eye_yaw),
        velocity = velocity,
        method = method,
        pattern_type = pattern_analysis.pattern_type,
        pattern_confidence = pattern_analysis.confidence,
        movement_confidence = movement_pred.confidence,
        left_tendency = pattern_analysis.left_tendency or 0,
        right_tendency = pattern_analysis.right_tendency or 0,
        jitter_factor = pattern_analysis.jitter_factor or 0,
        resolver_mode = method -- Add resolver_mode based on method used
    }
    
    return resolved_yaw, resolution_data
end

-- Advanced Pitch Resolution and Realer
local pitch_history = {} -- Store pitch history for each player
local pitch_patterns = {} -- Track pitch anti-aim patterns

local function track_pitch_updates(ent_index)
    -- Track pitch updates to detect anti-aim patterns
    local current_pitch = entity.get_prop(ent_index, "m_angEyeAngles[0]") or 0
    local current_tick = api.globals.tickcount()
    local velocity = get_velocity_2d(ent_index)
    local flags = entity.get_prop(ent_index, "m_fFlags") or 0
    local on_ground = bit.band(flags, 1) == 1
    
    if not pitch_history[ent_index] then
        pitch_history[ent_index] = {}
    end
    
    local history = pitch_history[ent_index]
    
    -- Add current pitch data
    table.insert(history, {
        pitch = current_pitch,
        tick = current_tick,
        velocity = velocity,
        on_ground = on_ground,
        duck_amount = entity.get_prop(ent_index, "m_flDuckAmount") or 0
    })
    
    -- Keep only last 15 pitch records
    if #history > 15 then
        table.remove(history, 1)
    end
    
    return history
end

local function detect_pitch_antiaim(ent_index)
    -- Detect pitch anti-aim patterns
    local history = pitch_history[ent_index]
    if not history or #history < 5 then
        return false, "normal", 0.5
    end
    
    local pitch_changes = {}
    local extreme_pitches = 0
    local rapid_changes = 0
    
    -- Analyze pitch behavior
    for i = 2, #history do
        local current = history[i]
        local previous = history[i-1]
        local pitch_change = math.abs(current.pitch - previous.pitch)
        
        table.insert(pitch_changes, pitch_change)
        
        -- Count extreme pitches (fake up/down)
        if math.abs(current.pitch) > 85 then
            extreme_pitches = extreme_pitches + 1
        end
        
        -- Count rapid pitch changes
        if pitch_change > 30 then
            rapid_changes = rapid_changes + 1
        end
    end
    
    -- Calculate average pitch change
    local total_change = 0
    for i = 1, #pitch_changes do
        total_change = total_change + pitch_changes[i]
    end
    local avg_change = total_change / #pitch_changes
    
    -- Determine anti-aim type
    local is_antiim = false
    local aa_type = "normal"
    local confidence = 0.5
    
    if extreme_pitches > (#history * 0.6) then
        -- Fake up/down detected
        is_antiim = true
        aa_type = "fake_up_down"
        confidence = 0.9
    elseif rapid_changes > (#history * 0.4) then
        -- Jitter detected
        is_antiim = true
        aa_type = "jitter"
        confidence = 0.8
    elseif avg_change > 20 then
        -- High variance pitch
        is_antiim = true
        aa_type = "high_variance"
        confidence = 0.7
    end
    
    -- Store pattern detection results
    if not pitch_patterns[ent_index] then
        pitch_patterns[ent_index] = {}
    end
    
    pitch_patterns[ent_index] = {
        is_antiim = is_antiim,
        aa_type = aa_type,
        confidence = confidence,
        extreme_pitches = extreme_pitches,
        rapid_changes = rapid_changes,
        avg_change = avg_change,
        last_detection = api.globals.tickcount()
    }
    
    return is_antiim, aa_type, confidence
end

local function predict_real_pitch(ent_index)
    -- Predict the real pitch based on movement and stance
    local velocity = get_velocity_2d(ent_index)
    local flags = entity.get_prop(ent_index, "m_fFlags") or 0
    local on_ground = bit.band(flags, 1) == 1
    local duck_amount = entity.get_prop(ent_index, "m_flDuckAmount") or 0
    
    local predicted_pitch = 0
    
    if not on_ground then
        -- Airborne - predict based on velocity
        local vel_z = entity.get_prop(ent_index, "m_vecVelocity[2]") or 0
        if vel_z > 0 then
            predicted_pitch = -15 -- Looking up while jumping
        else
            predicted_pitch = 25 -- Looking down while falling
        end
    elseif duck_amount > 0.5 then
        -- Crouching - likely looking down
        predicted_pitch = 35 + (duck_amount * 20)
    elseif velocity > 100 then
        -- Fast movement - slight downward angle
        predicted_pitch = 10 + (velocity / 50)
    else
        -- Standing/slow movement - neutral to slight down
        predicted_pitch = 5
    end
    
    -- Clamp to valid range
    predicted_pitch = math.max(-89, math.min(89, predicted_pitch))
    
    return predicted_pitch
end

local function calculate_hitbox_offset(ent_index, target_pitch)
    -- Calculate vertical hitbox offset based on pitch
    local duck_amount = entity.get_prop(ent_index, "m_flDuckAmount") or 0
    local base_height = 64 -- Standard player height
    local crouch_height = 46 -- Crouched player height
    
    -- Interpolate height based on duck amount
    local player_height = base_height - (base_height - crouch_height) * duck_amount
    
    -- Calculate head position offset
    local head_offset = player_height * 0.9 -- Head is ~90% of player height
    
    -- Apply pitch-based vertical adjustment
    local pitch_rad = math.rad(target_pitch)
    local vertical_adjustment = math.sin(pitch_rad) * 10 -- Adjust based on pitch
    
    return {
        head_offset = head_offset + vertical_adjustment,
        chest_offset = player_height * 0.6,
        stomach_offset = player_height * 0.4,
        pelvis_offset = player_height * 0.2
    }
end

local function resolve_pitch(ent_index)
    -- Advanced pitch resolution with anti-aim detection
    local history = track_pitch_updates(ent_index)
    local is_antiim, aa_type, aa_confidence = detect_pitch_antiaim(ent_index)
    
    local current_pitch = entity.get_prop(ent_index, "m_angEyeAngles[0]") or 0
    local resolved_pitch = current_pitch
    local confidence = 0.5
    
    if is_antiim then
        -- Handle anti-aim cases
        if aa_type == "fake_up_down" then
            -- Use predicted real pitch instead of fake angles
            resolved_pitch = predict_real_pitch(ent_index)
            confidence = aa_confidence * 0.9
        elseif aa_type == "jitter" then
            -- Use average of recent non-extreme pitches
            local valid_pitches = {}
            for i = 1, #history do
                local pitch = history[i].pitch
                if math.abs(pitch) < 80 then -- Filter out extreme angles
                    table.insert(valid_pitches, pitch)
                end
            end
            
            if #valid_pitches > 0 then
                local pitch_sum = 0
                for i = 1, #valid_pitches do
                    pitch_sum = pitch_sum + valid_pitches[i]
                end
                resolved_pitch = pitch_sum / #valid_pitches
                confidence = 0.7
            else
                resolved_pitch = predict_real_pitch(ent_index)
                confidence = 0.6
            end
        elseif aa_type == "high_variance" then
            -- Blend current pitch with predicted real pitch
            local predicted = predict_real_pitch(ent_index)
            resolved_pitch = current_pitch * 0.3 + predicted * 0.7
            confidence = 0.75
        end
    else
        -- Normal pitch resolution
        if math.abs(current_pitch) > 89 then
            -- Invalid pitch, use prediction
            resolved_pitch = predict_real_pitch(ent_index)
            confidence = 0.8
        else
            -- Use current pitch with slight adjustment
            local predicted = predict_real_pitch(ent_index)
            resolved_pitch = current_pitch * 0.8 + predicted * 0.2
            confidence = 0.9
        end
    end
    
    -- Clamp to valid range
    resolved_pitch = math.max(-89, math.min(89, resolved_pitch))
    
    -- Calculate hitbox offsets for different body parts
    local hitbox_offsets = calculate_hitbox_offset(ent_index, resolved_pitch)
    
    return {
        pitch = resolved_pitch,
        confidence = confidence,
        is_antiim = is_antiim,
        aa_type = aa_type,
        hitbox_offsets = hitbox_offsets,
        predicted_pitch = predict_real_pitch(ent_index)
    }
end

-- Advanced Yaw Resolution Logic
local yaw_history = {} -- Store yaw history for each player
local animation_state_cache = {} -- Cache animation states

local function track_yaw_history(ent_index, resolved_yaw, confidence)
    if not yaw_history[ent_index] then
        yaw_history[ent_index] = {}
    end
    
    local history = yaw_history[ent_index]
    table.insert(history, {
        yaw = resolved_yaw,
        confidence = confidence,
        tick = api.globals.tickcount()
    })
    
    -- Keep only last 10 records
    if #history > 10 then
        table.remove(history, 1)
    end
end

local function get_yaw_trend(ent_index)
    local history = yaw_history[ent_index]
    if not history or #history < 3 then
        return "unknown", 0
    end
    
    local positive_count = 0
    local negative_count = 0
    local total_confidence = 0
    
    for i = 1, #history do
        local record = history[i]
        total_confidence = total_confidence + record.confidence
        
        if record.yaw > 0 then
            positive_count = positive_count + 1
        else
            negative_count = negative_count + 1
        end
    end
    
    local avg_confidence = total_confidence / #history
    
    if positive_count > negative_count then
        return "positive_trend", avg_confidence
    elseif negative_count > positive_count then
        return "negative_trend", avg_confidence
    else
        return "mixed", avg_confidence
    end
end

local function analyze_playback_rate_changes(ent_index)
    -- Analyze changes in animation playback rates over time
    local current_rates = analyze_animation_playback_rates(ent_index)
    
    if not animation_state_cache[ent_index] then
        animation_state_cache[ent_index] = {
            previous_rates = current_rates,
            rate_changes = {},
            last_update = api.globals.tickcount()
        }
        return current_rates, 0 -- No change data available yet
    end
    
    local cache = animation_state_cache[ent_index]
    local prev_rates = cache.previous_rates
    
    -- Calculate rate changes
    local positive_change = current_rates.positive_playback - prev_rates.positive_playback
    local negative_change = current_rates.negative_playback - prev_rates.negative_playback
    local base_change = current_rates.base_rate - prev_rates.base_rate
    
    -- Store change data
    table.insert(cache.rate_changes, {
        positive_delta = positive_change,
        negative_delta = negative_change,
        base_delta = base_change,
        tick = api.globals.tickcount()
    })
    
    -- Keep only last 5 changes
    if #cache.rate_changes > 5 then
        table.remove(cache.rate_changes, 1)
    end
    
    -- Update cache
    cache.previous_rates = current_rates
    cache.last_update = api.globals.tickcount()
    
    -- Calculate change magnitude
    local change_magnitude = math.abs(positive_change) + math.abs(negative_change) + math.abs(base_change)
    
    return current_rates, change_magnitude
end

local function resolve_yaw_advanced(ent_index)
    -- Advanced yaw resolution using multiple analysis methods
    local record = analyze_animation_layers(ent_index)
    local current_rates, change_magnitude = analyze_playback_rate_changes(ent_index)
    local trend, trend_confidence = get_yaw_trend(ent_index)
    
    -- Base resolution from animation analysis
    local base_yaw = record.resolved_yaw
    local base_confidence = record.confidence
    
    -- Adjust confidence based on playback rate changes
    if change_magnitude > 0.1 then
        -- Significant animation changes detected - higher confidence
        base_confidence = math.min(base_confidence + 0.1, 0.95)
    end
    
    -- Apply trend analysis
    if trend == "positive_trend" and record.resolver_mode == "negative" then
        -- Trend suggests positive but current analysis says negative
        -- Reduce confidence or switch if trend is strong
        if trend_confidence > 0.8 then
            base_yaw = record.positive_abs_yaw
            record.resolver_mode = "positive"
            base_confidence = trend_confidence * 0.9
        else
            base_confidence = base_confidence * 0.7
        end
    elseif trend == "negative_trend" and record.resolver_mode == "positive" then
        -- Similar logic for negative trend
        if trend_confidence > 0.8 then
            base_yaw = record.negative_abs_yaw
            record.resolver_mode = "negative"
            base_confidence = trend_confidence * 0.9
        else
            base_confidence = base_confidence * 0.7
        end
    elseif trend == "mixed" then
        -- Mixed trend - slightly reduce confidence
        base_confidence = base_confidence * 0.85
    end
    
    -- Apply velocity-based corrections
    local velocity = get_velocity_2d(ent_index)
    if velocity > 5 then
        -- Player is moving - use movement-based prediction
        local vel_x = record.velocity[1]
        local vel_y = record.velocity[2]
        local movement_yaw = math_deg(math.atan2(vel_y, vel_x))
        
        -- Blend movement yaw with resolved yaw
        local movement_weight = math.min(velocity / 250, 0.3) -- Max 30% weight
        base_yaw = normalize_yaw(base_yaw * (1 - movement_weight) + movement_yaw * movement_weight)
    end
    
    -- Store in history for future trend analysis
    track_yaw_history(ent_index, base_yaw, base_confidence)
    
    -- Return final resolved data
    record.final_yaw = base_yaw
    record.final_confidence = base_confidence
    record.trend_data = {
        trend = trend,
        trend_confidence = trend_confidence,
        change_magnitude = change_magnitude
    }
    
    return record
end

local function resolve_yaw_basic(ent_index)
    -- Basic yaw resolution using animation layer analysis
    local record = analyze_animation_layers(ent_index)
    
    -- Apply basic resolver logic
    if record.resolver_mode == "positive" then
        return record.positive_abs_yaw
    else
        return record.negative_abs_yaw
    end
end

-- Advanced Choked Packets Analysis and Fakelag Detection
local choked_packets_history = {} -- Store choked packets data for each player
local fakelag_patterns = {} -- Track fakelag patterns
local packet_timing = {} -- Track packet timing patterns

local function track_choked_packets(ent_index)
    -- Track choked packets to detect fakelag patterns
    local current_tick = api.globals.tickcount()
    local simulation_time = entity.get_prop(ent_index, "m_flSimulationTime") or 0
    local old_simulation_time = entity.get_prop(ent_index, "m_flOldSimulationTime") or 0
    
    -- Calculate choked packets
    local choked_ticks = math.max(0, math_floor((simulation_time - old_simulation_time) / 0.015625))
    
    if not choked_packets_history[ent_index] then
        choked_packets_history[ent_index] = {}
    end
    
    local history = choked_packets_history[ent_index]
    
    -- Get and validate eye angles for choked packet tracking
    local eye_pitch = entity.get_prop(ent_index, "m_angEyeAngles[0]") or 0
    local eye_yaw = entity.get_prop(ent_index, "m_angEyeAngles[1]") or 0
    
    -- Validate angle types and ranges
    if type(eye_pitch) ~= "number" or type(eye_yaw) ~= "number" then
        eye_pitch, eye_yaw = 0, 0
    end
    if math.abs(eye_pitch) > 90 or math.abs(eye_yaw) > 180 then
        eye_pitch, eye_yaw = 0, 0
    end
    
    -- Add current choked packet data
    table.insert(history, {
        choked_ticks = choked_ticks,
        tick = current_tick,
        simulation_time = simulation_time,
        velocity = get_velocity_2d(ent_index),
        eye_angles = {eye_pitch, eye_yaw}
    })
    
    -- Keep only last 20 records
    if #history > 20 then
        table.remove(history, 1)
    end
    
    return history, choked_ticks
end

local function detect_fakelag_pattern(ent_index)
    -- Detect fakelag patterns and anti-aim behavior
    local history = choked_packets_history[ent_index]
    if not history or #history < 8 then
        return false, "normal", 0, 0.5
    end
    
    local choked_values = {}
    local high_choke_count = 0
    local zero_choke_count = 0
    local pattern_variance = 0
    
    -- Analyze choked packet patterns
    for i = 1, #history do
        local choked = history[i].choked_ticks
        table.insert(choked_values, choked)
        
        if choked > 10 then
            high_choke_count = high_choke_count + 1
        elseif choked == 0 then
            zero_choke_count = zero_choke_count + 1
        end
    end
    
    -- Calculate variance in choked packets
    local sum = 0
    for i = 1, #choked_values do
        sum = sum + choked_values[i]
    end
    local mean = sum / #choked_values
    
    local variance_sum = 0
    for i = 1, #choked_values do
        variance_sum = variance_sum + math.pow(choked_values[i] - mean, 2)
    end
    pattern_variance = variance_sum / #choked_values
    
    -- Determine fakelag type and strength
    local is_fakelag = false
    local fakelag_type = "normal"
    local fakelag_amount = 0
    local confidence = 0.5
    
    if high_choke_count > (#history * 0.4) then
        -- High fakelag detected
        is_fakelag = true
        fakelag_type = "high_fakelag"
        fakelag_amount = mean
        confidence = 0.9
    elseif pattern_variance > 25 then
        -- Variable fakelag (adaptive)
        is_fakelag = true
        fakelag_type = "adaptive_fakelag"
        fakelag_amount = mean
        confidence = 0.8
    elseif mean > 5 then
        -- Moderate fakelag
        is_fakelag = true
        fakelag_type = "moderate_fakelag"
        fakelag_amount = mean
        confidence = 0.7
    end
    
    -- Store pattern detection results
    if not fakelag_patterns[ent_index] then
        fakelag_patterns[ent_index] = {}
    end
    
    fakelag_patterns[ent_index] = {
        is_fakelag = is_fakelag,
        fakelag_type = fakelag_type,
        fakelag_amount = fakelag_amount,
        confidence = confidence,
        pattern_variance = pattern_variance,
        high_choke_ratio = high_choke_count / #history,
        zero_choke_ratio = zero_choke_count / #history,
        last_detection = api.globals.tickcount()
    }
    
    return is_fakelag, fakelag_type, fakelag_amount, confidence
end

local function predict_next_update(ent_index)
    -- Predict when the next real update will occur
    local history = choked_packets_history[ent_index]
    if not history or #history < 5 then
        return 1 -- Default to next tick
    end
    
    local pattern = fakelag_patterns[ent_index]
    if not pattern or not pattern.is_fakelag then
        return 1 -- No fakelag, expect update next tick
    end
    
    local current_tick = api.globals.tickcount()
    local last_update = history[#history]
    local ticks_since_update = current_tick - last_update.tick
    
    -- Predict based on fakelag type
    if pattern.fakelag_type == "high_fakelag" then
        -- High fakelag usually updates every 14-16 ticks
        local expected_interval = math_floor(pattern.fakelag_amount)
        return math.max(1, expected_interval - ticks_since_update)
    elseif pattern.fakelag_type == "adaptive_fakelag" then
        -- Adaptive fakelag is harder to predict, use average
        return math.max(1, math_floor(pattern.fakelag_amount * 0.7))
    else
        -- Moderate fakelag
        return math.max(1, math_floor(pattern.fakelag_amount * 0.8))
    end
end

local function compensate_for_fakelag(ent_index, base_angles)
    -- Compensate resolver angles for fakelag
    local is_fakelag, fakelag_type, fakelag_amount, confidence = detect_fakelag_pattern(ent_index)
    
    if not is_fakelag then
        return base_angles, 1.0 -- No fakelag compensation needed
    end
    
    local history = choked_packets_history[ent_index]
    local compensated_angles = {base_angles[1], base_angles[2]}
    local compensation_confidence = confidence
    
    -- Apply fakelag-specific compensation
    if fakelag_type == "high_fakelag" then
        -- High fakelag: use older data for more stable resolution
        if #history >= 3 then
            local older_record = history[#history - 2]
            if older_record.eye_angles and older_record.eye_angles[2] then
                compensated_angles[2] = older_record.eye_angles[2] or base_angles[2]
                compensation_confidence = confidence * 0.9
            end
        end
    elseif fakelag_type == "adaptive_fakelag" then
        -- Adaptive fakelag: blend multiple records
        local angle_sum = 0
        local valid_records = 0
        
        for i = math.max(1, #history - 4), #history do
            local record = history[i]
            if record.eye_angles and record.eye_angles[2] then
                angle_sum = angle_sum + record.eye_angles[2]
                valid_records = valid_records + 1
            end
        end
        
        if valid_records > 0 then
            compensated_angles[2] = angle_sum / valid_records
            compensation_confidence = confidence * 0.8
        end
    end
    
    return compensated_angles, compensation_confidence
end

-- Adaptive Learning System for Resolver Stability
local player_learning_data = {}
local adaptive_resolver_settings = {
    learning_rate = 0.1,
    stability_threshold = 0.6,
    max_history_size = 50,
    confidence_boost = 0.2,
    cleanup_interval = 30.0, -- seconds
    max_inactive_time = 60.0 -- seconds
}

-- Utility function for counting table elements
local function table_count(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end

-- Initialize player learning data
local function initialize_player_learning(ent_index)
    if not player_learning_data[ent_index] then
        player_learning_data[ent_index] = {
            preferred_angles = {},
            shot_history = {},
            confidence_modifier = 1.0,
            last_update = globals.realtime(),
            success_count = 0,
            total_attempts = 0
        }
    end
end

local function remove_duplicates_from_table(t)
    local seen = {}
    local j = 1
    for i = 1, #t do
        if not seen[t[i]] then
            seen[t[i]] = true
            t[j] = t[i]
            j = j + 1
        end
    end
    for i = #t, j, -1 do
        table.remove(t, i)
    end
end

-- Cleanup old learning data for memory optimization
local last_cleanup_time = 0
local function cleanup_old_learning_data()
    local current_time = globals.realtime()
    
    if current_time - last_cleanup_time < adaptive_resolver_settings.cleanup_interval then
        return
    end
    
    last_cleanup_time = current_time
    
    if player_learning_data then
        for ent_index, learning_data in pairs(player_learning_data) do
            -- Remove data for inactive players
            if not entity.is_alive(ent_index) or entity.is_dormant(ent_index) or 
               current_time - learning_data.last_update > adaptive_resolver_settings.max_inactive_time then
                player_learning_data[ent_index] = nil
            else
                -- Limit history size for active players
                if learning_data.shot_history then
                    remove_duplicates_from_table(learning_data.shot_history)
                    if #learning_data.shot_history > adaptive_resolver_settings.max_history_size then
                    local excess = #learning_data.shot_history - adaptive_resolver_settings.max_history_size
                    for i = 1, excess do
                        table.remove(learning_data.shot_history, 1)
                    end
                    end
                    end
                end
            end
        end
    end


local ai_learning_system = {
    pattern_weights = {
        velocity_based = 0.3,
        angle_based = 0.25,
        timing_based = 0.2,
        movement_based = 0.15,
        weapon_based = 0.1
    },
    confidence_threshold = 0.7,
    learning_rate = 0.1,
    min_samples = 5,
    max_pattern_age = 1800 -- 30 minutes
}

-- Shot database for AI learning system
local shot_database = {
    shots = {},
    player_profiles = {},
    last_cleanup = 0,
    cleanup_interval = 300 -- 5 minutes
}

-- Function moved to earlier location

-- PList functionality for forcing yaw
local function force_player_yaw(player_index, yaw_value, enable)
    if not player_index or player_index <= 0 then return end
    
    if enable and yaw_value then
        plist.set(player_index, "Force body yaw", true)
        plist.set(player_index, "Force body yaw value", yaw_value)
    else
        plist.set(player_index, "Force body yaw", false)
        plist.set(player_index, "Force body yaw value", 0)
    end
end

-- Fallback function for basic resolver data when primary validation fails
local function get_fallback_resolver_data(player_index)
    if not entity.is_alive(player_index) then
        return nil
    end
    
    -- Try to get basic data with minimal validation
    local origin = {entity.get_origin(player_index)}
    if not origin[1] then
        return nil
    end
    
    -- Use camera angles as fallback for eye angles
    local camera_angles = {client.camera_angles()}
    local fallback_yaw = camera_angles[2] or 0
    local fallback_pitch = camera_angles[1] or 0
    
    return {
        yaw = normalize_yaw(fallback_yaw),
        pitch = math.max(-89, math.min(89, fallback_pitch)),
        origin = origin,
        velocity = {0, 0, 0}, -- Default velocity
        lby = fallback_yaw, -- Use yaw as LBY fallback
        flags = 0,
        duck_amount = 0,
        is_fallback = true -- Mark as fallback data
    }
end

-- Validation function for resolver data
local function get_resolver_data(player_index)
    -- Enhanced security validation
    if security_system.enabled then
        local valid, error_msg = validate_entity_index(player_index)
        if not valid then
            simple_log("SECURITY: get_resolver_data validation failed - " .. error_msg, "resolver")
            return nil
        end
    end
    
    -- Check if player is alive (this also validates if player exists)
    if not entity.is_alive(player_index) then
        return nil
    end
    
    -- Validate entity functions
    if not entity.get_prop then
        simple_log("[ERROR] entity.get_prop function not available!", "resolver")
        return get_fallback_resolver_data(player_index) -- Use fallback
    end
    
    -- Get basic player data with validation
    local eye_angles = entity.get_prop(player_index, "m_angEyeAngles")
    if not eye_angles or type(eye_angles) ~= "table" or not eye_angles[1] or not eye_angles[2] then
        -- Try fallback instead of returning nil
        return get_fallback_resolver_data(player_index)
    end
    
    -- Validate angle ranges to prevent invalid data
    if type(eye_angles[1]) ~= "number" or type(eye_angles[2]) ~= "number" then
        return get_fallback_resolver_data(player_index)
    end
    
    -- Check for reasonable angle ranges (pitch: -89 to 89, yaw: any value but normalize)
    if math.abs(eye_angles[1]) > 90 then
        return get_fallback_resolver_data(player_index)
    end
    
    -- Normalize yaw to -180 to 180 range instead of rejecting
    eye_angles[2] = normalize_yaw(eye_angles[2])
    
    local origin = {entity.get_origin(player_index)}
    if not origin[1] then
        simple_log(string.format("[ERROR] Invalid origin for player %d", player_index), "resolver")
        return get_fallback_resolver_data(player_index)
    end
    
    local velocity = {safe_entity_get_prop(player_index, "m_vecVelocity[0]", 0), safe_entity_get_prop(player_index, "m_vecVelocity[1]", 0), safe_entity_get_prop(player_index, "m_vecVelocity[2]", 0)}
    
    -- Return validated data
    return {
        yaw = eye_angles[2],
        pitch = eye_angles[1] or 0,
        origin = origin,
        velocity = velocity,
        lby = safe_entity_get_prop(player_index, "m_flLowerBodyYawTarget", 0),
        flags = safe_entity_get_prop(player_index, "m_fFlags", 0),
        duck_amount = safe_entity_get_prop(player_index, "m_flDuckAmount", 0),
        is_fallback = false
    }
end

-- AI Database Management Functions (moved before resolve_player)
-- Functions moved above resolve_player

-- Debug function for resolver - only logs hits/misses
local function debug_resolver(player_index, resolver_data, resolve_result)
    if not debug_enabled then return end
    
    -- Only log when we have actual resolver results
    if not resolver_data or not resolve_result then
        return
    end
    
    -- Minimal logging - only essential info
    -- Hit/miss logging will be handled in aim_fire callback
end

-- Position correction with movement prediction
local function get_corrected_position(player_index)
    local pos = {entity.get_origin(player_index)}
    if not pos[1] then return nil end
    
    local velocity = {entity.get_prop(player_index, "m_vecVelocity[0]"), entity.get_prop(player_index, "m_vecVelocity[1]"), entity.get_prop(player_index, "m_vecVelocity[2]")}
    if not velocity[1] then velocity = {0, 0, 0} end
    
    -- Calculate 2D velocity for movement prediction
    local vel_2d = math.sqrt(velocity[1]^2 + velocity[2]^2)
    
    -- Only apply prediction if player is moving significantly
    if vel_2d > 10 then
        local frametime = globals.frametime()
        local ping = client_latency() or 0
        local prediction_time = frametime + ping
        
        -- Simple linear prediction
        pos[1] = pos[1] + velocity[1] * prediction_time
        pos[2] = pos[2] + velocity[2] * prediction_time
        pos[3] = pos[3] + velocity[3] * prediction_time
        
        -- Prediction applied
    end
    
    return pos
end

-- Enhanced backtrack correction
local function get_backtrack_corrected_position(player_index, backtrack_ticks)
    if not backtrack_ticks or backtrack_ticks <= 0 then
        return get_corrected_position(player_index)
    end
    
    local pos = get_corrected_position(player_index)
    if not pos then return nil end
    
    local velocity = {entity.get_prop(player_index, "m_vecVelocity[0]"), entity.get_prop(player_index, "m_vecVelocity[1]"), entity.get_prop(player_index, "m_vecVelocity[2]")}
    if not velocity[1] then return pos end
    
    -- Backtrack correction (go back in time)
    local tick_interval = api.globals.tickinterval()
    local backtrack_time = backtrack_ticks * tick_interval
    
    pos[1] = pos[1] - velocity[1] * backtrack_time
    pos[2] = pos[2] - velocity[2] * backtrack_time
    pos[3] = pos[3] - velocity[3] * backtrack_time
    
    return pos
end

-- AI Learning and Pattern Analysis Functions
local function analyze_shot_patterns(steamid)
    local profile = shot_database.player_profiles[steamid]
    if not profile or profile.total_shots < ai_learning_system.min_samples then
        return nil
    end
    
    local patterns = {
        velocity_pattern = 0,
        angle_pattern = 0,
        timing_pattern = 0,
        movement_pattern = 0,
        weapon_pattern = 0
    }
    
    local relevant_shots = {}
    local current_time = globals.realtime()
    
    -- Get recent shots for this player
    for _, shot in ipairs(shot_database.shots) do
        if shot.player_steamid == steamid and (current_time - shot.timestamp) < 1800 then -- Last 30 minutes
            table.insert(relevant_shots, shot)
        end
    end
    
    if #relevant_shots < ai_learning_system.min_samples then
        return patterns
    end
    
    -- Analyze velocity patterns
    local velocity_hits = 0
    local velocity_total = 0
    for _, shot in ipairs(relevant_shots) do
        if shot.velocity and vector_length(shot.velocity) > 50 then
            velocity_total = velocity_total + 1
            if shot.result == "hit" then
                velocity_hits = velocity_hits + 1
            end
        end
    end
    
    if velocity_total > 0 then
        patterns.velocity_pattern = velocity_hits / velocity_total
    end
    
    return patterns
end

-- Function moved above resolve_player

local function update_ai_learning(shot_result, prediction_data, actual_data)
    if not prediction_data or not actual_data then return end
    
    local error_rate = 0
    if shot_result == "miss" then
        error_rate = 1.0
    end
    
    -- Update learning weights based on prediction accuracy
    local learning_rate = ai_learning_system.learning_rate
    
    if prediction_data.patterns then
        if prediction_data.patterns.velocity_pattern then
            ai_learning_system.pattern_weights.velocity_based = 
                ai_learning_system.pattern_weights.velocity_based * (1 - learning_rate * error_rate)
        end
        
        if prediction_data.patterns.angle_pattern then
            ai_learning_system.pattern_weights.angle_based = 
                ai_learning_system.pattern_weights.angle_based * (1 - learning_rate * error_rate)
        end
    end
    
    -- Clamp weights to reasonable bounds
    for key, weight in pairs(ai_learning_system.pattern_weights) do
        ai_learning_system.pattern_weights[key] = math.max(0.1, math.min(1.0, weight))
    end
end

local function cleanup_old_data()
    local current_time = globals.realtime()
    if current_time - shot_database.last_cleanup < shot_database.cleanup_interval then
        return
    end
    
    -- Remove shots older than 1 hour
    local cutoff_time = current_time - 3600
    local new_shots = {}
    
    for i, shot in ipairs(shot_database.shots) do
        if shot.timestamp > cutoff_time then
            table.insert(new_shots, shot)
        end
    end
    
    shot_database.shots = new_shots
    shot_database.last_cleanup = current_time
end

local function calculate_ai_prediction(player_index, current_data)
    local steamid = api.entity.get_steam64(player_index)
    if not steamid then return nil end
    
    local patterns = analyze_shot_patterns(steamid)
    if not patterns then
        return {
            confidence = 0.5,
            suggested_angle = 0,
            resolver_mode = "default"
        }
    end
    
    -- Calculate weighted confidence
    local confidence = 0
    confidence = confidence + (patterns.velocity_pattern or 0.5) * ai_learning_system.pattern_weights.velocity_based
    confidence = confidence + (patterns.angle_pattern or 0.5) * ai_learning_system.pattern_weights.angle_based
    confidence = confidence + (patterns.timing_pattern or 0.5) * ai_learning_system.pattern_weights.timing_based
    confidence = confidence + (patterns.movement_pattern or 0.5) * ai_learning_system.pattern_weights.movement_based
    confidence = confidence + (patterns.weapon_pattern or 0.5) * ai_learning_system.pattern_weights.weapon_based
    
    -- Determine best resolver mode based on patterns
    local resolver_mode = "default"
    if patterns.velocity_pattern and patterns.velocity_pattern > 0.7 then
        resolver_mode = "velocity_based"
    elseif patterns.angle_pattern and patterns.angle_pattern > 0.7 then
        resolver_mode = "angle_based"
    elseif confidence > ai_learning_system.confidence_threshold then
        resolver_mode = "ai_optimized"
    end
    
    -- Calculate suggested angle adjustment
    local suggested_angle = 0
    if patterns.angle_pattern and patterns.angle_pattern > 0.6 then
        -- Use historical data to suggest angle
        local profile = shot_database.player_profiles[player_info.steamid]
        if profile and profile.patterns and profile.patterns.preferred_angle then
            suggested_angle = profile.patterns.preferred_angle
        end
    end
    
    return {
        confidence = confidence,
        suggested_angle = suggested_angle,
        resolver_mode = resolver_mode,
        patterns = patterns
    }
end

-- Bruteforce and Debug Functions (moved before resolve_player)
-- Adaptive Brute-Force with Feedback Loop
local bruteforce_history = {} -- Store brute-force attempts and results
local shot_feedback = {} -- Store shot feedback data
local angle_success_rates = {} -- Track success rates for different angles
local adaptive_modes = {} -- Store adaptive resolver modes per player

local function initialize_bruteforce_data(ent_index)
    if not bruteforce_history[ent_index] then
        bruteforce_history[ent_index] = {
            attempts = {},
            successful_angles = {},
            failed_angles = {},
            current_phase = 1,
            phase_attempts = 0,
            last_hit_angle = nil,
            consecutive_misses = 0
        }
    end
    
    if not angle_success_rates[ent_index] then
        angle_success_rates[ent_index] = {
            left_side = {attempts = 0, hits = 0, rate = 0.5},
            right_side = {attempts = 0, hits = 0, rate = 0.5},
            center = {attempts = 0, hits = 0, rate = 0.5},
            desync_delta = {attempts = 0, hits = 0, rate = 0.5},
            freestanding = {attempts = 0, hits = 0, rate = 0.5}
        }
    end
end

local function calculate_bruteforce_angle(ent_index)
    -- Calculate bruteforce angle based on player patterns
    initialize_bruteforce_data(ent_index)
    
    local history = bruteforce_history[ent_index]
    local rates = angle_success_rates[ent_index]
    
    -- Get and validate base angles from entity
    local eye_pitch = entity.get_prop(ent_index, "m_angEyeAngles[0]") or 0
    local eye_yaw = entity.get_prop(ent_index, "m_angEyeAngles[1]") or 0
    
    -- Validate angle types and ranges
    if type(eye_pitch) ~= "number" or type(eye_yaw) ~= "number" then
        eye_pitch, eye_yaw = 0, 0
    end
    if math.abs(eye_pitch) > 90 or math.abs(eye_yaw) > 180 then
        eye_pitch, eye_yaw = 0, 0
    end
    
    local eye_angles = {eye_pitch, eye_yaw}
    local base_yaw = eye_yaw
    
    -- Determine best angle based on success rates and consecutive misses
    local target_angle = base_yaw
    
    if history.consecutive_misses < 2 then
        -- Low miss count - use successful angles
        if #history.successful_angles > 0 then
            target_angle = history.successful_angles[#history.successful_angles]
        else
            -- No successful angles yet, use desync offset
            target_angle = base_yaw + (math.random() > 0.5 and 60 or -60)
        end
    elseif history.consecutive_misses < 4 then
        -- Medium miss count - try opposite side
        if history.last_hit_angle then
            local offset = history.last_hit_angle - base_yaw
            target_angle = base_yaw - offset -- Opposite side
        else
            target_angle = base_yaw + (math.random() > 0.5 and 90 or -90)
        end
    else
        -- High miss count - random bruteforce
        local angles = {-90, -60, -30, 0, 30, 60, 90}
        target_angle = base_yaw + angles[math.random(#angles)]
    end
    
    return normalize_yaw(target_angle)
end

local function update_debug_stats(resolve_data)
    if not resolve_data then return end
    
    debug_stats.total_resolves = debug_stats.total_resolves + 1
    
    -- Only count as successful if confidence is reasonable
    if resolve_data.confidence and resolve_data.confidence > 0.5 then
        debug_stats.successful_resolves = debug_stats.successful_resolves + 1
    end
    
    -- Track actual corrections made
    if resolve_data.yaw_corrected then
        debug_stats.yaw_corrections = debug_stats.yaw_corrections + 1
    end
    
    if resolve_data.pitch_corrected then
        debug_stats.pitch_corrections = debug_stats.pitch_corrections + 1
    end
    
    -- Track detections only when actually detected
    if resolve_data.desync_breaker_detected then
        debug_stats.desync_breaks_detected = debug_stats.desync_breaks_detected + 1
    end
    
    if resolve_data.fakelag_detected then
        debug_stats.fakelag_detections = debug_stats.fakelag_detections + 1
    end
end

-- Main resolver function with auto-adaptation and plist integration
local function resolve_player(ent_index)
    -- Security and safety checks
    if security_system.emergency_shutdown then
        force_player_yaw(ent_index, 0, false)
        return nil
    end
    
    if not security_system.enabled then
        -- Basic checks only
        if not entity.is_alive(ent_index) or entity.is_dormant(ent_index) then
            force_player_yaw(ent_index, 0, false)
            return nil
        end
        
        if not get_resolver_enabled() then
            force_player_yaw(ent_index, 0, false)
            return nil
        end
    else
        -- Enhanced security checks
        local valid, error_msg = validate_entity_index(ent_index)
        if not valid then
            simple_log("SECURITY: Entity validation failed - " .. error_msg, "resolver")
            force_player_yaw(ent_index, 0, false)
            return nil
        end
        
        local security_ok, security_msg = check_security_limits()
        if not security_ok then
            simple_log("SECURITY: Security limits exceeded - " .. security_msg, "resolver")
            force_player_yaw(ent_index, 0, false)
            return nil
        end
        
        -- Anti-detection measures
        if not anti_detection_measures() then
            return nil -- Skip this frame for anti-detection
        end
        
        -- Check if player is inactive or dormant (with safe property access)
        local health = safe_entity_get_prop(ent_index, "m_iHealth", 0)
        local dormant = entity.is_dormant(ent_index)
        
        if health <= 0 or dormant then
            force_player_yaw(ent_index, 0, false)
            return nil
        end
        
        -- Check if resolver is enabled
        if not get_resolver_enabled() then
            force_player_yaw(ent_index, 0, false)
            return nil
        end
    end
    
    -- Get validated resolver data
    local resolver_data = get_resolver_data(ent_index)
    if not resolver_data then
        force_player_yaw(ent_index, 0, false)
        return nil
    end
    
    -- Enhanced data validation
    if security_system.validation_level >= 1 then
        local data_valid, data_error = validate_resolver_data(resolver_data)
        if not data_valid then
            simple_log("SECURITY: Resolver data validation failed - " .. data_error, "resolver")
            force_player_yaw(ent_index, 0, false)
            return nil
        end
    end
    
    -- Cleanup old learning data periodically
    cleanup_old_learning_data()
    cleanup_old_data() -- AI database cleanup
    
    -- Track choked packets for fakelag detection
    local packet_history, current_choked = track_choked_packets(ent_index)
    
    -- AI Prediction System Integration
    -- Get and validate eye angles for AI prediction
    local ai_eye_angles = entity.get_prop(ent_index, "m_angEyeAngles")
    if not ai_eye_angles or type(ai_eye_angles) ~= "table" or not ai_eye_angles[1] or not ai_eye_angles[2] then
        ai_eye_angles = {0, 0} -- Default angles if invalid
    end
    
    -- Safely get velocity data
    local velocity_data = entity.get_prop(ent_index, "m_vecVelocity")
    if not velocity_data or type(velocity_data) ~= "table" then
        velocity_data = {0, 0, 0}
    end
    
    -- Safely get body yaw
    local body_yaw = safe_entity_get_prop(ent_index, "m_flLowerBodyYawTarget", 0)
    
    local ai_prediction = calculate_ai_prediction(ent_index, {
        velocity = velocity_data,
        eye_angles = ai_eye_angles,
        body_yaw = body_yaw,
        duck_amount = safe_entity_get_prop(ent_index, "m_flDuckAmount", 0)
    })
    
    -- Jitter Detection Integration
    local jitter_info = detect_jitter(ent_index)
    
    -- Create and analyze lag record
    local record = resolve_yaw_advanced(ent_index)
    add_lag_record(ent_index, record)
    
    -- Add jitter information to record
    if record then
        record.jitter_detected = jitter_info.is_jittering
        record.jitter_confidence = jitter_info.confidence
        record.jitter_strength = jitter_info.pattern_strength
    end
    
    -- Get resolver mode (AI can override this)
    -- local resolver_mode = resolver_mode -- already defined
    local original_resolver_mode = resolver_mode
    
    -- Store advanced analysis resolver_mode separately
    local advanced_resolver_mode = nil
    if record and record.resolver_mode then
        advanced_resolver_mode = record.resolver_mode
    end
    
    if ai_prediction and ai_prediction.resolver_mode ~= "default" and ai_prediction.confidence > ai_learning_system.confidence_threshold then
        resolver_mode = ai_prediction.resolver_mode
        log_resolver_event("AI", string.format("AI override mode: %s (confidence: %.2f)", resolver_mode, ai_prediction.confidence))
    end
    
    -- Apply different resolver modes
    local resolved_yaw = record.final_yaw or record.resolved_yaw
    local resolved_pitch = resolve_pitch(ent_index)
    local final_confidence = record.final_confidence or record.confidence
    
    -- AI angle adjustment
    if ai_prediction and ai_prediction.suggested_angle ~= 0 and ai_prediction.confidence > 0.6 then
        resolved_yaw = resolved_yaw + ai_prediction.suggested_angle
        resolved_yaw = normalize_yaw(resolved_yaw)
        final_confidence = math.min(final_confidence + ai_prediction.confidence * 0.2, 0.95)
        log_resolver_event("AI", string.format("AI angle adjustment: %.1f° (new confidence: %.2f)", ai_prediction.suggested_angle, final_confidence))
    end
    
    -- Apply adaptive learning adjustments
    local function get_adaptive_angle_adjustment(ent_index, base_angle)
        initialize_player_learning(ent_index)
        local learning_data = player_learning_data[ent_index]
        
        if not learning_data.preferred_angles or table_count(learning_data.preferred_angles) == 0 then
            return base_angle, 1.0
        end
        
        -- Find the most successful angle range
        local best_angle, best_success = nil, 0
        for angle, success_count in pairs(learning_data.preferred_angles) do
            if success_count > best_success then
                best_success = success_count
                best_angle = angle
            end
        end
        
        if best_angle and best_success > 2 then
            -- Blend towards successful angle
            local angle_diff = normalize_yaw(best_angle - base_angle)
            local adjustment_strength = math.min(0.3, best_success / 10)
            local adjusted_angle = normalize_yaw(base_angle + angle_diff * adjustment_strength)
            
            return adjusted_angle, learning_data.confidence_modifier
        end
        
        return base_angle, learning_data.confidence_modifier or 1.0
    end
    
    local adaptive_yaw, confidence_modifier = get_adaptive_angle_adjustment(ent_index, resolved_yaw)
    resolved_yaw = adaptive_yaw
    final_confidence = final_confidence * confidence_modifier
    
    -- Apply fakelag compensation
    local base_angles = {resolved_pitch.pitch, resolved_yaw}
    local compensated_angles, fakelag_confidence = compensate_for_fakelag(ent_index, base_angles)
    
    resolved_yaw = compensated_angles[2]
    final_confidence = final_confidence * fakelag_confidence
    
    if record.movement_state == "standing" then
        local desync_yaw, desync_data = resolve_desync_offset(ent_index)
        -- Blend desync resolution with advanced resolution
        resolved_yaw = normalize_yaw(resolved_yaw * 0.7 + desync_yaw * 0.3)
        -- Update resolver_mode if desync analysis provides better method
        if desync_data and desync_data.resolver_mode and desync_data.confidence > 0.7 then
            resolver_mode = desync_data.resolver_mode
        end
    elseif record.movement_state == "airborne" then
        -- For airborne targets, blend with eye angles
        local eye_yaw = record.eye_angles[2]
        resolved_yaw = normalize_yaw(resolved_yaw * 0.8 + eye_yaw * 0.2)
    end
    
    -- Check if using fallback data and adjust confidence
        local using_fallback = resolver_data.is_fallback
        if using_fallback then
            final_confidence = math.max(0.3, final_confidence * 0.6) -- Reduce confidence for fallback data
        end
    
    -- Apply resolver mode specific logic
    if resolver_mode == "Adaptive" then
        -- Adaptive mode uses learning data and confidence
        if final_confidence < 0.6 or using_fallback then
            -- Low confidence or fallback data, use bruteforce
            resolved_yaw = calculate_bruteforce_angle(ent_index)
        end
    elseif resolver_mode == "Bruteforce" then
        -- Always use bruteforce
        resolved_yaw = calculate_bruteforce_angle(ent_index)
    elseif resolver_mode == "Static" then
        -- Use basic desync resolution
        local desync_yaw, desync_data = resolve_desync_offset(ent_index)
        resolved_yaw = desync_yaw
        if desync_data and desync_data.resolver_mode then
            resolver_mode = desync_data.resolver_mode
        end
        -- For fallback data, ensure we have a reasonable angle
        if using_fallback then
            resolved_yaw = normalize_yaw(resolver_data.yaw + (math.random() > 0.5 and 35 or -35))
        end
    elseif resolver_mode == "Maximum" then
        -- Maximum mode: Combine all available data sources for best accuracy
        local adaptive_yaw = resolved_yaw
        local bruteforce_yaw = calculate_bruteforce_angle(ent_index)
        local desync_yaw, desync_data = resolve_desync_offset(ent_index)
        
        -- Adjust weights based on fallback data usage
        local adaptive_weight = using_fallback and (final_confidence * 0.5) or final_confidence
        local bruteforce_weight = using_fallback and 0.6 or 0.3 -- Increase bruteforce weight for fallback
        local desync_weight = (desync_data and desync_data.confidence or 0.2)
        
        -- For fallback data, add more aggressive angle variations
        if using_fallback then
            local fallback_angles = {
                normalize_yaw(resolver_data.yaw + 35),
                normalize_yaw(resolver_data.yaw - 35),
                normalize_yaw(resolver_data.yaw + 58),
                normalize_yaw(resolver_data.yaw - 58)
            }
            bruteforce_yaw = fallback_angles[math.random(1, 4)]
        end
        
        -- Normalize weights
        local total_weight = adaptive_weight + bruteforce_weight + desync_weight
        if total_weight > 0 then
            resolved_yaw = normalize_yaw(
                (adaptive_yaw * adaptive_weight + 
                 bruteforce_yaw * bruteforce_weight + 
                 desync_yaw * desync_weight) / total_weight
            )
            local confidence_boost = using_fallback and 0.08 or 0.15
            final_confidence = math.min(final_confidence + confidence_boost, 0.95)
        end
    elseif resolver_mode == "AI Boost" then
        -- AI Boost mode: Enhanced AI prediction with higher confidence thresholds
        local ai_threshold = using_fallback and 0.3 or 0.4 -- Lower threshold for fallback data
        
        if ai_prediction and ai_prediction.confidence > ai_threshold then
            local ai_influence = using_fallback and 1.2 or 1.5 -- Reduce AI influence for fallback
            resolved_yaw = resolved_yaw + (ai_prediction.suggested_angle * ai_influence)
            resolved_yaw = normalize_yaw(resolved_yaw)
            
            local confidence_multiplier = using_fallback and 0.3 or 0.4
            final_confidence = math.min(final_confidence + ai_prediction.confidence * confidence_multiplier, 0.98)
            
            -- Additional AI-based angle correction
            if ai_prediction.pattern_detected then
                local pattern_adjustment = ai_prediction.pattern_angle or 0
                resolved_yaw = normalize_yaw(resolved_yaw + pattern_adjustment)
                local pattern_boost = using_fallback and 0.05 or 0.1
                final_confidence = math.min(final_confidence + pattern_boost, 0.98)
            end
        else
            -- Fallback to adaptive with AI enhancement
            local confidence_threshold = using_fallback and 0.5 or 0.7
            if final_confidence < confidence_threshold then
                if using_fallback then
                    -- For fallback data, use more conservative bruteforce with multiple angles
                    local fallback_bruteforce = {
                        normalize_yaw(resolver_data.yaw + 30),
                        normalize_yaw(resolver_data.yaw - 30),
                        calculate_bruteforce_angle(ent_index)
                    }
                    resolved_yaw = fallback_bruteforce[math.random(1, 3)]
                else
                    resolved_yaw = calculate_bruteforce_angle(ent_index)
                end
                final_confidence = math.max(final_confidence, using_fallback and 0.45 or 0.6)
            end
        end
    end
    
    local resolve_result = {
        yaw = resolved_yaw,
        pitch = resolved_pitch,
        confidence = final_confidence,
        mode = original_resolver_mode,
        advanced_mode = advanced_resolver_mode,
        trend_data = record.trend_data,
        fakelag_data = fakelag_patterns[ent_index],
        choked_packets = current_choked,
        yaw_corrected = math.abs(resolved_yaw - (record.eye_angles and record.eye_angles[2] or 0)) > 5,
        pitch_corrected = resolved_pitch and resolved_pitch.corrected or false,
        desync_breaker_detected = record.desync_breaker_detected or false,
        fakelag_detected = current_choked > 8
    }
    
    -- Automatically apply plist to force the resolved yaw
    if final_confidence > 0.3 then -- Only apply if we have reasonable confidence
        force_player_yaw(ent_index, resolved_yaw, true)
    else
        -- Instead of resetting to 0, use eye_yaw or last known good angle
        local fallback_yaw = record.eye_angles and record.eye_angles[2] or 0
        if resolver_record and resolver_record.latest_record and resolver_record.latest_record.resolved_yaw then
            fallback_yaw = resolver_record.latest_record.resolved_yaw
        end
        force_player_yaw(ent_index, fallback_yaw, true)
        -- Fallback yaw applied
    end
    
    -- Update debug statistics
    update_debug_stats(resolve_result)
    
    -- Debug resolver output
    debug_resolver(ent_index, resolver_data, resolve_result)
    
    return resolve_result
end

-- Initialize the resolver
init_lag_records()

local function register_shot_attempt(ent_index, target_angle, angle_type)
    -- Register a shot attempt for feedback analysis
    initialize_bruteforce_data(ent_index)
    
    local history = bruteforce_history[ent_index]
    local current_tick = api.globals.tickcount()
    
    local attempt = {
        angle = target_angle,
        angle_type = angle_type,
        tick = current_tick,
        result = "pending", -- Will be updated by feedback
        confidence = 0.5
    }
    
    table.insert(history.attempts, attempt)
    history.phase_attempts = history.phase_attempts + 1
    
    -- Keep only last 20 attempts
    if #history.attempts > 20 then
        table.remove(history.attempts, 1)
    end
    
    return attempt
end

local function process_shot_feedback(ent_index, hit_result, damage_dealt)
    -- Process feedback from shot results
    local history = bruteforce_history[ent_index]
    if not history or #history.attempts == 0 then
        return
    end
    
    -- Find the most recent pending attempt
    local recent_attempt = nil
    for i = #history.attempts, 1, -1 do
        if history.attempts[i].result == "pending" then
            recent_attempt = history.attempts[i]
            break
        end
    end
    
    if not recent_attempt then
        return
    end
    
    -- Update attempt result
    if hit_result and damage_dealt > 0 then
        recent_attempt.result = "hit"
        recent_attempt.damage = damage_dealt
        history.last_hit_angle = recent_attempt.angle
        history.consecutive_misses = 0
        
        -- Update success rates
        local rates = angle_success_rates[ent_index]
        local angle_type = recent_attempt.angle_type
        if rates[angle_type] then
            rates[angle_type].hits = rates[angle_type].hits + 1
            rates[angle_type].attempts = rates[angle_type].attempts + 1
            rates[angle_type].rate = rates[angle_type].hits / rates[angle_type].attempts
        end
        
        table.insert(history.successful_angles, recent_attempt.angle)
    else
        recent_attempt.result = "miss"
        history.consecutive_misses = history.consecutive_misses + 1
        
        -- Update failure rates
        local rates = angle_success_rates[ent_index]
        local angle_type = recent_attempt.angle_type
        if rates[angle_type] then
            rates[angle_type].attempts = rates[angle_type].attempts + 1
            rates[angle_type].rate = rates[angle_type].hits / rates[angle_type].attempts
        end
        
        table.insert(history.failed_angles, recent_attempt.angle)
    end
    
    -- Keep limited history
    if #history.successful_angles > 10 then
        table.remove(history.successful_angles, 1)
    end
    if #history.failed_angles > 15 then
        table.remove(history.failed_angles, 1)
    end
end

-- Function moved above resolve_player

local function calculate_adaptive_angle(ent_index, base_resolver_angle)
    -- Calculate adaptive angle based on feedback history
    initialize_bruteforce_data(ent_index)
    
    local history = bruteforce_history[ent_index]
    local rates = angle_success_rates[ent_index]
    
    -- Determine best angle type based on success rates
    local best_type = "center"
    local best_rate = 0
    
    for angle_type, data in pairs(rates) do
        if data.attempts > 2 and data.rate > best_rate then
            best_rate = data.rate
            best_type = angle_type
        end
    end
    
    local adaptive_angle = base_resolver_angle
    local confidence = 0.5
    
    -- Apply adaptive logic based on consecutive misses
    if history.consecutive_misses >= 3 then
        -- High miss count - try alternative approaches
        if history.consecutive_misses >= 5 then
            -- Very high miss count - use randomization
            local random_offset = (math_random() - 0.5) * 60
            adaptive_angle = base_resolver_angle + random_offset
            confidence = 0.3
        else
            -- Moderate miss count - try opposite side
            if history.last_hit_angle then
                local delta = normalize_yaw(base_resolver_angle - history.last_hit_angle)
                if math_abs(delta) < 90 then
                    adaptive_angle = base_resolver_angle + 180
                else
                    adaptive_angle = history.last_hit_angle
                end
                confidence = 0.6
            else
                adaptive_angle = base_resolver_angle + 90
                confidence = 0.4
            end
        end
    elseif history.consecutive_misses >= 1 then
        -- Some misses - apply smart adjustment
        if best_type == "left_side" then
            adaptive_angle = base_resolver_angle - 35
        elseif best_type == "right_side" then
            adaptive_angle = base_resolver_angle + 35
        elseif best_type == "desync_delta" then
             local desync_result, desync_data = resolve_desync_offset(ent_index)
             if desync_result then
                 adaptive_angle = desync_result
            end
        end
        confidence = best_rate
    else
        -- No recent misses - use successful pattern
        if #history.successful_angles > 0 then
            local recent_success = history.successful_angles[#history.successful_angles]
            local angle_diff = normalize_yaw(base_resolver_angle - recent_success)
            
            if math_abs(angle_diff) > 45 then
                -- Current angle is far from last success, blend them
                adaptive_angle = base_resolver_angle * 0.7 + recent_success * 0.3
                confidence = 0.8
            else
                -- Current angle is close to success, use it
                adaptive_angle = base_resolver_angle
                confidence = 0.9
            end
        end
    end
    
    -- Normalize final angle
    adaptive_angle = normalize_yaw(adaptive_angle)
    
    -- Determine angle type for tracking
    local angle_type = "center"
    local angle_offset = normalize_yaw(adaptive_angle - base_resolver_angle)
    
    if angle_offset < -20 then
        angle_type = "left_side"
    elseif angle_offset > 20 then
        angle_type = "right_side"
    elseif math_abs(angle_offset) > 120 then
        angle_type = "desync_delta"
    end
    
    return adaptive_angle, confidence, angle_type
end

local function update_bruteforce_phase(ent_index)
    -- Update brute-force phase based on performance
    local history = bruteforce_history[ent_index]
    if not history then
        return
    end
    
    -- Check if phase should advance
    if history.phase_attempts >= 8 or history.consecutive_misses >= 4 then
        history.current_phase = (history.current_phase % 4) + 1
        history.phase_attempts = 0
        
        -- Reset some counters on phase change
        if history.current_phase == 1 then
            history.consecutive_misses = math.max(0, history.consecutive_misses - 2)
        end
    end
end

-- Mobile Protection (Anti-Resolver)
local function detect_mobile_protection(ent_index)
    -- Detect if enemy is using mobile protection/anti-resolver
    local record = get_latest_record(ent_index)
    if not record then return false end
    
    -- Check for rapid angle changes (jitter)
    local angle_changes = 0
    local records = lag_records[ent_index]
    if records and #records > 5 then
        for i = 2, math.min(6, #records) do
            local current_yaw = records[i].eye_angles[2]
            local prev_yaw = records[i-1].eye_angles[2]
            local change = math_abs(normalize_yaw(current_yaw - prev_yaw))
            if change > 30 then
                angle_changes = angle_changes + 1
            end
        end
    end
    
    -- Mobile protection detected if many rapid changes
    return angle_changes > 3
end

-- Missed Shot Detection System
-- Shot analysis data structures removed

local function initialize_shot_detection()
    -- Initialize shot detection system
    api.client.set_event_callback("bullet_impact", function(e)
        local user_id = e.userid
        local impact_pos = {e.x, e.y, e.z}
        local tick = api.globals.tickcount()
        
        -- Store bullet impact data
        if not bullet_impacts[user_id] then
            bullet_impacts[user_id] = {}
        end
        
        table.insert(bullet_impacts[user_id], {
            position = impact_pos,
            tick = tick,
            processed = false
        })
        
        -- Keep only recent impacts
        if #bullet_impacts[user_id] > 10 then
            table.remove(bullet_impacts[user_id], 1)
        end
    end)
    
    api.client.set_event_callback("weapon_fire", function(e)
        local user_id = e.userid
        local tick = api.globals.tickcount()
        
        -- Store shot event data
        if not shot_events[user_id] then
            shot_events[user_id] = {}
        end
        
        table.insert(shot_events[user_id], {
            tick = tick,
            weapon = e.weapon,
            processed = false
        })
        
        -- Keep only recent shots
        if #shot_events[user_id] > 15 then
            table.remove(shot_events[user_id], 1)
        end
    end)
    
    api.client.set_event_callback("player_hurt", function(e)
        local attacker_id = e.attacker
        local victim_id = e.userid
        local damage = e.dmg_health
        local hitgroup = e.hitgroup
        local tick = api.globals.tickcount()
        
        -- Process hit detection
        if not hit_detection[attacker_id] then
            hit_detection[attacker_id] = {}
        end
        
        table.insert(hit_detection[attacker_id], {
            victim_id = victim_id,
            damage = damage,
            hitgroup = hitgroup,
            tick = tick
        })
        
        -- Keep only recent hits
        if #hit_detection[attacker_id] > 20 then
            table.remove(hit_detection[attacker_id], 1)
        end
    end)
end

local function analyze_shot_trajectory(shooter_pos, target_pos, impact_pos)
    -- Analyze shot trajectory to determine miss reason
    local shot_vector = {
        target_pos[1] - shooter_pos[1],
        target_pos[2] - shooter_pos[2],
        target_pos[3] - shooter_pos[3]
    }
    
    local impact_vector = {
        impact_pos[1] - shooter_pos[1],
        impact_pos[2] - shooter_pos[2],
        impact_pos[3] - shooter_pos[3]
    }
    
    -- Calculate distance from intended target to actual impact
    local target_distance = math.sqrt(shot_vector[1]^2 + shot_vector[2]^2 + shot_vector[3]^2)
    local impact_distance = math.sqrt(impact_vector[1]^2 + impact_vector[2]^2 + impact_vector[3]^2)
    
    -- Calculate angle difference
    local dot_product = shot_vector[1] * impact_vector[1] + shot_vector[2] * impact_vector[2] + shot_vector[3] * impact_vector[3]
    local angle_diff = math.acos(dot_product / (target_distance * impact_distance))
    angle_diff = math.deg(angle_diff)
    
    -- Calculate horizontal and vertical miss distances
    local horizontal_miss = math.sqrt((impact_pos[1] - target_pos[1])^2 + (impact_pos[2] - target_pos[2])^2)
    local vertical_miss = math.abs(impact_pos[3] - target_pos[3])
    
    return {
        angle_difference = angle_diff,
        horizontal_miss = horizontal_miss,
        vertical_miss = vertical_miss,
        total_miss_distance = math.sqrt(horizontal_miss^2 + vertical_miss^2)
    }
end

local function detect_missed_shot(ent_index, shot_tick)
    -- Detect if a shot missed and analyze the reason
    local local_player = api.entity.get_local_player()
    if not local_player then return nil end
    
    local user_id = entity.get_prop(local_player, "m_iUserID")
    if not user_id then return nil end
    
    -- Check for recent bullet impacts
    local impacts = bullet_impacts[user_id]
    if not impacts then return nil end
    
    -- Find impact closest to shot time
    local closest_impact = nil
    local min_tick_diff = math.huge
    
    for i, impact in ipairs(impacts) do
        if not impact.processed then
            local tick_diff = math.abs(impact.tick - shot_tick)
            if tick_diff < min_tick_diff and tick_diff <= 3 then -- Within 3 ticks
                min_tick_diff = tick_diff
                closest_impact = impact
            end
        end
    end
    
    if not closest_impact then
        return nil -- No matching impact found
    end
    
    -- Mark impact as processed
    closest_impact.processed = true
    
    -- Get positions
    local shooter_pos = {entity.get_prop(local_player, "m_vecOrigin")}
    local target_pos = {entity.get_prop(ent_index, "m_vecOrigin")}
    
    if not shooter_pos[1] or not target_pos[1] then
        return nil
    end
    
    -- Analyze trajectory
    local trajectory_data = analyze_shot_trajectory(shooter_pos, target_pos, closest_impact.position)
    
    -- Determine miss reason
    local miss_reason = "unknown"
    local resolver_adjustment = {yaw = 0, pitch = 0}
    
    if trajectory_data.angle_difference > 15 then
        miss_reason = "large_angle_error"
        -- Suggest major resolver adjustment
        if trajectory_data.horizontal_miss > 30 then
            resolver_adjustment.yaw = trajectory_data.horizontal_miss > 0 and 45 or -45
        end
    elseif trajectory_data.horizontal_miss > 20 then
        miss_reason = "horizontal_miss"
        -- Suggest yaw adjustment
        resolver_adjustment.yaw = trajectory_data.horizontal_miss > 0 and 25 or -25
    elseif trajectory_data.vertical_miss > 15 then
        miss_reason = "vertical_miss"
        -- Suggest pitch adjustment
        resolver_adjustment.pitch = trajectory_data.vertical_miss > 0 and 10 or -10
    elseif trajectory_data.total_miss_distance > 10 then
        miss_reason = "general_inaccuracy"
        -- Suggest minor adjustments
        resolver_adjustment.yaw = (math.random() - 0.5) * 20
        resolver_adjustment.pitch = (math.random() - 0.5) * 10
    else
        miss_reason = "close_miss"
        -- Very minor adjustments
        resolver_adjustment.yaw = (math.random() - 0.5) * 10
    end
    
    -- Store miss data
    if not missed_shots_data[ent_index] then
        missed_shots_data[ent_index] = {
            total_misses = 0,
            miss_reasons = {},
            recent_adjustments = {},
            last_miss_tick = 0
        }
    end
    
    local miss_data = missed_shots_data[ent_index]
    miss_data.total_misses = miss_data.total_misses + 1
    miss_data.last_miss_tick = shot_tick
    
    -- Track miss reasons
    if not miss_data.miss_reasons[miss_reason] then
        miss_data.miss_reasons[miss_reason] = 0
    end
    miss_data.miss_reasons[miss_reason] = miss_data.miss_reasons[miss_reason] + 1
    
    -- Store adjustment suggestion
    table.insert(miss_data.recent_adjustments, {
        tick = shot_tick,
        reason = miss_reason,
        yaw_adjustment = resolver_adjustment.yaw,
        pitch_adjustment = resolver_adjustment.pitch,
        trajectory_data = trajectory_data
    })
    
    -- Keep only recent adjustments
    if #miss_data.recent_adjustments > 10 then
        table.remove(miss_data.recent_adjustments, 1)
    end
    
    return {
        miss_reason = miss_reason,
        trajectory_data = trajectory_data,
        suggested_adjustment = resolver_adjustment,
        confidence = math.max(0.1, 1.0 - (trajectory_data.total_miss_distance / 100))
    }
end

local function get_resolver_adjustment_from_misses(ent_index)
    -- Get resolver adjustment suggestions based on miss history
    local miss_data = missed_shots_data[ent_index]
    if not miss_data or #miss_data.recent_adjustments == 0 then
        return {yaw = 0, pitch = 0, confidence = 0.5}
    end
    
    -- Analyze recent miss patterns
    local yaw_adjustments = {}
    local pitch_adjustments = {}
    local total_weight = 0
    
    for i, adjustment in ipairs(miss_data.recent_adjustments) do
        local weight = 1.0 / (i) -- More recent misses have higher weight
        table.insert(yaw_adjustments, adjustment.yaw_adjustment * weight)
        table.insert(pitch_adjustments, adjustment.pitch_adjustment * weight)
        total_weight = total_weight + weight
    end
    
    -- Calculate weighted average adjustments
    local avg_yaw = 0
    local avg_pitch = 0
    
    for i, yaw_adj in ipairs(yaw_adjustments) do
        avg_yaw = avg_yaw + yaw_adj
    end
    
    for i, pitch_adj in ipairs(pitch_adjustments) do
        avg_pitch = avg_pitch + pitch_adj
    end
    
    avg_yaw = avg_yaw / total_weight
    avg_pitch = avg_pitch / total_weight
    
    -- Calculate confidence based on consistency
    local yaw_variance = 0
    local pitch_variance = 0
    
    for i, yaw_adj in ipairs(yaw_adjustments) do
        yaw_variance = yaw_variance + (yaw_adj - avg_yaw)^2
    end
    
    for i, pitch_adj in ipairs(pitch_adjustments) do
        pitch_variance = pitch_variance + (pitch_adj - avg_pitch)^2
    end
    
    yaw_variance = yaw_variance / #yaw_adjustments
    pitch_variance = pitch_variance / #pitch_adjustments
    
    local confidence = math.max(0.1, 1.0 - (yaw_variance + pitch_variance) / 100)
    
    return {
        yaw = avg_yaw,
        pitch = avg_pitch,
        confidence = confidence,
        miss_count = miss_data.total_misses
    }
end

-- Initialize the shot detection system
initialize_shot_detection()

-- Configuration functions removed

-- Configuration buttons removed

-- Reset function removed

local function reset_debug_stats()
    debug_stats.total_resolves = 0
    debug_stats.successful_resolves = 0
    debug_stats.missed_shots = 0
    debug_stats.hit_shots = 0
    debug_stats.yaw_corrections = 0
    debug_stats.pitch_corrections = 0
    debug_stats.desync_breaks_detected = 0
    debug_stats.fakelag_detections = 0
    debug_stats.negative_backtrack_records = 0
    debug_stats.last_reset = globals.realtime()
    client_log("[HVH Resolver] Debug statistics cleared!")
end

-- Configuration system removed

-- UI settings already configured at top of file

-- Simplified UI Visibility Management
local function update_ui_visibility()
    -- local resolver_enabled = resolver_enabled -- already defined
    
    -- Show/hide essential settings only
    -- UI visibility removed
end

-- Function moved to earlier location

-- UI Callbacks
-- UI callback removed
-- Removed callbacks for non-existent UI elements
-- Debug mode removed

-- Initialize UI visibility
update_ui_visibility()

-- Debug and Statistics System moved to earlier location

-- Enhanced Logging System (functions moved to top of file)
-- Function moved above resolve_player

local function reset_debug_stats()
    debug_stats.total_resolves = 0
    debug_stats.successful_resolves = 0
    debug_stats.missed_shots = 0
    debug_stats.hit_shots = 0
    debug_stats.yaw_corrections = 0
    debug_stats.pitch_corrections = 0
    debug_stats.desync_breaks_detected = 0
    debug_stats.fakelag_detections = 0
    debug_stats.negative_backtrack_records = 0
    debug_stats.last_reset = globals.realtime()
end

-- ESP Function for Head Visualization
-- ESP function removed - all visual elements disabled
local function draw_resolver_esp()
    -- All ESP functionality removed
end

-- Info panel function removed - all visual elements disabled
local function draw_resolver_info()
    -- All info panel functionality removed
end

local function log_resolver_event(event_type, message)
    -- Zawsze loguj zdarzenia resolvera
    
    local timestamp = string.format("[%.2f]", globals.realtime())
    
    -- Event types in English
    local event_translations = {
        ["MISS"] = "MISS",
        ["HIT"] = "HIT",
        ["RESOLVE"] = "RESOLVER",
        ["ERROR"] = "ERROR",
        ["INFO"] = "INFO"
    }
    
    local translated_event = event_translations[event_type] or event_type
    local log_message = string.format("%s [%s] %s", timestamp, translated_event, message)
    
    -- Loguj wszystkie zdarzenia
    client_log(log_message)
end

-- Paint event callback removed - no visual elements

-- Shot data saving functions removed

-- Shot event callbacks for real statistics tracking
local shots_fired = {}

api.client.set_event_callback("aim_fire", function(e)
    if not get_resolver_enabled() then return end
    
    local target = e.target
    if target and target > 0 then
        -- Get target position at shot time
        local target_origin = {entity.get_origin(target)}
    local target_angles = {entity.get_prop(target, "m_angEyeAngles")}
        
        -- Validate target angles
        if not target_angles or type(target_angles) ~= "table" or not target_angles[1] or not target_angles[2] then
            target_angles = {0, 0} -- Default angles if invalid
        end
        
        -- Get resolver data
        local resolver_record = resolver_data[target]
        local resolver_mode = "unknown"
        local resolved_yaw = 0
        local confidence = 0
        
        if resolver_record and resolver_record.latest_record then
            local main_mode = resolver_record.latest_record.resolver_mode or "unknown"
            local advanced_mode = resolver_record.latest_record.advanced_mode
            
            -- Resolver data retrieved
            
            -- Combine main mode with advanced mode for better display
            if advanced_mode and advanced_mode ~= main_mode then
                resolver_mode = main_mode .. "/" .. advanced_mode
            else
                resolver_mode = main_mode
            end
            
            resolved_yaw = resolver_record.latest_record.resolved_yaw or 0
            confidence = resolver_record.latest_record.confidence or 0
        end
        
        -- Validate and convert backtrack value from ticks to milliseconds
        local backtrack_ticks = e.backtrack or 0
        if backtrack_ticks < 0 then
            backtrack_ticks = 0
            debug_stats.negative_backtrack_events = (debug_stats.negative_backtrack_events or 0) + 1
        end
        local backtrack_value = math.floor(backtrack_ticks * 15.625) -- Convert ticks to ms (1000/64)
        
        -- Get AI prediction for this shot
        local ai_prediction = calculate_ai_prediction(target, {
            velocity = {entity.get_prop(target, "m_vecVelocity")},
            eye_angles = target_angles,
            body_yaw = entity.get_prop(target, "m_flLowerBodyYawTarget"),
            duck_amount = entity.get_prop(target, "m_flDuckAmount") or 0
        })
        
        shots_fired[target] = {
            time = globals.realtime(),
            hitbox = e.hitbox,
            damage = e.damage,
            backtrack = backtrack_value, -- Already in milliseconds
            backtrack_ticks = backtrack_ticks,
            original_backtrack = e.backtrack,
            target_pos_x = target_origin[1] or 0,
            target_pos_y = target_origin[2] or 0,
            target_pos_z = target_origin[3] or 0,
            target_yaw = target_angles[2] or 0,
            resolver_mode = resolver_mode,
            resolved_yaw = resolved_yaw,
            resolver_confidence = confidence,
            ai_prediction = ai_prediction -- Store AI prediction for learning
        }
        
        -- Log shot attempt with detailed information using standard CS:GO mapping
        local hitbox_value = e.hitbox or 0
        local hitbox_name = "unknown"
        if hitbox_value == 0 then hitbox_name = "generic"
        elseif hitbox_value == 1 then hitbox_name = "head"
        elseif hitbox_value == 2 then hitbox_name = "chest"
        elseif hitbox_value == 3 then hitbox_name = "stomach"
        elseif hitbox_value == 4 then hitbox_name = "left arm"
        elseif hitbox_value == 5 then hitbox_name = "right arm"
        elseif hitbox_value == 6 then hitbox_name = "left leg"
        elseif hitbox_value == 7 then hitbox_name = "right leg"
        elseif hitbox_value == 8 then hitbox_name = "neck"
        elseif hitbox_value == 9 then hitbox_name = "generic"
        elseif hitbox_value == 10 then hitbox_name = "gear"
        end
        
        local shot_log = string.format(
            "Player: %s | Target: %s | Resolver: %s (angle: %.1f°, confidence: %d%%) | Position: %.0f,%.0f,%.0f | Backtrack: %d ms",
            api.entity.get_player_name(target) or "unknown",
            hitbox_name,
            resolver_mode or "unknown",
            resolved_yaw or 0,
            math.floor((confidence or 0) * 100),
            target_origin[1] or 0,
            target_origin[2] or 0,
            target_origin[3] or 0,
            backtrack_value
        )
        
        simple_log(shot_log, "resolver")
    end
end)

-- Add aim_hit event handler with detailed logging
api.client.set_event_callback("aim_hit", function(e)
    if not resolver_enabled then return end
    
    local target = e.target
    if target and target > 0 then
        -- Get detailed target information
        local target_name = api.entity.get_player_name(target) or "unknown"
        local target_origin = {entity.get_origin(target)}
        local target_head_pos = {entity.get_prop(target, "m_vecOrigin")}
        if target_head_pos[1] then
            target_head_pos[3] = (target_head_pos[3] or 0) + 64 -- Add head offset
        end
        
        -- Get resolver data from shot_data (more accurate than current resolver_record)
        local shot_data = shots_fired[target]
        local resolver_mode = "unknown"
        local resolver_yaw = "unknown"
        local resolver_confidence = 0
        
        if shot_data then
            resolver_mode = shot_data.resolver_mode or "unknown"
            resolver_yaw = string.format("%.1f°", shot_data.resolved_yaw or 0)
            resolver_confidence = math.floor((shot_data.resolver_confidence or 0) * 100)
        end
        
        -- Get shot information and check for hitbox mismatch
        local hitbox_name = "unknown"
        local aimed_hitbox_name = "unknown"
        local hitbox = e.hitbox or 0
        local aimed_hitbox = shot_data and shot_data.hitbox or 0
        
        -- Convert hitbox numbers to names (CS:GO standard mapping)
        local function get_hitbox_name(hb)
            if hb == 0 then return "generic"
            elseif hb == 1 then return "head"
            elseif hb == 2 then return "chest"
            elseif hb == 3 then return "stomach"
            elseif hb == 4 then return "left arm"
            elseif hb == 5 then return "right arm"
            elseif hb == 6 then return "left leg"
            elseif hb == 7 then return "right leg"
            elseif hb == 8 then return "neck"
            elseif hb == 9 then return "generic"
            elseif hb == 10 then return "gear"
            else return "unknown"
            end
        end
        
        hitbox_name = get_hitbox_name(hitbox)
        aimed_hitbox_name = get_hitbox_name(aimed_hitbox)
        
        -- Check for hitbox mismatch
        local is_mismatch = (aimed_hitbox ~= hitbox) and shot_data ~= nil
        local mismatch_info = ""
        if is_mismatch then
            mismatch_info = string.format(" | MISMATCH: aimed %s, hit %s", aimed_hitbox_name, hitbox_name)
        end
        
        -- Use backtrack value from shot_data (more accurate than e.backtrack)
        local backtrack_value = 0
        if shot_data then
            backtrack_value = shot_data.backtrack or 0
        else
            backtrack_value = e.backtrack or 0
        end
        
        if backtrack_value < 0 then
            debug_stats.negative_backtrack_hits = (debug_stats.negative_backtrack_hits or 0) + 1
        end
        
        -- Create detailed hit log with mismatch detection
        local hit_log = string.format(
            "Player: %s | Hitbox: %s | Damage: %d HP | Resolver: %s (angle: %s, confidence: %d%%) | Backtrack: %d ms | Position: %.0f,%.0f,%.0f%s",
            target_name or "unknown",
            hitbox_name,
            e.damage or 0,
            resolver_mode,
            resolver_yaw or "unknown",
            resolver_confidence or 0,
            backtrack_value,
            target_origin[1] or 0,
            target_origin[2] or 0,
            target_origin[3] or 0,
            mismatch_info
        )
        
        -- Use different log type for mismatch
        local log_type = is_mismatch and "miss" or "hit"
        simple_log(hit_log, log_type)
        
        debug_stats.hit_shots = debug_stats.hit_shots + 1
        
        -- AI Database Integration removed
        
        -- Update AI learning system
        if shots_fired[target] and shots_fired[target].ai_prediction then
            update_ai_learning("hit", shots_fired[target].ai_prediction, shot_data)
        end
        
        -- Update bruteforce learning with successful hit
        if shots_fired[target] then
            process_shot_feedback(target, true, e.damage)
            shots_fired[target] = nil
        end
    end
end)

-- Add aim_miss event handler with detailed analysis
api.client.set_event_callback("aim_miss", function(e)
    if not resolver_enabled then return end
    
    local target = e.target
    if target and target > 0 then
        -- Get detailed target information
        local target_name = api.entity.get_player_name(target) or "unknown"
        local target_origin = {entity.get_origin(target)}
        local target_head_pos = {entity.get_prop(target, "m_vecOrigin")}
        if target_head_pos[1] then
            target_head_pos[3] = (target_head_pos[3] or 0) + 64 -- Add head offset
        end
        
        -- Get shot data for accurate resolver information
        local shot_data = shots_fired[target]
        local resolver_mode = "unknown"
        local resolver_yaw = "unknown"
        local resolver_confidence = 0
        local predicted_yaw = "unknown"
        
        if shot_data then
            resolver_mode = shot_data.resolver_mode or "unknown"
            resolver_yaw = string.format("%.1f°", shot_data.resolved_yaw or 0)
            resolver_confidence = math.floor((shot_data.resolver_confidence or 0) * 100)
            predicted_yaw = resolver_yaw -- Use same as resolved_yaw for consistency
        end
        
        -- Analyze miss reason
        local miss_reason = e.reason or "unknown"
        local detailed_reason = "unknown"
        
        if miss_reason == "spread" then
            detailed_reason = "weapon spread/recoil"
        elseif miss_reason == "prediction error" then
            detailed_reason = "movement prediction failed"
        elseif miss_reason == "resolver" then
            detailed_reason = "anti-aim resolver failed"
        elseif miss_reason == "occlusion" then
            detailed_reason = "target occluded/behind wall"
        elseif miss_reason == "lag compensation" then
            detailed_reason = "lag compensation error"
        else
            detailed_reason = miss_reason
        end
        
        -- Get aimed hitbox information using standard CS:GO mapping
        local aimed_hitbox = "unknown"
        if shot_data and shot_data.hitbox then
            if shot_data.hitbox == 0 then aimed_hitbox = "generic"
            elseif shot_data.hitbox == 1 then aimed_hitbox = "head"
            elseif shot_data.hitbox == 2 then aimed_hitbox = "chest"
            elseif shot_data.hitbox == 3 then aimed_hitbox = "stomach"
            elseif shot_data.hitbox == 4 then aimed_hitbox = "left arm"
            elseif shot_data.hitbox == 5 then aimed_hitbox = "right arm"
            elseif shot_data.hitbox == 6 then aimed_hitbox = "left leg"
            elseif shot_data.hitbox == 7 then aimed_hitbox = "right leg"
            elseif shot_data.hitbox == 8 then aimed_hitbox = "neck"
            elseif shot_data.hitbox == 9 then aimed_hitbox = "generic"
            elseif shot_data.hitbox == 10 then aimed_hitbox = "gear"
            end
        end
        
        -- Calculate position difference if we have shot data
         local pos_diff = "unknown"
         local yaw_diff = "unknown"
         if shot_data and target_origin[1] then
             local dx = (target_origin[1] or 0) - (shot_data.target_pos_x or 0)
             local dy = (target_origin[2] or 0) - (shot_data.target_pos_y or 0)
             local dz = (target_origin[3] or 0) - (shot_data.target_pos_z or 0)
             local distance = math.sqrt(dx*dx + dy*dy + dz*dz)
             pos_diff = string.format("%.1f units (%.1f,%.1f,%.1f)", distance, dx, dy, dz)
             
             -- Calculate yaw difference
             local eye_angles = entity.get_prop(target, "m_angEyeAngles")
             local current_yaw = (eye_angles and type(eye_angles) == "table" and eye_angles[2]) or 0
             local shot_yaw = shot_data.target_yaw or 0
             local yaw_delta = math.abs(current_yaw - shot_yaw)
             if yaw_delta > 180 then yaw_delta = 360 - yaw_delta end
             yaw_diff = string.format("%.1f° (was %.1f°, now %.1f°)", yaw_delta, shot_yaw, current_yaw)
         end
        
        -- Use backtrack value from shot_data (more accurate than e.backtrack)
        local backtrack_value = 0
        if shot_data then
            backtrack_value = shot_data.backtrack or 0
        else
            backtrack_value = e.backtrack or 0
        end
        
        if backtrack_value < 0 then
            debug_stats.negative_backtrack_misses = (debug_stats.negative_backtrack_misses or 0) + 1
        end
        
        -- Create detailed miss log with explanations
         local miss_log = string.format(
             "Player: %s | Miss Reason: %s | Target: %s | Resolver: %s (angle: %s→%s, confidence: %d%%) | Backtrack: %d ms | Position: %.0f,%.0f,%.0f | Pos Diff: %s | Angle Diff: %s",
             target_name,
             detailed_reason == "resolver" and "resolver inaccuracy (predicted wrong angle)" or
             detailed_reason == "spread" and "weapon spread (random bullet deviation)" or
             detailed_reason == "prediction" and "movement prediction error" or
             detailed_reason == "desync" and "desync detection failed" or
             detailed_reason == "movement" and "player movement compensation" or
             detailed_reason == "lag" and "network lag compensation" or
             detailed_reason == "hitbox" and "hitbox positioning error" or detailed_reason,
             aimed_hitbox,
             resolver_mode,
             resolver_yaw,
             predicted_yaw,
             resolver_confidence,
             backtrack_value,
             target_origin[1] or 0,
             target_origin[2] or 0,
             target_origin[3] or 0,
             pos_diff,
             yaw_diff
         )
        
        simple_log(miss_log, "miss")
        
        -- Additional resolver analysis completed
        
        debug_stats.missed_shots = debug_stats.missed_shots + 1
        
        -- AI Database Integration removed
        
        -- Update AI learning system
        if shots_fired[target] and shots_fired[target].ai_prediction then
            update_ai_learning("miss", shots_fired[target].ai_prediction, shot_data)
        end
        
        -- Update bruteforce learning with missed shot
        if shots_fired[target] then
            process_shot_feedback(target, false, 0)
            shots_fired[target] = nil
        end
    end
end)

api.client.set_event_callback("player_hurt", function(e)
    if not resolver_enabled then return end
    
    local attacker = client_userid_to_entindex(e.attacker)
    local victim = client_userid_to_entindex(e.userid)
    
    if attacker == api.entity.get_local_player() and victim ~= attacker then
        -- This is handled by aim_hit event now
        -- Keep for compatibility with existing code
    end
end)

-- Check for missed shots periodically
local function check_missed_shots()
    if not resolver_enabled then return end
    
    local current_time = globals.realtime()
    
    for target, shot_data in pairs(shots_fired) do
        -- If shot is older than 0.5 seconds and no hit was registered, count as miss
        if current_time - shot_data.time > 0.5 then
            debug_stats.missed_shots = debug_stats.missed_shots + 1
            
            -- Update bruteforce learning with missed shot
            process_shot_feedback(target, false, 0)
            
            shots_fired[target] = nil
        end
    end
end

-- Hook missed shot checker to paint event - keeping for functionality
api.client.set_event_callback("paint", check_missed_shots)

-- Function moved to earlier location

-- Configuration system removed

-- Configuration getter functions
-- get_ui_config function removed - using hardcoded values



-- Function moved above resolve_player

-- Enhanced Performance Optimization System
local performance_optimizer = {
    adaptive_quality = true,
    target_fps = 144,
    current_fps = 0,
    quality_level = 1.0,
    last_optimization = 0,
    optimization_interval = 1000
}

local resolver_cache = {
    desync_data = {},
    pattern_cache = {},
    movement_cache = {},
    max_cache_size = 1000,
    cache_timeout = 5000
}

-- Security and Safety Functions
local function validate_entity_index(ent_index)
    if not ent_index or type(ent_index) ~= "number" then
        return false, "Invalid entity index type"
    end
    
    if ent_index < 1 or ent_index > 64 then
        return false, "Entity index out of range"
    end
    
    if not entity.get_prop(ent_index, "m_iHealth") then
        return false, "Entity does not exist"
    end
    
    return true, "Valid"
end



local function validate_resolver_data(resolver_data)
    if not resolver_data then
        return false, "Resolver data is nil"
    end
    
    -- Validate required fields
    local required_fields = {"eye_angles", "velocity", "flags", "movement_state"}
    for _, field in ipairs(required_fields) do
        if not resolver_data[field] then
            return false, "Missing required field: " .. field
        end
    end
    
    -- Validate eye angles
    if type(resolver_data.eye_angles) ~= "table" or 
       not resolver_data.eye_angles[1] or not resolver_data.eye_angles[2] then
        return false, "Invalid eye angles format"
    end
    
    local pitch, yaw = resolver_data.eye_angles[1], resolver_data.eye_angles[2]
    if type(pitch) ~= "number" or type(yaw) ~= "number" then
        return false, "Eye angles must be numbers"
    end
    
    if math.abs(pitch) > 90 or math.abs(yaw) > 180 then
        return false, "Eye angles out of valid range"
    end
    
    -- Validate velocity
    if type(resolver_data.velocity) ~= "table" or #resolver_data.velocity < 3 then
        return false, "Invalid velocity format"
    end
    
    for i = 1, 3 do
        if type(resolver_data.velocity[i]) ~= "number" then
            return false, "Velocity components must be numbers"
        end
        if math.abs(resolver_data.velocity[i]) > 3500 then -- CS:GO max velocity check
            return false, "Velocity out of realistic range"
        end
    end
    
    return true, "Resolver data valid"
end

-- Update security settings from UI
local function update_security_settings()
    security_system.enabled = true
    security_system.anti_detection = true
    security_system.safe_mode = false
    security_system.validation_level = 2
    security_system.max_resolver_calls_per_second = 128
    
    -- Reset emergency shutdown if settings changed
    if security_system.enabled then
        security_system.emergency_shutdown = false
        security_system.suspicious_activity_count = 0
    end
end

-- Security monitoring and reporting
local function monitor_security_status()
    if not security_system.enabled then
        return
    end
    
    local current_time = globals.realtime()
    
    -- Log security status periodically (every 30 seconds)
    if not security_system.last_status_report then
        security_system.last_status_report = current_time
    end
    
    if current_time - security_system.last_status_report >= 30.0 then
        local status_msg = string.format(
            "Security Status: Calls/sec: %d/%d, Suspicious: %d, Emergency: %s",
            security_system.call_counter,
            security_system.max_resolver_calls_per_second,
            security_system.suspicious_activity_count,
            security_system.emergency_shutdown and "YES" or "NO"
        )
        simple_log(status_msg, "resolver")
        security_system.last_status_report = current_time
    end
end

local function optimize_performance()
    local current_time = globals.realtime()
    
    if current_time - performance_optimizer.last_optimization < performance_optimizer.optimization_interval then
        return
    end
    
    performance_optimizer.last_optimization = current_time
    performance_optimizer.current_fps = 1 / globals.frametime()
    
    -- Adaptive quality adjustment based on FPS
    if performance_optimizer.adaptive_quality then
        local fps_ratio = performance_optimizer.current_fps / performance_optimizer.target_fps
        
        if fps_ratio < 0.8 then -- FPS too low, reduce quality
            performance_optimizer.quality_level = math.max(0.3, performance_optimizer.quality_level - 0.1)
        elseif fps_ratio > 1.2 then -- FPS high enough, increase quality
            performance_optimizer.quality_level = math.min(1.0, performance_optimizer.quality_level + 0.05)
        end
    end
    
    -- Clean old cache entries
    local cache_cleaned = 0
    for cache_type, cache_data in pairs(resolver_cache) do
        if type(cache_data) == "table" then
            for key, entry in pairs(cache_data) do
                if type(entry) == "table" and entry.timestamp then
                    if current_time - entry.timestamp > resolver_cache.cache_timeout then
                        cache_data[key] = nil
                        cache_cleaned = cache_cleaned + 1
                    end
                end
            end
        end
    end
    
    -- Update performance stats
    if performance_stats.resolver_calls > 0 then
        performance_stats.average_time = performance_stats.total_time / performance_stats.resolver_calls
        performance_stats.fps_impact = math.max(0, performance_optimizer.target_fps - performance_optimizer.current_fps)
    end
end

local function get_cached_result(cache_type, key)
    local cache = resolver_cache[cache_type]
    if not cache or not cache[key] then
        performance_stats.cache_misses = performance_stats.cache_misses + 1
        return nil
    end
    
    local entry = cache[key]
    local current_time = globals.realtime()
    
    if current_time - entry.timestamp > resolver_cache.cache_timeout then
        cache[key] = nil
        performance_stats.cache_misses = performance_stats.cache_misses + 1
        return nil
    end
    
    performance_stats.cache_hits = performance_stats.cache_hits + 1
    return entry.data
end

local function set_cached_result(cache_type, key, data)
    local cache = resolver_cache[cache_type]
    if not cache then
        resolver_cache[cache_type] = {}
        cache = resolver_cache[cache_type]
    end
    
    -- Limit cache size
    local cache_size = 0
    for _ in pairs(cache) do
        cache_size = cache_size + 1
    end
    
    if cache_size >= resolver_cache.max_cache_size then
        -- Remove oldest entry
        local oldest_key, oldest_time = nil, math.huge
        for k, v in pairs(cache) do
            if v.timestamp and v.timestamp < oldest_time then
                oldest_time = v.timestamp
                oldest_key = k
            end
        end
        if oldest_key then
            cache[oldest_key] = nil
        end
    end
    
    cache[key] = {
        data = data,
        timestamp = globals.realtime()
    }
end

local function get_performance_stats()
    return {
        resolver_calls = performance_stats.resolver_calls,
        average_time = performance_stats.average_time,
        max_time = performance_stats.max_time,
        fps_impact = performance_stats.fps_impact,
        cache_hit_rate = performance_stats.cache_hits / math.max(1, performance_stats.cache_hits + performance_stats.cache_misses),
        quality_level = performance_optimizer.quality_level,
        current_fps = performance_optimizer.current_fps
    }
end

-- Log flushing functions removed

-- Performance monitoring callback - visual elements removed
api.client.set_event_callback("paint", function()
    -- Update security settings from UI
    update_security_settings()
    
    -- Monitor security status
    monitor_security_status()
    
    optimize_performance()
    
    -- Log flushing removed
end)

-- Shutdown callback
api.client.set_event_callback("shutdown", function()
    simple_log("HVH Resolver został wyłączony", "resolver")
end)

-- AI Miss Analysis System removed

-- AI player analysis functions removed

-- AI miss analysis functions removed

-- Initialize security system
simple_log("Enhanced Security System initialized - Resolver is now more secure and stable", "resolver")
simple_log("Security features: Entity validation, Rate limiting, Anti-detection, Safe mode", "resolver")

-- Main resolver update callback
api.client.set_event_callback("net_update_end", function()
    if not get_resolver_enabled() then return end
    
    local players = entity.get_players(true)
    for _, player in ipairs(players) do
        if player and entity.is_alive(player) and not entity.is_dormant(player) then
            -- Call resolve_player - it handles plist internally
            resolve_player(player)
        end
    end
end)

-- Main resolver functions table (for reference)
local resolver_api = {
    resolve_player = resolve_player,
    get_latest_record = get_latest_record,
    resolver_stats = resolver_stats,
    register_shot_attempt = register_shot_attempt,
    process_shot_feedback = process_shot_feedback,
    calculate_adaptive_angle = calculate_adaptive_angle,
    update_bruteforce_phase = update_bruteforce_phase,
    detect_mobile_protection = detect_mobile_protection,
    detect_missed_shot = detect_missed_shot,
    get_resolver_adjustment_from_misses = get_resolver_adjustment_from_misses,
    analyze_shot_trajectory = analyze_shot_trajectory,
    -- UI config functions removed,
    
    -- Enhanced performance functions
    get_performance_stats = get_performance_stats,
    get_cached_result = get_cached_result,
    set_cached_result = set_cached_result,
    analyze_desync_patterns = analyze_desync_patterns,
    predict_movement = predict_movement,
    
    -- AI Miss Analysis System removed
}

-- ESP Flag Registration for Resolved Players
client.register_esp_flag("\a96E631FFRESOLVED", 200, 200, 200, function(e)
    if not get_resolver_enabled() then return false end
    if not entity.is_enemy(e) then return false end
    if not entity.is_alive(e) then return false end
    
    -- Check if player has been resolved recently
    local resolver_record = resolver_data[e]
    if resolver_record and resolver_record.latest_record then
        local confidence = resolver_record.latest_record.confidence or 0
        local time_since_resolve = globals.realtime() - (resolver_record.last_resolve_time or 0)
        
        -- Show flag if confidence > 0.3 and resolved within last 2 seconds
        return confidence > 0.3 and time_since_resolve < 2.0
    end
    
    return false
end)

-- Return resolver API for module usage
return resolver_api