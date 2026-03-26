local var_0_0 = require("vector")
local var_0_1 = require("gamesense/pui")
local var_0_2 = require("gamesense/base64")
local var_0_3 = require("gamesense/clipboard")
local var_0_4 = require("gamesense/entity")
local var_0_5 = require("gamesense/http")
local var_0_6 = require("ffi")
local var_0_7 = {
	offset = 0,
	blured = false,
	color = {
		164,
		210,
		212
	}
}

local function var_0_8(arg_1_0, arg_1_1, arg_1_2)
	return (function()
		local var_2_0 = {}
		local var_2_1
		local var_2_2
		local var_2_3
		local var_2_4
		local var_2_5
		local var_2_6
		local var_2_7
		local var_2_8
		local var_2_9
		local var_2_10
		local var_2_11
		local var_2_12
		local var_2_13
		local var_2_14
		local var_2_15 = {
			__index = {
				drag = function(arg_3_0, ...)
					local var_3_0, var_3_1 = arg_3_0:get()
					local var_3_2, var_3_3 = var_2_0.drag(var_3_0, var_3_1, ...)

					if var_3_0 ~= var_3_2 or var_3_1 ~= var_3_3 then
						arg_3_0:set(var_3_2, var_3_3)
					end

					return var_3_2, var_3_3
				end,
				set = function(arg_4_0, arg_4_1, arg_4_2)
					local var_4_0, var_4_1 = client.screen_size()

					ui.set(arg_4_0.x_reference, arg_4_1 / var_4_0 * arg_4_0.res)
					ui.set(arg_4_0.y_reference, arg_4_2 / var_4_1 * arg_4_0.res)
				end,
				get = function(arg_5_0, arg_5_1, arg_5_2)
					local var_5_0, var_5_1 = client.screen_size()

					return ui.get(arg_5_0.x_reference) / arg_5_0.res * var_5_0 + (arg_5_1 or 0), ui.get(arg_5_0.y_reference) / arg_5_0.res * var_5_1 + (arg_5_2 or 0)
				end
			}
		}

		function var_2_0.new(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
			arg_6_3 = arg_6_3 or 10000

			local var_6_0, var_6_1 = client.screen_size()
			local var_6_2 = ui.new_slider("misc", "settings", "one::x:" .. arg_6_0, 0, arg_6_3, arg_6_1 / var_6_0 * arg_6_3)
			local var_6_3 = ui.new_slider("misc", "settings", "one::y:" .. arg_6_0, 0, arg_6_3, arg_6_2 / var_6_1 * arg_6_3)

			ui.set_visible(var_6_2, false)
			ui.set_visible(var_6_3, false)

			return setmetatable({
				name = arg_6_0,
				x_reference = var_6_2,
				y_reference = var_6_3,
				res = arg_6_3
			}, var_2_15)
		end

		function var_2_0.drag(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)
			if globals.framecount() ~= var_2_1 then
				var_2_2 = ui.is_menu_open()
				var_2_5, var_2_6 = var_2_3, var_2_4
				var_2_3, var_2_4 = ui.mouse_position()
				var_2_8 = var_2_7
				var_2_7 = client.key_state(1) == true
				var_2_12 = var_2_11
				var_2_11 = {}
				var_2_14 = var_2_13
				var_2_13 = false
				var_2_9, var_2_10 = client.screen_size()
			end

			if var_2_2 and var_2_8 ~= nil and (not var_2_8 or var_2_14) and var_2_7 and arg_7_0 < var_2_5 and arg_7_1 < var_2_6 and var_2_5 < arg_7_0 + arg_7_2 and var_2_6 < arg_7_1 + arg_7_3 then
				renderer.rectangle(arg_7_0, arg_7_1, arg_7_2, arg_7_3, 255, 255, 255, 5)

				var_2_13 = true
				arg_7_0, arg_7_1 = arg_7_0 + var_2_3 - var_2_5, arg_7_1 + var_2_4 - var_2_6

				if not arg_7_5 then
					arg_7_0 = math.max(0, math.min(var_2_9 - arg_7_2, arg_7_0))
					arg_7_1 = math.max(0, math.min(var_2_10 - arg_7_3, arg_7_1))
				end
			end

			client.set_event_callback("setup_command", function(arg_8_0)
				if var_2_2 and var_2_7 and var_2_13 then
					arg_8_0.in_attack = 0
				end
			end)
			table.insert(var_2_11, {
				arg_7_0,
				arg_7_1,
				arg_7_2,
				arg_7_3
			})

			return arg_7_0, arg_7_1, arg_7_2, arg_7_3
		end

		return var_2_0
	end)().new(arg_1_0, arg_1_1, arg_1_2)
end

local var_0_9 = renderer.load_png("\x89PNG\r\n\x1A\n\x00\x00\x00\rIHDR\x00\x00\x00\v\x00\x00\x00\v\b\x06\x00\x00\x00\xA9\xACw&\x00\x00\x00\x01sRGB\x00\xAE\xCE\x1C\xE9\x00\x00\x00\x04gAMA\x00\x00\xB1\x8F\v\xFCa\x05\x00\x00\x00\tpHYs\x00\x00\x0E\xC3\x00\x00\x0E\xC3\x01\xC7o\xA8d\x00\x00\x013IDAT(S5\x91\xBDJ\x03Q\x10\x85\xEFO\x88\x91%`\x145\x85X\xA9(\xDA\b\xC1\"\nb\x97\a\b\xA9\xD5\xD6\a\xF0!\xB4\xB4\xD3\xD22\xA6Haa#i,\x14A\xB0Q\v!\xC1B\xB0\x10\x7Fր\xEE\xDD\xF5;b\x06>\xCE̙\xB9s\xEF&6I\x92!\xE7ܺ\xB5v3˲7\xB8JӴM\xED\xF1G\x8C1)\x14\xE0\xD1Ш1p\x8D\x9EB9\x8EcKC\xFE\"\xFE\x19\\\xC2~\baԱ\xA1No\x1E\xDAlz\x8E\xA2(\xA3\xE1\x18\xC8\xE1\x8DC\xE5_\xFB2k$y\x0E}\xA1\x83(R\xAF\xA11\x9C\xC3$\xF5\x946\x97(<\x87VQ\xC378Dy\to\x17\xB6xR\x93zEo{\xC0P\xF4\xB8~\x8E\xE1<Z\xC1\x9F\xD0s\xB4\x80|\t\x8E\x95\x1C0\xF8#\xC8O`\x81\x03\x7F\x1F\xA9\xA0.\xD0k\xC0\xAD\x8A*\xC9\x1D(\xFA\xD0\xC1ہe\x98\x85m\xBC\v\xB87\\5\x8CqH\xF1\r\x83\b\xF0\t\xEF\xA0\x05\x1F\xCC\xEC\xE9M\xD3\xF0\x8Aq\x84vu3ȏ\xA0\b\x01:\xD0\xD2?8C\x92c\xF8\xC9{_%\xAF\xF3\vm\xA0cx/h\x93\xBA\x15B\xB8\xF9\x05\xD4\x19\x01\x8D\xADu\xE9;\x00\x00\x00\x00IEND\xAEB`\x82", 11, 11)
local var_0_10 = (function()
	local var_9_0 = var_0_0

	local function var_9_1(arg_10_0, arg_10_1, arg_10_2)
		return arg_10_0 + (arg_10_1 - arg_10_0) * (arg_10_2 + 0.01)
	end

	local function var_9_2()
		return var_9_0(client.screen_size())
	end

	local function var_9_3(arg_12_0, ...)
		local var_12_0 = {
			...
		}
		local var_12_1 = table.concat(var_12_0, "")

		return var_9_0(renderer.measure_text(arg_12_0, var_12_1))
	end

	local var_9_4 = {
		notifications = {
			bottom = {}
		},
		max = {
			bottom = 6
		}
	}

	var_9_4.__index = var_9_4

	function var_9_4.create_new(...)
		table.insert(var_9_4.notifications.bottom, {
			started = false,
			instance = setmetatable({
				timeout = 5,
				active = false,
				color = {
					g = 0,
					a = 0,
					b = 0,
					r = 0
				},
				x = var_9_2().x / 2,
				y = var_9_2().y,
				text = ...
			}, var_9_4)
		})
	end

	function var_9_4.handler(arg_14_0)
		local var_14_0 = 0
		local var_14_1 = 0

		for iter_14_0, iter_14_1 in pairs(var_9_4.notifications.bottom) do
			if not iter_14_1.instance.active and iter_14_1.started then
				table.remove(var_9_4.notifications.bottom, iter_14_0)
			end
		end

		for iter_14_2 = 1, #var_9_4.notifications.bottom do
			if var_9_4.notifications.bottom[iter_14_2].instance.active then
				var_14_1 = var_14_1 + 1
			end
		end

		for iter_14_3, iter_14_4 in pairs(var_9_4.notifications.bottom) do
			if iter_14_3 > var_9_4.max.bottom then
				return
			end

			if iter_14_4.instance.active then
				iter_14_4.instance:render_bottom(var_14_0, var_14_1)

				var_14_0 = var_14_0 + 1
			end

			if not iter_14_4.started then
				iter_14_4.instance:start()

				iter_14_4.started = true
			end
		end
	end

	function var_9_4.start(arg_15_0)
		arg_15_0.active = true
		arg_15_0.delay = globals.realtime() + arg_15_0.timeout
	end

	function var_9_4.get_text(arg_16_0)
		local var_16_0 = ""

		for iter_16_0, iter_16_1 in pairs(arg_16_0.text) do
			local var_16_1 = var_9_3("", iter_16_1[1])
			local var_16_2 = 255
			local var_16_3 = 255
			local var_16_4 = 255

			if iter_16_1[2] then
				var_16_2, var_16_3, var_16_4 = var_0_7.color[1], var_0_7.color[2], var_0_7.color[3]
			end

			var_16_0 = var_16_0 .. ("\a%02x%02x%02x%02x%s"):format(var_16_2, var_16_3, var_16_4, arg_16_0.color.a, iter_16_1[1])
		end

		return var_16_0
	end

	local var_9_5 = (function()
		local var_17_0 = {
			rec = function(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6, arg_18_7, arg_18_8)
				arg_18_8 = math.min(arg_18_0 / 2, arg_18_1 / 2, arg_18_8)

				renderer.rectangle(arg_18_0, arg_18_1 + arg_18_8, arg_18_2, arg_18_3 - arg_18_8 * 2, arg_18_4, arg_18_5, arg_18_6, arg_18_7)
				renderer.rectangle(arg_18_0 + arg_18_8, arg_18_1, arg_18_2 - arg_18_8 * 2, arg_18_8, arg_18_4, arg_18_5, arg_18_6, arg_18_7)
				renderer.rectangle(arg_18_0 + arg_18_8, arg_18_1 + arg_18_3 - arg_18_8, arg_18_2 - arg_18_8 * 2, arg_18_8, arg_18_4, arg_18_5, arg_18_6, arg_18_7)
				renderer.circle(arg_18_0 + arg_18_8, arg_18_1 + arg_18_8, arg_18_4, arg_18_5, arg_18_6, arg_18_7, arg_18_8, 180, 0.25)
				renderer.circle(arg_18_0 - arg_18_8 + arg_18_2, arg_18_1 + arg_18_8, arg_18_4, arg_18_5, arg_18_6, arg_18_7, arg_18_8, 90, 0.25)
				renderer.circle(arg_18_0 - arg_18_8 + arg_18_2, arg_18_1 - arg_18_8 + arg_18_3, arg_18_4, arg_18_5, arg_18_6, arg_18_7, arg_18_8, 0, 0.25)
				renderer.circle(arg_18_0 + arg_18_8, arg_18_1 - arg_18_8 + arg_18_3, arg_18_4, arg_18_5, arg_18_6, arg_18_7, arg_18_8, -90, 0.25)
			end,
			rec_h = function(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
				arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_5 = arg_19_0 * var_0_92, arg_19_1 * var_0_92, arg_19_2 * var_0_92, arg_19_3 * var_0_92, (arg_19_5 or 0) * var_0_92

				local var_19_0 = arg_19_4.r
				local var_19_1 = arg_19_4.g
				local var_19_2 = arg_19_4.b
				local var_19_3 = arg_19_4.a * var_0_99.get_alpha()

				renderer.circle(arg_19_0 + arg_19_5, arg_19_1 + arg_19_5, var_19_0, var_19_1, var_19_2, var_19_3, arg_19_5, 180, 0.25)
				renderer.rectangle(arg_19_0 + arg_19_5, arg_19_1, arg_19_2 - arg_19_5 - arg_19_5, arg_19_5, var_19_0, var_19_1, var_19_2, var_19_3)
				renderer.circle(arg_19_0 + arg_19_2 - arg_19_5, arg_19_1 + arg_19_5, var_19_0, var_19_1, var_19_2, var_19_3, arg_19_5, 90, 0.25)
				renderer.rectangle(arg_19_0, arg_19_1 + arg_19_5, arg_19_2, arg_19_3 - arg_19_5, var_19_0, var_19_1, var_19_2, var_19_3)
			end,
			rec_outline = function(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6, arg_20_7, arg_20_8, arg_20_9)
				arg_20_8 = math.min(arg_20_2 / 2, arg_20_3 / 2, arg_20_8)

				if arg_20_8 == 1 then
					renderer.rectangle(arg_20_0, arg_20_1, arg_20_2, arg_20_9, arg_20_4, arg_20_5, arg_20_6, arg_20_7)
					renderer.rectangle(arg_20_0, arg_20_1 + arg_20_3 - arg_20_9, arg_20_2, arg_20_9, arg_20_4, arg_20_5, arg_20_6, arg_20_7)
				else
					renderer.rectangle(arg_20_0 + arg_20_8, arg_20_1, arg_20_2 - arg_20_8 * 2, arg_20_9, arg_20_4, arg_20_5, arg_20_6, arg_20_7)
					renderer.rectangle(arg_20_0 + arg_20_8, arg_20_1 + arg_20_3 - arg_20_9, arg_20_2 - arg_20_8 * 2, arg_20_9, arg_20_4, arg_20_5, arg_20_6, arg_20_7)
					renderer.rectangle(arg_20_0, arg_20_1 + arg_20_8, arg_20_9, arg_20_3 - arg_20_8 * 2, arg_20_4, arg_20_5, arg_20_6, arg_20_7)
					renderer.rectangle(arg_20_0 + arg_20_2 - arg_20_9, arg_20_1 + arg_20_8, arg_20_9, arg_20_3 - arg_20_8 * 2, arg_20_4, arg_20_5, arg_20_6, arg_20_7)
					renderer.circle_outline(arg_20_0 + arg_20_8, arg_20_1 + arg_20_8, arg_20_4, arg_20_5, arg_20_6, arg_20_7, arg_20_8, 180, 0.25, arg_20_9)
					renderer.circle_outline(arg_20_0 + arg_20_8, arg_20_1 + arg_20_3 - arg_20_8, arg_20_4, arg_20_5, arg_20_6, arg_20_7, arg_20_8, 90, 0.25, arg_20_9)
					renderer.circle_outline(arg_20_0 + arg_20_2 - arg_20_8, arg_20_1 + arg_20_8, arg_20_4, arg_20_5, arg_20_6, arg_20_7, arg_20_8, -90, 0.25, arg_20_9)
					renderer.circle_outline(arg_20_0 + arg_20_2 - arg_20_8, arg_20_1 + arg_20_3 - arg_20_8, arg_20_4, arg_20_5, arg_20_6, arg_20_7, arg_20_8, 0, 0.25, arg_20_9)
				end
			end
		}

		function var_17_0.glow_module_notify(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6, arg_21_7, arg_21_8, arg_21_9, arg_21_10, arg_21_11, arg_21_12, arg_21_13, arg_21_14)
			local var_21_0 = 1
			local var_21_1 = 1

			if arg_21_14 then
				var_17_0.rec(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_6, arg_21_7, arg_21_8, arg_21_9, arg_21_5)
			end

			for iter_21_0 = 0, arg_21_4 do
				local var_21_2 = arg_21_9 / 2 * (iter_21_0 / arg_21_4)^3

				var_17_0.rec_outline(arg_21_0 + (iter_21_0 - arg_21_4 - var_21_1) * var_21_0, arg_21_1 + (iter_21_0 - arg_21_4 - var_21_1) * var_21_0, arg_21_2 - (iter_21_0 - arg_21_4 - var_21_1) * var_21_0 * 2, arg_21_3 - (iter_21_0 - arg_21_4 - var_21_1) * var_21_0 * 2, arg_21_10, arg_21_11, arg_21_12, var_21_2 / 1.5, arg_21_5 + var_21_0 * (arg_21_4 - iter_21_0 + var_21_1), var_21_0)
			end
		end

		return var_17_0
	end)()

	function var_9_4.render_bottom(arg_22_0, arg_22_1, arg_22_2)
		local var_22_0 = var_9_2()
		local var_22_1 = 16
		local var_22_2 = "     " .. arg_22_0:get_text()
		local var_22_3 = var_9_3("", var_22_2)
		local var_22_4 = 4
		local var_22_5 = var_0_7.color[1]
		local var_22_6 = var_0_7.color[2]
		local var_22_7 = var_0_7.color[3]
		local var_22_8 = 30
		local var_22_9 = 30
		local var_22_10 = 30
		local var_22_11 = 11
		local var_22_12 = 2
		local var_22_13 = 0 + var_22_1 + var_22_3.x + var_22_12 * 2
		local var_22_14 = 23
		local var_22_15 = arg_22_0.x - var_22_13 / 2
		local var_22_16 = math.ceil(arg_22_0.y - 40 + 0.4)
		local var_22_17 = globals.frametime()

		if globals.realtime() < arg_22_0.delay then
			arg_22_0.y = var_9_1(arg_22_0.y, var_22_0.y - var_0_7.offset - (arg_22_2 - arg_22_1) * var_22_14 * 1.5, var_22_17 * 7)
			arg_22_0.color.a = var_9_1(arg_22_0.color.a, var_0_7.blured and 125 or 255, var_22_17 * 2)
		else
			arg_22_0.y = var_9_1(arg_22_0.y, arg_22_0.y - 10, var_22_17 * 15)
			arg_22_0.color.a = var_9_1(arg_22_0.color.a, 0, var_22_17 * 20)

			if arg_22_0.color.a <= 1 then
				arg_22_0.active = false
			end
		end

		local var_22_18 = arg_22_0.color.r
		local var_22_19 = arg_22_0.color.g
		local var_22_20 = arg_22_0.color.b
		local var_22_21 = arg_22_0.color.a

		if var_0_7.blured then
			var_22_8, var_22_9, var_22_10 = var_22_5, var_22_6, var_22_7
		else
			var_22_8, var_22_9, var_22_10 = 20, 20, 20
		end

		var_9_5.glow_module_notify(var_22_15 + 26, var_22_16, var_22_13 - 15, var_22_14, var_22_11, var_22_4, var_22_8, var_22_9, var_22_10, var_22_21, var_22_5, var_22_6, var_22_7, var_22_21, true)
		var_9_5.glow_module_notify(var_22_15 - 5, var_22_16, 25, var_22_14, var_22_11, var_22_4, var_22_8, var_22_9, var_22_10, var_22_21, var_22_5, var_22_6, var_22_7, var_22_21, true)

		local var_22_22 = var_22_12 + 2 + 0 + var_22_1

		renderer.texture(var_0_9, var_22_15 + var_22_22 - 18, var_22_16 + var_22_14 / 2 - var_22_3.y / 2 + 1, 11, 11, var_22_5, var_22_6, var_22_7, var_22_21)
		renderer.text(var_22_15 + var_22_22, var_22_16 + var_22_14 / 2 - var_22_3.y / 2, var_22_18, var_22_19, var_22_20, var_22_21, "", nil, var_22_2)
	end

	client.set_event_callback("paint_ui", function()
		var_9_4:handler()
	end)

	return var_9_4
end)()
local var_0_11 = panorama.open()
local var_0_12 = var_0_11.MyPersonaAPI.GetName()
local var_0_13 = {
	vers = "1.6",
	build = "sunlight",
	name = var_0_12,
	shots = {
		total = 0,
		hits = 0
	}
}

client.delay_call(2, function()
	var_0_10.create_new({
		{
			"Welcome back, "
		},
		{
			var_0_13.name,
			true
		},
		{
			" to onesense "
		},
		{
			var_0_13.build,
			true
		},
		{
			" " .. var_0_13.vers,
			false
		}
	})
end)

math.FLOAT_MAX = 3.4028235e+38

local var_0_14 = var_0_6.typeof("void***")
local var_0_15 = client.create_interface("client.dll", "VClientEntityList003") or error("VClientEntityList003 wasnt found", 2)
local var_0_16 = var_0_6.cast(var_0_14, var_0_15) or error("rawientitylist is nil", 2)
local var_0_17 = var_0_6.cast("void*(__thiscall*)(void*, int)", var_0_16[0][3]) or error("get_client_entity is nil", 2)
local var_0_18 = {
	HIT = {
		11,
		2048
	}
}

local function var_0_19(arg_25_0, arg_25_1)
	if not arg_25_0 or not arg_25_1 then
		return false
	end

	local var_25_0 = var_0_18[arg_25_1]

	if var_25_0 == nil then
		return false
	end

	local var_25_1 = entity.get_esp_data(arg_25_0) or {}

	return bit.band(var_25_1.flags or 0, bit.lshift(1, var_25_0[1])) == var_25_0[2]
end

local var_0_20 = "struct {char         __pad_0x0000[0x1cd]; bool         hide_vm_scope; }"
local var_0_21 = client.find_signature("client_panorama.dll", "\x8B5\xCC\xCC\xCC\xCC\xFF\x10\x0F\xB7\xC0")
local var_0_22 = var_0_6.cast("void****", var_0_6.cast("char*", var_0_21) + 2)[0]
local var_0_23 = vtable_thunk(2, var_0_20 .. "*(__thiscall*)(void*, unsigned int)")
local var_0_24 = (function()
	local var_26_0 = {}
	local var_26_1 = {}
	local var_26_2 = {}

	var_26_0.__metatable = false

	function var_26_1.struct(arg_27_0, arg_27_1)
		assert(type(arg_27_1) == "string", "invalid class name")
		assert(rawget(arg_27_0, arg_27_1) == nil, "cannot overwrite subclass")

		return function(arg_28_0)
			assert(type(arg_28_0) == "table", "invalid class data")
			rawset(arg_27_0, arg_27_1, setmetatable(arg_28_0, {
				__metatable = false,
				__index = function(arg_29_0, arg_29_1)
					return rawget(var_26_0, arg_29_1) or rawget(var_26_2, arg_29_1)
				end
			}))

			return var_26_2
		end
	end

	var_26_2 = setmetatable(var_26_1, var_26_0)

	return var_26_2
end)():struct("globals")({
	nade = 0,
	default_cfg = "{onesense:config}:W3sidGFiIjoiaG9tZSIsInRpdGxlX25hbWVfYyI6IiNBNEQyRDRGRiJ9LHsibWFudWFsX2FhIjp0cnVlLCJtYW51YWxfbGVmdCI6WzIsOTAsIn4iXSwiZWRnZV95YXdfaCI6WzEsMCwifiJdLCJmcmVlc3RhbmRpbmdfZGlzYWJsZXJzIjpbIn4iXSwiZnJlZXN0YW5kaW5nX2giOlsxLDE4LCJ+Il0sIm1hbnVhbF9yaWdodCI6WzIsNjcsIn4iXSwibWFudWFsX2ZvcndhcmQiOlsxLDAsIn4iXSwibWFudWFsX3N0YXRpYyI6dHJ1ZSwic3RhdGVzIjp7ImFlcm9iaWMiOnsiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MjEiOjg5LCJib2R5X3lhdyI6IkppdHRlciIsImRlZmVuc2l2ZV9waXRjaF9jbG9jayI6MCwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHkiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3JhbmRvbWl6ZXJfU3Bpbl93YXkiOjAsInlhd19qaXR0ZXIiOiJPZmZzZXQiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X3NwZWVkX1NwaW5fd2F5Ijo2LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQyMiI6ODksInlhd19hZGQiOjI4LCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDMiOjgsImRlZmVuc2l2ZV95YXdfd2F5X2RlbGF5Ijo0LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNCI6OCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfcmFkaXVzXzEiOjMwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMyI6OCwiZGVmZW5zaXZlX2ZyZWVzdGFuZCI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW41IjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MiI6ODksImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDMiOjMwLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9yYW5kb20iOjAsImRlZmVuc2l2ZV9waXRjaF93YXkyIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gxIjozMCwiYm9keV95YXdfc2lkZSI6IkxlZnQiLCJkZWZlbnNpdmVfeWF3X3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX2NvbmRpdGlvbnMiOlsifiJdLCJkZWZlbnNpdmVfcGl0Y2hfc3BlZWR0aWNrIjo2LCJkZWZlbnNpdmVfcGl0Y2hfbW9kZSI6IlN0YXRpYyIsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDUyIjo4OSwiZW5hYmxlIjp0cnVlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDEiOjgsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluNSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQyIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g0IjozMCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW40IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjEiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ1Ijo4LCJkZWZlbnNpdmVfcGl0Y2hfc3Bpbl9saW1pdDIiOjAsInlhd19qaXR0ZXJfYWRkIjotMzQsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDUiOjMwLCJkZWZlbnNpdmVfcGl0Y2hfc3Bpbl9yYW5kb20yIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NSI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMiI6MzAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDUxIjo4OSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDMiOjAsImRlZmVuc2l2ZV95YXdfM3dheV9saW1pdCI6MjUsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9jb21ibyI6IjEtd2F5IiwiZGVmZW5zaXZlX3lhd19zcGluX2xpbWl0IjozNjAsImRlZmVuc2l2ZV95YXdfaml0dGVyX2RlbGF5Ijo2LCJvcHRpb25zIjpbIkF2b2lkIGJhY2tzdGFiIiwifiJdLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDEiOjAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjQiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ1Ijo4LCJkZWZlbnNpdmVfeWF3X3dheXNwaW5fY29tYm8iOiIxLXdheSIsImRlZmVuc2l2ZV9waXRjaF9jdXN0b20iOjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQxIjo4LCJ5YXdfYWRkX3IiOjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDExIjo4OSwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwieWF3X2Jhc2UiOiJBdCB0YXJnZXRzIiwiZGVmZW5zaXZlX3lhd18yX1NwaW5fd2F5IjoxODAsImRlZmVuc2l2ZV95YXciOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ0Ijo4LCJkZWZlbnNpdmVfeWF3XzFfU3Bpbl93YXkiOi0xODAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGUiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMiI6OCwiaml0dGVyX2RlbGF5IjowLCJkZWZlbnNpdmVfeWF3X21vZGUiOiJKaXR0ZXIiLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDIiOjgsImRlc3luY19tb2RlIjoiRGVmYXVsdCIsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDEyIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheTMiOjAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4xIjpmYWxzZX0sInNsb3cgd2FsayI6eyJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQyMSI6ODksImJvZHlfeWF3IjoiSml0dGVyIiwiZGVmZW5zaXZlX3BpdGNoX2Nsb2NrIjowLCJkZWZlbnNpdmVfeWF3X3dheV9yYW5kb21seSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfcmFuZG9taXplcl9TcGluX3dheSI6MCwieWF3X2ppdHRlciI6Ik9mZnNldCIsImRlZmVuc2l2ZV9waXRjaF93YXk1IjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQzMSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDQxIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9yYW5kb21seV92YWx1ZSI6MjAsImRlZmVuc2l2ZV95YXdfc3BlZWRfU3Bpbl93YXkiOjYsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDIyIjo4OSwieWF3X2FkZCI6LTI2LCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDMiOjgsImRlZmVuc2l2ZV95YXdfd2F5X2RlbGF5Ijo0LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNCI6OCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfcmFkaXVzXzEiOjMwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMyI6OCwiZGVmZW5zaXZlX2ZyZWVzdGFuZCI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW41IjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MiI6ODksImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDMiOjMwLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9yYW5kb20iOjAsImRlZmVuc2l2ZV9waXRjaF93YXkyIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gxIjozMCwiYm9keV95YXdfc2lkZSI6IkxlZnQiLCJkZWZlbnNpdmVfeWF3X3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX2NvbmRpdGlvbnMiOlsifiJdLCJkZWZlbnNpdmVfcGl0Y2hfc3BlZWR0aWNrIjo2LCJkZWZlbnNpdmVfcGl0Y2hfbW9kZSI6IlN0YXRpYyIsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDUyIjo4OSwiZW5hYmxlIjp0cnVlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDEiOjgsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluNSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQyIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g0IjozMCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW40IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjEiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ1Ijo4LCJkZWZlbnNpdmVfcGl0Y2hfc3Bpbl9saW1pdDIiOjAsInlhd19qaXR0ZXJfYWRkIjo2MywiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoNSI6MzAsImRlZmVuc2l2ZV9waXRjaF9zcGluX3JhbmRvbTIiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQ1IjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gyIjozMCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NTEiOjg5LCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MyI6MCwiZGVmZW5zaXZlX3lhd18zd2F5X2xpbWl0IjoyNSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2NvbWJvIjoiMS13YXkiLCJkZWZlbnNpdmVfeWF3X3NwaW5fbGltaXQiOjM2MCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfZGVsYXkiOjYsIm9wdGlvbnMiOlsifiJdLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDEiOjAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjQiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ1Ijo4LCJkZWZlbnNpdmVfeWF3X3dheXNwaW5fY29tYm8iOiIxLXdheSIsImRlZmVuc2l2ZV9waXRjaF9jdXN0b20iOjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQxIjo4LCJ5YXdfYWRkX3IiOjgsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDExIjo4OSwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwieWF3X2Jhc2UiOiJBdCB0YXJnZXRzIiwiZGVmZW5zaXZlX3lhd18yX1NwaW5fd2F5IjoxODAsImRlZmVuc2l2ZV95YXciOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ0Ijo4LCJkZWZlbnNpdmVfeWF3XzFfU3Bpbl93YXkiOi0xODAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGUiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMiI6OCwiaml0dGVyX2RlbGF5IjoyLCJkZWZlbnNpdmVfeWF3X21vZGUiOiJKaXR0ZXIiLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDIiOjgsImRlc3luY19tb2RlIjoiRXh0ZW5kZWQiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQxMiI6ODksImRlZmVuc2l2ZV9waXRjaF93YXkzIjowLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMSI6ZmFsc2V9LCJzbmVhayI6eyJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQyMSI6ODksImJvZHlfeWF3IjoiSml0dGVyIiwiZGVmZW5zaXZlX3BpdGNoX2Nsb2NrIjowLCJkZWZlbnNpdmVfeWF3X3dheV9yYW5kb21seSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfcmFuZG9taXplcl9TcGluX3dheSI6MCwieWF3X2ppdHRlciI6Ik9mZnNldCIsImRlZmVuc2l2ZV9waXRjaF93YXk1IjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQzMSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDQxIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9yYW5kb21seV92YWx1ZSI6MjAsImRlZmVuc2l2ZV95YXdfc3BlZWRfU3Bpbl93YXkiOjYsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDIyIjo4OSwieWF3X2FkZCI6LTE5LCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDMiOjgsImRlZmVuc2l2ZV95YXdfd2F5X2RlbGF5Ijo0LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNCI6OCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfcmFkaXVzXzEiOjMwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMyI6OCwiZGVmZW5zaXZlX2ZyZWVzdGFuZCI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW41IjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MiI6ODksImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDMiOjMwLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9yYW5kb20iOjAsImRlZmVuc2l2ZV9waXRjaF93YXkyIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gxIjozMCwiYm9keV95YXdfc2lkZSI6IkxlZnQiLCJkZWZlbnNpdmVfeWF3X3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX2NvbmRpdGlvbnMiOlsifiJdLCJkZWZlbnNpdmVfcGl0Y2hfc3BlZWR0aWNrIjo2LCJkZWZlbnNpdmVfcGl0Y2hfbW9kZSI6IlN0YXRpYyIsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDUyIjo4OSwiZW5hYmxlIjp0cnVlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDEiOjgsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluNSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQyIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g0IjozMCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW40IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjEiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ1Ijo4LCJkZWZlbnNpdmVfcGl0Y2hfc3Bpbl9saW1pdDIiOjAsInlhd19qaXR0ZXJfYWRkIjo2OCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoNSI6MzAsImRlZmVuc2l2ZV9waXRjaF9zcGluX3JhbmRvbTIiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQ1IjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gyIjozMCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NTEiOjg5LCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MyI6MCwiZGVmZW5zaXZlX3lhd18zd2F5X2xpbWl0IjoyNSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2NvbWJvIjoiMS13YXkiLCJkZWZlbnNpdmVfeWF3X3NwaW5fbGltaXQiOjM2MCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfZGVsYXkiOjYsIm9wdGlvbnMiOlsifiJdLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDEiOjAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjQiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ1Ijo4LCJkZWZlbnNpdmVfeWF3X3dheXNwaW5fY29tYm8iOiIxLXdheSIsImRlZmVuc2l2ZV9waXRjaF9jdXN0b20iOjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQxIjo4LCJ5YXdfYWRkX3IiOjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDExIjo4OSwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwieWF3X2Jhc2UiOiJBdCB0YXJnZXRzIiwiZGVmZW5zaXZlX3lhd18yX1NwaW5fd2F5IjoxODAsImRlZmVuc2l2ZV95YXciOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ0Ijo4LCJkZWZlbnNpdmVfeWF3XzFfU3Bpbl93YXkiOi0xODAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGUiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMiI6OCwiaml0dGVyX2RlbGF5IjoyLCJkZWZlbnNpdmVfeWF3X21vZGUiOiJKaXR0ZXIiLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDIiOjgsImRlc3luY19tb2RlIjoiRXh0ZW5kZWQiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQxMiI6ODksImRlZmVuc2l2ZV9waXRjaF93YXkzIjowLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMSI6ZmFsc2V9LCJmYWtlbGFnIjp7ImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDIxIjo4OSwiYm9keV95YXciOiJPZmYiLCJkZWZlbnNpdmVfcGl0Y2hfY2xvY2siOjAsImRlZmVuc2l2ZV95YXdfd2F5X3JhbmRvbWx5IjpmYWxzZSwiZGVmZW5zaXZlX3lhd19yYW5kb21pemVyX1NwaW5fd2F5IjowLCJ5YXdfaml0dGVyIjoiT2ZmIiwiZGVmZW5zaXZlX3BpdGNoX3dheTUiOjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDMxIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NDEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5X3ZhbHVlIjoyMCwiZGVmZW5zaXZlX3lhd19zcGVlZF9TcGluX3dheSI6NiwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MjIiOjg5LCJ5YXdfYWRkIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDMiOjgsImRlZmVuc2l2ZV95YXdfd2F5X2RlbGF5Ijo0LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNCI6OCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfcmFkaXVzXzEiOjMwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMyI6OCwiZGVmZW5zaXZlX2ZyZWVzdGFuZCI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW41IjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MiI6ODksImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDMiOjMwLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9yYW5kb20iOjAsImRlZmVuc2l2ZV9waXRjaF93YXkyIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gxIjozMCwiYm9keV95YXdfc2lkZSI6IkxlZnQiLCJkZWZlbnNpdmVfeWF3X3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX2NvbmRpdGlvbnMiOlsifiJdLCJkZWZlbnNpdmVfcGl0Y2hfc3BlZWR0aWNrIjo2LCJkZWZlbnNpdmVfcGl0Y2hfbW9kZSI6IlN0YXRpYyIsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDUyIjo4OSwiZW5hYmxlIjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQxIjo4LCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjUiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MiI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoNCI6MzAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluNCI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3JhbmRvbWx5X3ZhbHVlIjoyMCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4xIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjMiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNSI6OCwiZGVmZW5zaXZlX3BpdGNoX3NwaW5fbGltaXQyIjowLCJ5YXdfaml0dGVyX2FkZCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoNSI6MzAsImRlZmVuc2l2ZV9waXRjaF9zcGluX3JhbmRvbTIiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQ1IjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gyIjozMCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NTEiOjg5LCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MyI6MCwiZGVmZW5zaXZlX3lhd18zd2F5X2xpbWl0IjoyNSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2NvbWJvIjoiMS13YXkiLCJkZWZlbnNpdmVfeWF3X3NwaW5fbGltaXQiOjM2MCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfZGVsYXkiOjYsIm9wdGlvbnMiOlsifiJdLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDEiOjAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjQiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ1Ijo4LCJkZWZlbnNpdmVfeWF3X3dheXNwaW5fY29tYm8iOiIxLXdheSIsImRlZmVuc2l2ZV9waXRjaF9jdXN0b20iOjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQxIjo4LCJ5YXdfYWRkX3IiOjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDExIjo4OSwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwieWF3X2Jhc2UiOiJBdCB0YXJnZXRzIiwiZGVmZW5zaXZlX3lhd18yX1NwaW5fd2F5IjoxODAsImRlZmVuc2l2ZV95YXciOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ0Ijo4LCJkZWZlbnNpdmVfeWF3XzFfU3Bpbl93YXkiOi0xODAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGUiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMiI6OCwiaml0dGVyX2RlbGF5IjoxLCJkZWZlbnNpdmVfeWF3X21vZGUiOiJKaXR0ZXIiLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDIiOjgsImRlc3luY19tb2RlIjoiRGVmYXVsdCIsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDEyIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheTMiOjAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4xIjpmYWxzZX0sInJ1biI6eyJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQyMSI6ODksImJvZHlfeWF3IjoiSml0dGVyIiwiZGVmZW5zaXZlX3BpdGNoX2Nsb2NrIjowLCJkZWZlbnNpdmVfeWF3X3dheV9yYW5kb21seSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfcmFuZG9taXplcl9TcGluX3dheSI6MCwieWF3X2ppdHRlciI6IkNlbnRlciIsImRlZmVuc2l2ZV9waXRjaF93YXk1IjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQzMSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDQxIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9yYW5kb21seV92YWx1ZSI6MjAsImRlZmVuc2l2ZV95YXdfc3BlZWRfU3Bpbl93YXkiOjYsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDIyIjo4OSwieWF3X2FkZCI6MTksImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMyI6OCwiZGVmZW5zaXZlX3lhd193YXlfZGVsYXkiOjQsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ0Ijo4LCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9yYWRpdXNfMSI6MzAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQzIjo4LCJkZWZlbnNpdmVfZnJlZXN0YW5kIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjUiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQzMiI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDQyIjo4OSwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMyI6MzAsImRlZmVuc2l2ZV95YXdfaml0dGVyX3JhbmRvbSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheTIiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDEiOjMwLCJib2R5X3lhd19zaWRlIjoiTGVmdCIsImRlZmVuc2l2ZV95YXdfc3BlZWR0aWNrIjo2LCJkZWZlbnNpdmVfY29uZGl0aW9ucyI6WyJ+Il0sImRlZmVuc2l2ZV9waXRjaF9zcGVlZHRpY2siOjYsImRlZmVuc2l2ZV9waXRjaF9tb2RlIjoiU3RhdGljIiwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NTIiOjg5LCJlbmFibGUiOnRydWUsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMSI6OCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW41IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDIiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDQiOjMwLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjQiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9yYW5kb21seV92YWx1ZSI6MjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMSI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4zIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDUiOjgsImRlZmVuc2l2ZV9waXRjaF9zcGluX2xpbWl0MiI6MCwieWF3X2ppdHRlcl9hZGQiOjMwLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g1IjozMCwiZGVmZW5zaXZlX3BpdGNoX3NwaW5fcmFuZG9tMiI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDUiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDIiOjMwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ1MSI6ODksImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQzIjowLCJkZWZlbnNpdmVfeWF3XzN3YXlfbGltaXQiOjI1LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fY29tYm8iOiIxLXdheSIsImRlZmVuc2l2ZV95YXdfc3Bpbl9saW1pdCI6MzYwLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9kZWxheSI6Niwib3B0aW9ucyI6WyJ+Il0sImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHkiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MSI6MCwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjIiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluNCI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQ0IjowLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDUiOjgsImRlZmVuc2l2ZV95YXdfd2F5c3Bpbl9jb21ibyI6IjEtd2F5IiwiZGVmZW5zaXZlX3BpdGNoX2N1c3RvbSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDEiOjgsInlhd19hZGRfciI6LTgsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDExIjo4OSwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwieWF3X2Jhc2UiOiJBdCB0YXJnZXRzIiwiZGVmZW5zaXZlX3lhd18yX1NwaW5fd2F5IjoxODAsImRlZmVuc2l2ZV95YXciOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ0Ijo4LCJkZWZlbnNpdmVfeWF3XzFfU3Bpbl93YXkiOi0xODAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGUiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMiI6OCwiaml0dGVyX2RlbGF5IjoyLCJkZWZlbnNpdmVfeWF3X21vZGUiOiJKaXR0ZXIiLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDIiOjgsImRlc3luY19tb2RlIjoiRXh0ZW5kZWQiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQxMiI6ODksImRlZmVuc2l2ZV9waXRjaF93YXkzIjowLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMSI6ZmFsc2V9LCJnbG9iYWwiOnsiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MjEiOjg5LCJib2R5X3lhdyI6Ik9mZiIsImRlZmVuc2l2ZV9waXRjaF9jbG9jayI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MTIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5MyI6MCwieWF3X2ppdHRlciI6Ik9mZiIsImRlZmVuc2l2ZV9waXRjaF93YXk1IjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQzMSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDQxIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9yYW5kb21seV92YWx1ZSI6MjAsImRlZmVuc2l2ZV95YXdfc3BlZWRfU3Bpbl93YXkiOjYsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDIyIjo4OSwieWF3X2FkZCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQzIjo4LCJkZWZlbnNpdmVfeWF3X3dheV9kZWxheSI6NCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDQiOjgsImRlZmVuc2l2ZV95YXdfaml0dGVyX3JhZGl1c18xIjozMCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDMiOjgsImRlZmVuc2l2ZV9mcmVlc3RhbmQiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluNSI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDMyIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NDIiOjg5LCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gzIjozMCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfcmFuZG9tIjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5MiI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMSI6MzAsImJvZHlfeWF3X3NpZGUiOiJMZWZ0IiwiZGVmZW5zaXZlX3lhd19zcGVlZHRpY2siOjYsImRlZmVuc2l2ZV95YXdfd2F5c3Bpbl9jb21ibyI6IjEtd2F5IiwiZGVmZW5zaXZlX3BpdGNoX3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX3BpdGNoX21vZGUiOiJTdGF0aWMiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ1MiI6ODksImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMSI6OCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW41IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDIiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDQiOjMwLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjQiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9yYW5kb21seV92YWx1ZSI6MjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDIiOjMwLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMiI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF9zcGluX2xpbWl0MiI6MCwieWF3X2ppdHRlcl9hZGQiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDUiOjMwLCJkZWZlbnNpdmVfcGl0Y2hfc3Bpbl9yYW5kb20yIjowLCJkZWZlbnNpdmVfeWF3X3dheV9yYW5kb21seSI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4zIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NTEiOjg5LCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MyI6MCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfZGVsYXkiOjYsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9jb21ibyI6IjEtd2F5IiwiZGVmZW5zaXZlX3lhd19zcGluX2xpbWl0IjozNjAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW40IjpmYWxzZSwib3B0aW9ucyI6WyJ+Il0sImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHkiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MSI6MCwiZGVzeW5jX21vZGUiOiJEZWZhdWx0IiwiZGVmZW5zaXZlX3lhd19yYW5kb21pemVyX1NwaW5fd2F5IjowLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ1Ijo4LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMSI6OCwiZGVmZW5zaXZlX3BpdGNoX2N1c3RvbSI6MCwiZGVmZW5zaXZlX3lhd18xX1NwaW5fd2F5IjotMTgwLCJ5YXdfYWRkX3IiOjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDExIjo4OSwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwieWF3X2Jhc2UiOiJBdCB0YXJnZXRzIiwiZGVmZW5zaXZlX3lhdyI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkNCI6OCwiZGVmZW5zaXZlX3BpdGNoX3dheTQiOjAsImRlZmVuc2l2ZV9jb25kaXRpb25zIjpbIn4iXSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDUiOjgsImRlZmVuc2l2ZV9waXRjaF9lbmFibGUiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMiI6OCwiaml0dGVyX2RlbGF5IjoxLCJkZWZlbnNpdmVfeWF3X21vZGUiOiJKaXR0ZXIiLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDIiOjgsImRlZmVuc2l2ZV95YXdfMl9TcGluX3dheSI6MTgwLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NSI6MCwiZGVmZW5zaXZlX3lhd18zd2F5X2xpbWl0IjoyNSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjEiOmZhbHNlfSwic3RhbmQiOnsiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MjEiOjg5LCJib2R5X3lhdyI6IkppdHRlciIsImRlZmVuc2l2ZV9waXRjaF9jbG9jayI6MCwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHkiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3JhbmRvbWl6ZXJfU3Bpbl93YXkiOjAsInlhd19qaXR0ZXIiOiJDZW50ZXIiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X3NwZWVkX1NwaW5fd2F5Ijo2LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQyMiI6ODksInlhd19hZGQiOjI5LCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDMiOjgsImRlZmVuc2l2ZV95YXdfd2F5X2RlbGF5Ijo0LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNCI6OCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfcmFkaXVzXzEiOjQ1LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMyI6OCwiZGVmZW5zaXZlX2ZyZWVzdGFuZCI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW41IjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MiI6ODksImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDMiOjMwLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9yYW5kb20iOjE1LCJkZWZlbnNpdmVfcGl0Y2hfd2F5MiI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMSI6MzAsImJvZHlfeWF3X3NpZGUiOiJGcmVlc3RhbmRpbmciLCJkZWZlbnNpdmVfeWF3X3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX2NvbmRpdGlvbnMiOlsiQWx3YXlzIiwiT24gd2VhcG9uIHN3aXRjaCIsIk9uIHJlbG9hZCIsIk9uIGhpdHRhYmxlIiwiT24gZnJlZXN0YW5kIiwifiJdLCJkZWZlbnNpdmVfcGl0Y2hfc3BlZWR0aWNrIjo2LCJkZWZlbnNpdmVfcGl0Y2hfbW9kZSI6IlJhbmRvbSIsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDUyIjo4OSwiZW5hYmxlIjp0cnVlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDEiOjgsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluNSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQyIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g0IjozMCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW40IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjEiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ1Ijo4LCJkZWZlbnNpdmVfcGl0Y2hfc3Bpbl9saW1pdDIiOjAsInlhd19qaXR0ZXJfYWRkIjotMTAsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDUiOjMwLCJkZWZlbnNpdmVfcGl0Y2hfc3Bpbl9yYW5kb20yIjo1MCwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDUiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDIiOjMwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ1MSI6ODksImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQzIjowLCJkZWZlbnNpdmVfeWF3XzN3YXlfbGltaXQiOjI1LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fY29tYm8iOiIxLXdheSIsImRlZmVuc2l2ZV95YXdfc3Bpbl9saW1pdCI6MzYwLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9kZWxheSI6NSwib3B0aW9ucyI6WyJ+Il0sImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHkiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MSI6MCwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjIiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluNCI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQ0IjowLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDUiOjgsImRlZmVuc2l2ZV95YXdfd2F5c3Bpbl9jb21ibyI6IjEtd2F5IiwiZGVmZW5zaXZlX3BpdGNoX2N1c3RvbSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQxIjo4LCJ5YXdfYWRkX3IiOi0xLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjMiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQxMSI6ODksImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMiI6ZmFsc2UsInlhd19iYXNlIjoiQXQgdGFyZ2V0cyIsImRlZmVuc2l2ZV95YXdfMl9TcGluX3dheSI6MTgwLCJkZWZlbnNpdmVfeWF3Ijp0cnVlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ0Ijo4LCJkZWZlbnNpdmVfeWF3XzFfU3Bpbl93YXkiOi0xODAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGUiOnRydWUsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQyIjo4LCJqaXR0ZXJfZGVsYXkiOjIsImRlZmVuc2l2ZV95YXdfbW9kZSI6IkppdHRlciIsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMiI6OCwiZGVzeW5jX21vZGUiOiJEZWZhdWx0IiwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MTIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5MyI6MCwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjEiOmZhbHNlfSwiY3JvdWNoIjp7ImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDIxIjo4OSwiYm9keV95YXciOiJKaXR0ZXIiLCJkZWZlbnNpdmVfcGl0Y2hfY2xvY2siOjAsImRlZmVuc2l2ZV95YXdfd2F5X3JhbmRvbWx5IjpmYWxzZSwiZGVmZW5zaXZlX3lhd19yYW5kb21pemVyX1NwaW5fd2F5IjowLCJ5YXdfaml0dGVyIjoiQ2VudGVyIiwiZGVmZW5zaXZlX3BpdGNoX3dheTUiOjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDMxIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NDEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5X3ZhbHVlIjoyMCwiZGVmZW5zaXZlX3lhd19zcGVlZF9TcGluX3dheSI6NiwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MjIiOjg5LCJ5YXdfYWRkIjo1LCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDMiOjgsImRlZmVuc2l2ZV95YXdfd2F5X2RlbGF5Ijo0LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNCI6OCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfcmFkaXVzXzEiOjMwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMyI6OCwiZGVmZW5zaXZlX2ZyZWVzdGFuZCI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW41IjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MiI6ODksImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDMiOjMwLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9yYW5kb20iOjAsImRlZmVuc2l2ZV9waXRjaF93YXkyIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gxIjozMCwiYm9keV95YXdfc2lkZSI6IkxlZnQiLCJkZWZlbnNpdmVfeWF3X3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX2NvbmRpdGlvbnMiOlsifiJdLCJkZWZlbnNpdmVfcGl0Y2hfc3BlZWR0aWNrIjo2LCJkZWZlbnNpdmVfcGl0Y2hfbW9kZSI6IlN0YXRpYyIsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDUyIjo4OSwiZW5hYmxlIjp0cnVlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDEiOjgsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluNSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQyIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g0IjozMCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW40IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjEiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ1Ijo4LCJkZWZlbnNpdmVfcGl0Y2hfc3Bpbl9saW1pdDIiOjAsInlhd19qaXR0ZXJfYWRkIjozNiwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoNSI6MzAsImRlZmVuc2l2ZV9waXRjaF9zcGluX3JhbmRvbTIiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQ1IjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gyIjozMCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NTEiOjg5LCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MyI6MCwiZGVmZW5zaXZlX3lhd18zd2F5X2xpbWl0IjoyNSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2NvbWJvIjoiMS13YXkiLCJkZWZlbnNpdmVfeWF3X3NwaW5fbGltaXQiOjM2MCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfZGVsYXkiOjYsIm9wdGlvbnMiOlsifiJdLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDEiOjAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjQiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ1Ijo4LCJkZWZlbnNpdmVfeWF3X3dheXNwaW5fY29tYm8iOiIxLXdheSIsImRlZmVuc2l2ZV9waXRjaF9jdXN0b20iOjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQxIjo4LCJ5YXdfYWRkX3IiOjAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDExIjo4OSwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwieWF3X2Jhc2UiOiJBdCB0YXJnZXRzIiwiZGVmZW5zaXZlX3lhd18yX1NwaW5fd2F5IjoxODAsImRlZmVuc2l2ZV95YXciOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ0Ijo4LCJkZWZlbnNpdmVfeWF3XzFfU3Bpbl93YXkiOi0xODAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGUiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkMiI6OCwiaml0dGVyX2RlbGF5IjoyLCJkZWZlbnNpdmVfeWF3X21vZGUiOiJKaXR0ZXIiLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDIiOjgsImRlc3luY19tb2RlIjoiRXh0ZW5kZWQiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQxMiI6ODksImRlZmVuc2l2ZV9waXRjaF93YXkzIjowLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMSI6ZmFsc2V9LCJoaWRlc2hvdHMiOnsiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MjEiOjg5LCJib2R5X3lhdyI6Ik9mZiIsImRlZmVuc2l2ZV9waXRjaF9jbG9jayI6MCwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHkiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3JhbmRvbWl6ZXJfU3Bpbl93YXkiOjAsInlhd19qaXR0ZXIiOiJPZmYiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X3NwZWVkX1NwaW5fd2F5Ijo2LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQyMiI6ODksInlhd19hZGQiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMyI6OCwiZGVmZW5zaXZlX3lhd193YXlfZGVsYXkiOjQsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ0Ijo4LCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9yYWRpdXNfMSI6MzAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQzIjo4LCJkZWZlbnNpdmVfZnJlZXN0YW5kIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjUiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQzMiI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDQyIjo4OSwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMyI6MzAsImRlZmVuc2l2ZV95YXdfaml0dGVyX3JhbmRvbSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheTIiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDEiOjMwLCJib2R5X3lhd19zaWRlIjoiTGVmdCIsImRlZmVuc2l2ZV95YXdfc3BlZWR0aWNrIjo2LCJkZWZlbnNpdmVfY29uZGl0aW9ucyI6WyJ+Il0sImRlZmVuc2l2ZV9waXRjaF9zcGVlZHRpY2siOjYsImRlZmVuc2l2ZV9waXRjaF9tb2RlIjoiU3RhdGljIiwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NTIiOjg5LCJlbmFibGUiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDEiOjgsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluNSI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQyIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g0IjozMCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW40IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjEiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMyI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQ1Ijo4LCJkZWZlbnNpdmVfcGl0Y2hfc3Bpbl9saW1pdDIiOjAsInlhd19qaXR0ZXJfYWRkIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2g1IjozMCwiZGVmZW5zaXZlX3BpdGNoX3NwaW5fcmFuZG9tMiI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDUiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDIiOjMwLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ1MSI6ODksImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQzIjowLCJkZWZlbnNpdmVfeWF3XzN3YXlfbGltaXQiOjI1LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fY29tYm8iOiIxLXdheSIsImRlZmVuc2l2ZV95YXdfc3Bpbl9saW1pdCI6MzYwLCJkZWZlbnNpdmVfeWF3X2ppdHRlcl9kZWxheSI6Niwib3B0aW9ucyI6WyJ+Il0sImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHkiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MSI6MCwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjIiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluNCI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3NwaW5fbGltaXQ0IjowLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDUiOjgsImRlZmVuc2l2ZV95YXdfd2F5c3Bpbl9jb21ibyI6IjEtd2F5IiwiZGVmZW5zaXZlX3BpdGNoX2N1c3RvbSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDEiOjgsInlhd19hZGRfciI6MCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4zIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MTEiOjg5LCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjIiOmZhbHNlLCJ5YXdfYmFzZSI6IkF0IHRhcmdldHMiLCJkZWZlbnNpdmVfeWF3XzJfU3Bpbl93YXkiOjE4MCwiZGVmZW5zaXZlX3lhdyI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXk0IjowLCJkZWZlbnNpdmVfeWF3X3dheV9zcGVlZDQiOjgsImRlZmVuc2l2ZV95YXdfMV9TcGluX3dheSI6LTE4MCwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZSI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQyIjo4LCJqaXR0ZXJfZGVsYXkiOjEsImRlZmVuc2l2ZV95YXdfbW9kZSI6IkppdHRlciIsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkMiI6OCwiZGVzeW5jX21vZGUiOiJEZWZhdWx0IiwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MTIiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5MyI6MCwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjEiOmZhbHNlfSwiYWVyb2JpYysiOnsiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MjEiOjg5LCJib2R5X3lhdyI6IkppdHRlciIsImRlZmVuc2l2ZV9waXRjaF9jbG9jayI6MCwiZGVmZW5zaXZlX3lhd193YXlfcmFuZG9tbHkiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3JhbmRvbWl6ZXJfU3Bpbl93YXkiOjAsInlhd19qaXR0ZXIiOiJDZW50ZXIiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5NSI6MCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0MzEiOjg5LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ0MSI6ODksImRlZmVuc2l2ZV9waXRjaF93YXlfcmFuZG9tbHlfdmFsdWUiOjIwLCJkZWZlbnNpdmVfeWF3X3NwZWVkX1NwaW5fd2F5Ijo2LCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQyMiI6ODksInlhd19hZGQiOi0xMiwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQzIjo4LCJkZWZlbnNpdmVfeWF3X3dheV9kZWxheSI6NCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDQiOjgsImRlZmVuc2l2ZV95YXdfaml0dGVyX3JhZGl1c18xIjozMCwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDMiOjgsImRlZmVuc2l2ZV9mcmVlc3RhbmQiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluNSI6ZmFsc2UsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDMyIjo4OSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGluX2xpbWl0NDIiOjg5LCJkZWZlbnNpdmVfeWF3X3dheV9zd2l0Y2gzIjozMCwiZGVmZW5zaXZlX3lhd19qaXR0ZXJfcmFuZG9tIjowLCJkZWZlbnNpdmVfcGl0Y2hfd2F5MiI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMSI6MzAsImJvZHlfeWF3X3NpZGUiOiJMZWZ0IiwiZGVmZW5zaXZlX3lhd19zcGVlZHRpY2siOjYsImRlZmVuc2l2ZV9jb25kaXRpb25zIjpbIn4iXSwiZGVmZW5zaXZlX3BpdGNoX3NwZWVkdGljayI6NiwiZGVmZW5zaXZlX3BpdGNoX21vZGUiOiJTdGF0aWMiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQ1MiI6ODksImVuYWJsZSI6dHJ1ZSwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQxIjo4LCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjUiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0MiI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoNCI6MzAsImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluNCI6ZmFsc2UsImRlZmVuc2l2ZV95YXdfd2F5X3JhbmRvbWx5X3ZhbHVlIjoyMCwiZGVmZW5zaXZlX3lhd19lbmFibGVfd2F5X3NwaW4xIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjMiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwZWVkNSI6OCwiZGVmZW5zaXZlX3BpdGNoX3NwaW5fbGltaXQyIjowLCJ5YXdfaml0dGVyX2FkZCI6OTAsImRlZmVuc2l2ZV95YXdfd2F5X3N3aXRjaDUiOjMwLCJkZWZlbnNpdmVfcGl0Y2hfc3Bpbl9yYW5kb20yIjowLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NSI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3dpdGNoMiI6MzAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9saW1pdDUxIjo4OSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDMiOjAsImRlZmVuc2l2ZV95YXdfM3dheV9saW1pdCI6MjUsImRlZmVuc2l2ZV9waXRjaF93YXlfc3Bpbl9jb21ibyI6IjEtd2F5IiwiZGVmZW5zaXZlX3lhd19zcGluX2xpbWl0IjozNjAsImRlZmVuc2l2ZV95YXdfaml0dGVyX2RlbGF5Ijo2LCJvcHRpb25zIjpbIkF2b2lkIGJhY2tzdGFiIiwiU2FmZSBoZWFkIiwifiJdLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3JhbmRvbWx5IjpmYWxzZSwiZGVmZW5zaXZlX3lhd193YXlfc3Bpbl9saW1pdDEiOjAsImRlZmVuc2l2ZV9waXRjaF9lbmFibGVfd2F5X3NwaW4yIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX2VuYWJsZV93YXlfc3BpbjQiOmZhbHNlLCJkZWZlbnNpdmVfeWF3X3dheV9zcGluX2xpbWl0NCI6MCwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQ1Ijo4LCJkZWZlbnNpdmVfeWF3X3dheXNwaW5fY29tYm8iOiIxLXdheSIsImRlZmVuc2l2ZV9waXRjaF9jdXN0b20iOjAsImRlZmVuc2l2ZV9waXRjaF93YXlfc3BlZWQxIjo4LCJ5YXdfYWRkX3IiOjE4LCJkZWZlbnNpdmVfeWF3X2VuYWJsZV93YXlfc3BpbjMiOmZhbHNlLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQxMSI6ODksImRlZmVuc2l2ZV95YXdfZW5hYmxlX3dheV9zcGluMiI6ZmFsc2UsInlhd19iYXNlIjoiQXQgdGFyZ2V0cyIsImRlZmVuc2l2ZV95YXdfMl9TcGluX3dheSI6MTgwLCJkZWZlbnNpdmVfeWF3IjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX3dheTQiOjAsImRlZmVuc2l2ZV95YXdfd2F5X3NwZWVkNCI6OCwiZGVmZW5zaXZlX3lhd18xX1NwaW5fd2F5IjotMTgwLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlIjpmYWxzZSwiZGVmZW5zaXZlX3BpdGNoX3dheV9zcGVlZDIiOjgsImppdHRlcl9kZWxheSI6MCwiZGVmZW5zaXZlX3lhd19tb2RlIjoiSml0dGVyIiwiZGVmZW5zaXZlX3lhd193YXlfc3BlZWQyIjo4LCJkZXN5bmNfbW9kZSI6IkRlZmF1bHQiLCJkZWZlbnNpdmVfcGl0Y2hfd2F5X3NwaW5fbGltaXQxMiI6ODksImRlZmVuc2l2ZV9waXRjaF93YXkzIjowLCJkZWZlbnNpdmVfcGl0Y2hfZW5hYmxlX3dheV9zcGluMSI6ZmFsc2V9fSwiZmFrZWxhZ19saW0iOjE1LCJmYWtlbGFnX3ZhciI6MTAwLCJzdGF0ZSI6ImFlcm9iaWMrIiwiZnJlZXN0YW5kaW5nIjpbIkZvcmNlIHN0YXRpYyIsIn4iXSwibW9kZSI6IuKakiAgQnVpbGRlciIsImZha2VsYWdfdHlwZSI6Ik1heGltdW0ifSx7Im5vdGlmeV92aWJvciI6WyJ+Il0sImtleWxpc3QiOmZhbHNlLCJpbmRpY2F0b3JvZmZzZXQiOjM1LCJ2aWV3bW9kZWxfeTIiOjEsImluZGljYXRvcmZvbnQiOiJEZWZhdWx0IiwibWFudWFsc19vZmZzZXQiOjUzLCJnc19pbmQiOmZhbHNlLCJ2aWV3bW9kZWxfb24iOnRydWUsImFkYXB0aXZlX2hpdF9kaXN0YW5jZSI6MzUsIm5vdGlmeV9tYXN0ZXIiOmZhbHNlLCJ2aWV3bW9kZWxfejIiOi0xLCJhbmltc2NvcGVfc2xpZGVyIjo1LCJjbGFudGFnIjpmYWxzZSwidmlld21vZGVsX2luc2NvcGUiOmZhbHNlLCJtYW51YWxzX3N0eWxlIjoiTmV3IiwiYW5pbXNjb3BlIjpmYWxzZSwiZ3NfaW5kcyI6WyJ+Il0sImFuaW1zY29wZV9mb3Zfc2xpZGVyIjoxMzAsInZpZXdtb2RlbF9zY29wZSI6ZmFsc2UsInZpZXdtb2RlbF9tb2QiOiJXaXRob3V0LXNjb3BlIiwiYW5pbWF0aW9uc19ib2R5Ijo3NCwidmlld21vZGVsX3kxIjotMiwidmlld21vZGVsX2ZvdjEiOjYwLCJ0cmFzaHRhbGtfY2hlY2syIjpmYWxzZSwiaW5kaWNhdG9yX2RtZ193ZWFwb24iOnRydWUsIndhdGVybWFyayI6ZmFsc2UsImluZGljYXRvcl9kbWciOnRydWUsIm1hbnVhbHNfZ2xvYmFsIjpmYWxzZSwidmlld21vZGVsX3oxIjoyLCJpbmRpY2F0b3JzIjpmYWxzZSwiYWRhcHRpdmVfaGl0IjpmYWxzZSwiYXV0b2J1eV92IjoiQXdwIiwidHJhc2h0YWxrX2N1c3RvbSI6IiIsInZpZXdtb2RlbF94MiI6LTQsIm1hbnVhbHMiOnRydWUsInN1YnR1YiI6IuKamSBWaXN1YWxzIiwidHJhc2h0YWxrX3R5cGUiOiJEZWZhdWx0IHR5cGUiLCJ0cmFzaHRhbGsiOmZhbHNlLCJub3RpZnlfb2Zmc2V0Ijo0NSwiYXV0b2J1eSI6ZmFsc2UsImFuaW1hdGlvbnNfc2VsZWN0b3IiOlsifiJdLCJhbmltYXRpb25zIjpmYWxzZSwidmlld21vZGVsX2ZvdjIiOjYwLCJpbmRpY2F0b3JfZG1nX2MiOiIjRkZGRkZGRkYiLCJ2aWV3bW9kZWxfeDEiOjB9XQ==",
	states = {
		"stand",
		"slow walk",
		"run",
		"crouch",
		"sneak",
		"aerobic",
		"aerobic+",
		"fakelag",
		"hideshots"
	},
	extended_states = {
		"global",
		"stand",
		"slow walk",
		"run",
		"crouch",
		"sneak",
		"aerobic",
		"aerobic+",
		"fakelag",
		"hideshots"
	},
	def_ways = {
		"1-way",
		"2-way",
		"3-way",
		"4-way",
		"5-way"
	},
	keylist_icon = renderer.load_png("\x89PNG\r\n\x1A\n\x00\x00\x00\rIHDR\x00\x00\x00\x0F\x00\x00\x00\x0F\b\x06\x00\x00\x00;֕J\x00\x00\x00\x01sRGB\x00\xAE\xCE\x1C\xE9\x00\x00\x00\x04gAMA\x00\x00\xB1\x8F\v\xFCa\x05\x00\x00\x00\tpHYs\x00\x00\x0E\xC3\x00\x00\x0E\xC3\x01\xC7o\xA8d\x00\x00\x00\xE7IDAT8O\x8D\x92\r\x11\x82@\x10\x85\xB9\x06D0\x026 \x02\x11\x8C`\x03#\x18\xC1\bF\xD0\x06D \x0268\xDFw\xEC\x02\a\xC7\xE87\xF3\xC6\xDB?\xEE\xF6\x8D\xD5/b\x8C\xB5t\x97F\t\x9ERc\xE5c\xD4\xC4 \xCD0H\xAF\xE9\x988\xFE\x80\x8A\xEBAn\xAE-ߦL\x8C}jܢBq\xD0Q\xDCKc\xB08Úy\x16\xBF\xEF\x10\xC2\x87<Xm\x7F+\x05im\x0E{vVN(~\xA4J\x8C7K̓\xFET\x8C\xF13\xF8\xBE>ȳ\xA7U8Hَ\xD2Uꤋ\xC5\x7F\x0F\"\x87\x1A\x03\xB0\f\x82\x02\x06 sUgneg\xC0\x03VY\x06EPb\xB0\xF3y\xED*\xA8\xE6fe\x8EϨ\x01v\xD6+\xB7\xDFq\x8B\n\xFE\x97k-.\x9BSB\xC5Sj\x9B\xE0Ces\x8EPS#\xB9㘓\x99W\xA6\xAA\xBE\xA0\xF9\xACZzA\v\x0E\x00\x00\x00\x00IEND\xAEB`\x82", 15, 15)
}):struct("ref")({
	aa = {
		enabled = {
			ui.reference("aa", "anti-aimbot angles", "enabled")
		},
		pitch = {
			ui.reference("aa", "anti-aimbot angles", "pitch")
		},
		yaw_base = {
			ui.reference("aa", "anti-aimbot angles", "Yaw base")
		},
		yaw = {
			ui.reference("aa", "anti-aimbot angles", "Yaw")
		},
		yaw_jitter = {
			ui.reference("aa", "anti-aimbot angles", "Yaw Jitter")
		},
		body_yaw = {
			ui.reference("aa", "anti-aimbot angles", "Body yaw")
		},
		freestanding_body_yaw = {
			ui.reference("aa", "anti-aimbot angles", "Freestanding body yaw")
		},
		freestand = {
			ui.reference("aa", "anti-aimbot angles", "Freestanding")
		},
		roll = {
			ui.reference("aa", "anti-aimbot angles", "Roll")
		},
		edge_yaw = {
			ui.reference("aa", "anti-aimbot angles", "Edge yaw")
		},
		fake_peek = {
			ui.reference("aa", "other", "Fake peek")
		}
	},
	misc = {
		knife = {
			ui.reference("misc", "miscellaneous", "Knifebot")
		},
		clantag = {
			ui.reference("misc", "miscellaneous", "Clan tag spammer")
		},
		fov = ui.reference("misc", "miscellaneous", "Override FOV"),
		override_zf = ui.reference("misc", "miscellaneous", "Override zoom FOV")
	},
	fakelag = {
		enable = {
			ui.reference("aa", "fake lag", "enabled")
		},
		amount = {
			ui.reference("aa", "fake lag", "amount")
		},
		variance = {
			ui.reference("aa", "fake lag", "variance")
		},
		limit = {
			ui.reference("aa", "fake lag", "limit")
		},
		lg = {
			ui.reference("aa", "other", "Leg movement")
		}
	},
	aa_other = {
		sw = {
			ui.reference("aa", "other", "Slow motion")
		},
		hide_shots = {
			ui.reference("aa", "other", "On shot anti-aim")
		}
	},
	rage = {
		dt = {
			ui.reference("rage", "aimbot", "Double tap")
		},
		dt_limit = {
			ui.reference("rage", "aimbot", "Double tap fake lag limit")
		},
		fd = {
			ui.reference("rage", "other", "Duck peek assist")
		},
		os = {
			ui.reference("aa", "other", "On shot anti-aim")
		},
		silent = {
			ui.reference("rage", "Other", "Silent aim")
		},
		quickpeek = {
			ui.reference("RAGE", "Other", "Quick peek assist")
		},
		quickpeek2 = {
			ui.reference("RAGE", "Other", "Quick peek assist mode")
		},
		mindmg = {
			ui.reference("rage", "aimbot", "minimum damage")
		},
		hit_chance = var_0_1.reference("rage", "aimbot", "minimum hit chance"),
		ovr = {
			ui.reference("rage", "aimbot", "minimum damage override")
		}
	},
	slow_motion = {
		ui.reference("aa", "other", "Slow motion")
	}
}):struct("ui")({
	menu = {
		global = {},
		home = {},
		antiaim = {},
		tools = {}
	},
	execute = function(arg_30_0)
		local var_30_0 = var_0_1.group("AA", "anti-aimbot angles")
		local var_30_1 = var_0_1.group("AA", "Fake lag")
		local var_30_2 = var_0_1.group("AA", "Other")
		local var_30_3 = "\a373737FF‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
		local var_30_4, var_30_5 = client.screen_size()
		local var_30_6 = "\a808080FF•\r  "

		arg_30_0.menu.global.title_name = var_30_1:label("\v~ Ваня Сенс / \r" .. arg_30_0.helpers:limit_ch(var_0_12, 14, "..."), {
			164,
			210,
			212
		})
		arg_30_0.menu.global.tab = var_30_1:combobox("\n tabs", {
			"home",
			"antiaim",
			"tools"
		})

		var_30_1:label(var_30_3)

		arg_30_0.menu.home.welcomer = var_30_0:label("Welcome to \vonesense\r 1.6")
		arg_30_0.menu.home.get_aura = var_30_2:slider("~ Aura", 0, 10, 6, true, "x", 1)
		arg_30_0.menu.home.list = var_30_0:listbox("configs", {})

		arg_30_0.menu.home.list:set_callback(function()
			arg_30_0.config:update_name()
		end)

		arg_30_0.menu.home.name = var_30_0:textbox("config name")
		arg_30_0.menu.home.load = var_30_0:button("▷  Load", function()
			arg_30_0.config:load("config")
		end)
		arg_30_0.menu.home.save = var_30_0:button("✎  Save", function()
			arg_30_0.config:save()
		end)
		arg_30_0.menu.home.delete = var_30_0:button("\aff0000ff♻ Delete", function()
			arg_30_0.config:delete()
		end)
		arg_30_0.menu.home.export = var_30_1:button("☰  Export", function()
			var_0_3.set(arg_30_0.config:export("config"))
		end)
		arg_30_0.menu.home.import = var_30_1:button("✦  Import", function()
			arg_30_0.config:import(var_0_3.get(), "config")
		end)
		arg_30_0.menu.home.default = var_30_1:button("★  Default \vcfg", function()
			arg_30_0.config:import(arg_30_0.globals.default_cfg, "config")
		end)
		arg_30_0.menu.home.line = var_30_2:label(var_30_3)
		arg_30_0.menu.home.discord = var_30_2:button("\a808080FFJoin Our Discord\r", function()
			var_0_11.SteamOverlayAPI.OpenExternalBrowserURL("https://discord.gg/zUKBpRrSss")
		end)
		arg_30_0.menu.home.youtube = var_30_2:button("\a808080FFJoin Coder YouTube\r", function()
			var_0_11.SteamOverlayAPI.OpenExternalBrowserURL("https://www.youtube.com/@reloadhvh")
		end)
		arg_30_0.menu.antiaim.mode = var_30_0:combobox(var_30_6 .. "Anti-aim tab", {
			"⚒  Builder",
			"⌨ Binds & Other"
		})
		arg_30_0.menu.antiaim.space_teweaks = var_30_0:label(var_30_3):depend({
			arg_30_0.menu.antiaim.mode,
			"⌨ Binds & Other"
		})
		arg_30_0.menu.antiaim.freestanding = var_30_0:multiselect("Freestanding", {
			"Force static",
			"Disablers"
		}, 0):depend({
			arg_30_0.menu.antiaim.mode,
			"⌨ Binds & Other"
		})
		arg_30_0.menu.antiaim.freestanding_disablers = var_30_0:multiselect("\nfreestanding disablers", arg_30_0.globals.states):depend({
			arg_30_0.menu.antiaim.freestanding,
			"Disablers"
		}):depend({
			arg_30_0.menu.antiaim.mode,
			"⌨ Binds & Other"
		})
		arg_30_0.menu.antiaim.edge_yaw = var_30_0:label("Edge yaw", 0):depend({
			arg_30_0.menu.antiaim.mode,
			"⌨ Binds & Other"
		})
		arg_30_0.menu.antiaim.manual_aa = var_30_0:checkbox("Manual aa"):depend({
			arg_30_0.menu.antiaim.mode,
			"⌨ Binds & Other"
		})
		arg_30_0.menu.antiaim.manual_static = var_30_0:checkbox(var_30_6 .. "Manual static"):depend({
			arg_30_0.menu.antiaim.manual_aa,
			true
		}):depend({
			arg_30_0.menu.antiaim.mode,
			"⌨ Binds & Other"
		})
		arg_30_0.menu.antiaim.manual_left = var_30_0:hotkey(var_30_6 .. "Manual left"):depend({
			arg_30_0.menu.antiaim.manual_aa,
			true
		}):depend({
			arg_30_0.menu.antiaim.mode,
			"⌨ Binds & Other"
		})
		arg_30_0.menu.antiaim.manual_right = var_30_0:hotkey(var_30_6 .. "Manual right"):depend({
			arg_30_0.menu.antiaim.manual_aa,
			true
		}):depend({
			arg_30_0.menu.antiaim.mode,
			"⌨ Binds & Other"
		})
		arg_30_0.menu.antiaim.manual_forward = var_30_0:hotkey(var_30_6 .. "Manual forward"):depend({
			arg_30_0.menu.antiaim.manual_aa,
			true
		}):depend({
			arg_30_0.menu.antiaim.mode,
			"⌨ Binds & Other"
		})
		arg_30_0.menu.antiaim.fakelag_type = var_30_1:combobox("Fake lag type", {
			"Maximum",
			"Dynamic",
			"Fluctuate"
		}):depend({
			arg_30_0.menu.antiaim.mode,
			"⌨ Binds & Other"
		})
		arg_30_0.menu.antiaim.fakelag_var = var_30_1:slider(var_30_6 .. "Variance", 0, 100, 100, true, "%"):depend({
			arg_30_0.menu.antiaim.mode,
			"⌨ Binds & Other"
		})
		arg_30_0.menu.antiaim.fakelag_lim = var_30_1:slider(var_30_6 .. "Limit", 1, 15, 15):depend({
			arg_30_0.menu.antiaim.mode,
			"⌨ Binds & Other"
		})
		arg_30_0.menu.antiaim.state = var_30_0:combobox("\n current condition", arg_30_0.globals.extended_states):depend({
			arg_30_0.menu.antiaim.mode,
			"⚒  Builder"
		})
		arg_30_0.menu.antiaim.states = {}

		for iter_30_0, iter_30_1 in ipairs(arg_30_0.globals.extended_states) do
			arg_30_0.menu.antiaim.states[iter_30_1] = {}

			local var_30_7 = arg_30_0.menu.antiaim.states[iter_30_1]

			if iter_30_1 ~= "global" then
				var_30_7.enable = var_30_0:checkbox("Activate \v" .. iter_30_1 .. "\n")
			end

			local var_30_8 = "\a666666ff ~ \r\v" .. iter_30_1

			var_30_7.options = var_30_2:multiselect(var_30_6 .. "Tweaks" .. var_30_8, {
				"Enable defensive",
				"Avoid backstab",
				"Safe head"
			})
			var_30_7.options2 = var_30_2:label(var_30_3)
			var_30_7.defensive_conditions = var_30_2:multiselect("Defensive triggers" .. var_30_8, {
				"Always",
				"On weapon switch",
				"On reload",
				"On hittable",
				"On freestand"
			}):depend({
				var_30_7.options,
				"Enable defensive"
			})
			var_30_7.defensive_yaw = var_30_0:checkbox("Defensive yaw" .. var_30_8):depend({
				var_30_7.options,
				"Enable defensive"
			})
			var_30_7.defensive_yaw_mode = var_30_0:combobox("\ndefensive yaw mode" .. var_30_8, {
				"Jitter",
				"Custom spin",
				"Custom ways",
				"Spin-way",
				"Switch 5-way"
			}):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			})
			var_30_7.defensive_yaw_1_Spin_way = var_30_0:slider("\n 1 stage Spin-way" .. var_30_8, -359, 359, -180, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Spin-way"
			})
			var_30_7.defensive_yaw_2_Spin_way = var_30_0:slider("\n 2 stage Spin-way" .. var_30_8, -359, 359, 180, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Spin-way"
			})
			var_30_7.defensive_yaw_speed_Spin_way = var_30_0:slider(var_30_6 .. "Delay" .. var_30_8, 0, 16, 6, true, "t", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Spin-way"
			})
			var_30_7.defensive_yaw_randomizer_Spin_way = var_30_0:slider(var_30_6 .. "Randomizer Spin-way [AI]" .. var_30_8, 0, 359, 0, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Spin-way"
			})
			var_30_7.defensive_yaw_jitter_radius_1 = var_30_0:slider("\n JiTter 1" .. var_30_8, -180, 180, 30, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Jitter"
			})
			var_30_7.defensive_yaw_jitter_delay = var_30_0:slider(var_30_6 .. "Delayed" .. var_30_8, 1, 12, 6, true, "t", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Jitter"
			})
			var_30_7.defensive_yaw_jitter_random = var_30_0:slider(var_30_6 .. "Randomize" .. var_30_8, 0, 180, 0, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Jitter"
			})
			var_30_7.defensive_yaw_way_switch1 = var_30_0:slider("\n way-1" .. var_30_8, 0, 360, 30, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_yaw_way_switch2 = var_30_0:slider("\n way-2" .. var_30_8, 0, 360, 30, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_yaw_way_switch3 = var_30_0:slider("\n way-3" .. var_30_8, 0, 360, 30, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_yaw_way_switch4 = var_30_0:slider("\n way-4" .. var_30_8, 0, 360, 30, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_yaw_way_switch5 = var_30_0:slider("\n way-5" .. var_30_8, 0, 360, 30, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_yaw_way_randomly = var_30_0:checkbox(var_30_6 .. "Increase yaw (random) " .. var_30_8):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_yaw_way_randomly_value = var_30_0:slider("\n ramdom yaw value" .. var_30_8, 0, 360, 20, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			}, {
				var_30_7.defensive_yaw_way_randomly,
				true
			})
			var_30_7.defensive_yaw_way_delay = var_30_0:slider(var_30_6 .. "Interpolation (delay)" .. var_30_8, 0, 16, 4, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_yaw_wayspin_combo = var_30_0:combobox(var_30_6 .. "Select spin way yaw" .. var_30_8, arg_30_0.globals.def_ways):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_yaw_enable_way_spin1 = var_30_0:checkbox("Enable spin \n 1" .. var_30_8):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			}, {
				var_30_7.defensive_yaw_wayspin_combo,
				"1-way"
			})
			var_30_7.defensive_yaw_way_spin_limit1 = var_30_0:slider("\n limit  way-1 " .. var_30_8, 0, 360, 0, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			}, {
				var_30_7.defensive_yaw_enable_way_spin1,
				true
			}, {
				var_30_7.defensive_yaw_wayspin_combo,
				"1-way"
			})
			var_30_7.defensive_yaw_way_speed1 = var_30_0:slider("\n speed way-1 " .. var_30_8, 1, 12, 8, true, "t", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			}, {
				var_30_7.defensive_yaw_enable_way_spin1,
				true
			}, {
				var_30_7.defensive_yaw_wayspin_combo,
				"1-way"
			})
			var_30_7.defensive_yaw_enable_way_spin2 = var_30_0:checkbox("Enable spin \n 2" .. var_30_8):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			}, {
				var_30_7.defensive_yaw_wayspin_combo,
				"2-way"
			})
			var_30_7.defensive_yaw_way_spin_limit2 = var_30_0:slider("\n limit  way-2 " .. var_30_8, 0, 360, 0, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			}, {
				var_30_7.defensive_yaw_enable_way_spin2,
				true
			}, {
				var_30_7.defensive_yaw_wayspin_combo,
				"2-way"
			})
			var_30_7.defensive_yaw_way_speed2 = var_30_0:slider("\n speed way-2 " .. var_30_8, 1, 12, 8, true, "t", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			}, {
				var_30_7.defensive_yaw_enable_way_spin2,
				true
			}, {
				var_30_7.defensive_yaw_wayspin_combo,
				"2-way"
			})
			var_30_7.defensive_yaw_enable_way_spin3 = var_30_0:checkbox("Enable spin \n 3 " .. var_30_8):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			}, {
				var_30_7.defensive_yaw_wayspin_combo,
				"3-way"
			})
			var_30_7.defensive_yaw_way_spin_limit3 = var_30_0:slider("\n limit  way-3 " .. var_30_8, 0, 360, 0, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			}, {
				var_30_7.defensive_yaw_enable_way_spin3,
				true
			}, {
				var_30_7.defensive_yaw_wayspin_combo,
				"3-way"
			})
			var_30_7.defensive_yaw_way_speed3 = var_30_0:slider("\n speed way-3 " .. var_30_8, 1, 12, 8, true, "t", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			}, {
				var_30_7.defensive_yaw_enable_way_spin3,
				true
			}, {
				var_30_7.defensive_yaw_wayspin_combo,
				"3-way"
			})
			var_30_7.defensive_yaw_enable_way_spin4 = var_30_0:checkbox("Enable spin \n 4 " .. var_30_8):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			}, {
				var_30_7.defensive_yaw_wayspin_combo,
				"4-way"
			})
			var_30_7.defensive_yaw_way_spin_limit4 = var_30_0:slider("\n limit  way-4 " .. var_30_8, 0, 360, 0, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			}, {
				var_30_7.defensive_yaw_enable_way_spin4,
				true
			}, {
				var_30_7.defensive_yaw_wayspin_combo,
				"4-way"
			})
			var_30_7.defensive_yaw_way_speed4 = var_30_0:slider("\n speed way-4 " .. var_30_8, 1, 12, 8, true, "t", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			}, {
				var_30_7.defensive_yaw_enable_way_spin4,
				true
			}, {
				var_30_7.defensive_yaw_wayspin_combo,
				"4-way"
			})
			var_30_7.defensive_yaw_enable_way_spin5 = var_30_0:checkbox("Enable spin \n 5 " .. var_30_8):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			}, {
				var_30_7.defensive_yaw_wayspin_combo,
				"5-way"
			})
			var_30_7.defensive_yaw_way_spin_limit5 = var_30_0:slider("\n limit  way-5 " .. var_30_8, 0, 360, 0, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			}, {
				var_30_7.defensive_yaw_enable_way_spin5,
				true
			}, {
				var_30_7.defensive_yaw_wayspin_combo,
				"5-way"
			})
			var_30_7.defensive_yaw_way_speed5 = var_30_0:slider("\n speed way-5 " .. var_30_8, 1, 12, 8, true, "t", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			}, {
				var_30_7.defensive_yaw_enable_way_spin5,
				true
			}, {
				var_30_7.defensive_yaw_wayspin_combo,
				"5-way"
			})
			var_30_7.defensive_yaw_spin_limit = var_30_0:slider("\n limit spin" .. var_30_8, 15, 360, 360, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Custom spin"
			})
			var_30_7.defensive_yaw_3way_limit = var_30_0:slider("\n limit wayssss" .. var_30_8, 10, 29, 25, true, "°", 1, {
				[29] = "5-way",
				[10] = "4-way",
				[25] = "3-way",
				[14] = "5-way"
			}):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Custom ways"
			})
			var_30_7.defensive_yaw_speedtick = var_30_0:slider("\n spin speed" .. var_30_8, 1, 12, 6, true, "t", 0.5):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			}, {
				var_30_7.defensive_yaw_mode,
				"Custom spin"
			})
			var_30_7.defensive_pitch_enable = var_30_1:checkbox("Defensive pitch" .. var_30_8):depend({
				var_30_7.options,
				"Enable defensive"
			})
			var_30_7.defensive_pitch_mode = var_30_1:combobox("\n defensive pitch mode" .. var_30_8, {
				"Static",
				"Spin",
				"Random",
				"Clocking",
				"Jitter",
				"5way"
			}):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable,
				true
			})
			var_30_7.defensive_pitch_spin_random2 = var_30_1:slider("\n pitch def random2" .. var_30_8, -89, 89, 0, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"Random"
			})
			var_30_7.defensive_pitch_spin_limit2 = var_30_1:slider("\n spin speed 2" .. var_30_8, -89, 89, 0, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"Spin"
			})
			var_30_7.defensive_pitch_custom = var_30_1:slider("\n pitch custom limit" .. var_30_8, -89, 89, 0, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable,
				true
			})
			var_30_7.defensive_pitch_speedtick = var_30_1:slider("\n spin speed" .. var_30_8, 1, 64, 32, true, "t", 0.1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"Spin"
			})
			var_30_7.defensive_pitch_way2 = var_30_1:slider("\n pitch way 2" .. var_30_8, -89, 89, 0, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_way3 = var_30_1:slider("\n pitch way 3" .. var_30_8, -89, 89, 0, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_way4 = var_30_1:slider("\n pitch way 4" .. var_30_8, -89, 89, 0, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_way5 = var_30_1:slider("\n pitch way 5" .. var_30_8, -89, 89, 0, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_way_randomly = var_30_1:checkbox(var_30_6 .. "Increase pitch (random) " .. var_30_8):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_way_randomly_value = var_30_1:slider("\n ramdom pitch value" .. var_30_8, -89, 89, 20, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}, {
				var_30_7.defensive_pitch_way_randomly,
				true
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_way_spin_combo = var_30_1:combobox(var_30_6 .. "Select spin way pitch" .. var_30_8, arg_30_0.globals.def_ways):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_enable_way_spin1 = var_30_1:checkbox("Enable spin \n 1" .. var_30_8):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}, {
				var_30_7.defensive_pitch_way_spin_combo,
				"1-way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_way_spin_limit11 = var_30_1:slider("\n limit  way-11 " .. var_30_8, -89, 89, 89, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable_way_spin1,
				true
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}, {
				var_30_7.defensive_pitch_way_spin_combo,
				"1-way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_way_spin_limit12 = var_30_1:slider("\n limit  way-12 " .. var_30_8, -89, 89, 89, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable_way_spin1,
				true
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}, {
				var_30_7.defensive_pitch_way_spin_combo,
				"1-way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_way_speed1 = var_30_1:slider("\n speed way-1 " .. var_30_8, 1, 12, 8, true, "t", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable_way_spin1,
				true
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}, {
				var_30_7.defensive_pitch_way_spin_combo,
				"1-way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_enable_way_spin2 = var_30_1:checkbox("Enable spin \n 2" .. var_30_8):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}, {
				var_30_7.defensive_pitch_way_spin_combo,
				"2-way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_way_spin_limit21 = var_30_1:slider("\n limit  way-21 " .. var_30_8, -89, 89, 89, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable_way_spin2,
				true
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}, {
				var_30_7.defensive_pitch_way_spin_combo,
				"2-way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_way_spin_limit22 = var_30_1:slider("\n limit  way-22 " .. var_30_8, -89, 89, 89, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable_way_spin2,
				true
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}, {
				var_30_7.defensive_pitch_way_spin_combo,
				"2-way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_way_speed2 = var_30_1:slider("\n speed way-2 " .. var_30_8, 1, 12, 8, true, "t", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable_way_spin2,
				true
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}, {
				var_30_7.defensive_pitch_way_spin_combo,
				"2-way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_enable_way_spin3 = var_30_1:checkbox("Enable spin \n 3" .. var_30_8):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}, {
				var_30_7.defensive_pitch_way_spin_combo,
				"3-way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_way_spin_limit31 = var_30_1:slider("\n limit  way-31 " .. var_30_8, -89, 89, 89, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable_way_spin3,
				true
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}, {
				var_30_7.defensive_pitch_way_spin_combo,
				"3-way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_way_spin_limit32 = var_30_1:slider("\n limit  way-32 " .. var_30_8, -89, 89, 89, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable_way_spin3,
				true
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}, {
				var_30_7.defensive_pitch_way_spin_combo,
				"3-way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_way_speed3 = var_30_1:slider("\n speed way-3 " .. var_30_8, 1, 12, 8, true, "t", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable_way_spin3,
				true
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}, {
				var_30_7.defensive_pitch_way_spin_combo,
				"3-way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_enable_way_spin4 = var_30_1:checkbox("Enable spin \n 4" .. var_30_8):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}, {
				var_30_7.defensive_pitch_way_spin_combo,
				"4-way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_way_spin_limit41 = var_30_1:slider("\n limit  way-41 " .. var_30_8, -89, 89, 89, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable_way_spin4,
				true
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}, {
				var_30_7.defensive_pitch_way_spin_combo,
				"4-way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_way_spin_limit42 = var_30_1:slider("\n limit  way-42 " .. var_30_8, -89, 89, 89, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable_way_spin4,
				true
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}, {
				var_30_7.defensive_pitch_way_spin_combo,
				"4-way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_way_speed4 = var_30_1:slider("\n speed way-4 " .. var_30_8, 1, 12, 8, true, "t", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable_way_spin4,
				true
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}, {
				var_30_7.defensive_pitch_way_spin_combo,
				"4-way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_enable_way_spin5 = var_30_1:checkbox("Enable spin \n 5" .. var_30_8):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}, {
				var_30_7.defensive_pitch_way_spin_combo,
				"5-way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_way_spin_limit51 = var_30_1:slider("\n limit  way-51 " .. var_30_8, -89, 89, 89, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable_way_spin5,
				true
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}, {
				var_30_7.defensive_pitch_way_spin_combo,
				"5-way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_way_spin_limit52 = var_30_1:slider("\n limit  way-52 " .. var_30_8, -89, 89, 89, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable_way_spin5,
				true
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}, {
				var_30_7.defensive_pitch_way_spin_combo,
				"5-way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_way_speed5 = var_30_1:slider("\n speed way-5 " .. var_30_8, 1, 12, 8, true, "t", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable_way_spin5,
				true
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"5way"
			}, {
				var_30_7.defensive_pitch_way_spin_combo,
				"5-way"
			}):depend({
				var_30_7.defensive_yaw_mode,
				"Switch 5-way"
			})
			var_30_7.defensive_pitch_clock = var_30_1:slider("\n pitch clock limit" .. var_30_8, -89, 89, 0, true, "°", 1):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_pitch_enable,
				true
			}, {
				var_30_7.defensive_pitch_mode,
				"Jitter"
			})
			var_30_7.defensive_freestand = var_30_0:checkbox("Freestand on defensive" .. var_30_8):depend({
				var_30_7.options,
				"Enable defensive"
			}, {
				var_30_7.defensive_yaw,
				true
			})
			var_30_7.space = var_30_0:label(var_30_3):depend({
				arg_30_0.menu.antiaim.mode,
				"Builder"
			})
			var_30_7.yaw_base = var_30_0:combobox(var_30_6 .. "Yaw" .. var_30_8, {
				"At targets",
				"Local view"
			})
			var_30_7.yaw_jitter = var_30_0:combobox("\nyaw jitter" .. var_30_8, {
				"Off",
				"Offset",
				"Center",
				"Skitter",
				"Random"
			})
			var_30_7.yaw_jitter_add = var_30_0:slider("\nyaw jitter add" .. var_30_8, -180, 180, 0, true, "°", 1):depend({
				var_30_7.yaw_jitter,
				"Off",
				true
			})
			var_30_7.yaw_add = var_30_0:slider(var_30_6 .. "Yaw add \v(L/R)" .. var_30_8, -180, 180, 0, true, "°", 1)
			var_30_7.yaw_add_r = var_30_0:slider("\n yaw add (R)" .. var_30_8, -180, 180, 0, true, "°", 1)
			var_30_7.jitter_delay = var_30_0:slider(var_30_6 .. "Yaw delay" .. var_30_8, 0, 4, 1, true, "x", 1, {
				[0] = "Off",
				[1] = "Randomly"
			})
			var_30_7.space2 = var_30_0:label(var_30_3):depend({
				arg_30_0.menu.antiaim.mode,
				"Builder"
			})
			var_30_7.desync_mode = var_30_0:combobox(var_30_6 .. "Desync mode" .. var_30_8, {
				"Default",
				"Extended"
			})
			var_30_7.body_yaw = var_30_0:combobox("\n Body yaw" .. var_30_8, {
				"Off",
				"Opposite",
				"Static",
				"Jitter"
			})
			var_30_7.body_yaw_side = var_30_0:combobox(var_30_6 .. "Body yaw side" .. var_30_8, {
				"Left",
				"Right",
				"Freestanding"
			}):depend({
				var_30_7.body_yaw,
				"Static",
				false
			})

			for iter_30_2, iter_30_3 in pairs(var_30_7) do
				local var_30_9 = {
					{
						arg_30_0.menu.antiaim.state,
						iter_30_1
					},
					{
						arg_30_0.menu.antiaim.mode,
						"⚒  Builder"
					}
				}

				if iter_30_2 ~= "enable" and iter_30_1 ~= "global" then
					var_30_9 = {
						{
							arg_30_0.menu.antiaim.state,
							iter_30_1
						},
						{
							arg_30_0.menu.antiaim.mode,
							"⚒  Builder"
						},
						{
							var_30_7.enable,
							true
						}
					}
				end

				iter_30_3:depend(table.unpack(var_30_9))
			end
		end

		arg_30_0.menu.antiaim.export = var_30_2:button("Export condition", function()
			data = arg_30_0.config:export("state", arg_30_0.menu.antiaim.state:get())

			var_0_3.set(data)
		end):depend({
			arg_30_0.menu.antiaim.mode,
			"⚒  Builder"
		})
		arg_30_0.menu.antiaim.import = var_30_2:button("Import condition ", function()
			local var_41_0 = var_0_3.get()
			local var_41_1 = var_41_0:match("{onesense:(.+)}")

			arg_30_0.config:import(var_41_0, var_41_1, arg_30_0.menu.antiaim.state:get())
		end):depend({
			arg_30_0.menu.antiaim.mode,
			"⚒  Builder"
		})
		arg_30_0.menu.tools.subtub = var_30_1:combobox(var_30_6 .. "Active tab", {
			"⚙ Visuals",
			"Misc"
		})

		local var_30_10 = arg_30_0.menu.tools.subtub

		arg_30_0.menu.tools.indicators = var_30_0:checkbox("\v✣\r  Crosshair indicators"):depend({
			var_30_10,
			"⚙ Visuals"
		})
		arg_30_0.menu.tools.indicatorfont = var_30_0:combobox(var_30_6 .. "Indicator style", {
			"Default",
			"New"
		}):depend({
			arg_30_0.menu.tools.indicators,
			true
		}):depend({
			var_30_10,
			"⚙ Visuals"
		})
		arg_30_0.menu.tools.indicatoroffset = var_30_0:slider("\n Offset indcator ", 0, 90, 35, true, "px"):depend({
			arg_30_0.menu.tools.indicators,
			true
		}):depend({
			var_30_10,
			"⚙ Visuals"
		})
		arg_30_0.menu.tools.gs_ind = var_30_0:checkbox("\v⊂\r  Indicators left gs"):depend({
			var_30_10,
			"⚙ Visuals"
		})
		arg_30_0.menu.tools.gs_inds = var_30_0:multiselect("\n inds selc", {
			"Target",
			"..."
		}):depend({
			var_30_10,
			"⚙ Visuals"
		}, {
			arg_30_0.menu.tools.gs_ind,
			true
		})
		arg_30_0.menu.tools.manuals = var_30_0:checkbox("\v⋟\r  Manual arrows"):depend({
			var_30_10,
			"⚙ Visuals"
		})
		arg_30_0.menu.tools.manuals_style = var_30_0:combobox("\n arrows style", {
			"Onesense",
			"New"
		}):depend({
			var_30_10,
			"⚙ Visuals"
		}, {
			arg_30_0.menu.tools.manuals,
			true
		})
		arg_30_0.menu.tools.manuals_global = var_30_0:checkbox("Arrows side"):depend({
			var_30_10,
			"⚙ Visuals"
		}, {
			arg_30_0.menu.tools.manuals,
			true
		})
		arg_30_0.menu.tools.manuals_offset = var_30_0:slider("\n arrows offset", 0, 100, 15, true, "px"):depend({
			var_30_10,
			"⚙ Visuals"
		}, {
			arg_30_0.menu.tools.manuals,
			true
		})
		arg_30_0.menu.tools.animscope = var_30_0:checkbox("\v✖\r  Animated scope"):depend({
			var_30_10,
			"⚙ Visuals"
		})
		arg_30_0.menu.tools.animscope_fov_slider = var_30_0:slider(var_30_6 .. "Fov value", 105, 135, 130, true, "%", 1):depend({
			arg_30_0.menu.tools.animscope,
			true
		}):depend({
			var_30_10,
			"⚙ Visuals"
		})
		arg_30_0.menu.tools.animscope_slider = var_30_0:slider("\n Anim scope value", 0, 100, 5, true, "%", 1):depend({
			arg_30_0.menu.tools.animscope,
			true
		}):depend({
			var_30_10,
			"⚙ Visuals"
		})
		arg_30_0.menu.tools.indicator_dmg = var_30_0:checkbox("\v⊹\r  Damage indicator", {
			255,
			255,
			255
		}):depend({
			var_30_10,
			"⚙ Visuals"
		})
		arg_30_0.menu.tools.indicator_dmg_weapon = var_30_0:checkbox(var_30_6 .. "Only min damage"):depend({
			arg_30_0.menu.tools.indicator_dmg,
			true
		}):depend({
			var_30_10,
			"⚙ Visuals"
		})
		arg_30_0.menu.tools.notify_master = var_30_0:checkbox("\v⚠\r  Logging"):depend({
			var_30_10,
			"⚙ Visuals"
		})
		arg_30_0.menu.tools.notify_vibor = var_30_0:multiselect("\n Log type", {
			"New style",
			"Hit",
			"Miss",
			"Get harmed",
			"Detect shot",
			"Preview"
		}):depend({
			arg_30_0.menu.tools.notify_master,
			true
		}):depend({
			var_30_10,
			"⚙ Visuals"
		})
		arg_30_0.menu.tools.notify_offset = var_30_0:slider("\n Offset notifys ", 0, 900, 45, true, "px", 1):depend({
			arg_30_0.menu.tools.notify_master,
			true
		}):depend({
			var_30_10,
			"⚙ Visuals"
		})
		arg_30_0.menu.tools.notify_test = var_30_0:button("\v▣  Preview logg", function()
			var_0_10.create_new({
				{
					"Example: "
				},
				{
					"logging ",
					true
				},
				{
					"12345"
				}
			})
		end):depend({
			arg_30_0.menu.tools.notify_vibor,
			"Preview"
		}, {
			arg_30_0.menu.tools.notify_master,
			true
		}):depend({
			var_30_10,
			"⚙ Visuals"
		})
		arg_30_0.menu.tools.watermark = var_30_0:checkbox("\v♒︎\r  Watermark"):depend({
			var_30_10,
			"⚙ Visuals"
		})
		arg_30_0.menu.tools.keylist = var_30_0:checkbox("\v✧₊⁺\r  Keylist"):depend({
			var_30_10,
			"⚙ Visuals"
		})
		arg_30_0.menu.tools.viewmodel_scope = var_30_0:checkbox("\v☞\r  Viewmodel show in scope"):depend({
			var_30_10,
			"⚙ Visuals"
		})
		arg_30_0.menu.tools.viewmodel_on = var_30_0:checkbox(var_30_6 .. "Viewmodel modifier"):depend({
			var_30_10,
			"⚙ Visuals"
		})
		arg_30_0.menu.tools.viewmodel_mod = var_30_0:combobox("\nstyleview", {
			"Without-scope",
			"In-scope"
		}):depend({
			var_30_10,
			"⚙ Visuals"
		}, {
			arg_30_0.menu.tools.viewmodel_on,
			true
		})
		arg_30_0.menu.tools.viewmodel_x1 = var_30_0:slider("\nviewwithoscope-x", -100, 100, 1, true, "x", 1):depend({
			var_30_10,
			"⚙ Visuals"
		}, {
			arg_30_0.menu.tools.viewmodel_on,
			true
		}, {
			arg_30_0.menu.tools.viewmodel_mod,
			"Without-scope"
		})
		arg_30_0.menu.tools.viewmodel_y1 = var_30_0:slider("\nviewwithoscope-y", -100, 100, 1, true, "y", 1):depend({
			var_30_10,
			"⚙ Visuals"
		}, {
			arg_30_0.menu.tools.viewmodel_on,
			true
		}, {
			arg_30_0.menu.tools.viewmodel_mod,
			"Without-scope"
		})
		arg_30_0.menu.tools.viewmodel_z1 = var_30_0:slider("\nviewwithoscope-z", -100, 100, -1, true, "z", 1):depend({
			var_30_10,
			"⚙ Visuals"
		}, {
			arg_30_0.menu.tools.viewmodel_on,
			true
		}, {
			arg_30_0.menu.tools.viewmodel_mod,
			"Without-scope"
		})
		arg_30_0.menu.tools.viewmodel_fov1 = var_30_0:slider(var_30_6 .. "Fov\n without scope", 0, 170, 60, true, "x", 1):depend({
			var_30_10,
			"⚙ Visuals"
		}, {
			arg_30_0.menu.tools.viewmodel_on,
			true
		}, {
			arg_30_0.menu.tools.viewmodel_mod,
			"Without-scope"
		})
		arg_30_0.menu.tools.viewmodel_inscope = var_30_0:checkbox("Viewmodel scope"):depend({
			var_30_10,
			"⚙ Visuals"
		}, {
			arg_30_0.menu.tools.viewmodel_on,
			true
		}, {
			arg_30_0.menu.tools.viewmodel_mod,
			"In-scope"
		})
		arg_30_0.menu.tools.viewmodel_x2 = var_30_0:slider("\nview with x", -100, 100, -4, true, "x", 1):depend({
			var_30_10,
			"⚙ Visuals"
		}, {
			arg_30_0.menu.tools.viewmodel_on,
			true
		}, {
			arg_30_0.menu.tools.viewmodel_mod,
			"In-scope"
		}, {
			arg_30_0.menu.tools.viewmodel_inscope,
			true
		})
		arg_30_0.menu.tools.viewmodel_y2 = var_30_0:slider("\nview with y", -100, 100, 1, true, "y", 1):depend({
			var_30_10,
			"⚙ Visuals"
		}, {
			arg_30_0.menu.tools.viewmodel_on,
			true
		}, {
			arg_30_0.menu.tools.viewmodel_mod,
			"In-scope"
		}, {
			arg_30_0.menu.tools.viewmodel_inscope,
			true
		})
		arg_30_0.menu.tools.viewmodel_z2 = var_30_0:slider("\nview with z", -100, 100, -1, true, "z", 1):depend({
			var_30_10,
			"⚙ Visuals"
		}, {
			arg_30_0.menu.tools.viewmodel_on,
			true
		}, {
			arg_30_0.menu.tools.viewmodel_mod,
			"In-scope"
		}, {
			arg_30_0.menu.tools.viewmodel_inscope,
			true
		})
		arg_30_0.menu.tools.viewmodel_fov2 = var_30_0:slider(var_30_6 .. "Fov\n with ov", 0, 170, 60, true, "x", 1):depend({
			var_30_10,
			"⚙ Visuals"
		}, {
			arg_30_0.menu.tools.viewmodel_on,
			true
		}, {
			arg_30_0.menu.tools.viewmodel_mod,
			"In-scope"
		}, {
			arg_30_0.menu.tools.viewmodel_inscope,
			true
		})
		arg_30_0.menu.tools.adaptive_hit = var_30_0:checkbox("\v➶\r  Air stop"):depend({
			var_30_10,
			"Misc"
		})
		arg_30_0.menu.tools.adaptive_hit_distance = var_30_0:slider("\n Distance", 1, 150, 35, true, "m"):depend({
			var_30_10,
			"Misc"
		}, {
			arg_30_0.menu.tools.adaptive_hit,
			true
		})
		arg_30_0.menu.tools.animations = var_30_0:checkbox("\v✨\r  Animations breakers"):depend({
			var_30_10,
			"Misc"
		})
		arg_30_0.menu.tools.animations_selector = var_30_0:multiselect("\n Animations", {
			"Reset pitch on land",
			"Body lean",
			"Static legs",
			"Jitter air",
			"Jitter ground",
			"Kangaroo",
			"Moonwalk"
		}):depend({
			arg_30_0.menu.tools.animations,
			true
		}):depend({
			var_30_10,
			"Misc"
		})
		arg_30_0.menu.tools.animations_body = var_30_0:slider("\n Body lean ", 0, 100, 74, true, ""):depend({
			arg_30_0.menu.tools.animations,
			true
		}):depend({
			arg_30_0.menu.tools.animations_selector,
			"Body lean"
		}):depend({
			var_30_10,
			"Misc"
		})
		arg_30_0.menu.tools.autobuy = var_30_0:checkbox("\v⇄\r  Auto buy"):depend({
			var_30_10,
			"Misc"
		})
		arg_30_0.menu.tools.autobuy_v = var_30_0:combobox("\n auto buy vibor", {
			"Awp",
			"Scar/g3sg1",
			"Scout"
		}):depend({
			arg_30_0.menu.tools.autobuy,
			true
		}):depend({
			var_30_10,
			"Misc"
		})
		arg_30_0.menu.tools.trashtalk = var_30_0:checkbox("\v※\r  Trashtalk"):depend({
			var_30_10,
			"Misc"
		})
		arg_30_0.menu.tools.trashtalk_type = var_30_0:combobox("\n trashtalk type", {
			"Default type",
			"Custom phrase",
			"1 MOD"
		}):depend({
			arg_30_0.menu.tools.trashtalk,
			true
		}):depend({
			var_30_10,
			"Misc"
		})
		arg_30_0.menu.tools.trashtalk_check2 = var_30_0:checkbox(var_30_6 .. "with player name (enemy)"):depend({
			arg_30_0.menu.tools.trashtalk,
			true
		}, {
			arg_30_0.menu.tools.trashtalk_type,
			"1 MOD"
		}):depend({
			var_30_10,
			"Misc"
		})
		arg_30_0.menu.tools.trashtalk_custom = var_30_0:textbox("\n phrase"):depend({
			arg_30_0.menu.tools.trashtalk,
			true
		}, {
			arg_30_0.menu.tools.trashtalk_type,
			"Custom phrase"
		}):depend({
			var_30_10,
			"Misc"
		})
		arg_30_0.menu.tools.clantag = var_30_0:checkbox("\v☊\r  Clantag"):depend({
			var_30_10,
			"Misc"
		})
		arg_30_0.menu.tools.resolver = var_30_0:checkbox("\v❖\r  Resolver"):depend({
			var_30_10,
			"Misc"
		})
		arg_30_0.menu.tools.resolver_delta = var_30_0:checkbox(var_30_6 .. "Delta Fix"):depend({
			var_30_10,
			"Misc"
		}, {
			arg_30_0.menu.tools.resolver,
			true
		})

		for iter_30_4, iter_30_5 in pairs(arg_30_0.menu) do
			if type(iter_30_5) == "table" and iter_30_4 ~= "global" then
				function Loop(arg_43_0, arg_43_1)
					for iter_43_0, iter_43_1 in pairs(arg_43_0) do
						if type(iter_43_1) == "table" then
							if iter_43_1.__type == "pui::element" then
								iter_43_1:depend({
									arg_30_0.menu.global.tab,
									arg_43_1
								})
							else
								Loop(iter_43_1, arg_43_1)
							end
						end
					end
				end

				Loop(iter_30_5, iter_30_4)
			end
		end
	end,
	shutdown = function(arg_44_0)
		arg_44_0.helpers:menu_visibility(true)
	end
}):struct("helpers")({
	last_eye_yaw = 0,
	was_in_air = true,
	last_tick = globals.tickcount(),
	anim = {},
	contains = function(arg_45_0, arg_45_1, arg_45_2)
		for iter_45_0, iter_45_1 in pairs(arg_45_1) do
			if iter_45_1 == arg_45_2 then
				return true
			end
		end

		return false
	end,
	lerp = function(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
		local var_46_0 = (arg_46_2 - arg_46_1) * arg_46_3 + arg_46_1

		return tonumber(string.format("%.3f", var_46_0))
	end,
	math_anim2 = function(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
		return arg_47_0:lerp(arg_47_1, arg_47_2, globals.frametime() * (arg_47_3 or 8))
	end,
	new_anim = function(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
		if arg_48_0.anim[arg_48_1] == nil then
			arg_48_0.anim[arg_48_1] = arg_48_2
		end

		local var_48_0 = arg_48_0:math_anim2(arg_48_0.anim[arg_48_1], arg_48_2, arg_48_3)

		if 0.10000000149011612 > math.abs(var_48_0) then
			var_48_0 = 0
		end

		arg_48_0.anim[arg_48_1] = var_48_0

		return arg_48_0.anim[arg_48_1]
	end,
	rgba_to_hex = function(arg_49_0, arg_49_1, arg_49_2, arg_49_3, arg_49_4)
		return bit.tohex(math.floor(arg_49_1 + 0.5) * 16777216 + math.floor(arg_49_2 + 0.5) * 65536 + math.floor(arg_49_3 + 0.5) * 256 + math.floor(arg_49_4 + 0.5))
	end,
	limit_ch = function(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
		local var_50_0 = {}
		local var_50_1 = 1

		for iter_50_0 in string.gmatch(arg_50_1, ".[\x80-\xBF]*") do
			var_50_1, var_50_0[var_50_1] = var_50_1 + 1, iter_50_0

			if arg_50_2 < var_50_1 then
				if arg_50_3 then
					var_50_0[var_50_1] = arg_50_3 == true and "..." or arg_50_3
				end

				break
			end
		end

		return table.concat(var_50_0)
	end,
	animate_text = function(arg_51_0, arg_51_1, arg_51_2, arg_51_3, arg_51_4, arg_51_5, arg_51_6)
		local var_51_0 = {}
		local var_51_1 = 1
		local var_51_2 = arg_51_2:len() - 1
		local var_51_3 = 255 - arg_51_3
		local var_51_4 = 255 - arg_51_4
		local var_51_5 = 255 - arg_51_5
		local var_51_6 = 155 - arg_51_6

		for iter_51_0 = 1, #arg_51_2 do
			local var_51_7 = (iter_51_0 - 1) / (#arg_51_2 - 1) + arg_51_1

			var_51_0[var_51_1] = "\a" .. arg_51_0:rgba_to_hex(arg_51_3 + var_51_3 * math.abs(math.cos(var_51_7)), arg_51_4 + var_51_4 * math.abs(math.cos(var_51_7)), arg_51_5 + var_51_5 * math.abs(math.cos(var_51_7)), arg_51_6 + var_51_6 * math.abs(math.cos(var_51_7)))
			var_51_0[var_51_1 + 1] = arg_51_2:sub(iter_51_0, iter_51_0)
			var_51_1 = var_51_1 + 2
		end

		return var_51_0
	end,
	clamp = function(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
		assert(arg_52_1 and arg_52_2 and arg_52_3, "not very useful error message here")

		if arg_52_3 < arg_52_2 then
			arg_52_2, arg_52_3 = arg_52_3, arg_52_2
		end

		return math.max(arg_52_2, math.min(arg_52_3, arg_52_1))
	end,
	rounded_side_v = function(arg_53_0, arg_53_1, arg_53_2, arg_53_3, arg_53_4, arg_53_5, arg_53_6, arg_53_7, arg_53_8, arg_53_9, arg_53_10, arg_53_11)
		arg_53_1, arg_53_2, arg_53_3, arg_53_4, arg_53_9 = arg_53_1 * 1, arg_53_2 * 1, arg_53_3 * 1, arg_53_4 * 1, (arg_53_9 or 0) * 1
		arg_53_10, arg_53_11 = arg_53_10 or false, arg_53_11 or false

		local var_53_0 = arg_53_5
		local var_53_1 = arg_53_6
		local var_53_2 = arg_53_7
		local var_53_3 = arg_53_8

		renderer.rectangle(arg_53_1 + arg_53_9, arg_53_2, arg_53_3 - arg_53_9, arg_53_4, var_53_0, var_53_1, var_53_2, var_53_3)

		if arg_53_10 then
			renderer.circle(arg_53_1 + arg_53_9, arg_53_2 + arg_53_9, var_53_0, var_53_1, var_53_2, var_53_3, arg_53_9, 180, 0.25)
			renderer.circle(arg_53_1 + arg_53_9, arg_53_2 + arg_53_4 - arg_53_9, var_53_0, var_53_1, var_53_2, var_53_3, arg_53_9, 270, 0.25)
			renderer.rectangle(arg_53_1, arg_53_2 + arg_53_9, arg_53_3 - arg_53_3 + arg_53_9, arg_53_4 - arg_53_9 - arg_53_9, var_53_0, var_53_1, var_53_2, var_53_3)
		end

		if arg_53_11 then
			renderer.circle(arg_53_1 + arg_53_3, arg_53_2 + arg_53_9, var_53_0, var_53_1, var_53_2, var_53_3, arg_53_9, 90, 0.25)
			renderer.circle(arg_53_1 + arg_53_3, arg_53_2 + arg_53_4 - arg_53_9, var_53_0, var_53_1, var_53_2, var_53_3, arg_53_9, 0, 0.25)
			renderer.rectangle(arg_53_1 + arg_53_3, arg_53_2 + arg_53_9, arg_53_3 - arg_53_3 + arg_53_9, arg_53_4 - arg_53_9 - arg_53_9, var_53_0, var_53_1, var_53_2, var_53_3)
		end
	end,
	get_camera_pos = function(arg_54_0, arg_54_1)
		local var_54_0, var_54_1, var_54_2 = entity.get_prop(arg_54_1, "m_vecOrigin")

		if var_54_0 == nil then
			return
		end

		local var_54_3, var_54_4, var_54_5 = entity.get_prop(arg_54_1, "m_vecViewOffset")
		local var_54_6 = var_54_2 + (var_54_5 - entity.get_prop(arg_54_1, "m_flDuckAmount") * 16)

		return var_54_0, var_54_1, var_54_6
	end,
	fired_shot = function(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
		local var_55_0 = {
			arg_55_0:get_camera_pos(arg_55_2)
		}

		if var_55_0[1] == nil then
			return
		end

		local var_55_1 = {
			entity.hitbox_position(arg_55_1, 0)
		}
		local var_55_2 = {
			var_55_1[1] - var_55_0[1],
			var_55_1[2] - var_55_0[2],
			var_55_1[3] - var_55_0[3]
		}
		local var_55_3 = {
			arg_55_3[1] - var_55_0[1],
			arg_55_3[2] - var_55_0[2],
			arg_55_3[3] - var_55_0[3]
		}
		local var_55_4 = (var_55_2[1] * var_55_3[1] + var_55_2[2] * var_55_3[2] + var_55_2[3] * var_55_3[3]) / (math.pow(var_55_3[1], 2) + math.pow(var_55_3[2], 2) + math.pow(var_55_3[3], 2))
		local var_55_5 = {
			var_55_0[1] + var_55_3[1] * var_55_4,
			var_55_0[2] + var_55_3[2] * var_55_4,
			var_55_0[3] + var_55_3[3] * var_55_4
		}
		local var_55_6 = math.abs(math.sqrt(math.pow(var_55_1[1] - var_55_5[1], 2) + math.pow(var_55_1[2] - var_55_5[2], 2) + math.pow(var_55_1[3] - var_55_5[3], 2)))
		local var_55_7 = client.trace_line(arg_55_2, arg_55_3[1], arg_55_3[2], arg_55_3[3], var_55_1[1], var_55_1[2], var_55_1[3])
		local var_55_8 = client.trace_line(arg_55_1, var_55_5[1], var_55_5[2], var_55_5[3], var_55_1[1], var_55_1[2], var_55_1[3])

		return var_55_6 < 69 and (var_55_7 > 0.99 or var_55_8 > 0.99)
	end,
	get_velocity = function(arg_56_0, arg_56_1)
		local var_56_0 = entity.get_prop(arg_56_1, "m_vecVelocity[0]")
		local var_56_1 = entity.get_prop(arg_56_1, "m_vecVelocity[1]")

		return math.floor(math.sqrt(var_56_0 * var_56_0 + var_56_1 * var_56_1))
	end,
	get_damage = function(arg_57_0)
		local var_57_0 = ui.get(arg_57_0.ref.rage.mindmg[1])

		if ui.get(arg_57_0.ref.rage.ovr[1]) and ui.get(arg_57_0.ref.rage.ovr[2]) then
			return ui.get(arg_57_0.ref.rage.ovr[3])
		else
			return var_57_0
		end
	end,
	normalize = function(arg_58_0, arg_58_1)
		arg_58_1 = arg_58_1 % 360
		arg_58_1 = (arg_58_1 + 360) % 360

		if arg_58_1 > 180 then
			arg_58_1 = arg_58_1 - 360
		end

		return arg_58_1
	end,
	distance = function(arg_59_0, arg_59_1, arg_59_2, arg_59_3, arg_59_4, arg_59_5, arg_59_6)
		return math.sqrt((arg_59_4 - arg_59_1)^2 + (arg_59_5 - arg_59_2)^2 + (arg_59_6 - arg_59_3)^2)
	end,
	menu_visibility = function(arg_60_0, arg_60_1)
		local var_60_0 = {
			arg_60_0.ref.aa,
			arg_60_0.ref.fakelag,
			arg_60_0.ref.aa_other
		}

		for iter_60_0, iter_60_1 in ipairs(var_60_0) do
			for iter_60_2, iter_60_3 in pairs(iter_60_1) do
				for iter_60_4, iter_60_5 in ipairs(iter_60_3) do
					ui.set_visible(iter_60_5, arg_60_1)
				end
			end
		end
	end,
	in_air = function(arg_61_0, arg_61_1)
		local var_61_0 = entity.get_prop(arg_61_1, "m_fFlags")

		return bit.band(var_61_0, 1) == 0
	end,
	in_duck = function(arg_62_0, arg_62_1)
		local var_62_0 = entity.get_prop(arg_62_1, "m_fFlags")

		return bit.band(var_62_0, 4) == 4
	end,
	get_eye_yaw = function(arg_63_0, arg_63_1)
		if arg_63_1 == nil then
			return
		end

		local var_63_0 = var_0_17(var_0_16, arg_63_1)

		if var_63_0 == nil then
			return
		end

		local var_63_1 = var_0_6.cast("float*", var_0_6.cast("char*", var_0_6.cast("void**", var_0_6.cast("char*", var_63_0) + 39264)[0]) + 120)[0]

		if globals.chokedcommands() == 0 then
			arg_63_0.last_eye_yaw = var_63_1
		end

		return arg_63_0.last_eye_yaw
	end,
	get_closest_angle = function(arg_64_0, arg_64_1, arg_64_2, arg_64_3, arg_64_4)
		arg_64_1 = arg_64_0.helpers:normalize(arg_64_1)
		arg_64_2 = arg_64_0.helpers:normalize(arg_64_2)
		arg_64_3 = arg_64_0.helpers:normalize(arg_64_3)
		arg_64_4 = arg_64_0.helpers:normalize(arg_64_4)

		local var_64_0 = math.abs((arg_64_1 - arg_64_4 + 180) % 360 - 180)
		local var_64_1 = math.abs((arg_64_2 - arg_64_4 + 180) % 360 - 180)
		local var_64_2 = math.abs((arg_64_1 - arg_64_3 + 180) % 360 - 180)
		local var_64_3 = math.abs((arg_64_2 - arg_64_3 + 180) % 360 - 180)
		local var_64_4 = math.abs((arg_64_2 - arg_64_1 + 180) % 360 - 180)
		local var_64_5 = var_64_4 < var_64_0 or var_64_4 < var_64_1

		if (var_64_4 < var_64_2 or var_64_4 < var_64_3) ~= var_64_5 then
			if var_64_1 < var_64_0 then
				return 0
			else
				return 1
			end

			return
		end

		return 2
	end,
	get_freestanding_side = function(arg_65_0, arg_65_1)
		local var_65_0 = entity.get_local_player()
		local var_65_1 = client.current_threat()
		local var_65_2, var_65_3 = client.camera_angles()
		local var_65_4 = var_0_0(client.eye_position())

		if not var_65_1 then
			return 2
		end

		local var_65_5, var_65_6 = (var_65_4 - var_0_0(entity.get_origin(var_65_1))):angles()
		local var_65_7 = arg_65_1.offset
		local var_65_8 = string.lower(arg_65_1.type)
		local var_65_9 = arg_65_1.value
		local var_65_10 = math.abs(var_65_9)

		if var_65_8 == "skitter" then
			var_65_10 = math.abs(var_65_9) + 33
		elseif var_65_8 == "offset" then
			var_65_10 = math.max(0, var_65_9)
		elseif var_65_8 == "center" then
			var_65_10 = math.abs(var_65_9) / 2
		end

		local var_65_11 = arg_65_0.helpers:normalize(var_65_6 + var_65_7 + var_65_10)
		local var_65_12 = var_65_10

		if var_65_8 == "offset" then
			var_65_12 = math.abs(math.min(0, var_65_9))
		end

		local var_65_13 = arg_65_0.helpers:normalize(var_65_6 + var_65_7 - var_65_12)
		local var_65_14 = arg_65_0:get_eye_yaw(var_65_0)

		print(var_65_14)

		local var_65_15 = var_65_11 - var_65_14
		local var_65_16 = var_65_13 - var_65_14

		return (arg_65_0:get_closest_angle(var_65_13, var_65_11, var_65_6, var_65_14))
	end,
	get_state = function(arg_66_0)
		local var_66_0 = entity.get_local_player()
		local var_66_1 = var_0_0(entity.get_prop(var_66_0, "m_vecVelocity")):length2d()
		local var_66_2 = arg_66_0:in_duck(var_66_0) or ui.get(arg_66_0.ref.rage.fd[1])
		local var_66_3 = var_66_1 > 1.5 and "run" or "stand"

		if arg_66_0:in_air(var_66_0) or arg_66_0.was_in_air then
			var_66_3 = var_66_2 and "aerobic+" or "aerobic"
		elseif var_66_1 > 1.5 and var_66_2 then
			var_66_3 = "sneak"
		elseif ui.get(arg_66_0.ref.slow_motion[1]) and ui.get(arg_66_0.ref.slow_motion[2]) then
			var_66_3 = "slow walk"
		elseif var_66_2 then
			var_66_3 = "crouch"
		end

		if globals.tickcount() ~= arg_66_0.last_tick then
			arg_66_0.was_in_air = arg_66_0:in_air(var_66_0)
			arg_66_0.last_tick = globals.tickcount()
		end

		return var_66_3
	end,
	get_team = function(arg_67_0)
		local var_67_0 = entity.get_local_player()

		return entity.get_prop(var_67_0, "m_iTeamNum") == 2 and "t" or "ct"
	end,
	get_charge = function()
		local var_68_0 = entity.get_local_player()
		local var_68_1 = entity.get_prop(entity.get_local_player(), "m_flSimulationTime")

		return globals.tickcount() - var_68_1 / globals.tickinterval()
	end
}):struct("config")({
	configs = {},
	write_file = function(arg_69_0, arg_69_1, arg_69_2)
		if not arg_69_2 or type(arg_69_1) ~= "string" then
			return
		end

		return writefile(arg_69_1, json.stringify(arg_69_2))
	end,
	update_name = function(arg_70_0)
		local var_70_0 = arg_70_0.ui.menu.home.list()
		local var_70_1 = 0

		for iter_70_0, iter_70_1 in pairs(arg_70_0.configs) do
			if var_70_0 == var_70_1 then
				return arg_70_0.ui.menu.home.name(iter_70_0)
			end

			var_70_1 = var_70_1 + 1
		end
	end,
	update_configs = function(arg_71_0)
		local var_71_0 = {}

		for iter_71_0, iter_71_1 in pairs(arg_71_0.configs) do
			table.insert(var_71_0, iter_71_0)
		end

		if #var_71_0 > 0 then
			arg_71_0.ui.menu.home.list:update(var_71_0)
		end

		arg_71_0:write_file("onesense_configs.txt", arg_71_0.configs)
		arg_71_0:update_name()
	end,
	setup = function(arg_72_0)
		local var_72_0 = readfile("onesense_configs.txt")

		if var_72_0 == nil then
			arg_72_0.configs = {}

			return
		end

		arg_72_0.configs = json.parse(var_72_0)

		arg_72_0:update_configs()
		arg_72_0:update_name()
	end,
	export_config = function(arg_73_0, ...)
		local var_73_0 = arg_73_0.ui.menu.home.name()
		local var_73_1 = var_0_1.setup({
			arg_73_0.ui.menu.global,
			arg_73_0.ui.menu.antiaim,
			arg_73_0.ui.menu.tools
		}):save()
		local var_73_2 = var_0_2.encode(json.stringify(var_73_1))

		print("Succsess cfg export")

		return var_73_2
	end,
	export_state = function(arg_74_0, arg_74_1)
		local var_74_0 = var_0_1.setup({
			arg_74_0.ui.menu.antiaim.states[arg_74_1]
		})
		local var_74_1 = arg_74_0.ui.menu.antiaim.state:get()
		local var_74_2 = var_74_0:save()
		local var_74_3 = var_0_2.encode(json.stringify(var_74_2))

		var_0_10.create_new({
			{
				"Condition "
			},
			{
				var_74_1,
				true
			},
			{
				" export"
			}
		})

		return var_74_3
	end,
	export = function(arg_75_0, arg_75_1, ...)
		local var_75_0, var_75_1 = pcall(arg_75_0["export_" .. arg_75_1], arg_75_0, ...)

		if not var_75_0 then
			print(var_75_1)

			return
		end

		print("Succsess")

		return "{onesense:" .. arg_75_1 .. "}:" .. var_75_1
	end,
	import_config = function(arg_76_0, arg_76_1)
		local var_76_0 = json.parse(var_0_2.decode(arg_76_1))

		var_0_1.setup({
			arg_76_0.ui.menu.global,
			arg_76_0.ui.menu.antiaim,
			arg_76_0.ui.menu.tools
		}):load(var_76_0)
		var_0_10.create_new({
			{
				"Cfg import"
			},
			{
				"!",
				true
			}
		})
	end,
	import_state = function(arg_77_0, arg_77_1, arg_77_2)
		local var_77_0 = json.parse(var_0_2.decode(arg_77_1))

		var_0_1.setup({
			arg_77_0.ui.menu.antiaim.states[arg_77_2]
		}):load(var_77_0)
		var_0_10.create_new({
			{
				"Condition import"
			},
			{
				"!",
				true
			}
		})
	end,
	import = function(arg_78_0, arg_78_1, arg_78_2, ...)
		local var_78_0 = arg_78_1:match("{onesense:(.+)}")

		if not var_78_0 or var_78_0 ~= arg_78_2 then
			var_0_10.create_new({
				{
					"Error: "
				},
				{
					"This not onesense config",
					true
				}
			})

			return error("This not onesense config")
		end

		local var_78_1, var_78_2 = pcall(arg_78_0["import_" .. var_78_0], arg_78_0, arg_78_1:gsub("{onesense:" .. var_78_0 .. "}:", ""), ...)

		if not var_78_1 then
			print(var_78_2)
			var_0_10.create_new({
				{
					"Error: "
				},
				{
					"Failed data onesense",
					true
				}
			})

			return error("Failed data onesense")
		end
	end,
	save = function(arg_79_0)
		local var_79_0 = arg_79_0.ui.menu.home.name()

		if var_79_0:match("%w") == nil then
			var_0_10.create_new({
				{
					"Invalid config "
				},
				{
					"name",
					true
				}
			})

			return print("Invalid config name")
		end

		local var_79_1 = arg_79_0:export("config")

		arg_79_0.configs[var_79_0] = var_79_1

		var_0_10.create_new({
			{
				"Saved cfg "
			},
			{
				var_79_0,
				true
			}
		})
		arg_79_0:update_configs()
	end,
	load = function(arg_80_0, arg_80_1)
		local var_80_0 = arg_80_0.ui.menu.home.name()
		local var_80_1 = arg_80_0.configs[var_80_0]

		if not var_80_1 then
			var_0_10.create_new({
				{
					"Invalid cfg "
				},
				{
					"name",
					true
				}
			})

			return error("Inval. cfg name")
		end

		arg_80_0:import(var_80_1, arg_80_1)
		var_0_10.create_new({
			{
				"Loaded cfg "
			},
			{
				var_80_0,
				true
			}
		})
	end,
	delete = function(arg_81_0)
		local var_81_0 = arg_81_0.ui.menu.home.name()

		if not arg_81_0.configs[var_81_0] then
			return error("Invalid config name")
		end

		arg_81_0.configs[var_81_0] = nil

		var_0_10.create_new({
			{
				"Delete cfg "
			},
			{
				var_81_0,
				true
			}
		})
		arg_81_0:update_configs()
	end
}):struct("fakelag")({
	send_packet = true,
	get_limit = function(arg_82_0)
		if not ui.get(arg_82_0.ref.fakelag.enable[1]) then
			return 1
		end

		local var_82_0 = ui.get(arg_82_0.ref.fakelag.limit[1])
		local var_82_1 = arg_82_0.helpers:get_charge()
		local var_82_2 = ui.get(arg_82_0.ref.rage.dt[1]) and ui.get(arg_82_0.ref.rage.dt[2])
		local var_82_3 = ui.get(arg_82_0.ref.rage.os[1]) and ui.get(arg_82_0.ref.rage.os[2])

		if (var_82_2 or var_82_3) and not ui.get(arg_82_0.ref.rage.fd[1]) then
			var_82_0 = var_82_1 > 0 and 1 or ui.get(arg_82_0.ref.rage.dt_limit[1])
		end

		return var_82_0
	end,
	run = function(arg_83_0, arg_83_1)
		local var_83_0 = arg_83_0:get_limit()

		if var_83_0 > arg_83_1.chokedcommands and (not arg_83_1.no_choke or arg_83_1.chokedcommands == 0 and var_83_0 == 1) then
			arg_83_0.send_packet = false
			arg_83_1.no_choke = false
		else
			arg_83_1.no_choke = true
			arg_83_0.send_packet = true
		end

		arg_83_1.allow_send_packet = arg_83_0.send_packet

		return arg_83_0.send_packet
	end
}):struct("desync")({
	switch_move = true,
	get_yaw_base = function(arg_84_0, arg_84_1)
		local var_84_0 = client.current_threat()
		local var_84_1, var_84_2 = client.camera_angles()

		if arg_84_1 == "At targets" and var_84_0 then
			local var_84_3 = var_0_0(entity.get_origin(entity.get_local_player()))
			local var_84_4 = var_0_0(entity.get_origin(var_84_0))
			local var_84_5

			var_84_5, var_84_2 = var_84_3:to(var_84_4):angles()
		end

		return var_84_2
	end,
	do_micromovements = function(arg_85_0, arg_85_1, arg_85_2)
		local var_85_0 = entity.get_local_player()
		local var_85_1 = 1.01

		if var_0_0(entity.get_prop(var_85_0, "m_vecVelocity")):length2d() > 3 then
			return
		end

		if arg_85_0.helpers:in_duck(var_85_0) or ui.get(arg_85_0.ref.rage.fd[1]) then
			var_85_1 = var_85_1 * 2.94117647
		end

		arg_85_0.switch_move = arg_85_0.switch_move or false

		if arg_85_0.switch_move then
			arg_85_1.sidemove = arg_85_1.sidemove + var_85_1
		else
			arg_85_1.sidemove = arg_85_1.sidemove - var_85_1
		end

		arg_85_0.switch_move = not arg_85_0.switch_move
	end,
	can_desync = function(arg_86_0, arg_86_1)
		local var_86_0 = entity.get_local_player()

		if arg_86_1.in_use == 1 then
			return false
		end

		local var_86_1 = entity.get_player_weapon(var_86_0)

		if arg_86_1.in_attack == 1 then
			local var_86_2 = entity.get_classname(var_86_1)

			if var_86_2 == nil then
				return false
			end

			if var_86_2:find("Grenade") or var_86_2:find("Flashbang") then
				arg_86_0.globals.nade = globals.tickcount()
			elseif math.max(entity.get_prop(var_86_1, "m_flNextPrimaryAttack"), entity.get_prop(var_86_0, "m_flNextAttack")) - globals.tickinterval() - globals.curtime() < 0 then
				return false
			end
		end

		local var_86_3 = entity.get_prop(var_86_1, "m_fThrowTime")

		if arg_86_0.globals.nade + 15 == globals.tickcount() or var_86_3 ~= nil and var_86_3 ~= 0 then
			return false
		end

		if entity.get_prop(entity.get_game_rules(), "m_bFreezePeriod") == 1 then
			return false
		end

		if entity.get_prop(var_86_0, "m_MoveType") == 10 then
			return false
		end

		return true
	end,
	run = function(arg_87_0, arg_87_1, arg_87_2, arg_87_3)
		if not arg_87_0:can_desync(arg_87_1) then
			return
		end

		arg_87_0:do_micromovements(arg_87_1, arg_87_2)

		local var_87_0 = arg_87_0:get_yaw_base(arg_87_3.base)

		if arg_87_2 then
			arg_87_1.pitch = arg_87_3.pitch or 88.9
			arg_87_1.yaw = var_87_0 + 180 + arg_87_3.offset
		else
			arg_87_1.pitch = 88.9
			arg_87_1.yaw = var_87_0 + 180 + arg_87_3.offset + (arg_87_3.side == 2 and 0 or arg_87_3.side == 0 and 120 or -120)
		end
	end
}):struct("antiaim")({
	spin_way = 0,
	side = 0,
	side_180 = 0,
	last_rand = 0,
	SPIN3 = 0,
	skitter_counter = 0,
	cycle = 0,
	freestanding_side = 0,
	last_skitter = 0,
	manual_side = 0,
	ran3 = 0,
	sise_180 = 0,
	current_way = 1,
	ran2 = 0,
	JITTER = 0,
	spin_yaw = 0,
	ran1 = 0,
	SPIN2 = 0,
	last_way = 0,
	spin_pitch = 0,
	check_in = 0,
	anti_backstab = function(arg_88_0)
		local var_88_0 = entity.get_local_player()
		local var_88_1 = client.current_threat()

		if var_88_0 == nil or not entity.is_alive(var_88_0) then
			return false
		end

		if not var_88_1 then
			return false
		end

		local var_88_2 = entity.get_player_weapon(var_88_1)

		if not var_88_2 then
			return false
		end

		if not entity.get_classname(var_88_2):find("Knife") then
			return false
		end

		local var_88_3 = var_0_0(entity.get_origin(var_88_0))
		local var_88_4 = var_0_0(entity.get_origin(var_88_1))

		return 168 > var_88_4:dist2d(var_88_3)
	end,
	calculate_additional_states = function(arg_89_0, arg_89_1)
		local var_89_0 = ui.get(arg_89_0.ref.rage.dt[1]) and ui.get(arg_89_0.ref.rage.dt[2])
		local var_89_1 = ui.get(arg_89_0.ref.rage.os[1]) and ui.get(arg_89_0.ref.rage.os[2])
		local var_89_2 = ui.get(arg_89_0.ref.rage.fd[1])

		if arg_89_0.ui.menu.antiaim.states.fakelag.enable() and (not var_89_0 and not var_89_1 or var_89_2) then
			arg_89_1 = "fakelag"
		end

		if arg_89_0.ui.menu.antiaim.states.hideshots.enable() and var_89_1 and not var_89_0 and not var_89_2 then
			arg_89_1 = "hideshots"
		end

		return arg_89_1
	end,
	get_best_side = function(arg_90_0, arg_90_1)
		local var_90_0 = entity.get_local_player()
		local var_90_1 = var_0_0(client.eye_position())
		local var_90_2 = client.current_threat()
		local var_90_3, var_90_4 = client.camera_angles()
		local var_90_5

		if var_90_2 then
			var_90_5 = var_0_0(entity.get_origin(var_90_2)) + var_0_0(0, 0, 64)

			local var_90_6

			var_90_6, var_90_4 = (var_90_5 - var_90_1):angles()
		end

		local var_90_7 = {
			60,
			45,
			30,
			-30,
			-45,
			-60
		}
		local var_90_8 = {
			left = 0,
			right = 0
		}

		for iter_90_0, iter_90_1 in ipairs(var_90_7) do
			local var_90_9 = var_0_0():init_from_angles(0, var_90_4 + 180 + iter_90_1, 0)

			if var_90_2 then
				local var_90_10 = var_90_1 + var_90_9:scaled(128)
				local var_90_11, var_90_12 = client.trace_bullet(var_90_2, var_90_5.x, var_90_5.y, var_90_5.z, var_90_10.x, var_90_10.y, var_90_10.z, var_90_0)

				var_90_8[iter_90_1 < 0 and "left" or "right"] = var_90_8[iter_90_1 < 0 and "left" or "right"] + var_90_12
			else
				local var_90_13 = var_90_1 + var_90_9:scaled(8192)
				local var_90_14 = client.trace_line(var_90_0, var_90_1.x, var_90_1.y, var_90_1.z, var_90_13.x, var_90_13.y, var_90_13.z)

				var_90_8[iter_90_1 < 0 and "left" or "right"] = var_90_8[iter_90_1 < 0 and "left" or "right"] + var_90_14
			end
		end

		if var_90_8.left == var_90_8.right then
			return 2
		elseif var_90_8.left > var_90_8.right then
			return arg_90_1 and 1 or 0
		else
			return arg_90_1 and 0 or 1
		end
	end,
	get_manual = function(arg_91_0)
		local var_91_0 = entity.get_local_player()

		if not arg_91_0.ui.menu.antiaim.manual_aa:get() then
			return
		end

		local var_91_1 = arg_91_0.ui.menu.antiaim.manual_left:get()
		local var_91_2 = arg_91_0.ui.menu.antiaim.manual_right:get()
		local var_91_3 = arg_91_0.ui.menu.antiaim.manual_forward:get()

		if arg_91_0.last_forward == nil then
			arg_91_0.last_forward, arg_91_0.last_right, arg_91_0.last_left = var_91_3, var_91_2, var_91_1
		end

		if var_91_1 ~= arg_91_0.last_left then
			if arg_91_0.manual_side == 1 then
				arg_91_0.manual_side = nil
			else
				arg_91_0.manual_side = 1
			end
		end

		if var_91_2 ~= arg_91_0.last_right then
			if arg_91_0.manual_side == 2 then
				arg_91_0.manual_side = nil
			else
				arg_91_0.manual_side = 2
			end
		end

		if var_91_3 ~= arg_91_0.last_forward then
			if arg_91_0.manual_side == 3 then
				arg_91_0.manual_side = nil
			else
				arg_91_0.manual_side = 3
			end
		end

		arg_91_0.last_forward, arg_91_0.last_right, arg_91_0.last_left = var_91_3, var_91_2, var_91_1

		if not arg_91_0.manual_side then
			return
		end

		return ({
			-90,
			90,
			180
		})[arg_91_0.manual_side]
	end,
	run = function(arg_92_0, arg_92_1)
		local var_92_0 = entity.get_local_player()

		if not entity.is_alive(var_92_0) then
			return
		end

		local var_92_1 = arg_92_0.helpers:get_state()
		local var_92_2 = arg_92_0:calculate_additional_states(var_92_1)

		arg_92_0:set_builder(arg_92_1, var_92_2)
	end,
	set_builder = function(arg_93_0, arg_93_1, arg_93_2)
		if not arg_93_0.ui.menu.antiaim.states[arg_93_2].enable() then
			arg_93_2 = "global"
		end

		local var_93_0 = {}

		for iter_93_0, iter_93_1 in pairs(arg_93_0.ui.menu.antiaim.states[arg_93_2]) do
			var_93_0[iter_93_0] = iter_93_1()
		end

		arg_93_0:set(arg_93_1, var_93_0)
	end,
	animations = function(arg_94_0)
		local var_94_0 = entity.get_local_player()
		local var_94_1 = arg_94_0.ui.menu.tools.animations:get()

		if not entity.is_alive(var_94_0) or not var_94_1 then
			return
		end

		local var_94_2 = var_0_4.new(var_94_0)
		local var_94_3 = var_94_2:get_anim_state()
		local var_94_4 = arg_94_0.ui.menu.tools.animations_body:get()
		local var_94_5 = arg_94_0.ui.menu.tools.animations_selector:get()

		if not var_94_3 then
			return
		end

		local var_94_6 = arg_94_0.helpers:get_state()
		local var_94_7 = entity.get_prop(var_94_0, "m_vecVelocity[0]")

		if arg_94_0.helpers:contains(var_94_5, "Body lean") then
			local var_94_8 = var_94_2:get_anim_overlay(12)

			if not var_94_8 then
				return
			end

			if math.abs(var_94_7) >= 3 then
				var_94_8.weight = var_94_4 / 100
			end
		end

		if arg_94_0.helpers:contains(var_94_5, "Static legs") then
			entity.set_prop(var_94_0, "m_flPoseParameter", 1, 6)
		end

		if arg_94_0.helpers:contains(var_94_5, "Jitter ground") then
			ui.set(arg_94_0.ref.fakelag.lg[1], "Always slide")

			if globals.tickcount() % 4 > 1 then
				entity.set_prop(var_94_0, "m_flPoseParameter", 0, 0)
			end
		end

		if arg_94_0.helpers:contains(var_94_5, "Kangaroo") then
			if not arg_94_0.helpers:contains(var_94_5, "Jitter air") then
				entity.set_prop(var_94_0, "m_flPoseParameter", math.random(0, 10) / 10, 6)
			end

			entity.set_prop(var_94_0, "m_flPoseParameter", math.random(0, 10) / 10, 10)
			entity.set_prop(var_94_0, "m_flPoseParameter", math.random(0, 10) / 10, 9)
		end

		if arg_94_0.helpers:contains(var_94_5, "Jitter air") then
			entity.set_prop(var_94_0, "m_flPoseParameter", math.random(0, 10) / 10, 6)
		end

		if arg_94_0.helpers:contains(var_94_5, "Moonwalk") then
			ui.set(arg_94_0.ref.fakelag.lg[1], "Never slide")
			entity.set_prop(var_94_0, "m_flPoseParameter", 0, 7)

			if arg_94_0.helpers:in_air(var_94_0) then
				var_94_2:get_anim_overlay(4).weight = 0
				var_94_2:get_anim_overlay(6).weight = 1
			end
		end

		if arg_94_0.helpers:contains(var_94_5, "Reset pitch on land") then
			if not var_94_3.hit_in_ground_animation then
				return
			end

			entity.set_prop(var_94_0, "m_flPoseParameter", 0.5, 12)
		end
	end,
	get_defensive = function(arg_95_0, arg_95_1, arg_95_2, arg_95_3)
		local var_95_0 = client.current_threat()
		local var_95_1 = entity.get_local_player()

		if arg_95_0.helpers:contains(arg_95_1, "Always") then
			return true
		end

		if arg_95_0.helpers:contains(arg_95_1, "On weapon switch") and (entity.get_prop(var_95_1, "m_flNextAttack") - globals.curtime()) / globals.tickinterval() > arg_95_0.defensive.defensive + 2 then
			return true
		end

		if arg_95_0.helpers:contains(arg_95_1, "On reload") then
			local var_95_2 = entity.get_player_weapon(var_95_1)

			if var_95_2 then
				local var_95_3 = entity.get_prop(var_95_1, "m_flNextAttack") - globals.curtime()
				local var_95_4 = entity.get_prop(var_95_2, "m_flNextPrimaryAttack") - globals.curtime()

				if var_95_3 > 0 and var_95_4 > 0 and var_95_3 * globals.tickinterval() > arg_95_0.defensive.defensive then
					return true
				end
			end
		end

		if arg_95_0.helpers:contains(arg_95_1, "On hittable") and var_0_19(var_95_0, "HIT") then
			return true
		end

		if arg_95_0.helpers:contains(arg_95_1, "On freestand") and arg_95_0.ui.menu.antiaim.freestanding:get_hotkey() and (not arg_95_0.ui.menu.antiaim.freestanding:get("Disablers") or not arg_95_0.ui.menu.antiaim.freestanding_disablers:get(arg_95_2)) then
			return true
		end
	end,
	set = function(arg_96_0, arg_96_1, arg_96_2)
		local var_96_0 = arg_96_0.helpers:get_state()
		local var_96_1 = {
			math.random(1, math.random(3, 4)),
			2,
			4,
			5
		}
		local var_96_2 = arg_96_0:get_manual()
		local var_96_3 = true

		if arg_96_2.jitter_delay == 0 then
			var_96_1[arg_96_2.jitter_delay] = 1
		end

		if globals.chokedcommands() == 0 and arg_96_0.cycle == var_96_1[arg_96_2.jitter_delay] then
			var_96_3 = false
			arg_96_0.side = arg_96_0.side == 1 and 0 or 1
		end

		local var_96_4 = arg_96_0:get_best_side()
		local var_96_5 = arg_96_0.side
		local var_96_6 = arg_96_2.body_yaw
		local var_96_7 = "default"

		if var_96_6 == "Jitter" then
			var_96_6 = "Static"
		else
			var_96_5 = arg_96_2.body_yaw_side == "Left" and 1 or arg_96_2.body_yaw_side == "Right" and 0 or var_96_4
		end

		local var_96_8 = 0

		if arg_96_2.yaw_jitter == "Offset" then
			if arg_96_0.side == 1 then
				var_96_8 = var_96_8 + arg_96_2.yaw_jitter_add
			end
		elseif arg_96_2.yaw_jitter == "Center" then
			var_96_8 = var_96_8 + (arg_96_0.side == 1 and arg_96_2.yaw_jitter_add / 2 or -arg_96_2.yaw_jitter_add / 2)
		elseif arg_96_2.yaw_jitter == "Random" then
			local var_96_9 = math.random(0, arg_96_2.yaw_jitter_add) - arg_96_2.yaw_jitter_add / 2

			if not var_96_3 then
				var_96_8 = var_96_8 + var_96_9
				arg_96_0.last_rand = var_96_9
			else
				var_96_8 = var_96_8 + arg_96_0.last_rand
			end
		elseif arg_96_2.yaw_jitter == "Skitter" then
			local var_96_10 = {
				0,
				2,
				1,
				0,
				2,
				1,
				0,
				1,
				2,
				0,
				1,
				2,
				0,
				1,
				2
			}
			local var_96_11

			if arg_96_0.skitter_counter == #var_96_10 then
				arg_96_0.skitter_counter = 1
			elseif not var_96_3 then
				arg_96_0.skitter_counter = arg_96_0.skitter_counter + 1
			end

			local var_96_12 = var_96_10[arg_96_0.skitter_counter]

			arg_96_0.last_skitter = var_96_12

			if arg_96_2.body_yaw == "jitter" then
				var_96_5 = var_96_12
			end

			if var_96_12 == 0 then
				var_96_8 = var_96_8 - 16 - math.abs(arg_96_2.yaw_jitter_add) / 2
			elseif var_96_12 == 1 then
				var_96_8 = var_96_8 + 16 + math.abs(arg_96_2.yaw_jitter_add) / 2
			end
		end

		local var_96_13 = var_96_8 + (var_96_5 == 0 and arg_96_2.yaw_add_r or var_96_5 == 1 and arg_96_2.yaw_add or 0)

		if arg_96_0.helpers:contains(arg_96_2.options, "Enable defensive") and arg_96_0:get_defensive(arg_96_2.defensive_conditions, var_96_0) then
			arg_96_1.force_defensive = true
		end

		local var_96_14 = arg_96_0.ui.menu.antiaim.edge_yaw:get_hotkey()

		ui.set(arg_96_0.ref.aa.freestand[1], false)
		ui.set(arg_96_0.ref.aa.edge_yaw[1], var_96_14)
		ui.set(arg_96_0.ref.aa.freestand[2], "Always on")

		if arg_96_0.helpers:contains(arg_96_2.options, "Safe head") then
			local var_96_15 = entity.get_local_player()

			if client.current_threat() then
				local var_96_16 = entity.get_player_weapon(var_96_15)

				if var_96_16 and (entity.get_classname(var_96_16):find("Knife") or entity.get_classname(var_96_16):find("Taser")) then
					var_96_13 = 0
					var_96_5 = 2
				end
			end
		end

		if var_96_2 then
			var_96_13 = var_96_2
		elseif arg_96_0.ui.menu.antiaim.freestanding:get_hotkey() and (not arg_96_0.ui.menu.antiaim.freestanding:get("Disablers") or not arg_96_0.ui.menu.antiaim.freestanding_disablers:get(var_96_0)) then
			ui.set(arg_96_0.ref.aa.freestand[1], true)

			arg_96_2.desync_mode = "gamesense"

			if arg_96_0.ui.menu.antiaim.freestanding:get("Force static") or arg_96_0.ui.menu.antiaim.manual_static:get() then
				var_96_13 = 0
				var_96_5 = 0
			end
		elseif arg_96_0.helpers:contains(arg_96_2.options, "Avoid backstab") and arg_96_0:anti_backstab() then
			var_96_13 = var_96_13 + 180
		end

		local var_96_17 = arg_96_0.defensive.ticks * arg_96_0.defensive.defensive > 0 and math.max(arg_96_0.defensive.defensive, arg_96_0.defensive.ticks) or 0
		local var_96_18 = {
			{
				speed = arg_96_2.defensive_yaw_way_speed1,
				spin_limit = arg_96_2.defensive_yaw_way_spin_limit1,
				enable_spin = arg_96_2.defensive_yaw_enable_way_spin1,
				switch_value = arg_96_2.defensive_yaw_way_switch1
			},
			{
				speed = arg_96_2.defensive_yaw_way_speed2,
				spin_limit = arg_96_2.defensive_yaw_way_spin_limit2,
				enable_spin = arg_96_2.defensive_yaw_enable_way_spin2,
				switch_value = arg_96_2.defensive_yaw_way_switch2
			},
			{
				speed = arg_96_2.defensive_yaw_way_speed3,
				spin_limit = arg_96_2.defensive_yaw_way_spin_limit3,
				enable_spin = arg_96_2.defensive_yaw_enable_way_spin3,
				switch_value = arg_96_2.defensive_yaw_way_switch3
			},
			{
				speed = arg_96_2.defensive_yaw_way_speed4,
				spin_limit = arg_96_2.defensive_yaw_way_spin_limit4,
				enable_spin = arg_96_2.defensive_yaw_enable_way_spin4,
				switch_value = arg_96_2.defensive_yaw_way_switch4
			},
			{
				speed = arg_96_2.defensive_yaw_way_speed5,
				spin_limit = arg_96_2.defensive_yaw_way_spin_limit5,
				enable_spin = arg_96_2.defensive_yaw_enable_way_spin5,
				switch_value = arg_96_2.defensive_yaw_way_switch5
			}
		}
		local var_96_19 = {
			{
				speed = arg_96_2.defensive_pitch_way_speed1,
				spin_limit1 = arg_96_2.defensive_pitch_way_spin_limit11,
				spin_limit2 = arg_96_2.defensive_pitch_way_spin_limit12,
				enable_spin = arg_96_2.defensive_pitch_enable_way_spin1,
				switch_value = arg_96_2.defensive_pitch_custom
			},
			{
				speed = arg_96_2.defensive_pitch_way_speed2,
				spin_limit1 = arg_96_2.defensive_pitch_way_spin_limit21,
				spin_limit2 = arg_96_2.defensive_pitch_way_spin_limit22,
				enable_spin = arg_96_2.defensive_pitch_enable_way_spin2,
				switch_value = arg_96_2.defensive_pitch_way2
			},
			{
				speed = arg_96_2.defensive_pitch_way_speed3,
				spin_limit1 = arg_96_2.defensive_pitch_way_spin_limit31,
				spin_limit2 = arg_96_2.defensive_pitch_way_spin_limit32,
				enable_spin = arg_96_2.defensive_pitch_enable_way_spin3,
				switch_value = arg_96_2.defensive_pitch_way3
			},
			{
				speed = arg_96_2.defensive_pitch_way_speed4,
				spin_limit1 = arg_96_2.defensive_pitch_way_spin_limit41,
				spin_limit2 = arg_96_2.defensive_pitch_way_spin_limit42,
				enable_spin = arg_96_2.defensive_pitch_enable_way_spin4,
				switch_value = arg_96_2.defensive_pitch_way4
			},
			{
				speed = arg_96_2.defensive_pitch_way_speed5,
				spin_limit1 = arg_96_2.defensive_pitch_way_spin_limit51,
				spin_limit2 = arg_96_2.defensive_pitch_way_spin_limit52,
				enable_spin = arg_96_2.defensive_pitch_enable_way_spin5,
				switch_value = arg_96_2.defensive_pitch_way5
			}
		}
		local var_96_20 = globals.tickcount() % 32

		if arg_96_2.defensive_yaw and arg_96_0.helpers:contains(arg_96_2.options, "Enable defensive") and (var_96_17 ~= 1 or true) then
			if arg_96_2.defensive_yaw_mode == "Jitter" and var_96_17 > 0 then
				local var_96_21 = arg_96_2.defensive_yaw_jitter_radius_1
				local var_96_22 = arg_96_2.defensive_yaw_jitter_delay * 3
				local var_96_23 = arg_96_2.defensive_yaw_jitter_random

				if var_96_22 == 1 then
					arg_96_0.JITTER = arg_96_0.JITTER == -1 and 1 or -1
				else
					arg_96_0.JITTER = var_96_22 >= globals.tickcount() % var_96_22 * 2 + 1 and -1 or 1
				end

				var_96_13 = arg_96_0.JITTER * var_96_21 + math.random(-var_96_23, var_96_23)
			elseif arg_96_2.defensive_yaw_mode == "Custom spin" and var_96_17 > 0 then
				arg_96_0.SPIN3 = arg_96_0.SPIN3 + 8 * (arg_96_2.defensive_yaw_speedtick / 5)

				if arg_96_0.SPIN3 >= arg_96_2.defensive_yaw_spin_limit then
					arg_96_0.SPIN3 = 0
				end

				var_96_13 = arg_96_0.SPIN3
			elseif arg_96_2.defensive_yaw_mode == "Custom ways" and var_96_17 > 0 then
				var_96_13 = math.abs(var_96_13) + var_96_17 * (arg_96_2.defensive_yaw_3way_limit * 20 - math.abs(var_96_13) * 2) / 14
			elseif arg_96_2.defensive_yaw_mode == "Spin-way" and var_96_17 > 0 then
				local var_96_24 = arg_96_2.defensive_yaw_speed_Spin_way
				local var_96_25 = arg_96_2.defensive_yaw_randomizer_Spin_way
				local var_96_26 = arg_96_2.defensive_yaw_1_Spin_way
				local var_96_27 = arg_96_2.defensive_yaw_2_Spin_way

				if var_96_20 >= 29 + math.random(0, var_96_24) then
					arg_96_0.sise_180 = arg_96_0.sise_180 + 1
					arg_96_0.ran3 = math.random(-var_96_25, var_96_25)
				end

				if arg_96_0.sise_180 == 0 then
					arg_96_0.side_180 = var_96_26 + arg_96_0.ran3
				elseif arg_96_0.sise_180 == 1 then
					arg_96_0.side_180 = var_96_27 + arg_96_0.ran3
				end

				var_96_13 = arg_96_0.helpers:new_anim("Spin-way_antiaim", arg_96_0.side_180, 6)

				if arg_96_0.sise_180 == 2 then
					arg_96_0.sise_180 = 0
				end
			elseif arg_96_2.defensive_yaw_mode == "Switch 5-way" and var_96_17 > 0 then
				if var_96_20 >= 29 + math.random(0, arg_96_2.defensive_yaw_way_delay) then
					arg_96_0.current_way = arg_96_0.current_way + 1
					arg_96_0.ran1 = math.random(-arg_96_2.defensive_yaw_way_randomly_value, arg_96_2.defensive_yaw_way_randomly_value)
				else
					var_96_13 = arg_96_0.last_way

					if arg_96_0.current_way == #var_96_18 then
						arg_96_0.current_way = 0
					end
				end

				if arg_96_0.current_way >= 0 and arg_96_0.current_way < #var_96_18 then
					local var_96_28 = var_96_18[arg_96_0.current_way + 1]

					arg_96_0.spin_way = arg_96_0.spin_way + 8 * (var_96_28.speed / 5)

					if arg_96_0.spin_way >= var_96_28.spin_limit then
						arg_96_0.spin_way = 0
					end

					if not var_96_28.enable_spin then
						if arg_96_2.defensive_yaw_way_randomly then
							var_96_13 = var_96_28.switch_value + arg_96_0.ran1
							arg_96_0.last_way = var_96_28.switch_value + arg_96_0.ran1
						else
							var_96_13 = var_96_28.switch_value
							arg_96_0.last_way = var_96_28.switch_value
						end
					else
						var_96_13 = arg_96_0.spin_way
						arg_96_0.last_way = arg_96_0.spin_way
					end
				elseif arg_96_0.current_way == #var_96_18 then
					arg_96_0.current_way = 0
				end
			end

			if arg_96_2.defensive_pitch_mode == "Static" and var_96_17 > 0 then
				var_96_7 = arg_96_2.defensive_pitch_custom
			elseif arg_96_2.defensive_pitch_mode == "Jitter" and var_96_17 > 0 then
				if math.random(0, 20) >= 10 then
					var_96_7 = arg_96_2.defensive_pitch_clock
				else
					var_96_7 = arg_96_2.defensive_pitch_custom
				end
			elseif arg_96_2.defensive_pitch_mode == "Spin" and var_96_17 > 0 then
				if arg_96_2.defensive_pitch_custom < 0 then
					arg_96_0.SPIN2 = arg_96_0.SPIN2 - arg_96_2.defensive_pitch_speedtick / 5
				else
					arg_96_0.SPIN2 = arg_96_0.SPIN2 + arg_96_2.defensive_pitch_speedtick / 5
				end

				if arg_96_2.defensive_pitch_custom < 0 then
					if arg_96_0.SPIN2 <= arg_96_2.defensive_pitch_custom then
						arg_96_0.SPIN2 = arg_96_2.defensive_pitch_spin_limit2
					end
				elseif arg_96_0.SPIN2 >= arg_96_2.defensive_pitch_custom then
					arg_96_0.SPIN2 = arg_96_2.defensive_pitch_spin_limit2
				end

				var_96_7 = arg_96_0.SPIN2
			elseif arg_96_2.defensive_pitch_mode == "Clocking" and var_96_17 > 0 then
				if var_96_20 >= 28 then
					arg_96_0.spin_yaw = arg_96_0.spin_yaw + 15
				end

				if arg_96_0.spin_yaw >= 89 then
					arg_96_0.spin_yaw = -89
				end

				var_96_7 = arg_96_0.spin_yaw
			elseif arg_96_2.defensive_pitch_mode == "Random" and var_96_17 > 0 then
				local var_96_29 = arg_96_2.defensive_pitch_custom
				local var_96_30 = arg_96_2.defensive_pitch_spin_random2

				var_96_7 = math.random(var_96_29, var_96_30)
			elseif arg_96_2.defensive_pitch_mode == "5way" and var_96_17 > 0 then
				if var_96_20 >= 29 + math.random(0, arg_96_2.defensive_yaw_way_delay) then
					arg_96_0.ran2 = math.random(-arg_96_2.defensive_pitch_way_randomly_value, arg_96_2.defensive_pitch_way_randomly_value)
				else
					var_96_7 = arg_96_0.last_way
				end

				if arg_96_0.current_way >= 0 and arg_96_0.current_way < #var_96_19 then
					local var_96_31 = var_96_19[arg_96_0.current_way + 1]

					if var_96_31.spin_limit2 < 0 then
						arg_96_0.spin_pitch = arg_96_0.spin_pitch - 8 * (var_96_31.speed / 5)
					else
						arg_96_0.spin_pitch = arg_96_0.spin_pitch + 8 * (var_96_31.speed / 5)
					end

					if var_96_31.spin_limit2 < 0 then
						if arg_96_0.spin_pitch <= var_96_31.spin_limit2 then
							arg_96_0.spin_pitch = var_96_31.spin_limit1
						end
					elseif arg_96_0.spin_pitch >= var_96_31.spin_limit2 then
						arg_96_0.spin_pitch = var_96_31.spin_limit1
					end

					if not var_96_31.enable_spin then
						if arg_96_2.defensive_pitch_way_randomly then
							var_96_7 = arg_96_0.ran2
							arg_96_0.last_way = arg_96_0.ran2
						else
							var_96_7 = var_96_31.switch_value
							arg_96_0.last_way = var_96_31.switch_value
						end
					else
						var_96_7 = arg_96_0.spin_pitch
						arg_96_0.last_way = arg_96_0.spin_pitch
					end
				end
			end
		end

		if arg_96_2.desync_mode == "Default" then
			ui.set(arg_96_0.ref.aa.enabled[1], true)
			ui.set(arg_96_0.ref.aa.pitch[1], var_96_7 == "default" and var_96_7 or "custom")
			ui.set(arg_96_0.ref.aa.pitch[2], type(var_96_7) == "number" and var_96_7 or 0)
			ui.set(arg_96_0.ref.aa.yaw_base[1], arg_96_2.yaw_base)
			ui.set(arg_96_0.ref.aa.yaw[1], 180)
			ui.set(arg_96_0.ref.aa.yaw[2], arg_96_0.helpers:normalize(var_96_13))
			ui.set(arg_96_0.ref.aa.yaw_jitter[1], "off")
			ui.set(arg_96_0.ref.aa.yaw_jitter[2], 0)
			ui.set(arg_96_0.ref.aa.body_yaw[1], var_96_6)
			ui.set(arg_96_0.ref.aa.body_yaw[2], var_96_5 == 2 and 0 or var_96_5 == 1 and 90 or -90)
		elseif arg_96_2.desync_mode == "Extended" then
			local var_96_32 = arg_96_0.fakelag:run(arg_96_1)

			if var_96_7 == "default" then
				var_96_7 = nil
			end

			arg_96_0.desync:run(arg_96_1, var_96_32, {
				pitch = var_96_7,
				base = arg_96_2.yaw_base,
				side = var_96_5,
				offset = var_96_13
			})
		end

		if globals.chokedcommands() == 0 then
			if arg_96_0.cycle >= var_96_1[arg_96_2.jitter_delay] then
				arg_96_0.cycle = 1
			else
				arg_96_0.cycle = arg_96_0.cycle + 1
			end
		end
	end
}):struct("defensive")({
	check = 0,
	ticks = 0,
	defensive = 0,
	active_until = 0,
	active = false,
	sim_time = globals.tickcount(),
	defensive_active = function(arg_97_0)
		local var_97_0 = entity.get_local_player()

		if not var_97_0 or not entity.is_alive(var_97_0) then
			return
		end

		local var_97_1 = globals.tickcount()
		local var_97_2 = entity.get_prop(var_97_0, "m_flSimulationTime")
		local var_97_3 = toticks(var_97_2 - arg_97_0.sim_time)

		if var_97_3 < 0 then
			arg_97_0.active_until = var_97_1 + math.abs(var_97_3)
		end

		arg_97_0.ticks = arg_97_0.helpers:clamp(arg_97_0.active_until - var_97_1, 0, 16)
		arg_97_0.active = var_97_1 < arg_97_0.active_until
		arg_97_0.sim_time = var_97_2
	end,
	defensive_setup = function(arg_98_0)
		local var_98_0 = entity.get_prop(entity.get_local_player(), "m_nTickBase")

		arg_98_0.defensive = math.abs(var_98_0 - arg_98_0.check)
		arg_98_0.check = math.max(var_98_0, arg_98_0.check or 0)
	end,
	def_reset = function(arg_99_0)
		arg_99_0.check, arg_99_0.defensive = 0, 0
	end
}):struct("tools")({
	draw = false,
	scoped_comp = 0,
	view_x = 1,
	scoped = 0,
	scoped_check = false,
	view_z = -1,
	view_fov = 60,
	view_y = 1,
	widget_keylist = var_0_8("keylist", 300, 100),
	widget_watermark = var_0_8("watermark", 10, 10),
	menu_setup = function(arg_100_0)
		local var_100_0 = arg_100_0.ui.menu.tools.notify_offset:get()
		local var_100_1, var_100_2, var_100_3, var_100_4 = arg_100_0.ui.menu.global.title_name:get_color()

		var_0_7.color[1] = var_100_1
		var_0_7.color[2] = var_100_2
		var_0_7.color[3] = var_100_3
		var_0_7.offset = var_100_0

		if arg_100_0.ui.menu.tools.notify_vibor:get("New style") then
			var_0_7.blured = true
		else
			var_0_7.blured = false
		end

		if not ui.is_menu_open() then
			return
		end

		local var_100_5 = arg_100_0.ui.menu.global.tab:get()
		local var_100_6 = arg_100_0.ui.menu.antiaim.mode:get()
		local var_100_7 = var_100_5 == "antiaim" and var_100_6 == "⚒  Builder" or var_100_5 == "home"
		local var_100_8 = {
			fakelag = arg_100_0.ref.fakelag,
			aa_other = arg_100_0.ref.aa_other
		}

		for iter_100_0, iter_100_1 in pairs(var_100_8) do
			local var_100_9 = true

			if iter_100_0 == "fakelag" then
				var_100_9 = false
			elseif iter_100_0 == "aa_other" then
				var_100_9 = not var_100_7
			end

			for iter_100_2, iter_100_3 in pairs(iter_100_1) do
				for iter_100_4, iter_100_5 in ipairs(iter_100_3) do
					ui.set_visible(iter_100_5, var_100_9)
				end
			end
		end

		if arg_100_0.ref.fakelag.enable[1] ~= true then
			ui.set(arg_100_0.ref.fakelag.enable[1], true)
		end

		ui.set(arg_100_0.ref.fakelag.amount[1], arg_100_0.ui.menu.antiaim.fakelag_type:get())
		ui.set(arg_100_0.ref.fakelag.variance[1], arg_100_0.ui.menu.antiaim.fakelag_var:get())
		ui.set(arg_100_0.ref.fakelag.limit[1], arg_100_0.ui.menu.antiaim.fakelag_lim:get())
	end,
	gs_ind = function(arg_101_0)
		if not arg_101_0.ui.menu.tools.gs_ind:get() then
			return
		end

		if arg_101_0.helpers:contains(arg_101_0.ui.menu.tools.gs_inds:get(), "Target") then
			local var_101_0 = client.current_threat()
			local var_101_1 = "None"
			local var_101_2 = not var_101_0 and "None" or entity.get_player_name(var_101_0)

			renderer.indicator(255, 255, 255, 200, "Target: " .. var_101_2)
		end
	end,
	crosshair = function(arg_102_0)
		local var_102_0 = entity.get_local_player()

		if not var_102_0 or not entity.is_alive(var_102_0) then
			return
		end

		arg_102_0.scoped = entity.get_prop(var_102_0, "m_bIsScoped")
		arg_102_0.scoped_comp = arg_102_0.helpers:math_anim2(arg_102_0.scoped_comp, arg_102_0.scoped * -1, 8)

		local var_102_1 = arg_102_0.helpers:get_state()
		local var_102_2 = {
			client.screen_size()
		}

		arg_102_0.ss = {
			x = var_102_2[1],
			y = var_102_2[2]
		}

		local var_102_3, var_102_4, var_102_5, var_102_6 = arg_102_0.ui.menu.global.title_name:get_color()
		local var_102_7 = arg_102_0.helpers:new_anim("indicator_alpha_general", arg_102_0.ui.menu.tools.indicators:get() and 255 or 0, 16)

		if var_102_7 < 0.1 then
			return
		end

		local var_102_8 = arg_102_0.ui.menu.tools.indicatorfont:get()
		local var_102_9 = 0

		if var_102_8 == "Default" then
			var_102_9 = 1
		elseif var_102_8 == "New" then
			var_102_9 = 2
		elseif var_102_8 == "Normal" then
			var_102_9 = 3
		end

		local var_102_10 = entity.get_prop(var_102_0, "m_flNextAttack")
		local var_102_11 = entity.get_prop(entity.get_player_weapon(var_102_0), "m_flNextPrimaryAttack")
		local var_102_12 = not (math.max(var_102_11, var_102_10) > globals.curtime())
		local var_102_13 = var_102_12 and 255 or var_102_3
		local var_102_14 = var_102_12 and 255 or var_102_4
		local var_102_15 = var_102_12 and 255 or var_102_5
		local var_102_16 = {
			{
				n = "DT",
				c = {
					var_102_13,
					var_102_14,
					var_102_15
				},
				a = ui.get(arg_102_0.ref.rage.dt[1]) and ui.get(arg_102_0.ref.rage.dt[2]) and not ui.get(arg_102_0.ref.rage.fd[1]),
				s = renderer.measure_text("c-", "DT") + 13
			},
			{
				n = "OSAA",
				c = {
					255,
					255,
					255
				},
				a = ui.get(arg_102_0.ref.rage.os[1]) and ui.get(arg_102_0.ref.rage.os[2]) and not ui.get(arg_102_0.ref.rage.fd[1]),
				s = renderer.measure_text("c-", "OSAA") + 15
			},
			{
				n = "FS",
				c = {
					255,
					255,
					255
				},
				a = ui.get(arg_102_0.ref.aa.freestand[1]) and ui.get(arg_102_0.ref.aa.freestand[2]),
				s = renderer.measure_text("c-", "FS") + 15
			}
		}
		local var_102_17 = arg_102_0.helpers:new_anim("indicator_pose", arg_102_0.ui.menu.tools.indicatoroffset:get(), 16)
		local var_102_18 = 0

		if var_102_9 == 1 then
			local var_102_19 = arg_102_0.helpers:new_anim("indicator_alpha", var_102_7, 16)
			local var_102_20 = arg_102_0.helpers:animate_text(globals.curtime() * 2, "onesense", var_102_3, var_102_4, var_102_5, var_102_19)
			local var_102_21 = renderer.measure_text("c-", var_0_13.build:upper())

			renderer.text(arg_102_0.ss.x / 2 + (var_102_21 + 14) / 2 * arg_102_0.scoped_comp, arg_102_0.ss.y / 2 + var_102_17 - 10, var_102_3, var_102_4, var_102_5, var_102_19, "c-", 0, var_0_13.build:upper())
			renderer.text(arg_102_0.ss.x / 2 - 22 + 30 * arg_102_0.scoped_comp, arg_102_0.ss.y / 2 + var_102_17 - 6, 0, 0, 0, var_102_19, "b", 0, unpack(var_102_20))

			local var_102_22 = arg_102_0.helpers:new_anim("indicator_mes_1", renderer.measure_text("-", var_102_1:upper()) or 0, 12)

			renderer.text(arg_102_0.ss.x / 2 + (var_102_22 + 14) / 2 * arg_102_0.scoped_comp, arg_102_0.ss.y / 2 + var_102_17 + 13, 255, 255, 255, var_102_19, "c-", 0, var_102_1:upper())

			for iter_102_0, iter_102_1 in ipairs(var_102_16) do
				local var_102_23 = arg_102_0.helpers:new_anim("indicators_alpha" .. iter_102_1.n, iter_102_1.a and var_102_19 or 0, 10)

				var_102_18 = var_102_18 + arg_102_0.helpers:new_anim("indicators_pose_2" .. iter_102_1.n, iter_102_1.a and 10 or 0, 10)

				renderer.text(arg_102_0.ss.x / 2 + iter_102_1.s / 2 * arg_102_0.scoped_comp, arg_102_0.ss.y / 2 + var_102_17 + var_102_18 + 15, iter_102_1.c[1], iter_102_1.c[2], iter_102_1.c[3], var_102_23, "-ca", nil, iter_102_1.n)
			end
		end
	end,
	viewmodel = function(arg_103_0)
		local var_103_0 = entity.get_local_player()
		local var_103_1 = arg_103_0.ui.menu.tools.viewmodel_on:get()
		local var_103_2 = arg_103_0.ui.menu.tools.viewmodel_scope:get()

		if not entity.is_alive(var_103_0) then
			return
		end

		local var_103_3 = entity.get_player_weapon(var_103_0)
		local var_103_4 = entity.get_prop(var_103_3, "m_iItemDefinitionIndex")
		local var_103_5 = var_0_23(var_0_22, var_103_4)

		if var_103_3 == nil then
			return
		end

		var_103_5.hide_vm_scope = not var_103_2

		if not var_103_1 then
			return
		end

		local var_103_6 = arg_103_0.ui.menu.tools.viewmodel_x1:get()
		local var_103_7 = arg_103_0.ui.menu.tools.viewmodel_y1:get()
		local var_103_8 = arg_103_0.ui.menu.tools.viewmodel_z1:get()
		local var_103_9 = arg_103_0.ui.menu.tools.viewmodel_fov1:get()
		local var_103_10 = arg_103_0.ui.menu.tools.viewmodel_x2:get()
		local var_103_11 = arg_103_0.ui.menu.tools.viewmodel_y2:get()
		local var_103_12 = arg_103_0.ui.menu.tools.viewmodel_z2:get()
		local var_103_13 = arg_103_0.ui.menu.tools.viewmodel_fov2:get()

		if arg_103_0.scoped == 1 then
			if arg_103_0.ui.menu.tools.viewmodel_inscope:get() then
				arg_103_0.view_x = var_103_10
				arg_103_0.view_y = var_103_11
				arg_103_0.view_z = var_103_12
				arg_103_0.view_fov = var_103_13
			end
		else
			arg_103_0.view_x = var_103_6
			arg_103_0.view_y = var_103_7
			arg_103_0.view_z = var_103_8
			arg_103_0.view_fov = var_103_9
		end

		client.set_cvar("viewmodel_offset_x", arg_103_0.helpers:new_anim("view_x1", arg_103_0.view_x, 11))
		client.set_cvar("viewmodel_offset_y", arg_103_0.helpers:new_anim("view_y1", arg_103_0.view_y, 11))
		client.set_cvar("viewmodel_offset_z", arg_103_0.helpers:new_anim("view_z1", arg_103_0.view_z, 11))
		client.set_cvar("viewmodel_fov", arg_103_0.helpers:new_anim("view_fov1", arg_103_0.view_fov, 11))
	end,
	manuals = function(arg_104_0)
		local var_104_0, var_104_1 = client.screen_size()
		local var_104_2 = entity.get_local_player()
		local var_104_3 = ""
		local var_104_4 = ""

		if arg_104_0.ui.menu.tools.manuals_style:get() == "Onesense" then
			var_104_3 = "‹"
			var_104_4 = "›"
		elseif arg_104_0.ui.menu.tools.manuals_style:get() == "New" then
			var_104_3 = "«"
			var_104_4 = "»"
		end

		if not entity.is_alive(var_104_2) then
			return
		end

		local var_104_5 = arg_104_0.antiaim:get_manual()
		local var_104_6 = arg_104_0.antiaim:get_best_side()
		local var_104_7, var_104_8, var_104_9, var_104_10 = arg_104_0.ui.menu.global.title_name:get_color()
		local var_104_11 = arg_104_0.helpers:new_anim("alpha_manual", arg_104_0.ui.menu.tools.manuals:get() and 255 or 0, 16)

		if var_104_11 < 0.1 then
			return
		end

		local var_104_12 = arg_104_0.helpers:new_anim("alpha_manual_global", arg_104_0.ui.menu.tools.manuals_global:get() and 255 or 0, 16)
		local var_104_13 = arg_104_0.helpers:new_anim("manual_scope", arg_104_0.scoped == 1 and 15 or 0, 8)
		local var_104_14 = arg_104_0.helpers:new_anim("alpha_manual_right", var_104_5 == 90 and 255 or 0, 16)
		local var_104_15 = arg_104_0.helpers:new_anim("alpha_manual_left", var_104_5 == -90 and 255 or 0, 16)
		local var_104_16 = arg_104_0.helpers:new_anim("alpha_manual_right_global", var_104_6 == 0 and 255 or 0, 8)
		local var_104_17 = arg_104_0.helpers:new_anim("alpha_manual_left_global", var_104_6 == 2 and 255 or 0, 8)
		local var_104_18 = arg_104_0.helpers:new_anim("alpha_manual_offset", -arg_104_0.ui.menu.tools.manuals_offset:get() - 25, 12)

		renderer.text(var_104_0 / 2 + var_104_18, var_104_1 / 2 - 16 - var_104_13, var_104_7, var_104_8, var_104_9, var_104_15 * (var_104_11 / 255), "d+", 0, var_104_3)
		renderer.text(var_104_0 / 2 - var_104_18 - 11, var_104_1 / 2 - 16 - var_104_13, var_104_7, var_104_8, var_104_9, var_104_14 * (var_104_11 / 255), "d+", 0, var_104_4)

		if var_104_12 < 0.1 then
			return
		end

		renderer.text(var_104_0 / 2 + var_104_18 + 11, var_104_1 / 2 - 16 - var_104_13, var_104_7, var_104_8, var_104_9, var_104_17 * (var_104_12 / var_104_11), "d+", 0, var_104_3)
		renderer.text(var_104_0 / 2 - var_104_18 - 22, var_104_1 / 2 - 16 - var_104_13, var_104_7, var_104_8, var_104_9, var_104_16 * (var_104_12 / var_104_11), "d+", 0, var_104_4)
	end,
	ind_dmg = function(arg_105_0)
		local var_105_0, var_105_1 = client.screen_size()
		local var_105_2 = entity.get_local_player()

		if not entity.is_alive(var_105_2) then
			return
		end

		local var_105_3, var_105_4, var_105_5, var_105_6 = arg_105_0.ui.menu.tools.indicator_dmg:get_color()
		local var_105_7 = arg_105_0.helpers:new_anim("dmg_indicator_alpha", arg_105_0.ui.menu.tools.indicator_dmg:get() and 255 or 0, 16)

		if var_105_7 < 0.1 then
			return
		end

		local var_105_8 = arg_105_0.ui.menu.tools.indicator_dmg_weapon:get()
		local var_105_9 = math.floor(arg_105_0.helpers:new_anim("dmg_indicator", arg_105_0.helpers:get_damage() + 0.1, 8))
		local var_105_10 = ""

		if arg_105_0.ref.rage.ovr[2] then
			if var_105_8 then
				if ui.get(arg_105_0.ref.rage.ovr[2]) then
					var_105_10 = arg_105_0.helpers:get_damage()
				else
					var_105_10 = ""
				end
			elseif ui.get(arg_105_0.ref.rage.ovr[2]) then
				var_105_10 = var_105_9
			else
				var_105_10 = var_105_9
			end
		end

		renderer.text(var_105_0 / 2 + 5, var_105_1 / 2 - 17, var_105_3, var_105_4, var_105_5, var_105_7, "d", 0, var_105_10 .. "")
	end,
	scopedu = function(arg_106_0)
		if not arg_106_0.ui.menu.tools.animscope:get() then
			return
		end

		local var_106_0 = entity.get_local_player()
		local var_106_1 = arg_106_0.ui.menu.tools.animscope_slider:get()
		local var_106_2 = arg_106_0.ui.menu.tools.animscope_fov_slider:get()

		if entity.get_prop(var_106_0, "m_bIsScoped") == 1 then
			arg_106_0.scoped_check = true
		else
			arg_106_0.scoped_check = false
		end

		local var_106_3 = arg_106_0.helpers:new_anim("animated_scoped2", arg_106_0.scoped_check and var_106_1 or 0, 8)

		if ui.get(arg_106_0.ref.misc.override_zf) > 0 then
			ui.set(arg_106_0.ref.misc.override_zf, 0)
		end

		ui.set(arg_106_0.ref.misc.fov, var_106_2 - var_106_3)
	end,
	watermark = function(arg_107_0)
		local var_107_0, var_107_1 = client.screen_size()
		local var_107_2, var_107_3, var_107_4, var_107_5 = arg_107_0.ui.menu.global.title_name:get_color()
		local var_107_6, var_107_7 = arg_107_0.widget_watermark:get(65, 10)
		local var_107_8 = arg_107_0.helpers:new_anim("alpha_watermark", arg_107_0.ui.menu.tools.watermark:get() and 255 or 0, 32)

		if var_107_8 < 0.1 then
			return
		end

		local var_107_9 = 5 + var_107_2 / 5
		local var_107_10 = 6 + var_107_3 / 5
		local var_107_11 = 8 + var_107_4 / 5
		local var_107_12 = arg_107_0.helpers:new_anim("alpha_watermark_160", arg_107_0.ui.menu.tools.watermark:get() and 160 or 0, 32)
		local var_107_13 = var_0_13.name
		local var_107_14, var_107_15 = client.system_time()
		local var_107_16 = string.format("%02d:%02d", var_107_14, var_107_15)
		local var_107_17 = renderer.measure_text("ca", var_0_13.build)
		local var_107_18 = renderer.measure_text("ca", var_107_13)
		local var_107_19 = renderer.measure_text("ca", var_107_16)
		local var_107_20 = 38
		local var_107_21 = math.floor(client.latency() * 1000)
		local var_107_22 = renderer.measure_text("ca", var_107_21)
		local var_107_23 = 125 + var_107_18

		arg_107_0.helpers:rounded_side_v(var_107_6 - 60, var_107_7 - 5, 100 + (var_107_17 - var_107_20), 25, var_107_9, var_107_10, var_107_11, var_107_12, 6, true, true)
		arg_107_0.helpers:rounded_side_v(var_107_6 + (var_107_17 - var_107_20) + 51, var_107_7 - 5, var_107_23 + (var_107_22 - 8), 25, var_107_9, var_107_10, var_107_11, var_107_12, 6, true, true)
		renderer.text(var_107_6 + (var_107_17 - var_107_20) + 144 + var_107_18 + var_107_19 / 2 + (var_107_22 - 8), var_107_7 + 7, 255, 255, 255, var_107_8, "ca", nil, var_107_16)
		renderer.text(var_107_6 + (var_107_17 - var_107_20) + 135 + var_107_18 + (var_107_22 - 8), var_107_7 + 7, var_107_2, var_107_3, var_107_4, var_107_8, "bca", nil, "•")
		renderer.text(var_107_6 + (var_107_17 - var_107_20) + 105 + var_107_18 + var_107_22 / 2, var_107_7 + 7, 255, 255, 255, var_107_8, "ca", nil, var_107_21 .. " ping")
		renderer.text(var_107_6 + (var_107_17 - var_107_20) + 84 + var_107_18, var_107_7 + 7, var_107_2, var_107_3, var_107_4, var_107_8, "bca", nil, "•")
		renderer.text(var_107_6 + (var_107_17 - var_107_20) + 75 + var_107_18 / 2, var_107_7 + 7, 255, 255, 255, var_107_8, "ca", nil, var_107_13)
		renderer.text(var_107_6 + (var_107_17 - var_107_20) + 65, var_107_7 + 7, var_107_2, var_107_3, var_107_4, var_107_8, "bca", nil, "•")
		renderer.text(var_107_6 - 30, var_107_7 + 7, 255, 255, 255, var_107_8, "ca", nil, "onesense")
		renderer.text(var_107_6 + var_107_17 / 2, var_107_7 + 7, var_107_2, var_107_3, var_107_4, var_107_8, "ca", nil, var_0_13.build)
		arg_107_0.widget_watermark:drag(var_107_23 + 126, 35)
	end,
	keylist = function(arg_108_0)
		local var_108_0, var_108_1 = client.screen_size()
		local var_108_2, var_108_3, var_108_4, var_108_5 = arg_108_0.ui.menu.global.title_name:get_color()
		local var_108_6 = 5 + var_108_2 / 5
		local var_108_7 = 6 + var_108_3 / 5
		local var_108_8 = 8 + var_108_4 / 5
		local var_108_9 = arg_108_0.helpers:new_anim("alpha_keybinds", arg_108_0.ui.menu.tools.keylist:get() and arg_108_0.draw and 160 or 0, 16)
		local var_108_10 = 95

		if not ui.is_menu_open() and not ui.get(arg_108_0.ref.rage.dt[2]) and not ui.get(arg_108_0.ref.rage.os[2]) and not ui.get(arg_108_0.ref.rage.ovr[2]) and not ui.get(arg_108_0.ref.aa.freestand[1]) and not ui.get(arg_108_0.ref.slow_motion[2]) and not ui.get(arg_108_0.ref.rage.fd[1]) then
			arg_108_0.draw = false
		else
			arg_108_0.draw = true
		end

		if var_108_9 < 0.1 then
			return
		end

		local var_108_11, var_108_12 = arg_108_0.widget_keylist:get(25, 10)

		arg_108_0.helpers:rounded_side_v(var_108_11 - 20, var_108_12 - 5, var_108_10, 25, var_108_6, var_108_7, var_108_8, var_108_9, 6, true, true)
		renderer.line(var_108_11 + 10, var_108_12, var_108_11 + 9, var_108_12 + 15, 255, 255, 255, 55 * (var_108_9 / 160))
		renderer.texture(arg_108_0.globals.keylist_icon, var_108_11 - 14, var_108_12, 15, 15, 255, 255, 255, 255 * (var_108_9 / 160))
		renderer.text(var_108_11 + 35, var_108_12 + 7, 255, 255, 255, 255 * (var_108_9 / 160), "ca", nil, "Keylist")

		local var_108_13 = 0
		local var_108_14 = {
			{
				n = "Double Tap",
				c = {
					255,
					255,
					255
				},
				a = ui.get(arg_108_0.ref.rage.dt[1]) and ui.get(arg_108_0.ref.rage.dt[2]) and not ui.get(arg_108_0.ref.rage.fd[1]),
				s = renderer.measure_text("c", "Double tap")
			},
			{
				n = "Hide Shots",
				c = {
					255,
					255,
					255
				},
				a = ui.get(arg_108_0.ref.rage.os[1]) and ui.get(arg_108_0.ref.rage.os[2]) and not ui.get(arg_108_0.ref.rage.fd[1]),
				s = renderer.measure_text("c", "Hide shots") + 1
			},
			{
				n = "Fake Duck",
				c = {
					255,
					255,
					255
				},
				a = ui.get(arg_108_0.ref.rage.fd[1]),
				s = renderer.measure_text("c", "Fake duck") + 3
			},
			{
				n = "Min. Damage",
				c = {
					255,
					255,
					255
				},
				a = ui.get(arg_108_0.ref.rage.ovr[1]) and ui.get(arg_108_0.ref.rage.ovr[2]),
				s = renderer.measure_text("c", "Min dmg") + 16
			},
			{
				n = "Edge yaw",
				c = {
					255,
					255,
					255
				},
				a = ui.get(arg_108_0.ref.aa.edge_yaw[1]) and arg_108_0.ui.menu.antiaim.edge_yaw:get_hotkey(),
				s = renderer.measure_text("c", "Edge yaw") + 3
			},
			{
				n = "Freestand",
				c = {
					255,
					255,
					255
				},
				a = ui.get(arg_108_0.ref.aa.freestand[1]) and ui.get(arg_108_0.ref.aa.freestand[2]),
				s = renderer.measure_text("c", "Freestand") + 3
			}
		}

		for iter_108_0, iter_108_1 in ipairs(var_108_14) do
			local var_108_15 = arg_108_0.helpers:new_anim("alpha_rect_keybinds" .. iter_108_1.n, iter_108_1.a and 130 or 0, 18)
			local var_108_16 = arg_108_0.helpers:new_anim("alpha_text_keybinds" .. iter_108_1.n, iter_108_1.a and 255 or 0, 18)
			local var_108_17 = renderer.measure_text("ca", ui.get(arg_108_0.ref.rage.ovr[3])) - 12

			var_108_13 = var_108_13 + arg_108_0.helpers:new_anim("move_keybinds" .. iter_108_1.n, iter_108_1.a and 20 or 0, 15)

			arg_108_0.helpers:rounded_side_v(var_108_11 - 20, var_108_12 + 3 + var_108_13, var_108_10, 18, var_108_6, var_108_7, var_108_8, var_108_15 * (var_108_9 / 160), 6, true, true)

			if iter_108_1.n == "Min. Damage" then
				renderer.text(var_108_11 + (var_108_10 - 27) - var_108_17 / 2, var_108_12 + 11 + var_108_13, var_108_2, var_108_3, var_108_4, var_108_16 * (var_108_9 / 160), "ca", nil, ui.get(arg_108_0.ref.rage.ovr[3]))
			else
				renderer.text(var_108_11 + (var_108_10 - 27), var_108_12 + 11 + var_108_13, var_108_2, var_108_3, var_108_4, var_108_16 * (var_108_9 / 160), "ca", nil, "on")
			end

			renderer.text(var_108_11 - 40 + iter_108_1.s, var_108_12 + 11 + var_108_13, iter_108_1.c[1], iter_108_1.c[2], iter_108_1.c[3], var_108_16 * (var_108_9 / 160), "ca", nil, iter_108_1.n)
		end

		arg_108_0.widget_keylist:drag(var_108_10 + 16, 35)
	end
}):struct("round_reset")({
	auto_buy = function(arg_109_0)
		arg_109_0.defensive:def_reset()
		var_0_10.create_new({
			{
				"Round started, "
			},
			{
				"defensive data ",
				true
			},
			{
				"restored"
			}
		})

		if not arg_109_0.ui.menu.tools.autobuy:get() then
			return
		end

		if arg_109_0.ui.menu.tools.autobuy_v:get() == "Awp" then
			client.exec("buy awp")
		elseif arg_109_0.ui.menu.tools.autobuy_v:get() == "Scar/g3sg1" then
			if team == "t" then
				client.exec("buy g3sg1")
			else
				client.exec("buy scar20")
			end
		elseif arg_109_0.ui.menu.tools.autobuy_v:get() == "Scout" then
			client.exec("buy ssg08")
		end
	end
}):struct("misc")({
	a1312 = 1,
	clantag_time = 0,
	clantag_direction = 1,
	table_clantag = {
		"",
		"o",
		"on",
		"one",
		"ones",
		"onese",
		"onesen",
		"onesens",
		"onesense",
		"onesense",
		"onesense",
		"onesens",
		"onesen",
		"onese",
		"ones",
		"one",
		"on",
		"o",
		""
	},
	adaptive_hitchance = function(arg_110_0, arg_110_1)
		if not arg_110_0.ui.menu.tools.adaptive_hit:get() then
			return
		end

		local var_110_0 = entity.get_local_player()
		local var_110_1 = 0

		if not var_110_0 or not entity.is_alive(var_110_0) then
			return
		end

		local var_110_2 = arg_110_0.ui.menu.tools.adaptive_hit_distance:get()
		local var_110_3 = bit.band(entity.get_prop(entity.get_player_weapon(var_110_0), "m_iItemDefinitionIndex"), 65535)
		local var_110_4 = entity.get_prop(var_110_0, "m_fFlags")
		local var_110_5 = entity.get_players(true)

		for iter_110_0 = 1, #var_110_5 do
			if var_110_5 == nil then
				return
			end

			local var_110_6, var_110_7, var_110_8 = entity.get_prop(var_110_0, "m_vecOrigin")
			local var_110_9, var_110_10, var_110_11 = entity.get_prop(var_110_5[iter_110_0], "m_vecOrigin")

			if var_110_2 > arg_110_0.helpers:distance(var_110_6, var_110_7, var_110_8, var_110_9, var_110_10, var_110_11) / 11.91 and var_110_3 == 40 and bit.band(var_110_4, 1) == 0 then
				if arg_110_1.quick_stop then
					if globals.tickcount() - var_110_1 > 3 then
						arg_110_1.in_speed = 1
					end
				else
					var_110_1 = globals.tickcount()
				end
			end
		end
	end,
	clantag = function(arg_111_0)
		if not arg_111_0.ui.menu.tools.clantag:get() then
			client.set_clan_tag("")

			return
		end

		local var_111_0 = globals.curtime()

		if var_111_0 > arg_111_0.clantag_time + 0.3 then
			local var_111_1 = arg_111_0.table_clantag[arg_111_0.a1312]

			client.set_clan_tag(var_111_1)

			arg_111_0.a1312 = arg_111_0.a1312 + arg_111_0.clantag_direction

			if arg_111_0.a1312 == #arg_111_0.table_clantag then
				arg_111_0.clantag_direction = -1
			end

			if arg_111_0.a1312 == 1 then
				arg_111_0.clantag_direction = 1
			end

			arg_111_0.clantag_time = var_111_0
		end
	end,
	chat_spamme = {
		phrases = {
			kill = {
				{
					"УШАСТЫЙ ПИДОРАС ПОЧЕМУ ОПЯТЬ УМЕР?"
				},
				{
					"ОТРАХАННЫЙ БИЧ СНОВА УМЕР"
				},
				{
					"1 раб ебаный"
				},
				{
					"пизда те немощ ебаный"
				},
				{
					"ЕБУ ТЯ БОМЖИК НЕ ПУКАЙ"
				},
				{
					"ИДИ КОНФИГ МОЙ КУПИ С ЗЕЛЕННЫМИ ВИЗУАЛКАМИ ФАНАТИК ПОВРОТИКА"
				},
				{
					"СКАЧАЙ УЖЕ ONESENSE BEST LUA А ТО ТЫ УМИРАЕШЬ"
				},
				{
					"ВАНЯ СЕНСИК БУСТИТ, 1 "
				},
				{
					"бомж без onesense еще умеет wasd нажимать(("
				},
				{
					"как ты умер? мисснул в 20 хп xdxdxdxd иди скачай ванька уже"
				},
				{
					"ЛУЧШАЯ ЛУА discord.gg/zUKBpRrSss"
				},
				{
					"БИЧ ТУПОЙ ТВОЯ ЛУА НИЩ, ЛУЧШАЯ ЛУА discord.gg/zUKBpRrSss"
				}
			},
			death = {
				{
					"я те ща вырежу мать, лакерное чудовище"
				},
				{
					"как ты меня убил ты же кроме wasd не умеешь ниче нажимать"
				},
				{
					"НУ ГДЕ ТИМА ЕБАНАЯ, СУКА Я ТВОЮ МАТУХУ СБИЛ ЩА ПИДОРАС"
				},
				{
					"К А К Т Е Б Е В Е З Ё Т Л А К Е Р Н О Е С У Щ Е С Т В О"
				},
				{
					"не знал, что тех кто пиздил отец могут убивать)"
				}
			}
		},
		phrase_count = {
			death = 0,
			kill = 0
		}
	},
	trashtalk = function(arg_112_0, arg_112_1)
		if not arg_112_0.ui.menu.tools.trashtalk:get() then
			return
		end

		local var_112_0 = entity.get_local_player()
		local var_112_1 = client.userid_to_entindex(arg_112_1.userid)
		local var_112_2 = client.userid_to_entindex(arg_112_1.attacker)

		if var_112_0 == nil then
			return
		end

		arg_112_0.chat_spamme.phrase_count.death = arg_112_0.chat_spamme.phrase_count.death + 1

		if arg_112_0.chat_spamme.phrase_count.death > #arg_112_0.chat_spamme.phrases.death then
			arg_112_0.chat_spamme.phrase_count.death = 1
		end

		arg_112_0.chat_spamme.phrase_count.kill = arg_112_0.chat_spamme.phrase_count.kill + 1

		if arg_112_0.chat_spamme.phrase_count.kill > #arg_112_0.chat_spamme.phrases.kill then
			arg_112_0.chat_spamme.phrase_count.kill = 1
		end

		phrase = {
			death = arg_112_0.chat_spamme.phrases.death[arg_112_0.chat_spamme.phrase_count.death],
			kill = arg_112_0.chat_spamme.phrases.kill[arg_112_0.chat_spamme.phrase_count.kill]
		}

		if var_112_2 == var_112_0 and var_112_1 ~= var_112_0 then
			for iter_112_0 = 1, #phrase.kill do
				if arg_112_0.ui.menu.tools.trashtalk_type:get() == "Default type" then
					client.delay_call(2, function()
						client.exec(("say %s"):format(phrase.kill[iter_112_0]))
					end)
				elseif arg_112_0.ui.menu.tools.trashtalk_type:get() == "1 MOD" then
					if arg_112_0.ui.menu.tools.trashtalk_check2:get() then
						client.exec(("say %s, 1"):format(entity.get_player_name(var_112_1)))
					else
						client.exec("say 1")
					end
				elseif arg_112_0.ui.menu.tools.trashtalk_type:get() == "Custom phrase" then
					client.exec("say " .. arg_112_0.ui.menu.tools.trashtalk_custom:get())
				end
			end
		end

		if var_112_2 ~= var_112_0 and var_112_1 == var_112_0 then
			for iter_112_1 = 1, #phrase.death do
				client.delay_call(2, function()
					client.exec(("say %s"):format(phrase.death[iter_112_1]))
				end)
			end
		end
	end
}):struct("logs")({
	shot = 0,
	hitboxes = {
		[0] = "body",
		"head",
		"chest",
		"stomach",
		"left arm",
		"right arm",
		"left leg",
		"right leg",
		"neck",
		"?",
		"gear"
	},
	miss = function(arg_115_0, arg_115_1)
		if not arg_115_0.ui.menu.tools.notify_master:get() then
			return
		end

		local var_115_0 = entity.get_local_player()

		if arg_115_0.ui.menu.tools.notify_vibor:get("Miss") then
			local var_115_1 = entity.get_player_name(arg_115_1.target)
			local var_115_2 = arg_115_0.hitboxes[arg_115_1.hitgroup] or "?"
			local var_115_3 = arg_115_0.helpers:limit_ch(var_115_1, 15, "...")

			var_0_10.create_new({
				{
					"Missed "
				},
				{
					var_115_3,
					true
				},
				{
					"'s in "
				},
				{
					var_115_2,
					true
				},
				{
					" due "
				},
				{
					arg_115_1.reason,
					true
				}
			})
			print(string.format("[onesense] ~ Missed %s in %s due to %s", var_115_1, var_115_2, arg_115_1.reason))
		end
	end,
	hit = function(arg_116_0, arg_116_1)
		if not arg_116_0.ui.menu.tools.notify_master:get() then
			return
		end

		if arg_116_0.ui.menu.tools.notify_vibor:get("Hit") then
			local var_116_0 = entity.get_player_name(arg_116_1.target)
			local var_116_1 = arg_116_0.hitboxes[arg_116_1.hitgroup] or "?"
			local var_116_2 = arg_116_0.helpers:limit_ch(var_116_0, 15, "...")

			var_0_10.create_new({
				{
					"Hit "
				},
				{
					var_116_2,
					true
				},
				{
					"'s in "
				},
				{
					var_116_1,
					true
				},
				{
					" for "
				},
				{
					arg_116_1.damage,
					true
				}
			})
			print(string.format("[onesense] ~ Hit %s in %s for %s", var_116_0, var_116_1, arg_116_1.damage))
		end
	end,
	get_desync = function(arg_117_0)
		if math.random(-10, 10) > 0 then
			return "availability"
		else
			return "outdated"
		end
	end,
	evade = function(arg_118_0, arg_118_1)
		if not arg_118_0.ui.menu.tools.notify_master:get() then
			return
		end

		local var_118_0 = entity.get_local_player()

		if var_118_0 == nil then
			return
		end

		local var_118_1 = client.userid_to_entindex(arg_118_1.userid)
		local var_118_2 = entity.get_player_name(var_118_1)

		if var_118_1 == entity.get_local_player() or not entity.is_enemy(var_118_1) or not entity.is_alive(var_118_0) then
			return nil
		end

		if arg_118_0.helpers:fired_shot(var_118_0, var_118_1, {
			arg_118_1.x,
			arg_118_1.y,
			arg_118_1.z
		}) and arg_118_0.shot ~= globals.tickcount() then
			if arg_118_0.ui.menu.tools.notify_vibor:get("Detect shot") then
				print(string.format("[onesense] ~ Dedected %s shot", var_118_2))
				var_0_10.create_new({
					{
						"Detected "
					},
					{
						var_118_2,
						true
					},
					{
						"'s shot, "
					},
					{
						"desync is " .. arg_118_0:get_desync(),
						true
					}
				})
			end

			arg_118_0.shot = globals.tickcount()
		end
	end,
	harmed = function(arg_119_0, arg_119_1)
		if not arg_119_0.ui.menu.tools.notify_master:get() then
			return
		end

		local var_119_0 = entity.get_local_player()
		local var_119_1 = client.userid_to_entindex(arg_119_1.attacker)
		local var_119_2 = client.userid_to_entindex(arg_119_1.userid)
		local var_119_3 = arg_119_1.dmg_health
		local var_119_4 = entity.get_player_name(var_119_1)
		local var_119_5 = arg_119_0.hitboxes[arg_119_1.hitgroup]

		if var_119_1 == var_119_0 then
			return
		end

		if var_119_2 ~= var_119_0 then
			return
		end

		if arg_119_0.ui.menu.tools.notify_vibor:get("Get harmed") then
			var_0_10.create_new({
				{
					"Get " .. var_119_3 .. " damage by "
				},
				{
					var_119_4 .. "'s in " .. var_119_5,
					true
				}
			})
		end
	end
}):struct("unloads")({
	setup = function(arg_120_0)
		local var_120_0 = arg_120_0.ui.menu.tools.animscope:get()
		local var_120_1 = arg_120_0.ui.menu.tools.animscope_fov_slider:get()

		if var_120_0 then
			ui.set(arg_120_0.ref.misc.fov, var_120_1)
		end
	end
})

for iter_0_0, iter_0_1 in ipairs({
	{
		"load",
		function()
			var_0_24.ui:execute()
			var_0_24.config:setup()
		end
	},
	{
		"aim_miss",
		function(arg_122_0)
			var_0_24.logs:miss(arg_122_0)
		end
	},
	{
		"aim_hit",
		function(arg_123_0)
			var_0_24.logs:hit(arg_123_0)
		end
	},
	{
		"bullet_impact",
		function(arg_124_0)
			var_0_24.logs:evade(arg_124_0)
		end
	},
	{
		"player_death",
		function(arg_125_0)
			var_0_24.misc:trashtalk(arg_125_0)
		end
	},
	{
		"player_hurt",
		function(arg_126_0)
			var_0_24.logs:harmed(arg_126_0)
		end
	},
	{
		"setup_command",
		function(arg_127_0)
			var_0_24.misc:adaptive_hitchance(arg_127_0)
			var_0_24.antiaim:run(arg_127_0)
		end
	},
	{
		"shutdown",
		function(arg_128_0)
			var_0_24.ui:shutdown()
			var_0_24.unloads:setup()
		end
	},
	{
		"paint",
		function()
			var_0_24.tools:crosshair()
			var_0_24.tools:manuals()
			var_0_24.tools:ind_dmg()
			var_0_24.tools:viewmodel()
			var_0_24.tools:keylist()
			var_0_24.tools:watermark()
			var_0_24.tools:scopedu()
			var_0_24.tools:gs_ind()
		end
	},
	{
		"paint_ui",
		function()
			var_0_24.helpers:menu_visibility(false)
			var_0_24.misc:clantag()
			var_0_24.tools:menu_setup()
		end
	},
	{
		"pre_render",
		function()
			var_0_24.antiaim:animations()
		end
	},
	{
		"round_prestart",
		function()
			var_0_24.round_reset:auto_buy()
		end
	},
	{
		"predict_command",
		function()
			var_0_24.defensive:defensive_setup()
		end
	},
	{
		"net_update_end",
		function()
			var_0_24.defensive:defensive_active()
		end
	}
}) do
	if iter_0_1[1] == "load" then
		iter_0_1[2]()
	else
		client.set_event_callback(iter_0_1[1], iter_0_1[2])
	end
end

if _DEBUG == true then
	local var_0_25, var_0_26 = collectgarbage("count")

	print("\vonesense ~ [debug]. Memory used:", var_0_25, " KB")
end
