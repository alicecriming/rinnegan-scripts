-- author / aircrouch

-- 2025



--[[



    RULES

    1. юзай self и при вызове методов вызывай их через class:method()

    2. локальные методы и поля начинай с _

    3. юзай snake_case

    4. соблюдай модульность и ооп и не забывай про оптимизацию

    5. все суй в классы а их отделяй do блоками

    

]]



local ffi = require "ffi"

local bit = require "bit"

local pui = require "gamesense/pui"

local vector = require "vector"

local base64 = require "gamesense/base64"

local c_entity = require "gamesense/entity"

local websocket = require "gamesense/websockets"

local clipboard = require "gamesense/clipboard"



-- classes

Class = {

    ragebot = {},

    antiaim = {},

    visuals = {},    

    network = {},

    motion = {},

    render = {},

    config = {},

    util = {},

    misc = {},

    ui = {}

}



-- database

local user_database = {

    lua_name = "Amethyst",

    username = _USER_NAME  or "admin",

    branch = "Debug",

    update_date = "8.11.2025"

}



do          -- @ region util



    Class.util = {

        accent_color = {

            first = {194, 189, 251, 255},

            second = {61, 195, 207, 255},    

            background = {20, 20, 25, 195},

            separator = {75, 75, 75, 255}

        },



        gamesense_color = {

            159, 202, 43, 255

        },

        

        reference = {

            rage_enabled = { ui.reference("RAGE", "Aimbot", "Enabled") },

            rage_double_tap = { ui.reference("RAGE","aimbot","Double tap")},

            rage_force_baim = ui.reference("RAGE", "Aimbot", "Force body aim"),

            rage_hitchance = { ui.reference("RAGE", "Aimbot", "Minimum hit chance") },

            rage_minimum_damage = { ui.reference("RAGE", "Aimbot", "Minimum damage") },

            rage_minimum_damage_override = { ui.reference("RAGE", "Aimbot", "Minimum damage override") },

            rage_fake_duck = { ui.reference("RAGE", "Other", "Duck peek assist") },

            rage_peek_assist = { ui.reference("RAGE", "Other", "Quick peek assist") },

            aa_enabled = ui.reference("AA", "Anti-aimbot angles", "Enabled"),

            aa_yaw_base = ui.reference("AA", "Anti-aimbot angles", "Yaw base"),

            aa_fs_body_yaw = ui.reference("AA", "anti-aimbot angles", "Freestanding body yaw"),

            aa_edge_yaw = ui.reference("AA", "Anti-aimbot angles", "Edge yaw"),

            aa_roll = { ui.reference("AA", "Anti-aimbot angles", "Roll") },

            aa_hideshots = { ui.reference("AA","other","on shot anti-aim")},

            aa_pitch = { ui.reference("AA", "Anti-aimbot angles", "pitch"), },

            aa_yaw = { ui.reference("AA", "Anti-aimbot angles", "Yaw") }, 

            aa_yaw_jitter = { ui.reference("AA", "Anti-aimbot angles", "Yaw jitter") },

            aa_yaw_body = { ui.reference("AA", "Anti-aimbot angles", "Body yaw") },

            aa_freestanding = { ui.reference("AA", "Anti-aimbot angles", "Freestanding") },

            aa_slow_walk = { ui.reference("AA", "Other", "Slow motion") },

            aa_fakelag_limit = {ui.reference("AA","Fake lag", "Limit")},

            aa_fakelag_variance = {ui.reference("AA","Fake lag", "Variance")},

            aa_fakelag_amount = {ui.reference("AA","Fake lag", "Amount")},

            aa_fakelag_enabled = {ui.reference("AA","Fake lag", "Enabled")},

            aa_legs_movement = {ui.reference("AA","Other", "Leg movement")},

            aa_fakepeek = {ui.reference("AA","Other", "Fake peek")},

            visuals_scope_overlay = ui.reference("VISUALS", "Effects", "Remove scope overlay"),

            menu_color = {ui.reference("Misc", "Settings", "Menu color")},

            menu_lock = {ui.reference("Misc", "Settings", "Lock Menu Layout")}            

        },



        hide_menu = function(self, show)

            ui.set_visible(self.reference.aa_enabled, show)

            ui.set_visible(self.reference.aa_pitch[1], show)

            ui.set_visible(self.reference.aa_pitch[2], show)

            ui.set_visible(self.reference.aa_yaw_base, show)

            ui.set_visible(self.reference.aa_yaw[1], show)

            ui.set_visible(self.reference.aa_yaw[2], show)

            ui.set_visible(self.reference.aa_yaw_jitter[1], show)

            ui.set_visible(self.reference.aa_yaw_jitter[2], show)

            ui.set_visible(self.reference.aa_roll[1], show)

            ui.set_visible(self.reference.aa_yaw_body[1], show)

            ui.set_visible(self.reference.aa_yaw_body[2], show)

            ui.set_visible(self.reference.aa_fs_body_yaw, show)

            ui.set_visible(self.reference.aa_edge_yaw, show)

            ui.set_visible(self.reference.aa_freestanding[1], show)

            ui.set_visible(self.reference.aa_freestanding[2], show)

            ui.set_visible(self.reference.aa_fakelag_limit[1], show)

            ui.set_visible(self.reference.aa_fakelag_variance[1], show)

            ui.set_visible(self.reference.aa_fakelag_amount[1], show)

            ui.set_visible(self.reference.aa_fakelag_enabled[1], show)

            ui.set_visible(self.reference.aa_fakelag_enabled[2], show)            

        end,



        push_welcome_message = function(self)

            local highlight_color = {self.accent_color.first[1], self.accent_color.first[2], self.accent_color.first[3]}

            local default_color = {225, 225, 225}



            client.delay_call(0.25, function() 

                Class.render.notifications:push(string.format("/rwelcome back /v%s/r, your branch: /v%s/r", string.lower(user_database.username), string.lower(user_database.branch)), "info", highlight_color) 

            end)            

        end,



        open_network = function(self)

            local link

            if Class.ui.menu.home_tab.network.choose:get() == "Discord" then

                link = "https://discord.gg/sFYjyP5rpj"

            else

                link = "https://t.me/AmethystLua"

            end



            panorama.open().SteamOverlayAPI.OpenExternalBrowserURL(link)

        end,   



        setup_menu_color = function(self)

            ui.set(self.reference.menu_color[1], self.accent_color.first[1], self.accent_color.first[2], self.accent_color.first[3], self.accent_color.first[4])

        end,  

        

        reset_menu_color = function(self)

            ui.set(self.reference.menu_color[1], self.gamesense_color[1], self.gamesense_color[2], self.gamesense_color[3], self.gamesense_color[4])

        end,

    

        reset_viewmodel = function(self)

            Class.ui.menu.visuals_tab.other.viewmodel_changer.position.x:set(0)

            Class.ui.menu.visuals_tab.other.viewmodel_changer.position.y:set(0)

            Class.ui.menu.visuals_tab.other.viewmodel_changer.position.z:set(0)

        end,



        setup_console_filter = function(self)

            cvar.con_filter_enable:set_int(1)

            cvar.con_filter_text:set_string("IrWL5106TZZKNFPz4P4Gl3pSN?J370f5hi373ZjPg%VOVh6lN")

            client.exec("con_filter_enable 1")                

        end,



        reset_console_filter = function(self)

            cvar.r_aspectratio:set_float(0)

            cvar.con_filter_enable:set_int(0)

            cvar.con_filter_text:set_string("")

        end,



        setup_post_proccesing = function(self) 

            cvar.cl_csm_shadows:set_int(0) 

            cvar.violence_hblood:set_int(0)

            cvar.violence_ablood:set_int(0) 

            cvar.mat_vignette_enable:set_int(0) 

            cvar.mat_postprocess_enable:set_int(0) 

            cvar.mat_bloom_scalefactor_scalar:set_int(0)    

        end,



        reset_post_proccesing = function(self) 

            cvar.cl_csm_shadows:set_int(1) 

            cvar.violence_hblood:set_int(1)

            cvar.violence_ablood:set_int(1) 

            cvar.mat_vignette_enable:set_int(1) 

            cvar.mat_postprocess_enable:set_int(1) 

            cvar.mat_bloom_scalefactor_scalar:set_int(1)    

        end,

    

        rgba_to_hex = function(self, r, g, b, a)

            return string.format("%.2x%.2x%.2x%.2x", r, g, b, a)

        end,



        is_debug_branch = function(self)

            return user_database.branch == "Debug"

        end,



        get_username = function(self, case)

            return case and string.lower(user_database.username) or user_database.username

        end,



        get_lua_name = function(self, case)

            return case and string.lower(user_database.lua_name) or user_database.lua_name

        end,



        get_branch = function(self, case)

            return case and string.lower(user_database.branch) or user_database.branch

        end,



        get_update_date = function(self, case)

            return case and string.lower(user_database.update_date) or user_database.update_date

        end,



        math = {

            clamp = function(self, x, min, max)

                return x < min and min or x > max and max or x

            end

        }

    }



    Class.util.reference = {

        rage_enabled = { ui.reference("RAGE", "Aimbot", "Enabled") },

        rage_double_tap = { ui.reference("RAGE","aimbot","Double tap")},

        rage_force_baim = ui.reference("RAGE", "Aimbot", "Force body aim"),

        rage_hitchance = { ui.reference("RAGE", "Aimbot", "Minimum hit chance") },

        rage_minimum_damage = { ui.reference("RAGE", "Aimbot", "Minimum damage") },

        rage_minimum_damage_override = { ui.reference("RAGE", "Aimbot", "Minimum damage override") },

        rage_fake_duck = { ui.reference("RAGE", "Other", "Duck peek assist") },

        rage_peek_assist = { ui.reference("RAGE", "Other", "Quick peek assist") },

        aa_enabled = ui.reference("AA", "Anti-aimbot angles", "Enabled"),

        aa_yaw_base = ui.reference("AA", "Anti-aimbot angles", "Yaw base"),

        aa_fs_body_yaw = ui.reference("AA", "anti-aimbot angles", "Freestanding body yaw"),

        aa_edge_yaw = ui.reference("AA", "Anti-aimbot angles", "Edge yaw"),

        aa_roll = { ui.reference("AA", "Anti-aimbot angles", "Roll") },

        aa_hideshots = { ui.reference("AA","other","on shot anti-aim")},

        aa_pitch = { ui.reference("AA", "Anti-aimbot angles", "pitch"), },

        aa_yaw = { ui.reference("AA", "Anti-aimbot angles", "Yaw") }, 

        aa_yaw_jitter = { ui.reference("AA", "Anti-aimbot angles", "Yaw jitter") },

        aa_yaw_body = { ui.reference("AA", "Anti-aimbot angles", "Body yaw") },

        aa_freestanding = { ui.reference("AA", "Anti-aimbot angles", "Freestanding") },

        aa_slow_walk = { ui.reference("AA", "Other", "Slow motion") },

        aa_fakelag_limit = {ui.reference("AA","Fake lag", "Limit")},

        aa_fakelag_variance = {ui.reference("AA","Fake lag", "Variance")},

        aa_fakelag_amount = {ui.reference("AA","Fake lag", "Amount")},

        aa_fakelag_enabled = {ui.reference("AA","Fake lag", "Enabled")},

        aa_legs_movement = {ui.reference("AA","Other", "Leg movement")},

        aa_fakepeek = {ui.reference("AA","Other", "Fake peek")},

        visuals_scope_overlay = ui.reference("VISUALS", "Effects", "Remove scope overlay"),

        menu_color = {ui.reference("Misc", "Settings", "Menu color")},

        menu_lock = {ui.reference("Misc", "Settings", "Lock Menu Layout")}

    }



    Class.util.clamp = function(x, min, max)

        return x < min and min or x > max and max or x

    end



    Class.util.join_network = function()

        local link

        if Class.ui.menu.home_tab.network.choose:get() == "Discord" then

            link = "https://discord.gg/sFYjyP5rpj"

        else

            link = "https://t.me/AmethystLua"

        end



        return panorama.open().SteamOverlayAPI.OpenExternalBrowserURL(link)

    end



    Class.util.get_current_time = function()

        return string.format("\aB3BED6FF%02d:%02d\aC8C8C8FF", client.system_time())

    end



    Class.util.is_debug_branch = function()

        return user_database.branch == "Debug"

    end





    Class.util.output_message = function(messages)

        for _, part in ipairs(messages) do

            local text = part.text

            local color = part.color

            

            if text and color then

                client.color_log(color[1] or color.r, color[2] or color.g, color[3] or color.b, text .. "\0")

            end

        end

    end    



    Class.util.setup_random_seed = function() 

        math.randomseed((globals.frametime() * globals.curtime()) * 100000)  

    end



    Class.util.setup_random_seed()

end



--TODO VRODE NORM NO MOZNHO I REWRITE ETO

local windows = { }

do

    local data = { }

    local queue = { }

    

    local SNAP_DISTANCE = 20

    local RELEASE_DISTANCE = 35

    

    local axes_alpha = 0.0 

    local axes_target_alpha = 0.0



    local fade_alpha = 0.0

    local fade_target_alpha = 0.0 

    

    local mouse_pos = vector()

    local mouse_pos_prev = vector()

    

    local mouse_down = false

    local mouse_clicked = false

    local mouse_released = false

    

    local mouse_down_duration = 0

    local dragging_smth = false

    

    local mouse_delta = vector()

    local mouse_clicked_pos = vector()

    

    local hovered_window

    local foreground_window

    

    local c_window = { } do

        function c_window:new(name)

            local window = { }

    

            window.name = name

    

            window.pos = vector()

            window.size = vector()

            window.saved_pos = nil  

    

            window.anchor = vector(0.0, 0.0)

    

            window.updated = false

            window.dragging = false

            window.snap_axis = nil

            window.snap_offset = vector()

    

            data[name] = window

            queue[#queue + 1] = window

    

            setmetatable(window, self)

            return window

        end

    

        function c_window:set_pos(pos)

            local screen = vector(client.screen_size())

            local new_pos = pos:clone()

    

            if self.size.x > 0 and self.size.y > 0 then

                new_pos.x = Class.util.clamp(new_pos.x, 0, screen.x - self.size.x)

                new_pos.y = Class.util.clamp(new_pos.y, 0, screen.y - self.size.y)

            end

    

            self.pos = new_pos

        end

    

        function c_window:set_size(size)

            local size_delta = size - self.size

    

            self.size = size

            self:set_pos(self.pos - size_delta * self.anchor)

            

            if self.saved_pos then

                self:set_pos(self.saved_pos)

                self.saved_pos = nil

            end

        end

    

        function c_window:set_anchor(anchor)

            self.anchor = anchor

        end

    

        function c_window:is_hovering()

            return self.hovering

        end

    

        function c_window:is_dragging()

            return self.dragging

        end

    

        function c_window:update()

            self.updated = true

        end



        c_window.__index = c_window

    end

    

    local function save_window_position(window)

        local key = "window_pos_" .. window.name

        local position_data = {

            x = window.pos.x,

            y = window.pos.y

        }

        database.write(key, position_data)

    end

    

    local function load_window_position(window)

        local key = "window_pos_" .. window.name

        local position_data = database.read(key)

        

        if position_data and type(position_data) == "table" then

            window.saved_pos = vector(position_data.x or 0, position_data.y or 0)

            return true

        end

        

        return false

    end

    

    local function is_collided(point, a, b)

        return point.x >= a.x and point.y >= a.y

            and point.x <= b.x and point.y <= b.y

    end

    

    local function update_mouse_inputs()

        local cursor = vector(ui.mouse_position())

        local is_down = client.key_state(0x01)

    

        local delta_time = globals.frametime()

    

        mouse_pos = cursor

        mouse_delta = mouse_pos - mouse_pos_prev

    

        mouse_pos_prev = mouse_pos

    

        mouse_released = mouse_down and not is_down

        

        mouse_down = is_down

        mouse_clicked = is_down and mouse_down_duration < 0

    

        mouse_down_duration = is_down and (mouse_down_duration < 0 and 0 or mouse_down_duration + delta_time) or -1

    

        if mouse_clicked then

            mouse_clicked_pos = mouse_pos

        end

    end

    

    local function appear_all_windows()

        for i = 1, #queue do

            local window = queue[i]

    

            local pos = window.pos

            local size = window.size

    

            local r, g, b, a = 0, 0, 0, 155

    

            renderer.rectangle(pos.x, pos.y, size.x, size.y, r, g, b, a)

        end

    end

    

    local function render_axes()

        axes_alpha = Class.motion.exponential_smooth(axes_alpha, axes_target_alpha, 0.25)

        

        if axes_alpha < 0.01 then

            return

        end

        

        local screen = vector(client.screen_size())

        local screen_center = screen * 0.5

        

        local line_thickness = 1

        

        local active_axis = nil

        if foreground_window and foreground_window.snap_axis then

            active_axis = foreground_window.snap_axis

        end

        

        local x_axis_alpha, y_axis_alpha

        

        if active_axis == 'x' then

            x_axis_alpha = 0.85

            y_axis_alpha = 0.25

        elseif active_axis == 'y' then

            x_axis_alpha = 0.25

            y_axis_alpha = 0.85

        else

            x_axis_alpha = 0.25

            y_axis_alpha = 0.25

        end

        

        renderer.rectangle(screen_center.x - line_thickness/2, 0, line_thickness, screen.y, 220, 220, 220, math.floor(axes_alpha * x_axis_alpha * 255))

        

        renderer.rectangle(0, screen_center.y - line_thickness/2, screen.x, line_thickness, 220, 220, 220, math.floor(axes_alpha * y_axis_alpha * 255))

    end

    

    local function render_fade()

        fade_alpha = Class.motion.exponential_smooth(fade_alpha, fade_target_alpha, 0.25)

        

        if fade_alpha < 0.01 then

            return

        end

        

        local screen = vector(client.screen_size())

        

        renderer.rectangle(0, 0, screen.x, screen.y, 0, 0, 0, math.floor(fade_alpha * 100))

    end

    

    local function find_hovered_window()

        local found_window = nil

    

        if ui.is_menu_open() then

            for i = 1, #queue do

                local window = queue[i]

    

                local pos = window.pos

                local size = window.size

    

                if not window.updated then

                    goto continue

                end

    

                if not is_collided(mouse_pos, pos, pos + size) then

                    goto continue

                end

    

                found_window = window

                ::continue::

            end

        end



        hovered_window = found_window

    end

    

    local function find_foreground_window()

        if mouse_down then

            if mouse_clicked and hovered_window ~= nil then

                for i = 1, #queue do

                    local window = queue[i]

    

                    if window == hovered_window then

                        table.remove(queue, i)

                        table.insert(queue, window)

    

                        break

                    end

                end

    

                foreground_window = hovered_window

                local window_center = foreground_window.pos + foreground_window.size * 0.5

                foreground_window.snap_offset = mouse_pos - window_center

                return

            end

    

            return

        end

    

        foreground_window = nil

    end

    

    local function update_all_windows()

        for i = 1, #queue do

            local window = queue[i]

    

            window.updated = false

            window.hovering = false

            window.dragging = false

            window.snap_axis = nil 

        end

    end

    

    local function update_hovered_window()

        if hovered_window == nil then

            return

        end

    

        hovered_window.hovering = true

    end

    

    local function update_foreground_window()

        dragging_smth = false

        if foreground_window == nil then

            return

        end

        

        local screen = vector(client.screen_size())

        local screen_center = screen * 0.5

        

        local target_center = mouse_pos - foreground_window.snap_offset

        

        local new_position = target_center - foreground_window.size * 0.5

        

        if not foreground_window.snap_axis then

            local dist_to_x_axis = math.abs(target_center.x - screen_center.x)

            local dist_to_y_axis = math.abs(target_center.y - screen_center.y)

            

            if dist_to_x_axis < SNAP_DISTANCE or dist_to_y_axis < SNAP_DISTANCE then

                if dist_to_x_axis < dist_to_y_axis then

                    foreground_window.snap_axis = 'x'

                    new_position.x = screen_center.x - foreground_window.size.x * 0.5

                else

                    foreground_window.snap_axis = 'y'

                    new_position.y = screen_center.y - foreground_window.size.y * 0.5

                end

            end

        else

            if foreground_window.snap_axis == 'x' then

                new_position.x = screen_center.x - foreground_window.size.x * 0.5

                new_position.y = target_center.y - foreground_window.size.y * 0.5

                

                if math.abs(target_center.x - screen_center.x) > RELEASE_DISTANCE then

                    foreground_window.snap_axis = nil

                end

            elseif foreground_window.snap_axis == 'y' then

                new_position.x = target_center.x - foreground_window.size.x * 0.5

                new_position.y = screen_center.y - foreground_window.size.y * 0.5

                

                if math.abs(target_center.y - screen_center.y) > RELEASE_DISTANCE then

                    foreground_window.snap_axis = nil

                end

            end

        end

        

        foreground_window:set_pos(new_position)

        foreground_window.dragging = true

        dragging_smth = true

    end

    

    function windows.new(name, x, y)

        local window = data[name] or c_window:new(name)

        

        local position_loaded = load_window_position(window)



        if not position_loaded and not window.saved_pos then

            local screen = vector(client.screen_size())

            window:set_pos(screen * vector(x, y))

        end



        return window

    end

    

    function windows.frame()

        if ui.is_menu_open() and dragging_smth then

            axes_target_alpha = 1.0

            fade_target_alpha = 0.65

        else

            axes_target_alpha = 0.0

            fade_target_alpha = 0.0

        end

    

        render_fade()

        render_axes()

        update_mouse_inputs()

        find_hovered_window()

        find_foreground_window()

        update_all_windows()

        update_hovered_window()

        update_foreground_window()

        

        if mouse_released then

            windows.save_all_positions()

        end

    end

    

    function windows.cancel_attack(cmd)

        if dragging_smth or hovered_window then

            cmd.in_attack = false

            cmd.in_attack2 = false

        end

    end

    

    function windows.save_all_positions()

        for name, window in pairs(data) do

            save_window_position(window)

        end

    end

    

    function windows.load_all_positions()

        for name, window in pairs(data) do

            load_window_position(window)

        end

    end

end



do          -- @ region render

    Class.render = {

        panels = {

            _icons = {  

                warning = renderer.load_svg([[<svg width="24" height="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><title>warning</title><path fill="#ffffff" d="M1.2 20.8h21.6L12 2 1.2 20.8zM11 8h2v6h-2V8zm0 8h2v2h-2v-2z"/></svg>]],    

                    16, 16

                ),



                logo = renderer.load_svg(

                    [[<svg fill="#ffffff" width="800px" height="800px" viewBox="0 0 24 24" version="1.1" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" fill="#ffffff" d="M12.6 2.819l-3.15 2.613 1.405 10.325 1.819 1.276 1.926-1.202 1.1-10.301zM18.074 9.687l1.902-3.368-0.77-1.556-1.328 0.591-1.275 3.718 0.297 1.486zM6.909 8.377l0.163-1.289-1.856-2.776-1.234-0.504-0.104 1.367 1.856 2.775zM20.671 10.985l-2.572 0.556-3.311 7.929 0.726 1.613 2.207-0.149 4.008-7.541zM4.619 10.151l-0.913 3.043 4.745 7.477 1.703 0.544 0.458-1.403-3.048-9.467z"/></svg>]],

                    16, 16

                ),



                info = renderer.load_svg(

                    [[<svg width="800px" height="800px" viewBox="0 0 24 24" fill="#ffffff" xmlns="http://www.w3.org/2000/svg "><path fill-rule="evenodd" clip-rule="evenodd" d="M22 12C22 17.5228 17.5228 22 12 22C6.47715 22 2 17.5228 2 12C2 6.47715 6.47715 2 12 2C17.5228 2 22 6.47715 22 12ZM12 17.75C12.4142 17.75 12.75 17.4142 12.75 17V11C12.75 10.5858 12.4142 10.25 12 10.25C11.5858 10.25 11.25 10.5858 11.25 11V17C11.25 17.4142 11.5858 17.75 12 17.75ZM12 7C12.5523 7 13 7.44772 13 8C13 8.55228 12.5523 9 12 9C11.4477 9 11 8.55228 11 8C11 7.44772 11.4477 7 12 7Z" fill="#ffffff"/></svg>]],

                    16, 16

                ),



                success = renderer.load_svg(

                    [[<svg width="800px" height="800px" viewBox="0 0 24 24" fill="#ffffff"xmlns="http://www.w3.org/2000/svg "><path fill-rule="evenodd" clip-rule="evenodd" d="M22 12C22 17.5228 17.5228 22 12 22C6.47715 22 2 17.5228 2 12C2 6.47715 6.47715 2 12 2C17.5228 2 22 6.47715 22 12ZM16.0303 8.96967C16.3232 9.26256 16.3232 9.73744 16.0303 10.0303L11.0303 15.0303C10.7374 15.3232 10.2626 15.3232 9.96967 15.0303L7.96967 13.0303C7.67678 12.7374 7.67678 12.2626 7.96967 11.9697C8.26256 11.6768 8.73744 11.6768 9.03033 11.9697L10.5 13.4393L12.7348 11.2045L14.9697 8.96967C15.2626 8.67678 15.7374 8.67678 16.0303 8.96967Z" fill="#ffffff"/></svg>]],

                    16, 16

                ),



                failed = renderer.load_svg(

                    [[<svg width="800px" height="800px" viewBox="0 0 24 24" fill="#ffffff" xmlns="http://www.w3.org/2000/svg "><path fill-rule="evenodd" clip-rule="evenodd" d="M22 12C22 17.5228 17.5228 22 12 22C6.47715 22 2 17.5228 2 12C2 6.47715 6.47715 2 12 2C17.5228 2 22 6.47715 22 12ZM8.96963 8.96965C9.26252 8.67676 9.73739 8.67676 10.0303 8.96965L12 10.9393L13.9696 8.96967C14.2625 8.67678 14.7374 8.67678 15.0303 8.96967C15.3232 9.26256 15.3232 9.73744 15.0303 10.0303L13.0606 12L15.0303 13.9696C15.3232 14.2625 15.3232 14.7374 15.0303 15.0303C14.7374 15.3232 14.2625 15.3232 13.9696 15.0303L12 13.0607L10.0303 15.0303C9.73742 15.3232 9.26254 15.3232 8.96965 15.0303C8.67676 14.7374 8.67676 14.2625 8.96965 13.9697L10.9393 12L8.96963 10.0303C8.67673 9.73742 8.67673 9.26254 8.96963 8.96965Z" fill="#ffffff"/></svg>]],

                    16, 16

                )

            },

            

            render = function(self, x, y, w, h, radius, type, color, icon_color)

                local ix, iy, iw, ih = math.floor(x), math.floor(y), math.floor(w), math.floor(h)

                local iradius = math.floor(math.min(radius, iw / 2, ih / 2))

                

                local r, g, b, alpha = unpack(color)

                

                renderer.rectangle(ix + iradius, iy + iradius, iw - iradius * 2, ih - iradius * 2, r, g, b, alpha)

                

                renderer.rectangle(ix, iy + iradius, iradius, ih - iradius * 2, r, g, b, alpha)

                renderer.rectangle(ix + iw - iradius, iy + iradius, iradius, ih - iradius * 2, r, g, b, alpha)

                

                renderer.rectangle(ix + iradius, iy, iw - iradius * 2, iradius, r, g, b, alpha)

                renderer.rectangle(ix + iradius, iy + ih - iradius, iw - iradius * 2, iradius, r, g, b, alpha)

                

                renderer.circle(ix + iradius, iy + iradius, r, g, b, alpha, iradius, 180, 0.25)

                renderer.circle(ix + iw - iradius, iy + iradius, r, g, b, alpha, iradius, 90, 0.25)

                renderer.circle(ix + iw - iradius, iy + ih - iradius, r, g, b, alpha, iradius, 0, 0.25)

                renderer.circle(ix + iradius, iy + ih - iradius, r, g, b, alpha, iradius, -90, 0.25)

                

                local icon = self._icons[type] or self._icons.info

                local r_icon = icon_color[1] or 255

                local g_icon = icon_color[2] or 255

                local b_icon = icon_color[3] or 255

                local a_icon = icon_color[4] or alpha

                renderer.texture(icon, ix + 6, iy + 5, 16, 16, r_icon, g_icon, b_icon, a_icon)

            end,       

        },



        notifications = {

            config = {

                max_items = 5,

                lifetime = 3,

                corner_radius = 8,

                bg_color = Class.util.accent_color.background,

                placeholder = "notifications will start appearing here",

                padding = {vertical = 7, left = 7, right = 7, text = 4},

                icon_size = 16,

                animation = {fade = 0.045, scale = 0.25, step = 30},

                offset = 15

            },



            window = nil,

            items = {},

            alpha = 0,

            placeholder_alpha = 0,



            is_active = function(self)

                local logger = Class.ui.menu.misc_tab.info_logger

                return logger.enabled:get() and logger.triggers:get("On Screen")

            end,



            setup = function(self)

                self.window = windows.new("notifications", 0.5, 0.75)

                self.window:set_anchor(vector(0.5, 0))

                self.items = {}

                self.placeholder_alpha = 0

            end,

            parse_colors = function(self, text, accent_color)

                if type(text) ~= "string" then return "" end

                

                local accent_hex = string.format("%02X%02X%02XFF", 

                    math.floor(accent_color[1]), 

                    math.floor(accent_color[2]), 

                    math.floor(accent_color[3])

                )

                local default_hex = "F5F5F5FF"

                

                text = text:gsub("/v", "\a" .. accent_hex)

                        :gsub("/r", "\a" .. default_hex)

                

                return text

            end,



            push = function(self, text, notif_type, color, bg_color)

                if not self:is_active() then return end

                

                color = color or {255, 255, 255, 255}

                bg_color = bg_color or self.config.bg_color

                

                if type(color) ~= "table" then color = {255, 255, 255, 255} end

                if type(bg_color) ~= "table" then bg_color = self.config.bg_color end

                

                local processed_text = self:parse_colors(text, color)

                

                table.insert(self.items, 1, {

                    time = globals.curtime(),

                    text = processed_text,

                    color = color,

                    bg_color = bg_color,

                    type = notif_type or "info",

                    opacity = 0,

                    scale = 0,

                    width = 0,

                    height = 0

                })

                

                if #self.items > self.config.max_items then

                    table.remove(self.items)

                end

            end,



            clear = function(self)

                self.items = {}

            end,



            get_text_size = function(self, item)

                if item.width == 0 then

                    local clean = item.text:gsub("\a%x%x%x%x%x%x%x%x", "")

                    item.width, item.height = renderer.measure_text("", clean .. " ")

                end

                return item.width, item.height

            end,



            render_placeholder = function(self, pos, size, alpha)

                local a = math.floor(alpha * 255)

                Class.render.rounded_rect(pos.x, pos.y, size.x, size.y, self.config.corner_radius, {0, 0, 0, math.floor(150 * alpha)})

                renderer.text(pos.x + size.x / 2, pos.y + size.y / 2, 225, 225, 225, a, "c", 0, self.config.placeholder)

            end,



            format_text_with_alpha = function(self, text, default_color, target_alpha)

                target_alpha = tonumber(target_alpha) or 0

                

                if not text:find("\a") then

                    return string.format("\a%02X%02X%02X%02X%s", 

                        math.floor(default_color[1]),

                        math.floor(default_color[2]),

                        math.floor(default_color[3]),

                        target_alpha,

                        text

                    )

                else

                    return text:gsub("\a(%x%x)(%x%x)(%x%x)FF", 

                        function(cr, cg, cb)

                            return string.format("\a%s%s%s%02X", cr, cg, cb, target_alpha)

                        end)

                end

            end,



            render = function(self)

                self.alpha = Class.motion.interpolation(self.alpha, self:is_active() and 1 or 0, self.config.animation.fade)

                if self.alpha <= 0.01 then return end

                

                local window = self.window

                local pos = window.pos:clone()

                local size = window.size:clone()

                local window_center_x = pos.x + size.x / 2

                

                local cfg = self.config

                

                local is_menu_open = ui.is_menu_open()

                local show_placeholder = is_menu_open and self:is_active()

                self.placeholder_alpha = Class.motion.interpolation(self.placeholder_alpha, show_placeholder and 1 or 0, cfg.animation.fade)

                

                if self.placeholder_alpha > 0.01 then

                    self:render_placeholder(pos, size, self.placeholder_alpha)

                end

                

                if #self.items > 0 then

                    local screen_h = select(2, client.screen_size())

                    local time = globals.curtime()

                    local y_start = pos.y + (pos.y > screen_h / 2 and -cfg.offset or size.y + cfg.offset)

                    local step = pos.y > screen_h / 2 and -cfg.animation.step or cfg.animation.step

                    

                    for i = 1, #self.items do

                        local item = self.items[i]

                        local time_left = item.time + cfg.lifetime - time

                        

                        local target = time_left > 0 and 1 or 0

                        item.opacity = tonumber(Class.motion.exponential_smooth(item.opacity, target, cfg.animation.scale)) or 0

                        item.scale = tonumber(Class.motion.exponential_smooth(item.scale, target, cfg.animation.scale)) or 0

                        

                        if item.opacity > 0.01 then

                            local w, h = self:get_text_size(item)

                            local pad = cfg.padding

                            local content_w = w + pad.left + cfg.icon_size + pad.text + pad.right

                            local bg_w = content_w * item.scale

                            local bg_h = 26 

                            

                            local bg_y = y_start + (i - 1) * step - bg_h / 2

                            local bg_x = window_center_x - bg_w / 2

                            

                            local bg_a = math.floor(item.bg_color[4] * item.opacity * self.alpha)

                            

                            local icon_color = {

                                item.color[1], 

                                item.color[2], 

                                item.color[3], 

                                bg_a

                            }

                            

                            Class.render.panels:render(

                                bg_x, 

                                bg_y, 

                                bg_w, 

                                bg_h, 

                                cfg.corner_radius, 

                                item.type, 

                                {item.bg_color[1], item.bg_color[2], item.bg_color[3], bg_a},

                                icon_color

                            )

                            

                            if item.scale > 0.01 then

                                local animated_alpha = math.floor(255 * item.opacity * self.alpha)

                                local left_margin = pad.left + cfg.icon_size + pad.text

                                local available_w = bg_w - left_margin - pad.right

                                local text_x = bg_x + left_margin + (available_w - w * item.scale) / 2

                                local text_y = math.floor(bg_y + (bg_h - item.height) / 2)

                                

                                local formatted = self:format_text_with_alpha(item.text, item.color, animated_alpha)

                                renderer.text(math.floor(text_x), text_y, 255, 255, 255, animated_alpha, "", available_w, formatted)

                            end

                        end

                    end

                end

                

                local i = 1

                while i <= #self.items do

                    local item = self.items[i]

                    if globals.curtime() - item.time > cfg.lifetime and item.opacity < 0.01 then

                        table.remove(self.items, i)

                    else

                        i = i + 1

                    end

                end

                

                window:set_size(vector(225, 30))

                window:update()

            end

        }

    }    



    local function utf8_chars(str)

        local chars = {}

        local i = 1

        while i <= #str do

            local byte = str:byte(i)

            local char_len

            

            if byte < 128 then

                char_len = 1 

            elseif byte < 224 then

                char_len = 2  

            elseif byte < 240 then

                char_len = 3 

            else

                char_len = 4 

            end

            

            table.insert(chars, str:sub(i, i + char_len - 1))

            i = i + char_len

        end

        return chars

    end



    Class.render.gradient_text = function(string, speed, direction, r, g, b, a, r2, g2, b2, a2)

        local t_out, t_out_iter = {}, 1

        

        local r_add = (r2 - r)

        local g_add = (g2 - g)

        local b_add = (b2 - b)

        local a_add = (a2 - a)

        

        local chars = utf8_chars(string)

        local len = #chars

        

        for i = 1, len do

            local progress = (i - 1) / math.max(len - 1, 1)

            

            local iter = progress + globals.curtime() * speed * (direction == 1 and -1 or 1)

            

            local color_factor = math.abs(math.cos(iter))

            local current_r = r + r_add * color_factor

            local current_g = g + g_add * color_factor

            local current_b = b + b_add * color_factor

            local current_a = a + a_add * color_factor

            

            t_out[t_out_iter] = "\a" .. Class.util:rgba_to_hex(current_r, current_g, current_b, current_a)

            t_out[t_out_iter + 1] = chars[i]

            

            t_out_iter = t_out_iter + 2

        end

        

        return table.concat(t_out)

    end



    Class.render.rainbow_text = function(string, speed, direction, a, saturation)

        local chars = utf8_chars(string)

        local t_out, t_out_iter = {}, 1

        local len = #chars

        

        saturation = saturation or 1.0

        

        saturation = math.max(0, math.min(1, saturation))



        for i = 1, len do

            local progress = (i - 1) / math.max(len - 1, 1)

            

            local time_offset = globals.curtime() * speed * (direction == 1 and -1 or 1)

            

            local hue = (progress + time_offset) * 360

            hue = hue % 360

            

            local h = hue / 60

            local c = (1 - math.abs(2 * 0.5 - 1)) * saturation 

            local x = c * (1 - math.abs(h % 2 - 1))

            local m = 0.5 - c / 2 

            

            local r, g, b

            if h < 1 then

                r, g, b = c, x, 0

            elseif h < 2 then

                r, g, b = x, c, 0

            elseif h < 3 then

                r, g, b = 0, c, x

            elseif h < 4 then

                r, g, b = 0, x, c

            elseif h < 5 then

                r, g, b = x, 0, c

            else

                r, g, b = c, 0, x

            end

            

            r = math.floor((r + m) * 255 + 0.5)

            g = math.floor((g + m) * 255 + 0.5)

            b = math.floor((b + m) * 255 + 0.5)

            

            t_out[t_out_iter] = "\a" .. string.format("%02X%02X%02X%02X", r, g, b, a)

            t_out[t_out_iter + 1] = chars[i]  

            t_out_iter = t_out_iter + 2

        end



        return table.concat(t_out)

    end



    Class.render.rounded_rect = function(x, y, w, h, radius, color)

        x = math.floor(x)

        y = math.floor(y)

        w = math.floor(w)

        h = math.floor(h)

        radius = math.floor(math.min(radius, w/2, h/2))

        

        local r, g, b, a = unpack(color)

        

        -- center

        renderer.rectangle(x + radius, y + radius, w - radius*2, h - radius*2, r, g, b, a)

        

        -- sides

        renderer.rectangle(x, y + radius, radius, h - radius*2, r, g, b, a)

        renderer.rectangle(x + w - radius, y + radius, radius, h - radius*2, r, g, b, a)

        

        -- bottom and upper

        renderer.rectangle(x + radius, y, w - radius*2, radius, r, g, b, a)

        renderer.rectangle(x + radius, y + h - radius, w - radius*2, radius, r, g, b, a)

        

        -- corners

        renderer.circle(x + radius, y + radius, r, g, b, a, radius, 180, 0.25)

        renderer.circle(x + w - radius, y + radius, r, g, b, a, radius, 90, 0.25)

        renderer.circle(x + w - radius, y + h - radius, r, g, b, a, radius, 0, 0.25)

        renderer.circle(x + radius, y + h - radius, r, g, b, a, radius, -90, 0.25)

    end



    Class.render.rounded_rect_outline = function(x, y, w, h, radius, thickness, fill_color, outline_color)

        x = math.floor(x)

        y = math.floor(y)

        w = math.floor(w)

        h = math.floor(h)

        radius = math.floor(math.min(radius, w/2, h/2))

        thickness = math.floor(thickness)

        

        local fr, fg, fb, fa = unpack(fill_color)



        renderer.rectangle(x, y, w, h, fr, fg, fb, fa)

        renderer.circle(x + radius, y + radius, fr, fg, fb, fa, radius, 180, 0.25)

        renderer.circle(x + radius, y + h - radius, fr, fg, fb, fa, radius, 90, 0.25)

        renderer.circle(x + w - radius, y + radius, fr, fg, fb, fa, radius, -90, 0.25)

        renderer.circle(x + w - radius, y + h - radius, fr, fg, fb, fa, radius, 0, 0.25)

    

        local r, g, b, a = unpack(outline_color)

        

        renderer.rectangle(x + radius, y, w - radius*2, thickness, r, g, b, a)

        renderer.rectangle(x + radius, y + h - thickness, w - radius*2, thickness, r, g, b, a)

        

        renderer.rectangle(x, y + radius, thickness, h - radius*2, r, g, b, a)

        renderer.rectangle(x + w - thickness, y + radius, thickness, h - radius*2, r, g, b, a)

        

        renderer.circle_outline(x + radius, y + radius, r, g, b, a, radius, 180, 0.25, thickness)

        renderer.circle_outline(x + radius, y + h - radius, r, g, b, a, radius, 90, 0.25, thickness)

        renderer.circle_outline(x + w - radius, y + radius, r, g, b, a, radius, -90, 0.25, thickness)

        renderer.circle_outline(x + w - radius, y + h - radius, r, g, b, a, radius, 0, 0.25, thickness)

    end

end

       

do          -- @ region motion     



    local function linear(t, b, c, d)

        return c * t / d + b

    end



    local function get_deltatime()

        return globals.frametime()

    end



    local function solve(easing_fn, prev, new, clock, duration)

    if clock <= 0 then return new end

        if clock >= duration then return new end



        prev = easing_fn(clock, prev, new - prev, duration)



        if type(prev) == "number" then

            if math.abs(new - prev) < 0.001 then

                return new

            end



        local remainder = math.fmod(prev, 1.0)



            if remainder < 0.001 then

                return math.floor(prev)

            end



            if remainder > 0.999 then

                return math.ceil(prev)

            end

        end



        return prev

    end



    Class.motion.exponential_smooth = function(current, target, factor)

        factor = factor or 0.15

        local delta_time = globals.frametime() 



        local time_factor = 1 - math.exp(-factor * delta_time * 60)

        

        return current + (target - current) * time_factor

    end



    Class.motion.interpolation = function(a, b, t, easing_fn)

        easing_fn = easing_fn or linear



        if type(b) == "boolean" then

            b = b and 1 or 0

        end



        return solve(easing_fn, a, b, get_deltatime(), t)

    end

end



do          -- @ region ui



    local r, g, b, a = Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], Class.util.accent_color.first[4]

    local r2, g2, b2, a2 = Class.util.accent_color.second[1], Class.util.accent_color.second[2], Class.util.accent_color.second[3], Class.util.accent_color.second[4]

    

    pui.accent = Class.util:rgba_to_hex(r, g, b, a)

    pui.macros.dot = "\a4b4b4bff•\r"

    pui.macros.separator = "\a4b4b4bff──────────────────────────\r"

    pui.macros.tilde = "\v~\r"

    pui.macros.builder_team_t = "\v「T」\r"

    pui.macros.builder_team_ct = "\v「CT」\r"

    pui.macros.home = string.format("\a%s\aC8C8C8FF", pui.accent)

    pui.macros.ragebot = string.format("\a%s\aC8C8C8FF", pui.accent)

    pui.macros.antiaim = string.format("\a%s\aC8C8C8FF", pui.accent)

    pui.macros.visuals = string.format("\a%s✨\aC8C8C8FF", pui.accent)

    pui.macros.misc = string.format("\a%s\aC8C8C8FF", pui.accent)

    pui.macros.config = string.format("\a%s\aC8C8C8FF", pui.accent)

    pui.macros.antiaim_builder = string.format("\a%s\aC8C8C8FF", pui.accent)

    pui.macros.antiaim_other = string.format("\a%s\aC8C8C8FF", pui.accent)

    pui.macros.visuals_interface = string.format("\a%s\aC8C8C8FF", pui.accent)

    pui.macros.visuals_other = string.format("\a%s\aC8C8C8FF", pui.accent)



    Class.ui.antiaim_states_t = {}

    Class.ui.antiaim_states_ct = {}

    local antiaim_states = {"Shared", "Standing", "Running", "Slow-Motion", "Aerobic", "Aerobic+", "Crouching", "Sneaking"}

    local antiaim_team_states = {"Terrorist", "Counter-Terrorist"}

    local antiaim_different = {"", " ", "  ", "   ", "    ", "     ", "      ", "       ", "        "}



    local main_group = pui.group("aa", "anti-aimbot angles")

    local fakelag_group = pui.group("aa", "fake lag")



    local title_phrases = {

        "Beyond the Ordinary.",

        "Elevate Your Experience.",

        "The Unseen Advantage.", 

        "Where Style Meets Skill.",

        "The Essence of Excellence.",

        "The Fifth Dimension.",       

        "Elegance in Execution.",

        "Conquer in Style."

    }



    local watermark_phrases = {

        {

            text = "prefix=+ \\ - amethyst anti-aim technologies body=[debug]",

            settings = {

                mode = "custom",

                color_mode = 2,

                font = "Default",

                gradient = {

                    prefix = {r=255, g=255, b=255, a=226},

                    first = {r=64, g=64, b=64, a=202},

                    second = {r=255, g=255, b=255, a=226},

                    postfix = {r=238, g=104, b=104, a=255},

                    speed = 15,

                    direction = 1

                },

            }

        },

        {

            text = "body=NYANZA postfix=[MEOW]",

            settings = {

                mode = "custom",

                color_mode = 2,

                font = "Default",

                gradient = {

                    prefix = {r=174, g=174, b=226, a=255},

                    first = {r=86, g=78, b=65, a=255},

                    second = {r=198, g=161, b=95, a=255},

                    postfix = {r=188, g=100, b=88, a=255},

                    speed = 45,

                    direction = 2

                },

            }

        },

        {

            text = "mellstroy.game",

            settings = {

                mode = "custom",

                color_mode = 3,

                font = "Bold",

                rainbow = {

                    speed = 15,

                    saturation = 7,

                    direction = 1

                },

            }

        },

        {

            text = "prefix=L U A body=S E N S E postfix=[BETA]	",

            settings = {

                mode = "custom",

                color_mode = 2,

                font = "Default",

                gradient = {

                    prefix = {r=198, g=238, b=98, a=255},

                    first = {r=81, g=81, b=81, a=255},

                    second = {r=255, g=255, b=255, a=226},

                    postfix = {r=238, g=104, b=104, a=255},

                    speed = 15,

                    direction = 1

                },

            }

        },

        {

            text = "★ ｡˚ ☁︎ ˚｡ ★ ｡˚☽˚｡ ★",

            settings = {

                mode = "custom",

                color_mode = 2,

                font = "Default",

                gradient = {

                    prefix = {r=255, g=255, b=255, a=197},

                    first = {r=163, g=160, b=219, a=255},

                    second = {r=135, g=177, b=193, a=255},

                    postfix = {r=255, g=255, b=255, a=255},

                    speed = 16,

                    direction = 2

                },

            },

            {

                text = "contract.gosuslugi.ru",

                settings = {

                    mode = "custom",

                    color_mode = 3,

                    font = "Default",

                    rainbow = {

                        speed = 9,

                        saturation = 10,

                        direction = 1

                    },

                }

            }            

        },

        {

            text = "аренда вацап (звони) +380630078058042",

            settings = {

                mode = "custom",

                color_mode = 3,

                font = "Bold",

                rainbow = {

                    speed = 10,

                    saturation = 9,

                    direction = 1

                },

            }

        },

        {

            text = "body=H E R C U L E S postfix=[OUTDATED]",

            settings = {

                mode = "custom",

                color_mode = 2,

                font = "Default",

                gradient = {

                    prefix = {r=198, g=238, b=98, a=255},

                    first = {r=81, g=81, b=81, a=255},

                    second = {r=255, g=255, b=255, a=226},

                    postfix = {r=238, g=104, b=104, a=255},

                    speed = 15,

                    direction = 1

                },

            }

        },

        {

            text = "prefix=Е_с_Т_ь_body=_К_т_О__Р_у_postfix=С_с_К_и_Й",

            settings = {

                mode = "custom",

                color_mode = 2,

                font = "Bold",

                gradient = {

                    prefix = {r=255, g=255, b=255, a=255},

                    first = {r=103, g=108, b=227, a=255},

                    second = {r=103, g=108, b=227, a=255},

                    postfix = {r=238, g=104, b=104, a=255},

                    speed = 15,

                    direction = 1

                },

            }

        },

        {

            text = "главный инжир аэропорта",

            settings = {

                mode = "custom",

                color_mode = 3,

                font = "Bold",

                rainbow = {

                    speed = 11,

                    saturation = 9,

                    direction = 1

                },

            }

        },

        {

            text = "glace/arrêt",

            settings = {

                mode = "custom",

                color_mode = 1,

                font = "Bold",

                default_color = {r=172, g=182, b=229, a=255},

            }

        },

        {

            text = "prefix=3umph | •body= ıllılıllılıllı postfix=• 1:57",

            settings = {

                mode = "custom",

                color_mode = 2,

                font = "Bold",

                gradient = {

                    prefix = {r=174, g=174, b=226, a=255},

                    first = {r=174, g=221, b=226, a=255},

                    second = {r=174, g=174, b=226, a=255},

                    postfix = {r=174, g=174, b=226, a=255},

                    speed = 13,

                    direction = 2

                },

            }

        },

        {

            text = "кто такой Code10 (и почему он Code80)",

            settings = {

                mode = "custom",

                color_mode = 3,

                font = "Default",

                rainbow = {

                    speed = 8,

                    saturation = 6,

                    direction = 1

                },

            }

        },

        {

            text = "Пила: Игра на выживание 18+",

            settings = {

                mode = "custom",

                color_mode = 1,

                font = "Bold",

                default_color = {r=255, g=0, b=0, a=255},

            }

        },   

        {

            text = "artists you should follow",

            settings = {

                mode = "custom",

                color_mode = 2,

                font = "Bold",

                gradient = {

                    prefix = {r=174, g=174, b=226, a=255},

                    first = {r=174, g=221, b=226, a=255},

                    second = {r=229, g=146, b=146, a=255},

                    postfix = {r=174, g=174, b=226, a=255},

                    speed = 13,

                    direction = 2

                },

            }

        }, 

        {

            text = "https://unmatched.gg/lobby/8716-88c9-7249d103a/join",

            settings = {

                mode = "custom",

                color_mode = 3,

                font = "Bold",

                rainbow = {

                    speed = 25,

                    saturation = 10,

                    direction = 2

                },

            }

        },

        {

            text = "amethyst",

            settings = {

                mode = "custom",

                color_mode = 2,

                font = "Bold",

                gradient = {

                    prefix = {r=198, g=238, b=98, a=255},

                    first = {r=255, g=255, b=255, a=163},

                    second = {r=255, g=255, b=255, a=109},

                    postfix = {r=238, g=104, b=104, a=255},

                    speed = 15,

                    direction = 1

                },

            }

        },

        {

            text = "nyanza.meow",

            settings = {

                mode = "custom",

                color_mode = 1,

                font = "Default",

                default_color = {r=255, g=255, b=255, a=224},

            }

        },  

        {

            text = "Satoshi Nakamoto",

            settings = {

                mode = "custom",

                color_mode = 1,

                font = "Bold",

                default_color = {r=213, g=234, b=251, a=224},

            }

        },

        {

            text = "prefix=фото пяток - body=t.me/renderers",

            settings = {

                mode = "custom",

                color_mode = 2,

                font = "Bold",

                gradient = {

                    prefix = {r=182, g=190, b=204, a=255},

                    first = {r=227, g=200, b=223, a=255},

                    second = {r=182, g=190, b=204, a=255},

                    postfix = {r=238, g=104, b=104, a=255},

                    speed = 15,

                    direction = 1

                },

            }

        },

        {

            text = "Nightz: ep.1: \"Enlightenment I, Act I\"",

            settings = {

                mode = "custom",

                color_mode = 1,

                font = "Default",

                default_color = {r=207, g=191, b=215, a=224},

            }

        },   

        {

            text = "ANGELWINGS.PINK",

            settings = {

                mode = "custom",

                color_mode = 1,

                font = "Pixel",

                default_color = {r=230, g=204, b=255, a=255},

            }

        }, 

        {

            text = "★·.·´¯`·.·★  a m e t h y s t  ★·.·´¯`·.·★",

            settings = {

                mode = "custom",

                color_mode = 1,

                font = "Bold",

                default_color = {r=230, g=204, b=255, a=255},

            }

        },

        {

            text = "kr0v0pr0l1t1e",

            settings = {

                mode = "custom",

                color_mode = 1,

                font = "Bold",

                default_color = {r=255, g=50, b=50, a=255},

            }

        }, 

        {

            text = "iplogger.org/private-note",

            settings = {

                mode = "custom",

                color_mode = 3,

                font = "Bold",

                rainbow = {

                    speed = 5,

                    saturation = 5,

                    direction = 1

                },

            }

        },

        {

            text = "5v5 Tournament Registration Open! (www.indianhvh.club)",

            settings = {

                mode = "custom",

                color_mode = 1,

                font = "Large",

                default_color = {r=255, g=255, b=255, a=255},

            }

        },        

        {

            text = "веселый роджер"

        },

        {

            text = "ceo@vkontakte.ru"

        },

        {

            text = "≽^•⩊•^≼"

        },    

        {

            text = "「 ✦ A M E T H Y S T ✦ 」"

        },   

        {

            text = "° •★ cчастье_снова_в_моде ★• °"

        },

        {

            text = "★·.·´ＡＭＥＴＨＹＳＴ`·.·★"

        },    

        {

            text = "I'm a sink (я кран)"

        },   

        {

            text = "_*очень приятно царь*_"

        },

        {

            text = "БытьРомантикомАфигенно"

        }

    }



    current_title_phrase = title_phrases[math.random(1, #title_phrases)]

    

    function Class.ui.set_current_watermark_phrase()

        local template = watermark_phrases[math.random(1, #watermark_phrases)]

        

        Class.ui.menu.visuals_tab.interface.watermark.text:set(template.text)

        

        if template.settings then

            local settings = template.settings

            

            if settings.mode then

                Class.ui.menu.visuals_tab.interface.watermark.mode:set(settings.mode)

            end

            

            if settings.font then

                Class.ui.menu.visuals_tab.interface.watermark.font:set(settings.font)

            end

            

            if settings.color_mode then

                Class.ui.menu.visuals_tab.interface.watermark.color_mode:set(settings.color_mode)

            end

            

            if settings.default_color then

                local c = settings.default_color

                Class.ui.menu.visuals_tab.interface.watermark.default.color:set(c.r, c.g, c.b, c.a)

            end

            

            if settings.gradient then

                local g = settings.gradient

                if g.prefix then

                    Class.ui.menu.visuals_tab.interface.watermark.gradient.color.prefix:set(g.prefix.r, g.prefix.g, g.prefix.b, g.prefix.a)

                end

                if g.first then

                    Class.ui.menu.visuals_tab.interface.watermark.gradient.color.first:set(g.first.r, g.first.g, g.first.b, g.first.a)

                end

                if g.second then

                    Class.ui.menu.visuals_tab.interface.watermark.gradient.color.second:set(g.second.r, g.second.g, g.second.b, g.second.a)

                end

                if g.postfix then

                    Class.ui.menu.visuals_tab.interface.watermark.gradient.color.postfix:set(g.postfix.r, g.postfix.g, g.postfix.b, g.postfix.a)

                end

                if g.speed then

                    Class.ui.menu.visuals_tab.interface.watermark.gradient.speed:set(g.speed)

                end

                if g.direction then

                    Class.ui.menu.visuals_tab.interface.watermark.gradient.direction:set(g.direction)

                end

            end

            

            if settings.rainbow then

                local r = settings.rainbow

                if r.speed then

                    Class.ui.menu.visuals_tab.interface.watermark.rainbow.speed:set(r.speed)

                end

                if r.saturation then

                    Class.ui.menu.visuals_tab.interface.watermark.rainbow.saturation:set(r.saturation)

                end

                if r.direction then

                    Class.ui.menu.visuals_tab.interface.watermark.rainbow.direction:set(r.direction)

                end

            end

        end

    end



    function Class.ui.set_watermark_phrase_from_console(text)

        if #text < 5 then

            return

        end

        

        if text:sub(1, 5) == "/set " then

            Class.ui.menu.visuals_tab.interface.watermark.text:set(text:sub(6))

        end

    end



    local function output_guide_to_console()

        local guide = {

            { text = "amethyst: ", color = {r, g, b} },

            { text = "Instructions for using watermark:\n\n", color = {225, 225, 225} },

            { text = "COPY", color = {r, g, b} },

            { text = " - prefix=L U A body=S E N S E postfix=[BETA]\n", color = {225, 225, 225} },

            { text = "COPY", color = {r, g, b} },

            { text = " - body=NYANZA postfix=[MEOW]\n\n", color = {225, 225, 225} },            

            { text = "prefix", color = {r, g, b} },

            { text = " - first color\n", color = {225, 225, 225} },

            { text = "body", color = {r, g, b} },

            { text = " - second and third color\n", color = {225, 225, 225} },  

            { text = "postfix", color = {r, g, b} },

            { text = " - fourth color\n\n", color = {225, 225, 225} },      

            { text = "You can also use", color = {225, 225, 225} },

            { text = " /set <text>\n", color = {r, g, b} },                      

        }



        Class.util.output_message(guide)

    end



    function Class.ui.setup_menu()

        Class.util:setup_menu_color()

        Class.ui.set_current_watermark_phrase()

        ui.set(Class.util.reference.aa_enabled, true)

        ui.set(Class.util.reference.aa_fs_body_yaw, false)

    end



    function Class.ui.update_menu()

        if not ui.is_menu_open() then return end

        Class.util:hide_menu(false)

        Class.ui.menu.antiaim_tab.other.hotkey.manual_forward:set("On Hotkey")

        Class.ui.menu.antiaim_tab.other.hotkey.manual_left:set("On Hotkey")

        Class.ui.menu.antiaim_tab.other.hotkey.manual_right:set("On Hotkey")

        Class.ui.menu.home_tab.title:set(Class.render.gradient_text(user_database.lua_name, 1.5, 2, r2, g2, b2, a2, r, g, b, a) .. string.format(" %s %s", pui.macros.dot, current_title_phrase))

        Class.ui.menu.home_tab.info.users_online:set(string.format("\f<dot> Users Online ~ \v%s\r", _G.online_users))

    end



    -- maybe

    function Class.ui.export_watermark_settings()

        local text = Class.ui.menu.visuals_tab.interface.watermark.text:get()

        local mode = Class.ui.menu.visuals_tab.interface.watermark.mode:get()

        local result = "{\n    text = " .. string.format("%q", text)

        

        if mode == "Custom" then

            local color_mode = Class.ui.menu.visuals_tab.interface.watermark.color_mode:get()

            local font = Class.ui.menu.visuals_tab.interface.watermark.font:get()

            

            result = result .. ",\n    settings = {\n"

            result = result .. "        mode = \"custom\",\n"

            result = result .. "        color_mode = " .. color_mode .. ",\n"

            result = result .. "        font = \"" .. font .. "\",\n"

            

            if color_mode == 1 then

                local r, g, b, a = Class.ui.menu.visuals_tab.interface.watermark.default.color:get()

                result = result .. "        default_color = {r=" .. r .. ", g=" .. g .. ", b=" .. b .. ", a=" .. a .. "},\n"

            elseif color_mode == 2 then

                local prefix_r, prefix_g, prefix_b, prefix_a = Class.ui.menu.visuals_tab.interface.watermark.gradient.color.prefix:get()

                local first_r, first_g, first_b, first_a = Class.ui.menu.visuals_tab.interface.watermark.gradient.color.first:get()

                local second_r, second_g, second_b, second_a = Class.ui.menu.visuals_tab.interface.watermark.gradient.color.second:get()

                local postfix_r, postfix_g, postfix_b, postfix_a = Class.ui.menu.visuals_tab.interface.watermark.gradient.color.postfix:get()

                local speed = Class.ui.menu.visuals_tab.interface.watermark.gradient.speed:get()

                local direction = Class.ui.menu.visuals_tab.interface.watermark.gradient.direction:get()

                

                result = result .. "        gradient = {\n"

                result = result .. "            prefix = {r=" .. prefix_r .. ", g=" .. prefix_g .. ", b=" .. prefix_b .. ", a=" .. prefix_a .. "},\n"

                result = result .. "            first = {r=" .. first_r .. ", g=" .. first_g .. ", b=" .. first_b .. ", a=" .. first_a .. "},\n"

                result = result .. "            second = {r=" .. second_r .. ", g=" .. second_g .. ", b=" .. second_b .. ", a=" .. second_a .. "},\n"

                result = result .. "            postfix = {r=" .. postfix_r .. ", g=" .. postfix_g .. ", b=" .. postfix_b .. ", a=" .. postfix_a .. "},\n"

                result = result .. "            speed = " .. speed .. ",\n"

                result = result .. "            direction = " .. direction .. "\n"

                result = result .. "        },\n"

            elseif color_mode == 3 then

                local speed = Class.ui.menu.visuals_tab.interface.watermark.rainbow.speed:get()

                local saturation = Class.ui.menu.visuals_tab.interface.watermark.rainbow.saturation:get()

                local direction = Class.ui.menu.visuals_tab.interface.watermark.rainbow.direction:get()

                

                result = result .. "        rainbow = {\n"

                result = result .. "            speed = " .. speed .. ",\n"

                result = result .. "            saturation = " .. saturation .. ",\n"

                result = result .. "            direction = " .. direction .. "\n"

                result = result .. "        },\n"

            end

            

            result = result .. "    }"

        end

        

        result = result .. "\n}"

        print(result)

    end



    Class.ui.menu = {

        home_tab = {

            title = main_group:label(user_database.lua_name),



            selected_tab = {

                default = main_group:combobox("\n default_tab", string.format("%s Home", pui.macros.home), string.format("%s Ragebot", pui.macros.ragebot), string.format("%s Anti-Aimbot", pui.macros.antiaim), string.format("%s Visuals", pui.macros.visuals), string.format("%s Misc", pui.macros.misc), string.format("%s Config", pui.macros.config)),

                antiaim = main_group:combobox("\n antiaim_tab", string.format("%s Builder", pui.macros.antiaim_builder), string.format("%s Other", pui.macros.antiaim_other)),

                visuals = main_group:combobox("\n visuals_tab", string.format("%s Interface", pui.macros.visuals_interface), string.format("%s Other", pui.macros.visuals_other)),

                separator = main_group:label(pui.macros.separator),

            },



            info = {

                user = main_group:label(string.format("\f<dot> User ~ \v%s\r", user_database.username)),

                branch = main_group:label(string.format("\f<dot> Branch ~ \v%s\r", user_database.branch)),

                version = main_group:label(string.format("\f<dot> Version ~ \v%s\r", user_database.update_date)),

                users_online = main_group:label("\f<dot> Users Online ~ \v0\r"),

                separator = main_group:label(pui.macros.separator),

            },



            network = {

                choose = main_group:combobox("\nJoin the Network Choose", "Discord", "Telegram"),

                button = main_group:button("Join the Network", Class.util.join_network),

            }

        },



        ragebot_tab = {

            amethystine_double_tap = {

                enabled = main_group:checkbox("\v⚡\r Amethystine Double Tap"),

            },

            

            hideshots_fix = {

                enabled = main_group:checkbox("\v⚡\r Hideshots Fix"),

            }

        },



        antiaim_tab = {

            builder = {

                select = {

                    condition = main_group:combobox("Customize Condition \v{ ~ }\r", antiaim_states),

                    team = main_group:combobox("\nCustomize Team \v{ ~ }\r", antiaim_team_states),

                },



                separator = main_group:label(pui.macros.separator),

            },



            other = {

                fakelag = {

                    title = fakelag_group:label("Re-generate \vFakelag\r Settings:"),

                    separator = fakelag_group:label(pui.macros.separator),

                    enabled = fakelag_group:checkbox("\f<dot> Enable \vFakelag\r"),

                    amount = fakelag_group:combobox("Amount", "Dynamic", "Maximum", "Fluctuate"),



                    variance = {

                        amount = fakelag_group:slider("Variance", 0, 100, 0, true, "%", 1),

                        randomize = fakelag_group:slider("Variance Randomize", 0, 100, 0, true, "%", 1, {[0] = "Off"}),

                    },



                    limit = fakelag_group:slider("Limit", 1, 15, 14, true, "", 1)

                },



                hotkey = {

                    title = fakelag_group:label("Re-generate \vHotkey\r Settings:"),

                    separator = fakelag_group:label(pui.macros.separator),

                    freestanding = fakelag_group:hotkey("Freestanding ~ \vyaw\r"),

                    manual_forward = fakelag_group:hotkey("Manual ~ \vforward\r"),

                    manual_left = fakelag_group:hotkey("Manual ~ \vleft\r"),

                    manual_right = fakelag_group:hotkey("Manual ~ \vright\r"),

                },



                additional = {

                    select = main_group:multiselect("Anti-Aimbot \f<tilde> Additional", {"Safe Head", "Fast Ladder", "Yaw Modifier", "Avoid Backstab", "Anti-Aimbot Disablers", "Freestanding Disablers"}),



                    safe_head = {

                        states = main_group:multiselect("Safe Head \f<tilde> States", {"Knife", "Taser", "Above enemy"}),       

                        height_difference = main_group:slider("Safe Head \f<tilde> Height difference", 25, 150, 70, true, "u", 1),    

                    },



                    yaw_mode = {

                        freestanding = main_group:slider("Freestanding Yaw \f<tilde> Mode", 1, 3, 1, true, "", 1, {[1] = "Builder", [2] = "Jitter", [3] = "Static"}), 

                        manual = main_group:slider("Manual Yaw \f<tilde> Mode", 1, 3, 1, true, "", 1, {[1] = "Builder", [2] = "Jitter", [3] = "Static"}),

                    },



                    avoid_backstab = {

                        amount = main_group:slider("Avoid \f<tilde> Backstab Amount", 0, 300, 0, true, "u", 1, {[0] = "Disabled"}),

                    },



                    antiaimbot_disablers = {

                        states = main_group:multiselect("Anti-Aimbot Disablers \f<tilde> States", {"On Warmup"}),      

                        speed =  main_group:slider("Anti-Aimbot Disablers \f<tilde> Speed", 0, 100, 5, true, "%", 1),    

                    },



                    freestanding = {

                        disablers_states = main_group:multiselect("Freestanding Yaw \f<tilde> Disablers States", antiaim_states),

                    }

                }

            }

        },



        visuals_tab = {

            interface = {

                watermark = {

                    mode = main_group:combobox("\f<tilde> Watermark", {"Default", "Custom"}),

                    font = main_group:combobox("\f<tilde> Watermark Font", {"Default", "Pixel", "Bold", "Large"}),



                    default_color = main_group:color_picker("\f<tilde> Watermark Color", r, g, b, a),

                    color_mode = main_group:slider("\f<tilde> Watermark Color Mode", 1, 3, 1, true, "", 1, {[1] = "Default", [2] = "Gradient", [3] = "Rainbow"}),

                    

                    default = {

                        color = main_group:color_picker("\f<tilde> Watermark Default Color", r, g, b, a),

                    },



                    gradient = {

                        color = {

                            prefix = main_group:color_picker("\f<tilde> Watermark Gradient Prefix Color", 198, 238, 98, 255),

                            first = main_group:color_picker("\f<tilde> Watermark Gradient First Color", 81, 81, 81, 255),

                            second = main_group:color_picker("\f<tilde> Watermark Gradient Second Color", 255, 255, 255, 255),

                            postfix = main_group:color_picker("\f<tilde> Watermark Gradient Postfix Color", 238, 104, 104, 255),                           

                        },



                        speed = main_group:slider("\f<tilde> Watermark Gradient Speed", 0, 100, 10, true, "%", 1),

                        direction = main_group:slider("\f<tilde> Watermark Gradient Direction", 1, 2, 1, true, "", 1, {[1] = "Right", [2] = "Left"}),

                    },



                    rainbow = {

                        speed = main_group:slider("\f<tilde> Watermark Rainbow Speed", 0, 100, 10, true, "%", 1),

                        saturation = main_group:slider("\f<tilde> Watermark Rainbow Saturation", 0, 10, 10, true, "%", 10),

                        direction = main_group:slider("\f<tilde> Watermark Rainbow Direction", 1, 2, 1, true, "", 1, {[1] = "Right", [2] = "Left"}),

                    },



                    text = main_group:textbox("\f<tilde> Watermark Text"),

                    generate_button = main_group:button("\v[Generate]\r", Class.ui.set_current_watermark_phrase),

                    guide_button = main_group:button("\v[Output Guide To Console]\r", output_guide_to_console),

                    --export_button = main_group:button("\v[Export Settings]\r", Class.ui.export_watermark_settings),

                },



                velocity_indicator = {

                    enabled = main_group:checkbox("\f<tilde> Velocity Indicator"),

                    color = main_group:color_picker("\n\f<tilde> Velocity Indicator Color", r, g, b, a)

                },



                custom_scope = {

                    enabled = main_group:checkbox("\f<tilde> Custom Scope"),

                    color = main_group:color_picker("\n\f<tilde> Custom Scope Color", 255, 255, 255, 200),

                    mode = main_group:slider("\f<tilde> Custom Scope Mode", 1, 2, 1, true, "", 1, {[1] = "Default", [2] = "X"}),



                    offset = {

                        first = main_group:slider("\n\f<tilde> Custom Scope First Offset", 0, 300, 8, true, "px"),

                        second = main_group:slider("\n\f<tilde> Custom Scope Second Offset", 0, 300, 80, true, "px"),

                    }

                },

            },



            other = {

                aspect_ratio = {

                    enabled = main_group:checkbox("\f<tilde> Aspect Ratio"),

                    preset = main_group:slider("\f<tilde> Aspect Ratio Preset", 1, 5, 1, true, "", 1, {[1] = "Disabled", [2] = "5:4", [3] = "4:3", [4] = "16:10", [5] = "16:9"}),

                    amount = main_group:slider("\f<tilde> Aspect Ratio Amount", 1, 200, 100, true, "", 0.01),

                },



                viewmodel_changer = {

                    enabled = main_group:checkbox("\f<tilde> Viewmodel Changer"),

                    fire_animation = main_group:checkbox("\f<tilde> Viewmodel Changer Fire Animation"),

                    knife_reverse = main_group:checkbox("\f<tilde> Viewmodel Changer Knife Reverse"),

                    main_hand = main_group:slider("\f<tilde> Viewmodel Changer Main Hand", 1, 2, 1, true, "", 1, {[1] = "Left", [2] = "Right"}),



                    position = {

                        x = main_group:slider("\n\f<tilde> Viewmodel Changer X Amount", -200, 200, 0, true, "px", 0.1),

                        y = main_group:slider("\n\f<tilde> Viewmodel Changer Y Amount", -200, 200, 0, true, "px", 0.1),

                        z = main_group:slider("\n\f<tilde> Viewmodel Changer Z Amount", -200, 200, 0, true, "px", 0.1),

                    },



                    button = main_group:button("\v[Reset Position]\r", Class.util.reset_viewmodel),

                },



                disable_post_proccesing = {

                    enabled = main_group:checkbox("\f<tilde> Disable Post Proccesing"),

                },



                animation_breaker = {

                    enabled = main_group:checkbox("\f<tilde> Animation Breaker"),

                    triggers = main_group:multiselect("\f<tilde> Animation Breaker Triggers", {"Air", "Ground", "Tweaks"}),



                    air = {

                        mode = main_group:combobox("\f<tilde> Animation Breaker Air", {"Jitter", "Static", "Broken"}),

                        amount = main_group:slider("\n\f<tilde> Animation Breaker Air Amount", 0, 10, 0, true, "%", 10, {[0] = "Disabled", [10] = "Maximum"}),  

                    },



                    ground = {

                        mode = main_group:combobox("\f<tilde> Animation Breaker Ground", {"Jitter", "Static", "Modern", "Broken"}),

                        amount = main_group:slider("\n\f<tilde> Animation Breaker Ground Amount", 0, 10, 0, true, "%", 10, {[0] = "Disabled", [10] = "Maximum"}), 

                    },



                    tweaks = {

                        mode = main_group:multiselect("\f<tilde> Animation Breaker Tweaks", {"Lizginka", "Body Lean", "Earthshake", "Movement On Peek Assist"}),

                        amount = main_group:slider("\n\f<tilde> Animation Breaker Tweaks Amount", 0, 10, 0, true, "%", 10, {[0] = "Disabled", [10] = "Maximum"}),

                    }

                }

            },           

        },



        misc_tab = {

            info_logger = {

                enabled = main_group:checkbox("\f<tilde> Info Logger"),

                color = {

                    hit = main_group:color_picker("\n\f<tilde> Info Logger Hit Color", r, g, b, a),

                    miss = main_group:color_picker("\n\f<tilde> Info Logger Miss Color", 225, 80, 80, 255),

                },

                triggers = main_group:multiselect("\n\f<tilde> Info Logger Triggers", {"Hit", "Miss", "Purchase", "On Screen"}),

            },



            console_enhancement = {

                enabled = main_group:checkbox("\f<tilde> Console Enhancement"),

                mode = main_group:multiselect("\n\f<tilde> Console Enhancement Mode", {"Console Filter", "Clean On Level Init"})

            },



            trash_talk = {

                enabled = main_group:checkbox("\f<tilde> Trash Talk"),

                mode = main_group:combobox("\n\f<tilde> Trash Talk Mode", {"Sponsor", "Ragebait"})

            }

        },



        config_tab = {

            config_title = fakelag_group:label("\f<tilde> Create configuration"),

            list = main_group:listbox('Configs', '', false),

		    name = fakelag_group:textbox('Configuration name', '', false),

            load = main_group:button('Load', function() end),

            save = fakelag_group:button('Save', function() end),

		    delete = main_group:button('Delete', function() end),

		    import = main_group:button('Import from \vclipboard\r', function() end),

		    export = main_group:button('Export to \vclipboard\r', function() end)

        }

    }



    --          @ region depend



    local home_tab_active = {Class.ui.menu.home_tab.selected_tab.default, string.format("%s Home", pui.macros.home)}

    local ragebot_tab_active = {Class.ui.menu.home_tab.selected_tab.default, string.format("%s Ragebot", pui.macros.ragebot)}

    local antiaim_tab_active = {Class.ui.menu.home_tab.selected_tab.default, string.format("%s Anti-Aimbot", pui.macros.antiaim)}

    local visuals_tab_active = {Class.ui.menu.home_tab.selected_tab.default, string.format("%s Visuals", pui.macros.visuals)}

    local misc_tab_active = {Class.ui.menu.home_tab.selected_tab.default, string.format("%s Misc", pui.macros.misc)}

    local config_tab_active = {Class.ui.menu.home_tab.selected_tab.default, string.format("%s Config", pui.macros.config)}

    local fakelag_tab_active = {Class.ui.menu.home_tab.selected_tab.default, string.format("%s Home", pui.macros.home), string.format("%s Ragebot", pui.macros.ragebot), string.format("%s Anti-Aimbot", pui.macros.antiaim), string.format("%s Visuals", pui.macros.visuals), string.format("%s Misc", pui.macros.misc)}



    local antiaim_tab_builder_active = {Class.ui.menu.home_tab.selected_tab.antiaim, string.format("%s Builder", pui.macros.antiaim_builder)}

    local antiaim_tab_other_active = {Class.ui.menu.home_tab.selected_tab.antiaim, string.format("%s Other", pui.macros.antiaim_other)}



    local visuals_tab_interface_active = {Class.ui.menu.home_tab.selected_tab.visuals, string.format("%s Interface", pui.macros.visuals_interface)}

    local visuals_tab_other_active = {Class.ui.menu.home_tab.selected_tab.visuals, string.format("%s Other", pui.macros.visuals_other)}



    Class.ui.menu.home_tab.info.user:depend(home_tab_active)

    Class.ui.menu.home_tab.info.branch:depend(home_tab_active)

    Class.ui.menu.home_tab.info.version:depend(home_tab_active)

    Class.ui.menu.home_tab.info.users_online:depend(home_tab_active)

    Class.ui.menu.home_tab.info.separator:depend(home_tab_active)

    Class.ui.menu.home_tab.network.choose:depend(home_tab_active)

    Class.ui.menu.home_tab.network.button:depend(home_tab_active)



    Class.ui.menu.ragebot_tab.amethystine_double_tap.enabled:depend(ragebot_tab_active)

    Class.ui.menu.ragebot_tab.hideshots_fix.enabled:depend(ragebot_tab_active)



    Class.ui.menu.home_tab.selected_tab.antiaim:depend(antiaim_tab_active)

    Class.ui.menu.antiaim_tab.builder.select.condition:depend(antiaim_tab_active, antiaim_tab_builder_active)

    Class.ui.menu.antiaim_tab.builder.select.team:depend(antiaim_tab_active, antiaim_tab_builder_active)

    Class.ui.menu.antiaim_tab.builder.separator:depend(antiaim_tab_active, antiaim_tab_builder_active)



    Class.ui.menu.antiaim_tab.other.fakelag.title:depend(fakelag_tab_active, antiaim_tab_builder_active)

    Class.ui.menu.antiaim_tab.other.fakelag.separator:depend(fakelag_tab_active, antiaim_tab_builder_active)

    Class.ui.menu.antiaim_tab.other.fakelag.enabled:depend(fakelag_tab_active, antiaim_tab_builder_active)

    Class.ui.menu.antiaim_tab.other.fakelag.amount:depend(fakelag_tab_active, antiaim_tab_builder_active)

    Class.ui.menu.antiaim_tab.other.fakelag.variance.amount:depend(fakelag_tab_active, antiaim_tab_builder_active)

    Class.ui.menu.antiaim_tab.other.fakelag.variance.randomize:depend(fakelag_tab_active, antiaim_tab_builder_active)

    Class.ui.menu.antiaim_tab.other.fakelag.limit:depend(fakelag_tab_active, antiaim_tab_builder_active)



    Class.ui.menu.antiaim_tab.other.hotkey.title:depend(antiaim_tab_active, antiaim_tab_other_active)

    Class.ui.menu.antiaim_tab.other.hotkey.separator:depend(antiaim_tab_active, antiaim_tab_other_active)

    Class.ui.menu.antiaim_tab.other.hotkey.freestanding:depend(antiaim_tab_active, antiaim_tab_other_active)

    Class.ui.menu.antiaim_tab.other.hotkey.manual_forward:depend(antiaim_tab_active, antiaim_tab_other_active)

    Class.ui.menu.antiaim_tab.other.hotkey.manual_left:depend(antiaim_tab_active, antiaim_tab_other_active)

    Class.ui.menu.antiaim_tab.other.hotkey.manual_right:depend(antiaim_tab_active, antiaim_tab_other_active)

    Class.ui.menu.antiaim_tab.other.additional.select:depend(antiaim_tab_active, antiaim_tab_other_active)

    Class.ui.menu.antiaim_tab.other.additional.safe_head.states:depend({Class.ui.menu.antiaim_tab.other.additional.select, "Safe Head"}, antiaim_tab_active, antiaim_tab_other_active)

    Class.ui.menu.antiaim_tab.other.additional.safe_head.height_difference:depend({Class.ui.menu.antiaim_tab.other.additional.select, "Safe Head"}, {Class.ui.menu.antiaim_tab.other.additional.safe_head.states, "Above enemy"}, antiaim_tab_active, antiaim_tab_other_active)    

    Class.ui.menu.antiaim_tab.other.additional.yaw_mode.freestanding:depend({Class.ui.menu.antiaim_tab.other.additional.select, "Yaw Modifier"}, antiaim_tab_active, antiaim_tab_other_active)    

    Class.ui.menu.antiaim_tab.other.additional.yaw_mode.manual:depend({Class.ui.menu.antiaim_tab.other.additional.select, "Yaw Modifier"}, antiaim_tab_active, antiaim_tab_other_active)

    Class.ui.menu.antiaim_tab.other.additional.avoid_backstab.amount:depend({Class.ui.menu.antiaim_tab.other.additional.select, "Avoid Backstab"}, antiaim_tab_active, antiaim_tab_other_active)

    Class.ui.menu.antiaim_tab.other.additional.antiaimbot_disablers.states:depend({Class.ui.menu.antiaim_tab.other.additional.select, "Anti-Aimbot Disablers"}, antiaim_tab_active, antiaim_tab_other_active)

    Class.ui.menu.antiaim_tab.other.additional.antiaimbot_disablers.speed:depend({Class.ui.menu.antiaim_tab.other.additional.select, "Anti-Aimbot Disablers"}, antiaim_tab_active, antiaim_tab_other_active)

    Class.ui.menu.antiaim_tab.other.additional.freestanding.disablers_states:depend({Class.ui.menu.antiaim_tab.other.additional.select, "Freestanding Disablers"}, antiaim_tab_active, antiaim_tab_other_active)



    Class.ui.menu.home_tab.selected_tab.visuals:depend(visuals_tab_active)

    Class.ui.menu.visuals_tab.interface.watermark.mode:depend(visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.watermark.default_color:depend(visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.watermark.default.color:depend({Class.ui.menu.visuals_tab.interface.watermark.mode, "Custom"}, {Class.ui.menu.visuals_tab.interface.watermark.color_mode, 1}, visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.watermark.gradient.color.prefix:depend({Class.ui.menu.visuals_tab.interface.watermark.mode, "Custom"}, {Class.ui.menu.visuals_tab.interface.watermark.color_mode, 2}, visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.watermark.gradient.color.first:depend({Class.ui.menu.visuals_tab.interface.watermark.mode, "Custom"}, {Class.ui.menu.visuals_tab.interface.watermark.color_mode, 2}, visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.watermark.gradient.color.second:depend({Class.ui.menu.visuals_tab.interface.watermark.mode, "Custom"}, {Class.ui.menu.visuals_tab.interface.watermark.color_mode, 2}, visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.watermark.gradient.color.postfix:depend({Class.ui.menu.visuals_tab.interface.watermark.mode, "Custom"}, {Class.ui.menu.visuals_tab.interface.watermark.color_mode, 2}, visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.watermark.font:depend({Class.ui.menu.visuals_tab.interface.watermark.mode, "Custom"}, visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.watermark.color_mode:depend({Class.ui.menu.visuals_tab.interface.watermark.mode, "Custom"}, visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.watermark.gradient.speed:depend({Class.ui.menu.visuals_tab.interface.watermark.mode, "Custom"}, {Class.ui.menu.visuals_tab.interface.watermark.color_mode, 2}, visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.watermark.gradient.direction:depend({Class.ui.menu.visuals_tab.interface.watermark.mode, "Custom"}, {Class.ui.menu.visuals_tab.interface.watermark.color_mode, 2}, visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.watermark.rainbow.speed:depend({Class.ui.menu.visuals_tab.interface.watermark.mode, "Custom"}, {Class.ui.menu.visuals_tab.interface.watermark.color_mode, 3}, visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.watermark.rainbow.saturation:depend({Class.ui.menu.visuals_tab.interface.watermark.mode, "Custom"}, {Class.ui.menu.visuals_tab.interface.watermark.color_mode, 3}, visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.watermark.rainbow.direction:depend({Class.ui.menu.visuals_tab.interface.watermark.mode, "Custom"}, {Class.ui.menu.visuals_tab.interface.watermark.color_mode, 3}, visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.watermark.text:depend({Class.ui.menu.visuals_tab.interface.watermark.mode, "Custom"}, visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.watermark.generate_button:depend({Class.ui.menu.visuals_tab.interface.watermark.mode, "Custom"}, visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.watermark.guide_button:depend({Class.ui.menu.visuals_tab.interface.watermark.mode, "Custom"}, visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.velocity_indicator.enabled:depend(visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.velocity_indicator.color:depend({Class.ui.menu.visuals_tab.interface.velocity_indicator.enabled, true}, visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.custom_scope.enabled:depend(visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.custom_scope.color:depend({Class.ui.menu.visuals_tab.interface.custom_scope.enabled, true}, visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.custom_scope.mode:depend({Class.ui.menu.visuals_tab.interface.custom_scope.enabled, true}, visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.custom_scope.offset.first:depend({Class.ui.menu.visuals_tab.interface.custom_scope.enabled, true}, visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.interface.custom_scope.offset.second:depend({Class.ui.menu.visuals_tab.interface.custom_scope.enabled, true}, visuals_tab_active, visuals_tab_interface_active)

    Class.ui.menu.visuals_tab.other.aspect_ratio.enabled:depend(visuals_tab_active, visuals_tab_other_active)

    Class.ui.menu.visuals_tab.other.aspect_ratio.preset:depend({Class.ui.menu.visuals_tab.other.aspect_ratio.enabled, true}, visuals_tab_active, visuals_tab_other_active)

    Class.ui.menu.visuals_tab.other.aspect_ratio.amount:depend({Class.ui.menu.visuals_tab.other.aspect_ratio.enabled, true}, {Class.ui.menu.visuals_tab.other.aspect_ratio.preset, 1}, visuals_tab_active, visuals_tab_other_active)

    Class.ui.menu.visuals_tab.other.viewmodel_changer.enabled:depend(visuals_tab_active, visuals_tab_other_active)

    Class.ui.menu.visuals_tab.other.viewmodel_changer.fire_animation:depend({Class.ui.menu.visuals_tab.other.viewmodel_changer.enabled, true}, visuals_tab_active, visuals_tab_other_active)

    Class.ui.menu.visuals_tab.other.viewmodel_changer.knife_reverse:depend({Class.ui.menu.visuals_tab.other.viewmodel_changer.enabled, true}, visuals_tab_active, visuals_tab_other_active)

    Class.ui.menu.visuals_tab.other.viewmodel_changer.main_hand:depend({Class.ui.menu.visuals_tab.other.viewmodel_changer.knife_reverse, true}, {Class.ui.menu.visuals_tab.other.viewmodel_changer.enabled, true}, visuals_tab_active, visuals_tab_other_active)

    Class.ui.menu.visuals_tab.other.viewmodel_changer.position.x:depend({Class.ui.menu.visuals_tab.other.viewmodel_changer.enabled, true}, visuals_tab_active, visuals_tab_other_active)

    Class.ui.menu.visuals_tab.other.viewmodel_changer.position.y:depend({Class.ui.menu.visuals_tab.other.viewmodel_changer.enabled, true}, visuals_tab_active, visuals_tab_other_active)

    Class.ui.menu.visuals_tab.other.viewmodel_changer.position.z:depend({Class.ui.menu.visuals_tab.other.viewmodel_changer.enabled, true}, visuals_tab_active, visuals_tab_other_active)

    Class.ui.menu.visuals_tab.other.viewmodel_changer.button:depend({Class.ui.menu.visuals_tab.other.viewmodel_changer.enabled, true}, visuals_tab_active, visuals_tab_other_active)

    Class.ui.menu.visuals_tab.other.disable_post_proccesing.enabled:depend(visuals_tab_active, visuals_tab_other_active)

    Class.ui.menu.visuals_tab.other.animation_breaker.enabled:depend(visuals_tab_active, visuals_tab_other_active)

    Class.ui.menu.visuals_tab.other.animation_breaker.triggers:depend({Class.ui.menu.visuals_tab.other.animation_breaker.enabled, true}, visuals_tab_active, visuals_tab_other_active)

    Class.ui.menu.visuals_tab.other.animation_breaker.air.mode:depend({Class.ui.menu.visuals_tab.other.animation_breaker.enabled, true}, {Class.ui.menu.visuals_tab.other.animation_breaker.triggers, "Air"}, visuals_tab_active, visuals_tab_other_active)

    Class.ui.menu.visuals_tab.other.animation_breaker.air.amount:depend({Class.ui.menu.visuals_tab.other.animation_breaker.enabled, true}, {Class.ui.menu.visuals_tab.other.animation_breaker.triggers, "Air"}, {Class.ui.menu.visuals_tab.other.animation_breaker.air.mode, "Static"}, visuals_tab_active, visuals_tab_other_active)

    Class.ui.menu.visuals_tab.other.animation_breaker.ground.mode:depend({Class.ui.menu.visuals_tab.other.animation_breaker.enabled, true}, {Class.ui.menu.visuals_tab.other.animation_breaker.triggers, "Ground"}, visuals_tab_active, visuals_tab_other_active)

    Class.ui.menu.visuals_tab.other.animation_breaker.ground.amount:depend({Class.ui.menu.visuals_tab.other.animation_breaker.enabled, true}, {Class.ui.menu.visuals_tab.other.animation_breaker.triggers, "Ground"}, {Class.ui.menu.visuals_tab.other.animation_breaker.ground.mode, "Jitter"}, visuals_tab_active, visuals_tab_other_active)  

    Class.ui.menu.visuals_tab.other.animation_breaker.tweaks.mode:depend({Class.ui.menu.visuals_tab.other.animation_breaker.enabled, true}, {Class.ui.menu.visuals_tab.other.animation_breaker.triggers, "Tweaks"}, visuals_tab_active, visuals_tab_other_active)

    Class.ui.menu.visuals_tab.other.animation_breaker.tweaks.amount:depend({Class.ui.menu.visuals_tab.other.animation_breaker.enabled, true}, {Class.ui.menu.visuals_tab.other.animation_breaker.triggers, "Tweaks"}, {Class.ui.menu.visuals_tab.other.animation_breaker.tweaks.mode, "Body Lean"}, visuals_tab_active, visuals_tab_other_active)    



    Class.ui.menu.misc_tab.info_logger.enabled:depend(misc_tab_active)

    Class.ui.menu.misc_tab.info_logger.color.hit:depend({Class.ui.menu.misc_tab.info_logger.enabled, true}, misc_tab_active)

    Class.ui.menu.misc_tab.info_logger.color.miss:depend({Class.ui.menu.misc_tab.info_logger.enabled, true}, misc_tab_active)

    Class.ui.menu.misc_tab.info_logger.triggers:depend({Class.ui.menu.misc_tab.info_logger.enabled, true}, misc_tab_active)

    Class.ui.menu.misc_tab.console_enhancement.enabled:depend(misc_tab_active)

    Class.ui.menu.misc_tab.console_enhancement.mode:depend({Class.ui.menu.misc_tab.console_enhancement.enabled, true}, misc_tab_active)

    Class.ui.menu.misc_tab.trash_talk.enabled:depend(misc_tab_active)

    Class.ui.menu.misc_tab.trash_talk.mode:depend({Class.ui.menu.misc_tab.trash_talk.enabled, true}, misc_tab_active)



    Class.ui.menu.config_tab.config_title:depend(config_tab_active)

    Class.ui.menu.config_tab.list:depend(config_tab_active)

    Class.ui.menu.config_tab.name:depend(config_tab_active)

    Class.ui.menu.config_tab.load:depend(config_tab_active)

    Class.ui.menu.config_tab.save:depend(config_tab_active)

    Class.ui.menu.config_tab.delete:depend(config_tab_active)

    Class.ui.menu.config_tab.import:depend(config_tab_active)

    Class.ui.menu.config_tab.export:depend(config_tab_active)



    --          @ region restricted functionlity



    Class.ui.menu.ragebot_tab.amethystine_double_tap.enabled:set_enabled(Class.util.is_debug_branch())

    Class.ui.menu.ragebot_tab.hideshots_fix.enabled:set_enabled(Class.util.is_debug_branch())



    --          @ region builder

    

    local function randomize_delay(state)

        local mode = state.yaw.delay.mode:get()



        if mode == 2 then

            state.yaw.delay.value:set(math.random(1, 32))

        elseif mode == 3 then

            state.yaw.delay.first_value:set(math.random(1, 32))

            state.yaw.delay.second_value:set(math.random(1, 32))

        elseif mode == 4 then

            local count = state.yaw.delay.custom.count:get()

            for j = 1, 12 do

                if j <= count and state.yaw.delay.custom.delays[j] then

                    state.yaw.delay.custom.delays[j]:set(math.random(1, 32))

                end

            end

        end

    end



    local function copy_state_values(source, target)

        local skip_keys = {

            copy_button = true,

            randomize_button = true,

            separator = true,

            delays = true,

        }



        local function copy_recursive(src, tgt)

            for key, src_element in pairs(src) do

                if not skip_keys[key] then

                    if type(src_element) == "table" and 

                    src_element.get and src_element.set and 

                    tgt[key] and type(tgt[key]) == "table" and 

                    tgt[key].get and tgt[key].set then

                        local value = src_element:get()

                        tgt[key]:set(value)

                    elseif type(src_element) == "table" and 

                        tgt[key] and type(tgt[key]) == "table" then

                        copy_recursive(src_element, tgt[key])

                    end

                end

            end

        end



        if source.yaw and source.yaw.delay and source.yaw.delay.custom and source.yaw.delay.custom.delays and

        target.yaw and target.yaw.delay and target.yaw.delay.custom and target.yaw.delay.custom.delays then

            for j = 1, 12 do

                if source.yaw.delay.custom.delays[j] and target.yaw.delay.custom.delays[j] then

                    local delay_value = source.yaw.delay.custom.delays[j]:get()

                    target.yaw.delay.custom.delays[j]:set(delay_value)

                end

            end

        end



        copy_recursive(source, target)

    end



    local function create_antiaim_builder(team_prefix, state_name, indent)

        local builder = {pitch = {},yaw = {delay = {custom = {}},modifier = {}},body_yaw = {}}

        

        builder.override_state = main_group:checkbox(string.format("\f<%s> Override \f<tilde> %s", team_prefix, state_name))

        builder.yaw.base = main_group:combobox(string.format("\f<%s> Yaw \f<tilde> Base%s", team_prefix, indent), "At targets", "Local view")

        builder.pitch.mode = main_group:combobox(string.format("\f<%s> Pitch \f<tilde> Mode%s", team_prefix, indent), "Down", "Up",  "Custom", "Random")

        builder.pitch.value = main_group:slider(string.format("\f<%s> Pitch \f<tilde> Value%s", team_prefix, indent), -89, 89, 0, true, "°")

        if Class.util.is_debug_branch() then

            builder.yaw.mode = main_group:combobox(string.format("\f<%s> Yaw \f<tilde> Mode%s", team_prefix, indent), "180", "Spin", "Switch", "Amethystine")

            builder.yaw.delay.mode = main_group:slider(string.format("\f<%s> Yaw \f<tilde> Delay Mode%s", team_prefix, indent), 1, 4, 1, true, "", 1, {[1] = "Gamesense", [2] = "Static", [3] = "Random", [4] = "Custom"})

        else

            builder.yaw.mode = main_group:combobox(string.format("\f<%s> Yaw \f<tilde> Mode%s", team_prefix, indent), "180", "Spin", "Switch")

            builder.yaw.delay.mode = main_group:slider(string.format("\f<%s> Yaw \f<tilde> Delay Mode%s", team_prefix, indent), 1, 3, 1, true, "", 1, {[1] = "Gamesense", [2] = "Static", [3] = "Random", [4] = "Custom"})

        end

        builder.yaw.delay.custom.mode = main_group:slider(string.format("\f<%s> Yaw \f<tilde> Custom Delay Mode%s", team_prefix, indent), 1, 3, 1, true, "", 1, {[1] = "Sequential", [2] = "Smart Random", [3] = "Random"})

        builder.yaw.delay.custom.count = main_group:slider(string.format("\f<%s> Yaw \f<tilde> Custom Delay Count%s", team_prefix, indent), 1, 12, 1, true, "")

        builder.yaw.delay.custom.delays = {}

        for j = 1, 12 do

            builder.yaw.delay.custom.delays[j] = main_group:slider(string.format("\f<%s> Yaw \f<tilde> Custom Delay %d%s", team_prefix, j, indent), 1, 32, 1, true, "ms", 1, {[1] = "Gamesense"})

        end

        builder.yaw.delay.value = main_group:slider(string.format("\f<%s> Yaw \f<tilde> Delay Value%s", team_prefix, indent), 1, 32, 1, true, "ms", 1, {[1] = "Gamesense"})

        builder.yaw.delay.first_value = main_group:slider(string.format("\f<%s> Yaw \f<tilde> First Delay Value%s", team_prefix, indent), 1, 32, 1, true, "ms", 1, {[1] = "Gamesense"})

        builder.yaw.delay.second_value = main_group:slider(string.format("\f<%s> Yaw \f<tilde> Second Delay Value%s", team_prefix, indent), 1, 32, 1, true, "ms", 1, {[1] = "Gamesense"})

        builder.yaw.delay.randomize_button = main_group:button("\v[Randomize]\r", function() randomize_delay(builder) end)

        builder.yaw.separator = main_group:label(pui.macros.separator)

        builder.yaw.value = main_group:slider(string.format("\f<%s> Yaw \f<tilde> Value%s", team_prefix, indent), -180, 180, 0, true, "°") 

        builder.yaw.left_value = main_group:slider(string.format("\f<%s> Yaw \f<tilde> Left Value%s", team_prefix, indent), -180, 180, 0, true, "°")

        builder.yaw.right_value = main_group:slider(string.format("\f<%s> Yaw \f<tilde> Right Value%s", team_prefix, indent), -180, 180, 0, true, "°")

        builder.yaw.randomize_value = main_group:slider(string.format("\f<%s> Yaw \f<tilde> Randomize Value%s", team_prefix, indent), -180, 180, 0, true, "°", 1, {[0] = "Disabled"})

        builder.yaw.modifier.mode = main_group:combobox(string.format("\f<%s> Yaw Modifier \f<tilde> Mode%s", team_prefix, indent), "Off", "Offset", "Center", "Random", "Skitter")

        builder.yaw.modifier.value = main_group:slider(string.format("\f<%s> Yaw Modifier \f<tilde> Value%s", team_prefix, indent), -180, 180, 0, true, "°")

        builder.yaw.modifier.randomize_value = main_group:slider(string.format("\f<%s> Yaw Modifier \f<tilde> Randomize Value%s", team_prefix, indent), -180, 180, 0, true, "°", 1, {[0] = "Disabled"})             

        builder.body_yaw.separator = main_group:label(pui.macros.separator)

        builder.body_yaw.mode = main_group:combobox(string.format("\f<%s> Body Yaw \f<tilde> Mode%s", team_prefix, indent), "Off", "Jitter", "Static", "Opposite")

        builder.body_yaw.value = main_group:slider(string.format("\f<%s> Body Yaw \f<tilde> Value%s", team_prefix, indent), -180, 180, 0, true, "°")

        if Class.util.is_debug_branch() then

            builder.body_yaw.inverter = main_group:combobox(string.format("\f<%s> Body Yaw \f<tilde> Inverter%s", team_prefix, indent), {"Disabled", "Enabled"})

        else

            builder.body_yaw.inverter = main_group:combobox(string.format("\f<%s> Body Yaw \f<tilde> Inverter%s", team_prefix, indent), {"Disabled"})

        end    

        builder.body_yaw.left_value = main_group:slider(string.format("\f<%s> Body Yaw \f<tilde> Left Value%s", team_prefix, indent), 0, 60, 60, true, "°")

        builder.body_yaw.right_value = main_group:slider(string.format("\f<%s> Body Yaw \f<tilde> Right Value%s", team_prefix, indent), 0, 60, 60, true, "°")

        builder.copy_button = main_group:button("\v[Send to Another side]\r", function() end)

        return builder

    end



    for i = 1, #antiaim_states do

        Class.ui.antiaim_states_t[i] = create_antiaim_builder("builder_team_t", antiaim_states[i], antiaim_different[i])

        Class.ui.antiaim_states_ct[i] = create_antiaim_builder("builder_team_ct", antiaim_states[i], antiaim_different[i])

        if Class.ui.antiaim_states_t[i].copy_button then

            Class.ui.antiaim_states_t[i].copy_button:set_callback(function() copy_state_values(Class.ui.antiaim_states_t[i], Class.ui.antiaim_states_ct[i]) end)

        end

        if Class.ui.antiaim_states_ct[i].copy_button then

            Class.ui.antiaim_states_ct[i].copy_button:set_callback(function() copy_state_values(Class.ui.antiaim_states_ct[i], Class.ui.antiaim_states_t[i]) end)

        end

    end



    Class.ui.antiaim_states_t[1].override_state:set(true)

    Class.ui.antiaim_states_ct[1].override_state:set(true)



    for i = 1, #antiaim_states do

        

        local team_match = {Class.ui.menu.antiaim_tab.builder.select.team, antiaim_team_states[1]}

        local condition_match = {Class.ui.menu.antiaim_tab.builder.select.condition, antiaim_states[i]}

        local condition_enabled = {Class.ui.antiaim_states_t[i].override_state, true}



        if i ~= 1 then

            Class.ui.antiaim_states_t[i].override_state:depend(antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match)

        end



        Class.ui.antiaim_states_t[1].override_state:set_visible(false)

        Class.ui.antiaim_states_t[i].yaw.base:depend(antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].pitch.mode:depend(antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].pitch.value:depend({Class.ui.antiaim_states_t[i].pitch.mode, "Custom"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].yaw.mode:depend(antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].yaw.delay.mode:depend({Class.ui.antiaim_states_t[i].yaw.mode, "Switch"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].yaw.delay.custom.mode:depend({Class.ui.antiaim_states_t[i].yaw.mode, "Switch"}, {Class.ui.antiaim_states_t[i].yaw.delay.mode, 4}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].yaw.delay.value:depend({Class.ui.antiaim_states_t[i].yaw.mode, "Switch"}, {Class.ui.antiaim_states_t[i].yaw.delay.mode, 2}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].yaw.delay.first_value:depend({Class.ui.antiaim_states_t[i].yaw.mode, "Switch"}, {Class.ui.antiaim_states_t[i].yaw.delay.mode, 3}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].yaw.delay.second_value:depend({Class.ui.antiaim_states_t[i].yaw.mode, "Switch"}, {Class.ui.antiaim_states_t[i].yaw.delay.mode, 3}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].yaw.delay.randomize_button:depend({Class.ui.antiaim_states_t[i].yaw.mode, "Switch"}, {Class.ui.antiaim_states_t[i].yaw.delay.mode, 2, 4}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].yaw.separator:depend({Class.ui.antiaim_states_t[i].yaw.mode, "Switch"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].yaw.value:depend({Class.ui.antiaim_states_t[i].yaw.mode, "180", "Spin"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].yaw.left_value:depend({Class.ui.antiaim_states_t[i].yaw.mode, "Switch"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].yaw.right_value:depend({Class.ui.antiaim_states_t[i].yaw.mode, "Switch"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].yaw.randomize_value:depend({Class.ui.antiaim_states_t[i].yaw.mode, "180", "Spin", "Switch"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].yaw.modifier.mode:depend(antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].yaw.modifier.value:depend({Class.ui.antiaim_states_t[i].yaw.modifier.mode, "Offset", "Center", "Random", "Skitter"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].yaw.modifier.randomize_value:depend({Class.ui.antiaim_states_t[i].yaw.modifier.mode, "Offset", "Center", "Random", "Skitter"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].body_yaw.separator:depend(antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].body_yaw.mode:depend({Class.ui.antiaim_states_t[i].yaw.mode, "180", "Spin"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].body_yaw.value:depend({Class.ui.antiaim_states_t[i].yaw.mode, "180", "Spin"}, {Class.ui.antiaim_states_t[i].body_yaw.mode, "Jitter", "Static", "Opposite"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].body_yaw.inverter:depend({Class.ui.antiaim_states_t[i].yaw.mode, "Switch"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].body_yaw.left_value:depend({Class.ui.antiaim_states_t[i].yaw.mode, "Switch"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].body_yaw.right_value:depend({Class.ui.antiaim_states_t[i].yaw.mode, "Switch"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].copy_button:depend(antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_t[i].yaw.delay.custom.count:depend({Class.ui.antiaim_states_t[i].yaw.mode, "Switch"}, {Class.ui.antiaim_states_t[i].yaw.delay.mode, 4}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)



        for j = 1, 12 do

            Class.ui.antiaim_states_t[i].yaw.delay.custom.delays[j]:depend({Class.ui.antiaim_states_t[i].yaw.mode, "Switch"}, {Class.ui.antiaim_states_t[i].yaw.delay.mode, 4}, {Class.ui.antiaim_states_t[i].yaw.delay.custom.count, j, 12}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        end

    end



    for i = 1, #antiaim_states do

        local team_match = {Class.ui.menu.antiaim_tab.builder.select.team, antiaim_team_states[2]}

        local condition_match = {Class.ui.menu.antiaim_tab.builder.select.condition, antiaim_states[i]}

        local condition_enabled = {Class.ui.antiaim_states_ct[i].override_state, true}



        if i ~= 1 then

            Class.ui.antiaim_states_ct[i].override_state:depend(antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match)

        end



        Class.ui.antiaim_states_ct[1].override_state:set_visible(false)

        Class.ui.antiaim_states_ct[i].yaw.base:depend(antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].pitch.mode:depend(antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].pitch.value:depend({Class.ui.antiaim_states_ct[i].pitch.mode, "Custom"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].yaw.mode:depend(antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].yaw.delay.mode:depend({Class.ui.antiaim_states_ct[i].yaw.mode, "Switch"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].yaw.delay.custom.mode:depend({Class.ui.antiaim_states_ct[i].yaw.mode, "Switch"}, {Class.ui.antiaim_states_ct[i].yaw.delay.mode, 4}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].yaw.delay.value:depend({Class.ui.antiaim_states_ct[i].yaw.mode, "Switch"}, {Class.ui.antiaim_states_ct[i].yaw.delay.mode, 2}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].yaw.delay.first_value:depend({Class.ui.antiaim_states_ct[i].yaw.mode, "Switch"}, {Class.ui.antiaim_states_ct[i].yaw.delay.mode, 3}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].yaw.delay.second_value:depend({Class.ui.antiaim_states_ct[i].yaw.mode, "Switch"}, {Class.ui.antiaim_states_ct[i].yaw.delay.mode, 3}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].yaw.delay.randomize_button:depend({Class.ui.antiaim_states_ct[i].yaw.mode, "Switch"}, {Class.ui.antiaim_states_ct[i].yaw.delay.mode, 2, 4}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].yaw.separator:depend({Class.ui.antiaim_states_ct[i].yaw.mode, "Switch"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].yaw.value:depend({Class.ui.antiaim_states_ct[i].yaw.mode, "180", "Spin"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].yaw.left_value:depend({Class.ui.antiaim_states_ct[i].yaw.mode, "Switch"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].yaw.right_value:depend({Class.ui.antiaim_states_ct[i].yaw.mode, "Switch"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].yaw.randomize_value:depend({Class.ui.antiaim_states_ct[i].yaw.mode, "180", "Spin", "Switch"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].yaw.modifier.mode:depend(antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].yaw.modifier.value:depend({Class.ui.antiaim_states_ct[i].yaw.modifier.mode, "Offset", "Center", "Random", "Skitter"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].yaw.modifier.randomize_value:depend({Class.ui.antiaim_states_ct[i].yaw.modifier.mode, "Offset", "Center", "Random", "Skitter"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].body_yaw.separator:depend(antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].body_yaw.mode:depend({Class.ui.antiaim_states_ct[i].yaw.mode, "180", "Spin"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].body_yaw.value:depend({Class.ui.antiaim_states_ct[i].yaw.mode, "180", "Spin"}, {Class.ui.antiaim_states_ct[i].body_yaw.mode, "Jitter", "Static", "Opposite"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].body_yaw.inverter:depend({Class.ui.antiaim_states_ct[i].yaw.mode, "Switch"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].body_yaw.left_value:depend({Class.ui.antiaim_states_ct[i].yaw.mode, "Switch"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].body_yaw.right_value:depend({Class.ui.antiaim_states_ct[i].yaw.mode, "Switch"}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].copy_button:depend(antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        Class.ui.antiaim_states_ct[i].yaw.delay.custom.count:depend({Class.ui.antiaim_states_ct[i].yaw.mode, "Switch"}, {Class.ui.antiaim_states_ct[i].yaw.delay.mode, 4}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        

        for j = 1, 12 do

            Class.ui.antiaim_states_ct[i].yaw.delay.custom.delays[j]:depend({Class.ui.antiaim_states_ct[i].yaw.mode, "Switch"}, {Class.ui.antiaim_states_ct[i].yaw.delay.mode, 4}, {Class.ui.antiaim_states_ct[i].yaw.delay.custom.count, j, 12}, antiaim_tab_active, antiaim_tab_builder_active, condition_match, team_match, condition_enabled)

        end

    end

end



do --#region ragebot

    Class.ragebot = {

        hideshots_fix = {

            _original_limit = nil,

            _is_active = false,

            

            check_active = function(self)

                if not Class.util.is_debug_branch() then return false end

                if not Class.ui.menu.ragebot_tab.hideshots_fix.enabled:get() then return false end



                local reference = Class.util.reference

                local is_hideshots = ui.get(reference.aa_hideshots[1]) and ui.get(reference.aa_hideshots[2])

                local is_fakeduck = ui.get(reference.rage_fake_duck[1])

                local is_doubletap = ui.get(reference.rage_double_tap[1]) and ui.get(reference.rage_double_tap[2])



                return is_hideshots and not is_fakeduck and not is_doubletap

            end,

            

            apply_settings = function(self)

                local reference = Class.util.reference

                

                if not self._is_active then

                    self._original_limit = ui.get(reference.aa_fakelag_limit[1])

                    self._is_active = true

                end

                

                ui.set(reference.aa_fakelag_limit[1], 1)

            end,

            

            restore_settings = function(self)

                local reference = Class.util.reference

                

                if self._is_active and self._original_limit then

                    ui.set(reference.aa_fakelag_limit[1], self._original_limit)

                    self._original_limit = nil

                    self._is_active = false

                end

            end,

            

            handle = function(self)

                if self:check_active() then

                    self:apply_settings()

                else

                    self:restore_settings()

                end

            end,

            

            reset = function(self)

                self:restore_settings()

                self._original_limit = nil

                self._is_active = false

            end

        }

    }

end --#endregion



do          -- @ region antiaim





    Class.util.antiaim = {

        current_state = "Shared",

        current_team = "T",

        state_index = 1,

        manual_direction = 0,

        last_manual_press_time = 0,

        jitter_inverter = false,

        jitter_last_tick = 0,

        custom_delay_index = 1, 

        custom_delay_history = {}, 

        custom_delay_last = 1,  

        amethystine_pattern = {},  

        amethystine_index = 1, 

        amethystine_tick = 0,

        alive_players = {}

    }



    Class.util.antiaim.states = {

        "Shared", "Standing", "Running", "Slow-Motion", 

        "Aerobic", "Aerobic+", "Crouching", "Sneaking"

    }



    Class.util.antiaim.current_settings = {

        yaw = {

            base = "Local view",

            value = 0,

            left_value = 0,

            right_value = 0,

            modifier = {

                mode = "Off",

                value = 0

            },

        },



        pitch = {

            mode = "Down",

            value = "0",

        },



        fakelag = {

            enabled = true,

            amount = "Maximum",

            limit = 14,

            variance = 0,

        },



        body_yaw = {

            mode = "Off",

            value = 0,

            inverter = "Disabled",

            left_value = 0,

            right_value = 0

        },



        freestanding = {

            enabled = false

        },

    }



    function Class.util.antiaim.clear_data()

        Class.util.antiaim.current_state = "Shared"

        Class.util.antiaim.current_team = "T"

        Class.util.antiaim.state_index = 1

        Class.util.antiaim.manual_direction = 0

        Class.util.antiaim.last_manual_press_time = 0

        Class.util.antiaim.jitter_inverter = false

        Class.util.antiaim.jitter_last_tick = 0

        Class.util.antiaim.custom_delay_index = 1  

        Class.util.antiaim.custom_delay_history = {} 

        Class.util.antiaim.custom_delay_last = 1

        Class.util.antiaim.amethystine_pattern = {} 

        Class.util.antiaim.amethystine_index = 1

        Class.util.antiaim.amethystine_tick = 0  

        Class.util.antiaim.alive_players = {}

        

        Class.util.antiaim.was_in_air = false

        Class.util.antiaim.landing_time = 0

    end

    

    local function normalize_yaw(angle)

        while angle > 180 do

            angle = angle - 360

        end

        while angle < -180 do

            angle = angle + 360

        end

        return angle

    end



    local function generate_amethystine_pattern()

        local pattern = {}

        pattern[1] = { delay = 3, yaw = -8, body = -60 }

        pattern[2] = { delay = 3, yaw = 6, body = 60 }

        pattern[3] = { delay = 1, yaw = -6, body = -45 }

        pattern[4] = { delay = 4, yaw = 11, body = 45 }

        pattern[5] = { delay = 3, yaw = -9, body = -25 }

        pattern[6] = { delay = 1, yaw = 6, body = 25 }

        pattern[7] = { delay = 2, yaw = -7, body = -60 }

        pattern[8] = { delay = 5, yaw = 10, body = 20 }

        return pattern

    end



    local function get_next_custom_delay(settings)

        local count = settings.yaw.delay.custom.count:get()

        local mode = settings.yaw.delay.custom.mode:get()

        

        local default_delay = 1

        

        if count == 0 or not settings.yaw.delay.custom.delays then

            return default_delay

        end

        

        local delays = {}

        for i = 1, count do

            if settings.yaw.delay.custom.delays[i] then

                local delay_value = settings.yaw.delay.custom.delays[i]:get()

                if delay_value and type(delay_value) == "number" then

                    table.insert(delays, delay_value)

                end

            end

        end

        

        if #delays == 0 then

            return default_delay

        end

        

        if mode == 1 then 

            local delay = delays[Class.util.antiaim.custom_delay_index]

            return delay or default_delay

            

        elseif mode == 2 then

            local available_delays = {}

            for i, delay in ipairs(delays) do

                if delay ~= Class.util.antiaim.custom_delay_last then

                    table.insert(available_delays, delay)

                end

            end

            

            if #available_delays == 0 then

                available_delays = delays

            end

            

            local random_index = math.random(1, #available_delays)

            local selected_delay = available_delays[random_index]

            Class.util.antiaim.custom_delay_last = selected_delay

            return selected_delay or default_delay

            

        else 

            local random_index = math.random(1, #delays)

            local selected_delay = delays[random_index]

            return selected_delay or default_delay

        end

    end



    function Class.util.antiaim.get_player_state(cmd)

        local lp = entity.get_local_player()

        if lp == nil then return "Shared" end

        

        local flags = entity.get_prop(lp, "m_fFlags")

        local velocity = { entity.get_prop(lp, "m_vecVelocity") }

        local speed = math.sqrt(velocity[1]^2 + velocity[2]^2)

        

        local on_ground = bit.band(flags, 1) ~= 0

        local ducking = entity.get_prop(lp, "m_flDuckAmount") > 0.7 or ui.get(Class.util.reference.rage_fake_duck[1])

        local in_slow_walk = ui.get(Class.util.reference.aa_slow_walk[1]) and ui.get(Class.util.reference.aa_slow_walk[2])

        

        if not Class.util.antiaim.landing_time then

            Class.util.antiaim.landing_time = 0

        end

        

        local was_in_air = Class.util.antiaim.was_in_air or false

        

        if was_in_air and on_ground then

            Class.util.antiaim.landing_time = globals.curtime()

        end

        

        Class.util.antiaim.was_in_air = not on_ground

        

        local recently_landed = (globals.curtime() - Class.util.antiaim.landing_time) < 0.05

        

        if not on_ground then

            if ducking then

                return "Aerobic+"

            else

                return "Aerobic"

            end

        elseif cmd.in_jump == 1 then

            if ducking then

                return "Aerobic+"

            else

                return "Aerobic"

            end

        elseif recently_landed then

            if ducking then

                return "Aerobic+"

            else

                return "Aerobic"

            end

        elseif ducking then

            if speed > 10 then

                return "Sneaking"

            else

                return "Crouching"

            end

        elseif in_slow_walk and speed > 10 then

            return "Slow-Motion"

        elseif speed > 5 then

            return "Running"

        elseif speed <= 5 then

            return "Standing"

        else

            return "Shared"

        end

    end



    local function antiaim_disablers_check_active()

        if not Class.ui.menu.antiaim_tab.other.additional.select:get("Anti-Aimbot Disablers") then return false end



        for i=1, 64 do

            if entity.is_alive(i) and entity.is_enemy(i) then

                table.insert(Class.util.antiaim.alive_players, i)

            end

        end     



        if Class.ui.menu.antiaim_tab.other.additional.antiaimbot_disablers.states:get("On Warmup") then

            if entity.get_prop(entity.get_game_rules(), "m_bWarmupPeriod") == 1 then

                return true

            end

        end



        if Class.ui.menu.antiaim_tab.other.additional.antiaimbot_disablers.states:get("No Enemies Alive") then

            if client.current_threat() == nil and #Class.util.antiaim.alive_players == 0 then

                return true

            end

        end        



        return false

    end



    local function antiaim_disablers_apply_settings()

        Class.util.antiaim.current_settings.pitch.mode = "Custom"

        Class.util.antiaim.current_settings.pitch.value = 0

        Class.util.antiaim.current_settings.yaw.mode = "Spin" 

        Class.util.antiaim.current_settings.yaw.value = Class.ui.menu.antiaim_tab.other.additional.antiaimbot_disablers.speed:get()

        Class.util.antiaim.current_settings.yaw.modifier.mode = "Off" 

        Class.util.antiaim.current_settings.yaw.modifier.value = 0

        Class.util.antiaim.current_settings.body_yaw.mode = "Static" 

        Class.util.antiaim.current_settings.body_yaw.value = 60

        Class.util.antiaim.current_settings.freestanding.enabled = false

    end



    local function handle_antiaim_disablers()

        if antiaim_disablers_check_active() then

            antiaim_disablers_apply_settings()

        end

    end



    local function avoid_backstab_check_active()

        if Class.ui.menu.antiaim_tab.other.additional.avoid_backstab.amount:get() == 0 or not Class.ui.menu.antiaim_tab.other.additional.select:get("Avoid Backstab") then return false end



        local lp = entity.get_local_player()

        local players = entity.get_players(true)

        local lp_origin = { entity.get_prop(lp, "m_vecOrigin") }

        local avoid_distance = Class.ui.menu.antiaim_tab.other.additional.avoid_backstab.amount:get()

        

        for i = 1, #players do

            local enemy = players[i]

            local weapon = entity.get_player_weapon(enemy)

            

            if weapon and entity.get_classname(weapon) == "CKnife" then

                local enemy_origin = { entity.get_prop(enemy, "m_vecOrigin") }

                local distance = math.sqrt(

                    (lp_origin[1] - enemy_origin[1])^2 + 

                    (lp_origin[2] - enemy_origin[2])^2 + 

                    (lp_origin[3] - enemy_origin[3])^2

                )

                

                if distance <= avoid_distance then            

                    return true

                end

            end

        end



        return false

    end



    local function avoid_backstab_apply_settings()

        Class.util.antiaim.current_settings.yaw.base = "At targets"

        Class.util.antiaim.current_settings.yaw.mode = "180" 

        Class.util.antiaim.current_settings.yaw.value = 180

        Class.util.antiaim.current_settings.yaw.modifier.mode = "Off" 

        Class.util.antiaim.current_settings.yaw.modifier.value = 0

        Class.util.antiaim.current_settings.body_yaw.mode = "Static" 

        Class.util.antiaim.current_settings.body_yaw.value = 60

        Class.util.antiaim.current_settings.freestanding.enabled = false

    end



    local function handle_avoid_backstab()

        if avoid_backstab_check_active() then

            avoid_backstab_apply_settings()

        end

    end



    local function fast_ladder_check_active()

        if not Class.ui.menu.antiaim_tab.other.additional.select:get("Fast Ladder") then return false end



        local lp = entity.get_local_player()



        local move_type = entity.get_prop(lp, "m_MoveType")

        if move_type ~= 9 then 

            return false 

        end        



        return true

    end



    local function fast_ladder_apply_settings(cmd)

        local pitch, yaw = client.camera_angles()

        cmd.yaw = math.floor(cmd.yaw + 0.5)

        cmd.roll = 0



        if cmd.forwardmove == 0 then

            if cmd.sidemove ~= 0 then

                cmd.pitch = 89

                cmd.yaw = cmd.yaw + 180

                if cmd.sidemove < 0 then

                    cmd.in_moveleft = 0

                    cmd.in_moveright = 1

                end

                if cmd.sidemove > 0 then

                    cmd.in_moveleft = 1

                    cmd.in_moveright = 0

                end

            end

        end



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



    local function handle_fast_ladder(cmd)

        if fast_ladder_check_active() then

            fast_ladder_apply_settings(cmd)

        end

    end

    

    local function manual_direction()

        if Class.ui.menu.antiaim_tab.other.hotkey.manual_left:get() and Class.util.antiaim.last_manual_press_time + 0.2 < globals.curtime() then

            Class.util.antiaim.manual_direction = Class.util.antiaim.manual_direction == 1 and 0 or 1

            Class.util.antiaim.last_manual_press_time = globals.curtime()

        elseif Class.ui.menu.antiaim_tab.other.hotkey.manual_right:get() and Class.util.antiaim.last_manual_press_time + 0.2 < globals.curtime() then

            Class.util.antiaim.manual_direction = Class.util.antiaim.manual_direction == 2 and 0 or 2

            Class.util.antiaim.last_manual_press_time = globals.curtime()

        elseif Class.ui.menu.antiaim_tab.other.hotkey.manual_forward:get() and Class.util.antiaim.last_manual_press_time + 0.2 < globals.curtime() then

            Class.util.antiaim.manual_direction = Class.util.antiaim.manual_direction == 3 and 0 or 3

            Class.util.antiaim.last_manual_press_time = globals.curtime()

        elseif Class.util.antiaim.last_manual_press_time > globals.curtime() then

            Class.util.antiaim.last_manual_press_time = globals.curtime()

        end

    end



    local function manual_apply_settings()

        local yaw_value

        if Class.util.antiaim.manual_direction == 1 then

            yaw_value = -90  -- left

        elseif Class.util.antiaim.manual_direction == 2 then

            yaw_value = 90   -- right

        elseif Class.util.antiaim.manual_direction == 3 then

            yaw_value = -180

        end



        Class.util.antiaim.current_settings.yaw.mode = "180" 

        Class.util.antiaim.current_settings.yaw.base = "Local View"

        Class.util.antiaim.current_settings.yaw.value = yaw_value

        Class.util.antiaim.current_settings.freestanding.enabled = false   

        

        if Class.ui.menu.antiaim_tab.other.additional.yaw_mode.manual:get() ~= 1 then

            Class.util.antiaim.current_settings.pitch.mode = "Down"

            Class.util.antiaim.current_settings.yaw.modifier.mode = "Off" 

            Class.util.antiaim.current_settings.yaw.modifier.value = 0

            Class.util.antiaim.current_settings.body_yaw.mode = Class.ui.menu.antiaim_tab.other.additional.yaw_mode.manual:get() == 2 and "Jitter" or "Static"

            Class.util.antiaim.current_settings.body_yaw.value = 60        

        end

    end



    local function handle_manual()

        manual_direction()

        if Class.util.antiaim.manual_direction ~= 0 then

            manual_apply_settings()

        end

    end



    local function freestanding_check_active()

        local is_freestanding_disablers_enabled = Class.ui.menu.antiaim_tab.other.additional.select:get("Freestanding Disablers")

        local is_freestanding_active = Class.ui.menu.antiaim_tab.other.hotkey.freestanding:get() and Class.util.antiaim.manual_direction == 0



        if is_freestanding_disablers_enabled then

            local freestanding_disablers_active = false

            local disabled_states = Class.ui.menu.antiaim_tab.other.additional.freestanding.disablers_states:get()

            for _, state in ipairs(disabled_states) do

                if state == Class.util.antiaim.current_state then

                    freestanding_disablers_active = true

                    break

                end

            end

            

            if freestanding_disablers_active then

                is_freestanding_active = false

            end

        end 

        

        return is_freestanding_active

    end



    local function freestanding_apply_settings(enabled)

        Class.util.antiaim.current_settings.freestanding.enabled = enabled

        if not enabled then return end



        if Class.ui.menu.antiaim_tab.other.additional.yaw_mode.freestanding:get() ~= 1 then

            Class.util.antiaim.current_settings.pitch.mode = "Down"

            Class.util.antiaim.current_settings.yaw.base = "At targets"

            Class.util.antiaim.current_settings.yaw.mode = "180" 

            Class.util.antiaim.current_settings.yaw.value = 0

            Class.util.antiaim.current_settings.yaw.modifier.mode = "Off" 

            Class.util.antiaim.current_settings.yaw.modifier.value = 0

            Class.util.antiaim.current_settings.body_yaw.mode = Class.ui.menu.antiaim_tab.other.additional.yaw_mode.freestanding:get() == 2 and "Jitter" or "Static"

            Class.util.antiaim.current_settings.body_yaw.value = 60     

        end

    end



    local function handle_freestanding()

        freestanding_apply_settings(freestanding_check_active())

    end    



    local function safe_head_check_active()

        if not Class.ui.menu.antiaim_tab.other.additional.select:get("Safe Head") then return false end



        local lp = entity.get_local_player()



        local weapon = entity.get_player_weapon(lp)

        if not weapon then return false end



        local players = entity.get_players(true)

        local lp_origin = vector(entity.get_prop(lp, "m_vecOrigin"))

        local closest_enemy = nil

        local min_distance = math.huge



        for i = 1, #players do

            local enemy = players[i]

            local enemy_origin = vector(entity.get_prop(enemy, "m_vecOrigin"))

            local distance = lp_origin:dist(enemy_origin)



            if distance < min_distance then

                min_distance = distance

                closest_enemy = enemy

            end

        end



        local threat_origin = vector(entity.get_prop(closest_enemy, "m_vecOrigin"))

        local height_difference = lp_origin.z - threat_origin.z

        

        local state_index = Class.util.antiaim.state_index

        local is_knife = entity.get_classname(weapon) == "CKnife"

        local is_taser = entity.get_classname(weapon) == "CWeaponTaser"

        local height_diff_threshold = Class.ui.menu.antiaim_tab.other.additional.safe_head.height_difference:get()

        local is_above_enemy = height_difference > height_diff_threshold and closest_enemy ~= nil



        local knife_condition = Class.ui.menu.antiaim_tab.other.additional.safe_head.states:get("Knife") and state_index == 6 and is_knife

        local taser_condition = Class.ui.menu.antiaim_tab.other.additional.safe_head.states:get("Taser") and state_index == 6 and is_taser

        local above_condition = Class.ui.menu.antiaim_tab.other.additional.safe_head.states:get("Above enemy") and is_above_enemy



        return knife_condition or taser_condition or above_condition

    end



    local function safe_head_apply_settings()

        Class.util.antiaim.current_settings.pitch.mode = "Down"

        Class.util.antiaim.current_settings.yaw.mode = "180" 

        Class.util.antiaim.current_settings.yaw.value = 0

        Class.util.antiaim.current_settings.yaw.modifier.mode = "Off" 

        Class.util.antiaim.current_settings.yaw.modifier.value = 0

        Class.util.antiaim.current_settings.body_yaw.mode = "Static" 

        Class.util.antiaim.current_settings.body_yaw.value = 0

        Class.util.antiaim.current_settings.freestanding.enabled = false

    end



    local function handle_safe_head()

        if safe_head_check_active() then

            safe_head_apply_settings()

        end        

    end



    function Class.util.antiaim.update_settings(cmd, state_index, team)

        local settings = (team == "T") and Class.ui.antiaim_states_t[state_index] or Class.ui.antiaim_states_ct[state_index]

        local yaw_randomize_value = math.random(-settings.yaw.randomize_value:get(), settings.yaw.randomize_value:get())

        local yaw_modifier_randomize_value = math.random(-settings.yaw.modifier.randomize_value:get(), settings.yaw.modifier.randomize_value:get())



        Class.util.antiaim.current_settings.pitch.mode = settings.pitch.mode:get()

        Class.util.antiaim.current_settings.pitch.value = settings.pitch.value:get()



        Class.util.antiaim.current_settings.yaw.base = settings.yaw.base:get()

        Class.util.antiaim.current_settings.yaw.mode = settings.yaw.mode:get()

        Class.util.antiaim.current_settings.yaw.value = normalize_yaw(settings.yaw.value:get() + yaw_randomize_value)

        Class.util.antiaim.current_settings.yaw.left_value = normalize_yaw(settings.yaw.left_value:get() + yaw_randomize_value)

        Class.util.antiaim.current_settings.yaw.right_value = normalize_yaw(settings.yaw.right_value:get() + yaw_randomize_value)



        Class.util.antiaim.current_settings.yaw.modifier.mode = settings.yaw.modifier.mode:get()

        Class.util.antiaim.current_settings.yaw.modifier.value = normalize_yaw(settings.yaw.modifier.value:get() + yaw_modifier_randomize_value)



        Class.util.antiaim.current_settings.body_yaw.mode = settings.body_yaw.mode:get()

        Class.util.antiaim.current_settings.body_yaw.value = settings.body_yaw.value:get()

        Class.util.antiaim.current_settings.body_yaw.inverter = settings.body_yaw.inverter:get()

        Class.util.antiaim.current_settings.body_yaw.left_value = settings.body_yaw.left_value:get()

        Class.util.antiaim.current_settings.body_yaw.right_value = settings.body_yaw.right_value:get()



        if Class.util.antiaim.current_settings.yaw.mode == "Switch" then

            local should_switch = false

            local delay = 1

            

            if settings.yaw.delay.mode:get() == 1 then

                if globals.tickcount() > Class.util.antiaim.jitter_last_tick + 1 then

                    if cmd.chokedcommands == 0 then

                        should_switch = true

                        delay = 1

                    end

                end

            elseif settings.yaw.delay.mode:get() == 2 then

                if globals.tickcount() > Class.util.antiaim.jitter_last_tick + settings.yaw.delay.value:get() then

                    if cmd.chokedcommands == 0 then

                        should_switch = true

                        delay = settings.yaw.delay.value:get() or 1

                    end

                end

            elseif settings.yaw.delay.mode:get() == 3 then

                local first_delay = settings.yaw.delay.first_value:get() or 1

                local second_delay = settings.yaw.delay.second_value:get() or 1

                if globals.tickcount() > Class.util.antiaim.jitter_last_tick + math.random(first_delay, second_delay) then

                    if cmd.chokedcommands == 0 then

                        should_switch = true

                        delay = math.random(first_delay, second_delay)

                    end

                end

            elseif settings.yaw.delay.mode:get() == 4 then

                delay = get_next_custom_delay(settings) or 1

                

                local additional_delay = 0

                if settings.yaw.delay.custom.mode:get() == 1 then

                    additional_delay = 1

                end

                

                if globals.tickcount() > Class.util.antiaim.jitter_last_tick + delay + additional_delay then

                    if cmd.chokedcommands == 0 then

                        should_switch = true

                    end

                end

            end

            

            if should_switch then

                Class.util.antiaim.jitter_inverter = not Class.util.antiaim.jitter_inverter

                Class.util.antiaim.jitter_last_tick = globals.tickcount()

                

                if settings.yaw.delay.mode:get() == 4 and settings.yaw.delay.custom.mode:get() == 1 then

                    Class.util.antiaim.custom_delay_index = Class.util.antiaim.custom_delay_index % settings.yaw.delay.custom.count:get() + 1

                end

                

                table.insert(Class.util.antiaim.custom_delay_history, {

                    delay = delay,

                    state = Class.util.antiaim.jitter_inverter,

                    time = globals.curtime()

                })

                

                if #Class.util.antiaim.custom_delay_history > 20 then

                    table.remove(Class.util.antiaim.custom_delay_history, 1)

                end

            end



            Class.util.antiaim.current_settings.body_yaw.mode = "Static"

            Class.util.antiaim.current_settings.body_yaw.value = (Class.util.antiaim.jitter_inverter and Class.util.antiaim.current_settings.body_yaw.left_value or -Class.util.antiaim.current_settings.body_yaw.right_value) * (Class.util.antiaim.current_settings.yaw.left_value > 0 and 1 or -1) * (Class.util.antiaim.current_settings.body_yaw.inverter == "Enabled" and -1 or 1)

        elseif Class.util.antiaim.current_settings.yaw.mode == "Amethystine" then

            if #Class.util.antiaim.amethystine_pattern == 0 then

                Class.util.antiaim.amethystine_pattern = generate_amethystine_pattern()

            end

            

            Class.util.antiaim.amethystine_tick = Class.util.antiaim.amethystine_tick + 1

            local current_pattern = Class.util.antiaim.amethystine_pattern[Class.util.antiaim.amethystine_index]

            

            if Class.util.antiaim.amethystine_tick >= current_pattern.delay then

                Class.util.antiaim.jitter_inverter = not Class.util.antiaim.jitter_inverter

                Class.util.antiaim.amethystine_tick = 0

                Class.util.antiaim.amethystine_index = Class.util.antiaim.amethystine_index % #Class.util.antiaim.amethystine_pattern + 1

                

                local random_yaw_offset = math.random(-1, 2)

                local random_body_offset = math.random(-5, 5)

                

                Class.util.antiaim.current_settings.yaw.left_value = normalize_yaw(current_pattern.yaw + random_yaw_offset)

                Class.util.antiaim.current_settings.yaw.right_value = normalize_yaw(-current_pattern.yaw + random_yaw_offset)

                Class.util.antiaim.current_settings.body_yaw.value = current_pattern.body + random_body_offset

            end

            

            Class.util.antiaim.current_settings.body_yaw.mode = "Static"

        end

    end



    function Class.util.antiaim.apply_all_settings()

        ui.set(Class.util.reference.aa_pitch[1], Class.util.antiaim.current_settings.pitch.mode)

        ui.set(Class.util.reference.aa_pitch[2], Class.util.antiaim.current_settings.pitch.value)

        

        ui.set(Class.util.reference.aa_yaw_base, Class.util.antiaim.current_settings.yaw.base)

        

        if Class.util.antiaim.current_settings.yaw.mode == "Switch" or Class.util.antiaim.current_settings.yaw.mode == "Amethystine" then

            ui.set(Class.util.reference.aa_yaw[1], "180")

            

            local yaw_value

            if Class.util.antiaim.jitter_inverter then

                yaw_value = Class.util.antiaim.current_settings.yaw.left_value

            else

                yaw_value = Class.util.antiaim.current_settings.yaw.right_value

            end

            

            ui.set(Class.util.reference.aa_yaw[2], yaw_value)

    

        elseif Class.util.antiaim.current_settings.yaw.mode == "180" or Class.util.antiaim.current_settings.yaw.mode == "Spin" then

            ui.set(Class.util.reference.aa_yaw[1], Class.util.antiaim.current_settings.yaw.mode)

            ui.set(Class.util.reference.aa_yaw[2], Class.util.antiaim.current_settings.yaw.value)

        else

            ui.set(Class.util.reference.aa_yaw[1], Class.util.antiaim.current_settings.yaw.mode)

        end

        

        ui.set(Class.util.reference.aa_yaw_jitter[1], Class.util.antiaim.current_settings.yaw.modifier.mode)

        ui.set(Class.util.reference.aa_yaw_jitter[2], Class.util.antiaim.current_settings.yaw.modifier.value)

        

        ui.set(Class.util.reference.aa_yaw_body[1], Class.util.antiaim.current_settings.body_yaw.mode)

        ui.set(Class.util.reference.aa_yaw_body[2], Class.util.antiaim.current_settings.body_yaw.value)

        

        ui.set(Class.util.reference.aa_freestanding[1], Class.util.antiaim.current_settings.freestanding.enabled)

        ui.set(Class.util.reference.aa_freestanding[2], Class.util.antiaim.current_settings.freestanding.enabled and "Always on" or "On hotkey")

        

        ui.set(Class.util.reference.aa_fakelag_enabled[1], Class.util.antiaim.current_settings.fakelag.enabled)

        ui.set(Class.util.reference.aa_fakelag_amount[1], Class.util.antiaim.current_settings.fakelag.amount)

        ui.set(Class.util.reference.aa_fakelag_limit[1], Class.util.antiaim.current_settings.fakelag.limit)

        ui.set(Class.util.reference.aa_fakelag_variance[1], Class.util.antiaim.current_settings.fakelag.variance)

    end



    function Class.util.antiaim.update_fakelag_settings()

        Class.util.antiaim.current_settings.fakelag.enabled = Class.ui.menu.antiaim_tab.other.fakelag.enabled:get()

        Class.util.antiaim.current_settings.fakelag.amount = Class.ui.menu.antiaim_tab.other.fakelag.amount:get()

        Class.util.antiaim.current_settings.fakelag.limit = Class.ui.menu.antiaim_tab.other.fakelag.limit:get()

        

        if Class.ui.menu.antiaim_tab.other.fakelag.variance.randomize:get() > 0 then

            Class.util.antiaim.current_settings.fakelag.variance = math.random(Class.ui.menu.antiaim_tab.other.fakelag.variance.randomize:get(), Class.ui.menu.antiaim_tab.other.fakelag.variance.amount:get())

        else

            Class.util.antiaim.current_settings.fakelag.variance = Class.ui.menu.antiaim_tab.other.fakelag.variance.amount:get()

        end        

    end



    function Class.util.antiaim.handle_antiaim(cmd)

        local lp = entity.get_local_player()

        if not lp or not entity.is_alive(lp) then return end

        

        Class.util.antiaim.current_state = Class.util.antiaim.get_player_state(cmd)

        Class.util.antiaim.current_team = entity.get_prop(lp, "m_iTeamNum") == 2 and "T" or "CT"

        

        Class.util.antiaim.state_index = 1

        for i, state in ipairs(Class.util.antiaim.states) do

            if state == Class.util.antiaim.current_state then

                Class.util.antiaim.state_index = i

                break

            end

        end

        

        if Class.util.antiaim.state_index ~= 1 then

            local settings_table = (Class.util.antiaim.current_team == "T") and Class.ui.antiaim_states_t or Class.ui.antiaim_states_ct

            local current_state_settings = settings_table[Class.util.antiaim.state_index]

            

            if not current_state_settings.override_state:get() then

                Class.util.antiaim.state_index = 1

            end

        end

        

        Class.util.antiaim.update_settings(cmd, Class.util.antiaim.state_index, Class.util.antiaim.current_team)

        Class.util.antiaim.update_fakelag_settings()

        handle_freestanding()

        handle_manual()

        handle_safe_head()

        handle_avoid_backstab()

        handle_antiaim_disablers()

        handle_fast_ladder(cmd)

        Class.util.antiaim.apply_all_settings()

    end

    

end



do  --#region visuals



    Class.visuals = {



        --#region watermark

        watermark = {

            window = nil,

            fps = 0,

            ping = 0,

            last_update_time = 0,

            current_width = 240,



            _parse_gradient_text = function(self, text)

                local prefix = ""

                local body = ""

                local postfix = ""

                

                local prefix_start = text:find("prefix=")

                local body_start = text:find("body=")

                local postfix_start = text:find("postfix=")



                local markers = {}

                if prefix_start then table.insert(markers, {name = "prefix", pos = prefix_start, len = 7}) end

                if body_start then table.insert(markers, {name = "body", pos = body_start, len = 5}) end

                if postfix_start then table.insert(markers, {name = "postfix", pos = postfix_start, len = 8}) end

                

                table.sort(markers, function(a, b) return a.pos < b.pos end)

                

                for i, marker in ipairs(markers) do

                    local start_text = marker.pos + marker.len

                    local end_text = #text + 1

                    

                    if i < #markers then

                        end_text = markers[i + 1].pos

                    end

                    

                    local part_text = text:sub(start_text, end_text - 1)

                    

                    if marker.name == "prefix" then

                        prefix = part_text

                    elseif marker.name == "body" then

                        body = part_text

                    elseif marker.name == "postfix" then

                        postfix = part_text

                    end

                end

                

                return {

                    prefix = prefix,

                    body = body,

                    postfix = postfix,

                    has_markers = #markers > 0

                }

            end,



            setup = function(self)

                self.window = windows.new("watermark", 0.5, 0.9825)

                self.window:set_anchor(vector(0.5, 0))

                

                self.fps = 0

                self.ping = 0

                self.last_update_time = globals.realtime()

                self.current_width = 240

            end,



            render = function(self)

                local watermark = Class.ui.menu.visuals_tab.interface.watermark

                

                local font_mapping = {

                    ["Default"] = "",

                    ["Pixel"] = "-",  

                    ["Bold"] = "b", 

                    ["Large"] = "b+"

                }



                local font_name = font_mapping[watermark.font:get()]

                local window_pos = self.window.pos

                local x, y = window_pos.x, window_pos.y

                

                if watermark.mode:get() == "Default" then

                    local current_time = globals.realtime()



                    if current_time - self.last_update_time > 1.0 then

                        local frametime = globals.absoluteframetime()

                        self.fps = frametime > 0 and math.floor(1 / frametime) or 0

                        self.ping = math.floor(client.latency() * 1000)

                        self.last_update_time = current_time

                    end



                    local main_color_table = {watermark.default_color:get()}

                    local main_color_hex = string.format("%02x%02x%02x%02x", main_color_table[1], main_color_table[2], main_color_table[3], main_color_table[4])

                    local separator_color_hex = Class.util:rgba_to_hex(Class.util.accent_color.separator[1], Class.util.accent_color.separator[2], Class.util.accent_color.separator[3], Class.util.accent_color.separator[4])



                    local lua_name = Class.util:get_lua_name(true)

                    local username = Class.util:get_username(true)

                    local watermark_text = string.format(

                        "\a%s%s\a%s |\a%s %s\a%s |\a%s %d fps\a%s |\a%s %s",

                        main_color_hex, lua_name,

                        separator_color_hex,

                        main_color_hex, username,

                        separator_color_hex,

                        main_color_hex, self.fps,

                        separator_color_hex,

                        main_color_hex, self.ping == 0 and "localhost" or string.format("%d ms", self.ping)

                    )



                    local text_width = renderer.measure_text("", watermark_text)

                    local padding = 35

                    local target_width = text_width + padding



                    self.current_width = Class.motion.exponential_smooth(self.current_width, target_width, 0.15)



                    Class.render.panels:render(x, y, self.current_width, 26, 8, "logo", Class.util.accent_color.background, main_color_table)

                    renderer.text(x + 26, y + 6, 255, 255, 255, 255, "", nil, watermark_text)

                    

                    self.window:set_size(vector(self.current_width, 26))

                    self.window:update()

                    

                    return

                end



                local custom_text = watermark.text:get()

                local color_mode = watermark.color_mode:get()

                local text_width, text_height

                

                if color_mode == 2 then

                    local first_color = {watermark.gradient.color.first:get()}

                    local second_color = {watermark.gradient.color.second:get()}

                    local prefix_color = {watermark.gradient.color.prefix:get()}

                    local postfix_color = {watermark.gradient.color.postfix:get()}

                    local gradient_speed = watermark.gradient.speed:get() / 10

                    local gradient_direction = watermark.gradient.direction:get()

                    

                    local parsed_text = self:_parse_gradient_text(custom_text)

                    local current_x = x

                    

                    if parsed_text.has_markers then

                        if parsed_text.prefix ~= "" then

                            renderer.text(current_x, y, prefix_color[1], prefix_color[2], prefix_color[3], prefix_color[4], font_name, nil, parsed_text.prefix)

                            current_x = current_x + renderer.measure_text(font_name, parsed_text.prefix)

                        end

                        

                        if parsed_text.body ~= "" then

                            local gradient_body = Class.render.gradient_text(

                                parsed_text.body, gradient_speed, gradient_direction,

                                first_color[1], first_color[2], first_color[3], first_color[4],

                                second_color[1], second_color[2], second_color[3], second_color[4]

                            )



                            renderer.text(current_x, y, 255, 255, 255, 255, font_name, nil, gradient_body)

                            current_x = current_x + renderer.measure_text(font_name, parsed_text.body)

                        end

                        

                        if parsed_text.postfix ~= "" then

                            renderer.text(current_x, y, postfix_color[1], postfix_color[2], postfix_color[3], postfix_color[4], font_name, nil, parsed_text.postfix)

                        end

                        

                        local full_text = parsed_text.prefix .. parsed_text.body .. parsed_text.postfix

                        text_width, text_height = renderer.measure_text(font_name, full_text)

                    else

                        local gradient_text = Class.render.gradient_text(

                            custom_text, gradient_speed, gradient_direction,

                            first_color[1], first_color[2], first_color[3], first_color[4],

                            second_color[1], second_color[2], second_color[3], second_color[4]

                        )



                        renderer.text(x, y, 255, 255, 255, 255, font_name, nil, gradient_text)

                        text_width, text_height = renderer.measure_text(font_name, gradient_text)

                    end  

                elseif color_mode == 3 then

                    local rainbow_speed = watermark.rainbow.speed:get() / 10

                    local rainbow_saturation = watermark.rainbow.saturation:get() / 10

                    local rainbow_direction = watermark.rainbow.direction:get()

                    

                    local rainbow_text = Class.render.rainbow_text(custom_text, rainbow_speed, rainbow_direction, 255, rainbow_saturation)

                    renderer.text(x, y, 255, 255, 255, 255, font_name, nil, rainbow_text)

                    text_width, text_height = renderer.measure_text(font_name, rainbow_text)      

                else

                    local default_color = {watermark.default.color:get()}

                    renderer.text(x, y, default_color[1], default_color[2], default_color[3], default_color[4], font_name, nil, custom_text)

                    text_width, text_height = renderer.measure_text(font_name, custom_text)

                end

                        

                self.window:set_size(vector(text_width, text_height))

                self.window:update()

            end

        },

        --#endregion



        --#region velocity_indicator

        velocity_indicator = {

            window = nil,

            alpha = 0,



            setup = function(self)

                self.window = windows.new("velocity_indicator", 0.5, 0.9825)

                self.window:set_anchor(vector(0.5, 0))

            end,



            render = function(self)

                local velocity_indicator = Class.ui.menu.visuals_tab.interface.velocity_indicator

                if not velocity_indicator.enabled:get() then

                    return

                end   



                local me = entity.get_local_player()

                if not me then 

                    return

                end



                local width, height = 150, 25

                local color = { velocity_indicator.color:get() }



                local window = self.window

                local pos = window.pos:clone()



                local x, y = pos.x, pos.y



                local modifier = entity.get_prop(me, "m_flVelocityModifier")

                local alive_check = entity.is_alive(me)

                local velocity_check = modifier < 1.0

            

                local menu_check = ui.is_menu_open()   



                local is_interface_active = velocity_indicator.enabled:get() and ((alive_check and velocity_check) or menu_check)



                self.alpha = Class.motion.interpolation(self.alpha, is_interface_active, 0.045)   

                

                local velocity_reduction = 1 - modifier 

                local percent = velocity_reduction * 100 



                if menu_check and (not alive_check or not velocity_check) then

                    local demo_value = math.abs(math.sin(globals.tickcount() * 0.02))

                    velocity_reduction = demo_value

                    percent = demo_value * 100

                end

                

                if self.alpha > 0 then

                    Class.render.panels:render(x, y, width, height, 8, "warning", {Class.util.accent_color.background[1], Class.util.accent_color.background[2], Class.util.accent_color.background[3], Class.util.accent_color.background[4] * self.alpha}, {color[1], color[2], color[3], color[4] * self.alpha})

                    renderer.text(x + 26, y + 6, 245, 245, 245, 255 * self.alpha, nil, nil, string.format("velocity reduced to %d%%", math.floor(percent)))

                end



                window:set_size(vector(width, height))

                window:update()     

            end

        },

        --#endregion



        --#region custom_scope

        custom_scope = {

            alpha = 0,

            original_overlay_state = nil,



            interpolated_values = {

                first_offset = 0,

                second_offset = 0

            },            



            overlay_handler = {

                set_true = function() ui.set(Class.util.reference.visuals_scope_overlay, true) end,

                set_false = function() ui.set(Class.util.reference.visuals_scope_overlay, false) end

            },

            

            _update_overlay = function(self)

                local custom_scope = Class.ui.menu.visuals_tab.interface.custom_scope

                if custom_scope.enabled:get() then

                    if self.original_overlay_state == nil then

                       self.original_overlay_state = ui.get(Class.util.reference.visuals_scope_overlay)

                    end

                    

                    client.set_event_callback("paint", self.overlay_handler.set_false)

                    client.set_event_callback("paint_ui", self.overlay_handler.set_true)

                else

                    self.alpha = 0

                    client.unset_event_callback("paint", self.overlay_handler.set_false)

                    client.unset_event_callback("paint_ui", self.overlay_handler.set_true)

                    

                    if self.original_overlay_state ~= nil then

                        ui.set(Class.util.reference.visuals_scope_overlay, self.original_overlay_state)

                        self.original_overlay_state = nil

                    end

                end            

            end,

            

            render = function(self)

                local custom_scope = Class.ui.menu.visuals_tab.interface.custom_scope

                self:_update_overlay()

                if not custom_scope.enabled:get() then 

                    return

                end



                local me = entity.get_local_player()

                if not me then 

                    return

                end

                

                local screen = vector(client.screen_size())

                local first_offset = custom_scope.offset.first:get()

                local second_offset = custom_scope.offset.second:get()

                

                self.interpolated_values.first_offset = Class.motion.interpolation(self.interpolated_values.first_offset, first_offset, 0.075)

                self.interpolated_values.second_offset = Class.motion.interpolation(self.interpolated_values.second_offset, second_offset, 0.075)

                

                local initial_position = self.interpolated_values.first_offset * screen.y / 1080

                local offset = self.interpolated_values.second_offset * screen.y / 1080

                

                local speed = 8

                local color = { custom_scope.color:get() }

                

                local wpn = entity.get_player_weapon(me)

                local scope_level = entity.get_prop(wpn, "m_zoomLevel")

                local scoped = entity.get_prop(me, "m_bIsScoped") == 1

                local resume_zoom = entity.get_prop(me, "m_bResumeZoom") == 1

                local is_valid = entity.is_alive(me) and wpn ~= nil and scope_level ~= nil

                

                local act = is_valid and scope_level > 0 and scoped and not resume_zoom

                

                local texture_1 = renderer.load_svg([[<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg"><defs><linearGradient id="grad1" x1="100%" y1="100%" x2="0%" y2="0%"><stop offset="0%" stop-color="white" stop-opacity="1"/><stop offset="100%" stop-color="white" stop-opacity="0"/></linearGradient></defs><line x1="100" y1="100" x2="0" y2="0" stroke="url(#grad1)" stroke-width="1.5"/></svg>]], offset, offset)

                local texture_2 = renderer.load_svg([[<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg"><defs><linearGradient id="grad1" x1="0%" y1="100%" x2="100%" y2="0%"><stop offset="0%" stop-color="white" stop-opacity="1"/><stop offset="100%" stop-color="white" stop-opacity="0"/></linearGradient></defs><line x1="0" y1="100" x2="100" y2="0" stroke="url(#grad1)" stroke-width="1.5"/></svg>]], offset, offset)

                local texture_3 = renderer.load_svg([[<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg"><defs><linearGradient id="grad1" x1="100%" y1="0%" x2="0%" y2="100%"><stop offset="0%" stop-color="white" stop-opacity="1"/><stop offset="100%" stop-color="white" stop-opacity="0"/></linearGradient></defs><line x1="100" y1="0" x2="0" y2="100" stroke="url(#grad1)" stroke-width="1.5"/></svg>]], offset, offset)

                local texture_4 = renderer.load_svg([[<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg"><defs><linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="100%"><stop offset="0%" stop-color="white" stop-opacity="1"/><stop offset="100%" stop-color="white" stop-opacity="0"/></linearGradient></defs><line x1="0" y1="0" x2="100" y2="100" stroke="url(#grad1)" stroke-width="1.5"/></svg>]], offset, offset)

                

                local FT = speed > 3 and globals.frametime() * speed or 1

                local alpha = Class.util.clamp(self.alpha, 0, 1)

                

                if custom_scope.mode:get() == 1 then

                    renderer.gradient(screen.x / 2 - initial_position + 2, screen.y / 2, initial_position - offset, 1, color[1], color[2], color[3], 0, color[1], color[2], color[3], alpha * color[4], true)

                    renderer.gradient(screen.x / 2 + offset, screen.y / 2, initial_position - offset, 1, color[1], color[2], color[3], alpha * color[4], color[1], color[2], color[3], 0, true)

                    renderer.gradient(screen.x / 2, screen.y / 2 - initial_position + 2, 1, initial_position - offset, color[1], color[2], color[3], 0, color[1], color[2], color[3], alpha * color[4], false)

                    renderer.gradient(screen.x / 2, screen.y / 2 + offset, 1, initial_position - offset, color[1], color[2], color[3], alpha * color[4], color[1], color[2], color[3], 0, false)

                else

                    renderer.texture(texture_1, screen.x / 2 - offset - initial_position, screen.y / 2 - offset - initial_position, offset, offset, color[1], color[2], color[3], alpha * color[4])

                    renderer.texture(texture_2, screen.x / 2 + initial_position, screen.y / 2 - offset - initial_position, offset, offset, color[1], color[2], color[3], alpha * color[4])

                    renderer.texture(texture_3, screen.x / 2 - offset - initial_position, screen.y / 2 + initial_position, offset, offset, color[1], color[2], color[3], alpha * color[4])

                    renderer.texture(texture_4, screen.x / 2 + initial_position, screen.y / 2 + initial_position, offset, offset, color[1], color[2], color[3], alpha * color[4])

                end



                self.alpha = Class.util.clamp(self.alpha + (act and FT or -FT), 0, 1)     

            end

        },

        --#endregion



        --#region aspect_ratio

        aspect_ratio = {

            value = 0,



            update = function(self)

                local aspect_ratio = Class.ui.menu.visuals_tab.other.aspect_ratio



                if not aspect_ratio.enabled:get() then 

                    cvar.r_aspectratio:set_float(0) 

                    return

                end



                local presets = {

                    [1] = function() return aspect_ratio.amount:get() / 100 end,

                    [2] = 1.25,  

                    [3] = 1.333, 

                    [4] = 1.6,    

                    [5] = 1.777        

                }



                local target

                if aspect_ratio.enabled:get() then

                    local preset = aspect_ratio.preset:get()

                    local value = presets[preset]

                    target = type(value) == "function" and value() or value

                else

                    target = 0

                end



                self.value = Class.motion.interpolation(self.value, target, 0.075)

                

                cvar.r_aspectratio:set_float(self.value)   

            end

        },

        --#endregion



        --#region viewmodel_changer

        viewmodel_changer = {

            current_offset_x = 0,

            current_offset_y = 0,

            current_offset_z = 0,



            saved_target_x = 0,

            saved_target_y = 0,

            saved_target_z = 0,



            last_hand_state = nil,

            recoil_active = false,

            recoil_end_time = 0,



            on_aim_fire = function(self)

                local viewmodel_changer = Class.ui.menu.visuals_tab.other.viewmodel_changer



                if not viewmodel_changer.enabled:get() then

                    return

                end

                

                if not viewmodel_changer.fire_animation:get() then

                    return

                end

                

                self.saved_target_x = viewmodel_changer.position.x:get() / 10

                self.saved_target_y = viewmodel_changer.position.y:get() / 10

                self.saved_target_z = viewmodel_changer.position.z:get() / 10

                

                self.recoil_active = true

                self.recoil_end_time = globals.realtime() + 1.0             

            end,



            update = function(self)

                local viewmodel_changer = Class.ui.menu.visuals_tab.other.viewmodel_changer



                if not viewmodel_changer.enabled:get() then

                    Class.util:reset_viewmodel()



                    self.current_offset_x, self.current_offset_y, self.current_offset_z = 0, 0, 0

                    self.last_hand_state = nil

                    self.recoil_active = false

                    return

                end



                local target_x, target_y, target_z

                

                if self.recoil_active then

                    if globals.realtime() >= self.recoil_end_time then

                        self.recoil_active = false

                        target_x = self.saved_target_x

                        target_y = self.saved_target_y

                        target_z = self.saved_target_z

                    else

                        target_x = -5.75

                        target_y = 1.0 

                        target_z = 0.5

                    end

                else

                    target_x = viewmodel_changer.position.x:get() / 10

                    target_y = viewmodel_changer.position.y:get() / 10

                    target_z = viewmodel_changer.position.z:get() / 10

                end



                self.current_offset_x = Class.motion.exponential_smooth(self.current_offset_x, target_x, 0.25)

                self.current_offset_y = Class.motion.exponential_smooth(self.current_offset_y, target_y, 0.25)

                self.current_offset_z = Class.motion.exponential_smooth(self.current_offset_z, target_z, 0.25)



                cvar.viewmodel_offset_x:set_raw_float(self.current_offset_x)

                cvar.viewmodel_offset_y:set_raw_float(self.current_offset_y)

                cvar.viewmodel_offset_z:set_raw_float(self.current_offset_z)

                cvar.hide_view_model_zoomed = true



                if viewmodel_changer.knife_reverse:get() then

                    local me = entity.get_local_player()



                    if not me then

                        return

                    end



                    local weapon = entity.get_player_weapon(me)

                    if weapon and entity.get_classname(weapon) == "CKnife" then

                        local main_hand = viewmodel_changer.main_hand:get()

                        local knife_hand = 2 - main_hand

                        

                        if self.last_hand_state ~= knife_hand then

                            cvar.cl_righthand:set_int(knife_hand)

                            self.last_hand_state = knife_hand

                        end

                    else

                        local main_hand = 1 - viewmodel_changer.main_hand:get()

                        if self.last_hand_state ~= main_hand then

                            cvar.cl_righthand:set_int(main_hand)

                            self.last_hand_state = main_hand

                        end

                    end                    

                end 

            end

        },

        --#endregion



        --#region disable_post_proccesing

        disable_post_proccesing = {



            setup = function(self)

                local disable_post_proccesing = Class.ui.menu.visuals_tab.other.disable_post_proccesing



                disable_post_proccesing.enabled:set_callback(function()

                    if disable_post_proccesing.enabled:get() then

                        Class.util:setup_post_proccesing()

                    else

                        Class.util:reset_post_proccesing()

                    end

                end)      

            end



        },

        --#endregion



        --#region animation_breaker

        animation_breaker = {

            _ffi_helper = function(self, cmd)

                if not pcall(ffi.typeof, "bt_cusercmd_t") then

                    ffi.cdef[[

                        typedef struct {

                            struct bt_cusercmd_t (*cusercmd)();

                            int     command_number;

                            int     tick_count;

                            float   view[3];

                            float   aim[3];

                            float   move[3];

                            int     buttons;

                        } bt_cusercmd_t;

                    ]]

                end



                if not pcall(ffi.typeof, "bt_get_usercmd") then

                    ffi.cdef[[

                        typedef bt_cusercmd_t*(__thiscall* bt_get_usercmd)(void* input, int, int command_number);

                    ]]

                end



                local vtbl = ffi.cast("void***", ffi.cast("void**", ffi.cast("uintptr_t", client.find_signature("client.dll", "\xB9\xCC\xCC\xCC\xCC\x8B\x40\x38\xFF\xD0\x84\xC0\x0F\x85") or error("[animation breaker] cannot call this c function")) + 1)[0])

                local location = ffi.cast("bt_get_usercmd", vtbl[0][8])



                return (location(vtbl, 0, cmd))                

            end,



            _update_anim_overlay = function(self, overlay_index, weight)

                local me = entity.get_local_player()

                local self_index = c_entity.new(me)

                local overlay = self_index:get_anim_overlay(overlay_index)

                if overlay then

                    overlay.weight = weight

                end                

            end,



            _ground_animations = function(self, velocity, anim_overlay)

                local animation_breaker = Class.ui.menu.visuals_tab.other.animation_breaker



                if not animation_breaker.triggers:get("Ground") then

                    return

                end



                local me = entity.get_local_player()

                local in_air = bit.band(entity.get_prop(me, 'm_fFlags'), 1) ~= 1

                if in_air then 

                    return

                end



                local breaker_value = animation_breaker.ground.amount:get() / 10

                local ticks_amount = 4



                local breaker_mode = animation_breaker.ground.mode:get()

                

                local reference = Class.util.reference

                local legs_movement = "Off"



                if breaker_mode == "Static" then

                    entity.set_prop(me, "m_flPoseParameter", 1, 0)

                    legs_movement = "Always slide"



                elseif breaker_mode == "Jitter" then

                    legs_movement = "Always slide"

                    entity.set_prop(me, "m_flPoseParameter", (globals.tickcount() % ticks_amount > 1) and breaker_value or 0, 0)



                elseif breaker_mode == "Modern" then

                    legs_movement = client.random_int(1, 2) == 1 and "Off" or "Always slide"

                    entity.set_prop(me, "m_flPoseParameter", client.random_float(0.1, 1), 0)



                    if velocity >= 3 then

                        anim_overlay.weight = 1

                    end



                elseif breaker_mode == "Broken" then

                    legs_movement = "Off"

                    entity.set_prop(me, "m_flPoseParameter", client.random_float(0.1, 1), 3)

                    entity.set_prop(me, "m_flPoseParameter", client.random_float(0.1, 1), 7)

                    entity.set_prop(me, "m_flPoseParameter", client.random_float(0.1, 1), 6)

                end



                ui.set(reference.aa_legs_movement[1], legs_movement)   

            end,



            _air_animations = function(self)

                local animation_breaker = Class.ui.menu.visuals_tab.other.animation_breaker



                if not animation_breaker.triggers:get("Air") then

                    return

                end



                local me = entity.get_local_player()

                local in_air = bit.band(entity.get_prop(me, 'm_fFlags'), 1) ~= 1

                if not in_air then 

                    return

                end



                local breaker_mode = animation_breaker.air.mode:get()

                local breaker_value = animation_breaker.air.amount:get() / 10



                if breaker_mode == "Static" then

                    entity.set_prop(me, "m_flPoseParameter", breaker_value, 6)

                elseif breaker_mode == "Jitter" then

                    entity.set_prop(me, "m_flPoseParameter", client.random_float(0.1, 1), 6)

                elseif breaker_mode == "Broken" then

                    entity.set_prop(me, "m_flPoseParameter", client.random_float(0.1, 1), 3)

                    entity.set_prop(me, "m_flPoseParameter", client.random_float(0.1, 1), 7)

                    entity.set_prop(me, "m_flPoseParameter", client.random_float(0.1, 1), 6)

                end    

            end,



            _extra_animations = function(self, cmd)

                local animation_breaker = Class.ui.menu.visuals_tab.other.animation_breaker



                if not animation_breaker.triggers:get("Tweaks") then

                    return

                end

                

                local me = entity.get_local_player()

                local breaker_mode = animation_breaker.tweaks.mode

                local breaker_value = animation_breaker.tweaks.amount:get() / 10



                if breaker_mode:get("Lizginka") then

                    self:_update_anim_overlay(7, client.random_float(0.9, 1))

                    entity.set_prop(me, "m_flPoseParameter", (globals.tickcount() % 3 > 1) and 0.9 or 0, 0)

                end



                if breaker_mode:get("Body Lean") then

                    self:_update_anim_overlay(12, breaker_value)

                end



                if breaker_mode:get("Earthshake") then

                    self:_update_anim_overlay(12, client.random_float(0.1, 1))

                end



                if breaker_mode:get("Movement On Peek Assist") and ui.get(Class.util.reference.rage_peek_assist[2]) then

                    local move_type = entity.get_prop(me, "m_MoveType")

                    if move_type == 2 then

                        local command = self:_ffi_helper(cmd.command_number)



                        if command then

                            command.buttons = bit.band(command.buttons, bit.bnot(8))

                            command.buttons = bit.band(command.buttons, bit.bnot(16))

                            command.buttons = bit.band(command.buttons, bit.bnot(512))

                            command.buttons = bit.band(command.buttons, bit.bnot(1024))

                        end

                    end

                end 

            end,



            update = function(self, cmd)

                local animation_breaker = Class.ui.menu.visuals_tab.other.animation_breaker



                if not animation_breaker.enabled:get() then 

                    return

                end



                local me = entity.get_local_player()

                if not me or not entity.is_alive(me) then 

                    return

                end



                local self_index = c_entity.new(me)

                local self_anim_state = self_index:get_anim_state()

                if not self_anim_state then 

                    return

                end



                local anim_overlay = self_index:get_anim_overlay(12)

                if not anim_overlay then 

                    return

                end



                local velocity = math.abs(entity.get_prop(me, "m_vecVelocity[0]") or 0)

                if velocity >= 3 then 

                    anim_overlay.weight = 1 

                end



                self:_ground_animations(velocity, anim_overlay)

                self:_air_animations()

                self:_extra_animations(cmd)   

            end

        }

        --#endregion

    }

    

end  --#endregion 



do  --#region misc



    Class.misc = {



        --#region info_logger

        info_logger = {

            last_bullet_impact = nil,

            last_shot = nil,

            hitgroups = {"generic", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "?", "gear"},



            _calculate_spread = function(self)

                if not self.last_shot or not self.last_shot.eye_pos or not self.last_shot.shot_pos or not self.last_bullet_impact then

                    return "0.0°"

                end

                

                local aim_direction = self.last_shot.shot_pos - self.last_shot.eye_pos

                local aim_angles = aim_direction:angles()

                

                local shot_direction = self.last_bullet_impact.shot_pos - self.last_shot.eye_pos

                local shot_angles = shot_direction:angles()

                

                local spread_vector = vector(aim_angles - shot_angles)

                local spread_value = spread_vector:length2d()

                

                return string.format("%.1f°", spread_value)                    

            end,



            on_bullet_impact = function(self, cmd)

                local tick = globals.tickcount()

                local me = entity.get_local_player()

                local user = client.userid_to_entindex(cmd.userid)

                

                if user == me then

                    self.last_bullet_impact = {

                        tick = tick,

                        eye_pos = vector(client.eye_position()),

                        shot_pos = vector(cmd.x, cmd.y, cmd.z),

                        weapon = entity.get_classname(entity.get_player_weapon(me)),

                        time = globals.curtime()

                    }

                end                    

            end,



            on_aim_fire = function(self, cmd)

                self.last_bullet_impact = nil

    

                self.last_shot = {

                    target = cmd.target,

                    x = cmd.x,

                    y = cmd.y,

                    z = cmd.z,

                    tick = cmd.tick,

                    damage = cmd.damage,

                    hitchance = cmd.hit_chance,

                    hitbox = cmd.hitgroup,

                    eye_pos = vector(client.eye_position()),

                    shot_pos = vector(cmd.x, cmd.y, cmd.z),

                    backtrack = globals.tickcount() - cmd.tick,

                    time = globals.curtime()

                } 

            end,



            on_aim_hit = function(self, cmd)

                local info_logger = Class.ui.menu.misc_tab.info_logger



                if not info_logger.enabled:get() then

                    return

                end



                if not info_logger.triggers:get("Hit") then 

                    return

                end

                

                if not self.last_shot then

                    return

                end

                

                local r, g, b = info_logger.color.hit:get()

                

                local highlight_color = {r, g, b}

                local white_color = {245, 245, 245}

                

                local target_name = entity.get_player_name(cmd.target)

                local hitbox = self.hitgroups[cmd.hitgroup + 1] or "?"

                local damage = tostring(cmd.damage)

                

                local remaining_health = tostring(entity.get_prop(cmd.target, "m_iHealth"))

                local wanted_hitbox = self.hitgroups[self.last_shot.hitbox + 1] or "?"

                local wanted_damage = tostring(self.last_shot.damage)

                local backtrack = tostring(self.last_shot.backtrack)

                local spread = self:_calculate_spread()

                

                local message = {

                    { text = "amethyst: ", color = highlight_color },

                    { text = "hit ", color = white_color },

                    { text = target_name, color = highlight_color },

                    { text = "'s ", color = white_color },

                    { text = hitbox, color = highlight_color },

                    { text = " for ", color = white_color },

                    { text = damage, color = highlight_color },

                    { text = " damage", color = white_color },

                    { text = " (hp: ", color = white_color },

                    { text = remaining_health, color = highlight_color },

                    { text = ")", color = white_color },

                    { text = " (bt: ", color = white_color },

                    { text = backtrack, color = highlight_color },

                    { text = " ◦", color = white_color },

                    { text = " dmg: ", color = white_color },

                    { text = wanted_damage, color = highlight_color },

                    { text = " ◦ aim: ", color = white_color },    

                    { text = wanted_hitbox, color = highlight_color },    

                    { text = ") (spread: ", color = white_color },

                    { text = spread, color = highlight_color },

                    { text = ")\n", color = white_color }

                }



                -- (bt: /v%s/r ◦ dmg: /v%s/r ◦ aim: /v%s/r)

                Class.render.notifications:push(string.format("/vhit /r%s/r's /v%s/r for /v%s/r damage", target_name, hitbox, damage), "success", highlight_color)

                Class.util.output_message(message)

                self.last_shot = nil     

            end,



            on_aim_miss = function(self, cmd)

                local info_logger = Class.ui.menu.misc_tab.info_logger



                if not info_logger.enabled:get() then

                    return

                end



                if not info_logger.triggers:get("Miss") then 

                    return

                end

                

                if not self.last_shot then

                    return

                end

                

                local r, g, b = info_logger.color.miss:get()

                local highlight_color = {r, g, b}

                local white_color = {245, 245, 245}



                local target_name = entity.get_player_name(cmd.target)

                local hitbox = self.hitgroups[cmd.hitgroup + 1] or "?"

                local reason = cmd.reason == "?" and "correction" or cmd.reason

                local backtrack = tostring(self.last_shot.backtrack)

                local hitchance = string.format("%d%%", self.last_shot.hitchance)

                local damage = tostring(self.last_shot.damage)

                local spread = self:_calculate_spread()



                local message = {

                    { text = "amethyst: ", color = highlight_color },

                    { text = "missed ", color = white_color },

                    { text = target_name, color = highlight_color },

                    { text = "'s ", color = white_color },

                    { text = hitbox, color = highlight_color },

                    { text = " due to ", color = white_color },

                    { text = reason, color = highlight_color },

                    { text = " (bt: ", color = white_color },

                    { text = backtrack, color = highlight_color },

                    { text = " ◦", color = white_color },

                    { text = " hc: ", color = white_color },

                    { text = hitchance, color = highlight_color },

                    { text = " ◦ dmg: ", color = white_color },    

                    { text = damage, color = highlight_color },    

                    { text = ") (spread: ", color = white_color },

                    { text = spread, color = highlight_color },

                    { text = ")\n", color = white_color }

                }



                --(bt: /v%s/r ◦ hc: /v%s/r ◦ dmg: /v%s/r)

                Class.render.notifications:push(string.format("/vmissed/r %s's /v%s/r due to /v%s/r", target_name, hitbox, reason, backtrack, hitchance, damage), "failed", highlight_color)

                Class.util.output_message(message)

                self.last_shot = nil

            end,



            on_player_hurt = function(self, cmd)

                local info_logger = Class.ui.menu.misc_tab.info_logger



                if not info_logger.enabled:get() then

                    return

                end



                if not info_logger.triggers:get("Hit") then 

                    return

                end 

                

                local me = entity.get_local_player()

                local attacker = client.userid_to_entindex(cmd.attacker)

                local r, g, b = info_logger.color.hit:get()

                local highlight_color = {r, g, b}

                local white_color = {245, 245, 245}

                

                if (cmd.weapon == "inferno" or cmd.weapon == "smokegrenade" or cmd.weapon == "hegrenade" or cmd.weapon == "knife") and client.userid_to_entindex(cmd.userid) ~= me and attacker == me then

                    

                    local target_name = entity.get_player_name(client.userid_to_entindex(cmd.userid))

                    local damage = tostring(cmd.dmg_health)

                    local weapon = cmd.weapon

                    local remaining_health = cmd.health



                    local message = {

                        { text = "amethyst: ", color = highlight_color },

                        { text = "damaged ", color = white_color },

                        { text = target_name, color = highlight_color },

                        { text = " for ", color = white_color },

                        { text = damage, color = highlight_color },

                        { text = " damage with ", color = white_color },

                        { text = weapon, color = highlight_color },

                        { text = " (remaining health: ", color = white_color },

                        { text = remaining_health, color = highlight_color },

                        { text = ")\n", color = white_color }

                    }

                    

                    -- (remaining health: /v%s/r)

                    Class.render.notifications:push(string.format("/vdamaged/r %s for /v%s/r damage with /v%s/r", target_name, damage, weapon), "success", highlight_color)

                    Class.util.output_message(message)

                end  

            end,



            on_item_purchase = function(self, cmd)

                local info_logger = Class.ui.menu.misc_tab.info_logger



                if not info_logger.enabled:get() then

                    return

                end



                if not info_logger.triggers:get("Purchase") then 

                    return

                end

                

                local purchaser = client.userid_to_entindex(cmd.userid)

                if not purchaser or purchaser == 0 or purchaser == entity.get_local_player() then

                    return

                end

                

                local target_name = entity.get_player_name(purchaser)

                if not target_name then

                    return

                end

                

                local r, g, b = info_logger.color.hit:get()

                local highlight_color = {r, g, b}

                local white_color = {245, 245, 245}

                

                local weapon_name = cmd.weapon

                if weapon_name then

                    weapon_name = weapon_name:gsub("^%l", string.lower)

                else

                    weapon_name = "unknown"

                end



                local message = {

                    { text = "amethyst: ", color = highlight_color },

                    { text = target_name, color = highlight_color },

                    { text = " bought ", color = white_color },

                    { text = weapon_name, color = highlight_color },

                    { text = "\n", color = white_color }

                }

                

                Class.util.output_message(message)

            end  

        }, 

        --#endregion



        --#region console_enhancement

        console_enhancement = {

            console_cleaner = {

                on_level_init = function(self)

                    if not Class.ui.menu.misc_tab.console_enhancement.enabled:get() then 

                        return

                    end



                    if not Class.ui.menu.misc_tab.console_enhancement.mode:get("Clean On Level Init") then

                        return

                    end



                    client.exec("clear")   

                end

            },



            console_filter = {

                _toggle = function(self)

                    if not Class.ui.menu.misc_tab.console_enhancement.enabled:get() then

                        Class.util:reset_console_filter()

                        return

                    end



                    if not Class.ui.menu.misc_tab.console_enhancement.mode:get("Console Filter") then

                        Class.util:reset_console_filter()

                        return

                    end



                    Class.util:setup_console_filter()

                end,



                setup = function(self)

                    Class.ui.menu.misc_tab.console_enhancement.enabled:set_callback(function()

                        self:_toggle()

                    end)          

                    

                    Class.ui.menu.misc_tab.console_enhancement.mode:set_callback(function()

                        self:_toggle()

                    end)                   

                end                

            },

        },

        --#endregion



        --#region trash_talk

        trash_talk = {

            sponsor_phrases = {

                "Чек на 500 USDT ($498.92) Получить 500 USDT",

                "aircrouch раздает ключи на свою луа! напиши ему в лс слово 'КЛЮЧ' и получи месяц кайфа с топовым скриптом",

                "Розыгрыш Backwoods Honey!  Участвуйте в нашем розыгрыше тут - t.me/beseted",

                "Смотри, как я летаю (thanks aircrouch)! Смотри, как ты падаешь (thanks amethyst.realm)!",

                "Пока ты копил на еду, я купил amethyst.realm. Теперь ты копишь на респаун.",

                "тиктокершу заставили снять это... выложили в t.me/centity",

                "иван погиб на украине... теперь это призрак сургута [◣◢]",

                "по поводу настроек на кряк - aircrouch",

                "Иван Москалев — 22:47 я так пиздато аметист настроил",

                "ᴨᴩᴇждᴇ чᴇʍ ɜᴧᴏбиᴛьᴄя нᴀ ʍиᴩ, ɜᴀдᴀй ᴄᴇбᴇ ʙᴏᴨᴩᴏᴄ: ᴀ нᴇ ᴨᴩᴏбᴧᴇʍᴀ ᴧи ʙ ᴛᴏʍ, чᴛᴏ у ᴛᴇбя нᴇᴛ amethyst.realm?",

                "ᴄʙᴏбᴏдᴀ нᴀᴄᴛуᴨᴀᴇᴛ ᴛᴏᴦдᴀ, ᴋᴏᴦдᴀ ᴛы ᴨᴇᴩᴇᴄᴛᴀᴇɯь ᴦᴏʙᴏᴩиᴛь 'ᴇᴄᴧи бы' и ᴨᴏᴋуᴨᴀᴇɯь amethyst.realm.",

                "ᴛʙᴏи дᴇньᴦи ᴨᴩᴏᴨᴀᴧи ʙʍᴇᴄᴛᴇ ᴄ ᴛʙᴏиʍ ᴨᴏᴛᴇнциᴀᴧᴏʍ, ᴀ ʍᴏи — инʙᴇᴄᴛиᴩᴏʙᴀны ʙ amethyst.realm.",

                "ᴇᴄᴧи ᴛʙᴏя дᴇʙуɯᴋᴀ ᴛᴀᴋᴀя уʍнᴀя, ᴨᴏчᴇʍу ᴏнᴀ ᴇɯᴇ нᴇ ᴋуᴨиᴧᴀ ᴛᴇбᴇ amethyst.realm?",

                "я ᴨодᴀᴩиᴧ иʍ ʙᴄᴇʍ ᴨо ᴋᴧиᴨу, ʙᴇдь ᴨодᴀᴩиᴧ иʍ биᴧдᴇᴩ оᴛ amethyst.realm.",

                "ᴋоᴦдᴀ ᴛы дᴇᴧᴀᴇɯь ᴋᴧиᴨ, ʙᴄᴇ дуʍᴀюᴛ, чᴛо ϶ᴛо ʙᴇзᴇниᴇ. ᴀ ᴋоᴦдᴀ я дᴇᴧᴀю ᴋᴧиᴨ — ʙᴄᴇ ᴨониʍᴀюᴛ, чᴛо ϶ᴛо amethyst.realm",

                "->‌ ‌am‌et‌hy‌st.pub/b‌uy‌.ph‌p ‌<-",

                "как ты на еду накопил даже не знаю ))))))))",

                "дeтsкое πо́pнò t.me/calceated Toльkо пo этoй ccылkе aктyaльныe ƃoты",

                "твою маму ебал бы, но она слишком дешевая даже для бомжа",

                "держи ✈ и лети нахуй! спонсор билета - amethyst.realm",

                "amethyst в крови, ты в говне, жиробас ебаный",

                "вбив голды standoff 2 - t.me/renderers",

                "лучшая нейросеть для удаления одежды - t.me/beseted",

                "сладких снов хуесос ебаный",

                "молекула говна ебучая",

                "иди посмотри nolove там ты научишься играть хотя бы долбоёб ебаный",

                "«Шерлок Бот». Если информация существует — я её найду.",

                "#bless_amethyst #ты_бомж #лети_нахуй",

                "веселый роджер",

                "лучшее интимное отбеливание / омоложение - t.me/renderers",

                "разобью ваш автомобиль - t.me/renderers",

                "услуги киллера - t.me/renderers"

            },



            _send_message = function(self, delay, message)

                client.delay_call(delay, function()

                    client.exec(string.format("say %s", message))

                end)

            end,



            _send_trash_talk_message = function(self, attacker, victim)

                if not Class.ui.menu.misc_tab.trash_talk.enabled:get() then

                    return

                end



                local me = entity.get_local_player()



                if attacker ~= me then

                    return

                end



                if victim == me then

                    return

                end



                local mode = Class.ui.menu.misc_tab.trash_talk.mode:get()



                if mode == "Sponsor" then

                    local phrase = self.sponsor_phrases[math.random(1, #self.sponsor_phrases)]

                    local delay = math.random(1, 5) / 10

                    self:_send_message(delay, phrase)

                elseif mode == "Ragebait" then

                    if math.random(1, 10) <= 8 then

                        self:_send_message(0.25, "1")

                    else

                        local random = math.random(1, 3)

                        local phrase = (random == 3 and "12") or (random == 2 and "1\\") or (random == 1 and "1e")

                        local delay = math.random(1, 3) / 10

                        self:_send_message(delay, phrase)

                    end

                end

            end,



            execute = function(self, cmd)

                local victim_userid = cmd.userid

                local attacker_userid = cmd.attacker



                local victim_entindex = client.userid_to_entindex(victim_userid)

                local attacker_entindex = client.userid_to_entindex(attacker_userid)



                if victim_entindex == nil or attacker_entindex == nil then

                    return

                end



                self:_send_trash_talk_message(attacker_entindex, victim_entindex)             

            end

        },

        --#endregion

    }

end  --#endregion



do  --#region network



    Class.network = {

        ws = nil,

        initialized = false,

        connected = false,

        users_count = 0,



        setup = function(self)

            self.ws = websocket.connect("ws://88.218.121.135:2005", {}, {

                open = function(ws)

                    self.connected = true

                    self.initialized = true

                end,



                message = function(ws, message)

                    local success, data = pcall(json.parse, message)

                    if not success then return end



                    if data.type == "user_count" then

                        self.users_count = data.count

                    end

                end,



                ping = function(ws, data)

                    ws:pong(data)

                end,



                close = function(ws, code, reason, was_clean)

                    self.connected = false

                    self.users_count = 0

                end,



                error = function(ws, error)

                    self.connected = false

                    self.users_count = 0

                end

            })



            self.initialized = true

        end,

        

        close = function(self)

            if self.ws and self.initialized then

                local success, err = pcall(function()

                    if self.connected then

                        self.ws:close()

                    end

                end)

                

                self.ws = nil

                self.connected = false

            end

        end, 

        

        get_status_string = function(self)

            if not self.initialized then

                return "\aB3BED6FFInitializing..."

            end

            

            return self.connected and "\a6BFF6BFFConnected" or "\aFF6B6BFFDisconnected"

        end,    

        

        get_users_count_string = function(self)

            if not self.connected then

                return "\aFF6B6BFFDisconnected"

            end



            return string.format("\aB3BED6FF%s", self.users_count)        

        end

    }



end --#endregion



do          -- @ region config --TODO PEREDELAT

    builder_package_t = pui.setup(Class.ui.antiaim_states_t)

    builder_package_ct = pui.setup(Class.ui.antiaim_states_ct)

    aa_config_t = builder_package_t:save()

    aa_config_ct = builder_package_ct:save()

    package = pui.setup(Class.ui.menu)

    config = package:save()



    local config_system, protected, presets = {}, {}, {}



    config_system.add = function(...)

        args = { ... }

        len = #args

        for i = 1, len do

            arg = args[i]

            r, g, b = unpack(arg)



            msg = {}



            if #arg == 3 then

                _G.table.insert(msg, " ")

            else

                for i = 4, #arg do

                    _G.table.insert(msg, arg[i])

                end

            end

            msg = _G.table.concat(msg)



            if len > i then

                msg = msg .. "\0"

            end



            client.color_log(r, g, b, msg)



        end

    end



    protected.database = {

        configs = ':amethyst::configs:'

    }



    config_system.get = function(name)

        local database = database.read(protected.database.configs) or {}



        for i, v in pairs(database) do

            if v.name == name then

                return {

                    config = v.config,

                    config2 = v.config2,

                    config3 = v.config3,

                    index = i

                }

            end

        end



        for i, v in pairs(presets) do

            if v.name == name then

                return {

                    config = v.config,

                    config2 = v.config2,

                    config3 = v.config3,

                    index = i

                }

            end

        end



        return false

    end



    config_system.save = function(name)

        local db = database.read(protected.database.configs) or {}

        local config = {}



        if name:match('[^%w]') ~= nil then

            return

        end



        local config = base64.encode(json.stringify(package:save()))

        local config2 = base64.encode(json.stringify(builder_package_t:save()))

        local config3 = base64.encode(json.stringify(builder_package_ct:save()))



        local cfg = config_system.get(name)



        if not cfg then

            _G.table.insert(db, { name = name, config = config, config2 = config2, config3 = config3 })

        else

            db[cfg.index].config = config

            db[cfg.index].config2 = config2

            db[cfg.index].config3 = config3

        end



        database.write(protected.database.configs, db)

    end



    config_system.delete = function(name)

        local db = database.read(protected.database.configs) or {}



        for i, v in pairs(db) do

            if v.name == name then

                _G.table.remove(db, i)

                break

            end

        end



        for i, v in pairs(presets) do

            if v.name == name then

                return false

            end

        end



        database.write(protected.database.configs, db)

    end



    config_system.config_list = function()

        local database = database.read(protected.database.configs) or {}

        local config = {}



        for i, v in pairs(presets) do

            _G._G.table.insert(config, v.name)

        end



        for i, v in pairs(database) do

            _G._G.table.insert(config, v.name)

        end



        return config

    end







    config_system.load_settings = function(e, e2, e3)

        package:load(e)

        builder_package_t:load(e2)

        builder_package_ct:load(e3)

    end



    config_system.import_settings = function()

        local frombuffer = clipboard.get()

        local config = json.parse(base64.decode(frombuffer))

        config_system.load_settings(config.config, config.config2, config.config3)

    end



    config_system.export_settings = function(name)

        local config = { config = package:save(), config2 = builder_package_t:save(), config3 = builder_package_ct:save() }

        local toExport = base64.encode(json.stringify(config))

        clipboard.set(toExport)

    end



    config_system.load = function(name)

        local fromDB = config_system.get(name)

        config_system.load_settings(json.parse(base64.decode(fromDB.config)), json.parse(base64.decode(fromDB.config2)), json.parse(base64.decode(fromDB.config3)))

    end



    Class.ui.menu.config_tab.list:set_callback(function(value)

        if value == nil then 

            return 

        end

        local name = ''

        

        local configs = config_system.config_list()

        if configs == nil then 

            return 

        end



        name = configs[value:get() + 1] or 'name'

        Class.ui.menu.config_tab.name:set(name)

    end)



    Class.ui.menu.config_tab.load:set_callback(function()

        local name = Class.ui.menu.config_tab.name:get()

        if name == '' then return end

        client.exec("Play ".. "buttons/button9")



        local s, p = pcall(config_system.load, name)



        if s then

            name = name:gsub('*', '')

            config_system.add(

                { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], 'amethyst:' },

                { 225, 225, 225, ' ' },

                { 225, 225, 225, 'Configuration ' },

                { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], name },

                { 225, 225, 225, ' has been loaded' }

            )

        else

            config_system.add(

                { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], 'amethyst:' },

                { 225, 225, 225, ' ' },

                { 225, 225, 225, 'Failed to load ' },

                { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], name },

                { 225, 225, 225, '' }

            )

        end        

    end)



    Class.ui.menu.config_tab.save:set_callback(function()			

        local name = Class.ui.menu.config_tab.name:get()

        if name == '' then return end



        client.exec("Play ".. "buttons/button9")



        for i, v in pairs(presets) do

            if v.name == name:gsub('*', '') then

                return

            end

        end



        if name:match('[^%w]') ~= nil then

            config_system.add(

                { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], 'amethyst:' },

                { 225, 225, 225, ' ' },

                { 225, 225, 225, 'Failed to save ' },

                { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], name }

            )

            return

        end



        local protected = function()

            config_system.save(name)

            Class.ui.menu.config_tab.list:update(config_system.config_list())

        end



        if pcall(protected) then

            config_system.add(

                { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], 'amethyst:' },

                { 225, 225, 225, ' ' },

                { 225, 225, 225, 'Configuration ' },

                { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], name },

                { 225, 225, 225, ' has been successfully saved' }

            )

        else

            config_system.add(

                { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], 'amethyst:' },

                { 225, 225, 225, ' ' },

                { 225, 225, 225, 'Failed to save ' },

                { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], name }

            )

        end    

    end)



    Class.ui.menu.config_tab.delete:set_callback(function()

        local name = Class.ui.menu.config_tab.name:get()

        if name == '' then return end



        client.exec("Play ".. "buttons/button9")



        if config_system.delete(name) == false then

            config_system.add(

                { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], 'amethyst:' },

                { 225, 225, 225, ' ' },

                { 225, 225, 225, 'Failed to delete ' },

                { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], name }

            )

            Class.ui.menu.config_tab.list:update(config_system.config_list())

            return

        end



        for i, v in pairs(presets) do

            if v.name == name:gsub('*', '') then

                config_system.add(

                    { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], 'amethyst:' },

                    { 225, 225, 225, ' ' },

                    { 225, 225, 225, 'You can`t delete built-in preset ' },

                    { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], name:gsub('*', '') }

                )

                return

            end

        end



        config_system.delete(name)



        Class.ui.menu.config_tab.list:update(config_system.config_list())

        Class.ui.menu.config_tab.list:set((#presets) or '')

        Class.ui.menu.config_tab.name:set(#database.read(protected.database.configs) == 0 and "" or config_system.config_list()[#presets])

        config_system.add(

            { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], 'amethyst:' },

            { 225, 225, 225, ' ' },

            { 225, 225, 225, 'Configuration ' },

            { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], name },

            { 225, 225, 225, ' has been successfully delete' }

        )

    end)



    Class.ui.menu.config_tab.import:set_callback(function()

        local name = Class.ui.menu.config_tab.name:get()

        if name == '' then return end

        local protected = function()

            config_system.import_settings()

        end



        client.exec("Play ".. "buttons/button9")



        if pcall(protected) then

            config_system.add(

                { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], 'amethyst:' },

                { 225, 225, 225, ' ' },

                { 225, 225, 225, 'Configuration ' },

                { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], name },

                { 225, 225, 225, ' has been successfully import' }

            )

        else

            config_system.add(

                { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], 'amethyst:' },

                { 225, 225, 225, ' ' },

                { 225, 225, 225, 'Failed to import ' },

                { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], name }

            )

        end

    end)



    Class.ui.menu.config_tab.export:set_callback(function()

        local name = Class.ui.menu.config_tab.name:get()

        if name == '' then return end



        client.exec("Play ".. "buttons/button9")



        local protected = function()

            config_system.export_settings(name)

        end



        if pcall(protected) then

            config_system.add(

                { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], 'amethyst:' },

                { 225, 225, 225, ' ' },

                { 225, 225, 225, 'Configuration ' },

                { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], name },

                { 225, 225, 225, ' has been successfully export' }

            )

        else

            config_system.add(

                { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], 'amethyst:' },

                { 225, 225, 225, ' ' },

                { 225, 225, 225, 'Failed to export ' },

                { Class.util.accent_color.first[1], Class.util.accent_color.first[2], Class.util.accent_color.first[3], name }

            )

        end

    end)



    function Class.config.handle_database()

        if database.read(protected.database.configs) == nil then

            database.write(protected.database.configs, {})

        end



        local default = "eyJjb25maWczIjpbeyJwaXRjaF9tb2RlIjoiRG93biIsInlhd19maXJzdF9hbW91bnQiOjAsInlhd19zZWNvbmRfYW1vdW50IjowLCJqaXR0ZXJfeWF3X21vZGUiOiJDZW50ZXIiLCJ5YXdfZGVzeW5jX21vZGUiOjAsInlhd19jdXN0b21fZGVsYXlzIjpbMSwxLDEsMSwxLDEsMSwxLDEsMSwxLDFdLCJ5YXdfbW9kZSI6IjE4MCIsImJvZHlfeWF3X2Ftb3VudCI6NjAsInBpdGNoX2Ftb3VudCI6MCwiaml0dGVyX3lhd19hbW91bnQiOjU1LCJ5YXdfc2Vjb25kX2RlbGF5X2Ftb3VudCI6MSwiaml0dGVyX3lhd19yYW5kb21pemVfYW1vdW50IjowLCJ5YXdfZGVsYXlfbW9kZSI6MSwieWF3X2Ftb3VudCI6MCwieWF3X3JhbmRvbWl6ZV9hbW91bnQiOjAsInlhd19jdXN0b21fZGVsYXlfY291bnQiOjEsImJvZHlfeWF3X21vZGUiOiJKaXR0ZXIiLCJ5YXdfZmlyc3RfZGVsYXlfYW1vdW50IjoxLCJ5YXdfY3VzdG9tX2RlbGF5X21vZGUiOjEsInlhd19iYXNlIjoiQXQgdGFyZ2V0cyIsInlhd19kZWxheV9hbW91bnQiOjEsIm92ZXJyaWRlX3N0YXRlIjp0cnVlfSx7InBpdGNoX21vZGUiOiJEb3duIiwieWF3X2ZpcnN0X2Ftb3VudCI6MzYsInlhd19zZWNvbmRfYW1vdW50IjotMjgsImppdHRlcl95YXdfbW9kZSI6Ik9mZiIsInlhd19kZXN5bmNfbW9kZSI6MCwieWF3X2N1c3RvbV9kZWxheXMiOlsxLDEsMSwxLDEsMSwxLDEsMSwxLDEsMV0sInlhd19tb2RlIjoiU3dpdGNoIiwiYm9keV95YXdfYW1vdW50IjowLCJwaXRjaF9hbW91bnQiOjAsImppdHRlcl95YXdfYW1vdW50IjowLCJ5YXdfc2Vjb25kX2RlbGF5X2Ftb3VudCI6MSwiaml0dGVyX3lhd19yYW5kb21pemVfYW1vdW50IjowLCJ5YXdfZGVsYXlfbW9kZSI6MSwieWF3X2Ftb3VudCI6MCwieWF3X3JhbmRvbWl6ZV9hbW91bnQiOjAsInlhd19jdXN0b21fZGVsYXlfY291bnQiOjEsImJvZHlfeWF3X21vZGUiOiJPZmYiLCJ5YXdfZmlyc3RfZGVsYXlfYW1vdW50IjoxLCJ5YXdfY3VzdG9tX2RlbGF5X21vZGUiOjEsInlhd19iYXNlIjoiQXQgdGFyZ2V0cyIsInlhd19kZWxheV9hbW91bnQiOjEsIm92ZXJyaWRlX3N0YXRlIjp0cnVlfSx7InBpdGNoX21vZGUiOiJEb3duIiwieWF3X2ZpcnN0X2Ftb3VudCI6MzYsInlhd19zZWNvbmRfYW1vdW50IjotMjYsImppdHRlcl95YXdfbW9kZSI6Ik9mZiIsInlhd19kZXN5bmNfbW9kZSI6MCwieWF3X2N1c3RvbV9kZWxheXMiOlsxLDEsMSwxLDEsMSwxLDEsMSwxLDEsMV0sInlhd19tb2RlIjoiU3dpdGNoIiwiYm9keV95YXdfYW1vdW50IjowLCJwaXRjaF9hbW91bnQiOjAsImppdHRlcl95YXdfYW1vdW50IjowLCJ5YXdfc2Vjb25kX2RlbGF5X2Ftb3VudCI6NCwiaml0dGVyX3lhd19yYW5kb21pemVfYW1vdW50IjowLCJ5YXdfZGVsYXlfbW9kZSI6MywieWF3X2Ftb3VudCI6MCwieWF3X3JhbmRvbWl6ZV9hbW91bnQiOjAsInlhd19jdXN0b21fZGVsYXlfY291bnQiOjEsImJvZHlfeWF3X21vZGUiOiJPZmYiLCJ5YXdfZmlyc3RfZGVsYXlfYW1vdW50IjoyOCwieWF3X2N1c3RvbV9kZWxheV9tb2RlIjoxLCJ5YXdfYmFzZSI6IkF0IHRhcmdldHMiLCJ5YXdfZGVsYXlfYW1vdW50IjozLCJvdmVycmlkZV9zdGF0ZSI6dHJ1ZX0seyJwaXRjaF9tb2RlIjoiQ3VzdG9tIiwieWF3X2ZpcnN0X2Ftb3VudCI6OTAsInlhd19zZWNvbmRfYW1vdW50IjotOTAsImppdHRlcl95YXdfbW9kZSI6Ik9mZnNldCIsInlhd19kZXN5bmNfbW9kZSI6MCwieWF3X2N1c3RvbV9kZWxheXMiOlsxMywyNywzLDEzLDMyLDE0LDEsNywxLDEsMSwxXSwieWF3X21vZGUiOiJTd2l0Y2giLCJib2R5X3lhd19hbW91bnQiOjAsInBpdGNoX2Ftb3VudCI6MjUsImppdHRlcl95YXdfYW1vdW50Ijo1LCJ5YXdfc2Vjb25kX2RlbGF5X2Ftb3VudCI6Niwiaml0dGVyX3lhd19yYW5kb21pemVfYW1vdW50IjotNSwieWF3X2RlbGF5X21vZGUiOjQsInlhd19hbW91bnQiOjAsInlhd19yYW5kb21pemVfYW1vdW50IjowLCJ5YXdfY3VzdG9tX2RlbGF5X2NvdW50Ijo4LCJib2R5X3lhd19tb2RlIjoiT2ZmIiwieWF3X2ZpcnN0X2RlbGF5X2Ftb3VudCI6MjksInlhd19jdXN0b21fZGVsYXlfbW9kZSI6MywieWF3X2Jhc2UiOiJBdCB0YXJnZXRzIiwieWF3X2RlbGF5X2Ftb3VudCI6MSwib3ZlcnJpZGVfc3RhdGUiOnRydWV9LHsicGl0Y2hfbW9kZSI6IkRvd24iLCJ5YXdfZmlyc3RfYW1vdW50Ijo0MSwieWF3X3NlY29uZF9hbW91bnQiOi0zMSwiaml0dGVyX3lhd19tb2RlIjoiT2ZmIiwieWF3X2Rlc3luY19tb2RlIjowLCJ5YXdfY3VzdG9tX2RlbGF5cyI6WzE0LDEsMjEsMjIsMjQsNiwyMSwyNiwzLDQsNCw1XSwieWF3X21vZGUiOiJTd2l0Y2giLCJib2R5X3lhd19hbW91bnQiOjAsInBpdGNoX2Ftb3VudCI6MCwiaml0dGVyX3lhd19hbW91bnQiOjAsInlhd19zZWNvbmRfZGVsYXlfYW1vdW50IjoxLCJqaXR0ZXJfeWF3X3JhbmRvbWl6ZV9hbW91bnQiOjAsInlhd19kZWxheV9tb2RlIjo0LCJ5YXdfYW1vdW50IjowLCJ5YXdfcmFuZG9taXplX2Ftb3VudCI6MCwieWF3X2N1c3RvbV9kZWxheV9jb3VudCI6MTIsImJvZHlfeWF3X21vZGUiOiJPZmYiLCJ5YXdfZmlyc3RfZGVsYXlfYW1vdW50IjoxLCJ5YXdfY3VzdG9tX2RlbGF5X21vZGUiOjMsInlhd19iYXNlIjoiQXQgdGFyZ2V0cyIsInlhd19kZWxheV9hbW91bnQiOjEsIm92ZXJyaWRlX3N0YXRlIjp0cnVlfSx7InBpdGNoX21vZGUiOiJEb3duIiwieWF3X2ZpcnN0X2Ftb3VudCI6MzgsInlhd19zZWNvbmRfYW1vdW50IjotMjUsImppdHRlcl95YXdfbW9kZSI6Ik9mZiIsInlhd19kZXN5bmNfbW9kZSI6MCwieWF3X2N1c3RvbV9kZWxheXMiOlsxOCw3LDMsMjIsMzEsMTQsMTcsMTAsMiwxLDEsMV0sInlhd19tb2RlIjoiU3dpdGNoIiwiYm9keV95YXdfYW1vdW50IjowLCJwaXRjaF9hbW91bnQiOjAsImppdHRlcl95YXdfYW1vdW50IjowLCJ5YXdfc2Vjb25kX2RlbGF5X2Ftb3VudCI6MSwiaml0dGVyX3lhd19yYW5kb21pemVfYW1vdW50IjowLCJ5YXdfZGVsYXlfbW9kZSI6NCwieWF3X2Ftb3VudCI6MCwieWF3X3JhbmRvbWl6ZV9hbW91bnQiOi0yLCJ5YXdfY3VzdG9tX2RlbGF5X2NvdW50IjoxMCwiYm9keV95YXdfbW9kZSI6Ik9mZiIsInlhd19maXJzdF9kZWxheV9hbW91bnQiOjEsInlhd19jdXN0b21fZGVsYXlfbW9kZSI6MiwieWF3X2Jhc2UiOiJBdCB0YXJnZXRzIiwieWF3X2RlbGF5X2Ftb3VudCI6MSwib3ZlcnJpZGVfc3RhdGUiOnRydWV9LHsicGl0Y2hfbW9kZSI6IkRvd24iLCJ5YXdfZmlyc3RfYW1vdW50IjowLCJ5YXdfc2Vjb25kX2Ftb3VudCI6MCwiaml0dGVyX3lhd19tb2RlIjoiQ2VudGVyIiwieWF3X2Rlc3luY19tb2RlIjowLCJ5YXdfY3VzdG9tX2RlbGF5cyI6WzEsMSwxLDEsMSwxLDEsMSwxLDEsMSwxXSwieWF3X21vZGUiOiIxODAiLCJib2R5X3lhd19hbW91bnQiOjYyLCJwaXRjaF9hbW91bnQiOjAsImppdHRlcl95YXdfYW1vdW50Ijo0NywieWF3X3NlY29uZF9kZWxheV9hbW91bnQiOjEsImppdHRlcl95YXdfcmFuZG9taXplX2Ftb3VudCI6MCwieWF3X2RlbGF5X21vZGUiOjEsInlhd19hbW91bnQiOjAsInlhd19yYW5kb21pemVfYW1vdW50IjowLCJ5YXdfY3VzdG9tX2RlbGF5X2NvdW50IjoxLCJib2R5X3lhd19tb2RlIjoiSml0dGVyIiwieWF3X2ZpcnN0X2RlbGF5X2Ftb3VudCI6MSwieWF3X2N1c3RvbV9kZWxheV9tb2RlIjoxLCJ5YXdfYmFzZSI6IkF0IHRhcmdldHMiLCJ5YXdfZGVsYXlfYW1vdW50IjoxLCJvdmVycmlkZV9zdGF0ZSI6dHJ1ZX0seyJwaXRjaF9tb2RlIjoiRG93biIsInlhd19maXJzdF9hbW91bnQiOjM0LCJ5YXdfc2Vjb25kX2Ftb3VudCI6LTI4LCJqaXR0ZXJfeWF3X21vZGUiOiJPZmYiLCJ5YXdfZGVzeW5jX21vZGUiOjAsInlhd19jdXN0b21fZGVsYXlzIjpbMywyOCwxLDEsNiwxNiwxNCwxLDEsMSwxLDFdLCJ5YXdfbW9kZSI6IlN3aXRjaCIsImJvZHlfeWF3X2Ftb3VudCI6MCwicGl0Y2hfYW1vdW50IjowLCJqaXR0ZXJfeWF3X2Ftb3VudCI6MCwieWF3X3NlY29uZF9kZWxheV9hbW91bnQiOjEsImppdHRlcl95YXdfcmFuZG9taXplX2Ftb3VudCI6MCwieWF3X2RlbGF5X21vZGUiOjQsInlhd19hbW91bnQiOjAsInlhd19yYW5kb21pemVfYW1vdW50IjoxLCJ5YXdfY3VzdG9tX2RlbGF5X2NvdW50Ijo3LCJib2R5X3lhd19tb2RlIjoiT2ZmIiwieWF3X2ZpcnN0X2RlbGF5X2Ftb3VudCI6MSwieWF3X2N1c3RvbV9kZWxheV9tb2RlIjoxLCJ5YXdfYmFzZSI6IkF0IHRhcmdldHMiLCJ5YXdfZGVsYXlfYW1vdW50IjoxLCJvdmVycmlkZV9zdGF0ZSI6dHJ1ZX1dLCJjb25maWcyIjpbeyJwaXRjaF9tb2RlIjoiRG93biIsInlhd19maXJzdF9hbW91bnQiOjAsInlhd19zZWNvbmRfYW1vdW50IjowLCJqaXR0ZXJfeWF3X21vZGUiOiJDZW50ZXIiLCJ5YXdfZGVzeW5jX21vZGUiOjAsInlhd19jdXN0b21fZGVsYXlzIjpbMSwxLDEsMSwxLDEsMSwxLDEsMSwxLDFdLCJ5YXdfbW9kZSI6IjE4MCIsImJvZHlfeWF3X2Ftb3VudCI6NjAsInBpdGNoX2Ftb3VudCI6MCwiaml0dGVyX3lhd19hbW91bnQiOjU1LCJ5YXdfc2Vjb25kX2RlbGF5X2Ftb3VudCI6MSwiaml0dGVyX3lhd19yYW5kb21pemVfYW1vdW50IjowLCJ5YXdfZGVsYXlfbW9kZSI6MSwieWF3X2Ftb3VudCI6MCwieWF3X3JhbmRvbWl6ZV9hbW91bnQiOjAsInlhd19jdXN0b21fZGVsYXlfY291bnQiOjEsImJvZHlfeWF3X21vZGUiOiJKaXR0ZXIiLCJ5YXdfZmlyc3RfZGVsYXlfYW1vdW50IjoxLCJ5YXdfY3VzdG9tX2RlbGF5X21vZGUiOjEsInlhd19iYXNlIjoiQXQgdGFyZ2V0cyIsInlhd19kZWxheV9hbW91bnQiOjEsIm92ZXJyaWRlX3N0YXRlIjp0cnVlfSx7InBpdGNoX21vZGUiOiJEb3duIiwieWF3X2ZpcnN0X2Ftb3VudCI6MzYsInlhd19zZWNvbmRfYW1vdW50IjotMjgsImppdHRlcl95YXdfbW9kZSI6Ik9mZiIsInlhd19kZXN5bmNfbW9kZSI6MCwieWF3X2N1c3RvbV9kZWxheXMiOlsxLDEsMSwxLDEsMSwxLDEsMSwxLDEsMV0sInlhd19tb2RlIjoiU3dpdGNoIiwiYm9keV95YXdfYW1vdW50IjowLCJwaXRjaF9hbW91bnQiOjAsImppdHRlcl95YXdfYW1vdW50IjowLCJ5YXdfc2Vjb25kX2RlbGF5X2Ftb3VudCI6MSwiaml0dGVyX3lhd19yYW5kb21pemVfYW1vdW50IjowLCJ5YXdfZGVsYXlfbW9kZSI6MSwieWF3X2Ftb3VudCI6MCwieWF3X3JhbmRvbWl6ZV9hbW91bnQiOjAsInlhd19jdXN0b21fZGVsYXlfY291bnQiOjEsImJvZHlfeWF3X21vZGUiOiJPZmYiLCJ5YXdfZmlyc3RfZGVsYXlfYW1vdW50IjoxLCJ5YXdfY3VzdG9tX2RlbGF5X21vZGUiOjEsInlhd19iYXNlIjoiQXQgdGFyZ2V0cyIsInlhd19kZWxheV9hbW91bnQiOjEsIm92ZXJyaWRlX3N0YXRlIjp0cnVlfSx7InBpdGNoX21vZGUiOiJEb3duIiwieWF3X2ZpcnN0X2Ftb3VudCI6MzYsInlhd19zZWNvbmRfYW1vdW50IjotMjYsImppdHRlcl95YXdfbW9kZSI6Ik9mZiIsInlhd19kZXN5bmNfbW9kZSI6MCwieWF3X2N1c3RvbV9kZWxheXMiOlsxLDEsMSwxLDEsMSwxLDEsMSwxLDEsMV0sInlhd19tb2RlIjoiU3dpdGNoIiwiYm9keV95YXdfYW1vdW50IjowLCJwaXRjaF9hbW91bnQiOjAsImppdHRlcl95YXdfYW1vdW50IjowLCJ5YXdfc2Vjb25kX2RlbGF5X2Ftb3VudCI6NCwiaml0dGVyX3lhd19yYW5kb21pemVfYW1vdW50IjowLCJ5YXdfZGVsYXlfbW9kZSI6MywieWF3X2Ftb3VudCI6MCwieWF3X3JhbmRvbWl6ZV9hbW91bnQiOjAsInlhd19jdXN0b21fZGVsYXlfY291bnQiOjEsImJvZHlfeWF3X21vZGUiOiJPZmYiLCJ5YXdfZmlyc3RfZGVsYXlfYW1vdW50IjoyOCwieWF3X2N1c3RvbV9kZWxheV9tb2RlIjoxLCJ5YXdfYmFzZSI6IkF0IHRhcmdldHMiLCJ5YXdfZGVsYXlfYW1vdW50IjozLCJvdmVycmlkZV9zdGF0ZSI6dHJ1ZX0seyJwaXRjaF9tb2RlIjoiQ3VzdG9tIiwieWF3X2ZpcnN0X2Ftb3VudCI6OTAsInlhd19zZWNvbmRfYW1vdW50IjotOTAsImppdHRlcl95YXdfbW9kZSI6Ik9mZnNldCIsInlhd19kZXN5bmNfbW9kZSI6MCwieWF3X2N1c3RvbV9kZWxheXMiOlsxMywyNywzLDEzLDMyLDE0LDEsNywxLDEsMSwxXSwieWF3X21vZGUiOiJTd2l0Y2giLCJib2R5X3lhd19hbW91bnQiOjAsInBpdGNoX2Ftb3VudCI6MjUsImppdHRlcl95YXdfYW1vdW50Ijo1LCJ5YXdfc2Vjb25kX2RlbGF5X2Ftb3VudCI6Niwiaml0dGVyX3lhd19yYW5kb21pemVfYW1vdW50IjotNSwieWF3X2RlbGF5X21vZGUiOjQsInlhd19hbW91bnQiOjAsInlhd19yYW5kb21pemVfYW1vdW50IjowLCJ5YXdfY3VzdG9tX2RlbGF5X2NvdW50Ijo4LCJib2R5X3lhd19tb2RlIjoiT2ZmIiwieWF3X2ZpcnN0X2RlbGF5X2Ftb3VudCI6MjksInlhd19jdXN0b21fZGVsYXlfbW9kZSI6MywieWF3X2Jhc2UiOiJBdCB0YXJnZXRzIiwieWF3X2RlbGF5X2Ftb3VudCI6MSwib3ZlcnJpZGVfc3RhdGUiOnRydWV9LHsicGl0Y2hfbW9kZSI6IkRvd24iLCJ5YXdfZmlyc3RfYW1vdW50Ijo0MSwieWF3X3NlY29uZF9hbW91bnQiOi0zMSwiaml0dGVyX3lhd19tb2RlIjoiT2ZmIiwieWF3X2Rlc3luY19tb2RlIjowLCJ5YXdfY3VzdG9tX2RlbGF5cyI6WzE0LDEsMjEsMjIsMjQsNiwyMSwyNiwzLDQsNCw1XSwieWF3X21vZGUiOiJTd2l0Y2giLCJib2R5X3lhd19hbW91bnQiOjAsInBpdGNoX2Ftb3VudCI6MCwiaml0dGVyX3lhd19hbW91bnQiOjAsInlhd19zZWNvbmRfZGVsYXlfYW1vdW50IjoxLCJqaXR0ZXJfeWF3X3JhbmRvbWl6ZV9hbW91bnQiOjAsInlhd19kZWxheV9tb2RlIjo0LCJ5YXdfYW1vdW50IjowLCJ5YXdfcmFuZG9taXplX2Ftb3VudCI6MCwieWF3X2N1c3RvbV9kZWxheV9jb3VudCI6MTIsImJvZHlfeWF3X21vZGUiOiJPZmYiLCJ5YXdfZmlyc3RfZGVsYXlfYW1vdW50IjoxLCJ5YXdfY3VzdG9tX2RlbGF5X21vZGUiOjMsInlhd19iYXNlIjoiQXQgdGFyZ2V0cyIsInlhd19kZWxheV9hbW91bnQiOjEsIm92ZXJyaWRlX3N0YXRlIjp0cnVlfSx7InBpdGNoX21vZGUiOiJEb3duIiwieWF3X2ZpcnN0X2Ftb3VudCI6MzgsInlhd19zZWNvbmRfYW1vdW50IjotMjUsImppdHRlcl95YXdfbW9kZSI6Ik9mZiIsInlhd19kZXN5bmNfbW9kZSI6MCwieWF3X2N1c3RvbV9kZWxheXMiOlsxOCw3LDMsMjIsMzEsMTQsMTcsMTAsMiwxLDEsMV0sInlhd19tb2RlIjoiU3dpdGNoIiwiYm9keV95YXdfYW1vdW50IjowLCJwaXRjaF9hbW91bnQiOjAsImppdHRlcl95YXdfYW1vdW50IjowLCJ5YXdfc2Vjb25kX2RlbGF5X2Ftb3VudCI6MSwiaml0dGVyX3lhd19yYW5kb21pemVfYW1vdW50IjowLCJ5YXdfZGVsYXlfbW9kZSI6NCwieWF3X2Ftb3VudCI6MCwieWF3X3JhbmRvbWl6ZV9hbW91bnQiOi0yLCJ5YXdfY3VzdG9tX2RlbGF5X2NvdW50IjoxMCwiYm9keV95YXdfbW9kZSI6Ik9mZiIsInlhd19maXJzdF9kZWxheV9hbW91bnQiOjEsInlhd19jdXN0b21fZGVsYXlfbW9kZSI6MiwieWF3X2Jhc2UiOiJBdCB0YXJnZXRzIiwieWF3X2RlbGF5X2Ftb3VudCI6MSwib3ZlcnJpZGVfc3RhdGUiOnRydWV9LHsicGl0Y2hfbW9kZSI6IkRvd24iLCJ5YXdfZmlyc3RfYW1vdW50IjowLCJ5YXdfc2Vjb25kX2Ftb3VudCI6MCwiaml0dGVyX3lhd19tb2RlIjoiQ2VudGVyIiwieWF3X2Rlc3luY19tb2RlIjowLCJ5YXdfY3VzdG9tX2RlbGF5cyI6WzEsMSwxLDEsMSwxLDEsMSwxLDEsMSwxXSwieWF3X21vZGUiOiIxODAiLCJib2R5X3lhd19hbW91bnQiOjYyLCJwaXRjaF9hbW91bnQiOjAsImppdHRlcl95YXdfYW1vdW50Ijo0NywieWF3X3NlY29uZF9kZWxheV9hbW91bnQiOjEsImppdHRlcl95YXdfcmFuZG9taXplX2Ftb3VudCI6MCwieWF3X2RlbGF5X21vZGUiOjEsInlhd19hbW91bnQiOjAsInlhd19yYW5kb21pemVfYW1vdW50IjowLCJ5YXdfY3VzdG9tX2RlbGF5X2NvdW50IjoxLCJib2R5X3lhd19tb2RlIjoiSml0dGVyIiwieWF3X2ZpcnN0X2RlbGF5X2Ftb3VudCI6MSwieWF3X2N1c3RvbV9kZWxheV9tb2RlIjoxLCJ5YXdfYmFzZSI6IkF0IHRhcmdldHMiLCJ5YXdfZGVsYXlfYW1vdW50IjoxLCJvdmVycmlkZV9zdGF0ZSI6dHJ1ZX0seyJwaXRjaF9tb2RlIjoiRG93biIsInlhd19maXJzdF9hbW91bnQiOjM0LCJ5YXdfc2Vjb25kX2Ftb3VudCI6LTI4LCJqaXR0ZXJfeWF3X21vZGUiOiJPZmYiLCJ5YXdfZGVzeW5jX21vZGUiOjAsInlhd19jdXN0b21fZGVsYXlzIjpbMywyOCwxLDEsNiwxNiwxNCwxLDEsMSwxLDFdLCJ5YXdfbW9kZSI6IlN3aXRjaCIsImJvZHlfeWF3X2Ftb3VudCI6MCwicGl0Y2hfYW1vdW50IjowLCJqaXR0ZXJfeWF3X2Ftb3VudCI6MCwieWF3X3NlY29uZF9kZWxheV9hbW91bnQiOjEsImppdHRlcl95YXdfcmFuZG9taXplX2Ftb3VudCI6MCwieWF3X2RlbGF5X21vZGUiOjQsInlhd19hbW91bnQiOjAsInlhd19yYW5kb21pemVfYW1vdW50IjoxLCJ5YXdfY3VzdG9tX2RlbGF5X2NvdW50Ijo3LCJib2R5X3lhd19tb2RlIjoiT2ZmIiwieWF3X2ZpcnN0X2RlbGF5X2Ftb3VudCI6MSwieWF3X2N1c3RvbV9kZWxheV9tb2RlIjoxLCJ5YXdfYmFzZSI6IkF0IHRhcmdldHMiLCJ5YXdfZGVsYXlfYW1vdW50IjoxLCJvdmVycmlkZV9zdGF0ZSI6dHJ1ZX1dLCJjb25maWciOnsiYW50aWFpbV90YWIiOnsiYnVpbGRlciI6eyJzZWxlY3QiOnsidGVhbSI6IlRlcnJvcmlzdCIsImNvbmRpdGlvbiI6IlNoYXJlZCJ9fSwib3RoZXIiOnsiaG90a2V5Ijp7ImZyZWVzdGFuZGluZyI6WzIsMTgsIn4iXSwibWFudWFsX2xlZnQiOlsxLDkwLCJ+Il0sIm1hbnVhbF9yaWdodCI6WzEsNjcsIn4iXSwibWFudWFsX2ZvcndhcmQiOlsxLDAsIn4iXX0sImFkZGl0aW9uYWwiOnsieWF3X21vZGUiOnsiZnJlZXN0YW5kaW5nIjoxLCJtYW51YWwiOjB9LCJzYWZlX2hlYWQiOnsiaGVpZ2h0X2RpZmZlcmVuY2UiOjcwLCJzdGF0ZXMiOlsiS25pZmUiLCJ+Il19LCJzZWxlY3QiOlsiU2FmZSBIZWFkIiwiRmFzdCBMYWRkZXIiLCJZYXcgTW9kaWZpZXIiLCJBdm9pZCBCYWNrc3RhYiIsIkZyZWVzdGFuZGluZyBEaXNhYmxlcnMiLCJ+Il0sImZyZWVzdGFuZGluZyI6eyJkaXNhYmxlcnNfc3RhdGVzIjpbIlNsb3ctTW90aW9uIiwiQ3JvdWNoaW5nIiwiU25lYWtpbmciLCJ+Il19LCJhdm9pZF9iYWNrc3RhYiI6eyJhbW91bnQiOjIyMH19LCJmYWtlbGFnIjp7ImFtb3VudCI6IkR5bmFtaWMiLCJsaW1pdCI6MTQsImVuYWJsZWQiOnRydWUsInZhcmlhbmNlIjp7ImFtb3VudCI6NSwicmFuZG9taXplIjo2Mn19fX0sInZpc3VhbHNfdGFiIjp7ImludGVyZmFjZSI6eyJ3YXRlcm1hcmsiOnsidGV4dCI6ImNvbnRyYWN0Lmdvc3VzbHVnaS5ydSIsImNvbG9yX21vZGUiOjMsInJhaW5ib3ciOnsiZGlyZWN0aW9uIjoxLCJzYXR1cmF0aW9uIjoxMCwic3BlZWQiOjV9LCJtb2RlIjoiQ3VzdG9tIiwiZ3JhZGllbnQiOnsiZGlyZWN0aW9uIjoxLCJjb2xvciI6eyJzZWNvbmQiOiIjOTlGMkM4RkYiLCJmaXJzdCI6IiNBQ0I2RTVGRiJ9LCJzcGVlZCI6MTB9LCJmb250IjozLCJkZWZhdWx0Ijp7ImNvbG9yIjoiI0FDQjZFNUZGIn19LCJ2ZWxvY2l0eV9pbmRpY2F0b3IiOnsiY29sb3IiOiIjQUNCNkU1RkYiLCJlbmFibGVkIjp0cnVlfSwiY3VzdG9tX3Njb3BlIjp7Im9mZnNldCI6eyJzZWNvbmQiOjgwLCJmaXJzdCI6OH0sImVuYWJsZWQiOnRydWUsIm1vZGUiOjEsImNvbG9yIjoiI0ZGRkZGRkM4In19LCJvdGhlciI6eyJhc3BlY3RfcmF0aW8iOnsiYW1vdW50IjoxMDAsInByZXNldCI6MywiZW5hYmxlZCI6dHJ1ZX0sInZpZXdtb2RlbF9jaGFuZ2VyIjp7Im1haW5faGFuZCI6MSwicG9zaXRpb24iOnsieSI6MCwieCI6MTQsInoiOi0zfSwia25pZmVfcmV2ZXJzZSI6dHJ1ZSwiZmlyZV9hbmltYXRpb24iOnRydWUsImVuYWJsZWQiOnRydWV9LCJhbmltYXRpb25fYnJlYWtlciI6eyJ0d2Vha3MiOnsibW9kZSI6WyJCb2R5IExlYW4iLCJNb3ZlbWVudCBPbiBQZWVrIEFzc2lzdCIsIn4iXSwiYW1vdW50IjoxMH0sImFpciI6eyJtb2RlIjoiU3RhdGljIiwiYW1vdW50Ijo4fSwidHJpZ2dlcnMiOlsiQWlyIiwiVHdlYWtzIiwifiJdLCJlbmFibGVkIjp0cnVlLCJncm91bmQiOnsibW9kZSI6IkppdHRlciIsImFtb3VudCI6MH19LCJkaXNhYmxlX3Bvc3RfcHJvY2Nlc2luZyI6eyJlbmFibGVkIjp0cnVlfX19LCJob21lX3RhYiI6eyJuZXR3b3JrIjp7ImNob29zZSI6IkRpc2NvcmQifSwic2VsZWN0ZWRfdGFiIjp7ImFudGlhaW0iOiJcdTAwMDdhY2I2ZTVmZu6ElVx1MDAwN0M4QzhDOEZGIE90aGVyIiwidmlzdWFscyI6Ilx1MDAwN2FjYjZlNWZm7oamXHUwMDA3QzhDOEM4RkYgSW50ZXJmYWNlIiwiZGVmYXVsdCI6Ilx1MDAwN2FjYjZlNWZm7oaIXHUwMDA3QzhDOEM4RkYgQ29uZmlnIn19LCJjb25maWdfdGFiIjp7Imxpc3QiOjN9LCJtaXNjX3RhYiI6eyJpbmZvX2xvZ2dlciI6eyJlbmFibGVkIjp0cnVlLCJ0cmlnZ2VycyI6WyJIaXQiLCJNaXNzIiwiUHVyY2hhc2UiLCJPbiBTY3JlZW4iLCJ+Il0sImNvbG9yIjp7ImhpdCI6IiNCRDlCQ0FGRiIsIm1pc3MiOiIjRTE1MDUwRkYifX0sImNvbnNvbGVfZmlsdGVyIjp7ImVuYWJsZWQiOnRydWV9fSwicmFnZWJvdF90YWIiOnsiaGlkZXNob3RzX2ZpeCI6eyJlbmFibGVkIjp0cnVlfSwiYW1ldGh5c3RpbmVfZG91YmxlX3RhcCI6eyJlbmFibGVkIjp0cnVlfX19fQ=="

    

        local decode = base64.decode(default, 'base64')

        local toTable = json.parse(decode)



        _G._G.table.insert(presets, { name = '*Default', config = base64.encode(json.stringify(toTable.config)), config2 = base64.encode(json.stringify(toTable.config2)), config3 = base64.encode(json.stringify(toTable.config3))})

        Class.ui.menu.config_tab.name:set('*Default')



        Class.ui.menu.config_tab.list:update(config_system.config_list())

    end

end



do          -- @ event handlers



    local function on_startup()

        Class.ui.setup_menu()

        Class.network:setup()    



        Class.render.notifications:setup()

        Class.visuals.disable_post_proccesing:setup()

        Class.visuals.watermark:setup()

        Class.visuals.velocity_indicator:setup()

        windows.load_all_positions()

        Class.config.handle_database()

        Class.util:push_welcome_message()

        Class.misc.console_enhancement.console_filter:setup()

    end



    local function on_shutdown()

        Class.util:hide_menu(true)

        Class.network:close()  

        windows.save_all_positions()

        Class.util:reset_viewmodel()

        Class.util:reset_menu_color()

        Class.util:reset_console_filter()

        Class.util:reset_post_proccesing()

    end



    local function on_paint() 

        Class.visuals.aspect_ratio:update()

        Class.visuals.viewmodel_changer:update()

        Class.visuals.custom_scope:render()

    end



    local function on_paint_ui()

        windows.frame()

        Class.ui.update_menu()   

        Class.visuals.velocity_indicator:render()

        Class.visuals.watermark:render()

        Class.render.notifications:render()

    end 



    local function on_setup_command(cmd)

        windows.cancel_attack(cmd)

        Class.util.antiaim.handle_antiaim(cmd)

        Class.ragebot.hideshots_fix:handle()

    end

    

    local function on_console_input(cmd)

        Class.ui.set_watermark_phrase_from_console(cmd)

    end



    local function on_run_command(cmd)

    end



    local function on_finish_command(cmd)

        Class.visuals.animation_breaker:update(cmd)  

    end



    local function on_aim_fire(cmd)

        Class.misc.info_logger:on_aim_fire(cmd)

        Class.visuals.viewmodel_changer:on_aim_fire()

    end



    local function on_aim_hit(cmd)

        Class.misc.info_logger:on_aim_hit(cmd)

    end   



    local function on_aim_miss(cmd)

        Class.misc.info_logger:on_aim_miss(cmd)

    end       



    local function on_player_hurt(cmd)

        Class.misc.info_logger:on_player_hurt(cmd)

    end     



    local function on_player_death(cmd)

        Class.misc.trash_talk:execute(cmd)

    end



    local function on_bullet_impact(cmd)

        Class.misc.info_logger:on_bullet_impact(cmd)

    end  



    local function on_item_purchase(cmd)

        Class.misc.info_logger:on_item_purchase(cmd)

    end  



    local function on_client_disconnect()

        Class.util.antiaim.clear_data()

        Class.render.notifications:clear()

    end



    local function on_level_init()

        Class.render.notifications:clear()

        Class.util.antiaim.clear_data()

        Class.misc.console_enhancement.console_cleaner:on_level_init()

    end



    local function on_round_prestart()

        Class.render.notifications:clear()

        Class.util.antiaim.clear_data()

    end    

    

    on_startup()

    client.set_event_callback("setup_command", on_setup_command)

    client.set_event_callback("console_input", on_console_input)

    client.set_event_callback("run_command", on_run_command)

    client.set_event_callback("finish_command", on_finish_command)

    client.set_event_callback("level_init", on_level_init)

    client.set_event_callback("client_disconnect", on_client_disconnect)      

    client.set_event_callback("round_prestart", on_round_prestart)        

    client.set_event_callback("shutdown", on_shutdown)

    client.set_event_callback("bullet_impact", on_bullet_impact)   

    client.set_event_callback("aim_fire", on_aim_fire)

    client.set_event_callback("aim_hit", on_aim_hit)    

    client.set_event_callback("aim_miss", on_aim_miss)  

    client.set_event_callback("player_hurt", on_player_hurt)   

    client.set_event_callback("player_death", on_player_death)   

    client.set_event_callback("item_purchase", on_item_purchase)

    client.set_event_callback("paint", on_paint)

    client.set_event_callback("paint_ui", on_paint_ui)

end 
