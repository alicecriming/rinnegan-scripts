local var_0_0 = string.char
local var_0_1 = string.byte
local var_0_2 = string.sub
local var_0_3 = (bit32 or bit).bxor
local var_0_4 = table.concat
local var_0_5 = table.insert

local function var_0_6(arg_1_0, arg_1_1)
	local var_1_0 = {}

	for iter_1_0 = 1, #arg_1_0 do
		var_0_5(var_1_0, var_0_0(var_0_3(var_0_1(var_0_2(arg_1_0, iter_1_0, iter_1_0 + 1)), var_0_1(var_0_2(arg_1_1, 1 + iter_1_0 % #arg_1_1, 1 + iter_1_0 % #arg_1_1 + 1))) % 256))
	end

	return var_0_4(var_1_0)
end

local var_0_7 = require(var_0_6("\xC7\xC6\xD81\xE9\xA9", "~\xB1\xA3\xBBE\x86ۧ"))
local var_0_8 = require(var_0_6("$\xCC'\xC0\xEF&\xC39\xC0\xB33\xD8#", "\x9CC\xADJ\xA5"))
local var_0_9 = require(var_0_6("3\xB6D\x13\xAF#H'\xB2\x06\x15\xB0/V6\xB8H\x04\xB8", "&T\xD7)v\xDCF"))
local var_0_10 = require(var_0_6("W\x17/\x17\xEDU\x181\x17\xB1U\x186\x1B\xEAI", "\x9E0vBr"))
local var_0_11 = require(var_0_6("\xAD\"\x19", "\x9B\xCBDpV\x13\xC5"))
local var_0_12 = require(var_0_6("A\xDC;\xF9S}\xEB\xEBC\x924\xFDS}\xB3\xAC", "\x98&\xBDV\x9C \x18\x85"))
local var_0_13 = require(var_0_6("\xF6D\xA8H", "&\x9C7\xC7"))

data = database.read(var_0_6("\xAC\x7F-", "#\xC8\x1D\x1CHs\x14\x9A")) or {}
data.load_count = (data.load_count or 0) + 1

local function var_0_14(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = 0
	local var_2_1
	local var_2_2
	local var_2_3

	while true do
		local var_2_4 = 0

		while true do
			if var_2_4 == 0 then
				if var_2_0 == 0 then
					local var_2_5 = client.create_interface(arg_2_0, arg_2_1) or error(var_0_6("\x10\xB1\xC5ڟ*5\x1A\xBA\x91т8t\x1F\xB0\xC4щvt", "Ty߱\xBF\xEDL") .. arg_2_0 .. " " .. arg_2_1)

					var_2_2 = var_0_11.cast(var_0_6("\xADY\xC0\xA4p\x1Az", "\xA1\xDB6\xA9\xC0Z0P"), var_2_5)
					var_2_0 = 1
				end

				if var_2_0 == 1 then
					local var_2_6 = var_0_11.cast(arg_2_3, var_2_2[0][arg_2_2])

					return function(...)
						return var_2_6(var_2_2, ...)
					end
				end

				break
			end
		end
	end
end

local var_0_15 = {
	[var_0_6("HL\t(vN\t6]", "E)\"`")] = {},
	math_clamp = function(arg_4_0, arg_4_1, arg_4_2)
		return math.min(arg_4_2, math.max(arg_4_1, arg_4_0))
	end
}

function var_0_15.math_lerp(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = var_0_15.math_clamp(0.016, 0, 1)

	if type(arg_5_0) == var_0_6("\xA9\xD0\xD2\x18\x06*\xA8\xC2", "Kܣ\xB7jb") then
		local var_5_1 = 0

		while true do
			if var_5_1 == 3 then
				return color(r, g, b, arg_5_0)
			end

			if var_5_1 == 0 then
				r, g, b, arg_5_0 = arg_5_0.r, arg_5_0.g, arg_5_0.b, arg_5_0.a
				e_r, e_g, e_b, e_a = arg_5_1.r, arg_5_1.g, arg_5_1.b, arg_5_1.a
				var_5_1 = 1
			end

			if var_5_1 == 2 then
				b = var_0_15.math_lerp(b, e_b, var_5_0)
				arg_5_0 = var_0_15.math_lerp(arg_5_0, e_a, var_5_0)
				var_5_1 = 3
			end

			if var_5_1 == 1 then
				r = var_0_15.math_lerp(r, e_r, var_5_0)
				g = var_0_15.math_lerp(g, e_g, var_5_0)
				var_5_1 = 2
			end
		end
	end

	local var_5_2 = (arg_5_1 - arg_5_0) * var_5_0 + arg_5_0

	if arg_5_1 == 0 and var_5_2 < 0.01 and var_5_2 > -0.01 then
		var_5_2 = 0
	elseif arg_5_1 == 1 and var_5_2 < 1.009999999999991 and var_5_2 > 0.99 then
		var_5_2 = 1
	end

	return var_5_2
end

function var_0_15.vector_lerp(arg_6_0, arg_6_1, arg_6_2)
	return arg_6_0 + (arg_6_1 - arg_6_0) * arg_6_2
end

function var_0_15.anim_new(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = 0

	while true do
		if var_7_0 == 3 then
			return lerp
		end

		if var_7_0 == 2 then
			lerp = var_0_15.math_lerp(var_0_15.anim_list[arg_7_0].number, arg_7_1, arg_7_3)
			var_0_15.anim_list[arg_7_0].number = lerp
			var_7_0 = 3
		end

		if var_7_0 == 0 then
			if not var_0_15.anim_list[arg_7_0] then
				local var_7_1 = 0

				while true do
					if var_7_1 == 0 then
						var_0_15.anim_list[arg_7_0] = {}
						var_0_15.anim_list[arg_7_0].color = 0, 0, 0, 0
						var_7_1 = 1
					end

					if var_7_1 == 1 then
						var_0_15.anim_list[arg_7_0].number = 0
						var_0_15.anim_list[arg_7_0].call_frame = true

						break
					end
				end
			end

			if arg_7_2 == nil then
				var_0_15.anim_list[arg_7_0].call_frame = true
			end

			var_7_0 = 1
		end

		if var_7_0 == 1 then
			if arg_7_3 == nil then
				arg_7_3 = 0.1
			end

			if type(arg_7_1) == var_0_6("\x17\xA9\x8E%\xDD\x03\xAE\x8A", "\xB9b\xDA\xEBW") then
				local var_7_2 = 0

				while true do
					if var_7_2 == 1 then
						return lerp
					end

					if var_7_2 == 0 then
						lerp = var_0_15.math_lerp(var_0_15.anim_list[arg_7_0].color, arg_7_1, arg_7_3)
						var_0_15.anim_list[arg_7_0].color = lerp
						var_7_2 = 1
					end
				end
			end

			var_7_0 = 2
		end
	end
end

function countLetters(arg_8_0)
	local var_8_0 = 0

	while true do
		local var_8_1 = 0

		while true do
			if var_8_1 == 0 then
				if var_8_0 == 1 then
					return count
				end

				if var_8_0 == 0 then
					count = 0

					for iter_8_0 = 1, #arg_8_0 do
						local var_8_2 = 0

						while true do
							if var_8_2 == 0 then
								char = arg_8_0:sub(iter_8_0, iter_8_0)

								if char:match(var_0_6("\x8E=", "ʫ\\G\x86\xBE")) or char == " " then
									count = count + 1
								end

								break
							end
						end
					end

					var_8_0 = 1
				end

				break
			end
		end
	end
end

local function var_0_16(arg_9_0)
	return math.floor(0.5 + arg_9_0 / globals.tickinterval())
end

local var_0_17 = {
	frames = {
		var_0_6("i\x81l\xC8i\x81l\xC8i", "\xE8I\xA1L"),
		"❀       ",
		"❀K      ",
		"❀Kr     ",
		"❀Kri    ",
		"❀Krim   ",
		"❀Krim❀  ",
		"  Krim❀  ",
		"   rim❀  ",
		"    im❀  ",
		"     m❀  ",
		"      ❀  ",
		var_0_6("\xFB\x99\x02\x1D^\xFB\x99\x02\x1D", "~۹\"=")
	}
}

var_0_17.cache = nil

function var_0_17.set(arg_10_0)
	if arg_10_0 ~= var_0_17.cache then
		client.set_clan_tag(arg_10_0 or "")

		var_0_17.cache = arg_10_0
	end
end

function var_0_17.handle()
	local var_11_0 = 0
	local var_11_1

	while true do
		if var_11_0 == 0 then
			local var_11_2 = math.floor(math.fmod((globals.tickcount() + var_0_16(client.latency())) / 16, #var_0_17.frames + 1) + 1)

			var_0_17.set(var_0_17.frames[var_11_2])

			break
		end
	end
end

local var_0_18 = {
	get_client_entity = var_0_14 and var_0_14(var_0_6("\x0F\xC2Wwpc\xBD\xE3\x00\xC2", "\x87l\xAE>\x12\x1E\x17\x93"), var_0_6("\x80\xCA&\xC2\x1D\xA0'\xE2\xB8\xFD#\xDF\x01\x82:Ԣ\xB9z\x98", "\xA7։J\xABx\xCES"), 3, var_0_6("\x9D\xFF;Y\xB2\xEF\xB4\xCF&U\xF1\xB4\x88\xF1>Q\xB2\xEE\xC3\xE6=T\xFC\xED\xC1\xBA~\x1D񩟹", "\xC7\xEB\x90R=\x98")) or nil,
	animstate = {}
}
local var_0_19 = 0
local var_0_20

while true do
	if var_0_19 == 0 then
		var_0_20 = var_0_11.typeof(var_0_6("\x14\x02\xAB>\x04\x02\xF90G\x15\xB1*\x15V\xA9*\x03F\x82{\x1FG\xE1\x16\\V\xBF'\b\x17\xADk\x06\x18\xB0&8\x03\xA9/\x06\x02\xBC\x14\x13\x1F\xB4.\x15M\xF9(\x0F\x17\xABk\x17\x17\xBDz<F\xA1\b:M\xF9-\v\x19\xB8?G\x05\xAD*\x15\x02\xBC/8\x1B\xB6=\x0E\x18\xBE\x14\x13\x1F\xB4.\\V\xBF'\b\x17\xADk\v\x17\xAA?8\x1B\xB6=\x02)\xAD\"\n\x13\xE2k\x04\x1E\xB89G\x06\xB8/U-\xE93VF\x84pG\x10\xB5$\x06\x02\xF9'\x06\x05\xAD\x14\v\x14\xA0\x14\x13\x1F\xB4.\\V\xBA#\x06\x04\xF9;\x06\x12\xEA\x10W\x0E\xE1\x16\\V\xBF'\b\x17\xADk\x15\x03\xB7\x14\x06\x1B\xB6>\t\x02\xE2k\x04\x1E\xB89G\x06\xB8/S-\xE93VF\x84pG\x00\xB6\"\x03\\\xF9.\t\x02\xB0?\x1EM\xF9=\b\x1F\xBDaG\x17\xBA?\x0E\x00\xBC\x14\x10\x13\xB8;\b\x18\xE2k\x11\x19\xB0/MV\xB5*\x14\x02\x86*\x04\x02\xB0=\x02)\xAE.\x06\x06\xB6%\\V\xBF'\b\x17\xADk\v\x17\xAA?8\x15\xB5\"\x02\x18\xAD\x14\x14\x1F\xBD.8\x17\xB7\"\n\x17\xAD\"\b\x18\x86>\x17\x12\xB8?\x02)\xAD\"\n\x13\xE2k\x0E\x18\xADk\v\x17\xAA?8\x15\xB5\"\x02\x18\xAD\x14\x14\x1F\xBD.8\x17\xB7\"\n\x17\xAD\"\b\x18\x86>\x17\x12\xB8?\x02)\xBF9\x06\x1B\xBC(\b\x03\xB7?\\V\xBF'\b\x17\xADk\x02\x0F\xBC\x14\x13\x1F\xB4.\x15M\xF9-\v\x19\xB8?G\x13\xA0.8\x17\xB7,\v\x13\xAA\x14\x1EM\xF9-\v\x19\xB8?G\x13\xA0.8\x17\xB7,\v\x13\xAA\x14\x1FM\xF9-\v\x19\xB8?G\x11\xB6*\v)\xBF.\x02\x02\x862\x06\x01\xE2k\x01\x1A\xB6*\x13V\xBA>\x15\x04\xBC%\x13)\xBF.\x02\x02\x862\x06\x01\xE2k\x01\x1A\xB6*\x13V\xAD$\x15\x05\xB6\x14\x1E\x17\xAEpG\x10\xB5$\x06\x02\xF9'\x06\x05\xAD\x14\n\x19\xAF.8\x0F\xB8<\\V\xBF'\b\x17\xADk\v\x13\xB8%8\x17\xB4$\x12\x18\xADpG\x15\xB1*\x15V\xA9*\x03C\x82{\x1FB\x84pG\x10\xB5$\x06\x02\xF9-\x02\x13\xAD\x14\x04\x0F\xBA'\x02M\xF9-\v\x19\xB8?G\x10\xBC.\x13)\xA0*\x10)\xAB*\x13\x13\xE2k\x04\x1E\xB89G\x06\xB8/Q-\xE93S+\xE2k\x01\x1A\xB6*\x13V\xBD>\x04\x1D\x86*\n\x19\xAC%\x13M\xF9-\v\x19\xB8?G\x1A\xB8%\x03\x1F\xB7,8\x12\xAC(\f)\xB8&\b\x03\xB7?\\V\xBA#\x06\x04\xF9;\x06\x12\xEE\x10W\x0E\xED\x16\\V\xBF'\b\x17\xADk\x04\x03\xAB9\x02\x18\xAD\x14\b\x04\xB0,\x0E\x18\x82x:M\xF9-\v\x19\xB8?G\x1A\xB88\x13)\xB69\x0E\x11\xB0%<E\x84pG\x10\xB5$\x06\x02\xF9=\x02\x1A\xB6(\x0E\x02\xA0\x14\x1FM\xF9-\v\x19\xB8?G\x00\xBC'\b\x15\xB0?\x1E)\xA0pG\x15\xB1*\x15V\xA9*\x03N\x82{\x1FB\x84pG\x10\xB5$\x06\x02\xF9>\t\x1D\xB7$\x10\x18\x86-\v\x19\xB8?VM\xF9(\x0F\x17\xABk\x17\x17\xBDr<F\xA1s:M\xF9-\v\x19\xB8?G\x03\xB7 \t\x19\xAE%8\x10\xB5$\x06\x02\xEBpG\x10\xB5$\x06\x02\xF9>\t\x1D\xB7$\x10\x18\x86-\v\x19\xB8?TM\xF9-\v\x19\xB8?G\x03\xB7 \t\x19\xAE%\\V\xBF'\b\x17\xADk\n)\xAF.\v\x19\xBA\"\x13\x0F\xE2k\x01\x1A\xB6*\x13V\xB3>\n\x06\x86-\x06\x1A\xB5\x14\x11\x13\xB5$\x04\x1F\xAD2\\V\xBF'\b\x17\xADk\x04\x1A\xB8&\x17\x13\xBD\x14\x11\x13\xB5$\x04\x1F\xAD2\\V\xBF'\b\x17\xADk\x01\x13\xBC?8\x05\xA9.\x02\x12\x86-\b\x04\xAE*\x15\x12\xAA\x14\b\x04\x868\x0E\x12\xBC<\x06\x0F\xAApG\x10\xB5$\x06\x02\xF9-\x02\x13\xAD\x14\x14\x06\xBC.\x03)\xAC%\f\x18\xB6<\t)\xBF$\x15\x01\xB89\x03\x05\x86$\x15)\xAA\"\x03\x13\xAE*\x1E\x05\xE2k\x01\x1A\xB6*\x13V\xB5*\x14\x02\x86?\x0E\x1B\xBC\x14\x14\x02\xB89\x13\x13\xBD\x14\n\x19\xAF\"\t\x11\xE2k\x01\x1A\xB6*\x13V\xB5*\x14\x02\x86?\x0E\x1B\xBC\x14\x14\x02\xB6;\x17\x13\xBD\x14\n\x19\xAF\"\t\x11\xE2k\x05\x19\xB6'G\x19\xB7\x14\x00\x04\xB6>\t\x12\xE2k\x05\x19\xB6'G\x1E\xB0?8\x1F\xB7\x14\x00\x04\xB6>\t\x12\x86*\t\x1F\xB4*\x13\x1F\xB6%\\V\xBA#\x06\x04\xF9;\x06\x12\xE8{<F\xA1\x7F:M\xF9-\v\x19\xB8?G\x02\xB0&\x02)\xAA\"\t\x15\xBC\x14\x0E\x18\x86*\x0E\x04\xE2k\x01\x1A\xB6*\x13V\xB5*\x14\x02\x86$\x15\x1F\xBE\"\t)\xA3pG\x10\xB5$\x06\x02\xF9#\x02\x17\xBD\x14\x01\x04\xB6&8\x11\xAB$\x12\x18\xBD\x14\x03\x1F\xAA?\x06\x18\xBA.8\x05\xAD*\t\x12\xB0%\x00M\xF9-\v\x19\xB8?G\x05\xAD$\x17)\xAD$8\x10\xAC'\v)\xAB>\t\x18\xB0%\x00)\xBF9\x06\x15\xAD\"\b\x18\xE2k\x04\x1E\xB89G\x06\xB8/VG\x82{\x1FB\x84pG\x10\xB5$\x06\x02\xF9&\x06\x11\xB0(8\x10\xAB*\x04\x02\xB0$\tM\xF9(\x0F\x17\xABk\x17\x17\xBDzU-\xE93T5\x84pG\x10\xB5$\x06\x02\xF9<\b\x04\xB5/8\x10\xB69\x04\x13\xE2k\x04\x1E\xB89G\x06\xB8/VE\x82{\x1FG\x9A\n:M\xF9-\v\x19\xB8?G\x1B\xB0%8\x0F\xB8<\\V\xBF'\b\x17\xADk\n\x17\xA1\x14\x1E\x17\xAEpG\v\xF9aM", "Kgv\xD9"))
		var_0_18.animstate.offset = 39264
		var_0_19 = 1
	end

	if var_0_19 == 1 then
		function var_0_18.animstate.get(arg_12_0, arg_12_1)
			local var_12_0 = 0
			local var_12_1

			while true do
				local var_12_2 = 0

				while true do
					if var_12_2 == 0 then
						if var_12_0 == 1 then
							if not var_12_1 then
								return
							end

							return var_0_11.cast(var_0_20, var_0_11.cast(var_0_6("\xD2]~\x00\xA9\n\xD5kd", "~\xA74\x10t\xD9"), var_12_1) + arg_12_0.offset)[0]
						end

						if var_12_0 == 0 then
							if not arg_12_1 or not var_0_18.get_client_entity then
								return
							end

							var_12_1 = var_0_18.get_client_entity(arg_12_1)
							var_12_0 = 1
						end

						break
					end
				end
			end
		end

		break
	end
end

var_0_18.animlayers = {}

local var_0_21 = 0

while true do
	if var_0_21 == 1 then
		function var_0_18.animlayers.get(arg_13_0, arg_13_1)
			local var_13_0 = 0
			local var_13_1

			while true do
				if var_13_0 == 0 then
					if not var_0_18.get_client_entity then
						return
					end

					var_13_1 = var_0_18.get_client_entity(arg_13_1)
					var_13_0 = 1
				end

				if var_13_0 == 1 then
					if not var_13_1 then
						return
					end

					return var_0_11.cast(var_0_6("\xA8\xEB\xCF\xFB\xB9\xE7\xD2ɴ\xE8\xC2\xC1\xAA\xD6ώ", "\xA4؉\xBB"), var_0_11.cast(var_0_6("\xC7\xEF?\xA6\xB6\xEA\x19\xED\xF2", "k\xB2\x86Q\xD2ƞ"), var_13_1) + arg_13_0.offset)[0]
				end
			end
		end

		break
	end

	if var_0_21 == 0 then
		if not pcall(var_0_11.typeof, var_0_6("\xCA:\x1F\x81\xBA\x10\xF1\xC4/9\x85\xA6&\xE8", "\x9C\xA8N@\xE0\xD4y")) then
			var_0_11.cdef(var_0_6("m\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xFA\xBC\xDE\x02\xEA\xA0\xC8G\xFD\xB1\xDC\x12\xED\xB1\x8E\x1C\x84\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xA3\xC2\bﱎG\xAE\xA4\xC0\x0E\xE3\x9A\xDA\x0E㠕m\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xE8\xA9\xC1\x06\xFA\xE5\x8EG\xE8\xA4\xCA\x02Ѫ\xDB\x13ѱ\xC7\n\xEB\xFE\xA4G\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8E\x0E౎G\xAE\xE5\x8E\t穕m\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xE7\xAB\xDAG\xAE\xE5\x8EG\xEF\xA6\xDA\x0E\xF8\xB1\xD7\\\x84\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xAC\xC0\x13\xAE\xE5\x8EG\xAE\xB5\xDC\x0E\xE1\xB7\xC7\x13\xF7\xFE\xA4G\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8E\x0E౎G\xAE\xE5\x8E\b\xFC\xA1\xCB\x15\xB5ώG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\xC7\t\xFA\xE5\x8EG\xAE\xE5\xDD\x02\xFF\xB0\xCB\t\xED\xA0\x95m\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xE8\xA9\xC1\x06\xFA\xE5\x8EG\xFE\xB7\xCB\x11Ѧ\xD7\x04⠕m\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xE8\xA9\xC1\x06\xFA\xE5\x8EG\xF9\xA0\xC7\x00汕m\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xE8\xA9\xC1\x06\xFA\xE5\x8EG\xF9\xA0\xC7\x00\xE6\xB1\xF1\x03\xEB\xA9\xDA\x06ѷ\xCF\x13\xEB\xFE\xA4G\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8E\x01\xE2\xAA\xCF\x13\xAE\xE5\x8E\x17\xE2\xA4\xD7\x05\xEF\xA6\xC58\xFC\xA4\xDA\x02\xB5ώG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\xC8\v\xE1\xA4\xDAG\xAE\xE5\xCD\x1E\xED\xA9\xCB\\\x84\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xAC\xC0\x13\xAE\xE5\x8EG\xAE\xAA\xD9\t뷕m\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xE7\xAB\xDAG\xAE\xE5\x8EG\xEC\xAC\xDA\x14\xB5ώG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5\xD3G\xEC\xB1\xF1\x06\xE0\xAC\xC3\v\xEF\xBC\xCB\x15ѱ\x82G\xA4\xB5\xCC\x13Ѥ\xC0\x0E\xE3\xA9\xCF\x1E\xEB\xB7\xF1\x13\xB5ώG\xAE\xE5\x8EG\xAE\xE5\x8EG\xAE\xE5", "\xAEg\x8E\xC5"))
		end

		var_0_18.animlayers.offset = var_0_11.cast(var_0_6("_&Kr", "\x986H?XE>"), var_0_11.cast(var_0_6("\xC1\xCD\xE0H\xC4\xD0\xFCc\xC0", "<\xB4\xA4\x8E"), client.find_signature(var_0_6("[R\f,)\xF9\\\\R\t", "r8>eIG\x8D"), "\x8B\x89\xCC\xCC\xCC̍\f\xD1")) + 2)[0]
		var_0_21 = 1
	end
end

var_0_18.activity = {}

local var_0_22 = 0

while true do
	if var_0_22 == 1 then
		var_0_18.activity.location = var_0_11.cast(var_0_6("\x13$\x8D?K#\x16\x025\xA3-K9*\x14", "IqP\xD2X.W"), client.find_signature(var_0_6("\x82 \xC4\x17\xE9\x95b\xC9\x1E\xEB", "\x87\xE1L\xADr"), "U\x8B\xECS\x8B]\bV\x8B\xF1\x83"))

		function var_0_18.activity.get(arg_14_0, arg_14_1, arg_14_2)
			local var_14_0 = 0
			local var_14_1
			local var_14_2

			while true do
				if var_14_0 == 0 then
					if not var_0_18.get_client_entity then
						return
					end

					var_14_1 = var_0_18.get_client_entity(arg_14_2)
					var_14_0 = 1
				end

				if var_14_0 == 1 then
					if not var_14_1 then
						return
					end

					var_14_2 = var_0_11.cast(var_0_6("\fⱴ\xE6\xF7", "\xC7z\x8D\xD8\xD0\xCC\xDD"), var_0_11.cast(var_0_6("\xB8\xD4\x1E\xE4h\xE2\xBF\xE2\x04", "\x96ͽp\x90\x18"), var_14_1) + arg_14_0.offset)[0]
					var_14_0 = 2
				end

				if var_14_0 == 2 then
					if not var_14_2 then
						return
					end

					return arg_14_0.location(var_14_1, var_14_2, arg_14_1)
				end
			end
		end

		break
	end

	if var_0_22 == 0 then
		if not pcall(var_0_11.typeof, var_0_6(":\x1A\xBD\xC1\xAF,1\x91û-\v\x8Ců", "\xCAXn\xE2\xA6")) then
			var_0_11.cdef(var_0_6("\x83\x1B\x9B\xE7\xCF\xC7\n\x84\xB7\xC3\xCD\x1B\xCA\xC8\xF5\xC5\x0E\x91\xE3\xC9\xC2\x03\x8E\xBD\x8A\xC1\x1B\xBD\xF0\xCF\xD70\x91\xF2\xDB\xD6\n\x8C\xF4ϊG\x94\xF8\xC3\xC7E\xC2\xF2\xC4\xD7\x06\x96\x19\x8D\xFEΉO\x91\xE3\xDF\xC7\x06\x8D\xC8\xC2\xC7\x1Dη\xC3\xCD\x1B\xC2\xE4\xCF\xD2\x1A\x87\xF9\xC9\xC6Fٷ", "\xAA\xA3o\xE2\x97"))
		end

		var_0_18.activity.offset = 10576
		var_0_22 = 1
	end
end

var_0_18.user_input = {}

if not pcall(var_0_11.typeof, var_0_6("'\x90\x80O\x11\x9B\x14\x02&\x89\xBBs\x10", "pE\xE4\xDF,d\xE8q")) then
	var_0_11.cdef(var_0_6("\xBE_G\x93\xF6<Ɣ_G\x93\xF6<Ɣ_Gǯl\x83\xD0\x1A\x01\x93\xA5h\x94\xC1\x1C\x13\x93\xAD\x16Ɣ_G\x93\xF6<Ɣ_G\x93\xF6<Ɣ_G\x93\xF6o\x92\xC6\n\x04\xC7\xF6~\x92\xEB\x1C\x12\xC0\xB3n\x85\xD9\x1B8\xC7\xF64\xCC\xD7\n\x14֤\x7F\x8B\xD0VO\x9A\xED\x16Ɣ_G\x93\xF6<Ɣ_G\x93\xF6<Ɣ_G\x93\xF6u\x88\xC0_G\x93\xF6<\x85\xDB\x12\nҸx\xB9\xDA\n\nѳnݾ_G\x93\xF6<Ɣ_G\x93\xF6<Ɣ_G\x93\xF6<\xC6\xDD\x11\x13\x93\xF6<Ɣ\v\x0EнC\x85\xDB\n\t\xC7\xED\x16Ɣ_G\x93\xF6<Ɣ_G\x93\xF6<Ɣ_G\x93\xF6z\x8A\xDB\x1E\x13\x93\xF6<\x90\xDD\x1A\x10\xE8\xE5Aݾ_G\x93\xF6<Ɣ_G\x93\xF6<Ɣ_G\x93\xF6<\xC6\xD2\x13\bҢ<Ɣ\x1E\x0Eލ/\xBB\x8FuG\x93\xF6<Ɣ_G\x93\xF6<Ɣ_G\x93\xF6<Ɣ\x19\vܷhƔ_\nܠy\xBD\x87\"\\\xB9\xF6<Ɣ_G\x93\xF6<Ɣ_G\x93\xF6<Ɣ_GڸhƔ_G\x93\xB4i\x92\xC0\x10\t\xC0\xED\x16Ɣ_G\x93\xF6<Ɣ_G\x93\xF6<Ɣ\x02GѢC\x85\xC1\f\x02\xC1\xB5q\x82\xEB\v\\\xB9\xF6<Ɣ_G\x93\xF6<Ɣ_", "\xE6\xB4\x7Fg\xB3\xD6\x1C"))
end

if not pcall(var_0_11.typeof, var_0_6("\x8E\x11`A\xE1Uߙ\x16ZT\xE7L\xE4", "\x80\xECe?&\x84!")) then
	var_0_11.cdef(var_0_6("\xEC\xBD\bT\xB3\xEFʪ\xE9\x13P\x89\xE8ڿ\xAC\x03G\xBB\xEF\xF0\xB8\xE3Y{\x89\xFFǥ\xBA\x12E\xBA\xE7\x85\xEC\xAB\x05{\xB1\xEEۓ\xBC\x02A\xA4\xE8¨\xE0YR\xB9\xE2\xCB\xE6\xE9\x18J\xA6\xFE\xDB\xE0\xE9\x18J\xA2\xA7\x8F\xA5\xA7\x05\x04\xB5\xE4¡\xA8\x1F@\x89\xE5ڡ\xAB\x14V\xFF\xB0\x8F", "\xAF\xCC\xC9q$֋"))
end

var_0_18.user_input.vtbl = var_0_11.cast(var_0_6("Q\xC3<\xD8N\r\x86", "d'\xACU\xBC"), var_0_11.cast(var_0_6("\xBBw\xB0\x84y\xE7", "S\xCD\x18\xD9\xE0"), var_0_11.cast(var_0_6("\xF3\xCC\xC3)\xF6\xD1\xDF\x02\xF2", "]\x86\xA5\xAD"), client.find_signature(var_0_6("\xBD\xFE\xC8\xC74\xDA\xFCz\xB2\xFE", "\x1Eޒ\xA1\xA2Z\xAE\xD2"), "\xB9\xCC\xCC\xCC̋@8\xFFЄ\xC0\x0F\x85") or error(var_0_6("\xEC@`\x1F\xF1qc\x03\xE2", "j\x85.\x10"))) + 1)[0])
var_0_18.user_input.location = var_0_11.cast(var_0_6("Z4L\xFB_Tg5`\xF9HCU$", " 8@\x13\x9C:"), var_0_18.user_input.vtbl[0][8])

function var_0_18.user_input.get_command(arg_15_0, arg_15_1)
	return arg_15_0.location(arg_15_0.vtbl, 0, arg_15_1)
end

local var_0_23 = {}
local var_0_24 = 0
local var_0_25
local var_0_26

while true do
	if var_0_24 == 1 then
		var_0_25 = nil

		function var_0_25()
			local var_16_0 = 0
			local var_16_1
			local var_16_2

			while true do
				if var_16_0 == 0 then
					local var_16_3, var_16_4 = pcall(function()
						local var_17_0 = io.open(var_0_6("]W\x19\xC2v\x89\x89\rPQX\xB3\x7F\x95\x88\x05", "k96+\x9D\x15\xE6\xE7"), "r")

						if var_17_0 then
							local var_17_1 = 0
							local var_17_2

							while true do
								if var_17_1 == 1 then
									return var_0_13.parse(var_17_2)
								end

								if var_17_1 == 0 then
									var_17_2 = var_17_0:read(var_0_6("\x91\x8A\x1D\xF9", "\xAF\xBB\xEBq\x95ټ"))

									var_17_0:close()

									var_17_1 = 1
								end
							end
						end

						return nil
					end)
					local var_16_5 = var_16_4

					return var_16_3 and var_16_5 or {}
				end
			end
		end

		var_0_24 = 2
	end

	if var_0_24 == 4 then
		function var_0_23.write(arg_18_0, arg_18_1)
			var_0_23.data[arg_18_0] = arg_18_1

			var_0_26(var_0_23.data)

			return true
		end

		break
	end

	if var_0_24 == 0 then
		var_0_23.name = var_0_6("^ɷiY\xFD\x8E\\\xC1\xE2E", "\xE0:\xA8\x856:\x92")
		var_0_23.data = {}
		var_0_24 = 1
	end

	if var_0_24 == 2 then
		var_0_26 = nil

		function var_0_26(arg_19_0)
			pcall(function()
				local var_20_0 = io.open(var_0_6("8\xAE\xD3s\xE0vv:\xA6\x86_\xADsk3\xA1", "\x18\\\xCF\xE1,\x83\x19"), "w")

				if var_20_0 then
					var_20_0:write(var_0_13.stringify(arg_19_0))
					var_20_0:close()
				end
			end)
		end

		var_0_24 = 3
	end

	if var_0_24 == 3 then
		var_0_23.data = var_0_25()

		function var_0_23.read(arg_21_0)
			return var_0_23.data[arg_21_0]
		end

		var_0_24 = 4
	end
end

local var_0_27 = " /$$   /$$ /$$$$$$$  /$$$$$$ /$$      /$$\n| $$  /$$/| $$__  $$|_  $$_/| $$$    /$$$\n| $$ /$$/ | $$  \\ $$  | $$  | $$$$  /$$$$\n| $$$$$/  | $$$$$$$/  | $$  | $$ $$/$$ $$\n| $$  $$  | $$__  $$  | $$  | $$  $$$| $$\n| $$\\  $$ | $$  \\ $$  | $$  | $$\\  $ | $$\n| $$ \\  $$| $$  | $$ /$$$$$$| $$ \\/  | $$\n|__/  \\__/|__/  |__/|______/|__/     |__/\n\n"
local var_0_28 = {
	[var_0_6("^\xC0\xBD^\x15|F\xD6", "\x1D+\xB3\xD8,{")] = function()
		local var_22_0 = entity.get_local_player()

		return var_22_0 and entity.get_player_name(var_22_0) or var_0_6("\x8D\xD5!U\xB8\xCB", ",ݹ@")
	end,
	[var_0_6("\x17\xE2ZLz\x0E\xE9", "\x13a\x87(?")] = var_0_6("\x8Cy\a\x1A", "Q\xCE<S[O"),
	[var_0_6("L\xAA\xC3w,\xCCA\xAB\\", "\xC4.˰\x12O\xA3-")] = {
		173,
		216,
		230,
		255
	},
	[var_0_6("\xBA#m\x1B'\xF4\xE3\xB70A\x12-\xFC\xE7\xAC", "\x8F\xD8B\x1E~D\x9B")] = {
		200,
		230,
		250,
		255
	}
}
local var_0_29
local var_0_30 = 0
local var_0_31
local var_0_32
local var_0_33
local var_0_34

while true do
	if var_0_30 == 0 then
		var_0_11.cdef(var_0_6("\xC0\x88M\x8B\x85㗡\xEA\xDC\x14\xDB\xC0\xA7\xD2\xE7\xEA\xDB\x19\xD9Рá\xB1\x88\x18\xC2˷\x8F޾\x88\x1F\x90\x85\xB6\xDEﾐ2߅\xA4\x8C\xA1\xBF\xC1\x03ߝ\x9Cá\xA8\x93M\xDḘù\x95\xDCMʞ\xE3ʡ\xA9\xC7\x01\xC4ל\xC4\xF5\xB8\xDD\x0E\xDF\xFA\xB7\x8C\x8B\xEA\x88M\x8B", "\x81ʨm\xAB\xA5÷"))

		var_0_31 = var_0_11.cast(var_0_6("4W>ܔ^\xAC", "\x86B8W\xB8\xBEt"), client.create_interface(var_0_6("*\"\x1D\xBF\x15\xE2#{8=\x05", "U\\Qi\xDBy\x8BA"), var_0_6("˖^Bu\xD1\xF8\x90FDn\x8F\xAD\xE4", "\xBF\x9D\xD30%\x1C")))
		var_0_30 = 1
	end

	if var_0_30 == 1 then
		var_0_32 = var_0_11.cast(var_0_6("\xC9\x10\xFD\x18r\xE0 \xF7\x18?\xDC\x13\xBEUr\xC9\x10\xFD\x18p\x93_\xF7\x134\xCC\v\xB4\x1F5\xD3\x10\xE6#)\xCB\r\xE1\x1F.\xE0\v\xB2Pz\xDC\x10\xFA\x0F.\x9F\x1C\xFC\x1D(\x95S\xB4Rt\x91V", "Z\xBF\x7F\x94|"), var_0_31[0][25])

		function var_0_33(arg_23_0)
			return tonumber(arg_23_0:sub(1, 2), 16), tonumber(arg_23_0:sub(3, 4), 16), tonumber(arg_23_0:sub(5, 6), 16), tonumber(arg_23_0:sub(7, 8), 16)
		end

		var_0_30 = 2
	end

	if var_0_30 == 2 then
		function var_0_34(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
			local var_24_0 = 0
			local var_24_1

			while true do
				if var_24_0 == 0 then
					var_24_1 = var_0_11.new(var_0_6("{\x88\"\x18j\xB8=\x03j\x92-\x03G\x93", "w\x18\xE7N"))
					var_24_1.r, var_24_1.g, var_24_1.b, var_24_1.a = arg_24_1 or 217, arg_24_2 or 217, arg_24_3 or 217, arg_24_4 or 255
					var_24_0 = 1
				end

				if var_24_0 == 1 then
					var_0_32(var_0_31, var_24_1, tostring(arg_24_0))

					break
				end
			end
		end

		function var_0_29(...)
			local var_25_0 = 0

			while true do
				if var_25_0 == 0 then
					for iter_25_0, iter_25_1 in ipairs({
						...
					}) do
						local var_25_1 = 0
						local var_25_2

						while true do
							if var_25_1 == 0 then
								for iter_25_2, iter_25_3 in ("\aD9D9D9" .. iter_25_1):gmatch("\a(%x%x%x%x%x%x)([^\a]*)") do
									var_0_34(iter_25_3, var_0_33(iter_25_2))
								end

								break
							end
						end
					end

					var_0_34("\n")

					break
				end
			end
		end

		break
	end
end

local function var_0_35(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	return bit.tohex(arg_26_0, 2) .. bit.tohex(arg_26_1, 2) .. bit.tohex(arg_26_2, 2) .. bit.tohex(arg_26_3, 2)
end

local function var_0_36(arg_27_0, arg_27_1)
	local var_27_0 = 0
	local var_27_1
	local var_27_2
	local var_27_3
	local var_27_4
	local var_27_5
	local var_27_6

	while true do
		if var_27_0 == 2 then
			return var_27_1
		end

		if var_27_0 == 1 then
			local var_27_7 = 0

			while true do
				if var_27_7 == 0 then
					local var_27_8, var_27_9, var_27_10, var_27_11 = unpack(arg_27_0)

					for iter_27_0 = 1, #arg_27_1 do
						local var_27_12 = 0
						local var_27_13

						while true do
							if var_27_12 == 0 then
								local var_27_14 = var_0_35(var_27_8, var_27_9, var_27_10, var_27_11 * math.abs(1 * math.cos(6 * var_27_2 / 4 + iter_27_0 * 5 / 30)))

								var_27_1 = var_27_1 .. "\a" .. var_27_14 .. arg_27_1:sub(iter_27_0, iter_27_0)

								break
							end
						end
					end

					var_27_7 = 1
				end

				if var_27_7 == 1 then
					var_27_0 = 2

					break
				end
			end
		end

		if var_27_0 == 0 then
			var_27_1 = ""
			var_27_2 = globals.curtime()
			var_27_0 = 1
		end
	end
end

local var_0_37 = {
	"\vGlobal\r",
	"\vStand\r",
	"\vWalking\r",
	"\vRunning\r",
	"\vAir\r",
	"\vAir+\r",
	"\vDuck\r"
}
local var_0_38 = {
	"\vG ·\r",
	"\vS ·\r",
	"\vW ·\r",
	"\vR ·\r",
	"\vA ·\r",
	"\vA+ ·\r",
	"\vD ·\r"
}
local var_0_39 = {
	[var_0_6("\x83#\xB1C\xDDI\x1C", "q\xE2M\xC5*\xBC ")] = {
		[var_0_6(")\x1A\xFB\xA2-\x17\xF8\xBE", "\xD5Zv\x94")] = {
			ui.reference(var_0_6("z\x0F", "-;N\xD46"), var_0_6("?B\x8B\x8E\x94", "\x90p6\xE3\xEB\xE6N\xCD"), var_0_6("\x80$\x00\xEB\x90V\xBC<\x06\xF3\xDE", ";\xD3Ho\x9C\xB0"))
		},
		[var_0_6("K\x89\xE2/B\x82\xE7", "M.\xE7\x83")] = ui.reference(var_0_6("\x9Bu", " \xDA4\xD6"), var_0_6("o\x19%\xA1\xBC\xB1LWL\x18%\xE8\xF0\xBEBVK\x04", ":.wQȑ\xD0%"), var_0_6("\x0E\x821\xAE\xA5\xB82", "VK\xECP\xCC\xC9\xDD")),
		[var_0_6("bHc\x86\xF6", "\xEB\x12!\x17\xE5\x9E")] = {
			ui.reference(var_0_6("q\x9B", "\xDB0ڡ"), var_0_6("\xC5\x7Fh@\x96N\xE9\xE9ss]\x9BN\xEE\xE3}yZ", "\x80\x84\x11\x1C)\xBB/"), var_0_6("1;\x129U", "=aRfZ"))
		},
		[var_0_6("\xB5/\xBCI\xC6D\x1B", "i\xCCN\xCB+\xA77~")] = ui.reference(var_0_6("\x84\x8B", "1\xC5\xCAC~sd\xA7"), var_0_6("\x16U\xCB \xCDWW:Y\xD0=\xC0WP0W\xDA:", ">W;\xBFI\xE06"), var_0_6("\xDE\x03\xED\x89\xE5\x03\xE9\xCC", "\xA9\x87b\x9A")),
		[var_0_6("\xD2v3", "\xA8\xAB\x17D4\x9DS")] = {
			ui.reference(var_0_6("\xD5P", "\xE7\x94\x11\x95\xCDEM"), var_0_6("\xA1\xA9\xD3\xF2\x1A\xFE\x89\xAA\xC5\xF4C\xBF\x81\xA9\xC0\xF7R\xEC", "\x9F\xE0ǧ\x9B7"), var_0_6("\xCE\xF2+", "\xB2\x97\x93\\"))
		},
		[var_0_6("\x8A\xEEN=\x16Uc\x8D\xEA", "\x1A\xEC\x9D,Rr,")] = ui.reference(var_0_6("\v\x0F", ";JN\xB5"), var_0_6("\x04\xDFNS\xFE$\xD8WX\xBC1\x91[T\xB4)\xD4I", "\xD3E\xB1::"), var_0_6("\x91\xF7|\xF0\xFA߶\xEB}\xFC\xE7\xCC\xF7\xE7v\xF1\xF0\x8B\xAE\xE4n", "\xABׅ\x19\x95\x89")),
		[var_0_6("\xE4\xCC5\xFF\xF61\xEB", "\"\x81\xA8R\x9A\x8FP\x9C")] = ui.reference(var_0_6("\xA4\x93", "\xE9\xE5\xD2Sk(."), var_0_6("\xE0L&\xDFH\xC0K?\xD4\n\xD5\x023\xD8\x02\xCDG!", "e\xA1\"R\xB6"), var_0_6("\xCD\t^\xFB\x9B\xFB\x839", "N\x88m9\x9E\xBB\x82\xE2")),
		[var_0_6("<0\xFD\xE8\x01&\xF8\xE6", "\x91^_\x99")] = {
			ui.reference(var_0_6("\xDC\xEC", "ם\xADt\xB5."), var_0_6("\x14\xBA\x9F\xFB\x974\xBD\x86\xF0\xD5!\xF4\x8A\xFC\xDD9\xB1\x98", "\xBAU\xD4\xEB\x92"), var_0_6("\xE0\x8E\x12\xE7y\xF7Y\xD5", "8\xA2\xE1v\x9EY\x8E"))
		},
		[var_0_6("E\x04א(\xD1H\x11Ž", "\xB8<e\xA0\xCFB")] = {
			ui.reference(var_0_6("\x10\xA3", "\xDCQ\xE2\x1C"), var_0_6("2ۖ\xF2\xA7\xC6\x1A؀\xF4\xFE\x87\x12ۅ\xF7\xEF\xD4", "\xA7s\xB5⛊"), var_0_6("\xDB#\xF0\x1Cqx\xD2\xF6'\xF5", "\xA6\x82B\x87<\x1B\x11"))
		},
		[var_0_6("BX\xCBp#PK\xC0q", "P$*\xAE\x15")] = {
			ui.reference(var_0_6("o1", "\x1A.pW"), var_0_6("\x98-\xBF}\xF2\xBEL\xB9\xBB,\xBF4\xBE\xB1B\xB8\xBC0", "\xD4\xD9C\xCB\x14\xDF\xDF%"), var_0_6("\x9C\x9F\xADש\x99\xA9ܾ\x84\xA6\xD5", "\xB2\xDA\xED\xC8"))
		},
		[var_0_6("\xA4\xBA\xEA\xDC", "\xB0\xD6Ն")] = ui.reference(var_0_6("Ռ", "9\x94\xCDִ\xC86"), var_0_6("3\xF3!=;\x13\xF486y\x06\xBD4:q\x1E\xF8&", "\x16r\x9DUT"), var_0_6("\xF6\xC4\x1F\xC8", "Ȥ\xABs\xA4=\x96")),
		[var_0_6("\xBA\xFB\x16G\x8F\xBB\xCB\x17D\x93", "\xE3ޔc%")] = {
			ui.reference(var_0_6("\x01su\xD3", "\x99S22\x96"), var_0_6("|\x7F~\x1E|\xBF", "-=\x16\x13|\x13\xCB"), var_0_6("\xE5\x1D\x18\xF7\x0Eu\xF9\xD5\x13\x1D", "١rm\x95b\x10"))
		},
		[var_0_6("\x1D.\ao\xB4{\x06\x1F9r\xA8}-!1q", "\x14r@X\x1C\xDC")] = {
			ui.reference(var_0_6("\x10 ", "\xDDQa\xB2Ԙ\xB0"), var_0_6("\xE2\xF3\x15\xFE\b", "z\xAD\x87}\x9B"), var_0_6("\xAB\xCF@\xAA7>\xDC\xC4\xC0\x0E\xAD6|ɍ\xCC", "\xA8\xE4\xA1`\xD9_Q"))
		}
	},
	[var_0_6("\xC9\xD0)Y", "7\xBB\xB1N<O")] = {
		[var_0_6(")\xC3X", "\xE0M\xAE?\x8B&\xAF")] = ui.reference(var_0_6("\xB6`\x7F\v", "N\xE4!8"), var_0_6("\xEFw\xBF\x01\x8A\xDA", "\xE5\xAE\x1E\xD2c"), var_0_6("6\xE4\x88X\xE0(4[\xE9\x87\\\xEC:<", "Y{\x8D\xE61\x8D]")),
		[var_0_6("\xF7|\xF13\x1F\\\xF6c\xE4\x05\x14O", "*\x93\x11\x96lp")] = {
			ui.reference(var_0_6("=\x87\nZ", "\x88o\xC6M\x1F\x87"), var_0_6("#\x00\xAAT\xB2\xF0", "\xC9bi\xC76݄w"), var_0_6("\x94\x05\x8D(\x0F \xA1\xF9\b\x82,\x032\xA9\xF9\x03\x95$\x10'\xA5\xBD\t", "\xCC\xD9l\xE3AbU"))
		}
	},
	[var_0_6("X\xC2\xFE\xE0 \xC1Y", "\xA0>\xA3\x95\x85L")] = {
		[var_0_6("Ӯ\f-\xCFӤ", "\xA3\xB6\xC0mO")] = {
			ui.reference(var_0_6("\x15\a", "\x95TF`\xA0"), var_0_6("\x1E\a\x06\xE8x\n\f\xEA", "\x8DXfm"), var_0_6("\x96]\xCBr\x168Q", "\xA1\xD33\xAA\x10z]5"))
		},
		[var_0_6("\xFA\xA3\xBD=\xF5\xBA", "H\x9B\xCE\xD2")] = ui.reference(var_0_6("g[", "S&\x1A4n"), var_0_6("~\x16,C\x18\x1B&A", "&8wG"), var_0_6("\xD2\xE2W\xC3+B", "6\x93\x8F8\xB6E")),
		[var_0_6("\xC0\x80\xED@\xDE؂\xFA", "\xBF\xB6\xE1\x9F)")] = ui.reference(var_0_6("\n3", "\xA2KrH5\xEB\xE7"), var_0_6("\xAA=O\xE7\x13\x0E\x8D;", "b\xEC\\$\x823"), var_0_6("\x92\x18\x1E\xB3D\xA6\xB65", "P\xC4yl\xDA%\xC8\xD5")),
		[var_0_6("\fz\x0Fv_", "\xEA`\x13b\x1F+n")] = ui.reference(var_0_6("'>", "\xEBf\x7F2\xA7\xCC\x12"), var_0_6("v\xA0\xFE&\x04\"Q\xA6", "N0\xC1\x95C$"), var_0_6("\x1C\x17\x8D\x11U", "!P~\xE0x"))
	},
	[var_0_6("\xE3\xBC\v\xC1N", "<\x8C\xC8c\xA4")] = {
		[var_0_6("\x82\xFA\x05$\xAE\x82\xF0;5\xAE\x90", "\xC2\xE7\x94dF")] = {
			ui.reference(var_0_6("gm", "\xA8&,\xA1Ö"), var_0_6("\xAF\xE8\x8As\"", "v\xE0\x9C\xE2\x16P\x88\xD6"), var_0_6("q\xE2V\x97\x02\xC3V\x94K\xE1W", "\xE0\"\x8E9"))
		},
		[var_0_6("Ң\xC2\xE2~\xFEK\vӢ\xCB\xC9", "n\xBEǥ\xBD\x13\x91=")] = ui.reference(var_0_6("\xFB\xCA", "\xA7\xBA\x8B\x17\x88\xEB"), var_0_6("5\xA1\x80\b\b", "mz\xD5\xE8"), var_0_6("\xC2\xF2\xA5p\xE3\xF8\xB45\xE3\xF2\xAC$", "P\x8E\x97\xC2")),
		[var_0_6("\f\xD5vM", ",c\xA6\x17")] = {
			ui.reference(var_0_6("]\xD6", "\xC4\x1C\x97IVS"), var_0_6("\xDC\x17!\x15\x90", "\x16\x93cIp\xE28x"), var_0_6("\x97{\xA2ƅ\xB7a\xA2\xF4\x83\xAC|\xAF\xF4\x84\xB5", "\xED\xD8\x15\x82\x95"))
		},
		[var_0_6("\x84OTZ\xA0\xCC[\x89", ">\xE2.??Щ")] = {
			ui.reference(var_0_6("\xC48", ">\x85y5\xE3\x7FmO"), var_0_6("?\x00:\xF0\xC4", "\xC2ptR\x95\xB6\xCE"), var_0_6("\x1F\xA9G\x1D\x80\xF2\v<\xA3", "nY\xC8,x\xA0\x82"))
		}
	},
	[var_0_6("\xBD\xCAXSBF(", "-ˣ+&#*[")] = {
		[var_0_6("\xC1\x86\xD33\x82\x96[Ā\xCE/\x86\xB0", "4\xB2\xE5\xBCC\xE7\xC9")] = ui.reference(var_0_6("\x17hc1\xD6p\x10", "CA!0d\x97<"), var_0_6("\xFA\xE1\xA8\xDD\xF0\xCB\xF4", "\x93\xBF\x87θ"), var_0_6("\xB6-\xAB\xCE\xCEV\xF2\x97+\xA9\xD1\xDD\x13\xBD\x92-\xB4\xCD\xD9J", "\xD2\xE4Hơ\xB83"))
	}
}

var_0_8.macros.dot = "\v•  \r"
var_0_8.macros.dot_red = "\aADD8E6FFkrim.lua  \affffff7a⇨ \r"
var_0_8.macros.fs = "\v⟳  \r"
var_0_8.macros.left_manual = "\v⇦  \r"
var_0_8.macros.right_manual = "\v⇨  \r"
var_0_8.macros.forward_manual = "\v⇧  \r"
var_0_8.macros.antiaim_vinco = "\vKr\aADD8E6FFim \v• \r"
var_0_8.macros.fl_vinco = "\aADD8E6FFKrim \r"

local var_0_40 = var_0_8.group(var_0_6("7H", "\xAEV)\x93p\x13"), var_0_6("Z\x0E\x99\x02h\x0E\x18\xA6Y\x0F\x99K$\x01\x16\xA7^\x13", "\xCB;`\xEDkEoq"))
local var_0_41 = var_0_8.group(var_0_6("%\x17", "\xB7Dv́Q\x90"), var_0_6("\x01\xB9x\xE1\x19", "\xE2n\xCD\x10\x84k"))

vencolabelaa = var_0_40:label(var_0_6("\xC0\xD1\xE9\xD4", "!\x8B\xA3\x80\xB9"))
tab_selector = var_0_40:combobox("\f<dot_red> \f<fl_vinco> Tab Selector", {
	var_0_6("~V\x02\xD1", "\xBE78d"),
	var_0_6("w\xA1(\x17\r\xC2\xFA[\xAD3\n", "\x936\xCF\\~s\x83"),
	var_0_6("?02x\x0Fq\x19", "\x1EmQU\x1Dm"),
	var_0_6("\xC9xG\xA37\xD2\xEF", "\x9C\x9F\x114\xD6V\xBE"),
	var_0_6("\x83殿", "\xDCΏ\xDD"),
	var_0_6("\xA5r#\x11\xD1\xCB", "\xB2\xE6\x1DMw\xB8\xAC")
})

var_0_40:label(var_0_6("\xB8\xF3GV:\xB5\xB8\xF3GV:\xB5\xB8\xF3GV:\xB5\xB8\xF3GV:\xB5\xB8\xF3GV:\xB5\xB8\xF3GV:\xB5\xB8\xF3", "\x98\x95\xDEj{\x17"))
local username = "uwuboy"
var_0_40:label("\f<dot_red>Welcome back, \aADD8E6FF" .. username):depend({
	tab_selector,
	var_0_6("\xF4(\xF0L", "սF\x96#")
})
var_0_40:label("\f<dot_red>Version: \aADD8E6FF" .. var_0_28.version):depend({
	tab_selector,
	var_0_6("f[r\a", "h/5\x14")
})
var_0_40:label("\f<dot_red>Times fucked: \aADD8E6FF" .. data.load_count):depend({
	tab_selector,
	var_0_6("\x8AB\x87\x13", "o\xC3,\xE1|\xDC")
})

aa_tab = var_0_40:combobox("\f<antiaim_vinco>AntiAim Tab", {
	var_0_6("\xEBC\x14g\xA2\xA5\xDFU", "˸&`\x13\xCB"),
	var_0_6("\x1BfpM\xCA<a", "\xAEY\x13\x19!")
}):depend({
	tab_selector,
	var_0_6("\x0E\x1CFG\xE9\xA6\x02\"\x10]Z", "kOr2.\x97\xE7")
})

var_0_40:label(var_0_6("t\xEB\xF8d\xC7t\xFA\x8Dt\xEB\xF8d\xC7t\xFA\x8Dt\xEB\xF8d\xC7t\xFA\x8Dt\xEB\xF8d\xC7t\xFA\x8Dt\xEB\xF8d\xC7t", "\xA0Y\xC6\xD5I\xEAY\xD7")):depend({
	tab_selector,
	var_0_6("i\x7F\xA0\xF7\xDBix\xB9\xFC\xCA\\", "\xA5(\x11Ԟ")
})

aa_pitch = var_0_40:combobox("\f<antiaim_vinco>Pitch", {
	var_0_6("\xC1\xD0\x1B2$\xE9\xDC\f", "F\x85\xB9hS"),
	var_0_6(" JS$", "\xA9d%$J")
}):depend({
	tab_selector,
	var_0_6("!\x89\xB6Y\x1E\xA6\xAB]\x02\x88\xB6", "0`\xE7\xC2")
}, {
	aa_tab,
	var_0_6("\xFB_\x1A9\x10֨\x90", "\xE3\xA8:nMy\xB8\xCF")
})
aa_yaw_base = var_0_40:combobox("\f<antiaim_vinco>Yaw Base", {
	var_0_6("W3\xBCA\xBD\x9BG\xAC~+", "\xC5\x1B\\\xDF ѻ\x11"),
	var_0_6("\"K\x83\xCF\x02M\xC4\xFE\x17L", "\x9Bc?\xA3")
}):depend({
	tab_selector,
	var_0_6("\xA3ߵ\x84\xA7\xA5\x8Bܣ\x82\xAD", "\xE4\xE2\xB1\xC1\xED\xD9")
}, {
	aa_tab,
	var_0_6("\a\xB57\xF2=\xBE$\xF5", "\x86T\xD0C")
})
aa_fs_enable = var_0_40:checkbox("\f<antiaim_vinco>Enable Freestanding"):depend({
	tab_selector,
	var_0_6("2\xA2\x92U\r\x8D\x8FQ\x11\xA3\x92", "<s\xCC\xE6")
}, {
	aa_tab,
	var_0_6("\xD4?\xFFd\xEE4\xECc", "\x10\x87Z\x8B")
})
aa_fs_key = var_0_40:hotkey("\f<antiaim_vinco>Freestanding"):depend({
	tab_selector,
	var_0_6("uz\x12:PuqYv\t'", "\x184\x14fS.4")
}, {
	aa_tab,
	var_0_6("\xF7*50\x06\xCA(2", "o\xA4OAD")
}, aa_fs_enable)
safe_head_enabled = var_0_40:checkbox("\f<antiaim_vinco>Safe Head"):depend({
	tab_selector,
	var_0_6("\xE7ח\xD70\xCB\xCFԁ\xD1:", "\x8A\xA6\xB9\xE3\xBEN")
}, {
	aa_tab,
	var_0_6("\xF8q\xD1#[-\x1E\xD8", "y\xAB\x14\xA5W2C")
})
safe_head_states = var_0_40:multiselect("\f<antiaim_vinco>Safe Head States", {
	var_0_6("\xE71\xABv\x92\f\xCF>\xBC", "b\xA6X\xD9V\xD9"),
	var_0_6("\xD7\xFFkA\xBC\xD9\xE3\xE5", "\xBC\x96\x96\x19a\xE6"),
	var_0_6("\xE9\x9D^\f\b\xE4Ԏ", "\x8D\xBA\xE9?bl"),
	var_0_6("\xD2\xF8#\xA3&\xF9\xEF(", "E\x91\x8AL\xD6"),
	var_0_6("S݆\x9C\xBC\x1Eu\xCBɨ\xB6\x04", "v\x10\xAF\xE9\xE9\xDF")
}):depend({
	tab_selector,
	var_0_6("\xAA\x8A!\xB2\xF0\xAAt\x86\x86:\xAF", "\x1D\xEB\xE4Uێ\xEB")
}, {
	aa_tab,
	var_0_6("\x0EѮ\xC9~@ A", "2]\xB4ڽ\x17.G")
}, safe_head_enabled)
avoid_backstab_enabled = var_0_40:checkbox("\f<antiaim_vinco>Avoid Backstab"):depend({
	tab_selector,
	var_0_6("\xFF\xAAOEZ\xFDAӦTX", "(\xBE\xC4;,$\xBC")
}, {
	aa_tab,
	var_0_6("\x0F@Ƞ\xF3s\n/", "m\\%\xBCԚ\x1D")
})
aa_condition = var_0_40:combobox("\f<antiaim_vinco>Condition", var_0_37):depend({
	tab_selector,
	var_0_6("%\xE1\xB0\xCA/{\r\xE2\xA6\xCC%", ":d\x8FģQ")
}, {
	aa_tab,
	var_0_6("8W*\xAF;L\xF7", "nz\"C\xC3_)\x85")
})

local var_0_42 = {}

for iter_0_0 = 1, #var_0_37 do
	var_0_42[iter_0_0] = {
		[var_0_6("q\xB4]O\xD8f\xB8MO\xE9t\xBFOC\xE9t\xB8VH\xD9a", "\xB6\x15\xD1;*")] = ui.new_checkbox(var_0_6("\x96v", "\xDE\xD77\xA5}A"), var_0_6("\r\xDF\xD2\x13\xBF\xC0\xE4G.\xDE\xD2Z\xF3\xCF\xEAF)\xC2", "*L\xB1\xA6z\x92\xA1\x8D"), var_0_6("\x81\x8F\x03\xCBwe\xAC\x9C\x00\x8EXW\xE5", "\x16\xC5\xEAe\xAE\x19") .. var_0_37[iter_0_0]),
		[var_0_6(")1\xA3\xD9x\xBCސ(\v\xB5\xD5b\xAC\xDF", "\xE6MTż\x16Ϸ")] = ui.new_checkbox(var_0_6("\xD85", "U\x99t\xA6\x9C\xEC\xC1\x90"), var_0_6("\x85\xEEY\xBA\xA9\x01\xAD\xEDO\xBC\xF0@\xA5\xEEJ\xBF\xE1\x13", "`Ā-ӄ"), var_0_6("\x11\x88}Zܼ\xBD\xCE0\xCDKVƬ\xBC\x98", "\xB8U\xED\x1B?\xB2\xCF\xD4") .. var_0_37[iter_0_0]),
		[var_0_6("\f\\\x0FZ\x06J\x00I\rf\x19V\x1CZ\x01\x0E", "?h9i")] = ui.new_combobox(var_0_6("*\xA6", "$k\xE7\xC4"), var_0_6("|\xBB\xB6\x8E\x10\xB4\xAB\x8A_\xBA\xB6\xC7\\\xBB\xA5\x8BX\xA6", "\xE7=\xD5\xC2"), var_0_6("-\xA8;v\a\xBE4e\f\xED\rz\x1D\xAE53=\xB4-vI", "\x13i\xCD]") .. var_0_37[iter_0_0], var_0_6("\x86\x0E\xD8", "_\xC9h\xBE\xE1"), var_0_6("\x8B\xCE\xC7Ϻ\xC7\xD5", "\xAEϫ\xA1"), var_0_6("\xD8\xEE", "\xB7\x8D\x9Em\x93\x98"), var_0_6("\b\x06\xF1\x02", "lLi\x86"), var_0_6("\xC6̿\xE8\xC3\xEA\xC9", "\xAE\x8B\xA5с"), var_0_6("\x91\xB2\xEC\xC5\xC9\x0E", "\x18\xC3ӂ\xA1\xA6c\x10"), var_0_6("e\x16\xFA8\\\x1B", "v&c\x89L3")),
		[var_0_6("\xF9#\x03\x17\a3\xF40\x00-\x19)\xE9%\r@", "@\x9DFeri")] = ui.new_slider(var_0_6("a\x89", "p \xC8ǃ"), var_0_6("\r^H\xB1\x8E\xAA+!RS\xAC\x83\xAA,+\\Y\xAB", "BL0<أ\xCB"), var_0_6("\x9E\x83\x7F\xF6Q\xDD-\xAC\x839\xC3V\xDA'\xB2\xC6O\xF2S\xDB!\xFA", "D\xDA\xE6\x19\x93?\xAE") .. var_0_37[iter_0_0], -89, 89, -89, true, "°"),
		[var_0_6("\xA9/UI\xB8\xBE#EI\x89\xBD#GO\xBE\xFE", "\xD6\xCDJ3,")] = ui.new_slider(var_0_6("\xDBm", "\x17\x9A,\x82\x9C"), var_0_6("0\xA8\xB9\xA7{\x12\x18\xAB\xAF\xA1\"S\x10\xA8\xAA\xA23\x00", "sq\xC6\xCD\xCEV"), var_0_6("\xA0R\xF8_\x8AD\xF7L\x81\x17\xCES\x90T\xF6\x1A\xB6V\xF0^\x8BZ\xBEw\x85O\xBE", ":\xE47\x9E") .. var_0_37[iter_0_0], -89, 89, 89, true, "°"),
		[var_0_6("\xB0\x8C\xD6+2\xBE<\xA2\x8C\xEF7=\xBA", "U\xD4\xE9\xB0N\\\xCD")] = ui.new_checkbox(var_0_6("ky", "\x82*8\xE8"), var_0_6("˻0\xEA\r>\xE3\xB8&\xECT\x7F\xEB\xBB#\xEFE,", "_\x8A\xD5D\x83 "), var_0_6("\x0E-\xA7Fx9!\xB7F6\x13)\xB6\x03", "\x16JH\xC1#") .. var_0_37[iter_0_0]),
		[var_0_6("(|\xE2]\"j\xEDN)F\xFDY;(", "8L\x19\x84")] = ui.new_combobox(var_0_6("\x7F\xE0", "\xAF>\xA1\xCBF"), var_0_6("\x1D\xD3\xD7\x1Ax=\xD4\xCE\x11:(\x9D\xC2\x1D20\xD8\xD0", "U\\\xBD\xA3s"), var_0_6("\r\xA96='\xBF9.,\xEC\t9>\xEC\x04!9\xA9p", "XI\xCCP") .. var_0_37[iter_0_0], var_0_6("\x7F\xDB@", "\xBAN\xE3p&I"), var_0_6("\xCFG\xF4[", "\x1A\x9C7\x9D53"), var_0_6("݀F\x99\x82", "0\xEC\xB8v\xB9\xD8"), var_0_6("ִS5\xD85\xFC\xAE", "T\x85\xDD7P\xAF"), var_0_6("\x8F\xE6*\xA2\xC8Q", "<݇DƧ")),
		[var_0_6("\xEA\xB8\xFE\x86L\xCA\xE7\xAB\xFD\xBC[\xD8\xF9\xEF", "\xB9\x8Eݘ\xE3\"")] = ui.new_slider(var_0_6("y\xE4", "\x978\xA57\x9A#S"), var_0_6("\x81M\x11\xE7\xEDB\f\xE3\xA2L\x11\xAE\xA1M\x02\xE2\xA5P", "\x8E\xC0#e"), var_0_6("\xF2p/\xA6韥\x00\xD35\x10\xA2\xF0̚\x17\xDA`,\xE3", "v\xB6\x15IÇ\xEC\xCC") .. var_0_37[iter_0_0], -180, 180, 0, true, "°")
	}
end

var_0_40:label(var_0_6("EqW\rI@\xB0EqW\rI@\xB0EqW\rI@\xB0EqW\rI@\xB0EqW\rI@\xB0EqW", "\x9Dh\\z dm")):depend({
	tab_selector,
	var_0_6("\x82\xA8\xDB\xC3#\x06\x84\xA6\xA1\xA9\xDB", "\xCB\xC3Ư\xAA]G\xED")
}, {
	aa_tab,
	var_0_6("\f^7\xD9U\x14\xEE", "\x9CN+^\xB51q")
})
var_0_40:label("\f<antiaim_vinco>Defensive Anti-Aim Settings"):depend({
	tab_selector,
	var_0_6("S\xE6Ъ\x15bp\x7F\xEA˷", "\x19\x12\x88\xA4\xC3k#")
}, {
	aa_tab,
	var_0_6("\xCA8\xA0Cv\xB9\xD3", "؈M\xC9/\x12ܡ")
})
client.set_event_callback(var_0_6("=\xED\"\xD4\x1C\xE3\x97$", "\xE2M\x8CK\xBAh\xBC"), function()
	local var_28_0 = 0
	local var_28_1
	local var_28_2

	while true do
		if var_28_0 == 1 then
			for iter_28_0 = 1, #var_0_37 do
				local var_28_3 = 0
				local var_28_4

				while true do
					if var_28_3 == 1 then
						ui.set_visible(var_0_42[iter_28_0].defensive_pitch, var_28_4 and ui.get(var_0_42[iter_28_0].defensive_anti_aimbot))
						ui.set_visible(var_0_42[iter_28_0].defensive_pitch1, var_28_4 and ui.get(var_0_42[iter_28_0].defensive_anti_aimbot) and ui.get(var_0_42[iter_28_0].defensive_pitch))

						var_28_3 = 2
					end

					if var_28_3 == 4 then
						ui.set_visible(var_0_42[iter_28_0].defensive_yaw2, var_28_4 and ui.get(var_0_42[iter_28_0].defensive_anti_aimbot) and ui.get(var_0_42[iter_28_0].defensive_yaw) and (ui.get(var_0_42[iter_28_0].defensive_yaw1) == var_0_6("\xB1[r", "\xA4\x80cB\x89\x9F") or ui.get(var_0_42[iter_28_0].defensive_yaw1) == var_0_6("3\x99\xE0\xB0", "\xDE`\xE9\x89") or ui.get(var_0_42[iter_28_0].defensive_yaw1) == var_0_6("\xE8\xEB\xF7_\xB2", "\x90\xD9\xD3\xC7\x7F\xE8\x93")))

						break
					end

					if var_28_3 == 0 then
						local var_28_5 = 0

						while true do
							if var_28_5 == 0 then
								var_28_4 = var_28_1 and var_28_2 == var_0_37[iter_28_0]

								ui.set_visible(var_0_42[iter_28_0].defensive_anti_aimbot, var_28_4)

								var_28_5 = 1
							end

							if var_28_5 == 1 then
								var_28_3 = 1

								break
							end
						end
					end

					if var_28_3 == 3 then
						ui.set_visible(var_0_42[iter_28_0].defensive_yaw, var_28_4 and ui.get(var_0_42[iter_28_0].defensive_anti_aimbot))
						ui.set_visible(var_0_42[iter_28_0].defensive_yaw1, var_28_4 and ui.get(var_0_42[iter_28_0].defensive_anti_aimbot) and ui.get(var_0_42[iter_28_0].defensive_yaw))

						var_28_3 = 4
					end

					if var_28_3 == 2 then
						ui.set_visible(var_0_42[iter_28_0].defensive_pitch2, var_28_4 and ui.get(var_0_42[iter_28_0].defensive_anti_aimbot) and ui.get(var_0_42[iter_28_0].defensive_pitch) and (ui.get(var_0_42[iter_28_0].defensive_pitch1) == var_0_6("\xE8ޭ\x83\xDC\xD7", "\xB3\xBA\xBF\xC3\xE7") or ui.get(var_0_42[iter_28_0].defensive_pitch1) == var_0_6("\xDA*\v\xF0\xF62", "\x84\x99_x")))
						ui.set_visible(var_0_42[iter_28_0].defensive_pitch3, var_28_4 and ui.get(var_0_42[iter_28_0].defensive_anti_aimbot) and ui.get(var_0_42[iter_28_0].defensive_pitch) and ui.get(var_0_42[iter_28_0].defensive_pitch1) == var_0_6("\x83\xB3\x00)\xF8\xD7", "\xC0\xD1\xD2nM\x97\xBA"))

						var_28_3 = 3
					end
				end
			end

			break
		end

		if var_28_0 == 0 then
			var_28_1 = tab_selector:get() == var_0_6("\x98\xC0\xC46Q\x98\xC7\xDD=@\xAD", "/ٮ\xB0_") and aa_tab:get() == var_0_6("\x9A\xC8\x7F\x0E\xB6Qj", "Fؽ\x16b\xD24\x18")
			var_28_2 = aa_condition:get()
			var_28_0 = 1
		end
	end
end)

local var_0_43 = (function()
	local var_29_0 = {}

	local function var_29_1(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5, arg_30_6, arg_30_7, arg_30_8)
		local var_30_0 = 0

		while true do
			if var_30_0 == 4 then
				renderer.circle(arg_30_0 + arg_30_2 - arg_30_4, arg_30_1 + arg_30_3 - arg_30_4, arg_30_5, arg_30_6, arg_30_7, arg_30_8, arg_30_4, 0, 0.25)

				break
			end

			if var_30_0 == 1 then
				renderer.rectangle(arg_30_0 + arg_30_4, arg_30_1 + arg_30_3 - arg_30_4, arg_30_2 - arg_30_4 * 2, arg_30_4, arg_30_5, arg_30_6, arg_30_7, arg_30_8)
				renderer.rectangle(arg_30_0 + arg_30_2 - arg_30_4, arg_30_1 + arg_30_4, arg_30_4, arg_30_3 - arg_30_4 * 2, arg_30_5, arg_30_6, arg_30_7, arg_30_8)

				var_30_0 = 2
			end

			if var_30_0 == 3 then
				renderer.circle(arg_30_0 + arg_30_2 - arg_30_4, arg_30_1 + arg_30_4, arg_30_5, arg_30_6, arg_30_7, arg_30_8, arg_30_4, 90, 0.25)
				renderer.circle(arg_30_0 + arg_30_4, arg_30_1 + arg_30_3 - arg_30_4, arg_30_5, arg_30_6, arg_30_7, arg_30_8, arg_30_4, 270, 0.25)

				var_30_0 = 4
			end

			if var_30_0 == 2 then
				renderer.rectangle(arg_30_0 + arg_30_4, arg_30_1 + arg_30_4, arg_30_2 - arg_30_4 * 2, arg_30_3 - arg_30_4 * 2, arg_30_5, arg_30_6, arg_30_7, arg_30_8)
				renderer.circle(arg_30_0 + arg_30_4, arg_30_1 + arg_30_4, arg_30_5, arg_30_6, arg_30_7, arg_30_8, arg_30_4, 180, 0.25)

				var_30_0 = 3
			end

			if var_30_0 == 0 then
				renderer.rectangle(arg_30_0 + arg_30_4, arg_30_1, arg_30_2 - arg_30_4 * 2, arg_30_4, arg_30_5, arg_30_6, arg_30_7, arg_30_8)
				renderer.rectangle(arg_30_0, arg_30_1 + arg_30_4, arg_30_4, arg_30_3 - arg_30_4 * 2, arg_30_5, arg_30_6, arg_30_7, arg_30_8)

				var_30_0 = 1
			end
		end
	end

	local var_29_2 = 4
	local var_29_3 = var_29_2 + 2
	local var_29_4 = 45
	local var_29_5 = 20

	local function var_29_6(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5, arg_31_6, arg_31_7, arg_31_8)
		local var_31_0 = 0

		while true do
			if var_31_0 == 2 then
				renderer.circle_outline(arg_31_0 + arg_31_4 + var_29_3, arg_31_1 + arg_31_4 + var_29_3, arg_31_5, arg_31_6, arg_31_7, arg_31_8, arg_31_4 + var_29_2, 180, 0.25, 1)
				renderer.circle_outline(arg_31_0 + arg_31_2 - arg_31_4 - var_29_3, arg_31_1 + arg_31_4 + var_29_3, arg_31_5, arg_31_6, arg_31_7, arg_31_8, arg_31_4 + var_29_2, 270, 0.25, 1)

				var_31_0 = 3
			end

			if var_31_0 == 1 then
				renderer.rectangle(arg_31_0 + arg_31_4 + var_29_3, arg_31_1 + 1 + 1, arg_31_2 - var_29_3 * 2 - arg_31_4 * 2, 1, arg_31_5, arg_31_6, arg_31_7, arg_31_8)
				renderer.rectangle(arg_31_0 + arg_31_4 + var_29_3, arg_31_1 + arg_31_3 - 3, arg_31_2 - var_29_3 * 2 - arg_31_4 * 2, 1, arg_31_5, arg_31_6, arg_31_7, arg_31_8)

				var_31_0 = 2
			end

			if var_31_0 == 0 then
				renderer.rectangle(arg_31_0 + 2, arg_31_1 + arg_31_4 + var_29_3, 1, arg_31_3 - var_29_3 * 2 - arg_31_4 * 2, arg_31_5, arg_31_6, arg_31_7, arg_31_8)
				renderer.rectangle(arg_31_0 + arg_31_2 - 3, arg_31_1 + arg_31_4 + var_29_3, 1, arg_31_3 - var_29_3 * 2 - arg_31_4 * 2, arg_31_5, arg_31_6, arg_31_7, arg_31_8)

				var_31_0 = 1
			end

			if var_31_0 == 3 then
				renderer.circle_outline(arg_31_0 + arg_31_4 + var_29_3, arg_31_1 + arg_31_3 - arg_31_4 - var_29_3, arg_31_5, arg_31_6, arg_31_7, arg_31_8, arg_31_4 + var_29_2, 90, 0.25, 1)
				renderer.circle_outline(arg_31_0 + arg_31_2 - arg_31_4 - var_29_3, arg_31_1 + arg_31_3 - arg_31_4 - var_29_3, arg_31_5, arg_31_6, arg_31_7, arg_31_8, arg_31_4 + var_29_2, 0, 0.25, 1)

				break
			end
		end
	end

	local function var_29_7(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5, arg_32_6, arg_32_7, arg_32_8, arg_32_9)
		local var_32_0 = arg_32_8 / 255 * var_29_4

		renderer.rectangle(arg_32_0 + arg_32_4, arg_32_1, arg_32_2 - arg_32_4 * 2, 1, arg_32_5, arg_32_6, arg_32_7, arg_32_8)
		renderer.circle_outline(arg_32_0 + arg_32_4, arg_32_1 + arg_32_4, arg_32_5, arg_32_6, arg_32_7, arg_32_8, arg_32_4, 180, 0.25, 1)
		renderer.circle_outline(arg_32_0 + arg_32_2 - arg_32_4, arg_32_1 + arg_32_4, arg_32_5, arg_32_6, arg_32_7, arg_32_8, arg_32_4, 270, 0.25, 1)
		renderer.gradient(arg_32_0, arg_32_1 + arg_32_4, 1, arg_32_3 - arg_32_4 * 2, arg_32_5, arg_32_6, arg_32_7, arg_32_8, arg_32_5, arg_32_6, arg_32_7, var_32_0, false)
		renderer.gradient(arg_32_0 + arg_32_2 - 1, arg_32_1 + arg_32_4, 1, arg_32_3 - arg_32_4 * 2, arg_32_5, arg_32_6, arg_32_7, arg_32_8, arg_32_5, arg_32_6, arg_32_7, var_32_0, false)
		renderer.circle_outline(arg_32_0 + arg_32_4, arg_32_1 + arg_32_3 - arg_32_4, arg_32_5, arg_32_6, arg_32_7, var_32_0, arg_32_4, 90, 0.25, 1)
		renderer.circle_outline(arg_32_0 + arg_32_2 - arg_32_4, arg_32_1 + arg_32_3 - arg_32_4, arg_32_5, arg_32_6, arg_32_7, var_32_0, arg_32_4, 0, 0.25, 1)
		renderer.rectangle(arg_32_0 + arg_32_4, arg_32_1 + arg_32_3 - 1, arg_32_2 - arg_32_4 * 2, 1, arg_32_5, arg_32_6, arg_32_7, var_32_0)

		for iter_32_0 = 4, arg_32_9 do
			local var_32_1 = iter_32_0 / 2

			var_29_6(arg_32_0 - var_32_1, arg_32_1 - var_32_1, arg_32_2 + var_32_1 * 2, arg_32_3 + var_32_1 * 2, var_32_1, arg_32_5, arg_32_6, arg_32_7, arg_32_9 - var_32_1 * 2)
		end
	end

	local function var_29_8(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5, arg_33_6, arg_33_7, arg_33_8, arg_33_9, arg_33_10, arg_33_11, arg_33_12)
		local var_33_0 = 0
		local var_33_1

		while true do
			if var_33_0 == 0 then
				var_33_1 = arg_33_8 / 255 * var_33_1

				renderer.rectangle(arg_33_0, arg_33_1 + arg_33_4, 1, arg_33_3 - arg_33_4 * 2, arg_33_5, arg_33_6, arg_33_7, arg_33_8)
				renderer.circle_outline(arg_33_0 + arg_33_4, arg_33_1 + arg_33_4, arg_33_5, arg_33_6, arg_33_7, arg_33_8, arg_33_4, 180, 0.25, 1)
				renderer.circle_outline(arg_33_0 + arg_33_4, arg_33_1 + arg_33_3 - arg_33_4, arg_33_5, arg_33_6, arg_33_7, arg_33_8, arg_33_4, 90, 0.25, 1)

				var_33_0 = 1
			end

			if var_33_0 == 1 then
				renderer.gradient(arg_33_0 + arg_33_4, arg_33_1, arg_33_2 / 3.5 - arg_33_4 * 2, 1, arg_33_5, arg_33_6, arg_33_7, arg_33_8, 0, 0, 0, var_33_1 / 0, true)
				renderer.gradient(arg_33_0 + arg_33_4, arg_33_1 + arg_33_3 - 1, arg_33_2 / 3.5 - arg_33_4 * 2, 1, arg_33_5, arg_33_6, arg_33_7, arg_33_8, 0, 0, 0, var_33_1 / 0, true)
				renderer.rectangle(arg_33_0 + arg_33_4, arg_33_1 + arg_33_3 - 1, arg_33_2 - arg_33_4 * 2, 1, arg_33_10, arg_33_11, arg_33_12, var_33_1)
				renderer.rectangle(arg_33_0 + arg_33_4, arg_33_1, arg_33_2 - arg_33_4 * 2, 1, arg_33_10, arg_33_11, arg_33_12, var_33_1)

				var_33_0 = 2
			end

			if var_33_0 == 2 then
				renderer.circle_outline(arg_33_0 + arg_33_2 - arg_33_4, arg_33_1 + arg_33_4, arg_33_10, arg_33_11, arg_33_12, var_33_1, arg_33_4, -90, 0.25, 1)
				renderer.circle_outline(arg_33_0 + arg_33_2 - arg_33_4, arg_33_1 + arg_33_3 - arg_33_4, arg_33_10, arg_33_11, arg_33_12, var_33_1, arg_33_4, 0, 0.25, 1)
				renderer.rectangle(arg_33_0 + arg_33_2 - 1, arg_33_1 + arg_33_4, 1, arg_33_3 - arg_33_4 * 2, arg_33_10, arg_33_11, arg_33_12, var_33_1)

				for iter_33_0 = 4, arg_33_9 do
					local var_33_2 = iter_33_0 / 2

					var_29_6(arg_33_0 - var_33_2, arg_33_1 - var_33_2, arg_33_2 + var_33_2 * 2, arg_33_3 + var_33_2 * 2, var_33_2, arg_33_10, arg_33_11, arg_33_12, arg_33_9 - var_33_2 * 2)
				end

				break
			end
		end
	end

	local function var_29_9(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5, arg_34_6, arg_34_7, arg_34_8, arg_34_9, arg_34_10, arg_34_11, arg_34_12)
		local var_34_0 = arg_34_8 / 255 * var_29_4

		renderer.rectangle(arg_34_0 + arg_34_4, arg_34_1, arg_34_2 - arg_34_4 * 2, 1, arg_34_5, arg_34_6, arg_34_7, var_34_0)
		renderer.circle_outline(arg_34_0 + arg_34_4, arg_34_1 + arg_34_4, arg_34_5, arg_34_6, arg_34_7, var_34_0, arg_34_4, 180, 0.25, 1)
		renderer.circle_outline(arg_34_0 + arg_34_2 - arg_34_4, arg_34_1 + arg_34_4, arg_34_5, arg_34_6, arg_34_7, var_34_0, arg_34_4, 270, 0.25, 1)
		renderer.rectangle(arg_34_0, arg_34_1 + arg_34_4, 1, arg_34_3 - arg_34_4 * 2, arg_34_5, arg_34_6, arg_34_7, var_34_0)
		renderer.rectangle(arg_34_0 + arg_34_2 - 1, arg_34_1 + arg_34_4, 1, arg_34_3 - arg_34_4 * 2, arg_34_5, arg_34_6, arg_34_7, var_34_0)
		renderer.circle_outline(arg_34_0 + arg_34_4, arg_34_1 + arg_34_3 - arg_34_4, arg_34_5, arg_34_6, arg_34_7, var_34_0, arg_34_4, 90, 0.25, 1)
		renderer.circle_outline(arg_34_0 + arg_34_2 - arg_34_4, arg_34_1 + arg_34_3 - arg_34_4, arg_34_5, arg_34_6, arg_34_7, var_34_0, arg_34_4, 0, 0.25, 1)
		renderer.rectangle(arg_34_0 + arg_34_4, arg_34_1 + arg_34_3 - 1, arg_34_2 - arg_34_4 * 2, 1, arg_34_5, arg_34_6, arg_34_7, var_34_0)

		for iter_34_0 = 4, arg_34_9 do
			local var_34_1 = 0
			local var_34_2

			while true do
				if var_34_1 == 0 then
					var_34_2 = var_34_2 / 2

					var_29_6(arg_34_0 - var_34_2, arg_34_1 - var_34_2, arg_34_2 + var_34_2 * 2, arg_34_3 + var_34_2 * 2, var_34_2, arg_34_10, arg_34_11, arg_34_12, arg_34_9 - var_34_2 * 2)

					break
				end
			end
		end
	end

	function var_29_0.linear_interpolation(arg_35_0, arg_35_1, arg_35_2)
		return (arg_35_1 - arg_35_0) * arg_35_2 + arg_35_0
	end

	function var_29_0.clamp(arg_36_0, arg_36_1, arg_36_2)
		if arg_36_2 < arg_36_1 then
			return math.min(math.max(arg_36_0, arg_36_2), arg_36_1)
		else
			return math.min(math.max(arg_36_0, arg_36_1), arg_36_2)
		end
	end

	function var_29_0.lerp(arg_37_0, arg_37_1, arg_37_2)
		arg_37_2 = arg_37_2 or 0.005
		arg_37_2 = var_29_0.clamp(globals.frametime() * arg_37_2 * 175, 0.009999999999990905, 1)

		local var_37_0 = var_29_0.linear_interpolation(arg_37_0, arg_37_1, arg_37_2)

		if arg_37_1 == 0 and var_37_0 < 0.01 and var_37_0 > -0.009999999999990905 then
			var_37_0 = 0
		elseif arg_37_1 == 1 and var_37_0 < 1.01 and var_37_0 > 0.99 then
			var_37_0 = 1
		end

		return var_37_0
	end

	function var_29_0.outlined_glow(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4, arg_38_5, arg_38_6, arg_38_7, arg_38_8, arg_38_9)
		for iter_38_0 = 4, arg_38_9 do
			local var_38_0 = 0
			local var_38_1

			while true do
				if var_38_0 == 0 then
					var_38_1 = var_38_1 / 2

					var_29_6(arg_38_0 - var_38_1, arg_38_1 - var_38_1, arg_38_2 + var_38_1 * 2, arg_38_3 + var_38_1 * 2, var_38_1, arg_38_5, arg_38_6, arg_38_7, arg_38_9 - var_38_1 * 2)

					break
				end
			end
		end
	end

	function var_29_0.container(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4, arg_39_5, arg_39_6, arg_39_7, arg_39_8, arg_39_9)
		if arg_39_7 > 0 then
			renderer.blur(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
		end

		local var_39_0 = arg_39_7 - 50

		if var_39_0 < 0 then
			var_39_0 = 0
		end

		rag, gab, bag = 8, 58, 33
		rag, gab, bag = arg_39_4, arg_39_5, arg_39_6

		var_29_1(arg_39_0 - 2, arg_39_1 - 2, arg_39_2 + 4, arg_39_3 + 4, var_29_2, rag, gab, bag, var_39_0)
		var_29_1(arg_39_0 - 1, arg_39_1 - 1, arg_39_2 + 2, arg_39_3 + 2, var_29_2, 161, 28, 29, var_39_0)
		var_29_1(arg_39_0, arg_39_1, arg_39_2, arg_39_3, var_29_2, rag, gab, bag, var_39_0)
		var_29_1(arg_39_0 + 2, arg_39_1 + 1 + 1, arg_39_2 - 4, arg_39_3 - 4, var_29_2, 17, 17, 17, arg_39_7)

		if not arg_39_9 then
			return
		end

		arg_39_9(arg_39_0 + var_29_2, arg_39_1 + var_29_2, arg_39_2 - var_29_2 * 2, arg_39_3 - var_29_2 * 2)
	end

	function var_29_0.container2(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4, arg_40_5, arg_40_6, arg_40_7, arg_40_8)
		var_29_1(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4, arg_40_5, arg_40_6, arg_40_7, arg_40_8)
	end

	function var_29_0.container3(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4, arg_41_5, arg_41_6, arg_41_7, arg_41_8, arg_41_9)
		local var_41_0 = 0
		local var_41_1

		while true do
			if var_41_0 == 0 then
				local var_41_2 = 0

				while true do
					if var_41_2 == 1 then
						var_41_0 = 1

						break
					end

					if var_41_2 == 0 then
						if arg_41_7 - 50 < 0 then
							local var_41_3 = 0
						end

						var_41_2 = 1
					end
				end
			end

			if var_41_0 == 3 then
				arg_41_9(arg_41_0 + var_29_2, arg_41_1 + var_29_2, arg_41_2 - var_29_2 * 2, arg_41_3 - var_29_2 * 2)

				break
			end

			if var_41_0 == 1 then
				ra, ga, ba, aa = custom_scope_color:get()

				var_29_1(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4, arg_41_5, arg_41_6, arg_41_7, arg_41_8)

				var_41_0 = 2
			end

			if var_41_0 == 2 then
				var_29_9(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4, arg_41_5, arg_41_6, arg_41_7, arg_41_8, 3, arg_41_4, arg_41_5, arg_41_6)

				if not arg_41_9 then
					return
				end

				var_41_0 = 3
			end
		end
	end

	function var_29_0.container4(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5, arg_42_6, arg_42_7, arg_42_8, arg_42_9)
		local var_42_0 = 0
		local var_42_1

		while true do
			if var_42_0 == 2 then
				var_29_1(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5, arg_42_6, arg_42_7, arg_42_8)
				var_29_9(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5, arg_42_6, arg_42_7, arg_42_8, 3, arg_42_4, arg_42_5, arg_42_6)

				var_42_0 = 3
			end

			if var_42_0 == 1 then
				if var_42_1 < 0 then
					var_42_1 = 0
				end

				ra, ga, ba, aa = custom_scope_color:get()
				var_42_0 = 2
			end

			if var_42_0 == 0 then
				if arg_42_7 > 0 then
					renderer.blur(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
				end

				var_42_1 = arg_42_7 - 50
				var_42_0 = 1
			end

			if var_42_0 == 3 then
				if not arg_42_9 then
					return
				end

				arg_42_9(arg_42_0 + var_29_2, arg_42_1 + var_29_2, arg_42_2 - var_29_2 * 2, arg_42_3 - var_29_2 * 2)

				break
			end
		end
	end

	function var_29_0.container5(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5, arg_43_6, arg_43_7, arg_43_8, arg_43_9)
		local var_43_0 = 0
		local var_43_1
		local var_43_2

		while true do
			if var_43_0 == 4 then
				if not arg_43_9 then
					return
				end

				arg_43_9(arg_43_0 + var_29_2, arg_43_1 + var_29_2, arg_43_2 - var_29_2 * 2, arg_43_3 - var_29_2 * 2)

				break
			end

			if var_43_0 == 2 then
				renderer.gradient(arg_43_0 + arg_43_2 / 3 * 2, arg_43_1 + arg_43_3 - 1, arg_43_2 / 3, 1, 8, 8, 8, arg_43_8, 29, 29, 29, arg_43_8, true)

				arg_43_0 = arg_43_0 - 4
				arg_43_1 = arg_43_1 - 1
				var_43_0 = 3
			end

			if var_43_0 == 1 then
				local var_43_3 = 0

				while true do
					if var_43_3 == 0 then
						renderer.rectangle(arg_43_0, arg_43_1, arg_43_2, arg_43_3 - 1, 29, 29, 29, arg_43_8)
						renderer.gradient(arg_43_0 + 1, arg_43_1 + 1 + 0, arg_43_2 - 2, arg_43_3 - 1, 17, 17, 17, arg_43_8, 8, 8, 8, arg_43_8, false)

						var_43_3 = 1
					end

					if var_43_3 == 1 then
						renderer.gradient(arg_43_0, arg_43_1 + arg_43_3 - 1, arg_43_2 / 3, 1, 29, 29, 29, arg_43_8, 8, 8, 8, arg_43_8, true)

						var_43_0 = 2

						break
					end
				end
			end

			if var_43_0 == 0 then
				if arg_43_7 - 50 < 0 then
					local var_43_4 = 0
				end

				arg_43_8 = arg_43_7
				var_43_0 = 1
			end

			if var_43_0 == 3 then
				arg_43_2 = arg_43_2 + 8
				arg_43_3 = arg_43_3 + 1 + 1

				local var_43_5 = {
					10,
					60,
					40,
					40,
					40,
					60,
					20
				}

				var_43_0 = 4
			end
		end
	end

	function var_29_0.horizontal_container(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5, arg_44_6, arg_44_7, arg_44_8, arg_44_9, arg_44_10, arg_44_11, arg_44_12)
		local var_44_0 = 0

		while true do
			if var_44_0 == 2 then
				arg_44_12(arg_44_0 + var_29_2, arg_44_1 + var_29_2, arg_44_2 - var_29_2 * 2, arg_44_3 - var_29_2 * 2)

				break
			end

			if var_44_0 == 1 then
				var_29_8(arg_44_0, arg_44_1, arg_44_2, arg_44_3, var_29_2, arg_44_4, arg_44_5, arg_44_6, arg_44_8 * 255, arg_44_8 * var_29_5, arg_44_9, arg_44_10, arg_44_11)

				if not arg_44_12 then
					return
				end

				var_44_0 = 2
			end

			if var_44_0 == 0 then
				if arg_44_8 * 255 > 0 then
					renderer.blur(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
				end

				var_29_1(arg_44_0, arg_44_1, arg_44_2, arg_44_3, var_29_2, 17, 17, 17, arg_44_7)

				var_44_0 = 1
			end
		end
	end

	function var_29_0.container_glow(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4, arg_45_5, arg_45_6, arg_45_7, arg_45_8, arg_45_9, arg_45_10, arg_45_11, arg_45_12)
		local var_45_0 = 0

		while true do
			if var_45_0 == 1 then
				var_29_9(arg_45_0, arg_45_1, arg_45_2, arg_45_3, var_29_2, arg_45_4, arg_45_5, arg_45_6, arg_45_8 * 255, arg_45_8 * var_29_5, arg_45_9, arg_45_10, arg_45_11)

				if not arg_45_12 then
					return
				end

				var_45_0 = 2
			end

			if var_45_0 == 0 then
				if arg_45_8 * 255 > 0 then
					renderer.blur(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
				end

				var_29_1(arg_45_0, arg_45_1, arg_45_2, arg_45_3, var_29_2, 17, 17, 17, arg_45_7)

				var_45_0 = 1
			end

			if var_45_0 == 2 then
				arg_45_12(arg_45_0 + var_29_2, arg_45_1 + var_29_2, arg_45_2 - var_29_2 * 2, arg_45_3 - var_29_2 * 2)

				break
			end
		end
	end

	function var_29_0.measure_multitext(arg_46_0, arg_46_1)
		local var_46_0 = 0

		for iter_46_0, iter_46_1 in pairs(arg_46_1) do
			local var_46_1 = 0

			while true do
				if var_46_1 == 0 then
					iter_46_1.flags = iter_46_1.flags or ""
					var_46_0 = var_46_0 + renderer.measure_text(iter_46_1.flags, iter_46_1.text)

					break
				end
			end
		end

		return var_46_0
	end

	function var_29_0.multitext(arg_47_0, arg_47_1, arg_47_2)
		for iter_47_0, iter_47_1 in pairs(arg_47_2) do
			local var_47_0 = 0
			local var_47_1

			while true do
				if var_47_0 == 0 then
					local var_47_2 = 0

					while true do
						if var_47_2 == 0 then
							iter_47_1.flags = iter_47_1.flags or ""
							iter_47_1.limit = iter_47_1.limit or 0
							var_47_2 = 1
						end

						if var_47_2 == 2 then
							renderer.text(arg_47_0, arg_47_1, iter_47_1.color[1], iter_47_1.color[2], iter_47_1.color[3], iter_47_1.color[4], iter_47_1.flags, iter_47_1.limit, iter_47_1.text)

							arg_47_0 = arg_47_0 + renderer.measure_text(iter_47_1.flags, iter_47_1.text)

							break
						end

						if var_47_2 == 1 then
							iter_47_1.color = iter_47_1.color or {
								255,
								255,
								255,
								255
							}
							iter_47_1.color[4] = iter_47_1.color[4] or 255
							var_47_2 = 2
						end
					end

					break
				end
			end
		end
	end

	return var_29_0
end)()

ragebot_tab = var_0_40:combobox("\f<antiaim_vinco>Ragebot Tab", {
	var_0_6("\xC8=;,\xDCF\x16M\xF7!", "$\x98O^H\xB5%b"),
	var_0_6("\xE5\xDDT0\xDB\xCEB-", "_\xB7\xB8'")
}):depend({
	tab_selector,
	var_0_6("\x87>\xE0#V\x8F\x16", "b\xD5_\x87F4\xE0")
})

var_0_40:label(var_0_6("\xB3\xEE\x84:\x19\xB3\xEE\x84:\x19\xB3\xEE\x84:\x19\xB3\xEE\x84:\x19\xB3\xEE\x84:\x19\xB3\xEE\x84:\x19\xB3\xEE\x84:\x19\xB3\xEE\x84", "4\x9Eé\x17")):depend({
	tab_selector,
	var_0_6("H\xBD5q\x84:o", "\xEB\x1A\xDCR\x14\xE6U\x1B")
})

prediction_enabled = var_0_40:checkbox("\f<dot_red>Improved Prediction"):depend({
	tab_selector,
	var_0_6("\xBA\xA0\xEE\xC7v\x87\xB5", "\x14\xE8\xC1\x89\xA2")
}, {
	ragebot_tab,
	var_0_6("\x12\xCD\xC0\xA2\xEE\x8F\x03x-\xD1", "\x11B\xBF\xA5Ƈ\xECw")
})
prediction_visualize = var_0_40:checkbox("\f<dot_red>Visualize Prediction"):depend({
	tab_selector,
	var_0_6("=\xAE\xA9\x16\xFD\xE7\xF8", "\xB1o\xCF\xCEs\x9F\x88\x8C")
}, {
	ragebot_tab,
	var_0_6("5\x9B\x15\x10\xDDLK\f\x86\x1E", "?e\xE9pt\xB4/")
}, prediction_enabled)
prediction_smoothing = var_0_40:slider("\f<dot_red>Prediction Smoothing", 1, 100, 50, true, "%"):depend({
	tab_selector,
	var_0_6("\xF1:\xEA\x17\xFA9\xD7", "V\xA3[\x8Dr\x98")
}, {
	ragebot_tab,
	var_0_6("c\x19qw3P\x1F}|4", "Z3k\x14\x13")
}, prediction_enabled)
prediction_min_velocity = var_0_40:slider("\f<dot_red>Min Velocity", 1, 100, 20, true, var_0_6("\x98\xFE\x8C\xFB.", "]\xED\x90\xE5\x8F")):depend({
	tab_selector,
	var_0_6("'\xF7\xF7\x1C\tI\x01", "&u\x96\x90yk")
}, {
	ragebot_tab,
	var_0_6("\x1D\xA9\xEB>$\xB8\xFA3\"\xB5", "ZMێ")
}, prediction_enabled)
prediction_ticks = var_0_40:slider("\f<dot_red>Prediction Ticks", 1, 16, 8, true, var_0_6("\xF2\r\"2_", "\x1A\x86dAY,g")):depend({
	tab_selector,
	var_0_6("\xC3\xE27&\xA6\xFE\xF7", "đ\x83PC")
}, {
	ragebot_tab,
	var_0_6(".\xA2\x03\f\x11\xEB\n\xB9\t\x06", "\x88~\xD0fhx")
}, prediction_enabled)
prediction_acceleration = var_0_40:checkbox("\f<dot_red>Acceleration Prediction"):depend({
	tab_selector,
	var_0_6("J\x8B\xC9F\xAD])", "1\x18\xEA\xAE#\xCF2]")
}, {
	ragebot_tab,
	var_0_6("<\xE0\xF8\x8Cx\x0F\xE6\xF4\x87\x7F", "\x11l\x92\x9D\xE8")
}, prediction_enabled)
resolver_enabled = var_0_40:checkbox("\f<dot_red>Advanced Resolver"):depend({
	tab_selector,
	var_0_6("y\xC2\x13\xE8-\xA7_", "\xC8+\xA3t\x8DO")
}, {
	ragebot_tab,
	var_0_6("\x8D3.\x8C\xBC\xE2\xE6\xAD", "\x83\xDFV]\xE3Д")
})
resolver_force_body_yaw = var_0_40:checkbox("\f<dot_red>Force Body Yaw"):depend({
	tab_selector,
	var_0_6("\xD1D\xB1\xB3\x1F\xBA\xF7", "Ճ%\xD6\xD6}")
}, {
	ragebot_tab,
	var_0_6("\x14.6\xB0\xED0.7", "\x81FKE\xDF")
}, resolver_enabled)
resolver_correction_active = var_0_40:checkbox("\f<dot_red>Correction Active"):depend({
	tab_selector,
	var_0_6("t\xCA\xF4\xEC~\xE0R", "\x8F&\xAB\x93\x89\x1C")
}, {
	ragebot_tab,
	var_0_6("⇪\xFC\x0F\xF5\xD1\xC2", "\xB4\xB0\xE2ٓc\x83")
}, resolver_enabled)
ragebot_activation_key = var_0_40:hotkey("\f<dot_red>Ragebot Activation Key"):depend({
	tab_selector,
	var_0_6("\xE1\xB8(\x02Ѷ;", "g\xB3\xD9O")
})

local var_0_44 = var_0_8.group(var_0_6("K\xB6", "\xC3*\xD7|\xB5!\xEC"), var_0_6("\vX<;e\xF4\f^", "\x98m9W^E"))

vencolabelfl = var_0_44:label(var_0_6("\xD2\xC5\x03\xAE", "ș\xB7j\xC3޲4"))
enable_fl = var_0_44:checkbox("\f<dot_red>Enable \f<fl_vinco>fakelag system")
fl_limit = var_0_44:slider("\f<dot_red>Fakelag Limit", 1, 15, 0):depend(enable_fl)
fl_variance = var_0_44:slider("\f<dot_red>Fakelag Variance", 0, 100, 0, true, "%", 1):depend(enable_fl)
fl_type = var_0_44:combobox("\f<dot_red>Fakelag Type", {
	var_0_6("\x16\xFA\x86<DS1", ":R\x83\xE8])"),
	var_0_6("\xAEV\xC8\x1CP*\x8E", "_\xE37\xB0u="),
	var_0_6(">r6H\xBF\r\x7F7N", "\xCBx\x1EC+"),
	var_0_6("\xC3$C\xEB\xD6\xFC,W\xEA\xDD", "\xB9\x91E-\x8F")
}):depend(enable_fl)

local var_0_45 = var_0_8.group(var_0_6("\x8B\x1E", "\xBC\xEA\x7Fy\xC6"), var_0_6("7&\x1B\x86*", "\xE3XRs"))

vencolabeloth = var_0_45:label(var_0_6("h\r\xB3\xAA", "\x13#\x7F\xDA\xC7b"))
oth_sw = var_0_45:checkbox("\f<dot_red> Slow Walk")
oth_sw_kb = var_0_45:hotkey("\f<dot_red> Slow Walk Key")
oth_lm = var_0_45:combobox("\f<dot_red> Leg Movment", {
	var_0_6("8\xF2\x19\xE3\x1E\xF7\x0F\xE6", "\x82|\x9Bj"),
	var_0_6("\xF4\xC7ᮺ\xE5", "ߵ\xAB\x96\xCFÖ\x1C"),
	var_0_6("b?\xF5\xAB\x1B", "i,Z\x83\xCE")
})
oth_osaa = var_0_45:checkbox("\f<dot_red> OSAA")
oth_osaa_kb = var_0_45:hotkey("\f<dot_red> OSAA Key")

local var_0_46 = {}

hitlogs_select = var_0_40:multiselect("\f<dot_red>Hitlogs", var_0_6("\xD0\xEE\xF2\x8A\v,\xFA\xE5\xBC", "^\x9F\x80\xD2\xD9h"), var_0_6("\x7F\xF7F\x9CPq\xEAu\\\xFC", "\x1A0\x99f\xDF?\x1F\x99")):depend({
	tab_selector,
	var_0_6("4I\xFE\xE6\x03L\xFE", "\x93b \x8D")
})
misslogs_select = var_0_40:multiselect("\f<dot_red>Misslogs", var_0_6("7M\xA3\xF9\x05DN\x1DM", "+x#\x83\xAAf6"), var_0_6("{\bǕ\xAA\xBE\x97[\n\x82", "\xE44f\xE7\xD6\xC5\xD0")):depend({
	tab_selector,
	var_0_6("(\xE9f\xDF\xEB\x87\n", "\xB6~\x80\x15\xAA\x8A\xEBy")
})
custom_scope_enabled = var_0_40:checkbox("\f<dot_red>Custom Scope Overlay"):depend({
	tab_selector,
	var_0_6("\xBD\xD3&\xF3\x87\x1F#", "f\xEB\xBAU\x86\xE6sP")
})
custom_scope_color = var_0_40:color_picker("\f<dot_red>Scope Color", 255, 255, 255, 255):depend({
	tab_selector,
	var_0_6("a\x05-Js\xD81", "B7l^?\x12\xB4")
}, custom_scope_enabled)
custom_scope_mode = var_0_40:combobox("\f<dot_red>Scope Mode", {
	var_0_6("0\x88\x8362U\x00", "9t\xED\xE5WG"),
	"T"
}):depend({
	tab_selector,
	var_0_6("\x9C\xB8\xFE\xF2v\xE2T", "'\xCAэ\x87\x17\x8E")
}, custom_scope_enabled)
custom_scope_position = var_0_40:slider("\f<dot_red>Scope Position", 0, 500, 50, true, var_0_6("\xEF+", "\x98\x9FSijR")):depend({
	tab_selector,
	var_0_6("\xB7\xCFB\xE7\xC8P\x92", "<\xE1\xA61\x92\xA9")
}, custom_scope_enabled)
custom_scope_offset = var_0_40:slider("\f<dot_red>Scope Offset", 0, 500, 10, true, var_0_6("?\x06", "gO~OJa")):depend({
	tab_selector,
	var_0_6("\x8Cv\xC0f_\x16\xA9", "z\xDA\x1F\xB3\x13>")
}, custom_scope_enabled)
hitrate_enabled = var_0_40:checkbox("\f<dot_red>Hitrate"):depend({
	tab_selector,
	var_0_6("\x85\xDF\xDE\xD4ȭV", "%Ӷ\xAD\xA1\xA9\xC1")
})
vis_desync_arrows_style = var_0_40:combobox("\f<dot_red>Desync Arrows", {
	var_0_6("\xD33^\xD8*w\xBC\xF3", "ٗZ-\xB9H\x1B"),
	var_0_6("\xE7y\xE1\x13C\xCFh", "6\xA3\x1C\x87r")
}):depend({
	tab_selector,
	var_0_6("\x1E\xD2N\x97Os;", "\x1FH\xBB=\xE2.")
})
vis_desync_arrows_color = var_0_40:color_picker("\f<dot_red>Arrows Color", 255, 255, 255, 255):depend({
	tab_selector,
	var_0_6("\xF5\x0FP\xC7Fr7", "D\xA3f#\xB2'\x1E")
}, {
	vis_desync_arrows_style,
	var_0_6("\x9Ay\xC9\xC6\x01\xB9\x86\x15", "q\xDE\x10\xBA\xA7c\xD5\xE3"),
	true
})
vis_desync_arrows_distance = var_0_40:slider("\f<dot_red>Arrows Distance", 15, 150, 60, true, var_0_6(">\x16", "\x96Nn\x9B")):depend({
	tab_selector,
	var_0_6("\xB3\xCC4\xF4\xA5\x12\xAC", " \xE5\xA5G\x81\xC4~\xDF")
}, {
	vis_desync_arrows_style,
	var_0_6("\xE7\x80׀\x83\xD9ƍ", "\xB5\xA3\xE9\xA4\xE1\xE1"),
	true
})
vis_dmg_indicator_enable = var_0_40:checkbox("\f<dot_red>Damage Indicator"):depend({
	tab_selector,
	var_0_6("f\x82-bQ\x87-", "\x170\xEB^")
})
dmg_indicator_color = var_0_40:color_picker("\f<dot_red>Damage Indicator Color", 255, 165, 0, 255):depend({
	tab_selector,
	var_0_6("J\xD3\xCBHV?\xC1", "\xB2\x1C\xBA\xB8=7S")
}, vis_dmg_indicator_enable)
vis_watermark = var_0_40:checkbox(var_0_6("\xF3\xCCS9\xE0\x03\xF4\xD6\xC6", "\x95\xA4\xAD'\\\x92n")):depend({
	tab_selector,
	var_0_6("\xC5.\x03\n\x1B\x17\xE0", "{\x93Gp\x7Fz")
})
vis_watermark_mode = var_0_40:combobox(var_0_6("\xFB̖tT\xC1̐z\x06\xE1\xC2\x86t", "&\xAC\xAD\xE2\x11"), var_0_6("\x0E@", "\x8F-qL")):depend({
	tab_selector,
	var_0_6("\x8E\xB1\x0F)\xB9\xB4\x0F", "\\\xD8\xD8|")
}, vis_watermark)
vis_watermark_position = var_0_40:combobox(var_0_6("k=\xBFI\xE9R=\xA2", "\x9D;R\xCC "), var_0_6("\x14;\xE5\xEE", "\xD1X^\x83\x9A\x89\x8A\xB3"), var_0_6("\x1A\xA8\xC3t\n", "BH\xC1\xA4\x1C~CQ")):depend({
	tab_selector,
	var_0_6("\xD1%\xBBM'z\xF4", "\x16\x87L\xC88F")
}, vis_watermark, {
	vis_watermark_mode,
	var_0_6("\xCEa", "\x81\xEDP\x98D=")
})
vis_watermark_label = var_0_40:label(var_0_6("f\xA9\x10\xF6\x0E\x1AYC\xA3D\xD0\x13\x1BWC\xE8\"\xFA\x0E\x04L", "81\xC8d\x93|w")):depend({
	tab_selector,
	var_0_6("\xFA7\xAC\xE5\xCD2\xAC", "\x90\xAC^\xDF")
}, vis_watermark, {
	vis_watermark_mode,
	var_0_6("g^", "'Do\xC2")
})
vis_watermark_color = var_0_40:color_picker(var_0_6("\xE1\xA7\xF3\xC2k\xBA״\xEC\x87Z\xB8ک\xF5", "׶Ƈ\xA7\x19"), 155, 155, 200, 255):depend({
	tab_selector,
	var_0_6("\xBB@\xF9]\x8CE\xF9", "(\xED)\x8A")
}, vis_watermark, {
	vis_watermark_mode,
	var_0_6("\x84%", "*\xA7\x14\x9A\x98")
})
vis_watermark_label2 = var_0_40:label(var_0_6("}\xFF\xB6Gc,K\xEC\xA9\x02R.F\xF1\xB0\x02B$I\xF1\xACF", "A*\x9E\xC2\"\x11")):depend({
	tab_selector,
	var_0_6(",.A\x19,\xE1\b", "\x8EzG2lM\x8D{")
}, vis_watermark, {
	vis_watermark_mode,
	var_0_6("V\xF3", "[u\xC2\x9Fx")
})
vis_watermark_color2 = var_0_40:color_picker(var_0_6("-\x1C*\x1D'\xFC%\b\x16~;:\xFD+\b]l", "Dz}^xU\x91"), 0, 0, 0, 255):depend({
	tab_selector,
	var_0_6("!\x15\xDCK\xC9թ", "\xDAw|\xAF>\xA8\xB9")
}, vis_watermark, {
	vis_watermark_mode,
	var_0_6("\xE6\xA1", "\xA4Ő(")
})
vis_watermark_items = var_0_40:multiselect(var_0_6("\xAA䯆\xCE", "\xD6\xE3\x90\xCA\xEB\xBD"), var_0_6("ض\x82i\x1E\xB2^9", "\\\x8D\xC5\xE7\x1Bp\xD33"), var_0_6("\xCA\xFE\x9E\xA6\xDF\xE5\xE6", "\xB1\x86\x9F\xEA\xC3"), var_0_6("\x9B\xF9>\xAD̯\xEA+\xA5", "\xA9݋_\xC0"), var_0_6("\xEA\x82r:", "F\xBE\xEB\x1F_B")):depend({
	tab_selector,
	var_0_6("\x8C\xEB\t\xF3\xE4\xB6\xF1", "\x85ڂz\x86")
}, {
	vis_watermark_mode,
	var_0_6("\x7F\xAD", "X\\\x9F\x83\xA4\xBC\xC3")
})
vis_watermark_color_mode_2 = var_0_40:color_picker(var_0_6("\xB7/\xABN\xC5\xE6ܒ%\xFFh\xD8\xE7Ғn\x92D\xD3\xEE\x9D\xD2", "\xBD\xE0N\xDF+\xB7\x8B"), 155, 155, 200, 255):depend({
	tab_selector,
	var_0_6("\x18\xF5\x99\x03\xC0\"\xEF", "\xA1N\x9C\xEAv")
}, vis_watermark, {
	vis_watermark_mode,
	var_0_6("\xE4\xE5", "\xBC\xC7ש")
})
trash_talk_enable = var_0_40:checkbox("\f<dot_red>Trash Talk"):depend({
	tab_selector,
	var_0_6("\xD1\x00Lx", "\x88\x9Ci?\x1B")
})
clantag_enable = var_0_40:checkbox("\f<dot_red>ClanTag (KRIM)"):depend({
	tab_selector,
	var_0_6("6\x85j7", "T{\xEC\x19")
})
fast_ladder_enable = var_0_40:checkbox("\f<dot_red>Fast ladder"):depend({
	tab_selector,
	var_0_6("݂\xB9\x14", "Ր\xEB\xCAw\xCC")
})
animation_breaker_enable = var_0_40:checkbox("\f<dot_red>Animation Breaker"):depend({
	tab_selector,
	var_0_6("\x0E\x11\xCD)", "-Cx\xBEJHC")
})
animation_breaker_condition = var_0_40:combobox("\f<dot_red>Condition", {
	var_0_6("\x127\xE3\xAB\xF0\x86\xE9", "\x89@B\x8Dř\xE8\x8E"),
	var_0_6("*\xDEb\xA7\x81\x11", "\xE8c\xB0B\xC6")
}):depend({
	tab_selector,
	var_0_6("\xC1(;\x05", "L\x8CAHf\x1B\xED\x99")
}, animation_breaker_enable)
animation_breaker_running_type = var_0_40:combobox("\f<dot_red>Running Animation", {
	"-",
	var_0_6("y\xCE\x17\xC6\xDE\x02", "\xDE*\xBAv\xB2\xB7a"),
	var_0_6("w\xE5P\x9EX\xFE", "\xEA=\x8C$"),
	var_0_6("\x00Ѯw\x1D/ܮ{\x19$\x9D\xB0{\x1B5ب", "oA\xBD\xDA\x12"),
	var_0_6("bG\x174\x03", "\xCF#+{Uk<")
}):depend({
	tab_selector,
	var_0_6("]\xA3\xB3\xE9", "\x19\x10\xCA\xC0\x8A")
}, animation_breaker_enable, {
	animation_breaker_condition,
	var_0_6("\xCFޣ\xEC\xA0\xFA\xFA", "\x94\x9D\xAB͂\xC9")
})
animation_breaker_running_min_jitter = var_0_40:slider("\f<dot_red>Running Min Jitter", 0, 100, 0, true, "%"):depend({
	tab_selector,
	var_0_6("\x0E\xDDg*", "\x96C\xB4\x14I\xB1")
}, animation_breaker_enable, {
	animation_breaker_condition,
	var_0_6("\xBF\r\x14C\x84\x16\x1D", "-\xEDxz")
}, {
	animation_breaker_running_type,
	var_0_6("\xFD\xE1\xB68\xD2\xFA", "L\xB7\x88\xC2")
})
animation_breaker_running_max_jitter = var_0_40:slider("\f<dot_red>Running Max Jitter", 0, 100, 100, true, "%"):depend({
	tab_selector,
	var_0_6("W\xEF\xF6;", "t\x1A\x86\x85X0/")
}, animation_breaker_enable, {
	animation_breaker_condition,
	var_0_6(",Ԯ\xEA\xB4|\x19", "\x12~\xA1\xC0\x84\xDD")
}, {
	animation_breaker_running_type,
	var_0_6("u!\xBA\x10SM", "6?H\xCEd")
})
animation_breaker_running_extra = var_0_40:multiselect("\f<dot_red>Running Extra", {
	var_0_6("\xEAVAc\xA5w\xCDXK", "\x1B\xA89%\x1A\x85")
}):depend({
	tab_selector,
	var_0_6("\x00\xA3o\xAB", "\xB7M\xCA\x1C\xC8")
}, animation_breaker_enable, {
	animation_breaker_condition,
	var_0_6("%&\x87\x06\x1E=\x8E", "hwS\xE9")
})
animation_breaker_running_bodylean = var_0_40:slider("\f<dot_red>Running Body Lean", 0, 100, 70, true, "%"):depend({
	tab_selector,
	var_0_6("\xD8\xF14!", "#\x95\x98GB")
}, animation_breaker_enable, {
	animation_breaker_condition,
	var_0_6("+\xFDL\xBE3\x17\xEF", "Zy\x88\"\xD0")
}, {
	animation_breaker_running_extra,
	var_0_6("\xE5\x01Q\a\x87\x02P\x1F\xC9", "~\xA7n5")
})
animation_breaker_air_type = var_0_40:combobox("\f<dot_red>Air Animation", {
	"-",
	var_0_6("\x0E\x04/\xEC\xD5<", "_]pN\x98\xBC"),
	var_0_6("\xEB\xFC\x91\x01\xE1\xAC", "\xB2\xA1\x95\xE5u\x84\xDE"),
	var_0_6("\xA9\xD7ѭ\xA9", "C軽\xCC\xC1v\xC6")
}):depend({
	tab_selector,
	var_0_6("\xA6'\xA6#", "\x8F\xEBN\xD5@[b")
}, animation_breaker_enable, {
	animation_breaker_condition,
	var_0_6("\xA4F\xC4\xE8y\xA4", "\xD6\xED(\xE4\x89\x10")
})
animation_breaker_air_min_jitter = var_0_40:slider("\f<dot_red>Air Min Jitter", 0, 100, 0, true, "%"):depend({
	tab_selector,
	var_0_6("\xA8\xEA\xFC\xDA", "\xC6像\xB9c")
}, animation_breaker_enable, {
	animation_breaker_condition,
	var_0_6("x\x82\xE8rX\x9E", "\x131\xEC\xC8")
}, {
	animation_breaker_air_type,
	var_0_6("\xD4>\xE2\xA3\xE1\xA8", "ڞW\x96ׄ")
})
animation_breaker_air_max_jitter = var_0_40:slider("\f<dot_red>Air Max Jitter", 0, 100, 100, true, "%"):depend({
	tab_selector,
	var_0_6("\xD6\x17\xCA\xE1", "\xAD\x9B~\xB9\x82VB")
}, animation_breaker_enable, {
	animation_breaker_condition,
	var_0_6("̨\xFAƁ\xFE", "\x8C\x85\xC6ڧ\xE8")
}, {
	animation_breaker_air_type,
	var_0_6("\x9F'\xA0i\x81\xA7", "\xE4\xD5N\xD4\x1D")
})
animation_breaker_air_extra = var_0_40:multiselect("\f<dot_red>Air Extra", {
	var_0_6("\xA5C\xB2\x1C\xAB\x8BI\xB7\v", "\x8B\xE7,\xD6e"),
	var_0_6("\xE3\xEA\x14QP\xA18\x02\xDA\xE7FQ\x1E\xF1=\x17\xD7\xEB\x0FP\x17", "v\xB9\x8Ff>p\xD1Q")
}):depend({
	tab_selector,
	var_0_6("qy:\xE5", "X<\x10I\x86\xC5u|")
}, animation_breaker_enable, {
	animation_breaker_condition,
	var_0_6("y\xE4\xB8\xC9HB", "!0\x8A\x98\xA8")
})
animation_breaker_air_bodylean = var_0_40:slider("\f<dot_red>Air Body Lean", 0, 100, 70, true, "%"):depend({
	tab_selector,
	var_0_6("_\x1F#R", "W\x12vP1\xA1")
}, animation_breaker_enable, {
	animation_breaker_condition,
	var_0_6("e\x10\x9A\xA1\xB9^", "\xD0,~\xBA\xC0")
}, {
	animation_breaker_air_extra,
	var_0_6("\xD5\x15\xA0\xDFT\xF0\xCCO\xF9", ".\x97zĦt\x9C\xA9")
})

local var_0_47 = {}
local var_0_48 = {
	[var_0_6("\xEB\xECK\x1F", "\x9B\x85\x8D&z")] = {
		var_0_6("\x01/\xAA@Zs\xB1", "\xC5EJ\xCC!/\x1F")
	},
	[var_0_6("\xF3I]", "\xE7\x90/:")] = {
		var_0_6("\xA9\xC5", "YҸ\xBA\x15x]\xAF")
	}
}

local function var_0_49()
	local var_48_0 = 0
	local var_48_1

	while true do
		if var_48_0 == 0 then
			local var_48_2 = var_0_13.stringify(var_0_48)

			var_0_9.set(var_0_6("\x9AaU\xF8F\x1B\x84gS\xEAZ\x15\x9FuU\xF2#", "Z\xD13\x1C\xB5\x19") .. var_0_12.encode(var_48_2))

			break
		end
	end
end

var_0_48 = var_0_48 or {
	[var_0_6("\xDEzZ\xEB", "߰\x1B7\x8E")] = {
		var_0_6("\x00\xBEȴ1\xB7\xDA", "\xD5Dۮ")
	},
	[var_0_6("\b\xE6$", "\x1Fk\x80C\x87J\xA5_")] = {
		"eyJ0aW1lc3RhbXAiOjQwNzQ5LCJ2ZXJzaW9uIjoiMS4wIiwic2V0dGluZ3MiOnsidmlzX2Rlc3luY19hcnJvd3NfY29sb3IiOjI1NSwidHJhc2hfdGFsa19lbmFibGUiOmZhbHNlLCJjdXN0b21fc2NvcGVfZW5hYmxlZCI6dHJ1ZSwidmlzX2Rlc3luY19hcnJvd3NfZGlzdGFuY2UiOjYwLCJhYV9zeXNfN19tb2RfdHlwZSI6IlNraXR0ZXIiLCJkbWdfaW5kaWNhdG9yX2NvbG9yIjoyNTUsImFhX3N5c183X3lhd19yaWdodCI6MTYsImFhX3N5c181X2VuYWJsZSI6dHJ1ZSwiYWFfc3lzXzFfbW9kX2RtIjotMTAsImFhX3N5c180X3lhd190eXBlIjoiRGVsYXkiLCJ2aXNfd2F0ZXJtYXJrX2NvbG9yX21vZGVfMiI6MTU1LCJjdXN0b21fc2NvcGVfb2Zmc2V0IjoxMCwiYWFfc3lzXzdfZW5hYmxlIjp0cnVlLCJhYV9zeXNfMl95YXdfcmlnaHQiOjIzLCJ2aXNfd2F0ZXJtYXJrX21vZGUiOiIjMSIsImNmZ19uYW1lIjoiZGEiLCJhYV9zeXNfMV9tb2RfdHlwZSI6IlNraXR0ZXIiLCJhYV9zeXNfMV95YXdfcmlnaHQiOjIxLCJhYV9zeXNfNF9kZXN5bmNfbW9kZSI6IktyaW0iLCJhYV9zeXNfMl95YXdfZGVsYXkiOjQsImFhX3N5c182X21vZF9kbSI6MTAsImFhX3N5c18yX3lhd19sZWZ0IjotMTYsImFhX3N5c18zX3lhd190eXBlIjoiRGVsYXkiLCJhYV9zeXNfMl9lbmFibGUiOnRydWUsImN1c3RvbV9zY29wZV9wb3NpdGlvbiI6NTAsImFhX2NvbmRpdGlvbiI6Ilx1MDAwYkFpclxyIiwiY2ZnX2xpc3QiOjAsImFhX3N5c18xX3lhd19sZWZ0IjotMjcsImhpdGxvZ3Nfc2VsZWN0IjpbIk9uIFNjcmVlbiIsIk9uIENvbnNvbGUiXSwiYWFfc3lzXzRfZW5hYmxlIjp0cnVlLCJhYV9waXRjaCI6IkRvd24iLCJhYV9zeXNfMV95YXdfdHlwZSI6IkRlbGF5IiwiYWFfc3lzXzFfZW5hYmxlIjp0cnVlLCJhYV9zeXNfNF95YXdfcmlnaHQiOjE2LCJhYV9zeXNfNV9tb2RfdHlwZSI6IlNraXR0ZXIiLCJmbF9saW1pdCI6MSwiYWFfc3lzXzNfeWF3X3JpZ2h0IjoxNCwiZmxfdHlwZSI6IkR5bmFtaWMiLCJhYV9mc19rZXkiOmZhbHNlLCJhYV9zeXNfMl9tb2RfZG0iOjcsImFhX3N5c182X3lhd19sZWZ0IjotMTIsImFhX3N5c18yX2Rlc3luY19tb2RlIjoiS3JpbSIsImFhX3N5c18zX21vZF90eXBlIjoiU2tpdHRlciIsImFhX3N5c181X21vZF9kbSI6LTE2LCJ2aXNfZGVzeW5jX2Fycm93c19zdHlsZSI6IkRpc2FibGVkIiwib3RoX3N3IjpmYWxzZSwiYWFfc3lzXzFfZGVzeW5jX21vZGUiOiJLcmltIiwidmlzX3dhdGVybWFya19jb2xvciI6MTU1LCJhbmltYXRpb25fYnJlYWtlciI6WyJlYXJ0aHF1YWtlIiwic2xpZGluZyBzbG93IG1vdGlvbiIsInNsaWRpbmcgY3JvdWNoIiwib24gZ3JvdW5kIiwiYWVyb2JpYyIsInF1aWNrIHBlZWsgbGVncyJdLCJhYV9zeXNfNF9tb2RfZG0iOi0xMiwiYWFfc3lzXzVfeWF3X2RlbGF5Ijo0LCJjbGFudGFnX2VuYWJsZSI6dHJ1ZSwiYWFfc3lzXzVfeWF3X2xlZnQiOi0xMCwiaGl0cmF0ZV9jb2xvciI6MTEzLCJ2aXNfd2F0ZXJtYXJrX2NvbG9yMiI6MCwidmlzX3dhdGVybWFyayI6dHJ1ZSwiYWFfc3lzXzVfZGVzeW5jX21vZGUiOiJLcmltIiwib3RoX29zYWFfa2IiOmZhbHNlLCJhYV9zeXNfNV95YXdfdHlwZSI6IkRlbGF5IiwiYWFfc3lzXzZfeWF3X3JpZ2h0IjoxMiwidmlzX2RtZ19pbmRpY2F0b3JfZW5hYmxlIjp0cnVlLCJhYV9zeXNfN19kZXN5bmNfbW9kZSI6IktyaW0iLCJjdXN0b21fc2NvcGVfbW9kZSI6IkRlZmF1bHQiLCJjdXN0b21fc2NvcGVfY29sb3IiOjI1NSwiYWFfc3lzXzNfeWF3X2xlZnQiOi0xOCwic2FmZV9oZWFkX2VuYWJsZWQiOnRydWUsImFhX3N5c181X3lhd19yaWdodCI6MTYsIm90aF9sbSI6IkRpc2FibGVkIiwibWlzc2xvZ3Nfc2VsZWN0IjpbIk9uIFNjcmVlbiIsIk9uIENvbnNvbGUiXSwiYWFfc3lzXzJfeWF3X3R5cGUiOiJEZWxheSIsImZsX3ZhcmlhbmNlIjowLCJhYV9zeXNfM19kZXN5bmNfbW9kZSI6IktyaW0iLCJ2aXNfd2F0ZXJtYXJrX2l0ZW1zIjp7fSwiYWFfc3lzXzdfeWF3X3R5cGUiOiJEZWxheSIsImFhX3N5c18zX21vZF9kbSI6LTE0LCJ0YWJfc2VsZWN0b3IiOiJDb25maWciLCJhYV9mc19lbmFibGUiOnRydWUsInNhZmVfaGVhZF9zdGF0ZXMiOlsiQWlyIEtuaWZlIiwiQWlyIFpldXMiLCJTdGFuZGluZyIsIkNyb3VjaGVkIiwiQ3JvdWNoZWQgQWlyIl0sImVuYWJsZV9mbCI6ZmFsc2UsIm90aF9zd19rYiI6ZmFsc2UsImFhX3N5c18yX21vZF90eXBlIjoiU2tpdHRlciIsImFhX3N5c18xX3lhd19kZWxheSI6NCwiYWFfc3lzXzNfeWF3X2RlbGF5Ijo0LCJhYV9zeXNfM19lbmFibGUiOnRydWUsImF2b2lkX2JhY2tzdGFiX2VuYWJsZWQiOnRydWUsIm9uX2dyb3VuZF9vcHRpb25zIjoic3dhZyIsImFhX3N5c180X3lhd19kZWxheSI6NCwiYWFfc3lzXzdfeWF3X2RlbGF5Ijo0LCJhYV9zeXNfNF95YXdfbGVmdCI6LTE5LCJhYV9zeXNfNF9tb2RfdHlwZSI6IlNraXR0ZXIiLCJhYV90YWIiOiJCdWlsZGVyIiwiYWFfc3lzXzdfbW9kX2RtIjotMTksIm90aF9vc2FhIjpmYWxzZSwidmlzX3dhdGVybWFya19wb3NpdGlvbiI6IkxlZnQiLCJvbl9haXJfb3B0aW9ucyI6InN3YWciLCJhYV9zeXNfNl95YXdfZGVsYXkiOjQsImFhX3N5c182X2Rlc3luY19tb2RlIjoiS3JpbSIsImFhX3N5c182X21vZF90eXBlIjoiU2tpdHRlciIsImhpdHJhdGVfZW5hYmxlZCI6dHJ1ZSwiYWFfc3lzXzdfeWF3X2xlZnQiOi0xMiwiYWFfc3lzXzZfeWF3X3R5cGUiOiJEZWxheSIsImFhX3lhd19iYXNlIjoiQXQgVGFyZ2V0cyIsImFhX3N5c182X2VuYWJsZSI6dHJ1ZX19"
	}
}

if not var_0_48.name then
	var_0_48.name = {
		var_0_6("\xFC\xED\xFALT\xBD\xCC", "Ѹ\x88\x9C-!")
	}
end

if not var_0_48.cfg then
	var_0_48.cfg = {
		"{\"aa_sys_1_enable\":true,\"aa_sys_1_mod_type\":\"Skitter\",\"aa_sys_1_mod_dm\":-10,\"aa_sys_1_yaw_type\":\"Delay\",\"aa_sys_1_yaw_delay\":4,\"aa_sys_1_yaw_left\":-27,\"aa_sys_1_yaw_right\":21,\"aa_sys_1_desync_mode\":\"Krim\",\"aa_sys_2_enable\":true,\"aa_sys_2_mod_type\":\"Skitter\",\"aa_sys_2_mod_dm\":7,\"aa_sys_2_yaw_type\":\"Delay\",\"aa_sys_2_yaw_delay\":4,\"aa_sys_2_yaw_left\":-16,\"aa_sys_2_yaw_right\":23,\"aa_sys_2_desync_mode\":\"Krim\",\"aa_sys_3_enable\":true,\"aa_sys_3_mod_type\":\"Skitter\",\"aa_sys_3_mod_dm\":-14,\"aa_sys_3_yaw_type\":\"Delay\",\"aa_sys_3_yaw_delay\":4,\"aa_sys_3_yaw_left\":-18,\"aa_sys_3_yaw_right\":14,\"aa_sys_3_desync_mode\":\"Krim\",\"aa_sys_4_enable\":true,\"aa_sys_4_mod_type\":\"Skitter\",\"aa_sys_4_mod_dm\":-12,\"aa_sys_4_yaw_type\":\"Delay\",\"aa_sys_4_yaw_delay\":4,\"aa_sys_4_yaw_left\":-19,\"aa_sys_4_yaw_right\":16,\"aa_sys_4_desync_mode\":\"Krim\",\"aa_sys_5_enable\":true,\"aa_sys_5_mod_type\":\"Skitter\",\"aa_sys_5_mod_dm\":-16,\"aa_sys_5_yaw_type\":\"Delay\",\"aa_sys_5_yaw_delay\":4,\"aa_sys_5_yaw_left\":-10,\"aa_sys_5_yaw_right\":16,\"aa_sys_5_desync_mode\":\"Krim\",\"aa_sys_6_enable\":true,\"aa_sys_6_mod_type\":\"Skitter\",\"aa_sys_6_mod_dm\":10,\"aa_sys_6_yaw_type\":\"Delay\",\"aa_sys_6_yaw_delay\":4,\"aa_sys_6_yaw_left\":-12,\"aa_sys_6_yaw_right\":12,\"aa_sys_6_desync_mode\":\"Krim\",\"aa_sys_7_enable\":true,\"aa_sys_7_mod_type\":\"Skitter\",\"aa_sys_7_mod_dm\":-19,\"aa_sys_7_yaw_type\":\"Delay\",\"aa_sys_7_yaw_delay\":4,\"aa_sys_7_yaw_left\":-12,\"aa_sys_7_yaw_right\":16,\"aa_sys_7_desync_mode\":\"Krim\",\"aa_pitch\":\"Down\",\"aa_yaw_base\":\"At Targets\",\"aa_tab\":\"Builder\",\"safe_head_enabled\":true,\"avoid_backstab_enabled\":true,\"fast_ladder_enable\":false}"
	}
end

local var_0_50 = var_0_40:button(var_0_6("\"\xD0e\a\xAA\x13\x88V\a\xB6\x01\xC1r", "\xD8g\xA8\x15h")):depend({
	tab_selector,
	var_0_6("[\xA2M\xA2q\xAA", "\xC4\x18\xCD#")
})
local var_0_51 = var_0_40:button(var_0_6("\a\x86\xF3\t<\x9F\xA3%!\x85\xE5\x0F)", "fN\xEB\x83")):depend({
	tab_selector,
	var_0_6("\xD9!:BN>", "T\x9ANT$'Y\xD7")
})
local var_0_52 = var_0_40:button(var_0_6("\xCE\xE0@]E\xFE\xEEX^\f\xFA\xA1BWE\xF9\xE0BY\a\xFC\xF2S", "e\x9D\x8168")):depend({
	tab_selector,
	var_0_6(">\xA6\x84\xAD*~", "\x19}\xC9\xEA\xCBC")
})
local var_0_53 = var_0_40:button(var_0_6("U\xFB\x19\aT$\x1Cw\xF2\x11\x04T!\x01v\xF9X\a\x153\x12{\xF5\v\x06", "s\x19\x94xctG")):depend({
	tab_selector,
	var_0_6("/2\xB7\"H\v", "!l]\xD9D")
})
local var_0_54 = var_0_40:button(var_0_6("\xF7D\xA0\xA9\x9Bo\xA4\xAB\xDA^\xAD\xB9", "ͻ+\xC1")):depend({
	tab_selector,
	var_0_6("\xDD}\v\xD9\xF7u", "\xBF\x9E\x12e")
})
local var_0_55 = {}

local function var_0_56(arg_49_0)
	local var_49_0 = 0
	local var_49_1

	while true do
		if var_49_0 == 1 then
			return var_49_1
		end

		if var_49_0 == 0 then
			var_49_1 = 0

			for iter_49_0 in pairs(arg_49_0) do
				local var_49_2 = var_49_1 + 1
			end

			var_49_0 = 1
		end
	end
end

local var_0_57 = {
	[var_0_6("\xC4¸\xA7\xA6\xD1\xC0\x8F", "ϥ\xA3\xE7\xD7")] = var_0_6("\xE2\xF6\xEEX", "\x10\xA6\x99\x996D"),
	[var_0_6("Ӳ\xFF_56\xC6в\xD3C", "\x99\xB2Ӡ&TA")] = var_0_6("\xA3\x1F\x1A\x1F\x83\x19].\x96\x18", "K\xE2k:"),
	[var_0_6("Y\xDF.|\x02\xFD\xC8V\xDF\x13v\x14", "\xAD8\xBEq\x1Aq\xA2")] = true,
	[var_0_6("\xCA\xDF\x12\x03\xE4\xF4\xD5(\x1C", "\x97\xAB\xBEMe")] = false,
	[var_0_6("\xD6.\xFE\xAC\xC7u\x0E\xC4+Ǭ\xF6|\t\xC9*\xFC", "k\xA5O\x98ɘ\x1D")] = true,
	[var_0_6("DO\xEE\xCEkwRO\xEC\xF4GkVZ\xED\xD8", "\x1F7.\x88\xAB4")] = {
		var_0_6("\xF0!δ\xFA&\xD5\xF2\xD4", "\x94\xB1H\xBC"),
		var_0_6("\x87\xBFE\x93\x9C\xB3B\xC0", "\xB3\xC6\xD67"),
		var_0_6("\xC3\x18sxA\xDA\xFE\v", "\xB3\x90l\x12\x16%"),
		var_0_6("\xE5\xB1\x14\x9C\xCCΦ\x1F", "\xAF\xA6\xC3{\xE9"),
		var_0_6("\xCC\xD0R\\\xF3\xE7\xC7Y\t\xD1\xE6\xD0", "\x90\x8F\xA2=)")
	},
	[var_0_6("\xE1\xC5\x12Yv\xB81\xE1\xD0\x16Cf\x861\xDF\xD6\x13Qp\x8B6\xE4", "S\x80\xB3}0\x12\xE7")] = true,
	[var_0_6("\\\xB6\xCC\xDEH\x10Y\xBE\xE7\xD4H\x10", "~=ד\xBD'")] = var_0_6("Y\xF6\x0F", "%\x18\x9F}"),
	[var_0_6("ߨt@֣JD\xD6", "\"\xBA\xC6\x15")] = false,
	[var_0_6("\xFE\x04\xFAQ\xCB\xF5\x01\xD1", "\xA2\x98h\xA5=")] = 1,
	[var_0_6("\xCB#\x8Dkq\xF7\xC4.\xBC~u", "\x85\xADO\xD2\x1D\x10")] = 0,
	[var_0_6("\x8Bp\xD2?\x94l\xE8", "K\xED\x1C\x8D")] = var_0_6("\xF8F°\"\x12\xE4", "\x81\xBC?\xAC\xD1O{\x87"),
	[var_0_6("O\xF0\xEE\xF2S\xF3", "\xAD \x84\x86")] = var_0_6("j\x12\x1B\xEE\xAC=\xC8J", "\xAD.{h\x8F\xCEQ"),
	[var_0_6("\xBB\t*\xB5V\x94>\xBF\x1F", "a\xD4}B\xEA%\xE3")] = false,
	[var_0_6("\x85\xF7\xBE\n\x12\x87", "~\xEA\x83\xD6U")] = var_0_6("\xA0\xDCZ[M\x88\xD0M", "/\xE4\xB5):"),
	[var_0_6("\xA9\xE8\xD1\x04\f#\x1E\xA7", "\x7FƜ\xB9[cP")] = false,
	[var_0_6("\xFA\x0E\xC4Ϩ\x188\xDF\xCA\x11\xCE", "\xBE\x95z\xAC\x90\xC7kY")] = false,
	[var_0_6(":\f\xE5\xF2\xF15\x16\xCE\xED\xFB>\x00\xF2\xEA", "\x9ERe\x91\x9E")] = {
		var_0_6("_\xF0B%Gb\xFB\a\x18", "$\x10\x9Ebv"),
		var_0_6("\xEF\x18\x83\xD8W\xE64\xEA\xCC\x13", "\x85\xA0v\xA3\x9B8\x88G")
	},
	[var_0_6("\xFB\xABb\xE1\xBA\x10\xB2\xE5\x9Db\xF7\xBA\x1A\xB6\xE2", "Ֆ\xC2\x11\x92\xD6\x7F")] = {
		var_0_6("4\xA7\xE4\xE7E\xB6\xA73\x15", "V{\xC9Ĵ&\xC4\xC2"),
		var_0_6("\xD8晌\xF8\xE6ʠ\xFB\xED", "ϗ\x88\xB9")
	},
	[var_0_6("\xAB\x96;\x96{uN\xBB\x80'\x92qGt\xA6\x82*\x8Eq|", "\x11\xC8\xE3H\xE2\x14\x18")] = true,
	[var_0_6("\xB3T\b\xC3\xC6\xFC\xD0\xEC\xB3N\v\xD2\xF6\xF2\xE0\xF3\xBFS", "\x9F\xD0!{\xB7\xA9\x91\x8F")] = 255,
	[var_0_6("\xF1O+\"\xFDW\a%\xF1U(3\xCDW72\xF7", "V\x92:X")] = var_0_6("|\xDA\xEC\xC1\xBB\xE5\"", "\x9A8\xBF\x8A\xA0ΉV"),
	[var_0_6("\x85L\xE6\x93s7\xBE߅V\xE5\x82C*\x8EߏM\xFC\x88r", "\xAC\xE69\x95\xE7\x1CZ\xE1")] = 50,
	[var_0_6("\x01\xBF\x95\xC6'\xD6=\xB9\x85\xDD8\xDE=\xA5\x80\xD4;\xDE\x16", "\xBBb\xCA\xE6\xB2H")] = 10,
	[var_0_6(")\xE8\xB0\"K5\xE4\x9B5D \xE3\xA85N", "*A\x81\xC4P")] = true,
	[var_0_6("\x14CN\xE5\x13\x02\x11\xF7\fIb\xDB\x05\x15\r\xF9\x11uN\xCE\x0E\v\a", "\x8Eb*=\xBAwgb")] = var_0_6("\x1C\xB6\x11\t:\xB3\a\f", "hX\xDFb"),
	[var_0_6("R\xFE\xF1\xF1\x06\xE8W\xEE\xEC\xCD=\xECV\xE5\xED\xD9\x11\xD2G\xF8\xEE\xC1\x10", "\x8D$\x97\x82\xAEb")] = 255,
	[var_0_6("\x92s\xD12\x80\x7F\xD1\x14\x8Ay\xFD\f\x96h\xCD\x1A\x97E\xC6\x04\x97n\xC3\x03\x87\x7F", "m\xE4\x1A\xA2")] = 60,
	[var_0_6("H\xEC\xEEG\xE4\xEBY\xDA\xF4v\xE4\xEF]\xE4\xE9w\xF2\xD9[\xEB\xFCz\xEC\xE3", "\x86>\x85\x9D\x18\x80")] = true,
	[var_0_6("\x03\xA8\x1D\xE6&\xBF\xD2\x0E\xA6\x1B\xCD \xA3\xE9\x04\xAA\x16\xD6=", "\xB6g\xC5z\xB9O\xD1")] = 255,
	[var_0_6("\xE5\x8E\xF2H\x17I\xE7\x82\xF3z\x01Z\xF8", "(\x93\xE7\x81\x17`")] = true,
	[var_0_6("c\xF1\x9Fz\xAC\xAD\xC8p\xEA\x81D\xA9\xA7\xE3v\xF7\x80J\xA9", "\xBC\x15\x98\xEC%\xDB\xCC")] = 155,
	[var_0_6("V\xE0$3W\xE8#\tR\xE46\x1EK\xD64\x03L\xE6%3M\xE63\t\x7F\xBB", "l \x89W")] = 155,
	[var_0_6("\xBC\xE1\x13\x998\xF8_\\\xB8\xE5\x01\xB4$\xC6FV\xAE\xED", "9ʈ`\xC6O\x99+")] = var_0_6("\xE8r", "\x98\xCBC\xCA\xC7\xED\xC7"),
	[var_0_6("\xECJ\xB30\btm\xE3\xE8N\xA1\x1D\x14Ji\xE9\xE9J\xB4\x06\x10{", "\x86\x9A#\xC0o\x7F\x15\x19")] = var_0_6("\x94#\x0F\x1E", "\xB2\xD8Fij@"),
	[var_0_6(")\"i\xC9\xDE\xD4\xC0\x85-&{\xE4\xC2\xEAݔ:&i", "\xE0_K\x1A\x96\xA9\xB5\xB4")] = {},
	[var_0_6("\n\xD4\xD1%E\xB8\x7F\x04\xD4\xE7*V\xA9w\x00\xDF\xCA", "\x16k\xBA\xB8H$\xCC")] = {
		var_0_6("\xE2\xBC6Z\x06\xF6\xA8%E\v", "n\x87\xDDD."),
		var_0_6("\xF0:\x05\xEFǽ<\xA3%\x00\xE4\xD9\xF36\xEC\"\x05\xE4\xC0", "[\x83Vl\x8B\xAE\xD3"),
		var_0_6("\xE8'\xB1\x13T\xF5,\xF8\x14O\xF4>\xBB\x1F", "=\x9BK\xD8w"),
		var_0_6("\v\xA5\xF2;J\x06\xC8\n\xAF", "\xBDd\xCB\xD2\\8i"),
		var_0_6(".T\xEF'-X\xFE", "HO1\x9D"),
		var_0_6("\x99\xA58\xBF\x83\xF0!\xB9\x8D\xBBq\xB0\x8D\xB7\"", "\xDC\xE8\xD0Q")
	},
	[var_0_6("\xF6\xB2\xE4>8[\xA6ʻ\xEB1.V\xA4", "\xC1\x95ޅPL:")] = true,
	[var_0_6("\xD2\\M\xED\xD5XC\xD7\xC5I@\xC0", "\xB2\xA6=/")] = var_0_6("\xD8E\xE6|\xC39", "^\x9B*\x88\x1A\xAA"),
	[var_0_6("\x85>\x19\xA1\x85=", "\xD5\xE4_F")] = var_0_6("\b\xAEˈs/\xA9", "\x17Jۢ\xE4"),
	[var_0_6("=\xE3@\xAA5*\xEFP\xAA\x048\xE7y\xBC>-\xF2O\xA1<*", "[Y\x86&\xCF")] = {
		{
			[var_0_6("@\xEB\xCE3\x1D\xC3.R\xEB\xF77\x1D\xC4.{\xEF\xC1;\x11\xDF3", "G$\x8E\xA8Vs\xB0")] = false,
			[var_0_6("ۤt\xBA\r\xAD__ڞb\xB6\x17\xBD^", ")\xBF\xC1\x12\xDFc\xDE6")] = false,
			[var_0_6("\xAF#\xC1/\xA4\xB8/\xD1/\x95\xBB/\xD3)\xA2\xFA", "\xCA\xCBF\xA7J")] = var_0_6("\x03\a\xDA", "\x11La\xBCS"),
			[var_0_6("\x81\"\xDF2>\x90B\xB5\x80\x18\xC9>$\x80C\xF1", "\xC3\xE5G\xB9WP\xE3+")] = -89,
			[var_0_6("\xE4\xF9\x06U\xE1\xF3\xF5\x16U\xD0\xF0\xF5\x14S\xE7\xB3", "\x8F\x80\x9C`0")] = 89,
			[var_0_6("\xBC\xD4\xF6\x17\x19\xAB\xD8\xE6\x17(\xA1\xD0\xE7", "wر\x90r")] = false,
			[var_0_6("\xCD,\xFFG\xC7:\xF0T\xCC\x16\xE0C\xDEx", "\"\xA9I\x99")] = var_0_6("\xFB\xB4[", "\xEBʌk"),
			[var_0_6("\bq2\xAD\xE74\xFE\xD3\tK-\xA9\xFEu", "\xA5l\x14TȉG\x97")] = 0
		},
		{
			[var_0_6("~\xB1-\x8Dt\xA7\"\x9E\x7F\x8B*\x86n\xBD\x14\x89s\xB9)\x87n", "\xE8\x1A\xD4K")] = false,
			[var_0_6("3Lt\xED\xF9$@d\xED\xC8'@f\xEB\xFF", "\x97W)\x12\x88")] = false,
			[var_0_6("_\xAA\xCC\xD5\xF0H\xA6\xDC\xD5\xC1K\xA6\xDE\xD3\xF6\n", "\x9E;Ϫ\xB0")] = var_0_6("`X5", "\xEC/>S)"),
			[var_0_6("\xFE\xAC&>\xA4\x91\xF3\xBF%\x04\xBA\x8B\xEE\xAA(i", "\xE2\x9A\xC9@[\xCA")] = -89,
			[var_0_6("\xC5L\x1B\x1DD\xAF\xC8_\x18'Z\xB5\xD5J\x15K", "ܡ)}x*")] = 89,
			[var_0_6("\xB8t\xA6\v\xB2b\xA9\x18\xB9N\xB9\x0F\xAB", "n\xDC\x11\xC0")] = false,
			[var_0_6("p|2\x1F\xE5$\xF8\xB1qF-\x1B\xFCf", "\xC7\x14\x19Tz\x8BW\x91")] = var_0_6("\x16Q\x8D", "\x8A'i\xBD\xCE{"),
			[var_0_6("\x1B\x02\x8F(\xFD\xEA\xC6\xE9\x1A8\x90,\xE4\xAB", "\x9F\x7Fg\xE9M\x93\x99\xAF")] = 0
		},
		{
			[var_0_6("\x03\xF5\xE2\xAFN\xD8\x0E\xE6\xE1\x95A\xC5\x13\xF9۫I\xC6\x05\xFF\xF0", "\xABg\x90\x84\xCA ")] = false,
			[var_0_6("\x14*\xEF\t\x1E<\xE0\x1A\x15\x10\xF9\x05\x04,\xE1", "lpO\x89")] = false,
			[var_0_6(";\xC7r-\xA3\x12\xE0#:\xFDd!\xB9\x02\xE1d", "U_\xA2\x14H\xCDa\x89")] = var_0_6("\xD8\xFB,", "\xAD\x97\x9DJ\xBCm\x98"),
			[var_0_6(" \r>\xD8\xD2G\xDC\xE5!7(\xD4\xC8Wݡ", "\x93DhX\xBD\xBC4\xB5")] = -89,
			[var_0_6("\x1E\x8D\x8D\xD5\x14\x9B\x82\xC6\x1F\xB7\x9B\xD9\x0E\x8B\x83\x83", "\xB0z\xE8\xEB")] = 89,
			[var_0_6("\x84p<J\xE0\x93|,Jљt-", "\x8E\xE0\x15Z/")] = false,
			[var_0_6("p\xD1!S\xAA\x98\x8Cb\xD1\x18O\xA5\x9C\xD4", "\xE5\x14\xB4G6\xC4\xEB")] = var_0_6("x&\x91", "\xE0I\x1E\xA1\x83\x95\xCA"),
			[var_0_6("\xF5\xE0\xF7U\xFF\xF6\xF8F\xF4\xDA\xE8Q\xE6\xB7", "0\x91\x85\x91")] = 0
		},
		{
			[var_0_6("^I\xB3\xEB\xDF?SZ\xB0\xD1\xD0\"NE\x8A\xEF\xD8!XC\xA1", "L:,Վ\xB1")] = false,
			[var_0_6("\xCF!\x14(v\xD8-\x04(G\xDB-\x06.p", "\x18\xABDrM")] = false,
			[var_0_6("\xEB\x18VW\x89\xCD\r\xBB\xEA\"@[\x93\xDD\f\xFC", "͏}02\xE7\xBEd")] = var_0_6("\xEE\xA1\x12", "¡\xC7te\x81\x83\xBF"),
			[var_0_6("\xE8!έ\xF9\xB1\xE52͗\xE7\xAB\xF8'\xC0\xFA", "\xC2\x8CD\xA8ȗ")] = -89,
			[var_0_6("F\xFE\xD3 \xFBQ\xF2\xC3 \xCAR\xF2\xC1&\xFD\x11", "\x95\"\x9B\xB5E")] = 89,
			[var_0_6("\a\xF8\xD3\xFF\r\xEE\xDC\xEC\x06\xC2\xCC\xFB\x14", "\x9Ac\x9D\xB5")] = false,
			[var_0_6("\x89\n\xEA\xA5\xE2\x9E\x06\xFA\xA5Ӕ\x0E\xFB\xF1", "\x8C\xEDo\x8C\xC0")] = var_0_6("WA-", "xfy\x1D"),
			[var_0_6("\xA8\xE6\xBF>\xA2\xF0\xB0-\xA9ܠ:\xBB\xB1", "[̃\xD9")] = 0
		},
		{
			[var_0_6("\xCA\xFASѽ\xCE\xF7\xD8\xFAjս\xC9\xF7\xF1\xFE\\ٱ\xD2\xEA", "\x9E\xAE\x9F5\xB4ӽ")] = false,
			[var_0_6("V\xF8\xEB\xD8y\xA6[\xEB\xE8\xE2g\xBCF\xFE\xE5", "\xD52\x9D\x8D\xBD\x17")] = false,
			[var_0_6("\xFA#\x82\xA5|\xB7\xF70\x81\x9Fb\xAD\xEA%\x8C\xF1", "ĞF\xE4\xC0\x12")] = var_0_6("eY\x17", "\xB9*?q."),
			[var_0_6("\xD0\xD8'<\x15\xC7\xD47<$\xC4\xD45:\x13\x86", "{\xB4\xBDAY")] = -89,
			[var_0_6("Ɖ\xF6\xE1\x87х\xE6\xE1\xB6҅\xE4灑", "\xE9\xA2쐄")] = 89,
			[var_0_6("\xB6\xC1\xF8\x1F\xB7\xE5V\xA4\xC1\xC1\x03\xB8\xE1", "?Ҥ\x9Ezٖ")] = false,
			[var_0_6("7\xCE\xF0\xE9G\xEB:\xDD\xF3\xD3P\xF9$\x9A", "\x98S\xAB\x96\x8C)")] = var_0_6("ӽ\xD3", "h\xE2\x85\xE3S\xB4{"),
			[var_0_6("\a\x0E%U\r\x18*F\x064:Q\x14Y", "0ckC")] = 0
		},
		{
			[var_0_6("ڣ{\xD5#hװx\xEF,uʯB\xD1$vܩi", "\x1B\xBE\xC6\x1D\xB0M")] = false,
			[var_0_6("\xEBN\xFB1\xA7]\xE6]\xF8\v\xB9G\xFBH\xF5", ".\x8F+\x9DT\xC9")] = false,
			[var_0_6("S}P\xC7Q\x00\xC1A}i\xD2V\a\xCB_)", "\xA87\x186\xA2?s")] = var_0_6("8\xFC&", "\xAEw\x9A@\xE0\xB2"),
			[var_0_6(".{\xC3~\v\xB4\x13\xF2/A\xD5r\x11\xA4\x12\xB6", "\x84J\x1E\xA5\x1Be\xC7z")] = -89,
			[var_0_6("+\xE2\xF9\xA2\xA9\xA6\xBD9\xE2\xC0\xB7\xAE\xA1\xB7'\xB4", "\xD4O\x87\x9F\xC7\xC7\xD5")] = 89,
			[var_0_6("}\xA5\xB3BR\xC4\x11o\xA5\x8A^]\xC0", "x\x19\xC0\xD5'<\xB7")] = false,
			[var_0_6("\x1CE9M\x16S6^\x1D\x7F&I\x0F\x11", "(x _")] = var_0_6("k\xF3i", "\x7FZ\xCBY\x1A\xCF"),
			[var_0_6("\xD90\xA9\xCE\a\xEE\xD4#\xAA\xF4\x10\xFC\xCAg", "\x9D\xBDUϫi")] = 0
		},
		{
			[var_0_6("¤ް\rըΰ<ǯ̼<Ǩշ\f\xD2", "c\xA6\xC1\xB8\xD5")] = false,
			[var_0_6("Ҳ\x86\xBE\x02\x99ߡ\x85\x84\x1C\x83´\x88", "\xEA\xB6\xD7\xE0\xDBl")] = false,
			[var_0_6("Ą\xBD0Β\xB2#ž\xAB<Ԃ\xB3d", "U\xA0\xE1\xDB")] = var_0_6("s\x03\x85", "+<e\xE3\xA9V\xBC"),
			[var_0_6("t\xCD׺T߰!u\xF7\xC1\xB6Nϱe", "W\x10\xA8\xB1\xDF:\xAC\xD9")] = -89,
			[var_0_6("0\xC8_\xD85'\xC4O\xD8\x04$\xC4M\xDE3g", "[T\xAD9\xBD")] = 89,
			[var_0_6("\x14\xBC\n\xF9\xAE\xC5\x19\xAF\tù\xD7\a", "\xB6p\xD9l\x9C\xC0")] = false,
			[var_0_6("\xAE\rNꅹ\x01^괳\t_\xBE", "\xEB\xCAh(\x8F")] = var_0_6("\\\xD3K", "\xD9m\xEB{"),
			[var_0_6("#\x8CxS~\xC3ī\"\xB6gWg\x82", "\xDDG\xE9\x1E6\x10\xB0\xAD")] = 0
		}
	},
	[var_0_6("&\xFDY\xBA6\xF3J\x80 \xFD\\", "\xDFT\x9C>")] = var_0_6("\xE6\xEE\xE7پ8\xC2\xF5\xED\xD3", "[\xB6\x9C\x82\xBD\xD7"),
	[var_0_6("na\xA9Qwp\xB8\\q}\x93Ppr\xAEY{w", "5\x1E\x13\xCC")] = false,
	[var_0_6("\xE9\xF2u\x80\xAE\xFA\xF4y\x8B\xA9\xC6\xF6y\x97\xB2\xF8\xECy\x9E\xA2", "Ǚ\x80\x10\xE4")] = false,
	[var_0_6("\xC18\xE0\x1D\xAE\xD2>\xEC\x16\xA9\xEE9\xE8\x16\xA8\xC5\"\xEC\x17\xA0", "ǱJ\x85y")] = 50,
	[var_0_6("\xA8۹\xFA>\xC5>\xB1Ʋ\xC1:\xCF$\x87߹\xF28\xC5#\xAC\xD0", "JةܞW\xA6")] = 20,
	[var_0_6("\xF81\x16(S\xEB7\x1A#T\xD77\x1A/Q\xFB", ":\x88CsL")] = 8,
	[var_0_6("\xE1\xB8\xDD]\x8C#\xBFT\xFE\xA4\xE7X\x86#\xAEQ\xF4\xB8\xD9M\x8C/\xA5", "=\x91ʸ9\xE5@\xCB")] = false,
	[var_0_6("NW\x9AHPD\x8CUcW\x87F^^\x8CC", "'<2\xE9")] = false,
	[var_0_6("\b6\xB0#\x8E>\xB7\xB1%5\xAC>\x81-\x8D\xA1\x157\xBA\x13\x9B)\xA5", "\xC3zS\xC3L\xE2H\xD2")] = false,
	[var_0_6("\xF6\xD1(\xF1-\xF2\xD1)\xC1\"\xEB\xC6)\xFB\"\xF0\xDD4\xF0\x1E\xE5\xD7/\xF77\xE1", "A\x84\xB4[\x9E")] = false,
	[var_0_6("\x17}\xD6+\as\xC5\x11\x04\x7F\xC5'\x13}\xC5'\nr\xEE%\x00e", "Ne\x1C\xB1")] = false,
	[var_0_6("$\xB5\xDFB<\xA7", "1EԀ")] = {
		{
			[var_0_6("\x12\x02\xD1\xF0\xED\x12", "\x81wl\xB0\x92")] = true,
			[var_0_6("1\xC0\x03\xF21\x17\f9", "|\\\xAFg\xADEn")] = var_0_6("\xF23\n#\xD5=\x11", "W\xA1Xc"),
			[var_0_6("\x1F\xF6\xEB\xF3\xB3\xDD", "Cr\x99\x8F\xACװ")] = -10,
			[var_0_6("\xA7\xA3\xF91\xAA\xBB\xFE\v", "n\xDE\xC2\x8E")] = var_0_6("3\xDC\x17\xA8K", "\xC1w\xB9{\xC92"),
			[var_0_6("n\t\xEE\x19\v|\x13v\x11", "\x7F\x17h\x99Fo\x19")] = 4,
			[var_0_6("\x10\x06\xB1\x90')\xB1\xA7", "\xD3ig\xC6\xCFKL\xD7")] = -27,
			[var_0_6("צ\xA7\xD0l\x05\xBD\xBE\xDA", "֮\xC7Џ\x1El\xDA")] = 21,
			[var_0_6("\x15\x81\x18\xB3\xABU\xE7D\x1E\x80\x0E", ")q\xE4k\xCA\xC56\xB8")] = var_0_6("Q\x9F1Q", "<\x1A\xEDX")
		},
		{
			[var_0_6("\xDD$u\xE4\xA2\xDD", "θJ\x14\x86")] = true,
			[var_0_6("5\xEB\xEA\x8E\xE7S(\xC9", "\xACX\x84\x8Eѓ*X")] = var_0_6("\xB4\x81\xC5\x19\"\xF0\xAC", "\xDE\xE7\xEA\xACmV\x95"),
			[var_0_6("\xE0\xE0\xC4'\xE9\xE2", "x\x8D\x8F\xA0")] = 7,
			[var_0_6("Y\xAD\xA1mT\xB5\xA6W", "2 \xCC\xD6")] = var_0_6("\xA2B9x\xAA", "q\xE6'U\x19\xD3"),
			[var_0_6("Ǻ\x11\xD7#ΧJ\xC7", "+\xBE\xDBf\x88G\xAB\xCB")] = 4,
			[var_0_6(";\x7F'f.{6M", "9B\x1EP")] = -16,
			[var_0_6("0ٷ*\x960\xF3\x8C=", "\xE4I\xB8\xC0u\xE4Y\x94")] = 23,
			[var_0_6("ˌf\r\xC1\x8AJ\x19\xC0\x8Dp", "t\xAF\xE9\x15")] = var_0_6("\xD5\xEA\xB7K", "_\x9E\x98\xDE&\xBBQ")
		},
		{
			[var_0_6("\xFD\xB34\xB0\xAF\xCD", "\xA8\x98\xDDU\xD2\xC3")] = true,
			[var_0_6("\xA6\xD1\xF1\xB8\xBF\xC7\xE5\x82", "\xE7˾\x95")] = var_0_6("\xFE6\xEA\xE5\xA8\xF0\t", "{\xAD]\x83\x91ܕ"),
			[var_0_6("\x1B\xCB\xE9\x1Ep\xF4", "\x99v\xA4\x8DA\x14")] = -14,
			[var_0_6("\xF73\x91\xDD\xE3\x19\xFE7", "`\x8ER悗")] = var_0_6("k\xB5CC\xFD", "\x8E/\xD0/\"\x84"),
			[var_0_6("\xEF\xBF\x13=_Y\xFA\xBF\x1D", "<\x96\xDEdb;")] = 4,
			[var_0_6("\\=@i׿7Q", "Q%\\76\xBB\xDA")] = -18,
			[var_0_6("\x19E\xBA\b\x93\tC\xA5#", "\xE1`$\xCDW")] = 14,
			[var_0_6("\xED\xA3Q`rL6\xE4\xA9F|", "i\x89\xC6\"\x19\x1C/")] = var_0_6(":\xBBH{", "\xA0q\xC9!\x16")
		},
		{
			[var_0_6("\xD1V\xAD\xA5\xA5\xA8", "ʹ8\xCC\xC7\xC9")] = true,
			[var_0_6("\x8E\xD18'\x97\xC7,\x1D", "x\xE3\xBE\\")] = var_0_6("\x0EW\x16o7Y\xCB", "\x82]<\x7F\x1BC<\xB9"),
			[var_0_6("E=<q\xE4N", "\x1D(RX.\x80#")] = -12,
			[var_0_6("\"D\xC3\"\x15\xA1+@", "\xD8[%\xB4}a")] = var_0_6("\x01s\x10\xC2N", "7E\x16|\xA3"),
			[var_0_6("a\xD2K\xD7\xDBt\\\xF5a", "\x94\x18\xB3<\x88\xBF\x110")] = 4,
			[var_0_6("\xAB+\xEE\x9F\xFA\xB7,\xED", "\x96\xD2J\x99\xC0")] = -19,
			[var_0_6("\xFA\xC9/\xB5gs\xB3\xEB\xDC", "ԃ\xA8X\xEA\x15\x1A")] = 16,
			[var_0_6("Aq\x9A\x956$zy\x86\x88=", "G%\x14\xE9\xECX")] = var_0_6("\xE6T\xB9\x1B", "<\xAD&\xD0v \x8C,")
		},
		{
			[var_0_6("D<\xE0\xD1,\xCA", "\xAF!R\x81\xB3@")] = true,
			[var_0_6("\xE3\xE04\xF0(\xAB\xFE\xEA", "Ҏ\x8FP\xAF\\")] = var_0_6("\x8A\xE2\xFAҭ\xEC\xE1", "\xA6ى\x93"),
			[var_0_6("\xEE\xACv\x99\xF5K", "&\x83\xC3\x12Ƒ")] = -16,
			[var_0_6("J\xD7-\xD4,MC\xD3", "43\xB6Z\x8BX")] = var_0_6("Ҽ\xDC\xE6Z", "#\x96ٰ\x87"),
			[var_0_6("\xE0Q\x1C3sFz\xF8I", "\x16\x990kl\x17#")] = 4,
			[var_0_6("\x17\x84\xAC%spG\xFD", "\x89n\xE5\xDBz\x1F\x15!")] = -10,
			[var_0_6("\x03\xBC/D$B#v\x0E", "\x1Ez\xDDX\x1BV+D")] = 16,
			[var_0_6("<-\xF8\x9F6+ԋ7,\xEE", "\xE6XH\x8B")] = var_0_6("Y\xA6\x1F\x16", "8\x12\xD4v{ch")
		},
		{
			[var_0_6("\x1B\xE7\xF9\xD1\xD3\xDB", "\xBE~\x89\x98\xB3\xBF")] = true,
			[var_0_6("%\rv\xF4\xBEY8\a", " Hb\x12\xAB\xCA")] = var_0_6("7\x83;`\xE3\x01\x9A", "\x97d\xE8R\x14"),
			[var_0_6("r\xD6\xF27{\xD4", "h\x1F\xB9\x96")] = 10,
			[var_0_6("Ÿ\xE4\xC8\xF3\xD5\xF0\xC5", "\xA0\xBCٓ\x97\x87\xAC\x80")] = var_0_6("+\xD8\x1C\xF1#", "\xA9o\xBDp\x90Z"),
			[var_0_6("Ԃ2\x92\xBB\x85\x05\x83\xD4", "\xE2\xAD\xE3E\xCD\xDF\xE0i")] = 4,
			[var_0_6("A?5d\xC3\x1E^*", "{8^B;\xAF")] = -12,
			[var_0_6("\xE3Bd\xDE\b\xF7\x86\xF2W", "\xE1\x9A#\x13\x81z\x9E")] = 12,
			[var_0_6("^\x05\xF8N\xFB\xE4\xEF9U\x04\xEE", "T:`\x8B7\x95\x87\xB0")] = var_0_6("8-\xAA\r", "^s_\xC3`.\xAF")
		},
		{
			[var_0_6("FE>?\"(", "\x80#+_]NM\xE7")] = true,
			[var_0_6("\xA9\x122\v\x03g\xB9\xA1", "\xC9\xC4}VTw\x1E")] = var_0_6("\xF0\xE5\r\xAB\xD7\xEB\x16", "ߣ\x8Ed"),
			[var_0_6("\x8F\x19ǎ\xBC\x8F", "\xD8\xE2v\xA3\xD1")] = -19,
			[var_0_6("\xA7\xF1\f>Ci/\xBB", "_ސ{a7\x10")] = var_0_6("=\x81\xB6B\xFA", "\x83y\xE4\xDA#"),
			[var_0_6("\xC0\xD15>}\x1E\xD5\xD1;", "{\xB9\xB0Ba\x19")] = 4,
			[var_0_6("\xD1\x0E\x0En\x19*^%", "Q\xA8oy1uO8")] = -12,
			[var_0_6("\xDE\v\xF2\x89\xD5\x03\xE2\xBE\xD3", "֧j\x85")] = 16,
			[var_0_6("-=_V:|\xE6$7HJ", "\xB9IX,/T\x1F")] = var_0_6("\xA3\xC5\x13\xAD", "\x9F\xE8\xB7z\xC0\xB3")
		}
	}
}

function var_0_55.export()
	local var_50_0 = {}

	if tab_selector then
		var_50_0.tab_selector = tab_selector:get()
	end

	if aa_tab then
		var_50_0.aa_tab = aa_tab:get()
	end

	if aa_pitch then
		var_50_0.aa_pitch = aa_pitch:get()
	end

	if aa_yaw_base then
		var_50_0.aa_yaw_base = aa_yaw_base:get()
	end

	if aa_fs_enable then
		var_50_0.aa_fs_enable = aa_fs_enable:get()
	end

	if aa_fs_key then
		var_50_0.aa_fs_key = aa_fs_key:get()
	end

	if safe_head_enabled then
		var_50_0.safe_head_enabled = safe_head_enabled:get()
	end

	if safe_head_states then
		var_50_0.safe_head_states = safe_head_states:get()
	end

	if avoid_backstab_enabled then
		var_50_0.avoid_backstab_enabled = avoid_backstab_enabled:get()
	end

	if aa_condition then
		var_50_0.aa_condition = aa_condition:get()
	end

	if enable_fl then
		var_50_0.enable_fl = enable_fl:get()
	end

	if fl_limit then
		var_50_0.fl_limit = fl_limit:get()
	end

	if fl_variance then
		var_50_0.fl_variance = fl_variance:get()
	end

	if fl_type then
		var_50_0.fl_type = fl_type:get()
	end

	if oth_sw then
		var_50_0.oth_sw = oth_sw:get()
	end

	if oth_sw_kb then
		var_50_0.oth_sw_kb = oth_sw_kb:get()
	end

	if oth_lm then
		var_50_0.oth_lm = oth_lm:get()
	end

	if oth_osaa then
		var_50_0.oth_osaa = oth_osaa:get()
	end

	if oth_osaa_kb then
		var_50_0.oth_osaa_kb = oth_osaa_kb:get()
	end

	if hitlogs_select then
		var_50_0.hitlogs_select = hitlogs_select:get()
	end

	if misslogs_select then
		var_50_0.misslogs_select = misslogs_select:get()
	end

	if custom_scope_enabled then
		var_50_0.custom_scope_enabled = custom_scope_enabled:get()
	end

	if custom_scope_color then
		var_50_0.custom_scope_color = custom_scope_color:get()
	end

	if custom_scope_mode then
		var_50_0.custom_scope_mode = custom_scope_mode:get()
	end

	if custom_scope_position then
		var_50_0.custom_scope_position = custom_scope_position:get()
	end

	if custom_scope_offset then
		var_50_0.custom_scope_offset = custom_scope_offset:get()
	end

	if hitrate_enabled then
		var_50_0.hitrate_enabled = hitrate_enabled:get()
	end

	if vis_desync_arrows_style then
		var_50_0.vis_desync_arrows_style = vis_desync_arrows_style:get()
	end

	if vis_desync_arrows_color then
		var_50_0.vis_desync_arrows_color = vis_desync_arrows_color:get()
	end

	if vis_desync_arrows_distance then
		var_50_0.vis_desync_arrows_distance = vis_desync_arrows_distance:get()
	end

	if vis_dmg_indicator_enable then
		var_50_0.vis_dmg_indicator_enable = vis_dmg_indicator_enable:get()
	end

	if dmg_indicator_color then
		var_50_0.dmg_indicator_color = dmg_indicator_color:get()
	end

	if vis_watermark then
		var_50_0.vis_watermark = vis_watermark:get()
	end

	if vis_watermark_color then
		var_50_0.vis_watermark_color = vis_watermark_color:get()
	end

	if vis_watermark_mode then
		var_50_0.vis_watermark_mode = vis_watermark_mode:get()
	end

	if vis_watermark_position then
		var_50_0.vis_watermark_position = vis_watermark_position:get()
	end

	if clantag_enable then
		var_50_0.clantag_enable = clantag_enable:get()
	end

	if animation_breaker_enable then
		var_50_0.animation_breaker_enable = animation_breaker_enable:get()
	end

	if animation_breaker_condition then
		var_50_0.animation_breaker_condition = animation_breaker_condition:get()
	end

	if var_0_42 then
		local var_50_1 = 0
		local var_50_2

		while true do
			if var_50_1 == 0 then
				local var_50_3 = 0

				while true do
					if var_50_3 == 0 then
						var_50_0.defensive_aa_settings = {}

						for iter_50_0 = 1, 7 do
							if var_0_42[iter_50_0] then
								var_50_0.defensive_aa_settings[iter_50_0] = {
									[var_0_6(" 7\xAE$*!\xA17!\r\xA9/0;\x97 -?\xAA.0", "ADR\xC8")] = ui.get(var_0_42[iter_50_0].defensive_anti_aimbot),
									[var_0_6("!Ut%\xC1\xDCw3UM0\xC6\xDB}-", "\x1EE0\x12@\xAF\xAF")] = ui.get(var_0_42[iter_50_0].defensive_pitch),
									[var_0_6("\xF4)\x19\xE95\xE3%\t\xE9\x04\xE0%\v\xEF3\xA1", "[\x90L\x7F\x8C")] = ui.get(var_0_42[iter_50_0].defensive_pitch1),
									[var_0_6("\xE4\r@$ݩ\xDC\xC6\xE57V(ǹ݂", "\xB0\x80h&A\xB3ڵ")] = ui.get(var_0_42[iter_50_0].defensive_pitch2),
									[var_0_6("\xD4\xC1\xC4\x10\xDE\xD7\xCB\x03\xD5\xFB\xD2\x1C\xC4\xC7\xCAF", "u\xB0\xA4\xA2")] = ui.get(var_0_42[iter_50_0].defensive_pitch3),
									[var_0_6("\x80\xC7\x03\xF5\xD4j\x8D\xD4\x00\xCF\xC3x\x93", "\x19\xE4\xA2e\x90\xBA")] = ui.get(var_0_42[iter_50_0].defensive_yaw),
									[var_0_6("L3\xBF\v\xFC\xF7A \xBC1\xEB\xE5_g", "\x84(V\xD9n\x92")] = ui.get(var_0_42[iter_50_0].defensive_yaw1),
									[var_0_6("z\xCE!\xB9\xA9`\xF5H{\xF4>\xBD\xB0!", ">\x1E\xABG\xDC\xC7\x13\x9C")] = ui.get(var_0_42[iter_50_0].defensive_yaw2)
								}
							end
						end

						break
					end
				end

				break
			end
		end
	end

	if ragebot_tab then
		var_50_0.ragebot_tab = ragebot_tab:get()
	end

	if prediction_enabled then
		var_50_0.prediction_enabled = prediction_enabled:get()
	end

	if prediction_visualize then
		var_50_0.prediction_visualize = prediction_visualize:get()
	end

	if prediction_smoothing then
		var_50_0.prediction_smoothing = prediction_smoothing:get()
	end

	if prediction_min_velocity then
		var_50_0.prediction_min_velocity = prediction_min_velocity:get()
	end

	if prediction_ticks then
		var_50_0.prediction_ticks = prediction_ticks:get()
	end

	if prediction_acceleration then
		var_50_0.prediction_acceleration = prediction_acceleration:get()
	end

	if resolver_enabled then
		var_50_0.resolver_enabled = resolver_enabled:get()
	end

	if resolver_force_body_yaw then
		var_50_0.resolver_force_body_yaw = resolver_force_body_yaw:get()
	end

	if resolver_correction_active then
		var_50_0.resolver_correction_active = resolver_correction_active:get()
	end

	if ragebot_activation_key then
		var_50_0.ragebot_activation_key = ragebot_activation_key:get()
	end

	if aa_sys then
		var_50_0.aa_sys = {}

		for iter_50_1 = 1, 7 do
			if aa_sys[iter_50_1] then
				var_50_0.aa_sys[iter_50_1] = {
					[var_0_6("EK\xAD4Q\xCC", "- %\xCCV=\xA9O")] = aa_sys[iter_50_1].enable:get(),
					[var_0_6("XZ\x01\x83\xA1eEP", "\x1C55e\xDC\xD5")] = aa_sys[iter_50_1].mod_type:get(),
					[var_0_6("\x00S\f~^\xAC", "\xBFm<h!:\xC10")] = aa_sys[iter_50_1].mod_dm:get(),
					[var_0_6("\x9E\xD6\x0Fؓ\xCE\b\xE2", "\x87\xE7\xB7x")] = aa_sys[iter_50_1].yaw_type:get(),
					[var_0_6("\xFF\v[\xDB1\x1F\xA5\xE7\x13", "Ɇj,\x84Uz")] = aa_sys[iter_50_1].yaw_delay:get(),
					[var_0_6("/\r`\x00\r\t\xCE7", "CVl\x17_al\xA8")] = aa_sys[iter_50_1].yaw_left:get(),
					[var_0_6("\xBD9[5\xB6-\xD2X\xB0", "0\xC4X,j\xC4D\xB5")] = aa_sys[iter_50_1].yaw_right:get(),
					[var_0_6("\x86\xDA\xCF:\x8E\xA7\x9D!\x8D\xDB\xD9", "L⿼C\xE0\xC4\xC2")] = aa_sys[iter_50_1].desync_mode:get()
				}
			end
		end
	end

	local var_50_4 = {
		[var_0_6("\xCD!\n\xF5\xEE\xCD)\n\xE0", "\x9D\xB9Hg\x90")] = globals.tickcount(),
		[var_0_6("O\xB6\x98i\xA1\xBEW", "\xD19\xD3\xEA\x1A\xC8")] = var_0_6("P\x80\xF6", "\xB2a\xAE\xC6\xE10"),
		[var_0_6("\xDCS\x10\xE5q\xE8\b\xDC", "o\xAF6d\x91\x18\x86")] = var_50_0
	}
	local var_50_5 = var_0_12.encode(var_0_13.stringify(var_50_4))

	var_0_9.set(var_50_5)
	var_0_29("\affff4akrim.lua : \affffff✓ Config exported to clipboard!")

	return true
end

function var_0_55.save()
	local var_51_0 = {}

	if tab_selector then
		var_51_0.tab_selector = tab_selector:get()
	end

	if aa_tab then
		var_51_0.aa_tab = aa_tab:get()
	end

	if aa_pitch then
		var_51_0.aa_pitch = aa_pitch:get()
	end

	if aa_yaw_base then
		var_51_0.aa_yaw_base = aa_yaw_base:get()
	end

	if aa_fs_enable then
		var_51_0.aa_fs_enable = aa_fs_enable:get()
	end

	if aa_fs_key then
		var_51_0.aa_fs_key = aa_fs_key:get()
	end

	if safe_head_enabled then
		var_51_0.safe_head_enabled = safe_head_enabled:get()
	end

	if safe_head_states then
		var_51_0.safe_head_states = safe_head_states:get()
	end

	if avoid_backstab_enabled then
		var_51_0.avoid_backstab_enabled = avoid_backstab_enabled:get()
	end

	if aa_condition then
		var_51_0.aa_condition = aa_condition:get()
	end

	if enable_fl then
		var_51_0.enable_fl = enable_fl:get()
	end

	if fl_limit then
		var_51_0.fl_limit = fl_limit:get()
	end

	if fl_variance then
		var_51_0.fl_variance = fl_variance:get()
	end

	if fl_type then
		var_51_0.fl_type = fl_type:get()
	end

	if oth_sw then
		var_51_0.oth_sw = oth_sw:get()
	end

	if oth_sw_kb then
		var_51_0.oth_sw_kb = oth_sw_kb:get()
	end

	if oth_lm then
		var_51_0.oth_lm = oth_lm:get()
	end

	if oth_osaa then
		var_51_0.oth_osaa = oth_osaa:get()
	end

	if oth_osaa_kb then
		var_51_0.oth_osaa_kb = oth_osaa_kb:get()
	end

	if hitlogs_select then
		var_51_0.hitlogs_select = hitlogs_select:get()
	end

	if misslogs_select then
		var_51_0.misslogs_select = misslogs_select:get()
	end

	if custom_scope_enabled then
		var_51_0.custom_scope_enabled = custom_scope_enabled:get()
	end

	if custom_scope_color then
		var_51_0.custom_scope_color = custom_scope_color:get()
	end

	if custom_scope_mode then
		var_51_0.custom_scope_mode = custom_scope_mode:get()
	end

	if custom_scope_position then
		var_51_0.custom_scope_position = custom_scope_position:get()
	end

	if custom_scope_offset then
		var_51_0.custom_scope_offset = custom_scope_offset:get()
	end

	if hitrate_enabled then
		var_51_0.hitrate_enabled = hitrate_enabled:get()
	end

	if vis_desync_arrows_style then
		var_51_0.vis_desync_arrows_style = vis_desync_arrows_style:get()
	end

	if vis_desync_arrows_color then
		var_51_0.vis_desync_arrows_color = vis_desync_arrows_color:get()
	end

	if vis_desync_arrows_distance then
		var_51_0.vis_desync_arrows_distance = vis_desync_arrows_distance:get()
	end

	if vis_dmg_indicator_enable then
		var_51_0.vis_dmg_indicator_enable = vis_dmg_indicator_enable:get()
	end

	if dmg_indicator_color then
		var_51_0.dmg_indicator_color = dmg_indicator_color:get()
	end

	if vis_watermark then
		var_51_0.vis_watermark = vis_watermark:get()
	end

	if vis_watermark_color then
		var_51_0.vis_watermark_color = vis_watermark_color:get()
	end

	if vis_watermark_mode then
		var_51_0.vis_watermark_mode = vis_watermark_mode:get()
	end

	if vis_watermark_position then
		var_51_0.vis_watermark_position = vis_watermark_position:get()
	end

	if clantag_enable then
		var_51_0.clantag_enable = clantag_enable:get()
	end

	if animation_breaker_enable then
		var_51_0.animation_breaker_enable = animation_breaker_enable:get()
	end

	if animation_breaker_condition then
		var_51_0.animation_breaker_condition = animation_breaker_condition:get()
	end

	if var_0_42 then
		local var_51_1 = 0

		while true do
			if var_51_1 == 0 then
				var_51_0.defensive_aa_settings = {}

				for iter_51_0 = 1, 7 do
					if var_0_42[iter_51_0] then
						var_51_0.defensive_aa_settings[iter_51_0] = {
							[var_0_6("G\x1C&\x10M\n)\x03F&!\x1BW\x10\x1F\x14J\x14\"\x1AW", "u#y@")] = ui.get(var_0_42[iter_51_0].defensive_anti_aimbot),
							[var_0_6("ٸ\xE8\xD3-\\ԫ\xEB\xE93Fɾ\xE6", "/\xBDݎ\xB6C")] = ui.get(var_0_42[iter_51_0].defensive_pitch),
							[var_0_6("$\xBA!\xCEF\xBA)?%\x807\xC2\\\xAA(x", "I@\xDFG\xAB(\xC9@")] = ui.get(var_0_42[iter_51_0].defensive_pitch1),
							[var_0_6("\x0E\x88\xC2\\\xAEn\x03\x9B\xC1f\xB0t\x1E\x8E\xCC\v", "\x1Dj\xED\xA49\xC0")] = ui.get(var_0_42[iter_51_0].defensive_pitch2),
							[var_0_6("\xB5\xA1\xE1\xBF\xDB\xC1\xA9䴛\xF7\xB3\xC1Ѩ\xA1", "\x92\xD1ćڵ\xB2\xC0")] = ui.get(var_0_42[iter_51_0].defensive_pitch3),
							[var_0_6(")5\x85\x14^\xB4$&\x86.I\xA6:", "\xC7MP\xE3q0")] = ui.get(var_0_42[iter_51_0].defensive_yaw),
							[var_0_6(".:X\xC8$,W\xDB/\x00G\xCC=n", "\xADJ_>")] = ui.get(var_0_42[iter_51_0].defensive_yaw1),
							[var_0_6("\xC2\x1CZ3\xC5\x14\xB5\xD0\x1Cc/\xCA\x10\xEE", "ܦy<V\xABg")] = ui.get(var_0_42[iter_51_0].defensive_yaw2)
						}
					end
				end

				break
			end
		end
	end

	if ragebot_tab then
		var_51_0.ragebot_tab = ragebot_tab:get()
	end

	if prediction_enabled then
		var_51_0.prediction_enabled = prediction_enabled:get()
	end

	if prediction_visualize then
		var_51_0.prediction_visualize = prediction_visualize:get()
	end

	if prediction_smoothing then
		var_51_0.prediction_smoothing = prediction_smoothing:get()
	end

	if prediction_min_velocity then
		var_51_0.prediction_min_velocity = prediction_min_velocity:get()
	end

	if prediction_ticks then
		var_51_0.prediction_ticks = prediction_ticks:get()
	end

	if prediction_acceleration then
		var_51_0.prediction_acceleration = prediction_acceleration:get()
	end

	if resolver_enabled then
		var_51_0.resolver_enabled = resolver_enabled:get()
	end

	if resolver_force_body_yaw then
		var_51_0.resolver_force_body_yaw = resolver_force_body_yaw:get()
	end

	if resolver_correction_active then
		var_51_0.resolver_correction_active = resolver_correction_active:get()
	end

	if ragebot_activation_key then
		var_51_0.ragebot_activation_key = ragebot_activation_key:get()
	end

	if aa_sys then
		var_51_0.aa_sys = {}

		for iter_51_1 = 1, 7 do
			if aa_sys[iter_51_1] then
				var_51_0.aa_sys[iter_51_1] = {
					[var_0_6("\xEC\f<\xB27\xCF", "z\x89b]\xD0[\xAA")] = aa_sys[iter_51_1].enable:get(),
					[var_0_6("\x8A\xEE\x18p\xC1\xAB\xB9\xCF", "\xAA\xE7\x81|/\xB5\xD2\xC9")] = aa_sys[iter_51_1].mod_type:get(),
					[var_0_6("\x86\xB4>\x0F\x0E'", "J\xEB\xDBZPj")] = aa_sys[iter_51_1].mod_dm:get(),
					[var_0_6("U\xC2L\x04.\xEDj\xF7", "\x92,\xA3;[Z\x94\x1A")] = aa_sys[iter_51_1].yaw_type:get(),
					[var_0_6("l,\xAF\xBEMp!\xB9\x98", ")\x15M\xD8\xE1")] = aa_sys[iter_51_1].yaw_delay:get(),
					[var_0_6("\rLez\x18HtQ", "%t-\x12")] = aa_sys[iter_51_1].yaw_left:get(),
					[var_0_6("\xD6\xFEA\x9D\xB9\xC6\xF8^\xB6", "˯\x9F6\xC2")] = aa_sys[iter_51_1].yaw_right:get(),
					[var_0_6("\x7F\xCB\n\"TL\xFDv\xC1\x1D>", "\xA2\x1B\xAEy[:/")] = aa_sys[iter_51_1].desync_mode:get()
				}
			end
		end
	end

	local var_51_2 = {
		[var_0_6("\xC7\xCC\x12\xF0,\xCD\xD2\xC8\x0F", "\xB9\xB3\xA5\x7F\x95_")] = globals.tickcount(),
		[var_0_6("Gp\xDD\xE7\x1E^{", "w1\x15\xAF\x94")] = var_0_6("\x06\xFBF", "\x957\xD5v=M)\xEA"),
		[var_0_6("\x0E\x03\xDE\xD2\xE07\xA8\b", "{}f\xAA\xA6\x89Y\xCF")] = var_51_0
	}
	local var_51_3 = var_0_12.encode(var_0_13.stringify(var_51_2))

	data.savedconfig = var_51_3

	var_0_29("\affff4akrim.lua : \affffff✓ Config saved to database")

	return true
end

function var_0_55.import()
	local var_52_0 = var_0_9.get()

	if not var_52_0 then
		local var_52_1 = 0

		while true do
			if var_52_1 == 0 then
				var_0_29("\affff4akrim.lua : \affffff✗ No data in clipboard")

				return false
			end
		end
	end

	local var_52_2, var_52_3 = pcall(function()
		return var_0_13.parse(var_0_12.decode(var_52_0))
	end)

	if var_52_2 and var_52_3 and var_52_3.settings then
		local var_52_4 = 0

		local function var_52_5(arg_54_0, arg_54_1)
			if arg_54_0 and arg_54_1 ~= nil then
				local var_54_0 = 0
				local var_54_1

				while true do
					if var_54_0 == 0 then
						if pcall(function()
							arg_54_0:set(arg_54_1)
						end) then
							var_52_4 = var_52_4 + 1
						end

						break
					end
				end
			end
		end

		var_52_5(tab_selector, var_52_3.settings.tab_selector)
		var_52_5(aa_tab, var_52_3.settings.aa_tab)
		var_52_5(aa_pitch, var_52_3.settings.aa_pitch)
		var_52_5(aa_yaw_base, var_52_3.settings.aa_yaw_base)
		var_52_5(aa_fs_enable, var_52_3.settings.aa_fs_enable)
		var_52_5(aa_fs_key, var_52_3.settings.aa_fs_key)
		var_52_5(safe_head_enabled, var_52_3.settings.safe_head_enabled)
		var_52_5(safe_head_states, var_52_3.settings.safe_head_states)
		var_52_5(avoid_backstab_enabled, var_52_3.settings.avoid_backstab_enabled)
		var_52_5(aa_condition, var_52_3.settings.aa_condition)
		var_52_5(enable_fl, var_52_3.settings.enable_fl)
		var_52_5(fl_limit, var_52_3.settings.fl_limit)
		var_52_5(fl_variance, var_52_3.settings.fl_variance)
		var_52_5(fl_type, var_52_3.settings.fl_type)
		var_52_5(oth_sw, var_52_3.settings.oth_sw)
		var_52_5(oth_sw_kb, var_52_3.settings.oth_sw_kb)
		var_52_5(oth_lm, var_52_3.settings.oth_lm)
		var_52_5(oth_osaa, var_52_3.settings.oth_osaa)
		var_52_5(oth_osaa_kb, var_52_3.settings.oth_osaa_kb)
		var_52_5(hitlogs_select, var_52_3.settings.hitlogs_select)
		var_52_5(misslogs_select, var_52_3.settings.misslogs_select)
		var_52_5(custom_scope_enabled, var_52_3.settings.custom_scope_enabled)
		var_52_5(custom_scope_color, var_52_3.settings.custom_scope_color)
		var_52_5(custom_scope_mode, var_52_3.settings.custom_scope_mode)
		var_52_5(custom_scope_position, var_52_3.settings.custom_scope_position)
		var_52_5(custom_scope_offset, var_52_3.settings.custom_scope_offset)
		var_52_5(hitrate_enabled, var_52_3.settings.hitrate_enabled)
		var_52_5(vis_desync_arrows_style, var_52_3.settings.vis_desync_arrows_style)
		var_52_5(vis_desync_arrows_color, var_52_3.settings.vis_desync_arrows_color)
		var_52_5(vis_desync_arrows_distance, var_52_3.settings.vis_desync_arrows_distance)
		var_52_5(vis_dmg_indicator_enable, var_52_3.settings.vis_dmg_indicator_enable)
		var_52_5(dmg_indicator_color, var_52_3.settings.dmg_indicator_color)
		var_52_5(vis_watermark, var_52_3.settings.vis_watermark)
		var_52_5(vis_watermark_color, var_52_3.settings.vis_watermark_color)
		var_52_5(vis_watermark_mode, var_52_3.settings.vis_watermark_mode)
		var_52_5(vis_watermark_position, var_52_3.settings.vis_watermark_position)
		var_52_5(clantag_enable, var_52_3.settings.clantag_enable)
		var_52_5(animation_breaker_enable, var_52_3.settings.animation_breaker_enable)
		var_52_5(animation_breaker_condition, var_52_3.settings.animation_breaker_condition)

		if var_52_3.settings.defensive_aa_settings and var_0_42 then
			for iter_52_0 = 1, 7 do
				if var_52_3.settings.defensive_aa_settings[iter_52_0] and var_0_42[iter_52_0] then
					ui.set(var_0_42[iter_52_0].defensive_anti_aimbot, var_52_3.settings.defensive_aa_settings[iter_52_0].defensive_anti_aimbot)
					ui.set(var_0_42[iter_52_0].defensive_pitch, var_52_3.settings.defensive_aa_settings[iter_52_0].defensive_pitch)
					ui.set(var_0_42[iter_52_0].defensive_pitch1, var_52_3.settings.defensive_aa_settings[iter_52_0].defensive_pitch1)
					ui.set(var_0_42[iter_52_0].defensive_pitch2, var_52_3.settings.defensive_aa_settings[iter_52_0].defensive_pitch2)
					ui.set(var_0_42[iter_52_0].defensive_pitch3, var_52_3.settings.defensive_aa_settings[iter_52_0].defensive_pitch3)
					ui.set(var_0_42[iter_52_0].defensive_yaw, var_52_3.settings.defensive_aa_settings[iter_52_0].defensive_yaw)
					ui.set(var_0_42[iter_52_0].defensive_yaw1, var_52_3.settings.defensive_aa_settings[iter_52_0].defensive_yaw1)
					ui.set(var_0_42[iter_52_0].defensive_yaw2, var_52_3.settings.defensive_aa_settings[iter_52_0].defensive_yaw2)
				end
			end
		end

		var_52_5(ragebot_tab, var_52_3.settings.ragebot_tab)
		var_52_5(prediction_enabled, var_52_3.settings.prediction_enabled)
		var_52_5(prediction_visualize, var_52_3.settings.prediction_visualize)
		var_52_5(prediction_smoothing, var_52_3.settings.prediction_smoothing)
		var_52_5(prediction_min_velocity, var_52_3.settings.prediction_min_velocity)
		var_52_5(prediction_ticks, var_52_3.settings.prediction_ticks)
		var_52_5(prediction_acceleration, var_52_3.settings.prediction_acceleration)
		var_52_5(resolver_enabled, var_52_3.settings.resolver_enabled)
		var_52_5(resolver_force_body_yaw, var_52_3.settings.resolver_force_body_yaw)
		var_52_5(resolver_correction_active, var_52_3.settings.resolver_correction_active)
		var_52_5(ragebot_activation_key, var_52_3.settings.ragebot_activation_key)

		if var_52_3.settings.aa_sys and aa_sys then
			for iter_52_1 = 1, 7 do
				if var_52_3.settings.aa_sys[iter_52_1] and aa_sys[iter_52_1] then
					var_52_5(aa_sys[iter_52_1].enable, var_52_3.settings.aa_sys[iter_52_1].enable)
					var_52_5(aa_sys[iter_52_1].mod_type, var_52_3.settings.aa_sys[iter_52_1].mod_type)
					var_52_5(aa_sys[iter_52_1].mod_dm, var_52_3.settings.aa_sys[iter_52_1].mod_dm)
					var_52_5(aa_sys[iter_52_1].yaw_type, var_52_3.settings.aa_sys[iter_52_1].yaw_type)
					var_52_5(aa_sys[iter_52_1].yaw_delay, var_52_3.settings.aa_sys[iter_52_1].yaw_delay)
					var_52_5(aa_sys[iter_52_1].yaw_left, var_52_3.settings.aa_sys[iter_52_1].yaw_left)
					var_52_5(aa_sys[iter_52_1].yaw_right, var_52_3.settings.aa_sys[iter_52_1].yaw_right)
					var_52_5(aa_sys[iter_52_1].desync_mode, var_52_3.settings.aa_sys[iter_52_1].desync_mode)
				end
			end
		end

		var_0_29("\affff4akrim.lua : \affffff✓ Config imported from clipboard!")
		var_0_29("\affff4akrim.lua : \affffffSuccessfully set " .. var_52_4 .. var_0_6("\x0E\x13])\x1A\x8A\xA7I\x13", "\xC9.`8]n\xE3"))

		return true
	else
		local var_52_6 = 0

		while true do
			if var_52_6 == 0 then
				local var_52_7 = 0

				while true do
					if var_52_7 == 0 then
						var_0_29("\affff4akrim.lua : \affffff✗ Invalid config data in clipboard")

						return false
					end
				end
			end
		end
	end
end

function var_0_55.load()
	local var_56_0 = data.savedconfig

	if not var_56_0 then
		local var_56_1 = 0
		local var_56_2

		while true do
			if var_56_1 == 0 then
				local var_56_3 = 0

				while true do
					if var_56_3 == 0 then
						local var_56_4 = 0

						while true do
							if var_56_4 == 0 then
								local var_56_5 = 0

								while true do
									if var_56_5 == 0 then
										var_0_29("\affff4akrim.lua : \affffff✗ No data in database")

										return false
									end
								end
							end
						end
					end
				end

				break
			end
		end
	end

	local var_56_6, var_56_7 = pcall(function()
		return var_0_13.parse(var_0_12.decode(var_56_0))
	end)

	if var_56_6 and var_56_7 and var_56_7.settings then
		local var_56_8 = 0

		local function var_56_9(arg_58_0, arg_58_1)
			if arg_58_0 and arg_58_1 ~= nil then
				local var_58_0 = 0
				local var_58_1

				while true do
					if var_58_0 == 0 then
						if pcall(function()
							arg_58_0:set(arg_58_1)
						end) then
							var_56_8 = var_56_8 + 1
						end

						break
					end
				end
			end
		end

		var_56_9(tab_selector, var_56_7.settings.tab_selector)
		var_56_9(aa_tab, var_56_7.settings.aa_tab)
		var_56_9(aa_pitch, var_56_7.settings.aa_pitch)
		var_56_9(aa_yaw_base, var_56_7.settings.aa_yaw_base)
		var_56_9(aa_fs_enable, var_56_7.settings.aa_fs_enable)
		var_56_9(aa_fs_key, var_56_7.settings.aa_fs_key)
		var_56_9(safe_head_enabled, var_56_7.settings.safe_head_enabled)
		var_56_9(safe_head_states, var_56_7.settings.safe_head_states)
		var_56_9(avoid_backstab_enabled, var_56_7.settings.avoid_backstab_enabled)
		var_56_9(aa_condition, var_56_7.settings.aa_condition)
		var_56_9(enable_fl, var_56_7.settings.enable_fl)
		var_56_9(fl_limit, var_56_7.settings.fl_limit)
		var_56_9(fl_variance, var_56_7.settings.fl_variance)
		var_56_9(fl_type, var_56_7.settings.fl_type)
		var_56_9(oth_sw, var_56_7.settings.oth_sw)
		var_56_9(oth_sw_kb, var_56_7.settings.oth_sw_kb)
		var_56_9(oth_lm, var_56_7.settings.oth_lm)
		var_56_9(oth_osaa, var_56_7.settings.oth_osaa)
		var_56_9(oth_osaa_kb, var_56_7.settings.oth_osaa_kb)
		var_56_9(hitlogs_select, var_56_7.settings.hitlogs_select)
		var_56_9(misslogs_select, var_56_7.settings.misslogs_select)
		var_56_9(custom_scope_enabled, var_56_7.settings.custom_scope_enabled)
		var_56_9(custom_scope_color, var_56_7.settings.custom_scope_color)
		var_56_9(custom_scope_mode, var_56_7.settings.custom_scope_mode)
		var_56_9(custom_scope_position, var_56_7.settings.custom_scope_position)
		var_56_9(custom_scope_offset, var_56_7.settings.custom_scope_offset)
		var_56_9(hitrate_enabled, var_56_7.settings.hitrate_enabled)
		var_56_9(vis_desync_arrows_style, var_56_7.settings.vis_desync_arrows_style)
		var_56_9(vis_desync_arrows_color, var_56_7.settings.vis_desync_arrows_color)
		var_56_9(vis_desync_arrows_distance, var_56_7.settings.vis_desync_arrows_distance)
		var_56_9(vis_dmg_indicator_enable, var_56_7.settings.vis_dmg_indicator_enable)
		var_56_9(dmg_indicator_color, var_56_7.settings.dmg_indicator_color)
		var_56_9(vis_watermark, var_56_7.settings.vis_watermark)
		var_56_9(vis_watermark_color, var_56_7.settings.vis_watermark_color)
		var_56_9(vis_watermark_mode, var_56_7.settings.vis_watermark_mode)
		var_56_9(vis_watermark_position, var_56_7.settings.vis_watermark_position)
		var_56_9(clantag_enable, var_56_7.settings.clantag_enable)
		var_56_9(animation_breaker_enable, var_56_7.settings.animation_breaker_enable)
		var_56_9(animation_breaker_condition, var_56_7.settings.animation_breaker_condition)

		if var_56_7.settings.defensive_aa_settings and var_0_42 then
			for iter_56_0 = 1, 7 do
				if var_56_7.settings.defensive_aa_settings[iter_56_0] and var_0_42[iter_56_0] then
					ui.set(var_0_42[iter_56_0].defensive_anti_aimbot, var_56_7.settings.defensive_aa_settings[iter_56_0].defensive_anti_aimbot)
					ui.set(var_0_42[iter_56_0].defensive_pitch, var_56_7.settings.defensive_aa_settings[iter_56_0].defensive_pitch)
					ui.set(var_0_42[iter_56_0].defensive_pitch1, var_56_7.settings.defensive_aa_settings[iter_56_0].defensive_pitch1)
					ui.set(var_0_42[iter_56_0].defensive_pitch2, var_56_7.settings.defensive_aa_settings[iter_56_0].defensive_pitch2)
					ui.set(var_0_42[iter_56_0].defensive_pitch3, var_56_7.settings.defensive_aa_settings[iter_56_0].defensive_pitch3)
					ui.set(var_0_42[iter_56_0].defensive_yaw, var_56_7.settings.defensive_aa_settings[iter_56_0].defensive_yaw)
					ui.set(var_0_42[iter_56_0].defensive_yaw1, var_56_7.settings.defensive_aa_settings[iter_56_0].defensive_yaw1)
					ui.set(var_0_42[iter_56_0].defensive_yaw2, var_56_7.settings.defensive_aa_settings[iter_56_0].defensive_yaw2)
				end
			end
		end

		var_56_9(ragebot_tab, var_56_7.settings.ragebot_tab)
		var_56_9(prediction_enabled, var_56_7.settings.prediction_enabled)
		var_56_9(prediction_visualize, var_56_7.settings.prediction_visualize)
		var_56_9(prediction_smoothing, var_56_7.settings.prediction_smoothing)
		var_56_9(prediction_min_velocity, var_56_7.settings.prediction_min_velocity)
		var_56_9(prediction_ticks, var_56_7.settings.prediction_ticks)
		var_56_9(prediction_acceleration, var_56_7.settings.prediction_acceleration)
		var_56_9(resolver_enabled, var_56_7.settings.resolver_enabled)
		var_56_9(resolver_force_body_yaw, var_56_7.settings.resolver_force_body_yaw)
		var_56_9(resolver_correction_active, var_56_7.settings.resolver_correction_active)
		var_56_9(ragebot_activation_key, var_56_7.settings.ragebot_activation_key)

		if var_56_7.settings.aa_sys and aa_sys then
			for iter_56_1 = 1, 7 do
				if var_56_7.settings.aa_sys[iter_56_1] and aa_sys[iter_56_1] then
					local var_56_10 = 0

					while true do
						if var_56_10 == 3 then
							var_56_9(aa_sys[iter_56_1].yaw_right, var_56_7.settings.aa_sys[iter_56_1].yaw_right)
							var_56_9(aa_sys[iter_56_1].desync_mode, var_56_7.settings.aa_sys[iter_56_1].desync_mode)

							break
						end

						if var_56_10 == 0 then
							var_56_9(aa_sys[iter_56_1].enable, var_56_7.settings.aa_sys[iter_56_1].enable)
							var_56_9(aa_sys[iter_56_1].mod_type, var_56_7.settings.aa_sys[iter_56_1].mod_type)

							var_56_10 = 1
						end

						if var_56_10 == 2 then
							var_56_9(aa_sys[iter_56_1].yaw_delay, var_56_7.settings.aa_sys[iter_56_1].yaw_delay)
							var_56_9(aa_sys[iter_56_1].yaw_left, var_56_7.settings.aa_sys[iter_56_1].yaw_left)

							var_56_10 = 3
						end

						if var_56_10 == 1 then
							var_56_9(aa_sys[iter_56_1].mod_dm, var_56_7.settings.aa_sys[iter_56_1].mod_dm)
							var_56_9(aa_sys[iter_56_1].yaw_type, var_56_7.settings.aa_sys[iter_56_1].yaw_type)

							var_56_10 = 2
						end
					end
				end
			end
		end

		var_0_29("\affff4akrim.lua : \affffff✓ Config loaded from database")
		var_0_29("\affff4akrim.lua : \affffffSuccessfully set " .. var_56_8 .. var_0_6("\xFB\x10\xEB\xED\x01ȵ\x04\xFD", "\xA1\xDBc\x8E\x99u"))

		return true
	else
		local var_56_11 = 0

		while true do
			if var_56_11 == 0 then
				var_0_29("\affff4akrim.lua : \affffff✗ Invalid config data in clipboard")

				return false
			end
		end
	end
end

function var_0_55.load_default()
	local var_60_0 = 0

	local function var_60_1(arg_61_0, arg_61_1)
		if arg_61_0 and arg_61_1 ~= nil then
			local var_61_0 = 0
			local var_61_1

			while true do
				if var_61_0 == 0 then
					if pcall(function()
						arg_61_0:set(arg_61_1)
					end) then
						var_60_0 = var_60_0 + 1
					end

					break
				end
			end
		end
	end

	var_60_1(tab_selector, var_0_57.tab_selector)
	var_60_1(aa_tab, var_0_57.aa_tab)
	var_60_1(aa_pitch, var_0_57.aa_pitch)
	var_60_1(aa_yaw_base, var_0_57.aa_yaw_base)
	var_60_1(aa_fs_enable, var_0_57.aa_fs_enable)
	var_60_1(aa_fs_key, var_0_57.aa_fs_key)
	var_60_1(safe_head_enabled, var_0_57.safe_head_enabled)
	var_60_1(safe_head_states, var_0_57.safe_head_states)
	var_60_1(avoid_backstab_enabled, var_0_57.avoid_backstab_enabled)
	var_60_1(aa_condition, var_0_57.aa_condition)
	var_60_1(enable_fl, var_0_57.enable_fl)
	var_60_1(fl_limit, var_0_57.fl_limit)
	var_60_1(fl_variance, var_0_57.fl_variance)
	var_60_1(fl_type, var_0_57.fl_type)
	var_60_1(oth_sw, var_0_57.oth_sw)
	var_60_1(oth_sw_kb, var_0_57.oth_sw_kb)
	var_60_1(oth_lm, var_0_57.oth_lm)
	var_60_1(oth_osaa, var_0_57.oth_osaa)
	var_60_1(oth_osaa_kb, var_0_57.oth_osaa_kb)
	var_60_1(hitlogs_select, var_0_57.hitlogs_select)
	var_60_1(misslogs_select, var_0_57.misslogs_select)
	var_60_1(custom_scope_enabled, var_0_57.custom_scope_enabled)
	var_60_1(custom_scope_color, var_0_57.custom_scope_color)
	var_60_1(custom_scope_mode, var_0_57.custom_scope_mode)
	var_60_1(custom_scope_position, var_0_57.custom_scope_position)
	var_60_1(custom_scope_offset, var_0_57.custom_scope_offset)
	var_60_1(hitrate_enabled, var_0_57.hitrate_enabled)
	var_60_1(vis_desync_arrows_style, var_0_57.vis_desync_arrows_style)
	var_60_1(vis_desync_arrows_color, var_0_57.vis_desync_arrows_color)
	var_60_1(vis_desync_arrows_distance, var_0_57.vis_desync_arrows_distance)
	var_60_1(vis_dmg_indicator_enable, var_0_57.vis_dmg_indicator_enable)
	var_60_1(dmg_indicator_color, var_0_57.dmg_indicator_color)
	var_60_1(vis_watermark, var_0_57.vis_watermark)
	var_60_1(vis_watermark_color, var_0_57.vis_watermark_color)
	var_60_1(vis_watermark_mode, var_0_57.vis_watermark_mode)
	var_60_1(vis_watermark_position, var_0_57.vis_watermark_position)
	var_60_1(clantag_enable, var_0_57.clantag_enable)
	var_60_1(animation_breaker_enable, var_0_57.animation_breaker_enable)
	var_60_1(animation_breaker_condition, var_0_57.animation_breaker_condition)

	if var_0_57.defensive_aa_settings and var_0_42 then
		for iter_60_0 = 1, 7 do
			if var_0_57.defensive_aa_settings[iter_60_0] and var_0_42[iter_60_0] then
				local var_60_2 = 0

				while true do
					if var_60_2 == 0 then
						ui.set(var_0_42[iter_60_0].defensive_anti_aimbot, var_0_57.defensive_aa_settings[iter_60_0].defensive_anti_aimbot)
						ui.set(var_0_42[iter_60_0].defensive_pitch, var_0_57.defensive_aa_settings[iter_60_0].defensive_pitch)

						var_60_2 = 1
					end

					if var_60_2 == 1 then
						ui.set(var_0_42[iter_60_0].defensive_pitch1, var_0_57.defensive_aa_settings[iter_60_0].defensive_pitch1)
						ui.set(var_0_42[iter_60_0].defensive_pitch2, var_0_57.defensive_aa_settings[iter_60_0].defensive_pitch2)

						var_60_2 = 2
					end

					if var_60_2 == 3 then
						ui.set(var_0_42[iter_60_0].defensive_yaw1, var_0_57.defensive_aa_settings[iter_60_0].defensive_yaw1)
						ui.set(var_0_42[iter_60_0].defensive_yaw2, var_0_57.defensive_aa_settings[iter_60_0].defensive_yaw2)

						break
					end

					if var_60_2 == 2 then
						ui.set(var_0_42[iter_60_0].defensive_pitch3, var_0_57.defensive_aa_settings[iter_60_0].defensive_pitch3)
						ui.set(var_0_42[iter_60_0].defensive_yaw, var_0_57.defensive_aa_settings[iter_60_0].defensive_yaw)

						var_60_2 = 3
					end
				end
			end
		end
	end

	var_60_1(ragebot_tab, var_0_57.ragebot_tab)
	var_60_1(prediction_enabled, var_0_57.prediction_enabled)
	var_60_1(prediction_visualize, var_0_57.prediction_visualize)
	var_60_1(prediction_smoothing, var_0_57.prediction_smoothing)
	var_60_1(prediction_min_velocity, var_0_57.prediction_min_velocity)
	var_60_1(prediction_ticks, var_0_57.prediction_ticks)
	var_60_1(prediction_acceleration, var_0_57.prediction_acceleration)
	var_60_1(resolver_enabled, var_0_57.resolver_enabled)
	var_60_1(resolver_force_body_yaw, var_0_57.resolver_force_body_yaw)
	var_60_1(resolver_correction_active, var_0_57.resolver_correction_active)
	var_60_1(ragebot_activation_key, var_0_57.ragebot_activation_key)

	if var_0_57.aa_sys and aa_sys then
		for iter_60_1 = 1, 7 do
			if var_0_57.aa_sys[iter_60_1] and aa_sys[iter_60_1] then
				var_60_1(aa_sys[iter_60_1].enable, var_0_57.aa_sys[iter_60_1].enable)
				var_60_1(aa_sys[iter_60_1].mod_type, var_0_57.aa_sys[iter_60_1].mod_type)
				var_60_1(aa_sys[iter_60_1].mod_dm, var_0_57.aa_sys[iter_60_1].mod_dm)
				var_60_1(aa_sys[iter_60_1].yaw_type, var_0_57.aa_sys[iter_60_1].yaw_type)
				var_60_1(aa_sys[iter_60_1].yaw_delay, var_0_57.aa_sys[iter_60_1].yaw_delay)
				var_60_1(aa_sys[iter_60_1].yaw_left, var_0_57.aa_sys[iter_60_1].yaw_left)
				var_60_1(aa_sys[iter_60_1].yaw_right, var_0_57.aa_sys[iter_60_1].yaw_right)
				var_60_1(aa_sys[iter_60_1].desync_mode, var_0_57.aa_sys[iter_60_1].desync_mode)
			end
		end
	end

	var_0_29("\affff4akrim.lua : \affffff✓ Default config loaded!")
	var_0_29("\affff4akrim.lua : \affffffSuccessfully set " .. var_60_0 .. var_0_6("<\xA2\xA3g\xD9u\xBF\xA1`", "\xAD\x1C\xD1\xC6\x13"))

	return true
end

if var_0_50 then
	var_0_50:set_callback(function()
		var_0_55.export()
	end)
end

if var_0_51 then
	var_0_51:set_callback(function()
		var_0_55.import()
	end)
end

if var_0_51 then
	var_0_51:set_callback(function()
		var_0_55.import()
	end)
end

if var_0_52 then
	var_0_52:set_callback(function()
		var_0_55.save()
	end)
end

if var_0_53 then
	var_0_53:set_callback(function()
		var_0_55.load()
	end)
end

if var_0_54 then
	var_0_54:set_callback(function()
		local var_68_0 = 0
		local var_68_1

		while true do
			if var_68_0 == 0 then
				local var_68_2 = 0

				while true do
					if var_68_2 == 0 then
						var_0_55.load_default()
						client.delay_call(0.1, function()
							apply_your_settings()
						end)

						break
					end
				end

				break
			end
		end
	end)
end

client.delay_call(0.1, function()
	apply_your_settings()
end)

local function var_0_58()
	if aa_sys then
		local var_71_0 = 0
		local var_71_1

		while true do
			if var_71_0 == 1 then
				var_0_29("\affff4akrim.lua : \affffff✓ Anti-aim systems enabled for builder (" .. var_71_1 .. var_0_6(":\xBB\xF7\xA8l\xFF\xA3\xBEx\xFF\xFE", "\xDB\x15\x8C\xD7"))

				break
			end

			if var_71_0 == 0 then
				local var_71_2 = 0

				while true do
					if var_71_2 == 0 then
						var_71_1 = 0

						for iter_71_0 = 1, 7 do
							if aa_sys[iter_71_0] and aa_sys[iter_71_0].enable then
								local var_71_3 = 0
								local var_71_4

								while true do
									if var_71_3 == 0 then
										local var_71_5 = 0

										while true do
											local var_71_6

											if var_71_5 == 0 then
												aa_sys[iter_71_0].enable:set(true)

												var_71_6 = var_71_1 + 1 + 0

												break
											end
										end

										break
									end
								end
							end
						end

						var_71_2 = 1
					end

					if var_71_2 == 1 then
						var_71_0 = 1

						break
					end
				end
			end
		end
	else
		var_0_29("\affff4akrim.lua : \affffffWarning: aa_sys not initialized yet")
	end
end

local var_0_59 = {}

for iter_0_1 = 1, #var_0_37 do
	var_0_59[iter_0_1] = {
		[var_0_6("D\xB9ĢT", "8(ئ\xC7")] = var_0_40:label("\f<antiaim_vinco>Editing \v" .. var_0_37[iter_0_1]),
		[var_0_6("#\xBA\x14-*\xB1", "OF\xD4u")] = var_0_40:checkbox("\f<antiaim_vinco>Enable | \v" .. var_0_37[iter_0_1]),
		[var_0_6("\xBE\x17\xF6\xF9\xED\x14\xB7\x13", "m\xC7v\x81\xA6\x99")] = var_0_40:combobox("\f<antiaim_vinco>Yaw Type", {
			var_0_6("\x15\xB5q\xF7$\xBCc", "\x96Q\xD0\x17"),
			var_0_6("\xDD\xC0\xEC\x8A\xE0", "뙥\x80")
		}),
		[var_0_6("\xA2H\xB5\x10B#\xA6\xFF\xA2", "\x9E\xDB)\xC2O&F\xCA")] = var_0_40:slider("\f<antiaim_vinco>Delay Ticks", 1, 10, 4, true, "t", 1),
		[var_0_6("Z$8=\xE2ӎW", "\xE8#EOb\x8E\xB6")] = var_0_40:slider("\f<antiaim_vinco>Yaw Left", -180, 180, 0, true, "", 1),
		[var_0_6("`\x01\b\xC2k\t\x18\xF5m", "\x9D\x19`\x7F")] = var_0_40:slider("\f<antiaim_vinco>Yaw Right", -180, 180, 0, true, " ", 1),
		[var_0_6("\xAA\x8C\xF1:D(\xB7\x86", "Q\xC7\xE3\x95e0")] = var_0_40:combobox("\f<antiaim_vinco>Jitter Type", {
			var_0_6("RT\xFD", "\xDB\x1D2\x9Bq\x96\xE6\\"),
			var_0_6("\xFE&\xC3h\xFA\\", "-\xB1@\xA5\x1B\x9F("),
			var_0_6(">\x13\x01\xBEw\x0F", "\x12}vo\xCA"),
			var_0_6("b=W\xFE?\xA0", "\x9B0\\9\x9APͧ"),
			var_0_6("\x8AƲ\xAB\xEC\xAEW", "%٭\xDBߘ\xCB")
		}),
		[var_0_6("\x04\n\x1B\tK\xA5", "\x96ie\x7FV/\xC8")] = var_0_40:slider("\f<antiaim_vinco>Offset", -180, 180, 0, true, "", 1),
		[var_0_6("\xCA\xF7\xE0\xAC\xC9\xC3\xF1\xFF\xFC\xB1\xC2", "\xA0\xAE\x92\x93է")] = var_0_40:combobox("\f<antiaim_vinco>Desync Mode", {
			var_0_6("k\xF6\x13I", "! \x84z$l"),
			var_0_6("\xBE\x15\x7FXy\xB7\aw", "\x1C\xD9t\x12+")
		})
	}
end

for iter_0_2 = 1, #var_0_37 do
	local var_0_60 = {
		tab_selector,
		var_0_6("\xF3Y\xC2]Ώ5\xDFU\xD9@", "\\\xB27\xB64\xB0\xCE")
	}
	local var_0_61 = {
		aa_tab,
		var_0_6("8 x\x19\x1E0c", "uzU\x11")
	}
	local var_0_62 = {
		aa_condition,
		var_0_37[iter_0_2]
	}
	local var_0_63 = var_0_59[iter_0_2].enable
	local var_0_64 = {
		var_0_59[iter_0_2].yaw_type,
		var_0_6("\xAC\xEA&E\xBF", "\xBD\xE8\x8FJ$\xC6")
	}
	local var_0_65 = {
		var_0_59[iter_0_2].mod_type,
		function()
			return var_0_59[iter_0_2].mod_type:get() ~= var_0_6("Ӭ\f", "j\x9C\xCAj.\xB7")
		end
	}

	var_0_59[iter_0_2].label:depend(var_0_60, var_0_61, var_0_62)
	var_0_59[iter_0_2].enable:depend(var_0_60, var_0_61, var_0_62)
	var_0_59[iter_0_2].yaw_type:depend(var_0_63, var_0_60, var_0_61, var_0_62)
	var_0_59[iter_0_2].yaw_delay:depend(var_0_63, var_0_64, var_0_60, var_0_61, var_0_62)
	var_0_59[iter_0_2].yaw_left:depend(var_0_63, var_0_60, var_0_61, var_0_62)
	var_0_59[iter_0_2].yaw_right:depend(var_0_63, var_0_60, var_0_61, var_0_62)
	var_0_59[iter_0_2].mod_type:depend(var_0_63, var_0_60, var_0_61, var_0_62)
	var_0_59[iter_0_2].mod_dm:depend(var_0_63, var_0_60, var_0_61, var_0_62, var_0_65)
	var_0_59[iter_0_2].desync_mode:depend(var_0_63, var_0_60, var_0_61, var_0_62)
end

var_0_58()

function apply_your_settings()
	var_0_29("\affff4akrim.lua : \affffff=== APPLYING SETTINGS FUNCTION CALLED ===")
	var_0_29("\affff4akrim.lua : \affffffApplying your complete configuration...")
	var_0_29("\affff4akrim.lua : \affffffDebug: aa_sys exists: " .. tostring(var_0_59 ~= nil))

	if var_0_59 then
		var_0_29("\affff4akrim.lua : \affffffDebug: aa_sys length: " .. #var_0_59)

		for iter_73_0 = 1, 7 do
			if var_0_59[iter_73_0] then
				var_0_29("\affff4akrim.lua : \affffffDebug: aa_sys[" .. iter_73_0 .. var_0_6("\x00Y~+#.\rh", "J]y\x1BS"))
			else
				var_0_29("\affff4akrim.lua : \affffffDebug: aa_sys[" .. iter_73_0 .. var_0_6("@\xFB\xEFm=\xB5\xEFr<", "\x1E\x1Dۆ"))
			end
		end

		if var_0_59[1] then
			local var_73_0 = 0

			while true do
				if var_73_0 == 1 then
					var_0_59[1].mod_dm:set(-10)
					var_0_59[1].yaw_type:set(var_0_6("%\x1F\xF3>@", "\x9Caz\x9F_9"))

					var_73_0 = 2
				end

				if var_73_0 == 0 then
					var_0_59[1].enable:set(true)
					var_0_59[1].mod_type:set(var_0_6("f\xAC\x10\xEE\xE0Z\n", "n5\xC7y\x9A\x94?x"))

					var_73_0 = 1
				end

				if var_73_0 == 2 then
					var_0_59[1].yaw_delay:set(4)
					var_0_59[1].yaw_left:set(-27)

					var_73_0 = 3
				end

				if var_73_0 == 4 then
					var_0_29("\affff4akrim.lua : \affffffDebug: System 1 set - enable: " .. tostring(var_0_59[1].enable:get()) .. var_0_6("\xC5N|\x84\x17\xF9\x9D\x17a\x8EI\x86", "\xA6\xE9n\x11\xEBs") .. var_0_59[1].mod_type:get())

					break
				end

				if var_73_0 == 3 then
					var_0_59[1].yaw_right:set(21)
					var_0_59[1].desync_mode:set(var_0_6("\xE5\xA4\xD3\xF5", "_\xAEֺ\x98kb"))

					var_73_0 = 4
				end
			end
		end

		if var_0_59[2] then
			local var_73_1 = 0

			while true do
				if var_73_1 == 3 then
					var_0_59[2].yaw_right:set(23)
					var_0_59[2].desync_mode:set(var_0_6("\x9B\xBA\xC3G", "\xD6\xD0Ȫ*S\xAD"))

					break
				end

				if var_73_1 == 1 then
					var_0_59[2].mod_dm:set(7)
					var_0_59[2].yaw_type:set(var_0_6("\x7F\xC6Z$B", "E;\xA36"))

					var_73_1 = 2
				end

				if var_73_1 == 2 then
					var_0_59[2].yaw_delay:set(4)
					var_0_59[2].yaw_left:set(-16)

					var_73_1 = 3
				end

				if var_73_1 == 0 then
					var_0_59[2].enable:set(true)
					var_0_59[2].mod_type:set(var_0_6("K\x05\xCD\xD5\xE6\xBBn", "\x1C\x18n\xA4\xA1\x92\xDE"))

					var_73_1 = 1
				end
			end
		end

		if var_0_59[3] then
			var_0_59[3].enable:set(true)
			var_0_59[3].mod_type:set(var_0_6("\xEA*{\xB4a\xDC3", "\x15\xB9A\x12\xC0"))
			var_0_59[3].mod_dm:set(-14)
			var_0_59[3].yaw_type:set(var_0_6("\xDASQ\x1A\xB8", "\xC1\x9E6={"))
			var_0_59[3].yaw_delay:set(4)
			var_0_59[3].yaw_left:set(-18)
			var_0_59[3].yaw_right:set(14)
			var_0_59[3].desync_mode:set(var_0_6("\x1E\x03)\xB4", "\xD9Uq@"))
		end

		if var_0_59[4] then
			var_0_59[4].enable:set(true)
			var_0_59[4].mod_type:set(var_0_6("x\x04\xC5\xD4\xFB\x87\xF7", "\x85+o\xAC\xA0\x8F\xE2"))
			var_0_59[4].mod_dm:set(-12)
			var_0_59[4].yaw_type:set(var_0_6("\xEF\xA6\\\xD0\xD9", "\xA0\xAB\xC30\xB1"))
			var_0_59[4].yaw_delay:set(4)
			var_0_59[4].yaw_left:set(-19)
			var_0_59[4].yaw_right:set(16)
			var_0_59[4].desync_mode:set(var_0_6("\xF8\x11\x7F ", "\xA7\xB3c\x16M<\xA1\xCF"))
		end

		if var_0_59[5] then
			local var_73_2 = 0

			while true do
				if var_73_2 == 2 then
					var_0_59[5].yaw_delay:set(4)
					var_0_59[5].yaw_left:set(-10)

					var_73_2 = 3
				end

				if var_73_2 == 1 then
					var_0_59[5].mod_dm:set(-16)
					var_0_59[5].yaw_type:set(var_0_6("\xD5\v\xF4\xA5\xE8", "đn\x98"))

					var_73_2 = 2
				end

				if var_73_2 == 3 then
					var_0_59[5].yaw_right:set(16)
					var_0_59[5].desync_mode:set(var_0_6("s<\xF7\xFF", "\x928N\x9E"))

					break
				end

				if var_73_2 == 0 then
					var_0_59[5].enable:set(true)
					var_0_59[5].mod_type:set(var_0_6("2t\x82LX\x04m", ",a\x1F\xEB8"))

					var_73_2 = 1
				end
			end
		end

		if var_0_59[6] then
			local var_73_3 = 0

			while true do
				if var_73_3 == 1 then
					var_0_59[6].mod_dm:set(10)
					var_0_59[6].yaw_type:set(var_0_6("60\xAD\x06\xFC", "~rU\xC1g\x85N4"))

					var_73_3 = 2
				end

				if var_73_3 == 2 then
					var_0_59[6].yaw_delay:set(4)
					var_0_59[6].yaw_left:set(-12)

					var_73_3 = 3
				end

				if var_73_3 == 3 then
					var_0_59[6].yaw_right:set(12)
					var_0_59[6].desync_mode:set(var_0_6("\xEF\xC9;u", "\x18\xA4\xBBR"))

					break
				end

				if var_73_3 == 0 then
					var_0_59[6].enable:set(true)
					var_0_59[6].mod_type:set(var_0_6("\x1E\xD0F\xF2N(\xC9", ":M\xBB/\x86"))

					var_73_3 = 1
				end
			end
		end

		if var_0_59[7] then
			local var_73_4 = 0

			while true do
				if var_73_4 == 1 then
					var_0_59[7].mod_dm:set(-19)
					var_0_59[7].yaw_type:set(var_0_6("\xC2\xD5?\x05\xFF", "d\x86\xB0S"))

					var_73_4 = 2
				end

				if var_73_4 == 2 then
					var_0_59[7].yaw_delay:set(4)
					var_0_59[7].yaw_left:set(-12)

					var_73_4 = 3
				end

				if var_73_4 == 3 then
					var_0_59[7].yaw_right:set(16)
					var_0_59[7].desync_mode:set(var_0_6("\xF8\xD3K\xB0", "u\xB3\xA1\"\xDD\xD3"))

					break
				end

				if var_73_4 == 0 then
					var_0_59[7].enable:set(true)
					var_0_59[7].mod_type:set(var_0_6("\xC2\xD1U\xBE\xE5\xF4\xC8", "\x91\x91\xBA<\xCA"))

					var_73_4 = 1
				end
			end
		end
	end

	if aa_pitch then
		aa_pitch:set(var_0_6("i\xBF\xED\xC8", "\xC5-К\xA6d\x9F"))
	end

	if aa_yaw_base then
		aa_yaw_base:set(var_0_6("\b\xE0ƈ2;\xF3\x83\xA8 ", "SI\x94\xE6\xDC"))
	end

	if aa_tab then
		aa_tab:set(var_0_6("\x11\xCA\xFF\xEC\xEB\x8C!", "\xE9S\xBF\x96\x80\x8F"))
	end

	if safe_head_enabled then
		safe_head_enabled:set(true)
	end

	if avoid_backstab_enabled then
		avoid_backstab_enabled:set(true)
	end

	if aa_fs_enable then
		aa_fs_enable:set(true)
	end

	if aa_fs_key then
		aa_fs_key:set(false)
	end

	if enable_fl then
		enable_fl:set(false)
	end

	if fl_limit then
		fl_limit:set(1)
	end

	if fl_variance then
		fl_variance:set(0)
	end

	if fl_type then
		fl_type:set(var_0_6("ӟ\xC1s\x00\xFE\x85", "m\x97\xE6\xAF\x12"))
	end

	if vis_desync_arrows_color then
		vis_desync_arrows_color:set(255)
	end

	if vis_desync_arrows_distance then
		vis_desync_arrows_distance:set(60)
	end

	if vis_desync_arrows_style then
		vis_desync_arrows_style:set(var_0_6("\x84\xF3RE\x82\xAC\xFFE", "\xE0\xC0\x9A!$"))
	end

	if vis_watermark then
		vis_watermark:set(true)
	end

	if vis_watermark_mode then
		vis_watermark_mode:set(var_0_6("\xC0\x05", "\xE2\xE34x"))
	end

	if vis_watermark_position then
		vis_watermark_position:set(var_0_6(")\xEE\xEA\xB0", "\xD9e\x8B\x8C\xC4*߷"))
	end

	if vis_watermark_color then
		vis_watermark_color:set(155)
	end

	if vis_watermark_color2 then
		vis_watermark_color2:set(0)
	end

	if vis_watermark_color_mode_2 then
		vis_watermark_color_mode_2:set(155)
	end

	if vis_dmg_indicator_enable then
		vis_dmg_indicator_enable:set(true)
	end

	if dmg_indicator_color then
		dmg_indicator_color:set(255)
	end

	if hitrate_enabled then
		hitrate_enabled:set(true)
	end

	if custom_scope_enabled then
		custom_scope_enabled:set(true)
	end

	if custom_scope_color then
		custom_scope_color:set(255)
	end

	if custom_scope_mode then
		custom_scope_mode:set(var_0_6(">\n\xA9\x1BQ\x16\x1B", "$zo\xCFz"))
	end

	if custom_scope_position then
		custom_scope_position:set(50)
	end

	if custom_scope_offset then
		custom_scope_offset:set(10)
	end

	if trash_talk_enable then
		trash_talk_enable:set(false)
	end

	if clantag_enable then
		clantag_enable:set(true)
	end

	if animation_breaker then
		animation_breaker:set({
			var_0_6("\t\t\xF6\xAC\xB0%\x19\t\xEF\xBD", "Tlh\x84\xD8\xD8"),
			var_0_6("\xDF\x17\xCF\\\xE9\xAAE\x8C\b\xCAW\xF7\xE4O\xC3\x0F\xCFW\xEE", "\"\xAC{\xA68\x80\xC4"),
			var_0_6("\xB7\xA5\xA1\xCFC}\xD2T\xA7\xBB\xA7\xDEI{", "t\xC4\xC9ȫ*\x13\xB5"),
			var_0_6("y\x88\xBBZ\a\x0F\tx\x82", "|\x16\xE6\x9B=u`"),
			var_0_6("Į\xF4\xE4\xFC\xE4\xF6", "\x95\xA5ˆ\x8B\x9E\x8D"),
			var_0_6("\"\xB9I%8\xECP#6\xA7\x00*6\xABS", "FS\xCC ")
		})
	end

	if on_ground_options then
		on_ground_options:set(var_0_6("\x1D\x96\n\x87", "\xE0n\xE1k"))
	end

	if on_air_options then
		on_air_options:set(var_0_6("\xE7a\xDC6", "\xA4\x94\x16\xBDQP\xA4"))
	end

	if oth_sw then
		oth_sw:set(false)
	end

	if oth_sw_kb then
		oth_sw_kb:set(false)
	end

	if oth_lm then
		oth_lm:set(var_0_6("\x96\x89d\xB2%Gr\xB6", "\x17\xD2\xE0\x17\xD3G+"))
	end

	if oth_osaa then
		oth_osaa:set(false)
	end

	if oth_osaa_kb then
		oth_osaa_kb:set(false)
	end

	if hitlogs_select then
		hitlogs_select:set({
			var_0_6("\x86\x88P\x84V9\xD9\xF5\xA7", "\x90\xC9\xE6p\xD75K\xBC"),
			var_0_6("z\xCBY\xC9\xF9\xABF\xCA\x15\xEF", "\xC55\xA5y\x8A\x96")
		})
	end

	if misslogs_select then
		misslogs_select:set({
			var_0_6("\xC2љ\x13\xEE\xCD\xDC%\xE3", "@\x8D\xBF\xB9"),
			var_0_6(",\xE4\xF0\xF9\xF8ǵ\f\xE6\xB5", "\xC6c\x8Aк\x97\xA9")
		})
	end

	if safe_head_states then
		safe_head_states:set({
			var_0_6(",\xFC\x91\x1E&\xFB\x8AX\b", ">m\x95\xE3"),
			var_0_6("ҁ\x9B\x94:\xF6\x9D\x9A", "`\x93\xE8\xE9\xB4"),
			var_0_6("\x1B,\x1BE\x890&?", "YHXz+\xED"),
			var_0_6("\x0F\xA9\xAA#\x18$\xBE\xA1", "{L\xDB\xC5V"),
			var_0_6("{\xCA\x1A\x19\xED7]\xDCU-\xE7-", "_8\xB8ul\x8E")
		})
	end

	var_0_29("\affff4akrim.lua : \affffff✓ Complete configuration applied!")
	var_0_29("\affff4akrim.lua : \affffff✓ Anti-aim: 7 systems with Skitter jitter")
	var_0_29("\affff4akrim.lua : \affffff✓ Visuals: Watermark, desync arrows, hitrate")
	var_0_29("\affff4akrim.lua : \affffff✓ Misc: Clantag, animation breaker, custom scope")
end

local function var_0_66(arg_74_0)
	local var_74_0 = 0
	local var_74_1
	local var_74_2
	local var_74_3

	while true do
		if var_74_0 == 1 then
			return math.sqrt(var_74_1 * var_74_1 + var_74_2 * var_74_2 + var_74_3 * var_74_3)
		end

		if var_74_0 == 0 then
			local var_74_4 = 0

			while true do
				if var_74_4 == 1 then
					var_74_0 = 1

					break
				end

				if var_74_4 == 0 then
					var_74_1, var_74_2, var_74_3 = entity.get_prop(arg_74_0, var_0_6("\xFD\xFD0\xE9\xF3\xF4#\xE0\xFF\xC1/\xF8\xE9", "\x8C\x90\xA2F"))

					if var_74_1 == nil then
						return
					end

					var_74_4 = 1
				end
			end
		end
	end
end

local function var_0_67()
	local var_75_0 = 0
	local var_75_1
	local var_75_2
	local var_75_3
	local var_75_4
	local var_75_5
	local var_75_6
	local var_75_7
	local var_75_8
	local var_75_9

	while true do
		if var_75_0 == 3 then
			local var_75_10 = 0

			while true do
				if var_75_10 == 1 then
					if var_75_7 then
						return var_0_6("\xCD#\xC5", ".\x8Cj\x97ඓ")
					end

					var_75_0 = 4

					break
				end

				if var_75_10 == 0 then
					if bit.band(var_75_2, bit.lshift(1, 0)) == 0 then
						local var_75_11 = 0

						while true do
							if var_75_11 == 0 then
								var_75_7 = true
								var_75_8 = globals.tickcount() + 3

								break
							end
						end
					else
						var_75_7 = var_75_8 > globals.tickcount() and true or false
					end

					if var_75_7 and var_75_3 then
						return var_0_6("&n}\xBE[", "<g'/\x93\x18")
					end

					var_75_10 = 1
				end
			end
		end

		if var_75_0 == 2 then
			var_75_7 = false
			var_75_8 = 0

			local var_75_12 = 0

			var_75_0 = 3
		end

		if var_75_0 == 4 then
			if var_75_3 then
				return var_0_6("\xCF\x18^i\xCE\t", "\"\x8BM\x1D")
			end

			if var_75_6 then
				return var_0_6("\x87\xD11\x7F", "IА}4")
			end

			if var_75_5 < 8 then
				do return var_0_6("\x19ث\xE5\xE3", "\xABJ\x8Cꫧp3") end

				break
			end

			do return var_0_6("\x1D;b", "\xCDOn,?\x91") end

			break
		end

		if var_75_0 == 1 then
			local var_75_13 = {
				entity.get_prop(var_75_1, var_0_6("\xBA0\xA6\x11O+\xB2\x03\xBF\x17E\t\xAE", "}\xD7o\xD0t,"))
			}

			var_75_5 = math.sqrt(var_75_13[1]^2 + var_75_13[2]^2)
			var_75_6 = ui.get(var_0_39.antiaim.slowwalk[1]) and ui.get(var_0_39.antiaim.slowwalk[2])
			var_75_0 = 2
		end

		if var_75_0 == 0 then
			var_75_1 = entity.get_local_player()
			var_75_2 = entity.get_prop(var_75_1, var_0_6("\xDD\x17_T\xE2\xD1/J", "\x8E\xB0H9\x12"))
			var_75_3 = entity.get_prop(var_75_1, var_0_6("\xAB\x0E\x16(\x82$\x13/\x87<\x1F1\xA8%", "D\xC6Qp")) > 0.7
			var_75_0 = 1
		end
	end
end

local var_0_68 = 1
local var_0_69 = 0
local var_0_70 = false
local var_0_71 = ""
local var_0_72 = 0
local var_0_73 = false
local var_0_74 = 0

local function var_0_75(arg_76_0)
	var_0_74 = math.max(entity.get_prop(arg_76_0, var_0_6("\xAA`1\xFC\xBD\b\xAF>\xA6L:", "|\xC7?_\xA8\xD4k\xC4")), var_0_74 or 0)

	return math.abs(entity.get_prop(arg_76_0, var_0_6("\v\x97]\x0E\xAD\xF4\x82\xD1\a\xBBV", "\x93f\xC83Zė\xE9")) - var_0_74) > 2 and math.abs(entity.get_prop(arg_76_0, var_0_6("6\xCF\xE1\xF9\xB7\xE30\x19\xF1\xFC\xC8", "[[\x90\x8F\xADހ")) - var_0_74) < 14
end

client.set_event_callback(var_0_6("-\xA5Xn\xBE^'\xA1XT\x94K-\xA4", ".C\xC0,1\xCB"), function()
	local var_77_0 = 0
	local var_77_1

	while true do
		if var_77_0 == 0 then
			local var_77_2 = entity.get_local_player()

			if var_77_2 and entity.is_alive(var_77_2) and dt_active then
				var_0_73 = var_0_75(var_77_2)
			end

			break
		end
	end
end)

local var_0_76 = false
local var_0_77 = {
	[var_0_6("\x14\xDF:\xA1,", "ed\xB6N\xC2D\xC4")] = {
		ui.reference(var_0_6("ii", "\xB5((P\x95\xED+\x18"), var_0_6("4\xBC1;\xF7K\x1B\x18\xB0*&\xFAK\x1C\x12\xBE !", "ru\xD2ER\xDA*"), var_0_6("t\xDFLp\xA4", "\xCC$\xB68\x13"))
	},
	[var_0_6("\xF0J˼\x7F9\x01\xEC", "r\x89+\xBC\xE3\x1DX")] = ui.reference(var_0_6("\xC5<", "p\x84}\xC8"), var_0_6("ܶ\xE7z\x17\xF4\xF4\xB5\xF1|N\xB5\xFC\xB6\xF4\x7F_\xE6", "\x95\x9Dؓ\x13:"), var_0_6("\xF0\x87\x0F\x88ˇ\v\xCD", "\xA8\xA9\xE6x")),
	[var_0_6("匓", "w\x9C\xED\xE4")] = {
		ui.reference(var_0_6("\xE2\xF0", "\x1E\xA3\xB1`"), var_0_6(";.A\x80p*\xDD\x17\"Z\x9D}*\xDA\x1D,P\x9A", "\xB4z@5\xE9]K"), var_0_6("\xEF\x16\x04", "]\xB6ws"))
	},
	[var_0_6("\x88\x16ǘ\xB2\xEC", "\x9E\xE2\x7F\xB3\xEC\xD7")] = {
		ui.reference(var_0_6("\xD0\xE1", "\xB6\x91\xA0\xA9"), var_0_6("\x18.$\x1F\xEA\x0E0-2\x19\xB3O8.7\x1A\xA2\x1C", "oY@Pv\xC7"), var_0_6("\x86\xB6\x19\x06\xB5\xBE\x1AR\xBA\xA5", "&\xDF\xD7n"))
	},
	[var_0_6("\\\xC2\r\xD2", "\xCB>\xBBl\xA5")] = {
		ui.reference(var_0_6("\xD8U", "\xB0\x99\x14(^\x11\x9E"), var_0_6("\x89=\xAFZ\x88\xA9:\xB6Qʼs\xBA]¤6\xA8", "\xA5\xC8S\xDB3"), var_0_6("\xE5\xE5pb\x91\xAC\xBD\xF3", "\x84\xA7\x8A\x14\x1B\xB1\xD5\xDC"))
	},
	[var_0_6("\xF4\xD7\xFA", "\\\x92\xB5\x83,")] = ui.reference(var_0_6("j\xDF", "\xBD+\x9E!\xE6\xDE w"), var_0_6("\x7F\xCEYX\xC5_\xC9@S\x87J\x80L_\x8FR\xC5^", "\xE8>\xA0-1"), var_0_6("R\xC1\xF0\xA9\xB2`\xD2\xFB\xA8\xA8zԵ\xAE\xAEpʵ\xB5\xA0c", "\xC1\x14\xB3\x95\xCC")),
	[var_0_6("\xD2\x05\x86\xC7", "\xA2\xB7a\xE1")] = ui.reference(var_0_6("\b\xE4", "\xC1I\xA5\x84\x97|\x82"), var_0_6("\xEC̽R\xFB\xB7\xC4ϫT\xA2\xF6\xCC̮W\xB3\xA5", "֭\xA2\xC9;\xD6"), var_0_6("\x06}\xADD\x979\"n", "@C\x19\xCA!\xB7")),
	[var_0_6("\xEF\xFCt\xB9=\xC6B\xE7\xEAx\xB2)", "#\x89\x8E\x11\xDCN\xB2")] = {
		ui.reference(var_0_6("\fo", "aM.E"), var_0_6("\xFE\xD1\x14\xAC\x92\xDE\t\xA8\xDD\xD0\x14\xE5\xDE\xD1\a\xA9\xDA\xCC", "ſ\xBF`"), var_0_6("\xEC;\xE8KK\xFCL\xC4-\xE4@_", "-\xAAI\x8D.8\x88"))
	},
	[var_0_6("\x93\x00\xC1\xE9", "g\xE1o\xAD\x85\xCF\xE7")] = ui.reference(var_0_6("m\xA5", "5,\xE4\x95"), var_0_6("\xEC\xD5/\f\x86%\xC4\xD69\n\xDFd\xCC\xD5<\t\xCE7", "D\xAD\xBB[e\xAB"), var_0_6("\xCE\x00\x1E\xCB", "\xB9\x9Cor\xA7)\xE2\x1D")),
	[var_0_6("\x04\x16", "\x83kev@\xD4")] = {
		ui.reference(var_0_6("\xE0\xF7", "\xA9\xA1\xB6LK'\xA0"), var_0_6("\xF6F\xBF\x8E\t", "ȹ2\xD7\xEB{B"), var_0_6("ݏ\x99\xF1\x82y\x0E\xB2\x80\xD7\xF6\x83;\x1B\xFB\x8C", "z\x92Ṃ\xEA\x16"))
	},
	[var_0_6("\xBD\xF6", "\xDBق\xA0\xAF\x8F")] = {
		ui.reference(var_0_6("\f\x9De\x18", "]^\xDC\""), var_0_6(".\xC1̈\xD5\xE3", "\x9Do\xA8\xA1꺗"), var_0_6("_O`3μ\xF2\x91zP", "\xE5\x1B \x15Q\xA2\xD9\xD2"))
	},
	[var_0_6("?\xC0\xF4-]-\xC0\xF0", "*L\xAC\x9BZ")] = {
		ui.reference(var_0_6("Ӭ", "`\x92\xED\xE1I"), var_0_6("\xC7j\x00\xED[", "\xC2\x88\x1Eh\x88)\x1A"), var_0_6("\xEF\xDA\f_T\xBD\xA6;\xD5\xD9\r", "O\xBC\xB6c(t\xD0\xC9"))
	},
	[var_0_6("q\xCE", "_\x1D\xA3J!C")] = ui.reference(var_0_6("]\x13", "d\x1CR W\x1F\xEA"), var_0_6("\x1EF\xE8t\xE9", "^Q2\x80\x11\x9B\xB6\x88"), var_0_6("\xA79\xE3y\xEF\xBB\n\x82\x869\xEA-", "\xE7\xEB\\\x84Y\x82\xD4|")),
	[var_0_6("\xEC\xBB\xF83\xC2N\xFB\xB1\xE0", "%\x9EԔ_\xB1")] = ui.reference(var_0_6("U=", "m\x14|\xC4\xE7"), var_0_6("\x81\xB3`\xAC|!\xA9\xB0v\xAA%`\xA1\xB3s\xA943", "@\xC0\xDD\x14\xC5Q"), var_0_6("\x9D\xF9\xEE\xAE", "\xC7ϖ\x82\xC2")),
	[var_0_6("\xB3Kp\xED|\xB1_x\xE3", "#\xD5*\x1B\x88")] = ui.reference(var_0_6("\x92\xA6\x1C\x9A", "\x92\xC0\xE7[߸"), var_0_6("u\xE5\xFE,\xC3", "n:\x91\x96I\xB1\xD4g"), var_0_6("\xD0!\xC9\xF9\v\xDB\xEC\xF1?\x8A\xF3X\xD8\xE0\xE7 ", "\x89\x94T\xAA\x92+\xAB")),
	[var_0_6("\x04\xD1~\xFF{\x04\xD9s", "\x17a\xBF\x1F\x9D")] = ui.reference(var_0_6("\xA7\xA3", "R\xE6\xE2ge\xBD"), var_0_6("\xAD+\xB8\xB4T\x87+\xB4", "t\xEBJ\xD3\xD1"), var_0_6("\r2\xDF'$9\xDA", "EH\\\xBE")),
	[var_0_6("35\xE5֧\xAD\x0E\xAF.", "\xD7V[\x84\xB4\xCB\xC8v")] = ui.reference(var_0_6("\x12\xCF", "\xB3S\x8E\xE6"), var_0_6("\xFB!\xE9<t\x1E\xFE\xD2\xD8 \xE9u8\x11\xF0\xD3\xDF<", "\xBF\xBAO\x9DUY\x7F\x97"), var_0_6("\xD3t\xA5̈@\xF2", "%\x96\x1AĮ\xE4")),
	[var_0_6("\xCF\xFC\x8DT:\x86\xDC\xFE\xA6", "驐\xD25W")] = ui.reference(var_0_6("\x03g", "\xBCB&\x8D"), var_0_6("\xC7Q\x0643N\t\xCF", "\xA8\x810mQ\x13\"h"), var_0_6("V\x19\x03%\xD11", "\x99\x17tlP\xBFE\xDB")),
	[var_0_6("O\x13\xC2\xD4\xF1\x86\x7F]", "\x16)\x7F\x9D\xB8\x98\xEB")] = ui.reference(var_0_6("6\xE6", "\xAAw\xA7\x81"), var_0_6("\xFC\xF1\xB7v\xC3R\xDB\xF7", ">\xBA\x90\xDC\x13\xE3"), var_0_6("\x8D\xF5\xE1ߵ", "\xB6\xC1\x9C\x8C")),
	[var_0_6("\xC7@)\xA4\xE7-", "_\xA1,v҆")] = ui.reference(var_0_6("\xC7a", "Ά sm\x1A\xB6\x85"), var_0_6("0\xF9\xC4\x16\x1DQ7\xFF", "=V\x98\xAFs="), var_0_6("\xBF\x00\xCE9Џ \xC2", "\xA7\xC9a\xBCP\xB1\xE1C")),
	[var_0_6("]\x18\xBB\xA4\xF9\x98", "\xE1.h\xE4Ϝ")] = ui.reference(var_0_6("\x98\xE1\x94k", "\xDFʠ\xD3.W3\xD2"), var_0_6("\xF7\xE0\x17v\x02\xC2", "m\xB6\x89z\x14"), var_0_6("t\xA6\x00\xF9\xE5\x97\xF9}T\xACR\xEA\xEF\xDE\xE4h", "\x1C2\xC9r\x9A\x80\xB7\x8A")),
	[var_0_6("\xA8\x87\x10\xFF\x95\x8D\x1C\xEB", "\x92\xCA\xE6y")] = ui.reference(var_0_6("\xDC\xCE\xC9;", "^\x8E\x8F\x8E~\xA7\xD2\xC0"), var_0_6("!\xCC\x10\xE3\xC8\x14", "\xA7`\xA5}\x81"), var_0_6("!\xD9\x04EGfI\x87\x03\xCFVGK+", "\xE8g\xB6v&\"F+")),
	[var_0_6("$B&\xE0;a0R$", "\x11U7O\x83P")] = {
		ui.reference(var_0_6("\xFA\xA4\x9E\x89", "_\xA8\xE5\xD9\xCC"), var_0_6("\xA5/\x8E\x8C\x98", "\xE9\xEA[\xE6"), var_0_6("`T\x8Bp\xAC\x11Q\x87v\xAC\x11@\x91`\xAEBU", "\xC71!\xE2\x13"))
	},
	[var_0_6("PO", "\xA72;#\x7F")] = {
		ui.reference(var_0_6("z2u\xC9", "\xC8(s2\x8C"), var_0_6("\xDC9\x7F\x1A\xE1", "\x7F\x93M\x17"), var_0_6("\xAA\xE5\xF6ab\x8A\xE5\xEC4r\x84\xE9\xE6`", "\x10놕\x14"))
	},
	[var_0_6("\xDCD\\\xA5\t\xB8\x1F\xDBMK\x99\x1C\x88\x05\xD4_", "l\xBA+.\xC6l\xE7")] = ui.reference(var_0_6("\x00\x9E\xD2$", "\x1CRߕa"), var_0_6("\x8C<@\\\xA2!", ">\xCDU-"), var_0_6("S\x03\xB3\xAA\a\xC9\x1At\n\xA4\xE9\x12\x86\x00{\x18", "i\x15l\xC1\xC9b\xE9")),
	[var_0_6("M\x8C\x15\xFA\xCE9", "\xBA \xE5{\x9E\xA3^")] = ui.reference(var_0_6("6\x02V\xEF", "WdC\x11\xAAy\xC5"), var_0_6("ς\xB7\x82X\xA1", "Վ\xEB\xDA\xE07"), var_0_6("%\xAB\xF7\xCC\x05\xB7\xF4\x85\f\xA3\xF4\xC4\x0F\xA7", "\xA5h\xC2\x99")),
	[var_0_6("\x941߮\xE9R\x84\x89$", "\xED\xE7P\xB9˙=")] = ui.reference(var_0_6("\x97\x11\xA7W", "%\xC5P\xE0\x12"), var_0_6("8KAD\xBB\r", "\xD4y\",&"), var_0_6("\x9C\xB58\x06{\xED\xE1_\xBC\xBFj\x15q\xA4\xFCJ", ">\xDA\xDAJe\x1E͒")),
	[var_0_6("D\xA6k\xF2\xD8<E&O", "O\"\xC9\x19\x91\xBD^$")] = ui.reference(var_0_6("r\r\xCD/", "4 L\x8Aj "), var_0_6("\x99\xF3=\xC4u\xAC", "\x1AؚP\xA6"), var_0_6("\xEA\xC6\xFF@xl\xCE\xC6\xE9Z=-\xC5\xC4", "L\xAC\xA9\x8D#\x1D"))
}

client.set_event_callback(var_0_6("\xCF\xDC\xEC\x16\xCC\xE6\xFB\f\xD1\xD4\xF9\r\xD8", "c\xBC\xB9\x98"), function(arg_78_0)
	local var_78_0 = entity.get_local_player()
	local var_78_1 = entity.get_prop(var_78_0, var_0_6("\xDF+\xB0\x02\x8D\xD7\f\xA2/\xB7\xC6\x15\xB5\x05", "òt\xD6n")) or 0
	local var_78_2 = entity.get_prop(entity.get_player_weapon(var_78_0), var_0_6("\bȀy\xEF\xE3\x1D\xE3\xB6g\xC8\xEB\x04\xE5\x9FT\xD5\xF2\x04\xF4\x8D", "\x86e\x97\xE6\x15\xA1")) or 0
	local var_78_3 = ui.get(var_0_77.dt[2])
	local var_78_4 = not (math.max(var_78_2, var_78_1) > globals.curtime())

	if ragebot_activation_key:get() then
		ragebot_active = true
	else
		ragebot_active = false
	end

	if var_78_3 and var_78_4 then
		var_0_76 = true
	else
		var_0_76 = false
	end

	if var_78_0 and entity.is_alive(var_78_0) then
		var_0_73 = var_0_75(var_78_0)

		local var_78_5 = 1
		local var_78_6 = var_0_7(entity.get_prop(var_78_0, var_0_6("\xA4\xB5,Q \x04奅9]7+", "\x80\xC9\xEAZ4CR")))
		local var_78_7 = math.sqrt(var_78_6.x * var_78_6.x + var_78_6.y * var_78_6.y)
		local var_78_8 = entity.get_prop(var_78_0, var_0_6("\xA9r8RƥJ-", "\xAA\xC4-^\x14"))
		local var_78_9 = entity.get_prop(var_78_0, var_0_6("s{\x038\xE553ue\b;\xD4.$", "P\x1E$eT\xA1@"))
		local var_78_10 = bit.band(var_78_8, 1) == 0 and (var_78_9 > 0.1 and 6 or 5) or var_78_9 > 0.1 and (var_78_7 > 5 and 7 or 7) or var_78_7 < 5 and 2 or var_78_7 < 100 and 3 or 4

		if ui.get(var_0_42[var_78_10].defensive_anti_aimbot) then
			if ui.get(var_0_42[var_78_10].defensive_pitch) then
				local var_78_11 = 0
				local var_78_12

				while true do
					if var_78_11 == 0 then
						local var_78_13 = 0

						while true do
							if var_78_13 == 0 then
								ui.set(var_0_39.antiaim.pitch[1], ui.get(var_0_42[var_78_10].defensive_pitch1))

								if ui.get(var_0_42[var_78_10].defensive_pitch1) == var_0_6("\x94P\x17F\xD76", "[\xC61y\"\xB8") then
									local var_78_14 = 0
									local var_78_15

									while true do
										if var_78_14 == 0 then
											local var_78_16 = 0

											while true do
												if var_78_16 == 0 then
													ui.set(var_0_39.antiaim.pitch[1], var_0_6("\x17\xD3d\xAD\x869", "\xE9T\xA6\x17\xD9"))
													ui.set(var_0_39.antiaim.pitch[2], math.random(ui.get(var_0_42[var_78_10].defensive_pitch2), ui.get(var_0_42[var_78_10].defensive_pitch3)))

													break
												end
											end

											break
										end
									end

									break
								end

								ui.set(var_0_39.antiaim.pitch[2], ui.get(var_0_42[var_78_10].defensive_pitch2))

								break
							end
						end

						break
					end
				end
			end

			if ui.get(var_0_42[var_78_10].defensive_yaw) then
				local var_78_17 = 0

				while true do
					if var_78_17 == 1 then
						if ui.get(var_0_42[var_78_10].defensive_yaw1) == var_0_6("tn\xB3", "\xCBEV\x83\x90\xAE") then
							local var_78_18 = 0
							local var_78_19

							while true do
								if var_78_18 == 0 then
									local var_78_20 = 0

									while true do
										if var_78_20 == 0 then
											ui.set(var_0_39.antiaim.yaw[1], var_0_6("\xE8F\x03", "q\xD9~39\xA80\x87"))
											ui.set(var_0_39.antiaim.yaw[2], ui.get(var_0_42[var_78_10].defensive_yaw2))

											break
										end
									end

									break
								end
							end

							break
						end

						if ui.get(var_0_42[var_78_10].defensive_yaw1) == var_0_6(",\x05?F", "\xAE\x7FuV((\x1F\x16") then
							local var_78_21 = 0

							while true do
								if var_78_21 == 0 then
									ui.set(var_0_39.antiaim.yaw[1], var_0_6("\xEF+E\xD5", "\xBB\xBC[,"))
									ui.set(var_0_39.antiaim.yaw[2], ui.get(var_0_42[var_78_10].defensive_yaw2))

									break
								end
							end

							break
						end

						if ui.get(var_0_42[var_78_10].defensive_yaw1) == var_0_6("N\xAF.e\xD8", "m\x7F\x97\x1EE\x82") then
							local var_78_22 = 0

							while true do
								if var_78_22 == 0 then
									ui.set(var_0_39.antiaim.yaw[1], var_0_6("\x83\xDD'X\xFF", "v\xB2\xE5\x17x\xA5\xB0\xD2"))
									ui.set(var_0_39.antiaim.yaw[2], ui.get(var_0_42[var_78_10].defensive_yaw2))

									break
								end
							end

							break
						end

						if ui.get(var_0_42[var_78_10].defensive_yaw1) == var_0_6("6\xD5H\f\x1B\xAE8\xAE", "\xDDe\xBC,il\xCFA") then
							local var_78_23 = 0

							while true do
								if var_78_23 == 0 then
									ui.set(var_0_39.antiaim.yaw[1], var_0_6("\ahG", "\xB26Pw\xC2"))

									if arg_78_0.command_number % 4 >= 2 then
										ui.set(var_0_39.antiaim.yaw[2], math.random(85, 100))

										break
									end

									ui.set(var_0_39.antiaim.yaw[2], math.random(-100, -85))

									break
								end
							end

							break
						end

						if ui.get(var_0_42[var_78_10].defensive_yaw1) == var_0_6("\x06\x0EO\xC6\xE0\xF4", "\xA2To!\xA2\x8F\x99\xD9") then
							local var_78_24 = 0

							while true do
								if var_78_24 == 0 then
									ui.set(var_0_39.antiaim.yaw[1], var_0_6("v\x83M", "\xEAG\xBB}"))
									ui.set(var_0_39.antiaim.yaw[2], math.random(-180, 180))

									break
								end
							end
						end

						break
					end

					if var_78_17 == 0 then
						ui.set(var_0_39.antiaim.yaw_jitter[1], var_0_6("W~\xFE", "A\x18\x18\x98\x86V"))
						ui.set(var_0_39.antiaim.body_yaw[1], var_0_6("\x93'\xF8F\xAF>\xFCL", ")\xDCW\x88"))

						var_78_17 = 1
					end
				end
			end
		end
	end
end)
client.set_event_callback(var_0_6("\x029EN\xEE.?^V\xF3\x102U", "\x9Eq\\1;"), function(arg_79_0)
	choko = arg_79_0.chokedcommands
end)

local function var_0_78()
	ui.set(var_0_39.antiaim.enabled, true)
	ui.set(var_0_39.antiaim.yaw[1], var_0_6("\xBD(\x11", "g\x8C\x10!\x10\x9Ef\xBA"))

	local var_80_0 = entity.get_local_player()

	if var_80_0 == nil then
		return
	end

	desync_side = entity.get_prop(var_80_0, var_0_6("ʲ\xBBy33Ԉ\x8Dt\x11=ʈ\xA9p\x11", "\\\xA7\xED\xDD\x15c"), 11) * 120 - 60 > 0 and 1 or -1

	local var_80_1 = var_0_67()
	local var_80_2 = false

	for iter_80_0 = 1, 7 do
		if var_0_59[iter_80_0] and var_0_59[iter_80_0].enable and var_0_59[iter_80_0].enable:get() then
			var_80_2 = true

			break
		end
	end

	if var_80_2 then
		if var_80_1 == var_0_6("\xDB\x15\x0E\r\xDA\x04", "F\x9F@M") and var_0_59[7] and var_0_59[7].enable:get() then
			var_0_68 = 7
		elseif var_80_1 == var_0_6("\xF6f`\xB29", "z\xB7/2\x9F") and var_0_59[6] and var_0_59[6].enable:get() then
			var_0_68 = 6
		elseif var_80_1 == var_0_6("\xE3\x18\x95", "\xE0\xA2Q\xC7/") and var_0_59[5] and var_0_59[5].enable:get() then
			var_0_68 = 5
		elseif var_80_1 == var_0_6("\xDAp\x1D", "\xE3\x88%S]") and var_0_59[4] and var_0_59[4].enable:get() then
			var_0_68 = 4
		elseif var_80_1 == var_0_6("n\x8C$_", "\x149\xCDh") and var_0_59[3] and var_0_59[3].enable:get() then
			var_0_68 = 3
		elseif var_80_1 == var_0_6("\x1B\x9F9\x97>", "SH\xCBx\xD9z:") and var_0_59[2] and var_0_59[2].enable:get() then
			var_0_68 = 2
		else
			var_0_68 = 1
		end
	else
		var_0_68 = 1
	end

	if var_80_1 ~= var_0_71 or var_0_68 ~= var_0_72 then
		var_0_71 = var_80_1
		var_0_72 = var_0_68
	end

	ui.set(var_0_39.antiaim.fsbodyyaw, false)

	if aa_pitch:get() == var_0_6("\x98ਢ\xAD\xB1\xBA\xB8", "\xDF܉\xDB\xC3\xCF\xDD") then
		local var_80_3 = 0
		local var_80_4

		while true do
			if var_80_3 == 0 then
				local var_80_5 = 0

				while true do
					if var_80_5 == 0 then
						ui.set(var_0_39.antiaim.pitch[1], var_0_6("0]L\xF6#\x1E", "Ls(?\x82"))
						ui.set(var_0_39.antiaim.pitch[2], 0)

						break
					end
				end

				break
			end
		end
	else
		local var_80_6 = 0

		while true do
			if var_80_6 == 0 then
				ui.set(var_0_39.antiaim.pitch[1], var_0_6("\xA4\x0F>\xB9\xB9\xDC", "\xB1\xE7zM\xCD\xD6"))
				ui.set(var_0_39.antiaim.pitch[2], 89)

				break
			end
		end
	end

	ui.set(var_0_39.antiaim.yawbase, aa_yaw_base:get())

	local var_80_7 = var_0_6("k\x15G", "<$s! \xC9")
	local var_80_8 = 0
	local var_80_9 = var_0_6("\x93sQGYR)", "\xC1\xD7\x167&,>]")
	local var_80_10 = 4
	local var_80_11 = 0
	local var_80_12 = 0

	if var_0_59[var_0_68] and var_0_59[var_0_68].mod_type then
		var_80_7 = var_0_59[var_0_68].mod_type:get()
		var_80_8 = var_0_59[var_0_68].mod_dm:get()
		var_80_9 = var_0_59[var_0_68].yaw_type:get()
		var_80_10 = var_0_59[var_0_68].yaw_delay:get()
		var_80_11 = var_0_59[var_0_68].yaw_left:get()
		var_80_12 = var_0_59[var_0_68].yaw_right:get()
	else
		var_80_7 = var_0_6("\x1C\x19\a\xDB\xC1\xFE=", "\x9BOrn\xAF\xB5")
		var_80_8 = -10
		var_80_9 = var_0_6("|Q\xD5\xE5\xA8", "\xB584\xB9\x84\xD1\xEC")
		var_80_10 = 4
		var_80_11 = -27
		var_80_12 = 21
	end

	ui.set(var_0_39.antiaim.yaw_jitter[1], var_80_7)
	ui.set(var_0_39.antiaim.yaw_jitter[2], var_80_8)

	if var_80_9 == var_0_6("\x16Iީ\\", "\x9AR,\xB2\xC8%\xC9") then
		if globals.tickcount() > var_0_69 + var_80_10 then
			if choko == 0 then
				local var_80_13 = 0

				while true do
					if var_80_13 == 0 then
						var_0_70 = not var_0_70
						var_0_69 = globals.tickcount()

						break
					end
				end
			end
		elseif globals.tickcount() < var_0_69 then
			var_0_69 = globals.tickcount()
		end

		ui.set(var_0_39.antiaim.body_yaw[1], var_0_6("F\xFF\x03\x19\xB7K", "\x15\x15\x8Bbm\xDE("))
		ui.set(var_0_39.antiaim.body_yaw[2], var_0_70 and 1 or -1)

		if desync_side == 1 then
			ui.set(var_0_39.antiaim.yaw[2], var_80_11)
		elseif desync_side == -1 then
			ui.set(var_0_39.antiaim.yaw[2], var_80_12)
		end
	else
		local var_80_14 = 0
		local var_80_15

		while true do
			if var_80_14 == 0 then
				local var_80_16 = 0

				while true do
					if var_80_16 == 1 then
						if desync_side == 1 then
							ui.set(var_0_39.antiaim.yaw[2], var_80_11)

							break
						end

						if desync_side == -1 then
							ui.set(var_0_39.antiaim.yaw[2], var_80_12)
						end

						break
					end

					if var_80_16 == 0 then
						if globals.tickcount() > var_0_69 + 1 then
							if choko == 0 then
								var_0_70 = not var_0_70
								var_0_69 = globals.tickcount()
							end
						elseif globals.tickcount() < var_0_69 then
							var_0_69 = globals.tickcount()
						end

						if var_80_11 == 0 and var_80_12 == 0 then
							ui.set(var_0_39.antiaim.body_yaw[1], var_0_6("7\xF8\xAD\x983\a", "Zd\x8C\xCC\xEC"))
							ui.set(var_0_39.antiaim.body_yaw[2], -60)
						else
							local var_80_17 = 0

							while true do
								if var_80_17 == 0 then
									ui.set(var_0_39.antiaim.body_yaw[1], var_0_6("\x9F\x00?ؾ\x1B", "x\xCCt^\xAC\xD7"))
									ui.set(var_0_39.antiaim.body_yaw[2], var_0_70 and 1 or -1)

									break
								end
							end
						end

						var_80_16 = 1
					end
				end

				break
			end
		end
	end

	ui.set(var_0_39.antiaim.freestand[1], aa_fs_enable:get())
	ui.set(var_0_39.antiaim.freestand[2], aa_fs_key:get() and var_0_6("\"\xB1\xAF\t\xF2\xB10p\r", "\x1Fc\xDD\xD8h\x8B\xC2\x10") or var_0_6("\x1A\xAE\xAA\x04\x06\xF7>\xA5\xF3", "\x83U\xC0\x8Ali"))
end

local function var_0_79()
	local var_81_0 = 0

	while true do
		if var_81_0 == 1 then
			ui.set(var_0_39.fakelag.variance, fl_variance:get())
			ui.set(var_0_39.fakelag.limit, fl_limit:get())

			var_81_0 = 2
		end

		if var_81_0 == 0 then
			ui.set(var_0_39.fakelag.enabled[1], enable_fl:get())
			ui.set(var_0_39.fakelag.enabled[2], var_0_6("\x17\xA8h\x02/\xB7?\f8", "cV\xC4\x1F"))

			var_81_0 = 1
		end

		if var_81_0 == 2 then
			ui.set(var_0_39.fakelag.amount, var_0_6("}5W\xF4R\xB2\x02", "o0T/\x9D?\xC7"))

			break
		end
	end
end

local function var_0_80()
	local var_82_0 = 0

	while true do
		if var_82_0 == 0 then
			if oth_lm:get() == var_0_6(">\x0F\x93\xA6,\x16\x03\x84", "Nzf\xE0\xC7") then
				ui.set(var_0_39.other.leg_movement, var_0_6("\xD3\x1Er", "\x9F\x9Cx\x14cTe\xCE"))
			end

			if oth_lm:get() == var_0_6("]\x1D\x9B~\xD1R", "G\x1Cq\xEC\x1F\xA8!\x17") then
				ui.set(var_0_39.other.leg_movement, var_0_6("l\xF24\xF9\xC0\xCA{\xB4A\xF7'\xFD", "\xC7-\x9EC\x98\xB9\xB9["))
			end

			var_82_0 = 1
		end

		if var_82_0 == 3 then
			ui.set(var_0_39.other.osaa[2], oth_osaa_kb:get() and var_0_6("\xED$`8\xDA`\x8C'y", "\x13\xACH\x17Y\xA3") or var_0_6("\x18R\x8F\xED:F\xAE2E", "\xC5W<\xAF\x85U2"))

			break
		end

		if var_82_0 == 2 then
			ui.set(var_0_39.other.enabled_slw[2], oth_sw_kb:get() and var_0_6("cW7\xD9dQ\x1B/\xD6", "\x1D\";@\xB8") or var_0_6("=\x10\b\xC2:I\x19\x1BQ", "=r~(\xAAU"))
			ui.set(var_0_39.other.osaa[1], oth_osaa:get())

			var_82_0 = 3
		end

		if var_82_0 == 1 then
			if oth_lm:get() == var_0_6("t|\xAB\xAB\xC2", "\xB0:\x19\xDDΰv\xB7") then
				ui.set(var_0_39.other.leg_movement, var_0_6("\x1C\x14\xCF\x03\xFC\xF8!\x1D\xD0\x02\xEB", "\xD8Rq\xB9f\x8E"))
			end

			ui.set(var_0_39.other.enabled_slw[1], oth_sw:get())

			var_82_0 = 2
		end
	end
end

function hide_original_menu(arg_83_0)
	ui.set_visible(var_0_39.antiaim.enabled, arg_83_0)
	ui.set_visible(var_0_39.antiaim.pitch[1], arg_83_0)
	ui.set_visible(var_0_39.antiaim.pitch[2], arg_83_0)
	ui.set_visible(var_0_39.antiaim.yawbase, arg_83_0)
	ui.set_visible(var_0_39.antiaim.yaw[1], arg_83_0)
	ui.set_visible(var_0_39.antiaim.yaw[2], arg_83_0)
	ui.set_visible(var_0_39.antiaim.yaw_jitter[1], arg_83_0)
	ui.set_visible(var_0_39.antiaim.roll, arg_83_0)
	ui.set_visible(var_0_39.antiaim.yaw_jitter[2], arg_83_0)
	ui.set_visible(var_0_39.antiaim.body_yaw[1], arg_83_0)
	ui.set_visible(var_0_39.antiaim.body_yaw[2], arg_83_0)
	ui.set_visible(var_0_39.antiaim.fsbodyyaw, arg_83_0)
	ui.set_visible(var_0_39.antiaim.edgeyaw, arg_83_0)
	ui.set_visible(var_0_39.antiaim.freestand[1], arg_83_0)
	ui.set_visible(var_0_39.antiaim.freestand[2], arg_83_0)
	ui.set_visible(var_0_39.other.enabled_slw[1], arg_83_0)
	ui.set_visible(var_0_39.other.enabled_slw[2], arg_83_0)
	ui.set_visible(var_0_39.other.osaa[1], arg_83_0)
	ui.set_visible(var_0_39.other.osaa[2], arg_83_0)
	ui.set_visible(var_0_39.other.leg_movement, arg_83_0)
	ui.set_visible(var_0_39.other.fakepeek[1], arg_83_0)
	ui.set_visible(var_0_39.other.fakepeek[2], arg_83_0)
	ui.set_visible(var_0_39.fakelag.enabled[1], arg_83_0)
	ui.set_visible(var_0_39.fakelag.enabled[2], arg_83_0)
	ui.set_visible(var_0_39.fakelag.amount, arg_83_0)
	ui.set_visible(var_0_39.fakelag.variance, arg_83_0)
	ui.set_visible(var_0_39.fakelag.limit, arg_83_0)
end

local function var_0_81()
	vencolabelaa:set(var_0_36(var_0_28.basecolor, "               ⌖ Krim ⌖"))
	vencolabelfl:set(var_0_36(var_0_28.basecolor, "               ⌖ Krim ⌖"))
	vencolabeloth:set(var_0_36(var_0_28.basecolor, "               ⌖ Krim ⌖"))
end

local function var_0_82()
	return
end

function renderer.rounded_rectangle(arg_86_0, arg_86_1, arg_86_2, arg_86_3, arg_86_4, arg_86_5, arg_86_6, arg_86_7, arg_86_8)
	arg_86_1 = arg_86_1 + arg_86_8

	local var_86_0 = {
		{
			arg_86_0 + arg_86_8,
			arg_86_1,
			180
		},
		{
			arg_86_0 + arg_86_2 - arg_86_8,
			arg_86_1,
			90
		},
		{
			arg_86_0 + arg_86_8,
			arg_86_1 + arg_86_3 - arg_86_8 * 2,
			270
		},
		{
			arg_86_0 + arg_86_2 - arg_86_8,
			arg_86_1 + arg_86_3 - arg_86_8 * 2,
			0
		}
	}
	local var_86_1 = {
		{
			arg_86_0 + arg_86_8,
			arg_86_1,
			arg_86_2 - arg_86_8 * 2,
			arg_86_3 - arg_86_8 * 2
		},
		{
			arg_86_0 + arg_86_8,
			arg_86_1 - arg_86_8,
			arg_86_2 - arg_86_8 * 2,
			arg_86_8
		},
		{
			arg_86_0 + arg_86_8,
			arg_86_1 + arg_86_3 - arg_86_8 * 2,
			arg_86_2 - arg_86_8 * 2,
			arg_86_8
		},
		{
			arg_86_0,
			arg_86_1,
			arg_86_8,
			arg_86_3 - arg_86_8 * 2
		},
		{
			arg_86_0 + arg_86_2 - arg_86_8,
			arg_86_1,
			arg_86_8,
			arg_86_3 - arg_86_8 * 2
		}
	}

	for iter_86_0, iter_86_1 in next, var_86_0 do
		renderer.circle(iter_86_1[1], iter_86_1[2], arg_86_4, arg_86_5, arg_86_6, arg_86_7, arg_86_8, iter_86_1[3], 0.25)
	end

	for iter_86_2, iter_86_3 in next, var_86_1 do
		renderer.rectangle(iter_86_3[1], iter_86_3[2], iter_86_3[3], iter_86_3[4], arg_86_4, arg_86_5, arg_86_6, arg_86_7)
	end
end

function renderer.rounded_outline(arg_87_0, arg_87_1, arg_87_2, arg_87_3, arg_87_4, arg_87_5, arg_87_6, arg_87_7, arg_87_8, arg_87_9)
	renderer.rectangle(arg_87_0 + arg_87_9, arg_87_1, arg_87_2 - arg_87_9 * 2, arg_87_8, arg_87_4, arg_87_5, arg_87_6, arg_87_7)
	renderer.rectangle(arg_87_0 + arg_87_2 - arg_87_8, arg_87_1 + arg_87_9, arg_87_8, arg_87_3 - arg_87_9 * 2, arg_87_4, arg_87_5, arg_87_6, arg_87_7)
	renderer.rectangle(arg_87_0, arg_87_1 + arg_87_9, arg_87_8, arg_87_3 - arg_87_9 * 2, arg_87_4, arg_87_5, arg_87_6, arg_87_7)
	renderer.rectangle(arg_87_0 + arg_87_9, arg_87_1 + arg_87_3 - arg_87_8, arg_87_2 - arg_87_9 * 2, arg_87_8, arg_87_4, arg_87_5, arg_87_6, arg_87_7)
	renderer.circle_outline(arg_87_0 + arg_87_9, arg_87_1 + arg_87_9, arg_87_4, arg_87_5, arg_87_6, arg_87_7, arg_87_9, 180, 0.25, arg_87_8)
	renderer.circle_outline(arg_87_0 - arg_87_9 + arg_87_2, arg_87_1 + arg_87_9, arg_87_4, arg_87_5, arg_87_6, arg_87_7, arg_87_9, 270, 0.25, arg_87_8)
	renderer.circle_outline(arg_87_0 + arg_87_9, arg_87_1 - arg_87_9 + arg_87_3, arg_87_4, arg_87_5, arg_87_6, arg_87_7, arg_87_9, 90, 0.25, arg_87_8)
	renderer.circle_outline(arg_87_0 - arg_87_9 + arg_87_2, arg_87_1 - arg_87_9 + arg_87_3, arg_87_4, arg_87_5, arg_87_6, arg_87_7, arg_87_9, 0, 0.25, arg_87_8)
end

;({})[var_0_6("\x18{\xC6\xC3", "\xB3t\x1E\xB4")] = function(arg_88_0, arg_88_1, arg_88_2, arg_88_3, arg_88_4)
	local var_88_0 = 0
	local var_88_1
	local var_88_2
	local var_88_3

	while true do
		if var_88_0 == 0 then
			var_88_1 = 80
			var_88_2 = 1 / globals.frametime()
			var_88_0 = 1
		end

		if var_88_0 == 2 then
			return math.floor(arg_88_1)
		end

		if var_88_0 == 1 then
			local var_88_4 = var_88_1 / var_88_2

			if arg_88_0 then
				if arg_88_2 == 255 then
					if arg_88_1 > 235 then
						arg_88_1 = 255
					else
						local var_88_5 = 0

						while true do
							if var_88_5 == 0 then
								if arg_88_1 < arg_88_2 then
									arg_88_1 = arg_88_1 + globals.frametime() * arg_88_3 * 1.5 * 64
								end

								if arg_88_2 < arg_88_1 then
									arg_88_1 = arg_88_1 - globals.frametime() * arg_88_3 * 1.5 * 64
								end

								break
							end
						end
					end
				elseif math.floor(arg_88_1 / 10) == math.floor(arg_88_2 / 10) then
					arg_88_1 = arg_88_2
				else
					local var_88_6 = 0

					while true do
						if var_88_6 == 0 then
							if arg_88_1 < arg_88_2 then
								arg_88_1 = arg_88_1 + globals.frametime() * arg_88_3 * 2 * 64
							end

							if arg_88_2 < arg_88_1 then
								arg_88_1 = arg_88_1 - globals.frametime() * arg_88_3 * 2 * 64
							end

							break
						end
					end
				end
			else
				local var_88_7 = 0

				while true do
					if var_88_7 == 0 then
						if math.floor(arg_88_1) <= math.floor(arg_88_4) then
							arg_88_1 = arg_88_4
						end

						if arg_88_4 < math.floor(arg_88_1) then
							arg_88_1 = arg_88_1 - arg_88_3 * var_88_4
						end

						break
					end
				end
			end

			var_88_0 = 2
		end
	end
end

local var_0_83 = {
	[var_0_6("\xE2\xC8\xF9\x84\xF9\xD6", "ዦ\x8D")] = function(arg_89_0, arg_89_1, arg_89_2)
		return arg_89_0 + (arg_89_1 - arg_89_0) * arg_89_2
	end
}
local var_0_84 = {
	[var_0_6("^\x84\xF85^", "@-\xEB\x94")] = function(arg_90_0, arg_90_1, arg_90_2, arg_90_3, arg_90_4, arg_90_5, arg_90_6)
		if arg_90_0 == 1 then
			local var_90_0 = 0

			while true do
				if var_90_0 == 0 then
					renderer.rectangle(arg_90_1, arg_90_2 + 2, arg_90_3, arg_90_4, 0, 0, 0, arg_90_5[4] * arg_90_6 / 255)
					renderer.rectangle(arg_90_1, arg_90_2, arg_90_3, 2, arg_90_5[1], arg_90_5[2], arg_90_5[3], arg_90_6)

					break
				end
			end
		elseif arg_90_0 == 2 then
			local var_90_1 = 3

			renderer.rounded_rectangle(arg_90_1 + 1 + 0, arg_90_2 + 1, arg_90_3 - 1, arg_90_4 - 1, 0, 0, 0, arg_90_5[4] * arg_90_6 / 255, var_90_1)
			renderer.rectangle(arg_90_1 + var_90_1, arg_90_2, arg_90_3 - var_90_1 * 2, 1, arg_90_5[1], arg_90_5[2], arg_90_5[3], arg_90_6)
			renderer.circle_outline(arg_90_1 + var_90_1, arg_90_2 + var_90_1, arg_90_5[1], arg_90_5[2], arg_90_5[3], arg_90_6, var_90_1, 180, 0.25, 1)
			renderer.circle_outline(arg_90_1 - var_90_1 + arg_90_3, arg_90_2 + var_90_1, arg_90_5[1], arg_90_5[2], arg_90_5[3], arg_90_6, var_90_1, 270, 0.25, 1)
			renderer.gradient(arg_90_1, arg_90_2 + var_90_1, 1, arg_90_4 - var_90_1, arg_90_5[1], arg_90_5[2], arg_90_5[3], arg_90_6, arg_90_5[1], arg_90_5[2], arg_90_5[3], 0, false)
			renderer.gradient(arg_90_1 + arg_90_3 - 1, arg_90_2 + var_90_1, 1, arg_90_4 - var_90_1, arg_90_5[1], arg_90_5[2], arg_90_5[3], arg_90_6, arg_90_5[1], arg_90_5[2], arg_90_5[3], 0, false)
			renderer.rounded_outline(arg_90_1 + 1 + 0, arg_90_2 + 1 + 0, arg_90_3 - 2, arg_90_4 - 1, arg_90_5[1], arg_90_5[2], arg_90_5[3], arg_90_5[4] * arg_90_6 / 65025 * 25, 1, var_90_1)
			renderer.rounded_outline(arg_90_1, arg_90_2, arg_90_3, arg_90_4, arg_90_5[1], arg_90_5[2], arg_90_5[3], arg_90_5[4] * arg_90_6 / 65025 * 100, 1, var_90_1)
		end
	end,
	[var_0_6("{T;\xF1I\xC7sn.\xE7D\xC1", "\xB5\x161Z\x82<")] = function(arg_91_0, arg_91_1)
		return renderer.measure_text(arg_91_0, arg_91_1)
	end
}
local var_0_85 = {
	[var_0_6("\tù\x04\nù\x1D\n", "io\xB1\xD8")] = 0,
	[var_0_6("\xB8\x1B\xDB\x06/զ\x1B\xC5\x17\x02Ҡ\x1F", "\xB3\xD4z\xA8rp")] = 0,
	[var_0_6("xt\x8D\xC0xn\x8D\xC2wi", "\xAD\x19\x1A\xE4")] = (function()
		return {
			[var_0_6("\x12wݻ", "xv\x16\xA9\xDA")] = {},
			clamp = function(arg_93_0, arg_93_1, arg_93_2, arg_93_3)
				return math.min(arg_93_3, math.max(arg_93_2, arg_93_1))
			end,
			animate = function(arg_94_0, arg_94_1, arg_94_2, arg_94_3)
				local var_94_0 = 0
				local var_94_1

				while true do
					if var_94_0 == 2 then
						return arg_94_0.data[arg_94_1]
					end

					if var_94_0 == 1 then
						local var_94_2 = globals.frametime() * arg_94_3 * (arg_94_2 and -1 or 1)

						arg_94_0.data[arg_94_1] = arg_94_0:clamp(arg_94_0.data[arg_94_1] + var_94_2, 0, 1)
						var_94_0 = 2
					end

					if var_94_0 == 0 then
						if not arg_94_0.data[arg_94_1] then
							arg_94_0.data[arg_94_1] = 0
						end

						arg_94_3 = arg_94_3 or 4
						var_94_0 = 1
					end
				end
			end
		}
	end)(),
	[var_0_6("\xD5'\xB4\xE7\xF84\xB9\xD9\xCF%\xAE", "\x86\xA7@\xD6")] = function(arg_95_0, arg_95_1, arg_95_2, arg_95_3, arg_95_4)
		return string.format(var_0_6("A٬\x90\x8C\x98V\x91\xBB؛\xD0A٬\x90", "\xA8d\xE9\x9E\xE8\xA9"), arg_95_1, arg_95_2, arg_95_3, arg_95_4)
	end,
	[var_0_6("tU\x1D\xF9M\\\x18\xF2vX\x1C", "\x9C\x124y")] = function(arg_96_0, arg_96_1, arg_96_2, arg_96_3, arg_96_4, arg_96_5, arg_96_6)
		local var_96_0, var_96_1, var_96_2, var_96_3 = vis_watermark_color2:get()
		local var_96_4 = {}
		local var_96_5 = 1
		local var_96_6 = arg_96_2:len() - 1
		local var_96_7 = var_96_0 - arg_96_3
		local var_96_8 = var_96_1 - arg_96_4
		local var_96_9 = var_96_2 - arg_96_5

		for iter_96_0 = 1, #arg_96_2 do
			local var_96_10 = 0
			local var_96_11

			while true do
				if var_96_10 == 0 then
					local var_96_12 = (iter_96_0 - 1) / (#arg_96_2 - 1) + arg_96_1

					var_96_4[var_96_5] = "\a" .. arg_96_0:rgba_to_hex(arg_96_3 + var_96_7 * math.abs(math.cos(var_96_12)), arg_96_4 + var_96_8 * math.abs(math.cos(var_96_12)), arg_96_5 + var_96_9 * math.abs(math.cos(var_96_12)), arg_96_6)
					var_96_10 = 1
				end

				if var_96_10 == 1 then
					var_96_4[var_96_5 + 1] = arg_96_2:sub(iter_96_0, iter_96_0)
					var_96_5 = var_96_5 + 2

					break
				end
			end
		end

		return var_96_4
	end
}

local function var_0_86()
	if not entity.get_local_player() then
		return
	end

	local var_97_0, var_97_1 = client.screen_size()
	local var_97_2, var_97_3, var_97_4, var_97_5 = vis_watermark_color:get()
	local var_97_6, var_97_7, var_97_8, var_97_9 = vis_watermark_color_mode_2:get()
	local var_97_10 = var_0_85.animations:animate(var_0_6("B\x1C\xCB\xC2\x85\xE0", "\xBF#p\xBB\xAA\xE4\xD5e"), not vis_watermark:get(), 6)
	local var_97_11 = var_0_85.animations:animate(var_0_6("\xB9\xA3l]?M*", "\x1F\xD8\xCF\x1C5^|"), vis_watermark_position:get() ~= var_0_6("\r\"\xAD\x1B", ";AG\xCBo"), 6)
	local var_97_12 = var_0_85.animations:animate(var_0_6("\x16\xACl|\x8AZa", "Tw\xC0\x1C\x14\xEBl"), vis_watermark_position:get() ~= var_0_6("\xBE\xF7#\xFE\x0E", "!\xEC\x9ED\x96z\\\xC9"), 6)
	local var_97_13 = var_0_85.animations:animate(var_0_6("\xF7\xD9\xED\x1C[\xFC8\xF2\xD3\xC6\x14F\xF5<߉", "Y\x80\xB8\x99y)\x91"), vis_watermark_mode:get() ~= var_0_6("\xAFd", "[\x8CU\xC4\xE1B\xE7`"), 6)
	local var_97_14 = var_0_85.animations:animate(var_0_6("$\xB9\xA3\xB4Y>\xB9\xA5\xBAt>\xB7\xB3\xB4ta", "+S\xD8\xD7\xD1"), vis_watermark_mode:get() ~= var_0_6("\b\xF5", "N+\xC7\xD0k"), 6)
	local var_97_15 = ""
	local var_97_16 = var_0_85:fade_handle(globals.curtime() * 1.2, var_0_6("Y\xC82^\x92z\xE8\x96I\xAA%*\x9A\a", "\xB6\x12\xE8`~\xDBZ\xA5"), var_97_2, var_97_3, var_97_4, var_97_5 * var_97_10 * var_97_11 * var_97_13)
	local var_97_17 = var_0_85:fade_handle(-globals.curtime() * 1.2, var_0_6("\x16\x1E\x15\xE8\x14\x1E\n\xE8\x06|\x02\x9C\x1Cc", "\xC8]>G"), var_97_2, var_97_3, var_97_4, var_97_5 * var_97_10 * var_97_12 * var_97_13)
	local var_97_18 = "\a" .. var_0_85:rgba_to_hex(var_97_6, var_97_7, var_97_8, var_97_9 * var_97_10 * var_97_14) .. var_0_6("m_G\xD7\xFF\x90+rls\x9A\xDA", "n&-.\xBA\xA4\xD2") .. "\a" .. var_0_85:rgba_to_hex(200, 200, 200, 255 * var_97_10 * var_97_14)

	if vis_watermark_items:get(var_0_6("M\xAD\xAD\x040y\xB3\xAD", "^\x18\xDE\xC8v")) then
		var_97_18 = var_97_18 .. var_0_6("]\xDCf", "y}\xA0F") .. var_0_28.username()
	end

	if vis_watermark_items:get(var_0_6("\xDF\xEB/\xB7\xFD\xE9\"", "ғ\x8A[")) then
		var_97_18 = var_97_18 .. var_0_6("u\xE1\x88", "sU\x9D\xA8+P") .. string.format(var_0_6("\xBA^\x8AD", "\xA9\x9F:\xE77\xEC\xA9&"), client.real_latency() * 1000)
	end

	if vis_watermark_items:get(var_0_6("7Ӿ\x1D\xC1\x06}\x05\xC4", "\x1Cq\xA1\xDFp\xA4t")) then
		local var_97_19 = 0

		while true do
			if var_97_19 == 0 then
				var_0_85.framerate = 0.9 * var_0_85.framerate + 0.09999999999999998 * globals.absoluteframetime()
				var_0_85.last_framerate = var_0_85.framerate > 0 and var_0_85.framerate or 1
				var_97_19 = 1
			end

			if var_97_19 == 1 then
				var_97_18 = var_97_18 .. var_0_6("\x86D\a", ";\xA68'\x19") .. string.format(var_0_6("\xF7܆\xEEs\x81", "#Ҹ\xA6\xA8"), 1 / var_0_85.last_framerate)

				break
			end
		end
	end

	if vis_watermark_items:get(var_0_6("mPpG", "\x1799\x1D\"D")) then
		var_97_18 = var_97_18 .. var_0_6("\x10-_", "L0Q\x7F") .. string.format(var_0_6("K\xF5\x03\xB3P1\x8D\x02\n", "0n\xC51\xD7j\x14\xBD"), client.system_time())
	end

	local var_97_20 = renderer.measure_text(nil, var_97_18)
	local var_97_21 = 12
	local var_97_22 = var_97_20 + var_97_21 * 2
	local var_97_23 = var_97_0 - var_97_22 - 20
	local var_97_24 = 15

	renderer.rectangle(var_97_23, var_97_24, var_97_22, 30, 15, 15, 15, 160 * var_97_10 * var_97_14)
	renderer.text(var_97_23 + var_97_21, var_97_24 + 8, 255, 255, 255, 255 * var_97_10 * var_97_14, nil, nil, var_97_18)
	renderer.text(var_97_0 / 21 - 80, var_97_1 / 2, 255, 255, 255, 255 * var_97_10 * var_97_11 * var_97_13, nil, nil, unpack(var_97_16))
	renderer.text(var_97_0 - 135, var_97_1 / 2, 255, 255, 255, 255 * var_97_10 * var_97_12 * var_97_13, nil, nil, unpack(var_97_17))
	renderer.rectangle(var_97_23 + var_97_21, var_97_24 + 8, 0, 0, 0, 100 * var_97_10 * var_97_14, nil, nil, var_97_18)
end

local function var_0_87(arg_98_0)
	if not vis_dmg_indicator_enable:get() then
		return
	end

	local var_98_0 = entity.get_local_player()

	if not entity.is_alive(var_98_0) then
		return
	end

	local var_98_1, var_98_2 = client.screen_size()
	local var_98_3

	if ui.get(var_0_39.rage.dmg_override[2]) then
		var_98_3 = ui.get(var_0_39.rage.dmg_override[3])
	else
		var_98_3 = ui.get(var_0_39.rage.dmg)
	end

	local var_98_4, var_98_5, var_98_6 = dmg_indicator_color:get()

	renderer.indicator(var_98_4, var_98_5, var_98_6, 255, var_98_3)
	renderer.text(var_98_1 * 0.507, var_98_2 * 0.48, var_98_4, var_98_5, var_98_6, 255, var_0_6("\x13\x1BD", "l}r(̠K&"), 0, var_98_3)
end

local function var_0_88()
	local var_99_0 = vis_desync_arrows_style:get()

	if var_99_0 == var_0_6("\x11y\xEC\f7|\xFA\t", "mU\x10\x9F") then
		return
	end

	local var_99_1 = entity.get_local_player()

	if not var_99_1 then
		return
	end

	local var_99_2 = var_0_7(client.screen_size())
	local var_99_3, var_99_4, var_99_5, var_99_6 = vis_desync_arrows_color:get()
	local var_99_7 = vis_desync_arrows_distance:get()
	local var_99_8 = entity.get_prop(var_99_1, var_0_6("*̫W+W\xA3\"ìI\x1AU\xB53\xF6\xBF", "\xD0G\x93\xCD;{8"), 11) * 120 - 60 > 0 and 1 or -1

	if var_99_0 == var_0_6("s%\x82\xB9B,\x90", "\xD87@\xE4") then
		if var_99_8 == 1 then
			renderer.text(var_99_2.x / 2 + var_99_7, var_99_2.y / 2, var_99_3, var_99_4, var_99_5, var_99_6, var_0_6("\xBC\x8C<", "\x8B\xDF\xE8^\xA2ٕ"), 0, "→")
		else
			renderer.text(var_99_2.x / 2 - var_99_7, var_99_2.y / 2, var_99_3, var_99_4, var_99_5, var_99_6, var_0_6("և!", "\xAA\xB5\xE3C\x91\xDB5"), 0, "←")
		end
	elseif var_99_0 == var_0_6("u\x8A\x12\xF2R\x80\x15\xF2\v\xD5O\xEA", "\xD29\xE5~") then
		if var_99_8 == 1 then
			renderer.text(var_99_2.x / 2 + var_99_7, var_99_2.y / 2, var_99_3, var_99_4, var_99_5, var_99_6, var_0_6("\xBB7\xE8", "\xE3\xD8S\x8A\xC6R\xA5"), 0, var_0_6("\x19\x9C\x91P\xC6", "\x92K\xD5\xD6\x18"))
		else
			renderer.text(var_99_2.x / 2 - var_99_7, var_99_2.y / 2, var_99_3, var_99_4, var_99_5, var_99_6, var_0_6("Iz\xC3", "5*\x1E\xA1$\x1A%"), 0, var_0_6("\xD1\xDC\xD1\xD4", "\x80\x9D\x99\x97"))
		end
	end
end

local var_0_89 = 0

local function var_0_90()
	local var_100_0 = 0
	local var_100_1
	local var_100_2
	local var_100_3
	local var_100_4
	local var_100_5
	local var_100_6
	local var_100_7
	local var_100_8
	local var_100_9
	local var_100_10
	local var_100_11
	local var_100_12
	local var_100_13

	while true do
		if var_100_0 == 4 then
			if custom_scope_mode:get() ~= "T" then
				renderer.gradient(var_100_2 / 2, var_100_3 / 2 - var_100_5 + 2, 1, var_100_5 - var_100_4, var_100_11[1], var_100_11[2], var_100_11[3], var_100_11[4], var_100_12[1], var_100_12[2], var_100_12[3], var_100_12[4], false)
			end

			renderer.gradient(var_100_2 / 2, var_100_3 / 2 + var_100_4, 1, var_100_5 - var_100_4, var_100_12[1], var_100_12[2], var_100_12[3], var_100_12[4], var_100_11[1], var_100_11[2], var_100_11[3], var_100_11[4], false)

			var_100_0 = 5
		end

		if var_100_0 == 5 then
			renderer.gradient(var_100_2 / 2 - var_100_5 + 2, var_100_3 / 2, var_100_5 - var_100_4, 1, var_100_11[1], var_100_11[2], var_100_11[3], var_100_11[4], var_100_12[1], var_100_12[2], var_100_12[3], var_100_12[4], true)
			renderer.gradient(var_100_2 / 2 + var_100_4, var_100_3 / 2, var_100_5 - var_100_4, 1, var_100_12[1], var_100_12[2], var_100_12[3], var_100_12[4], var_100_11[1], var_100_11[2], var_100_11[3], var_100_11[4], true)

			break
		end

		if var_100_0 == 1 then
			if var_100_1 == nil then
				return
			end

			var_100_2, var_100_3 = client.screen_size()
			var_100_4, var_100_5 = custom_scope_offset:get() * var_100_3 / 1080, custom_scope_position:get() * var_100_3 / 1080
			var_100_0 = 2
		end

		if var_100_0 == 2 then
			local var_100_14 = entity.get_prop(var_100_1, var_0_6("{J\x8E\x00\x06@uz\x9C,\x11", "\x13\x16\x15\xECIu")) == 1 and entity.get_prop(var_100_1, var_0_6("z\xFA\xA0\x9B\xF2\xAE8\xFBr\xFF\xAD\xA6\xFA", "\x96\x17\xA5\xC2ɗ\xDDM")) == 0

			var_0_89 = var_0_83.interp(var_0_89, var_100_14 and 1 or 0, 0.045)

			if var_0_89 < 0.001 then
				return
			end

			var_100_0 = 3
		end

		if var_100_0 == 3 then
			local var_100_15, var_100_16, var_100_17, var_100_18 = custom_scope_color:get()

			var_100_11 = {
				var_100_15,
				var_100_16,
				var_100_17,
				0
			}
			var_100_12 = {
				var_100_15,
				var_100_16,
				var_100_17,
				var_100_18 * var_0_89
			}
			var_100_0 = 4
		end

		if var_100_0 == 0 then
			if not custom_scope_enabled:get() then
				return
			end

			ui.set(var_0_39.visuals.scope_overlay, false)

			var_100_1 = entity.get_local_player()
			var_100_0 = 1
		end
	end
end

local var_0_91 = {
	[var_0_6("j4\xFC\x1Br\x04\xFB\x12q/\xFB", "z\x1E[\x88")] = 0,
	[var_0_6("\xAB\xAB񱁀\xAC줞", "\xED\xDFą\xD0")] = 0,
	[var_0_6("\xD4\x01׬_\xEE\xD97ӻL\xF9\xD9\x06׿Y\xFF", "\x9A\xBCh\xA3\xDE>")] = 0,
	[var_0_6("9\xEC>\xEF/]\xC7&\xE89\xC4\x04F\xCF0", "\xA2U\x8DM\x9Bp/")] = 0,
	[var_0_6("\x00,\xB5K\x06\x16\xAF@\x06,\xB4X\x13%", ".rI\xC6")] = 300000
}

;({})[var_0_6("\xACpb\xEA<Z", "*\xC5\x1E\x16\x8FN")] = function(arg_101_0, arg_101_1, arg_101_2)
	local var_101_0 = 0
	local var_101_1
	local var_101_2

	while true do
		if var_101_0 == 0 then
			if arg_101_0 == arg_101_1 then
				return arg_101_1
			end

			var_101_1 = arg_101_1 - arg_101_0
			var_101_0 = 1
		end

		if var_101_0 == 1 then
			var_101_2 = var_101_1 * arg_101_2

			if math.abs(var_101_1) < 0.01 then
				return arg_101_1
			end

			var_101_0 = 2
		end

		if var_101_0 == 2 then
			return arg_101_0 + var_101_2
		end
	end
end

local var_0_92 = {
	[var_0_6("gJK>\x7F", "_\x13%?")] = 0,
	[var_0_6("y%\xB3\xEF", "g\x11Lǜ\x11")] = 0
}
local var_0_93 = {
	[var_0_6("\xBA9\xBA\xE9_\x04\xB0\xEC\xB6", "\x9A\xD3J\xE5\x88<p\xD9")] = false,
	[var_0_6("\xAA\x12\xEB\xCF\tB\xAB", "'\xCF|\x8A\xADe")] = true
}

local function var_0_94(arg_102_0)
	local var_102_0 = 0
	local var_102_1
	local var_102_2
	local var_102_3
	local var_102_4

	while true do
		local var_102_5 = 0

		while true do
			if var_102_5 == 0 then
				if var_102_0 == 2 then
					local var_102_6 = var_0_7(entity.get_prop(arg_102_0, var_0_6("/\xE8\x1FV'\xD5x.\xD8\nZ0\xFA", "\x1DB\xB7i3D\x83")))

					var_102_4 = math.sqrt(var_102_6.x^2 + var_102_6.y^2)
					var_102_0 = 3
				end

				if var_102_0 == 1 then
					if var_102_2 then
						local var_102_7 = 0
						local var_102_8
						local var_102_9

						while true do
							if var_102_7 == 1 then
								var_102_9 = entity.get_classname(var_102_8)

								if var_102_9 == var_0_6("\xDC\v3\v\xF9%", "b\x9F@]") then
									return var_0_6("/\xB8?_:\bR\"\v", "Dn\xD1M\x7Fqf;")
								end

								var_102_7 = 2
							end

							if var_102_7 == 2 then
								if var_102_9 == var_0_6("\x8DӢN\x13̠\x9A\xE5\xB4J\x11", "\xCE΄\xC7/c\xA3") then
									return var_0_6("\xD7\xCB\xC52k\xF3\xD7\xC4", "1\x96\xA2\xB7\x12")
								end

								if entity.get_prop(arg_102_0, var_0_6("D\x15\xBD->\xF5\x1BB\v\xB6.\x0F\xEE\f", "x)J\xDBAz\x80")) == 1 then
									return var_0_6("y\x14S\x0F\xE6\xAF\xD0^F}\x13\xF7", "\xB5:f<z\x85\xC7")
								end

								var_102_7 = 3
							end

							if var_102_7 == 3 then
								return nil
							end

							if var_102_7 == 0 then
								var_102_8 = entity.get_player_weapon(arg_102_0)

								if var_102_8 == nil then
									return
								end

								var_102_7 = 1
							end
						end
					end

					if entity.get_prop(arg_102_0, var_0_6("^\xDD\xDA\x15^F\xE1\xD78w\\\xF7\xD2\r", "\x1A3\x82\xBCy")) > 0.1 then
						return var_0_6("ː#\fJ\x16\xF2]", "9\x88\xE2Ly)~\x97")
					end

					var_102_0 = 2
				end

				var_102_5 = 1
			end

			if var_102_5 == 1 then
				if var_102_0 == 0 then
					local var_102_10 = entity.get_prop(arg_102_0, var_0_6("\xC3>E\xE6\xAE\xCF\x06P", "®a#\xA0"))

					var_102_2 = bit.band(var_102_10, 1) == 0
					var_102_0 = 1
				end

				if var_102_0 == 3 then
					if var_102_4 < 8 then
						return var_0_6("v1H\xC0A,G\xC9", "\xAE%E)")
					end

					return nil
				end

				break
			end
		end
	end
end

local function var_0_95(arg_103_0, arg_103_1)
	local var_103_0 = globals.tickinterval()
	local var_103_1 = var_0_7(entity.get_prop(arg_103_0, var_0_6("\x8C\x89X\v\x13\xB7\xB3B\x01\x13\x88\xA2W", "p\xE1\xD6.n")))
	local var_103_2 = arg_103_1:clone()
	local var_103_3 = 25

	if var_103_1:length() < 32 then
		var_103_3 = 40
	end

	var_103_2.x = var_103_2.x + var_103_1.x * var_103_0 * var_103_3
	var_103_2.y = var_103_2.y + var_103_1.y * var_103_0 * var_103_3

	if entity.get_prop(arg_103_0, var_0_6("\x13\x1B+|\xF6\xB2\xF9\x10 \x06U\xF0\xB4\xF8\a", "\x8C~DC;\x84\xDD")) == nil then
		local var_103_4 = 0
		local var_103_5

		while true do
			if var_103_4 == 0 then
				local var_103_6 = cvar.sv_gravity:get_float()

				var_103_2.z = var_103_2.z + var_103_1.z * var_103_0 * var_103_3 - var_103_6 * var_103_0 * var_103_0

				break
			end
		end
	end

	return var_103_2
end

function var_0_93.update(arg_104_0, arg_104_1)
	var_0_93.is_active = false

	if not safe_head_enabled:get() then
		return
	end

	local var_104_0 = entity.get_local_player()

	if var_104_0 == nil then
		return
	end

	local var_104_1 = entity.get_prop(var_104_0, var_0_6("\x8FN\x0E\x7FH\x1E\x8B\xACd\n", "\xE6\xE2\x11g+-\x7F"))

	if var_104_1 == nil then
		return
	end

	if entity.get_player_weapon(var_104_0) == nil then
		return
	end

	local var_104_2 = client.current_threat()

	if var_104_2 == nil then
		return
	end

	local var_104_3 = var_0_94(var_104_0)

	if var_104_3 == nil then
		return
	end

	if not safe_head_states:get(var_104_3) then
		return
	end

	local var_104_4 = false

	if var_104_3 == var_0_6("\xF1E\xD6\v\xBD\xD5Y\xD7", "\xE7\xB0,\xA4+") or var_104_3 == var_0_6("\x80\xCF6酂\xA8\xC0!", "\xEC\xC1\xA6D\xC9\xCE") then
		var_104_4 = true
	else
		local var_104_5 = 0
		local var_104_6
		local var_104_7

		while true do
			if var_104_5 == 1 then
				var_104_6.z = var_104_6.z + 2 + 3

				if var_104_7.z > var_104_6.z then
					var_104_4 = true
				end

				break
			end

			if var_104_5 == 0 then
				var_104_6 = var_0_95(var_104_2, var_0_7(entity.hitbox_position(var_104_2, 0)))
				var_104_7 = var_0_7(entity.hitbox_position(var_104_0, 0))
				var_104_5 = 1
			end
		end
	end

	if not var_104_4 then
		return
	end

	local var_104_8 = ({
		[var_0_6("7/\xC9\x7F\x002\xC6v", "\x11d[\xA8")] = {
			[2] = function(arg_105_0, arg_105_1, arg_105_2)
				local var_105_0 = 0

				while true do
					if var_105_0 == 1 then
						arg_105_1.body_yaw_offset = 0

						break
					end

					if var_105_0 == 0 then
						arg_105_1.yaw_offset = -6
						arg_105_1.body_yaw = var_0_6("i\xB2\x8D\xF8\xBA ", "\x1B:\xC6\xEC\x8C\xD3C")
						var_105_0 = 1
					end
				end
			end,
			[3] = function(arg_106_0, arg_106_1, arg_106_2)
				local var_106_0 = 0

				while true do
					if var_106_0 == 1 then
						arg_106_1.body_yaw_offset = 0

						break
					end

					if var_106_0 == 0 then
						arg_106_1.yaw_offset = 8
						arg_106_1.body_yaw = var_0_6("\x12\xD9\xCD^\x80\xE8", "\x8BA\xAD\xAC*\xE9")
						var_106_0 = 1
					end
				end
			end
		},
		[var_0_6("\xA4D~\xCD\xC7\x7F\xE5L", "(\xE76\x11\xB8\xA4\x17\x80")] = {
			[2] = function(arg_107_0, arg_107_1, arg_107_2)
				local var_107_0 = 0

				while true do
					if var_107_0 == 1 then
						arg_107_1.body_yaw_offset = 0

						break
					end

					if var_107_0 == 0 then
						arg_107_1.yaw_offset = 0
						arg_107_1.body_yaw = var_0_6("\xB7\xDD~\xEC\x8C\xE9", "\x8A\xE4\xA9\x1F\x98\xE5")
						var_107_0 = 1
					end
				end
			end,
			[3] = function(arg_108_0, arg_108_1, arg_108_2)
				arg_108_1.yaw_offset = 40
				arg_108_1.body_yaw = var_0_6("\xFF\x18C!\xE9\xC0", "\xA3\xACl\"U\x80")
				arg_108_1.body_yaw_offset = 180
			end
		},
		[var_0_6("\x04\x03\xF8\x92\xD8L\x8DPg0\xFE\x95", "4Gq\x97\xE7\xBB$\xE8")] = {
			[2] = function(arg_109_0, arg_109_1, arg_109_2)
				arg_109_1.yaw_offset = 0
				arg_109_1.body_yaw = var_0_6("E\x99y\xB9\x7F\x8E", "\xCD\x16\xED\x18")
				arg_109_1.body_yaw_offset = -120
			end,
			[3] = function(arg_110_0, arg_110_1, arg_110_2)
				local var_110_0 = 0

				while true do
					if var_110_0 == 0 then
						arg_110_1.yaw_offset = 0
						arg_110_1.body_yaw = var_0_6("\x8Dlr\xDC0\xBD", "Y\xDE\x18\x13\xA8")
						var_110_0 = 1
					end

					if var_110_0 == 1 then
						arg_110_1.body_yaw_offset = 120

						break
					end
				end
			end
		},
		[var_0_6("\xD4PA\xF7:\xFBPU\xB2", "q\x9593\xD7")] = {
			[2] = function(arg_111_0, arg_111_1, arg_111_2)
				arg_111_1.yaw_offset = 45
				arg_111_1.body_yaw = var_0_6("Jdʢ\xEB\xC3", "\xA0\x19\x10\xABւ")
				arg_111_1.body_yaw_offset = 180
			end,
			[3] = function(arg_112_0, arg_112_1, arg_112_2)
				arg_112_1.yaw_offset = 35
				arg_112_1.body_yaw = var_0_6("B\xCC6it\xD1", "\xEB\x11\xB8W\x1D\x1D\xB2")
				arg_112_1.body_yaw_offset = 180
			end
		},
		[var_0_6("\x8B\xA0k\xB8ʯ\xBCj", "\x90\xCA\xC9\x19\x98")] = {
			[2] = function(arg_113_0, arg_113_1, arg_113_2)
				local var_113_0 = 0

				while true do
					if var_113_0 == 0 then
						arg_113_1.yaw_offset = 23
						arg_113_1.body_yaw = var_0_6("\n\xCF\x05j\xF2I", "`Y\xBBd\x1E\x9B*\x87")
						var_113_0 = 1
					end

					if var_113_0 == 1 then
						arg_113_1.body_yaw_offset = 0

						break
					end
				end
			end,
			[3] = function(arg_114_0, arg_114_1, arg_114_2)
				local var_114_0 = 0

				while true do
					if var_114_0 == 1 then
						arg_114_1.body_yaw_offset = 0

						break
					end

					if var_114_0 == 0 then
						arg_114_1.yaw_offset = 10
						arg_114_1.body_yaw = var_0_6("\x1E\xD9\x02^s~", "\x1DM\xADc*\x1A")
						var_114_0 = 1
					end
				end
			end
		}
	})[var_104_3]

	if var_104_8 == nil then
		return
	end

	local var_104_9 = var_104_8[var_104_1]

	if var_104_9 == nil then
		return
	end

	arg_104_1.pitch = var_0_6("\xA0\xE7\x01{N\xE3\xE3", "m\xE4\x82g\x1A;\x8F\x97")
	arg_104_1.yaw_base = var_0_6("\xA2l\xEE\xCD?X(\x81\x97k", "\xE4\xE3\x18ι^*O")
	arg_104_1.yaw = var_0_6("\x9Fzg", "P\xAEBW\xC8\xD4{")
	arg_104_1.yaw_offset = 22
	arg_104_1.yaw_jitter = var_0_6("\xE4\x7F8", "s\xAB\x19^\xA8\x97")
	arg_104_1.body_yaw = var_0_6("?\xA6\xE55\xFE\x0F", "\x97l҄A")
	arg_104_1.body_yaw_offset = 120
	arg_104_1.freestanding_body_yaw = false

	var_104_9(arg_104_0, arg_104_1, var_104_0)

	var_0_93.is_active = true
end

function math.clamp(arg_115_0, arg_115_1, arg_115_2)
	local var_115_0 = 0
	local var_115_1

	while true do
		if var_115_0 == 0 then
			local var_115_2 = 0

			while true do
				if var_115_2 == 0 then
					if arg_115_2 < arg_115_1 then
						arg_115_1, arg_115_2 = arg_115_2, arg_115_1
					end

					return math.max(arg_115_1, math.min(arg_115_2, arg_115_0))
				end
			end

			break
		end
	end
end

local var_0_96 = {
	[var_0_6("\xDB[\a\\\xC7H\xC9G", "4\xB84i(\xA6!\xA7")] = function(arg_116_0, arg_116_1, arg_116_2)
		local var_116_0 = 0

		while true do
			if var_116_0 == 0 then
				for iter_116_0 = 1, #arg_116_1 do
					if arg_116_1[iter_116_0] == arg_116_2 then
						return true
					end
				end

				return false
			end
		end
	end,
	[var_0_6("U\vٗ7\xD1", "\xAC2n\xAD\xC8Z\xB4")] = function(arg_117_0)
		return entity.get_local_player()
	end,
	[var_0_6("\xF5\xB5\xE0s\xF6\xBF", ",\x9Bڔ")] = function(arg_118_0)
		local var_118_0 = arg_118_0.get_me()

		return var_118_0 == nil or not entity.is_alive(var_118_0)
	end,
	[var_0_6("\xE4\xF5\x13:\xDD5", "э\x9BL[\xB4G")] = function(arg_119_0, arg_119_1)
		local var_119_0 = entity.get_prop(arg_119_1, var_0_6("\xFEB\xD9m\x16\xF2z\xCC", "z\x93\x1D\xBF+"))

		return bit.band(var_119_0, 1) == 0
	end,
	[var_0_6("\xB5\xDEa\r\xCF\xFC\x87", "\x1Eܰ>i\xBA\x9F\xEC")] = function(arg_120_0, arg_120_1)
		local var_120_0 = 0
		local var_120_1

		while true do
			if var_120_0 == 0 then
				local var_120_2 = entity.get_prop(arg_120_1, var_0_6("\x85⃖:԰\xAE", "\xDD\xE8\xBD\xE5\xD0V\xB5\xD7"))

				return bit.band(var_120_2, 4) == 4
			end
		end
	end,
	[var_0_6("\v\xB1\xE0\xE38\t\xB8\xFB\xDF'\x18\xAD", "NlԔ\xBC")] = function(arg_121_0, arg_121_1)
		local var_121_0 = 0
		local var_121_1

		while true do
			if var_121_0 == 0 then
				local var_121_2 = 0

				while true do
					if var_121_2 == 0 then
						local var_121_3 = entity.get_prop(arg_121_1, var_0_6("6/\x02'\xEF6\xBE64\x13\x1D6\xF5", "Z[ptB\x8C`\xDB"))

						return var_0_7(var_121_3):length2d()
					end
				end
			end
		end
	end,
	[var_0_6("\xC8V\x04\x19\xE1\xA4", "d\xA57jl\x80\xC8")] = function(arg_122_0)
		if arg_122_0:not_me() then
			return
		end

		return 0
	end,
	[var_0_6("\xD6\xDF0\xA7\xC0", "ӥ\xABQ")] = function(arg_123_0)
		local var_123_0 = 0
		local var_123_1
		local var_123_2
		local var_123_3
		local var_123_4

		while true do
			if var_123_0 == 1 then
				var_123_3 = arg_123_0:in_air(var_123_1)
				var_123_4 = arg_123_0:in_duck(var_123_1)
				var_123_0 = 2
			end

			if var_123_0 == 2 then
				if var_123_3 then
					do return var_0_6("\x05|\xC0", "\xBCd\x15\xB2\xAA\xB7") end

					break
				end

				if var_123_2 > 1.5 then
					do return var_0_6("l\x02^\xBD\xBB\xC3y", "\xAD\x1Ew0\xD3\xD2") end

					break
				end

				if var_123_4 then
					do return var_0_6("X\xCB6/X\xD1", "Z;\xB9Y") end

					break
				end

				do return var_0_6("S\xE4[A?", "\x1D \x90:/[") end

				break
			end

			if var_123_0 == 0 then
				var_123_1 = arg_123_0:get_me()
				var_123_2 = arg_123_0:get_velocity(var_123_1)
				var_123_0 = 1
			end
		end
	end,
	[var_0_6("\x1D:c\xB0@\xAD\x1A/t\x82X\xA0\x04", "\xC1sU\x11\xDD!")] = function(arg_124_0, arg_124_1)
		local var_124_0 = 0

		while true do
			local var_124_1 = 0

			while true do
				if var_124_1 == 0 then
					if var_124_0 == 1 then
						if arg_124_1 > 180 then
							arg_124_1 = arg_124_1 - 360
						end

						return arg_124_1
					end

					if var_124_0 == 0 then
						arg_124_1 = arg_124_1 % 360
						arg_124_1 = (arg_124_1 + 344 + 16) % 360
						var_124_0 = 1
					end

					break
				end
			end
		end
	end
}
local var_0_97 = {
	[var_0_6("\xE0~", "\xBC\x8D\x1Bn~\xCF")] = nil,
	[var_0_6("\x807Pb\xE5\xE46\x9E?Zr", "i\xEDV>\x17\x84\x88")] = 0,
	[var_0_6("\xA0H+r/\x1C\xAA]", "}\xD9)\\-C")] = 0,
	[var_0_6("^\xB1\x12`\x87^_\xB1\bL\x8AM\\", ";9\xD4f?\xE3")] = function(arg_125_0, arg_125_1)
		local var_125_0 = 0
		local var_125_1
		local var_125_2
		local var_125_3
		local var_125_4

		while true do
			if var_125_0 == 1 then
				var_125_3 = false
				var_125_4 = (arg_125_1.duration or 1) * 2
				var_125_0 = 2
			end

			if var_125_0 == 0 then
				var_125_1 = arg_125_1.trigger or {
					var_0_6("\\\xE4h\x06d\xFB", "g\x1D\x88\x1F")
				}
				var_125_2 = false
				var_125_0 = 1
			end

			if var_125_0 == 2 then
				if var_0_96:contains(var_125_1, var_0_6("?\"\xCD+_\r", "&~N\xBAJ")) then
					var_125_2 = true
				end

				if var_0_96:contains(var_125_1, var_0_6("\xEENj\x9DB\x85\xD1O$\xCAT\x93\xC8T)\x82", "\xE4\xA1 J\xEA'")) and math.max(entity.get_prop(arg_125_0.me, var_0_6("3\xBB\f\xB9ބ,\x94\x1F\x90\x1E\xB4\xF3\x8A", "\xE0^\xE4jՐ\xE1T")) - globals.curtime(), 0) / globals.tickinterval() > 2 then
					var_125_2 = true
				end

				var_125_0 = 3
			end

			if var_125_0 == 3 then
				if var_125_4 >= globals.tickcount() % 32 and var_125_3 then
					return var_125_2
				end

				return var_125_2
			end
		end
	end,
	[var_0_6("\xB7\xEDS\xFF\x12\xB1\xEEB\xC8\x04\xB1\xEC", "aЈ'\xA0")] = function(arg_126_0, arg_126_1)
		if client.current_threat() then
			local var_126_0 = var_0_96:contains({
				var_0_6("\xC2(ЃK", "[\x96I\xA3\xE69r")
			}, var_0_6("z\xAC\xA1S\xE2", "?.\xCD\xD26\x90k\xDE"))
			local var_126_1 = var_0_96:contains({
				var_0_6("\xDB\"\xFDA\xD9", "\xBC\x90L\x94'")
			}, var_0_6("\xAEE|\xA2I", "5\xE5+\x15\xC4,lB"))
			local var_126_2 = entity.get_player_weapon(arg_126_0.me)

			if var_0_96:in_air(arg_126_0.me) and var_126_2 and (var_126_1 and entity.get_classname(var_126_2):find(var_0_6("\x18;\x1E\xA36", "\xC5SUw")) or var_126_0 and entity.get_classname(var_126_2):find(var_0_6("{\xFB\r2]", "W/\x9A~"))) then
				return true
			end
		end

		return false
	end,
	[var_0_6(",}\xD8\xE4\xD0\xD5(s\xDF\xCF\xD3\xD6", "\xB4K\x18\xAC\xBB\xB2")] = function(arg_127_0)
		local var_127_0 = client.current_threat()

		if var_0_96:not_me() or not var_127_0 then
			return false
		end

		local var_127_1 = entity.get_player_weapon(var_127_0)

		if not var_127_1 then
			return false
		end

		if not entity.get_classname(var_127_1):find(var_0_6("\xE8\xD7\xEC\x05y", "p\xA3\xB9\x85c\x1CD\x99")) then
			return false
		end

		local var_127_2 = {
			var_0_7(entity.get_origin(arg_127_0.me)),
			var_0_7(entity.get_origin(var_127_0))
		}

		return var_127_2[2]:dist2d(var_127_2[1]) < 230
	end,
	[var_0_6("\xB8]\xF8\xCE", "\xAB\xCB4\x9C")] = 0,
	[var_0_6("\xB9\xD3~\xBD/", "\xC0ڪ\x1D\xD1J\xE1\xDD")] = 0,
	[var_0_6("\x94\xDDB\x13", "\x9D\xE3\xBC;`\xAF-I")] = {
		[var_0_6("\xBC\xDF\xC5\x04", "Qߪ\xB7v")] = 0,
		[var_0_6("\"D\xAB", "qF!\xCCۙR")] = 0
	},
	[var_0_6("\xE8\x83(", "Б\xE2_\\\x9E")] = {
		[var_0_6("\xB8\xF3\xD8I\xF5\xF0", "xށ\xBD,\x8F\x95\xCF")] = 0,
		[var_0_6("\x96\x10\x13\xB5\xC5F", "\xD8\xE4q}Ѫ+\x19")] = 0,
		[var_0_6("\xEA\xF1QQ", "\x1E\x99\x9A8%\x12")] = 0
	},
	[var_0_6("\x19\xBC\xF1", "[}ٗl")] = {
		[var_0_6("\xE0\x12\xB1", "\xBE\x99s\xC6\x10")] = {
			[var_0_6(")k\xA3\x89", "\xE7Z\x1B\xCA")] = 0,
			[var_0_6("\x92\x8D\\\xA7", ">\xE1\xE48\xC2")] = 0,
			[var_0_6("\x05\xAE\xB84", "5v\xD9\xD9M\x14")] = 0
		},
		[var_0_6("\xB9\x16\xF0\xDD'", "O\xC9\x7F\x84\xBE")] = {
			[var_0_6(";\x04\xE0\xC7", "\xA9Ht\x89")] = 0,
			[var_0_6("jsͣ", "\xC6\x19\x1A\xA9")] = 0,
			[var_0_6("Zd\xDC?", "\x1F)\x13\xBDF\xE71\x1B")] = 0
		}
	},
	[var_0_6("\xBA\xDCU\xEF\xB1\xDAT\xF4", "\x86׳1")] = function(arg_128_0, arg_128_1, arg_128_2, arg_128_3, arg_128_4)
		local var_128_0 = 0
		local var_128_1
		local var_128_2

		while true do
			if var_128_0 == 1 then
				if arg_128_2 == var_0_6("\xCE\xF2P\xF5P\a", "s\x81\x946\x865") then
					if var_128_2 == 1 then
						var_128_1 = arg_128_4
					end
				elseif arg_128_2 == var_0_6("ʂ^_\xDD\x1A", "s\x89\xE70+\xB8h") then
					var_128_1 = var_128_2 == 1 and -arg_128_4 or arg_128_4
				elseif arg_128_2 == var_0_6("\xFE\xFB\x15\xF6\xA7\xA4r\xFB\xE8\t\xE6\xAD", "_\xB9\x89z\x83\xC9\xC0") then
					local var_128_3 = {
						0,
						2,
						1
					}
					local var_128_4

					if arg_128_0.yaw.skit == #var_128_3 then
						arg_128_0.yaw.skit = 1
					elseif not arg_128_3 then
						arg_128_0.yaw.skit = arg_128_0.yaw.skit + 1 + 0
					end

					local var_128_5 = var_128_3[arg_128_0.yaw.skit]

					if var_128_5 == 0 then
						var_128_1 = var_128_1 - math.abs(arg_128_4)
					elseif var_128_5 == 1 then
						var_128_1 = var_128_1 + math.abs(arg_128_4)
					end
				elseif arg_128_2 == var_0_6("D7\xC9\x17*{", "E\x16V\xA7s") then
					local var_128_6 = 0
					local var_128_7

					while true do
						if var_128_6 == 0 then
							local var_128_8 = math.random(0, arg_128_4 * 2) - arg_128_4

							if not arg_128_3 then
								local var_128_9 = 0

								while true do
									if var_128_9 == 0 then
										var_128_1 = var_128_1 + var_128_8
										arg_128_0.yaw.random = var_128_8

										break
									end
								end

								break
							end

							var_128_1 = var_128_1 + arg_128_0.yaw.random

							break
						end
					end
				elseif arg_128_2 == var_0_6("`\xC9P\x80\\", "G8\xE4'\xE1%") then
					if not arg_128_3 then
						arg_128_0.ways.curr = arg_128_0.ways.curr + 1

						if arg_128_0.ways.curr > (arg_128_1.way_value or 3) then
							arg_128_0.ways.curr = 1
						end
					else
						var_128_1 = var_128_1 + arg_128_0.ways.deg
					end

					arg_128_0.ways.deg = arg_128_1[var_0_6("\xA7\xE0\xFD\x16", "BЁ\x84I\x9A\x8D") .. arg_128_0.ways.curr] or 0
					var_128_1 = arg_128_0.ways.deg
				end

				return var_128_1
			end

			if var_128_0 == 0 then
				var_128_1 = 0
				var_128_2 = arg_128_0.side
				var_128_0 = 1
			end
		end
	end,
	[var_0_6("YZ\xC2", "\x9D*?\xB6")] = function(arg_129_0, arg_129_1, arg_129_2, arg_129_3)
		local var_129_0 = 0
		local var_129_1
		local var_129_2
		local var_129_3
		local var_129_4
		local var_129_5
		local var_129_6
		local var_129_7
		local var_129_8
		local var_129_9
		local var_129_10
		local var_129_11
		local var_129_12
		local var_129_13
		local var_129_14
		local var_129_15
		local var_129_16
		local var_129_17

		while true do
			if var_129_0 == 0 then
				local var_129_18 = false

				var_129_2 = var_0_96:manual()
				var_129_3 = arg_129_0.side
				var_129_4 = arg_129_2.delay_value_freze or 0

				local var_129_19 = (arg_129_2.freeze_ms or 100) / 10

				if (var_129_19 >= globals.tickcount() % (var_129_19 * 2) + 1 and -1 or 1) == 1 then
					arg_129_0.yaw.freeze = math.random(0, (arg_129_2.freeze_random or 100) / 10)
				end

				var_129_0 = 1
			end

			if var_129_0 == 2 then
				var_129_10 = 0

				local var_129_20 = (arg_129_2.lryaw and arg_129_2.yaw_value or arg_129_2.lyaw or 58) + math.random(-(arg_129_2.yaw_random or 0), arg_129_2.yaw_random or 0)
				local var_129_21 = arg_129_2.body_yaw or var_0_6("\x15+N4\x12 ", "\xA0F_/@{C")
				local var_129_22

				if var_129_21 == var_0_6("\xF1\\r", "Q\xBE:\x14") then
					local var_129_23 = var_0_6("cK\xB0", "S,-\xD6\x17\xE3I?")
				elseif var_129_21 == var_0_6("ڪV\xB13\xFC\xAEC", "@\x95\xDA&\xDE") then
					local var_129_24 = var_0_6("5\xB7\xDA\xDF\t\xAE\xDE\xD5", "\xB0zǪ")
				else
					local var_129_25 = 0
					local var_129_26

					while true do
						if var_129_25 == 0 then
							local var_129_27 = 0

							while true do
								if var_129_27 == 0 then
									if var_129_21 ~= var_0_6("8\x02\xA4\xC449", "KrkаQ") then
										var_129_3 = arg_129_2.body_yaw_static == var_0_6("\xD5./a", "\x15\x99KI") and 1 or 0
									end

									local var_129_28 = var_0_6(":\aL\xE6\xBBE", "&is-\x92\xD2")

									break
								end
							end

							break
						end
					end
				end

				var_129_10 = arg_129_0:modifier(arg_129_2, arg_129_2.yaw or var_0_6("-\x10\ne6\x16", "Sbvl\x16"), var_129_8, var_129_20)
				var_129_0 = 3
			end

			if var_129_0 == 1 then
				local var_129_29 = var_129_4 + arg_129_0.yaw.freeze / 2

				var_129_7 = math.clamp(arg_129_2.delay_adds == var_0_6("\xE9?'\xF8\xC0\xD673\xF9\x8F\xFF;%\xFD֛\n \xFF\xC4\xC8", "\xAF\xBB^I\x9C") and arg_129_2.delay_value + math.random(-(arg_129_2.delay_random or 0), arg_129_2.delay_random or 0) or var_129_29, 0, 32)
				var_129_8 = true

				if arg_129_2.delay_adds == "-" then
					var_129_7 = arg_129_2.delay_value_freze or 0
				end

				if globals.chokedcommands() == 0 and arg_129_0.cycle == var_129_7 then
					var_129_3 = var_129_3 == 1 and 0 or 1
					var_129_8 = false
				end

				var_129_9 = 90
				var_129_0 = 2
			end

			if var_129_0 == 5 then
				if globals.chokedcommands() == 0 then
					if var_129_7 <= arg_129_0.cycle then
						arg_129_0.cycle = 1
					else
						arg_129_0.cycle = arg_129_0.cycle + 1 + 0
					end
				end

				arg_129_0.side = var_129_3

				break
			end

			if var_129_0 == 3 then
				local var_129_30 = 0

				if arg_129_0:get_defensive(arg_129_3 or {}) then
					arg_129_1.force_defensive = true

					local var_129_31 = 1
				end

				local var_129_32 = (arg_129_2.lyaw or 58) + math.random(-(arg_129_2.lyaw_random or 0), arg_129_2.lyaw_random or 0)
				local var_129_33 = (arg_129_2.ryaw or 58) + math.random(-(arg_129_2.ryaw_random or 0), arg_129_2.ryaw_random or 0)

				var_129_10 = var_129_10 + (arg_129_2.lryaw and (var_129_3 == 0 and var_129_33 or var_129_3 == 1 and var_129_32 or 0) or 0)

				local var_129_34

				var_129_34 = var_129_3 == 2 and 0 or var_129_3 == 1 and -(arg_129_2.body_value or 0) or arg_129_2.body_value or 0
				var_129_0 = 4
			end

			if var_129_0 == 4 then
				if avoid_backstab_enabled:get() and arg_129_0:get_backstab() then
					var_129_10 = var_129_10 + 180
				end

				if safe_head_enabled:get() and arg_129_0:get_safehead() then
					local var_129_35 = 0

					while true do
						if var_129_35 == 1 then
							var_129_9 = 90

							local var_129_36 = 0

							var_129_35 = 2
						end

						if var_129_35 == 2 then
							var_129_3 = 2

							break
						end

						if var_129_35 == 0 then
							local var_129_37 = true

							var_129_10 = 0
							var_129_35 = 1
						end
					end
				end

				if var_129_2 and var_129_2 ~= 0 then
					var_129_10 = var_129_10 + var_129_2
				end

				arg_129_1.pitch = math.clamp(type(var_129_9) == var_0_6("G\xFEt/\xA0\x96", "C)\x8B\x19M\xC5\xE4") and var_129_9 or 0, -89, 89)
				arg_129_1.yaw = var_0_96:normalize_yaw(var_129_10)
				arg_129_0.yaw_last = var_0_96:normalize_yaw(var_129_10)
				var_129_0 = 5
			end
		end
	end,
	[var_0_6("\xEB\xA1\xC3:Z\xED\xFC\xAB", "\x88\x88ήJ6")] = function(arg_130_0, arg_130_1, arg_130_2)
		local var_130_0 = 0
		local var_130_1
		local var_130_2

		while true do
			if var_130_0 == 1 then
				arg_130_0:set(arg_130_1, var_130_1, var_130_2)

				break
			end

			if var_130_0 == 0 then
				var_130_1 = {
					[var_0_6(" \xF6\x8A\x84J\x9B\xAD%\xFF\x93\x80l\xA2\xA9!\xE9\x83", "\xDBD\x93\xE6\xE53\xC4")] = 0,
					[var_0_6("z\\\xF3\xE5\x1CB$q]", "{\x1C.\x96\x80f'")] = 100,
					[var_0_6("\x03[\x18R\x01\x8C\x04g\x04G\x19X\x16", "\x15e)}7{\xE9[")] = 100,
					[var_0_6("\x86\xEE\xA2\xF2\x15\r\x83\xEF\xAA\xE0", "R\xE2\x8BΓl")] = "-",
					[var_0_6("\xF5\x03A\xB0\xD5\xCE\x10L\xBD\xD9\xF4", "\xAC\x91f-\xD1")] = 0,
					[var_0_6("\xF0\b\x00A\x92A\xE6\f\x02D\x84s", "\x1E\x94ml \xEB")] = 0,
					[var_0_6("\x18U\b^\x03", "?t'q")] = false,
					[var_0_6("!Q\xD0\xD3\x06)\xA4-U", "\xC8X0\xA7\x8CpH")] = 58,
					[var_0_6("\xCEG)\xBC", "\x82\xA2>H\xCB")] = 58,
					[var_0_6("\xB1\xAE\xBCg", "\x9D\xC3\xD7\xDD\x10\xE7\xE0\x8F")] = 58,
					[var_0_6("f\xD8\x1C\xB3\xF1~\xD7\x0F\x83\xEE", "\x83\x1F\xB9k\xEC")] = 0,
					[var_0_6("\xA7\xB2K3\x94\xB9K*\xAF\xA4G", "D\xCB\xCB*")] = 0,
					[var_0_6("QNt\xCE|Et\xD7GXx", "\xB9#7\x15")] = 0,
					[var_0_6("\xB1\xF6\xBB\x9D\x8Cྒྷ", "\xE4ә\xDF")] = var_0_6("g\xFBY)3\x05", "f4\x8F8]Z"),
					[var_0_6("D\x18\xA41\xDA_\x16\xB7\x17\xF6R\x16\xB4!\xE6", "\x85&w\xC0H")] = var_0_6("ۤr\xEF", "\x9B\x97\xC1\x14"),
					[var_0_6(",\xAB\x04WD8\xA5\f[~", "\x1BN\xC4`.")] = 0,
					[var_0_6("\xF3\xFA\xA5", ",\x8A\x9B\xD2\xD8\x1A$")] = var_0_6("\x94K\xBFI\xF8\xAF", "\x9D\xDB-\xD9:"),
					[var_0_6("\xA7\xBC/\xEA豱#\xD0", "\x9E\xD0\xDDV\xB5")] = 3
				}
				var_130_2 = {
					[var_0_6("\xE1B\xFE\x026\xBA", "X\x80!\x8Ak@\xDF")] = false
				}
				var_130_0 = 1
			end
		end
	end,
	[var_0_6("\xD3\xE7{", "\x8E\xA1\x92\x15\x15\xCD\x1B")] = function(arg_131_0, arg_131_1)
		local var_131_0 = 0
		local var_131_1

		while true do
			if var_131_0 == 1 then
				local var_131_2 = var_0_96:state()

				arg_131_0:complete(arg_131_1, var_131_2)

				break
			end

			if var_131_0 == 0 then
				arg_131_0.me = var_0_96.get_me()

				if var_0_96:not_me() then
					return
				end

				var_131_0 = 1
			end
		end
	end
}
local var_0_98 = {
	[var_0_6("\x19\xE9C\x02\x19\xED\xC5\x06\xFF", "\xACp\x9A\x1Ccz\x99")] = false,
	[var_0_6("\xC6\xF2", "~\xAB\x97\xC0")] = nil
}

function var_0_98.get_backstab()
	local var_132_0 = 0
	local var_132_1
	local var_132_2
	local var_132_3
	local var_132_4

	while true do
		local var_132_5 = 0

		while true do
			if var_132_5 == 0 then
				if var_132_0 == 0 then
					var_132_1 = client.current_threat()

					if var_0_96:not_me() or not var_132_1 then
						return false
					end

					var_132_0 = 1
				end

				if var_132_0 == 1 then
					var_132_2 = entity.get_player_weapon(var_132_1)

					if not var_132_2 then
						return false
					end

					var_132_0 = 2
				end

				var_132_5 = 1
			end

			if var_132_5 == 1 then
				if var_132_0 == 2 then
					local var_132_6 = 0

					while true do
						if var_132_6 == 1 then
							var_132_0 = 3

							break
						end

						if var_132_6 == 0 then
							local var_132_7 = entity.get_classname(var_132_2)

							if not var_132_7 or not var_132_7:find(var_0_6("\x15\x10\xF0\x1A\x02", "9^~\x99|g\x9A")) then
								return false
							end

							var_132_6 = 1
						end
					end
				end

				if var_132_0 == 3 then
					local var_132_8 = {
						var_0_7(entity.get_origin(var_0_98.me)),
						var_0_7(entity.get_origin(var_132_1))
					}

					return var_132_8[2]:dist2d(var_132_8[1]) < 230
				end

				break
			end
		end
	end
end

function var_0_98.update(arg_133_0)
	local var_133_0 = 0

	while true do
		if var_133_0 == 0 then
			var_0_98.is_active = false

			if not avoid_backstab_enabled:get() then
				return
			end

			var_133_0 = 1
		end

		if var_133_0 == 1 then
			var_0_98.me = entity.get_local_player()

			if var_0_98.get_backstab() then
				local var_133_1 = 0

				while true do
					if var_133_1 == 1 then
						var_0_98.is_active = true

						break
					end

					if var_133_1 == 0 then
						if arg_133_0.yaw_offset == nil then
							arg_133_0.yaw_offset = 0
						end

						arg_133_0.yaw_offset = arg_133_0.yaw_offset + 180
						var_133_1 = 1
					end
				end
			end

			break
		end
	end
end

client.set_event_callback(var_0_6("\x16\xCED&\xD0H\x05\xC2", "!w\xA7)y\xB6"), function(arg_134_0)
	var_0_92.total = var_0_92.total + 1
end)
client.set_event_callback(var_0_6("F\xBD6i\xA3Z\b", "X'\xD4[6\xCB3|"), function(arg_135_0)
	var_0_92.hits = var_0_92.hits + 1
end)
client.set_event_callback(var_0_6("<\xA0\xB5\x93~\xDC\xF7/\xA3\xBA\x84~\xCD\xDC\x13\xAA\xA1\x86w", "\xA8L\xCC\xD4\xEA\x1B\xAE"), function(arg_136_0)
	local var_136_0 = 0
	local var_136_1

	while true do
		if var_136_0 == 0 then
			local var_136_2 = 0

			while true do
				if var_136_2 == 0 then
					if client.userid_to_entindex(arg_136_0[var_0_6("\x99\x176V\x00\xE2", ".\xECdS$i\x86")]) ~= entity.get_local_player() then
						return
					end

					var_0_92.hits = 0
					var_136_2 = 1
				end

				if var_136_2 == 1 then
					var_0_92.total = 0

					break
				end
			end

			break
		end
	end
end)

function var_0_91.frame()
	local var_137_0 = 0
	local var_137_1
	local var_137_2
	local var_137_3
	local var_137_4
	local var_137_5

	while true do
		if var_137_0 == 0 then
			if not hitrate_enabled:get() then
				return
			end

			var_137_1 = entity.get_local_player()
			var_137_0 = 1
		end

		if var_137_0 == 2 then
			local var_137_6, var_137_7, var_137_8 = 255, 255, 255

			renderer.indicator(var_137_6, var_137_7, var_137_8, 255, string.format(var_0_6("|\xFE\xC2\xC5\xC1@y\xBF\x83", "oY\x9A\xE7\xE0\xE1"), var_137_2, var_0_92.total))

			break
		end

		if var_137_0 == 1 then
			if var_137_1 == nil then
				return
			end

			var_137_2 = var_0_92.total ~= 0 and var_0_92.hits / var_0_92.total * 100 or 100
			var_137_0 = 2
		end
	end
end

local var_0_99 = {
	var_0_6("\xFA\xDF\b\xA0>\xF0\xDF", "\xB1\x9D\xBAf\xC5L\x99\xBC"),
	var_0_6("\xAA\xBB!\xAB", "\xCF\xC2\xDE@"),
	var_0_6("\x18}\xD2S\x9C", "\xB3{\x15\xB7 \xE8"),
	var_0_6("\xD57\xC30\xB2\x01\xCE", "b\xA6C\xAC]\xD3"),
	var_0_6("\xEB\xE6\xD1\xC1BK\xF0\xEA", "\x82\x87\x83\xB7\xB5b*"),
	var_0_6("ѿ<\xEB4\x83\xB7)\xEE", "@\xA3\xD6[\x83"),
	var_0_6("\x1D*\x1E\"\x7F\x1D*\x1F", "_qOxV"),
	var_0_6("\xB9\xFD'\xB8\x92M3̬", "\xA9˔@\xD0\xE6m_"),
	var_0_6("\xC6\x12\x05\xB9", "\x86\xA8wf\xD2J{\\"),
	"?",
	var_0_6("\xAC\v\x1DK", "9\xCBn|")
}
local var_0_100 = {}
local var_0_101 = 1
local var_0_102 = {
	notifys = {}
}

var_0_102.notifys.table_text = {}
var_0_102.notifys.c_var = {
	[var_0_6("\xBD\xD0\a,\x05\xA0", "`γuI")] = {
		client.screen_size()
	}
}

function var_0_102.lerp(arg_138_0, arg_138_1, arg_138_2, arg_138_3)
	return arg_138_1 + (arg_138_2 - arg_138_1) * arg_138_3
end

function aim_hit(arg_139_0)
	local var_139_0 = var_0_99[arg_139_0.hitgroup + 1] or "?"

	if hitlogs_select:get(var_0_6("\xAE-7\x06\x8E-d*\x8D&", "E\xE1C\x17")) then
		var_0_29(string.format("\affff4akrim.lua : \affffffHit %s in the %s for %d damage (%d health remaining)", entity.get_player_name(arg_139_0.target), var_139_0, arg_139_0.damage, entity.get_prop(arg_139_0.target, var_0_6("ɾ:\x9Dق\xD5o\xCC", "\x1B\xA4\xE1Sռ\xE3\xB9"))))
	end

	if hitlogs_select:get(var_0_6("\xA7\x01\xC2\xCDĚ\n\x87\xF0", "\xA7\xE8o\xE2\x9E")) then
		table.insert(var_0_102.notifys.table_text, {
			[var_0_6("P!7\f", "\xD1$DOx{=\x90")] = string.format(var_0_6("d\xE8G{E_\xA1Z5@X\xE9V{E_\xA1U4\x12\f\xA4W{\x04M\xECR<\x05\f\xA9\x16?@D\xE4R7\x14D\xA1A>\rM\xE8]2\x0EK\xA8", "`,\x813["), entity.get_player_name(arg_139_0.target), var_139_0, arg_139_0.damage, entity.get_prop(arg_139_0.target, var_0_6("\x180\x05\x8E\xF6\xE9\xFF\x01\a", "\x93uolƓ\x88"))),
			[var_0_6("\x1E\xBF\xCFQ\x18", "4j֢")] = globals.realtime(),
			[var_0_6("\x16\x02ѫ\xE5\r0\xC7", "\x91eo\xBE\xC4")] = var_0_102.notifys.c_var.screen[2] + 100,
			[var_0_6("Q\xC1\x91\xE4N", "/0\xAD\xE1\x8C")] = 0,
			[var_0_6("B\xC1\x91\xD0*\xFE", "\xCC#\xAD\xE1\xB8K")] = 0,
			[var_0_6("\xEFH\xF3\x85\xE7\xF5", "n\x8E$\x83\xED\x86\xC6")] = 0,
			[var_0_6("yO\xAB\xCF4~F\xA7", "X\x1B Ӑ")] = 0,
			[var_0_6("\x8F\xA4\xA6\x03٤\\x\x99", "\x10\xED\xCB\xDE\\\xAB\xCD;")] = 0,
			[var_0_6("㾥\xB7\x13\xB6祂\xD9", "Ӂ\xD1\xDD\xE8\x7F")] = 0,
			[var_0_6("\v@^\x1B\xEE\x14\xB7N\x1Dp\x17", "&i/&D\x9C}\xD0")] = 0
		})
	end
end

local function var_0_103(arg_140_0)
	local var_140_0 = 0
	local var_140_1

	while true do
		if var_140_0 == 1 then
			if misslogs_select:get(var_0_6("\xA3\x8E\xE5g\xF3&\x9F\x8F\xA9A", "H\xEC\xE0\xC5$\x9C")) then
				var_0_29(string.format("\affff4akrim.lua : \affffffMissed %s (%s) due to %s", entity.get_player_name(arg_140_0.target), var_140_1, arg_140_0.reason))
			end

			if misslogs_select:get(var_0_6("\xEB\xA5\x04\xB9ǹA\x8F\xCA", "\xEA\xA4\xCB$")) then
				table.insert(var_0_102.notifys.table_text, {
					[var_0_6("\x1F\xE8\x986", "\x12k\x8D\xE0B\xEC>\x11")] = string.format(var_0_6("\x86\xA6\x0F䮫\\\xB2\xB8\xEFT\xB2\xB8\xE6\\\xF3\xBE\xAA\\\xE3\xA4\xEFY\xE4", "\x97\xCB\xCF|"), entity.get_player_name(arg_140_0.target), var_140_1, arg_140_0.reason),
					[var_0_6("\xC0\x13\xFC\a\xF2", "\xA4\xB4z\x91b\x80\xE9~")] = globals.realtime(),
					[var_0_6("\xA8\t\x14¯\f$\xD4", "\xAD\xDBd{")] = var_0_102.notifys.c_var.screen[2] + 100,
					[var_0_6("\xB5$\\\x03\x12", "s\xD4H,k")] = 0,
					[var_0_6("\x8D\xE3Dz\xFC|", "$\xEC\x8F4\x12\x9DN\xCE")] = 0,
					[var_0_6("QM(G\xFE\x03", "\x9F0!X/")] = 0,
					[var_0_6("\x1DM\x01Ϳ\xE41#", "W\x7F\"y\x92ӁW")] = 0,
					[var_0_6("\xA9\xEE\x9D\xD377\xC8|\xBF", "\x14ˁ\xE5\x8CE^\xAF")] = 0,
					[var_0_6("\xAD\xC9L\t\xE3\xE7\xA9\xD2kg", "\x82Ϧ4V\x8F")] = 0,
					[var_0_6("HU\vҸr&BN,\xBC", "A*:s\x8D\xCA\x1B")] = 0
				})
			end

			break
		end

		if var_140_0 == 0 then
			local var_140_2 = 0

			while true do
				if var_140_2 == 1 then
					var_140_0 = 1

					break
				end

				if var_140_2 == 0 then
					var_140_1 = var_0_99[arg_140_0.hitgroup + 1] or "?"

					var_0_93.update(arg_140_0, arg_140_0)

					var_140_2 = 1
				end
			end
		end
	end
end

function noti()
	y = var_0_102.notifys.c_var.screen[2] - 100

	for iter_141_0, iter_141_1 in ipairs(var_0_102.notifys.table_text) do
		if iter_141_0 > 5 then
			table.remove(var_0_102.notifys.table_text, iter_141_0)
		end

		if iter_141_1.text ~= nil and iter_141_1 ~= "" then
			text_size = {
				renderer.measure_text(nil, iter_141_1.text)
			}
			r, g, b, a = custom_scope_color:get()

			if iter_141_1.timer + 3.8000000000000007 < globals.realtime() then
				iter_141_1.box_left = var_0_102:lerp(iter_141_1.box_left, text_size[1], globals.frametime() * 1)
				iter_141_1.box_right = var_0_102:lerp(iter_141_1.box_right, text_size[1], globals.frametime() * 1)
				iter_141_1.box_left_1 = var_0_102:lerp(iter_141_1.box_left_1, 0, globals.frametime() * 1)
				iter_141_1.box_right_1 = var_0_102:lerp(iter_141_1.box_right_1, 0, globals.frametime() * 1)
				iter_141_1.smooth_y = var_0_102:lerp(iter_141_1.smooth_y, var_0_102.notifys.c_var.screen[2] + 100, globals.frametime() * 2)
				iter_141_1.alpha = var_0_102:lerp(iter_141_1.alpha, 0, globals.frametime() * 4)
				iter_141_1.alpha2 = var_0_102:lerp(iter_141_1.alpha2, 0, globals.frametime() * 4)
				iter_141_1.alpha3 = var_0_102:lerp(iter_141_1.alpha3, 0, globals.frametime() * 4)
			else
				iter_141_1.alpha = var_0_102:lerp(iter_141_1.alpha, a, globals.frametime() * 4)
				iter_141_1.alpha2 = var_0_102:lerp(iter_141_1.alpha2, 1, globals.frametime() * 4)
				iter_141_1.alpha3 = var_0_102:lerp(iter_141_1.alpha3, 255, globals.frametime() * 4)
				iter_141_1.smooth_y = var_0_102:lerp(iter_141_1.smooth_y, y, globals.frametime() * 5)
				iter_141_1.box_left = var_0_102:lerp(iter_141_1.box_left, text_size[1] - text_size[1] / 2 - 2, globals.frametime() * 1)
				iter_141_1.box_right = var_0_102:lerp(iter_141_1.box_right, text_size[1] - text_size[1] / 2 + 4, globals.frametime() * 1)
				iter_141_1.box_left_1 = var_0_102:lerp(iter_141_1.box_left_1, text_size[1] + 10 + 3, globals.frametime() * 2)
				iter_141_1.box_right_1 = var_0_102:lerp(iter_141_1.box_right_1, text_size[1] + 7 + 7, globals.frametime() * 2)
			end

			add_y = math.floor(iter_141_1.smooth_y)
			alpha = iter_141_1.alpha
			alpha2 = iter_141_1.alpha2
			alpha3 = iter_141_1.alpha3
			left_box = math.floor(iter_141_1.box_left)
			right_box = math.floor(iter_141_1.box_right)
			left_box_1 = math.floor(iter_141_1.box_left_1)
			right_box_1 = math.floor(iter_141_1.box_right_1)

			if iter_141_1.type == nil then
				iter_141_1.type = false
			end

			if iter_141_1.red == nil then
				iter_141_1.red = r
			end

			if iter_141_1.green == nil then
				iter_141_1.green = g
			end

			if iter_141_1.blue == nil then
				iter_141_1.blue = b
			end

			r, g, b = iter_141_1.red, iter_141_1.green, iter_141_1.blue

			if iter_141_1.type == false then
				local var_141_0 = 0

				while true do
					if var_141_0 == 0 then
						var_0_43.container5(var_0_102.notifys.c_var.screen[1] / 2 - text_size[1] / 2 - 4 + 5, add_y - 21, text_size[1] + 8 + 4 - 7 + 4, text_size[2] + 7, r, g, b, alpha, alpha2)

						y = y - 25
						var_141_0 = 1
					end

					if var_141_0 == 1 then
						renderer.text(var_0_102.notifys.c_var.screen[1] / 2 - text_size[1] / 2 + 5, add_y - 19 + 1, 246, 164, 60, 255, nil, 0, "\affffffff" .. iter_141_1.text)

						break
					end
				end
			else
				local var_141_1 = 0
				local var_141_2
				local var_141_3
				local var_141_4
				local var_141_5
				local var_141_6
				local var_141_7
				local var_141_8
				local var_141_9

				while true do
					if var_141_1 == 3 then
						local var_141_10 = math.abs(1 * math.cos(2 * math.pi * (globals.curtime() + 3) / 6)) * 90
						local var_141_11 = math.abs(1 * math.cos(2 * math.pi * (globals.curtime() + 2 + 1) / 6)) * 100

						var_141_1 = 4
					end

					if var_141_1 == 2 then
						text2 = var_0_6("h\x19\xDC", "O39\x81\xB4")

						renderer.rectangle(0, 0, var_141_2, var_141_3, 0, 0, 0, 55 * alpha2)

						var_141_1 = 3
					end

					if var_141_1 == 4 then
						local var_141_12 = {
							renderer.measure_text(var_0_6("3\xF9{", "\xB9W\xD2P8"), text:sub(1, var_141_4))
						}
						local var_141_13 = {
							renderer.measure_text("b", "\a878787ff[DEBUG]")
						}

						break
					end

					if var_141_1 == 0 then
						local var_141_14 = 0

						while true do
							if var_141_14 == 1 then
								var_141_1 = 1

								break
							end

							if var_141_14 == 0 then
								var_141_2, var_141_3 = client.screen_size()
								var_141_4 = var_0_15.anim_new(var_0_6("X\x05Q\xC0<O\x17S\xD2.S\x1CM", "O+d5\xA1"), alpha2 > 0 and 12 or 0)
								var_141_14 = 1
							end
						end
					end

					if var_141_1 == 1 then
						local var_141_15 = var_0_15.anim_new(var_0_6("\xE3\xC5\xCBNGH%B\xE3\xC5\xD7WLT", "$\x90\xA4\xAF/4,V"), alpha2 > 0 and 8 or 0)

						text = var_0_6(";\x1D\xF2\xA9", "\x1FPo\x9B\xC4")
						var_141_1 = 2
					end
				end
			end

			if iter_141_1.timer + 4 < globals.realtime() then
				table.remove(var_0_102.notifys.table_text, iter_141_0)
			end
		end
	end
end

function createlog(arg_142_0)
	table.insert(var_0_102.notifys.table_text, {
		[var_0_6("\xD2\x15\xB6L", "5\xA6p\xCE8\x1D\x99")] = "" .. arg_142_0,
		[var_0_6("f\x1A[\x0F\xE7", "O\x12s6j\x95")] = globals.realtime(),
		[var_0_6("Y_AQ1u\xB2\xBF", "\xC6*2.>E\x1D\xED")] = var_0_102.notifys.c_var.screen[2] + 100,
		[var_0_6("ö\x061)", ";\xA2\xDAvYH\xC0n")] = 0,
		[var_0_6("\x84\xF2\xA0WIS", "a\xE5\x9E\xD0?(a\x12")] = 0,
		[var_0_6(",\xC2bN\x8D~", "\xECM\xAE\x12&")] = 0,
		[var_0_6("\x82R\xD7*\x8CX\xC9\x01", "u\xE0=\xAF")] = 0,
		[var_0_6("\xE9H޷\xF9N\xC1\x80\xFF", "\xE8\x8B'\xA6")] = 0,
		[var_0_6("\xE1^Kz{\xC7\xE5El\x14", "\xA2\x8313%\x17")] = 0,
		[var_0_6("]v\xE6\x15fV~\xF6>K\x0E", "\x14?\x19\x9EJ")] = 0,
		[var_0_6("n\xC3L\xA8", "\xD9\x1A\xBA<\xCD\x1F\xB0H")] = true
	})
end

createlog(var_0_6("\xCFt\x15\xE0\xDA1\x03\xAC\xD9~\x15\xFF\xCE", "\x8C\xBB\x11f"))

local function var_0_104()
	local var_143_0 = 0
	local var_143_1

	while true do
		if var_143_0 == 0 then
			local var_143_2 = var_0_7(client.screen_size())

			if #var_0_100 > 0 then
				if globals.tickcount() >= var_0_100[1][2] then
					if var_0_100[1][3] > 0 then
						var_0_100[1][3] = var_0_100[1][3] - 20
					elseif var_0_100[1][3] <= 0 then
						table.remove(var_0_100, 1)
					end
				end

				if #var_0_100 > 6 then
					table.remove(var_0_100, 1)
				end

				if globals.is_connected == false then
					table.remove(var_0_100, #var_0_100)
				end

				for iter_143_0 = 1, #var_0_100 do
					local var_143_3 = 0

					while true do
						if var_143_3 == 0 then
							text_size = renderer.measure_text("b", var_0_100[iter_143_0][1])

							if var_0_100[iter_143_0][3] < 255 then
								var_0_100[iter_143_0][3] = var_0_100[iter_143_0][3] + 10
							end

							var_143_3 = 1
						end

						if var_143_3 == 1 then
							renderer.text(var_143_2.x / 2 - text_size / 2 + var_0_100[iter_143_0][3] / 35, var_143_2.y / 1.2999999999999545 + 13 * iter_143_0, 255, 255, 255, 230, "", 0, var_0_100[iter_143_0][1])

							break
						end
					end
				end
			end

			break
		end
	end
end

local var_0_105 = {
	[var_0_6("?\x84\xB1O(\xB4\xA7M#\x9E\xA0", "!L\xEB\xC4")] = {
		var_0_6("<\xE2\xFBL\xECaő\t\xFA\xB2V\xBFp\x96\x95\a\xE4\xE1P\xBE5\x81\xC5\n\xF3\xB2t\xBE9\x88\xC9H\xEE\xFDQ\xB8p\x86\x97\x11", "\xE5h\x8A\x92?\xCCP\xE5"),
		var_0_6("\x99r\v\x89\xAAh\r\xDD\xE0z\x11\xDD\xE0y\x1Bťi\x1B\xCD\xEC=\n\xC1\xA1s\x15\x89\x8Bo\x17\xC4\xE0{\x11\xDB\xE0i\x16ȴ3", "\xA9\xC0\x1D~"),
		var_0_6("\x1E\xCB\x00\xCB\"\xCD\n\x9F}\x85\n\x854\x85\x11\x8A!\x89E\x84?\xC0E\xA0#\xCC\b\xCB<\xCA\b\x8E?\xD1K", "\xEBQ\xA5e"),
		var_0_6("\\\x8BQ\r\xC5\f\xCDl\x81\x1F\x14\x80H\x8Cp\x85K\x1C\xC5/\xDEq\x89\x1F\x1F\x8A\x16\x8Cu\x85T\x10\x8B\x03\x8Cq\x90\x1F\x15\x8A\v\xC78\x81^\n\x9C", "\xAC\x18\xE4?y\xE5d"),
		var_0_6("\xB9Z\xD4\xD4\xCAC\xD4\xC9\xC6\x0E\xDCٙ\x0E\xDFؙZ\x95\xE6\x98G؍\x87O\xDEĄI\x95\xC0\x8F\x0E\xD7ȞZ\xD0\xDF\xC4", "\xAD\xEA.\xB5"),
		var_0_6("\xEB:\xE2,c\x8Er\xFF>3\x9F;\xF8\x7F0\xCF=\xE5,,\xCD7\xEF\x7F!\xC6r\xC0-*\xD2~\xAB;,\xD1&\xAB<1\xC6", "C\xBFR\x8B_"),
		var_0_6("\x04\xE2R\x82\xE6\xFE.\xF9\a\xC5\xE3\xFF}\xE9B\xCE\xE9\xFF8\xE9\v\x82\xF8\xE3<\xE3L\x82\xC7\xF94\xE0\a\xC4\xE3\xF9}\xF9O\xC3\xF8", "\x8B]\x8D'\xA2\x8C")
	},
	[var_0_6("(\xA6\x0F\xD6\v \xB7", "~L\xC3i\xB7")] = {
		var_0_6("pF\xA11J\xBCP\\\xE81V\xBAZ\b\xB0pI\xF8\x1FG\xAAt\x19\x9FMA\xA91T\xBBRM\xAAe", "\xD4?(\xC4\x119"),
		var_0_6("\x8D\xC4\xFE\xEE\xE9\xC3\xF1\xFD\xFF\xE5\x8B\xF8\xFB\xBDΰѻ\xC2\xFD\xBA\xAF\xC4⺤\xCA\xFB\xF3\xA7̰\xF3\xBD\x8B\xFC\xF5\xA6\xC0\xB0\xFF\xA8\xD8\xE9", "\x9Aɫ\x90"),
		var_0_6("\xB1\xFA\xA9\xD4\xF6\x02\xBE\xB9ή\xA1٥O\xB5\xA8\x91\xFA\xE8\xE6\xA4\x06\xB2\xFD\x8F\xEF\xA3ĸ\b\xFF\xB0\x87\xAE\xAAȢ\x1B\xBA\xAF", "\xDD\xE2\x8Eȭ\xD6o\xDF"),
		var_0_6(":F\xB6\"\xE8_\x0E\xAB0\xB8NG\xACq\xBB\x1EA\xB1\"\xA7\x1CK\xBBq\xAA\x17\x0E\x94#\xA1\x03\x02\xFF5\xA7\x00Z\xFF2\xBA\x17", "\xC8n.\xDFQ"),
		var_0_6("/H)t(\xC7Q\x02\a;;6\x92F\x13K9 '\xD6\x0EVS45,\xD9\x02=U59b\xD4M\x04\a(<#\xC6", "\"v'\\TB\xB2"),
		var_0_6("I\x91q\t<\xA0\xC2", "\x13+\xE8QbNɯ")
	}
}
local var_0_106 = client.userid_to_entindex
local var_0_107 = entity.get_local_player
local var_0_108 = entity.is_enemy
local var_0_109 = client.exec

local function var_0_110(arg_144_0)
	if not trash_talk_enable:get() then
		return
	end

	local var_144_0 = arg_144_0.userid
	local var_144_1 = arg_144_0.attacker

	if var_144_0 == nil or var_144_1 == nil then
		return
	end

	local var_144_2 = var_0_106(var_144_0)

	if var_0_106(var_144_1) == var_0_107() and var_0_108(var_144_2) then
		client.delay_call(0.2, function()
			var_0_109(var_0_6("X\xD2\xE1\xE6", "\xEA+\xB3\x98Ƥ\x8D"), var_0_105.sound_cloud[math.random(1, #var_0_105.sound_cloud)])
		end)
	end
end

local var_0_111 = {
	var_0_59
}
local var_0_112 = var_0_8.setup(var_0_111)
local var_0_113 = ""
local var_0_114 = ""
local var_0_115 = ""

function config.export()
	local var_146_0 = 0

	while true do
		if var_146_0 == 1 then
			var_0_9.set(var_0_114)
			var_0_29("\affff4akrim.lua : \affffff\aADD8E6FFExported")

			break
		end

		if var_146_0 == 0 then
			var_0_113 = var_0_112:save()
			var_0_114 = var_0_13.stringify(var_0_113)
			var_146_0 = 1
		end
	end
end

function config.import(arg_147_0)
	local var_147_0 = 0

	while true do
		if var_147_0 == 0 then
			var_0_115 = var_0_13.parse(arg_147_0 ~= nil and arg_147_0 or var_0_9.get())

			var_0_112:load(var_0_115)

			var_147_0 = 1
		end

		if var_147_0 == 1 then
			var_0_29("\affff4akrim.lua : \affffff\aADD8E6FFImported")

			break
		end
	end
end

local var_0_116 = {}

local function var_0_117(arg_148_0)
	if not arg_148_0.saveable then
		return
	end

	if ui.type(arg_148_0.ref) == var_0_6("\xA9[~ۋ", "\xE7\xC5:\x1C\xBE\xE7ӭ") or ui.type(arg_148_0.ref) == var_0_6("[\xDD*'ҕ", "\xEC3\xB2^L\xB7") then
		return
	end

	return arg_148_0.value
end

local function var_0_118(arg_149_0, arg_149_1)
	local var_149_0 = 0
	local var_149_1

	while true do
		if var_149_0 == 0 then
			local var_149_2 = 0

			while true do
				if var_149_2 == 2 then
					return true
				end

				if var_149_2 == 0 then
					if ui.type(arg_149_0.ref) == var_0_6("\xE6\xCC\xD0F\xE6", "#\x8A\xAD\xB2") or ui.type(arg_149_0.ref) == var_0_6("\xC9\f\\\xD7Wd", "\x1D\xA1c(\xBC2") then
						return true
					end

					if not arg_149_0.saveable then
						return true
					end

					var_149_2 = 1
				end

				if var_149_2 == 1 then
					if arg_149_1 == nil then
						return false
					end

					arg_149_0:set(unpack(arg_149_1))

					var_149_2 = 2
				end
			end

			break
		end
	end
end

function var_0_116.export_to_str()
	local var_150_0 = 0
	local var_150_1

	while true do
		if var_150_0 == 1 then
			return var_0_12.encode(var_0_13.stringify(var_150_1)) .. var_0_6("F+\xA3\xEE\n", "\x8C\x19J\xC0\x87nZj")
		end

		if var_150_0 == 0 then
			var_150_1 = {}

			for iter_150_0, iter_150_1 in ipairs(ui.get_items()) do
				var_150_1[iter_150_1.name] = var_0_117(iter_150_1)
			end

			var_150_0 = 1
		end
	end
end

function var_0_116.import_from_str(arg_151_0)
	arg_151_0 = arg_151_0:gsub(var_0_6("\x1DPG\xFB\xAE", "\xC2B1$\x92\xCA"), "")

	local var_151_0, var_151_1 = pcall(var_0_12.decode, arg_151_0)

	if not var_151_0 then
		local var_151_2 = 0

		while true do
			if var_151_2 == 0 then
				var_0_29("\affff4akrim.lua : \affffffFailed to decode config")

				return
			end
		end
	end

	local var_151_3, var_151_4 = pcall(var_0_13.parse, var_151_1)
	local var_151_5 = var_151_4

	if not var_151_3 then
		var_0_29("\affff4akrim.lua : \affffffFailed to parse config")

		return
	end

	for iter_151_0, iter_151_1 in ipairs(ui.get_items()) do
		local var_151_6 = 0
		local var_151_7

		repeat
			-- block empty
		until var_151_6 == 0 and (var_0_118(iter_151_1, var_151_5[iter_151_1.name]) or true)
	end
end

client.set_event_callback(var_0_6("\x9B0\xC4\f\xD1", "\xA5\xEBQ\xADb"), function()
	var_0_78()
end)
client.set_event_callback(var_0_6("8\x80\xBD#\xA9\xDB(\x8A\xA4;\xB8\xEA/", "\x84K\xE5\xC9V\xD9"), function(arg_153_0)
	if not var_0_93.is_active and avoid_backstab_enabled:get() then
		local var_153_0 = 0
		local var_153_1

		while true do
			if var_153_0 == 0 then
				local var_153_2 = entity.get_local_player()

				if var_153_2 and entity.is_alive(var_153_2) then
					local var_153_3 = 0
					local var_153_4

					while true do
						if var_153_3 == 0 then
							local var_153_5 = client.current_threat()

							if var_153_5 then
								local var_153_6 = 0
								local var_153_7

								while true do
									if var_153_6 == 0 then
										local var_153_8 = entity.get_player_weapon(var_153_5)

										if var_153_8 then
											local var_153_9 = 0
											local var_153_10

											while true do
												if var_153_9 == 0 then
													if entity.get_classname(var_153_8):find(var_0_6("\xA9|\xAC\xA3\x87", "\xC5\xE2\x12\xC5")) then
														local var_153_11 = 0
														local var_153_12
														local var_153_13
														local var_153_14

														while true do
															if var_153_11 == 1 then
																if var_153_12:dist2d(var_153_13) < 230 then
																	local var_153_15 = 0
																	local var_153_16
																	local var_153_17
																	local var_153_18

																	while true do
																		if var_153_15 == 0 then
																			local var_153_19 = 0

																			while true do
																				if var_153_19 == 0 then
																					var_153_16 = var_153_13.x - var_153_12.x
																					var_153_17 = var_153_13.y - var_153_12.y
																					var_153_19 = 1
																				end

																				if var_153_19 == 1 then
																					var_153_15 = 1

																					break
																				end
																			end
																		end

																		if var_153_15 == 2 then
																			ui.set(var_0_39.antiaim.yaw[2], 0)

																			break
																		end

																		if var_153_15 == 1 then
																			arg_153_0.yaw = math.deg(math.atan2(var_153_17, var_153_16))
																			var_153_15 = 2
																		end
																	end
																end

																break
															end

															if var_153_11 == 0 then
																local var_153_20 = 0

																while true do
																	if var_153_20 == 0 then
																		var_153_12 = var_0_7(entity.get_origin(var_153_2))
																		var_153_13 = var_0_7(entity.get_origin(var_153_5))
																		var_153_20 = 1
																	end

																	if var_153_20 == 1 then
																		var_153_11 = 1

																		break
																	end
																end
															end
														end
													end

													break
												end
											end
										end

										break
									end
								end
							end

							break
						end
					end
				end

				break
			end
		end
	end
end)
client.set_event_callback(var_0_6("\f\xD0\b_\b\xEE\x14X", "1|\xB1a"), function()
	local var_154_0 = 0

	while true do
		if var_154_0 == 0 then
			hide_original_menu(false)
			var_0_81()

			var_154_0 = 1
		end

		if var_154_0 == 1 then
			if custom_scope_enabled:get() then
				ui.set(var_0_39.visuals.scope_overlay, true)
			end

			break
		end
	end
end)
client.set_event_callback(var_0_6("\x90<ɰ\x94", "\xDE\xE0]\xA0"), function(arg_155_0)
	local var_155_0 = 0

	while true do
		if var_155_0 == 3 then
			var_0_91.frame()

			if clantag_enable:get() then
				var_0_17.handle()
			end

			var_155_0 = 4
		end

		if var_155_0 == 0 then
			var_0_82()
			var_0_104()

			var_155_0 = 1
		end

		if var_155_0 == 4 then
			noti()

			break
		end

		if var_155_0 == 1 then
			var_0_86()
			var_0_88()

			var_155_0 = 2
		end

		if var_155_0 == 2 then
			var_0_87(arg_155_0)
			var_0_90()

			var_155_0 = 3
		end
	end
end)
client.set_event_callback(var_0_6("\xF8\xF5g5<\xE4\xEA|", "X\x8B\x9D\x12A"), function()
	local var_156_0 = 0

	while true do
		if var_156_0 == 1 then
			ui.set_visible(var_0_39.visuals.scope_overlay, true)

			break
		end

		if var_156_0 == 0 then
			hide_original_menu(true)
			var_0_17.set("")

			var_156_0 = 1
		end
	end
end)
client.set_event_callback(var_0_6("K\x13\x1F.\xC3C\x0E", "\xAB*zrq"), aim_hit)
client.set_event_callback(var_0_6("\x8C\xA1\xC1݀\xA1\xDF\xF1", "\x82\xEDȬ"), var_0_103)
client.set_event_callback(var_0_6("6ܯ\x17#\xC2\x91\n#Ѻ\x06", "nF\xB0\xCE"), var_0_110)

local var_0_119 = {
	[var_0_6("|\x03\x02\xEA9a\x19+\xEE", "Z\x15p]\x8B")] = false
}
local var_0_120 = {
	[var_0_6("2\xCFu\xB8\xA4\b\xD5s", "\xC0a\xBB\x14\xD6")] = {
		[2] = function(arg_157_0, arg_157_1, arg_157_2)
			local var_157_0 = 0

			while true do
				if var_157_0 == 0 then
					arg_157_1.yaw_offset = -6
					arg_157_1.body_yaw = var_0_6("9O2܉\t", "\xE0j;S\xA8")
					var_157_0 = 1
				end

				if var_157_0 == 1 then
					arg_157_1.body_yaw_offset = 0

					break
				end
			end
		end,
		[3] = function(arg_158_0, arg_158_1, arg_158_2)
			arg_158_1.yaw_offset = 8
			arg_158_1.body_yaw = var_0_6("\x94\xF1\x03\xEFG\x8B", ")ǅb\x9B.\xE8")
			arg_158_1.body_yaw_offset = 0
		end
	},
	[var_0_6("?\xB4\xEES\xBE\a\xE3\x18", "\x86|Ɓ&\xDDo")] = {
		[2] = function(arg_159_0, arg_159_1, arg_159_2)
			local var_159_0 = 0

			while true do
				if var_159_0 == 1 then
					arg_159_1.body_yaw_offset = 0

					break
				end

				if var_159_0 == 0 then
					arg_159_1.yaw_offset = 0
					arg_159_1.body_yaw = var_0_6("\xCB\xFB\xB04\xF1\xEC", "@\x98\x8F\xD1")
					var_159_0 = 1
				end
			end
		end,
		[3] = function(arg_160_0, arg_160_1, arg_160_2)
			arg_160_1.yaw_offset = 40
			arg_160_1.body_yaw = var_0_6("\x04]\xC4\x18C.", "gW)\xA5l*M\x1C")
			arg_160_1.body_yaw_offset = 180
		end
	},
	[var_0_6("\x81\xC1\x1B\xE2u\xE8\xA7\xD7T\xD6\x7F\xF2", "\x80³t\x97\x16")] = {
		[2] = function(arg_161_0, arg_161_1, arg_161_2)
			local var_161_0 = 0

			while true do
				if var_161_0 == 1 then
					arg_161_1.body_yaw_offset = -120

					break
				end

				if var_161_0 == 0 then
					arg_161_1.yaw_offset = 0
					arg_161_1.body_yaw = var_0_6("4&\x02\xB3\xD57", "\xE6gRcǼT")
					var_161_0 = 1
				end
			end
		end,
		[3] = function(arg_162_0, arg_162_1, arg_162_2)
			local var_162_0 = 0

			while true do
				if var_162_0 == 1 then
					arg_162_1.body_yaw_offset = 120

					break
				end

				if var_162_0 == 0 then
					arg_162_1.yaw_offset = 0
					arg_162_1.body_yaw = var_0_6("\x8F\x92\xA2\xBCP)", "J\xDC\xE6\xC3\xC89")
					var_162_0 = 1
				end
			end
		end
	},
	[var_0_6("\x84\x83\xC2_ ߬\x8C\xD5", "\xB1\xC5\xEA\xB0\x7Fk")] = {
		[2] = function(arg_163_0, arg_163_1, arg_163_2)
			local var_163_0 = 0

			while true do
				if var_163_0 == 0 then
					arg_163_1.yaw_offset = 45
					arg_163_1.body_yaw = var_0_6("@\xDE\xC7\\\x83w", "?\x13\xAA\xA6(\xEA\x14")
					var_163_0 = 1
				end

				if var_163_0 == 1 then
					arg_163_1.body_yaw_offset = 180

					break
				end
			end
		end,
		[3] = function(arg_164_0, arg_164_1, arg_164_2)
			arg_164_1.yaw_offset = 35
			arg_164_1.body_yaw = var_0_6("\x05\x1C\f<).", "\xA0VhmH@M")
			arg_164_1.body_yaw_offset = 180
		end
	},
	[var_0_6("\xD8z\xFCJ$\x8F\xEC`", "\xEA\x99\x13\x8Ej~")] = {
		[2] = function(arg_165_0, arg_165_1, arg_165_2)
			local var_165_0 = 0

			while true do
				if var_165_0 == 1 then
					arg_165_1.body_yaw_offset = 0

					break
				end

				if var_165_0 == 0 then
					arg_165_1.yaw_offset = 23
					arg_165_1.body_yaw = var_0_6("\x120\xBC\f('", "xAD\xDD")
					var_165_0 = 1
				end
			end
		end,
		[3] = function(arg_166_0, arg_166_1, arg_166_2)
			local var_166_0 = 0

			while true do
				if var_166_0 == 0 then
					arg_166_1.yaw_offset = 10
					arg_166_1.body_yaw = var_0_6("+\xA1\xE4\xA8\x11\xB6", "\xDCxՅ")
					var_166_0 = 1
				end

				if var_166_0 == 1 then
					arg_166_1.body_yaw_offset = 0

					break
				end
			end
		end
	}
}

local function var_0_121(arg_167_0)
	if entity.is_airborne(arg_167_0) then
		local var_167_0 = 0
		local var_167_1
		local var_167_2

		while true do
			if var_167_0 == 2 then
				if var_167_2 == var_0_6("{\x05\xC9Y,]", "J8N\xA70") then
					return var_0_6("\xC5\x159\x80!\x041\xE2\x19", "X\x84|K\xA0jj")
				end

				if var_167_2 == var_0_6("7\x01\x88F\v\xA5>4\x15%\x88U", "`tV\xED'{\xCAP") then
					return var_0_6("\x00\x1D\xA3=\xB8\xA9\xBA2", "\xCFAt\xD1\x1D\xE2\xCC")
				end

				var_167_0 = 3
			end

			if var_167_0 == 0 then
				var_167_1 = entity.get_player_weapon(arg_167_0)

				if var_167_1 == nil then
					return nil
				end

				var_167_0 = 1
			end

			if var_167_0 == 1 then
				local var_167_3 = 0

				while true do
					if var_167_3 == 1 then
						var_167_0 = 2

						break
					end

					if var_167_3 == 0 then
						var_167_2 = entity.get_classname(var_167_1)

						if var_167_2 == nil then
							return nil
						end

						var_167_3 = 1
					end
				end
			end

			if var_167_0 == 3 then
				local var_167_4 = 0

				while true do
					if var_167_4 == 0 then
						if entity.get_prop(arg_167_0, var_0_6("\xBDo\x8D\x02\x94E\x88\x05\x91]\x84\x1B\xBED", "n\xD00\xEB")) == 1 then
							return var_0_6("\x86\xBB\x8C\x98\xA6\xA1\x86\x89刊\x9F", "\xED\xC5\xC9\xE3")
						end

						return nil
					end
				end
			end
		end
	end

	if entity.is_crouched(arg_167_0) then
		return var_0_6("\x981\x10k\xA6;\x7F\xBF", "\x1A\xDBC\x7F\x1E\xC5S")
	end

	local var_167_5 = entity.get_prop(arg_167_0, var_0_6("\xF8'\xC8\x7F\x13\xCF\xF0\x14\xD1y\x19\xED\xEC", "\x99\x95x\xBE\x1Ap"))

	if math.sqrt(var_167_5.x^2 + var_167_5.y^2) < 5 then
		return var_0_6("?\x01ˮ.\xF9\xF0\x10", "wlu\xAA\xC0J\x90\x9E")
	end

	return nil
end

local function var_0_122(arg_168_0, arg_168_1)
	local var_168_0 = 0
	local var_168_1
	local var_168_2
	local var_168_3
	local var_168_4

	while true do
		if var_168_0 == 2 then
			if #var_168_2 < 32 then
				var_168_4 = 40
			end

			var_168_3.x = var_168_3.x + var_168_2.x * var_168_1 * var_168_4
			var_168_0 = 3
		end

		if var_168_0 == 1 then
			local var_168_5 = 0

			while true do
				if var_168_5 == 0 then
					var_168_3 = arg_168_1:clone()
					var_168_4 = 25
					var_168_5 = 1
				end

				if var_168_5 == 1 then
					var_168_0 = 2

					break
				end
			end
		end

		if var_168_0 == 3 then
			var_168_3.y = var_168_3.y + var_168_2.y * var_168_1 * var_168_4

			if entity.get_prop(arg_168_0, var_0_6("\x12lY\x87\x06\x10F_\xA41\x11GX\xB4\r", "t\x7F31\xC0")) == nil then
				var_168_3.z = var_168_3.z + var_168_2.z * var_168_1 * var_168_4 - 800 * var_168_1
			end

			var_168_0 = 4
		end

		if var_168_0 == 0 then
			var_168_1 = globals.tickinterval()
			var_168_2 = var_0_7(entity.get_prop(arg_168_0, var_0_6("\xEA\x16\x97$\xE4\x1F\x84-\xE8*\x885\xFE", "A\x87I\xE1")))
			var_168_0 = 1
		end

		if var_168_0 == 4 then
			return var_168_3
		end
	end
end

function var_0_119.update(arg_169_0, arg_169_1)
	local var_169_0 = 0
	local var_169_1
	local var_169_2
	local var_169_3
	local var_169_4
	local var_169_5
	local var_169_6
	local var_169_7
	local var_169_8
	local var_169_9
	local var_169_10

	while true do
		if var_169_0 == 5 then
			arg_169_1.freestanding_body_yaw = false

			var_169_10(arg_169_0, arg_169_1, var_169_1)

			var_0_119.is_active = true

			break
		end

		if var_169_0 == 3 then
			if not var_169_8 then
				return
			end

			local var_169_11 = var_0_120[var_169_5]

			if var_169_11 == nil then
				return
			end

			var_169_10 = var_169_11[var_169_2]

			if var_169_10 == nil then
				return
			end

			arg_169_1.pitch = var_0_6("3(V\x0F\x02!D", "nwM0")
			var_169_0 = 4
		end

		if var_169_0 == 4 then
			arg_169_1.yaw_base = var_0_6("\xCA+dA\xE5\xF98!A\xF7", "\x84\x8B_D5")
			arg_169_1.yaw = var_0_6("\xADp\xAD", "U\x9CH\x9D")
			arg_169_1.yaw_offset = 22
			arg_169_1.yaw_jitter = var_0_6("T4{", "\xEA\x1BR\x1DA\xBAH")
			arg_169_1.body_yaw = var_0_6("\xC3\xDB\xE8\xAA\n\xF3", "c\x90\xAF\x89\xDE")
			arg_169_1.body_yaw_offset = 120
			var_169_0 = 5
		end

		if var_169_0 == 2 then
			local var_169_12 = safe_head_states:get()
			local var_169_13 = false

			for iter_169_0, iter_169_1 in ipairs(var_169_12) do
				if iter_169_1 == var_169_5 then
					var_169_13 = true

					break
				end
			end

			if not var_169_13 then
				return
			end

			var_169_8 = false

			if var_169_5 == var_0_6("\xEC\xF7\xB4\x8E\x1C\xC8\xEB\xB5", "F\xAD\x9EƮ") or var_169_5 == var_0_6("\xD16]\xAE\xDB1F\xE8\xF5", "\x8E\x90_/") then
				var_169_8 = true
			else
				local var_169_14 = var_0_122(var_169_4, var_0_7(entity.hitbox_position(var_169_4, 0)))
				local var_169_15 = var_0_7(entity.hitbox_position(var_169_1, 0))

				var_169_14.z = var_169_14.z + 5

				if var_169_15.z > var_169_14.z then
					local var_169_16 = 0
					local var_169_17
					local var_169_18
					local var_169_19

					while true do
						if var_169_16 == 0 then
							var_169_17 = 0

							local var_169_20

							var_169_16 = 1
						end

						if var_169_16 == 1 then
							local var_169_21

							while true do
								if var_169_17 == 0 then
									local var_169_22, var_169_23 = client.trace_bullet(var_169_4, var_169_14.x, var_169_14.y, var_169_14.z, var_169_15.x, var_169_15.y, var_169_15.z + 6, var_169_4)

									var_169_8 = var_169_23 > 0

									break
								end
							end

							break
						end
					end
				end
			end

			var_169_0 = 3
		end

		if var_169_0 == 0 then
			var_0_119.is_active = false

			if not safe_head_enabled:get() then
				return
			end

			var_169_1 = entity.get_local_player()

			if not var_169_1 then
				return
			end

			var_169_2 = entity.get_prop(var_169_1, var_0_6("\x16?Z\xC9\xEB\x1F\x0F5\x15^", "b{`3\x9D\x8E~"))

			if var_169_2 == nil then
				return
			end

			var_169_0 = 1
		end

		if var_169_0 == 1 then
			if entity.get_player_weapon(var_169_1) == nil then
				return
			end

			var_169_4 = client.current_threat()

			if var_169_4 == nil then
				return
			end

			var_169_5 = var_0_121(var_169_1)

			if var_169_5 == nil then
				return
			end

			var_169_0 = 2
		end
	end
end

client.set_event_callback(var_0_6("Qz\x98\b8L\xBCou\x82\x065@\xA2", "\xD10\x14\xECaY%"), function(arg_170_0)
	var_0_119.update(e, arg_170_0)

	if not var_0_119.is_active and avoid_backstab_enabled:get() then
		local var_170_0 = 0
		local var_170_1

		while true do
			if var_170_0 == 0 then
				local var_170_2 = client.current_threat()

				if var_170_2 then
					local var_170_3 = entity.get_player_weapon(var_170_2)

					if var_170_3 and entity.get_classname(var_170_3):find(var_0_6("\xD7OW/G", "\"\x9C!>I")) then
						local var_170_4 = 0
						local var_170_5

						while true do
							if var_170_4 == 0 then
								local var_170_6 = entity.get_local_player()

								if var_170_6 then
									local var_170_7 = 0
									local var_170_8
									local var_170_9
									local var_170_10

									while true do
										if var_170_7 == 1 then
											if var_170_8:dist2d(var_170_9) < 230 then
												local var_170_11 = 0

												while true do
													if var_170_11 == 0 then
														if arg_170_0.yaw_offset == nil then
															arg_170_0.yaw_offset = 0
														end

														arg_170_0.yaw_offset = arg_170_0.yaw_offset + 180

														break
													end
												end
											end

											break
										end

										if var_170_7 == 0 then
											var_170_8 = var_0_7(entity.get_origin(var_170_6))
											var_170_9 = var_0_7(entity.get_origin(var_170_2))
											var_170_7 = 1
										end
									end
								end

								break
							end
						end
					end
				end

				break
			end
		end
	end
end)

local var_0_123 = false
local var_0_124 = {}

local function var_0_125(arg_171_0)
	return math.floor(arg_171_0 / globals.tickinterval() + 0.5)
end

local function var_0_126(arg_172_0)
	local var_172_0 = 0
	local var_172_1

	while true do
		if var_172_0 == 0 then
			local var_172_2 = var_0_7(entity.get_prop(arg_172_0, var_0_6("\x05M\xF8T\vD\xEB]\aq\xE7E\x11", "1h\x12\x8E")))

			return math.sqrt(var_172_2.x^2 + var_172_2.y^2)
		end
	end
end

local function var_0_127()
	if not prediction_enabled:get() or not var_0_123 then
		return
	end

	local var_173_0 = entity.get_local_player()

	if not var_173_0 or not entity.is_alive(var_173_0) then
		return
	end

	local var_173_1 = client.current_threat()

	if not var_173_1 or not entity.is_alive(var_173_1) or entity.is_dormant(var_173_1) then
		return
	end

	local var_173_2, var_173_3, var_173_4 = entity.get_prop(var_173_1, var_0_6("\xFC\xDAj\x0E\xF2\xCAn\x02\xF6\xECr", "k\x91\x85\x1C"))

	if not var_173_2 or not var_173_3 or not var_173_4 then
		return
	end

	if var_0_126(var_173_1) < prediction_min_velocity:get() then
		return
	end

	local var_173_5 = var_0_7(entity.get_prop(var_173_1, var_0_6("\xCFa\xA5\xBB\xC1h\xB6\xB2\xCD]\xBA\xAA\xDB", "ޢ>\xD3")))
	local var_173_6 = prediction_ticks:get()
	local var_173_7 = globals.tickinterval()
	local var_173_8 = var_173_2
	local var_173_9 = var_173_3
	local var_173_10 = var_173_4
	local var_173_11 = var_0_124[var_173_1] and var_0_124[var_173_1].velocity
	local var_173_12 = var_0_7(0, 0, 0)

	if var_173_11 and prediction_acceleration:get() then
		local var_173_13 = 0

		while true do
			if var_173_13 == 0 then
				var_173_12.x = (var_173_5.x - var_173_11.x) / var_173_7
				var_173_12.y = (var_173_5.y - var_173_11.y) / var_173_7
				var_173_13 = 1
			end

			if var_173_13 == 1 then
				var_173_12.z = (var_173_5.z - var_173_11.z) / var_173_7

				break
			end
		end
	end

	for iter_173_0 = 1, var_173_6 do
		local var_173_14 = 0
		local var_173_15

		while true do
			if var_173_14 == 0 then
				local var_173_16 = iter_173_0 * var_173_7

				if prediction_acceleration:get() then
					var_173_8 = var_173_8 + var_173_5.x * var_173_7 + 0.5 * var_173_12.x * var_173_16^2
					var_173_9 = var_173_9 + var_173_5.y * var_173_7 + 0.5 * var_173_12.y * var_173_16^2
					var_173_10 = var_173_10 + var_173_5.z * var_173_7 + 0.5 * var_173_12.z * var_173_16^2

					break
				end

				local var_173_17 = 0

				while true do
					if var_173_17 == 0 then
						var_173_8 = var_173_8 + var_173_5.x * var_173_7
						var_173_9 = var_173_9 + var_173_5.y * var_173_7
						var_173_17 = 1
					end

					if var_173_17 == 1 then
						var_173_10 = var_173_10 + var_173_5.z * var_173_7

						break
					end
				end

				break
			end
		end
	end

	local var_173_18 = globals.framecount()
	local var_173_19 = prediction_smoothing:get() / 100 / var_173_18
	local var_173_20 = var_0_7(var_173_2, var_173_3, var_173_4)

	var_173_20.x = var_173_20.x + (var_173_8 - var_173_20.x) * var_173_19
	var_173_20.y = var_173_20.y + (var_173_9 - var_173_20.y) * var_173_19
	var_173_20.z = var_173_20.z + (var_173_10 - var_173_20.z) * var_173_19

	if not var_0_124[var_173_1] then
		var_0_124[var_173_1] = {}
	end

	var_0_124[var_173_1].velocity = var_173_5

	if prediction_visualize:get() then
		local var_173_21 = 0
		local var_173_22
		local var_173_23
		local var_173_24
		local var_173_25
		local var_173_26
		local var_173_27
		local var_173_28
		local var_173_29

		while true do
			if var_173_21 == 1 then
				local var_173_30, var_173_31 = renderer.world_to_screen(var_173_20.x, var_173_20.y, var_173_20.z)

				if var_173_26 and var_173_27 and var_173_30 and var_173_31 then
					renderer.line(var_173_26, var_173_27, var_173_30, var_173_31, var_173_22, var_173_23, var_173_24, var_173_25)
					renderer.circle_outline(var_173_30, var_173_31, var_173_22, var_173_23, var_173_24, var_173_25, 8, 0, 1, 2)

					local var_173_32, var_173_33 = renderer.world_to_screen(var_173_2 + var_173_5.x * 0.09999999999990905, var_173_3 + var_173_5.y * 0.1, var_173_4)

					if var_173_32 and var_173_33 then
						renderer.line(var_173_26, var_173_27, var_173_32, var_173_33, 0, 255, 0, 150)
					end
				end

				break
			end

			if var_173_21 == 0 then
				var_173_22, var_173_23, var_173_24, var_173_25 = 255, 0, 0, 200
				var_173_26, var_173_27 = renderer.world_to_screen(var_173_2, var_173_3, var_173_4)
				var_173_21 = 1
			end
		end
	end
end

local var_0_128 = {
	get_animstate = function(arg_174_0)
		if not arg_174_0 or not entity.is_alive(arg_174_0) then
			return nil
		end

		if not entity.get_prop(arg_174_0, var_0_6("\xAEN\b\x17\x10\x8DîE\a\x164", "\xAA\xC3\x11n{Q\xE3")) then
			return nil
		end

		return {
			[var_0_6("\xB1-\xE5\xFF\xFC\xBA3\xEC\xC5\xEE\x8B-", "\x9D\xD4T\x80\xA0")] = select(2, entity.get_prop(arg_174_0, var_0_6("\x84L\xE1K!\xAD\xF7ƨ}\xE7I#\x9B", "\xA3\xE9\x13\x80%F\xE8\x8E"))),
			[var_0_6("\xE6L9&\xE2[;\x15\xE6F\x03\x01", "y\x835\\")] = select(1, entity.get_prop(arg_174_0, var_0_6("s\xF3J\x8Ey\xE9R\x85_\xC2L\x8C{\xDF", "\xE0\x1E\xAC+"))),
			[var_0_6("\x02\xA8~\xD2\xD2\x03\xA2z\xCA\xD2\x1C\xA6h", "\x8De\xC7\x1F\xBE")] = entity.get_prop(arg_174_0, var_0_6("Vx\x05\xCB\xF6\xB6\xB8^U!\xC8ޠ\x96ZP7\xC6Ⱦ\xAAO", "\xCF;'c\xA7\xBA\xD9")),
			[var_0_6("\x04S\xA9@M\xF3\xB4\xD4\x01C\xBEFw\xE4\xA1\xFC", "\x8Bg&\xDB2(\x9D\xC0")] = entity.get_prop(arg_174_0, var_0_6("\xEB\x870\xCEʷ!\xC7\xF4\x9A9\xC6\xFF\x817\xD5ҹ$\xC5\xE3\xAC", "\xA2\x86\xD8V")),
			[var_0_6("*\xE0EJ?}\xE8\xAE)", "\xCF^\x8F79P\"\x91")] = entity.get_prop(arg_174_0, var_0_6("/\xEE%v\x9CT\x00\xBC0\xF3,~\xA9b\x16\xAE\x16\xD01}\xB5O", "\xD9B\xB1C\x1A\xD0;w")),
			[var_0_6("/\xDBˤo\xEB\xF5,\xCBľ", "\x98C\xBE\xAA\xCA0\x8A")] = 0,
			[var_0_6("\xDF<V\xFB\xE4(X\xFF\xCE'A", "\x90\xBBI5")] = entity.get_prop(arg_174_0, var_0_6("\x1B\x84<ۆ\xA6\x15\xB0\x1Bڭ\xA6\x18\xAF", "\xD3v\xDBZ\xB7\xC2")) or 0,
			[var_0_6("\xF7\xA3\xB7\xECH\xFE\xED\xA3\x8C", "\x91\x98\xCD\xE8\x8B:")] = bit.band(entity.get_prop(arg_174_0, var_0_6("\xBE͸\x99W\xA9\t\xA0", "nӒ\xDE\xDF;\xC8")), 1) == 1,
			[var_0_6("EQ\xEE\x00AZ@\xFB0Z", "\"34\x82o")] = select(1, entity.get_prop(arg_174_0, var_0_6("\xC3\n.\xC6\x01\nR\xC2:;\xCA\x16%", "7\xAEUX\xA3b\\"))),
			[var_0_6("\xDBM\n\x8A5\xC4\\\x1F\xBA/", "V\xAD(f\xE5")] = select(2, entity.get_prop(arg_174_0, var_0_6("\t\x9BY\x88\a\x92J\x81\v\xA7F\x99\x1D", "\xEDd\xC4/")))
		}
	end,
	get_max_desync = function(arg_175_0)
		if not arg_175_0 then
			return 58
		end

		local var_175_0 = 58

		if arg_175_0.duck_amount and arg_175_0.duck_amount > 0.1 then
			var_175_0 = var_175_0 * 0.8
		end

		if arg_175_0.on_ground then
			if math.sqrt(arg_175_0.velocity_x^2 + arg_175_0.velocity_y^2) > 100 then
				var_175_0 = var_175_0 * 1.2
			end
		else
			var_175_0 = var_175_0 * 0.6000000000000227
		end

		return math.min(var_175_0, 60)
	end
}

local function var_0_129()
	if not resolver_enabled:get() or not var_0_123 then
		return
	end

	if not entity.is_alive(entity.get_local_player()) then
		return
	end

	client.update_player_list()

	for iter_176_0, iter_176_1 in pairs(entity.get_players(true)) do
		local var_176_0 = entity.get_prop(iter_176_1, var_0_6("As\x8D\xA6\x04\x81\x19Y@\x8A\xBE>\x87\x1AxE\x86\xAF", "t,,\xEB\xCAW\xE8"))
		local var_176_1 = entity.get_prop(iter_176_1, var_0_6("\x0E\xE8P)-\xBE\xF60\xDE[0\x0E\xB3\xE6\n\xD8X\x11\v\xBF\xF7", "\x92c\xB76Eb\xD2"))

		if not var_176_0 or not var_176_1 then
			return
		end

		local var_176_2, var_176_3 = var_0_125(var_176_0), var_0_125(var_176_1)

		var_0_124[iter_176_1] = var_0_124[iter_176_1] or {}

		local var_176_4 = var_0_128.get_animstate(iter_176_1)
		local var_176_5 = var_0_128.get_max_desync(var_176_4)

		var_0_124[iter_176_1][var_176_2] = {
			[var_0_6("\xE2\xE6\xB0", "ׇ\x9F\xD5\xC5\\")] = select(2, entity.get_prop(iter_176_1, var_0_6("\xBE\x9A\xE9ⴀ\xF1钫\xEFබ", "\x8C\xD3ň"))),
			[var_0_6("<\xCE%", "\xACP\xAC\\\x14")] = entity.get_prop(iter_176_1, var_0_6("\x13E\xD7\x14\\\xC6ԍ\fX\xDE\x1Ci\xF0\xC2\x9F*{\xC3\x1Fu\xDD", "\xE8~\x1A\xB1x\x10\xA9\xA3")),
			[var_0_6("\xE8\xE3\xA2jL\xCC", "֌\x86\xD1\x13\"\xAF")] = var_176_5,
			[var_0_6("U)\xA1\xA7G3\xA9\xBEQ", "\xCA4G\xC8")] = var_176_4,
			[var_0_6("\xF8My\x88\xEDAa\x9E", "\xE7\x8E(\x15")] = var_0_7(entity.get_prop(iter_176_1, var_0_6("}\r\xD3\x0FQ5\xD1|=\xC6\x03F\x1A", "\xB4\x10R\xA5j2c"))),
			[var_0_6("0Gv\xF9\n1", "c_5\x1F\x9E")] = var_0_7(entity.get_prop(iter_176_1, var_0_6("\xFF\x15fT\xF1\x05bX\xF5#~", "1\x92J\x10")))
		}

		if var_0_124[iter_176_1][var_176_3] and var_0_124[iter_176_1][var_176_2] then
			local var_176_6 = 0
			local var_176_7
			local var_176_8
			local var_176_9
			local var_176_10
			local var_176_11

			while true do
				if var_176_6 == 4 then
					if resolver_correction_active:get() then
						local var_176_12 = pcall(function()
							plist.set(iter_176_1, var_0_6("\xE0\x192C\x87\xC0\x02)^\x8C\x83\x17#E\x8B\xD5\x13", "\xE2\xA3v@1"), true)
						end)
					end

					break
				end

				if var_176_6 == 3 then
					if var_176_7.velocity and var_176_8.velocity and var_176_7.velocity:dist2d(var_176_8.velocity) > 50 then
						var_176_11 = var_176_11 + math.atan2(var_176_7.velocity.y, var_176_7.velocity.x) * 0.1
					end

					if resolver_force_body_yaw:get() then
						local var_176_13 = pcall(function()
							local var_178_0 = 0

							while true do
								if var_178_0 == 0 then
									plist.set(iter_176_1, var_0_6("\xC2^\x98Y\x87\xA4S\x85^\x9B\xA4H\x8BM", "\xE2\x841\xEA:"), var_176_11)
									plist.set(iter_176_1, var_0_6("\xFCw\xA2\xE7\x1F\xB9\x10W\xDEa\xF0\xFD\x1B\xEERN\xDBt\xA5\xE1", "8\xBA\x18Єz\x99r"), var_176_11)

									break
								end
							end
						end)
					end

					var_176_6 = 4
				end

				if var_176_6 == 1 then
					var_176_9 = var_176_7.desync
					var_176_10 = var_176_7.eye
					var_176_6 = 2
				end

				if var_176_6 == 2 then
					local var_176_14 = 0

					while true do
						if var_176_14 == 1 then
							var_176_6 = 3

							break
						end

						if var_176_14 == 0 then
							var_176_11 = var_176_10 + var_176_9

							if var_176_9 < math.abs(var_176_11 - var_176_8.eye) then
								var_176_11 = var_176_10 - var_176_9
							end

							var_176_14 = 1
						end
					end
				end

				if var_176_6 == 0 then
					var_176_7 = var_0_124[iter_176_1][var_176_2]
					var_176_8 = var_0_124[iter_176_1][var_176_3]
					var_176_6 = 1
				end
			end
		end
	end
end

client.set_event_callback(var_0_6("\xF7\xC9+\x81\b\xE9\xC8>\xAA\x18\xC6\xC91\xBA", "}\x99\xAC_\xDE"), function()
	if resolver_enabled:get() and var_0_123 then
		var_0_129()
	end
end)
client.set_event_callback(var_0_6("k\xC7\xEA\xC3\xF9", "\x83\x1B\xA6\x83\xAD\x8D\xBA"), function()
	if prediction_enabled:get() and var_0_123 then
		var_0_127()
	end
end)

local var_0_130
local var_0_131 = 0
local var_0_132
local var_0_133
local var_0_134
local var_0_135
local var_0_136
local var_0_137
local var_0_138
local var_0_139

while true do
	if var_0_131 == 2 then
		local var_0_140

		local function var_0_141(arg_181_0)
			var_0_137 = arg_181_0.command_number
		end

		client.set_event_callback(var_0_6("\xB0L\tx\xA1V\nJ\xA3W\x03", "'\xC29g"), var_0_141)

		var_0_131 = 3
	end

	if var_0_131 == 1 then
		var_0_135 = var_0_11.typeof(var_0_6("(\x05\xB5\x89\xB5t@", "\x9F^j\xDC\xED"))
		var_0_136 = var_0_11.typeof(var_0_6("\xBE\x0E\x16V\xAE\x0EDX\xED\x19\fB\xBFZ\x14B\xA9J?\x13\xB5K\\~\xF6Z\x11J\xA3\x0EW\x11\x92\x0EDP\xA8\v\x11F\xA3\x19\x01\x18\xED\x1C\bL\xAC\x0EDS\xBF\x1F\x12|\xAE\x03\aO\xA8VDT\xA8\x13\x03K\xB9VDT\xA8\x13\x03K\xB9%\x00F\xA1\x0E\x05|\xBF\x1B\x10F\xE1Z\x14O\xAC\x03\x06B\xAE\x11;Q\xAC\x0E\x01\x0F\xED\x19\x1D@\xA1\x1F_\x03\xBB\x15\rG\xEDP\x01M\xB9\x13\x10Z\xF6Z\aK\xAC\bDS\xAC\x1EUx\xFD\x02P~\xF6Z\x19\x03\xE7P", "#\xCDzd"))
		var_0_137 = 0
		var_0_131 = 2
	end

	if var_0_131 == 3 then
		local var_0_142

		local function var_0_143()
			if not animation_breaker_enable:get() then
				return
			end

			local var_182_0 = entity.get_local_player()

			if not var_182_0 or not entity.is_alive(var_182_0) then
				return
			end

			local var_182_1 = var_0_11.cast(var_0_135, var_0_132(var_182_0))

			if var_182_1 == var_0_134 then
				return
			end

			local var_182_2, var_182_3 = entity.get_prop(var_182_0, var_0_6("\xAF\xC4*T\x05\x9Aˮ\xF4?X\x12\xB5", "\xAE\xC2\x9B\\1f\xCC"))
			local var_182_4 = math.floor(math.sqrt(var_182_2^2 + var_182_3^2))
			local var_182_5 = entity.get_prop(var_182_0, var_0_6("ɷ_Q\x8B\xCB\xE9\xD7", "\x8E\xA4\xE89\x17\xE7\xAA"))
			local var_182_6 = bit.band(var_182_5, 1) == 1
			local var_182_7 = var_0_11.cast(var_0_136, var_0_11.cast(var_0_133, var_182_1) + 10640)[0]
			local var_182_8 = false
			local var_182_9 = false
			local var_182_10 = false
			local var_182_11 = false
			local var_182_12 = 0

			if var_182_6 and var_182_4 > 5 then
				var_182_8 = animation_breaker_running_type:get()
				var_182_10 = animation_breaker_running_min_jitter:get() * 0.01
				var_182_11 = animation_breaker_running_max_jitter:get() * 0.009999999999990905
				var_182_12 = animation_breaker_running_bodylean:get()
				var_182_9 = animation_breaker_running_extra:get(var_0_6("\x95\xA5\xD8\xE4R\xBB\xAF\xDD\xF3", "r\xD7ʼ\x9D"))
			elseif not var_182_6 then
				local var_182_13 = 0
				local var_182_14

				while true do
					if var_182_13 == 0 then
						local var_182_15 = 0

						while true do
							if var_182_15 == 0 then
								var_182_8 = animation_breaker_air_type:get()
								var_182_10 = animation_breaker_air_min_jitter:get() * 0.01
								var_182_15 = 1
							end

							if var_182_15 == 2 then
								var_182_9 = animation_breaker_air_extra:get(var_0_6("\x13\xAA\xF6I\xF2\x8F\xEE\x84?", "\xE5QŒ0\xD2\xE3\x8B"))

								break
							end

							if var_182_15 == 1 then
								var_182_11 = animation_breaker_air_max_jitter:get() * 0.01
								var_182_12 = animation_breaker_air_bodylean:get()
								var_182_15 = 2
							end
						end

						break
					end
				end
			end

			local var_182_16 = globals.realtime() / 2 % 1

			if var_182_8 == var_0_6("\xA3^W{\xDB", "6\xE22;\x1A\xB3\x9B=") then
				local var_182_17 = 0

				while true do
					if var_182_17 == 1 then
						ui.set(var_0_39.other.leg_movement, var_0_6("\xEF\xC1\xB2", "ƀ\xA7Ԣ\xD8]\x99"))

						break
					end

					if var_182_17 == 0 then
						entity.set_prop(var_182_0, var_0_6("\xC7\x01>T/\xC5-=h\x1E\xD8?5]\v\xCF,", "\x7F\xAA^X8"), 1, var_182_6 and var_182_4 > 5 and 7 or 6)

						if not var_182_6 then
							var_182_7[6].weight, var_182_7[6].cycle = 1, var_182_16
						end

						var_182_17 = 1
					end
				end
			elseif var_182_8 == var_0_6("\x99.\xE5ʣ9", "\xBE\xCAZ\x84") then
				local var_182_18 = 0

				while true do
					if var_182_18 == 0 then
						entity.set_prop(var_182_0, var_0_6("\x8A\xE6uے)\x94\xDCCְ'\x8A\xDCgҰ", "F\xE7\xB9\x13\xB7\xC2"), 1, var_182_6 and var_182_4 > 5 and 0 or 6)
						ui.set(var_0_39.other.leg_movement, var_0_6("\xDA\xCC\xF3\xA5\xAAȀ\xF7\xA8\xBA\xDF\xC5", "ӻ\xA0\x84\xC4"))

						break
					end
				end
			elseif var_182_8 == var_0_6("\x06\x89\xFB\xE9M\xAE", "\x92L\xE0\x8F\x9D(\xDC") then
				local var_182_19 = 0

				while true do
					if var_182_19 == 0 then
						entity.set_prop(var_182_0, var_0_6("V@\xB0~\x966\xED^O\xB7`\xA74\xFBOz\xA4", "\x9E;\x1F\xD6\x12\xC6Y"), client.random_float(var_182_10, var_182_11), var_182_6 and var_182_4 > 5 and 7 or 6)
						ui.set(var_0_39.other.leg_movement, var_0_6("S\fQ\x0FOIT\x06T\rB", "j=i'"))

						break
					end
				end
			elseif animation_breaker_running_type:get() == var_0_6("Ĳ/\xEA\x11\xCCs\xF1\xB7-\xEAC\xC8{\xF1\xAA>\xFD", "\x12\x85\xDE[\x8Fc\xA2") then
				local var_182_20 = 0

				while true do
					if var_182_20 == 1 then
						if var_182_6 and var_182_4 < 0 then
							entity.set_prop(var_182_0, var_0_6("\xC1D\xE9\xD9BD\xDF~\xDF\xD4`J\xC1~\xFB\xD0`", "+\xAC\x1B\x8F\xB5\x12"), client.random_float(0.4, 0.8), 7)
						end

						break
					end

					if var_182_20 == 0 then
						ui.set(var_0_39.other.leg_movement, var_0_137 % 3 == 0 and var_0_6("x9\xAA", "\xB2\x17_\xCC>\xB9\\#") or var_0_6(" \xFA\xC8\xF7D2\xB6\xCC\xFAT%\xF3", "=A\x96\xBF\x96"))
						entity.set_prop(var_182_0, var_0_6("Gꏵ\xE7\x0E\xD9O别\xD6\f\xCF^Л", "\xAA*\xB5\xE9ٷa"), 1, globals.tickcount() % 4 > 1 and 0.5 or 1)

						var_182_20 = 1
					end
				end
			else
				ui.set(var_0_39.other.leg_movement, var_0_6("\xDC/\xA1", "\x1D\xB3I\xC7\xD9"))
			end

			if var_182_9 then
				var_182_7[12].weight = var_182_12 / 100
			end

			if animation_breaker_air_extra:get(var_0_6("C\xA4o\xC29\xB1t\xD9z\xA9=\xC2w\xE1q\xCCw\xA5t\xC3~", "\xAD\x19\xC1\x1D")) then
				local var_182_21 = 0
				local var_182_22

				while true do
					if var_182_21 == 0 then
						local var_182_23 = var_0_18.animstate:get(var_182_0)

						if var_182_23 and var_182_23.hit_in_ground_animation and var_182_6 then
							entity.set_prop(var_182_0, var_0_6("WOQ\x13\x9D\x05\xC5}jqE\x1E\xA0\x0F\xC2}H", "\x18:\x107\x7F\xCDj\xB6"), 0.5, 12)
						end

						break
					end
				end
			end
		end

		client.set_event_callback(var_0_6("\xB7\x15\xD2f2\xA2\t\xD3\\2", "@\xC7g\xB79"), var_0_143)

		break
	end

	if var_0_131 == 0 then
		var_0_132 = var_0_14(var_0_6("\xF0\x7FN\"\xFDg\t#\xFF\x7F", "G\x93\x13'"), var_0_6("3\x19ꤶ\xE4\xEE\a\v.﹪\xC6\xF31\x11j\xB6\xFE", "BeZ\x86\xCDӊ\x9A"), 3, var_0_6("\nCp\xA8\xCFo#sm\xA4\x8C4\x1FMu\xA0\xCFnTZv\xA5\x81mP\fp\xA2\x91n", "G|,\x19\xCC\xE5"))
		var_0_133 = var_0_11.typeof(var_0_6("\x11\xF2(V\x88", "\xD9r\x9AI$\xA2"))
		var_0_134 = var_0_11.new(var_0_6("*\xAA\xB3\xA9K", "`\\\xC5\xDA\xCDa\xE8"))
		var_0_131 = 1
	end
end

local function var_0_144(arg_183_0)
	local var_183_0 = 0
	local var_183_1
	local var_183_2
	local var_183_3
	local var_183_4
	local var_183_5
	local var_183_6

	while true do
		if var_183_0 == 2 then
			if var_183_5 == nil then
				return
			end

			if var_183_6 ~= nil and var_183_6 ~= 0 then
				return
			end

			if arg_183_0.forwardmove > 0 and arg_183_0.pitch < 45 then
				local var_183_7 = 0

				while true do
					if var_183_7 == 1 then
						arg_183_0.in_moveleft = 0
						arg_183_0.in_forward = 0
						var_183_7 = 2
					end

					if var_183_7 == 3 then
						arg_183_0.sidemove = 250

						break
					end

					if var_183_7 == 2 then
						arg_183_0.in_back = 1

						if arg_183_0.sidemove == 0 then
							arg_183_0.yaw = arg_183_0.yaw + 64 + 26
						end

						var_183_7 = 3
					end

					if var_183_7 == 0 then
						arg_183_0.pitch = 89
						arg_183_0.in_moveright = 1
						var_183_7 = 1
					end
				end
			end

			break
		end

		if var_183_0 == 0 then
			if not fast_ladder_enable:get() then
				return
			end

			var_183_1 = entity.get_local_player()

			if not var_183_1 or not entity.is_alive(var_183_1) then
				return
			end

			local var_183_8, var_183_9 = client.camera_angles()

			var_183_0 = 1
		end

		if var_183_0 == 1 then
			local var_183_10 = entity.get_prop(var_183_1, var_0_6(")p~V\xE5!{JI\xF6", "\x93D/39"))

			var_183_5 = entity.get_player_weapon(var_183_1)
			var_183_6 = entity.get_prop(var_183_5, var_0_6("\x84p\x1A\b\x8ER\x86X(5\x8BE", " \xE9/|\\\xE6"))

			if var_183_10 ~= 9 then
				return
			end

			var_183_0 = 2
		end
	end
end

client.set_event_callback(var_0_6("\x98D\x96\xAE\xAC\xF1\xFA\x84L\x8F\xBA\xB2\xCA", "\x99\xEB!\xE2\xDBܮ"), var_0_144)
client.set_event_callback(var_0_6("\x92UN\x06\x85RL\x1C", "r\xE1=;"), function()
	database.write(var_0_6("\xD9k%\x80\xCC\x7F!\xC0\x8D", "\xED\xBC\x13D"), var_0_113)
end)
