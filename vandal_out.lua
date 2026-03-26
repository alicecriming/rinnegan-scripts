--discord.gg/BwbY7ZbY


username = "monstry"
build = "Beta"
update_date = "never"

if not LPH_OBFUSCATED then
	LPH_NO_VIRTUALIZE = function (...)
		return ...
	end
end

---я там дохуя коментариев написал, мне скучно просто было и я по приколу накалякал

LPH_NO_VIRTUALIZE(function()

---@references
	ref = {
		enabled = ui.reference("AA", "Anti-Aimbot angles", "Enabled"),
		pitch     = {
			ui.reference("AA", "Anti-Aimbot angles", "Pitch")
		},
		yaw_base  = ui.reference("AA", "Anti-Aimbot angles", "Yaw base"),
		yaw       = {
			ui.reference("AA", "Anti-Aimbot angles", "Yaw")
		},
		yaw_jitter = {
			ui.reference("AA", "Anti-Aimbot angles", "Yaw jitter")
		},
		body_yaw  = {
			ui.reference("AA", "Anti-Aimbot angles", "Body yaw")
		},
		freestanding_body_yaw = ui.reference("AA", "Anti-Aimbot angles", "Freestanding body yaw"),
		edge_yaw  = ui.reference("AA", "Anti-Aimbot angles", "Edge yaw"),
		freestand = {
			ui.reference("AA", "Anti-Aimbot angles", "Freestanding")
		},
		roll      = ui.reference("AA", "Anti-Aimbot angles", "Roll"),
		slow_walk = {
			ui.reference("AA", "Other", "Slow motion")
		},
		dt        = {
			ui.reference("RAGE", "Aimbot", "Double Tap")
		},
		hs        = {
			ui.reference("AA", "Other", "On shot anti-aim")
		},
		fd        = ui.reference("RAGE", "Other", "Duck peek assist"),
		min_damage = ui.reference("RAGE", "Aimbot", "Minimum damage"),
		min_damage_override = {
			ui.reference("RAGE", "Aimbot", "Minimum damage override")
		},
		rage_cb   = {
			ui.reference("RAGE", "Aimbot", "Enabled")
		},
		menu_color = ui.reference("MISC", "Settings", "Menu color"),
		clantag = ui.reference("MISC", "Miscellaneous", "Clan tag spammer"),
		falelag_enabled = {
			ui.reference("AA", "Fake lag", "Enabled")
		},
		fakelag_limit = ui.reference("AA", "Fake lag", "Limit"),
		variability   = ui.reference("AA", "Fake lag", "Variance"),
		fakelag_amount = ui.reference("AA", "Fake lag", "Amount"),
		aimbot        = ui.reference("RAGE", "Aimbot", "Enabled"),
		scope_overlay = ui.reference("VISUALS", "Effects", "Remove scope overlay"),
		body = ui.reference("RAGE", "Aimbot", "Force Body aim"),
		dt_fakelag = ui.reference("RAGE", "Aimbot", "Double tap fake lag limit"),
		autostop = {
			ui.reference("RAGE", "Aimbot", "Quick stop")
		},
		zoom = ui.reference("MISC", "Miscellaneous", "Override zoom FOV"),
		fov = ui.reference("MISC", "Miscellaneous", "Override FOV")
	}
---@end

---@libs
	vector = require 'vector'
	ffi = require 'ffi'
	weapons = require 'gamesense/csgo_weapons'
	clipboard = require 'gamesense/clipboard'
	json = require 'json'
	base64 = require 'gamesense/base64'
	c_entity = require 'gamesense/entity'

---@end

---@sdk
	local L_1_ = {
		get_lp = function()
			return entity.get_local_player()
		end,
		is_alive = function(L_194_arg0)
			return entity.is_alive(L_194_arg0)
		end,
		get_velocity = function(L_195_arg0)
			return math.max(0, math.floor(vector(entity.get_prop(L_195_arg0, "m_vecAbsVelocity")):length2d()) - 1)
		end,
		isScoped = function(L_196_arg0)
			return entity.get_prop(L_196_arg0, "m_bIsScoped") == 1
		end
	}
	local L_2_ = {
		shifting = 0,
		_shifting_enough = nil,
		choked = 0,
	}
	L_2_.get_dt = function()
		return L_2_._shifting_enough
	end
	L_2_.run_command = function(L_197_arg0)
		local L_198_ = L_1_.get_lp()
		if L_198_ then
			local L_199_ = entity.get_prop(L_198_, 'm_nTickBase')
			local L_200_ = client.latency()
			local L_201_ = math.floor(L_199_ - globals.tickcount() - 3 - toticks(L_200_) * 0.88 * (L_200_ * 10))
			if math.abs(L_201_ - (-1)) < math.abs(L_201_ - (-15)) then
				L_201_ = -1
			else
				L_201_ = -15
			end
			local L_202_ = -14 + (ui.get(ref.dt_fakelag) - 1) + 3
			L_2_.shifting = L_201_
			L_2_._shifting_enough = L_201_ <= L_202_
		end
	end

---@end

---@helpful functions
	local L_3_ = {}
	local function L_4_func(L_203_arg0)
		local L_204_ = L_1_.get_lp()
		if not L_204_ or not L_1_.is_alive(L_204_) then
			return
		end
		local L_205_, L_206_ = client.screen_size()
		local L_207_
		local L_208_
		if L_203_arg0 == "Right Upper" then
			L_207_ = L_205_ - 200
			L_208_ = 13
		elseif L_203_arg0 == "Right Center" then
			L_207_ = L_205_ - 10
			L_208_ = (L_206_ / 2)
		end
		local L_209_ = 0
		for L_210_forvar0, L_211_forvar1 in ipairs(L_3_) do
			if L_211_forvar1.active then
				local L_212_ = L_211_forvar1.text
				if L_211_forvar1.value then
					L_212_ = L_212_ .. " - > " .. tostring(L_211_forvar1.value)
				end
				renderer.text(
                L_207_,
                L_208_ + (L_209_ * 15),
                255, 255, 255, 255,
                "r",
                0,  
                L_212_
            )
				L_209_ = L_209_ + 1
			end
		end
	end
	function change_debug(L_213_arg0, L_214_arg1, L_215_arg2)
		if L_213_arg0 == "add" then
			for L_216_forvar0, L_217_forvar1 in ipairs(L_3_) do
				if L_217_forvar1.text == L_214_arg1 then
					if L_215_arg2 ~= nil then
						if type(L_215_arg2) == "boolean" then
							L_3_[L_216_forvar0].active = L_215_arg2
						else
							L_3_[L_216_forvar0].value = L_215_arg2
						end
					end
					return
				end
			end
			table.insert(L_3_, {
				text = L_214_arg1,
				active = true,
				value = type(L_215_arg2) ~= "boolean" and L_215_arg2 or nil
			})
		elseif L_213_arg0 == "remove" then
			table.remove(L_3_, #L_3_)
		elseif L_213_arg0 == "clear" then
			L_3_ = {}
		elseif L_213_arg0 == "set_active" then
			for L_218_forvar0, L_219_forvar1 in ipairs(L_3_) do
				if L_219_forvar1.text == L_214_arg1 then
					L_3_[L_218_forvar0].active = L_215_arg2
					break
				end
			end
		elseif L_213_arg0 == "set_value" then
			for L_220_forvar0, L_221_forvar1 in ipairs(L_3_) do
				if L_221_forvar1.text == L_214_arg1 then
					L_3_[L_220_forvar0].value = L_215_arg2
					break
				end
			end
		end
	end
	function height_advantaged(L_222_arg0)
		local L_223_ = entity.get_local_player()
		if not L_223_ or not entity.is_alive(L_223_) then
			return false
		end
		if not entity.is_enemy(L_222_arg0) or not entity.is_alive(L_222_arg0) then
			return false
		end
		local L_224_ = {
			entity.get_origin(L_223_)
		}
		local L_225_ = {
			entity.get_origin(L_222_arg0)
		}
		if not L_224_[3] or not L_225_[3] then
			return false
		end
		local L_226_ = L_224_[3] - L_225_[3]
		local L_227_ = 125
		return L_226_ >= L_227_
	end
	aspect_ratio_table = {}
	clamp = function(L_228_arg0, L_229_arg1, L_230_arg2)
		return math.max(L_229_arg1, math.min(L_230_arg2, L_228_arg0))
	end
	function ease_in_out_quad(L_231_arg0)
		return L_231_arg0 < 0.5 and (2 * L_231_arg0 * L_231_arg0) or (-1 + (4 - 2 * L_231_arg0) * L_231_arg0)
	end
	function gradient_text(L_232_arg0, L_233_arg1, L_234_arg2, L_235_arg3)
		local L_236_ = globals.realtime() * L_235_arg3
		local L_237_ = ""
		local L_238_ = #L_234_arg2
		local L_239_ = - 0.5 * (1 - math.cos(L_236_))
		for L_240_forvar0 = 1, L_238_ do
			local L_241_ = L_240_forvar0
			local L_242_ = L_234_arg2:sub(L_240_forvar0, L_240_forvar0)
			local L_243_ = (math.sin(L_236_ + (L_241_ / L_238_) * math.pi) + 1) / 2
			local L_244_ = math.floor(L_232_arg0[1] * L_243_ + L_233_arg1[1] * (1 - L_243_))
			local L_245_ = math.floor(L_232_arg0[2] * L_243_ + L_233_arg1[2] * (1 - L_243_))
			local L_246_ = math.floor(L_232_arg0[3] * L_243_ + L_233_arg1[3] * (1 - L_243_))
			L_237_ = L_237_ .. string.format("\a%02X%02X%02XFF%s", L_244_, L_245_, L_246_, L_242_)
		end
		return L_237_
	end
	function gradient_text_lower(L_247_arg0, L_248_arg1, L_249_arg2, L_250_arg3)
		local L_251_ = globals.realtime() * L_250_arg3
		local L_252_ = ""
		local L_253_ = #L_249_arg2
		for L_254_forvar0 = 1, L_253_ do
			local L_255_ = L_249_arg2:sub(L_254_forvar0, L_254_forvar0)
			local L_256_ = (math.sin(L_251_ + (L_254_forvar0 / L_253_) * math.pi) + 1) / 2
			local L_257_ = L_256_ * 1.3
			local L_258_ = (1 - L_256_) * 0.3
			local L_259_ = L_257_ + L_258_
			L_257_ = L_257_ / L_259_
			L_258_ = L_258_ / L_259_
			local L_260_ = math.floor(L_247_arg0[1] * L_257_ + L_248_arg1[1] * L_258_)
			local L_261_ = math.floor(L_247_arg0[2] * L_257_ + L_248_arg1[2] * L_258_)
			local L_262_ = math.floor(L_247_arg0[3] * L_257_ + L_248_arg1[3] * L_258_)
			L_252_ = L_252_ .. string.format("\a%02X%02X%02XFF%s", L_260_, L_261_, L_262_, L_255_)
		end
		return L_252_
	end
	local function L_5_func(L_263_arg0)
		local L_264_ = {}
		for L_265_forvar0 = 1, #L_263_arg0 do
			L_264_[L_265_forvar0] = L_263_arg0[L_265_forvar0]
		end
		return L_264_
	end
	local L_6_ = function (...)
		return ...
	end
	local L_7_ = function(L_266_arg0, L_267_arg1, L_268_arg2)
		return L_266_arg0 + (L_267_arg1 - L_266_arg0) * L_268_arg2
	end
	local L_8_ = function(L_269_arg0, L_270_arg1, L_271_arg2)
		return L_269_arg0 + (L_270_arg1 - L_269_arg0) * globals.absoluteframetime() * L_271_arg2
	end
	local function L_9_func(L_272_arg0, L_273_arg1)
		for L_274_forvar0 = 1, #L_272_arg0 do
			if L_272_arg0[L_274_forvar0] == L_273_arg1 then
				return true
			end
		end
		return false
	end
	local L_10_ = {
		r = 113,
		g = 104,
		b = 230
	}
	local L_11_ = function(...)
		client.color_log(L_10_.r, L_10_.g, L_10_.b, "[vandal] \0")
		client.color_log(198, 203, 209, ...)
	end
	local L_12_ = {}
	local L_13_, L_14_ = client.screen_size()
	local function L_15_func(L_275_arg0, L_276_arg1, L_277_arg2, L_278_arg3, L_279_arg4)
		table.insert(L_12_, {
			text = L_275_arg0,
			duration = L_276_arg1,
			start = globals.curtime(),
			color = {
				L_277_arg2,
				L_278_arg3,
				L_279_arg4
			},
			y = L_14_ + 100,
			state = "appearing",
			fade_delay = 1,
			scale = 0.21,
			alpha = 0
		})
	end
	function draw_rounded_rect(L_280_arg0, L_281_arg1, L_282_arg2, L_283_arg3, L_284_arg4, L_285_arg5, L_286_arg6, L_287_arg7)
		local L_288_ = math.min(L_280_arg0 / 2, L_281_arg1 / 2, 6)
		renderer.rectangle(L_280_arg0 + L_288_, L_281_arg1, L_282_arg2 - L_288_ * 2, L_283_arg3, L_284_arg4, L_285_arg5, L_286_arg6, L_287_arg7)
		renderer.rectangle(L_280_arg0, L_281_arg1 + L_288_, L_288_, L_283_arg3 - L_288_ * 2, L_284_arg4, L_285_arg5, L_286_arg6, L_287_arg7)
		renderer.rectangle(L_280_arg0 + L_282_arg2 - L_288_, L_281_arg1 + L_288_, L_288_, L_283_arg3 - L_288_ * 2, L_284_arg4, L_285_arg5, L_286_arg6, L_287_arg7)
		renderer.circle(L_280_arg0 + L_288_, L_281_arg1 + L_288_, L_284_arg4, L_285_arg5, L_286_arg6, L_287_arg7, L_288_, 180, 0.25)
		renderer.circle(L_280_arg0 + L_282_arg2 - L_288_, L_281_arg1 + L_288_, L_284_arg4, L_285_arg5, L_286_arg6, L_287_arg7, L_288_, 90, 0.25)
		renderer.circle(L_280_arg0 + L_282_arg2 - L_288_, L_281_arg1 + L_283_arg3 - L_288_, L_284_arg4, L_285_arg5, L_286_arg6, L_287_arg7, L_288_, 0, 0.25)
		renderer.circle(L_280_arg0 + L_288_, L_281_arg1 + L_283_arg3 - L_288_, L_284_arg4, L_285_arg5, L_286_arg6, L_287_arg7, L_288_, 270, 0.25)
	end
	function render_logs()
		local L_289_ = globals.curtime()
		local L_290_ = globals.frametime()
		local L_291_ = "cb"
		local L_292_ = 14
		local L_293_ = 12
		local L_294_ = L_14_ - 120
		local L_295_ = 14
		for L_296_forvar0 = #L_12_, 1, -1 do
			local L_297_ = L_12_[L_296_forvar0]
			local L_298_ = L_289_ - L_297_.start
			if L_297_.state == "disappearing" and L_297_.y > L_14_ + 50 then
				table.remove(L_12_, L_296_forvar0)
			elseif L_298_ >= L_297_.duration * L_297_.fade_delay and L_297_.state ~= "disappearing" then
				L_297_.state = "disappearing"
			end
		end
		for L_299_forvar0, L_300_forvar1 in ipairs(L_12_) do
			local L_301_ = L_289_ - L_300_forvar1.start
			local L_302_ = math.min(L_301_ / L_300_forvar1.duration, 1)
			local L_303_, L_304_ = renderer.measure_text(L_291_, L_300_forvar1.text)
			local L_305_ = math.floor(L_303_ + L_293_ * 2 + 10)
			local L_306_ = math.floor(L_304_ + L_295_)
			local L_307_ = math.floor((L_13_ - L_305_) / 2)
			local L_308_ = math.floor(L_294_ - (L_306_ + L_292_) * (#L_12_ - L_299_forvar0))
			if L_300_forvar1.state == "appearing" then
				L_300_forvar1.scale = L_300_forvar1.scale or 0.01
				L_300_forvar1.scale = L_7_(L_300_forvar1.scale, 1, L_290_ * 8)
				L_300_forvar1.y = L_7_(L_300_forvar1.y or L_14_ + 100, L_308_, L_290_ * 8)
				L_300_forvar1.alpha = L_7_(L_300_forvar1.alpha or 0, 255, L_290_ * 8)
				if math.abs(L_300_forvar1.scale - 1) < 0.01 and math.abs(L_300_forvar1.y - L_308_) < 1 then
					L_300_forvar1.state = "visible"
					L_300_forvar1.scale = 1
					L_300_forvar1.alpha = 255
				end
			elseif L_300_forvar1.state == "visible" then
				L_300_forvar1.y = L_7_(L_300_forvar1.y, L_308_, L_290_ * 8)
				L_300_forvar1.scale = 1
				L_300_forvar1.alpha = 255
			elseif L_300_forvar1.state == "disappearing" then
				L_300_forvar1.y = L_7_(L_300_forvar1.y, L_14_ + 100, L_290_ * 8)
				L_300_forvar1.alpha = L_7_(L_300_forvar1.alpha, 0, L_290_ * 8)
			end
			local L_309_ = math.floor(L_305_ * (L_300_forvar1.scale or 1))
			local L_310_ = math.floor(L_306_ * (L_300_forvar1.scale or 1))
			local L_311_ = math.floor(L_307_ + (L_305_ - L_309_) / 2)
			local L_312_ = math.floor((L_300_forvar1.y or L_308_) + (L_306_ - L_310_) / 2)
			local L_313_ = L_300_forvar1.alpha or 255
			local L_314_ = math.min(125, L_313_)
			local L_315_, L_316_, L_317_ = L_300_forvar1.color[1], L_300_forvar1.color[2], L_300_forvar1.color[3]
			draw_rounded_rect(
            L_311_, 
            L_312_, 
            L_309_, 
            L_310_, 
            20, 20, 20, L_314_
        )
			local L_318_ = L_313_
			local L_319_ = L_311_ + L_309_ / 2
			local L_320_ = (L_312_ + (L_310_ - L_304_) / 2) + 4
			renderer.text(L_319_, L_320_, 255, 255, 255, L_318_, L_291_, 0, L_300_forvar1.text)
		end
	end
	function distance3d(L_321_arg0, L_322_arg1, L_323_arg2, L_324_arg3, L_325_arg4, L_326_arg5)
		return math.sqrt((L_324_arg3 - L_321_arg0) * (L_324_arg3 - L_321_arg0) + (L_325_arg4 - L_322_arg1) * (L_325_arg4 - L_322_arg1) + (L_326_arg5 - L_323_arg2) * (L_326_arg5 - L_323_arg2))
	end
	to_hex = function(L_327_arg0, L_328_arg1, L_329_arg2, L_330_arg3)
		return string.format("%02x%02x%02x%02x", L_327_arg0, L_328_arg1, L_329_arg2, L_330_arg3)
	end
	to_hex_a = function(L_331_arg0, L_332_arg1, L_333_arg2)
		return string.format("%02x%02x%02xff", L_331_arg0, L_332_arg1, L_333_arg2)
	end
	local function L_16_func()
		local L_334_ = L_1_.get_lp()
		if not L_334_ or not L_1_.is_alive(L_334_) then
			return 0
		end
		local L_335_ = entity.get_prop(L_334_, "m_flPoseParameter", 11) * 120 - 60
		return math.floor(L_335_)
	end

---@end

---@lua menu
	local L_17_ = 1
	local L_18_ = ui.new_button("AA", "Anti-Aimbot angles", "Back", function()
		L_17_ = 1
	end)
	local L_19_ = ui.new_button("AA", "Anti-Aimbot angles", "Anti - Aim", function()
		L_17_ = 2
	end)
	local L_20_ = ui.new_button("AA", "Anti-Aimbot angles", "Visuals", function()
		L_17_ = 3
	end)
	local L_21_ = ui.new_button("AA", "Anti-Aimbot angles", "Misc", function()
		L_17_ = 4
	end)
	local L_22_ = ui.new_button("AA", "Anti-Aimbot angles", "Config", function()
		L_17_ = 5
	end)

--@visuals
	local L_23_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Crosshair Indicators")
	local L_24_ = ui.new_color_picker("AA", "Anti-Aimbot angles", "Crosshair Indicators", 176, 192, 255, 255)
	local L_25_ = ui.new_combobox("AA", "Anti-Aimbot angles", "Crosshair Indicators Style", "Modern", "Legacy")
--local center_indicators_alpha = ui.new_multiselect("AA", "Anti-Aimbot angles", "Reduce Alpha", "Scoped", "On Nades")
	local L_26_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Aimbot Logs")
	local L_27_ = ui.new_color_picker("AA", "Anti-Aimbot angles", "Aimot Logs", 255, 255, 255, 255)
	local L_28_ = ui.new_multiselect("AA", "Anti-Aimbot angles", "Aimbot logs Output", "Console", "Under Crosshair")
	local L_29_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Manual Indicator")
	local L_30_ = ui.new_color_picker("AA", "Anti-Aimbot angles", "Manual Indicator", 255, 255, 255, 255)
	local L_31_ = ui.new_multiselect("AA", "Anti-Aimbot angles", "UI", "Watermark")
	local L_32_ = ui.new_combobox("AA", "Anti-Aimbot angles", "Watermark Position", "Right upper", "Left upper", "Down centered")
	local L_33_ = ui.new_color_picker("AA", "Anti-Aimbot angles", "Watermark Position", 120, 150, 255, 255)
	local L_34_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Custom Scope")
	local L_35_ = ui.new_color_picker("AA", "Anti-Aimbot angles", "Custom Scope", 255, 255, 255, 255)
	local L_36_ = ui.new_combobox("AA", "Anti-Aimbot angles", "Custom Scope Style", "Default", "Inverted", "X-Style", "X-Style Inverted")
	local L_37_ = ui.new_slider("AA", "Anti-Aimbot angles", "Custom Scope Size", 0, 320, 25)
	local L_38_ = ui.new_slider("AA", "Anti-Aimbot angles", "Custom Scope Gap", 0, 50, 6)
	local L_39_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Disable Scope Animation")
	local L_40_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Revolver Helper")
	local L_41_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Damage Indicator")
	local L_42_ = ui.new_combobox("AA", "Anti-Aimbot angles", "Damage Indicator Font", "Verdana", "Pixel")
	local L_43_ = ui.new_checkbox("AA", "Anti-Aimbot Angles", "Aspect Ratio")
	local L_44_ = ui.new_slider("AA", "Anti-Aimbot angles", "Aspect Ratio", 1, 199, 100, true, "%", 0.01, aspect_ratio_table)
	local L_45_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Debug Text")
	local L_46_ = ui.new_combobox("AA", "Anti-Aimbot angles", "Debug Text Position", "Right Upper", "Right Center")
	local L_47_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Velocity Modifier")
	local L_48_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Animated zoom FOV")
	local L_49_ = ui.new_slider("AA", "Anti-Aimbot angles", "Animated zoom FOV", 0, 35, 0, true, "°")

--@end

---@misc
	local L_50_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Recharge Fix")
	local L_51_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Exploits Fix")
	local L_52_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Remove Delay On DT Uncharge")
	local L_53_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Killsay")
	local L_54_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Console Filter")
	local L_55_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Clantag")
	local L_56_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Force Team Aimbot")
	local L_57_ = ui.new_multiselect("AA", "Anti-Aimbot angles", "Fps Optimizations", "3d sky", "fog", "shadows", "blood", "decals", "bloom", "other")
	local L_58_ = ui.new_multiselect("AA", "Anti-aimbot angles", "Anim Breakers", "Jitter legs on ground", "Body lean", "0 pitch on landing", "Static in Air", "Kangaroo")

--@aa
	local L_59_ = {
		"Global",
		"Stand",
		"Running",
		"Air",
		"Air-Duck",
		"Slow-walk",
		"Duck",
		"Duck-Running",
		"Safe-Head",
		"Manual Left",
		"Manual Right",
		"Manual Forward"
	}
	local L_60_ = {}
	local L_61_ = ui.new_slider("AA", "Anti-Aimbot angles", "Tab", 1, 3, 1, true, "", 1, {
		[1] = "Builder",
		[2] = "Defensive",
		[3] = "Tweaks"
	})
	local L_62_ = ui.new_combobox("AA", "Anti-Aimbot angles", "State selector", L_59_)
	local L_63_ = to_hex(ui.get(ref.menu_color))
	for L_336_forvar0, L_337_forvar1 in ipairs(L_59_) do
		local L_338_ = string.format('\a%s', L_63_) .. L_337_forvar1 .. " \aC0C0C0FF"
		if L_337_forvar1 ~= "Global" then
			L_60_[L_337_forvar1] = {
				allow = ui.new_checkbox("AA", "Anti-Aimbot angles", "Allow " .. L_338_),
				yaw_select     = ui.new_combobox("AA", "Anti-Aimbot angles", L_338_ .. "yaw type", "Static", "L/R"),
				static_yaw     = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "yaw value", -180, 180, 0, true, "°"),
				l_yaw          = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "yaw left", -180, 180, 0, true, "°"),
				r_yaw          = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "yaw right", -180, 180, 0, true, "°"),
				rnd_yaw        = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "yaw randomization", 0, 100, 0, true, "%"),
				yaw_jitter     = ui.new_combobox("AA", "Anti-Aimbot angles", L_338_ .. "yaw jitter", "Off", "Offset", "Center", "Random", "Skitter"),
				yaw_jitter_value = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "yaw jitter value", -180, 180, 0, true, "°"),
				yaw_jitter_rnd = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "yaw jitter randomization", 0, 100, 0, true, "%"),
				body_yaw     = ui.new_combobox("AA", "Anti-Aimbot angles", L_338_ .. "body yaw", "Off", "Static", "Jitter", "Custom Jitter"),
				body_yaw_value     = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "body yaw value", -60, 60, 0, true, "°"),
				delay          = ui.new_combobox("AA", "Anti-Aimbot angles", L_338_ .. "delay type", "Off", "Tickbased", "Settable Random", "Chance"),
				delay_t        = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "delay ticks", 1, 14, 1, true, "t"),
				delay_c        = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "switch chance", 1, 100, 1, true, "%"),
				delay_rnd_select = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "delay stances", 2, 5, 2, true,  "", 1, {
					[2] = "2 Stances",
					[3] = "3 Stances",
					[4] = "4 Stances",
					[5] = "5 Stances"
				}),
				delay_rnd_1    = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "first delay ticks", 1, 14, 1, true, "t"),
				delay_rnd_2    = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "second delay ticks", 1, 14, 1, true, "t"),
				delay_rnd_3    = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "third delay ticks", 1, 14, 1, true, "t"),
				delay_rnd_4    = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "fourth delay ticks", 1, 14, 1, true, "t"),
				delay_rnd_5    = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "fifth delay ticks", 1, 14, 1, true, "t"),
				break_lc       = ui.new_checkbox("AA", "Anti-Aimbot angles", L_338_ .. "break lc"),
				defensive_aa   = ui.new_checkbox("AA", "Anti-Aimbot angles", L_338_ .. "defensive anti-aim"),
				defensive_pitch = ui.new_combobox("AA", "Anti-Aimbot angles", L_338_ .. "defensive pitch", "Off", "Static", "Jitter", "Random", "Sway", "Static Random", "Spin"),
				defensive_pitch_static = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "pitch value", -89, 89, 0, true, "°"),
				defensive_pitch_2 = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "second pitch value", -89, 89, 0, true, "°"),
				defensive_yaw = ui.new_combobox("AA", "Anti-Aimbot angles", L_338_ .. "defensive yaw", "Off", "Static", "Jitter", "Random", "Spin", "Negative Spin", "Distortion", "Sway", "Vandal", "3-Way", "Snap Jitter"),
				defensive_yaw_static = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "yaw offset", -180, 180, 0, true, "°"),
				defensive_yaw_spin = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "spin speed", 1, 100, 1, true, "°s"),
				defensive_yaw_2 = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "second yaw offset", -180, 180, 0, true, "°"),
				defensive_yaw_delay = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "defensive yaw delay", 1, 14, 1, true, "t"),
				defensive_yaw_3 = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "third yaw offset", -180, 180, 0, true, "°"),
			}
		else
			L_60_[L_337_forvar1] = {
				yaw_select     = ui.new_combobox("AA", "Anti-Aimbot angles", L_338_ .. "yaw type", "Static", "L/R"),
				static_yaw     = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "yaw value", -180, 180, 0, true, "°"),
				l_yaw          = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "yaw left", -180, 180, 0, true, "°"),
				r_yaw          = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "yaw right", -180, 180, 0, true, "°"),
				rnd_yaw        = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "yaw randomization", 0, 100, 0, true, "%"),
				yaw_jitter     = ui.new_combobox("AA", "Anti-Aimbot angles", L_338_ .. "yaw jitter", "Off", "Offset", "Center", "Random", "Skitter"),
				yaw_jitter_value = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "yaw jitter value", -180, 180, 0, true, "°"),
				yaw_jitter_rnd = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "yaw jitter randomization", 0, 100, 0, true, "%"),
				body_yaw     = ui.new_combobox("AA", "Anti-Aimbot angles", L_338_ .. "body yaw", "Off", "Static", "Jitter", "Custom Jitter"),
				body_yaw_value     = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "body yaw value", -60, 60, 0, true, "°"),
				delay          = ui.new_combobox("AA", "Anti-Aimbot angles", L_338_ .. "delay type", "Off", "Tickbased", "Settable Random", "Chance"),
				delay_t        = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "delay ticks", 1, 14, 1, true, "t"),
				delay_c        = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "switch chance", 1, 100, 1, true, "%"),
				delay_rnd_select = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "delay stances", 2, 5, 2, true,  "", 1, {
					[2] = "2 Stances",
					[3] = "3 Stances",
					[4] = "4 Stances",
					[5] = "5 Stances"
				}),
				delay_rnd_1    = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "first delay ticks", 1, 14, 1, true, "t"),
				delay_rnd_2    = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "second delay ticks", 1, 14, 1, true, "t"),
				delay_rnd_3    = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "third delay ticks", 1, 14, 1, true, "t"),
				delay_rnd_4    = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "fourth delay ticks", 1, 14, 1, true, "t"),
				delay_rnd_5    = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "fifth delay ticks", 1, 14, 1, true, "t"),
				break_lc       = ui.new_checkbox("AA", "Anti-Aimbot angles", L_338_ .. "break lc"),
				defensive_aa   = ui.new_checkbox("AA", "Anti-Aimbot angles", L_338_ .. "defensive anti-aim"),
				defensive_pitch = ui.new_combobox("AA", "Anti-Aimbot angles", L_338_ .. "defensive pitch", "Off", "Static", "Jitter", "Random", "Sway", "Static Random", "Spin"),
				defensive_pitch_static = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "pitch value", -89, 89, 0, true, "°"),
				defensive_pitch_2 = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "second pitch value", -89, 89, 0, true, "°"),
				defensive_yaw = ui.new_combobox("AA", "Anti-Aimbot angles", L_338_ .. "defensive yaw", "Off", "Static", "Jitter", "Random", "Spin", "Negative Spin", "Distortion", "Sway", "Vandal", "3-Way", "Snap Jitter"),
				defensive_yaw_static = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "yaw offset", -180, 180, 0, true, "°"),
				defensive_yaw_spin = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "spin speed", 1, 100, 1, true, "°s"),
				defensive_yaw_2 = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "second yaw offset", -180, 180, 0, true, "°"),
				defensive_yaw_delay = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "defensive yaw delay", 1, 14, 1, true, "t"),
				defensive_yaw_3 = ui.new_slider("AA", "Anti-Aimbot angles", L_338_ .. "third yaw offset", -180, 180, 0, true, "°"),
			}
		end
	end
	local function L_64_func()
		local L_339_ = ui.get(L_62_)
		for L_340_forvar0, L_341_forvar1 in ipairs(L_59_) do
			local L_342_ = L_60_[L_341_forvar1]
			local L_343_ = (L_341_forvar1 == L_339_ and L_17_ == 2 and ui.get(L_61_) == 1)
			local L_344_ = (L_341_forvar1 == L_339_ and L_17_ == 2 and ui.get(L_61_) == 2)
			local L_345_ = (L_341_forvar1 == "Global" or (L_342_.allow and ui.get(L_342_.allow)))
			if L_342_.allow then
				ui.set_visible(L_342_.allow, L_343_ or L_344_)
			end
			if L_342_.yaw_select then
				ui.set_visible(L_342_.yaw_select, L_343_ and L_345_)
			end
			if L_342_.static_yaw then
				ui.set_visible(L_342_.static_yaw, L_343_ and L_345_ and ui.get(L_342_.yaw_select) == "Static")
			end
			if L_342_.l_yaw then
				ui.set_visible(L_342_.l_yaw, L_343_ and L_345_ and ui.get(L_342_.yaw_select) == "L/R")
			end
			if L_342_.r_yaw then
				ui.set_visible(L_342_.r_yaw, L_343_ and L_345_ and ui.get(L_342_.yaw_select) == "L/R")
			end
			if L_342_.rnd_yaw then
				ui.set_visible(L_342_.rnd_yaw, L_343_ and L_345_ and ui.get(L_342_.yaw_select) == "L/R")
			end
			if L_342_.yaw_jitter then
				ui.set_visible(L_342_.yaw_jitter, L_343_ and L_345_)
			end
			if L_342_.yaw_jitter_value then
				ui.set_visible(L_342_.yaw_jitter_value, L_343_ and L_345_ and ui.get(L_342_.yaw_jitter) ~= "Off")
			end
			if L_342_.yaw_jitter_rnd then
				ui.set_visible(L_342_.yaw_jitter_rnd, L_343_ and L_345_ and ui.get(L_342_.yaw_jitter) ~= "Off")
			end
			if L_342_.body_yaw then
				ui.set_visible(L_342_.body_yaw, L_343_ and L_345_)
			end
			if L_342_.body_yaw_value then
				ui.set_visible(L_342_.body_yaw_value, L_343_ and L_345_ and ui.get(L_342_.body_yaw) ~= "Off")
			end
			if L_342_.delay then
				ui.set_visible(L_342_.delay, L_343_ and L_345_ and (ui.get(L_342_.body_yaw) == "Jitter" or ui.get(L_342_.body_yaw) == "Custom Jitter"))
			end
			if L_342_.delay_t then
				ui.set_visible(L_342_.delay_t, L_343_ and L_345_ and ui.get(L_342_.delay) == "Tickbased" and (ui.get(L_342_.body_yaw) == "Jitter" or ui.get(L_342_.body_yaw) == "Custom Jitter"))
			end
			if L_342_.delay_c then
				ui.set_visible(L_342_.delay_c, L_343_ and L_345_ and ui.get(L_342_.delay) == "Chance" and (ui.get(L_342_.body_yaw) == "Jitter" or ui.get(L_342_.body_yaw) == "Custom Jitter"))
			end
			if L_342_.delay_rnd_select then
				ui.set_visible(L_342_.delay_rnd_select, L_343_ and L_345_ and ui.get(L_342_.delay) == "Settable Random" and (ui.get(L_342_.body_yaw) == "Jitter" or ui.get(L_342_.body_yaw) == "Custom Jitter"))
			end
			if L_342_.delay_rnd_1 then
				ui.set_visible(L_342_.delay_rnd_1, L_343_ and L_345_ and ui.get(L_342_.delay) == "Settable Random" and (ui.get(L_342_.body_yaw) == "Jitter" or ui.get(L_342_.body_yaw) == "Custom Jitter") and ui.get(L_342_.delay_rnd_select) >= 1)
			end
			if L_342_.delay_rnd_2 then
				ui.set_visible(L_342_.delay_rnd_2, L_343_ and L_345_ and ui.get(L_342_.delay) == "Settable Random" and (ui.get(L_342_.body_yaw) == "Jitter" or ui.get(L_342_.body_yaw) == "Custom Jitter") and ui.get(L_342_.delay_rnd_select) >= 2)
			end
			if L_342_.delay_rnd_3 then
				ui.set_visible(L_342_.delay_rnd_3, L_343_ and L_345_ and ui.get(L_342_.delay) == "Settable Random" and (ui.get(L_342_.body_yaw) == "Jitter" or ui.get(L_342_.body_yaw) == "Custom Jitter") and ui.get(L_342_.delay_rnd_select) >= 3)
			end
			if L_342_.delay_rnd_4 then
				ui.set_visible(L_342_.delay_rnd_4, L_343_ and L_345_ and ui.get(L_342_.delay) == "Settable Random" and (ui.get(L_342_.body_yaw) == "Jitter" or ui.get(L_342_.body_yaw) == "Custom Jitter") and ui.get(L_342_.delay_rnd_select) >= 4)
			end
			if L_342_.delay_rnd_5 then
				ui.set_visible(L_342_.delay_rnd_5, L_343_ and L_345_ and ui.get(L_342_.delay) == "Settable Random" and (ui.get(L_342_.body_yaw) == "Jitter" or ui.get(L_342_.body_yaw) == "Custom Jitter") and ui.get(L_342_.delay_rnd_select) >= 5)
			end
			if L_342_.break_lc then
				ui.set_visible(L_342_.break_lc, L_343_ and L_345_)
			end
			if L_342_.defensive_aa then
				ui.set_visible(L_342_.defensive_aa, L_344_ and L_345_)
			end
			if L_342_.defensive_pitch then
				ui.set_visible(L_342_.defensive_pitch, L_344_ and L_345_ and ui.get(L_342_.defensive_aa))
			end
			if L_342_.defensive_pitch_static then
				ui.set_visible(L_342_.defensive_pitch_static, L_344_ and L_345_ and ui.get(L_342_.defensive_aa) and ui.get(L_342_.defensive_pitch) ~= "Off")
			end
			if L_342_.defensive_pitch_2 then
				ui.set_visible(L_342_.defensive_pitch_2, L_344_ and L_345_ and ui.get(L_342_.defensive_aa) and (ui.get(L_342_.defensive_pitch) == "Jitter" or ui.get(L_342_.defensive_pitch) == "Random" or ui.get(L_342_.defensive_pitch) == "Static Random" or ui.get(L_342_.defensive_pitch) == "Spin" or ui.get(L_342_.defensive_pitch) == "Sway"))
			end
			if L_342_.defensive_yaw then
				ui.set_visible(L_342_.defensive_yaw, L_344_ and L_345_ and ui.get(L_342_.defensive_aa))
			end
			if L_342_.defensive_yaw_static then
				ui.set_visible(L_342_.defensive_yaw_static, L_344_ and L_345_ and ui.get(L_342_.defensive_aa) and ( ui.get(L_342_.defensive_yaw) ~= "Off" and ui.get(L_342_.defensive_yaw) ~= "Spin" and ui.get(L_342_.defensive_yaw) ~= "Negative Spin" and ui.get(L_342_.defensive_yaw) ~= "Distortion" and ui.get(L_342_.defensive_yaw) ~= "Vandal"))
			end
			if L_342_.defensive_yaw_2 then
				ui.set_visible(L_342_.defensive_yaw_2, L_344_ and L_345_ and ui.get(L_342_.defensive_aa) and ( ui.get(L_342_.defensive_yaw) == "Jitter" or ui.get(L_342_.defensive_yaw) == "Random" or ui.get(L_342_.defensive_yaw) == "3-Way" or ui.get(L_342_.defensive_yaw) == "Snap Jitter" or ui.get(L_342_.defensive_yaw) == "Sway" ))
			end
			if L_342_.defensive_yaw_delay then
				ui.set_visible(L_342_.defensive_yaw_delay, L_344_ and L_345_ and ui.get(L_342_.defensive_aa) and (ui.get(L_342_.defensive_yaw) == "Jitter"))
			end
			if L_342_.defensive_yaw_3 then
				ui.set_visible(L_342_.defensive_yaw_3, L_344_ and L_345_ and ui.get(L_342_.defensive_aa) and ui.get(L_342_.defensive_yaw) == "3-Way")
			end
			if L_342_.defensive_yaw_spin then
				ui.set_visible(L_342_.defensive_yaw_spin, L_344_ and L_345_ and ui.get(L_342_.defensive_aa) and (ui.get(L_342_.defensive_yaw) == "Spin" or ui.get(L_342_.defensive_yaw) == "Negative Spin"))
			end
		end
	end
	L_64_func()


--@end

---@tweaks
	local L_65_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Avoid Backstab")
	local L_66_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Legit AA and Bombsite e-fix")
	local L_67_ = ui.new_combobox("AA", "Anti-Aimbot angles", "Legit AA Type", "Opposite", "2-Way")
	local L_68_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Fast Ladder Movement")
	local L_69_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Warmup AA")
	local L_70_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Anti-Bruteforce")
	local L_71_ = ui.new_multiselect("AA", "Anti-Aimbot angles", "Safe Head Options", "Knife", "Zeus", "Height Advantage")
	local L_72_ = ui.new_hotkey("AA", "Anti-Aimbot angles", "Freestanding")
	local L_73_ = ui.new_hotkey("AA", "Anti-Aimbot angles", "Manual Left")
	local L_74_ = ui.new_hotkey("AA", "Anti-Aimbot angles", "Manual Right")
	local L_75_ = ui.new_hotkey("AA", "Anti-Aimbot angles", "Manual Forward")
	local L_76_ = ui.new_hotkey("AA", "Anti-Aimbot angles", "Manual Reset")
	local L_77_ = ui.new_combobox("AA", "Anti-Aimbot angles", "Manual Type", "Static", "Jitter")
	local L_78_ = ui.new_hotkey("AA", "Anti-Aimbot angles", "Edge Yaw")
	local L_79_ = ui.new_checkbox("AA", "Anti-Aimbot angles", "Flick Opposite on manual")
--local force_lag = ui.new_hotkey("AA", "Anti-Aimbot angles", "Force Lag In Air")
	ui.set_visible(L_79_, false)
	ui.set_visible(L_77_, false)

---@end

---@main menu
	lua_name_label = ui.new_label("AA", "Fake Lag", "\a" .. L_63_ .. "Vandal\aC0C0C0FF • " .. build)
	lua_user_label = ui.new_label("AA", "Fake Lag", "\a" .. L_63_ .. "Username\aC0C0C0FF - " .. username)
	lua_update_label = ui.new_label("AA", "Fake Lag", "\a" .. L_63_ .. "Last Update\aC0C0C0FF - " .. update_date)
	lua_session = ui.new_label("AA", "Fake Lag", "\a" .. L_63_ .. "Current Session\aC0C0C0FF - 0 min 0 sec")

---@end
	function menu_visibillity()
    --main
		ui.set_visible(L_18_, L_17_ ~= 1)
		ui.set_visible(L_19_, L_17_ == 1)
		ui.set_visible(L_20_, L_17_ == 1)
		ui.set_visible(L_21_, L_17_ == 1)
		ui.set_visible(L_22_, L_17_ == 1)
		ui.set_visible(lua_name_label, L_17_ == 1)
		ui.set_visible(lua_user_label, L_17_ == 1)
		ui.set_visible(lua_update_label, L_17_ == 1)
		ui.set_visible(lua_session, L_17_ == 1)

    --aa
		ui.set_visible(L_62_, (L_17_ == 2 and ( ui.get(L_61_) == 1 or ui.get(L_61_) == 2 ) ))
		ui.set_visible(L_61_, L_17_ == 2)

    --tweaks
		ui.set_visible(L_65_, (L_17_ == 2 and ui.get(L_61_) == 3))
		ui.set_visible(L_66_, (L_17_ == 2 and ui.get(L_61_) == 3))
		ui.set_visible(L_67_, (L_17_ == 2 and ui.get(L_66_) and ui.get(L_61_) == 3))
		ui.set_visible(L_68_, (L_17_ == 2 and ui.get(L_61_) == 3))
		ui.set_visible(L_69_, (L_17_ == 2 and ui.get(L_61_) == 3))
		ui.set_visible(L_70_, (L_17_ == 2 and ui.get(L_61_) == 3))
		ui.set_visible(L_71_, (L_17_ == 2 and ui.get(L_61_) == 3))
		ui.set_visible(L_72_, (L_17_ == 2 and ui.get(L_61_) == 3))
		ui.set_visible(L_73_, (L_17_ == 2 and ui.get(L_61_) == 3))
		ui.set_visible(L_74_, (L_17_ == 2 and ui.get(L_61_) == 3))
		ui.set_visible(L_76_, (L_17_ == 2 and ui.get(L_61_) == 3))
		ui.set_visible(L_75_, (L_17_ == 2 and ui.get(L_61_) == 3))
		ui.set_visible(L_78_, (L_17_ == 2 and ui.get(L_61_) == 3))
    --ui.set_visible(force_lag, (cur_tab == 2 and ui.get(tab_type) == 3))

    --visuals
		ui.set_visible(L_23_, L_17_ == 3)
		ui.set_visible(L_24_, L_17_ == 3 and ui.get(L_23_))
		ui.set_visible(L_25_, L_17_ == 3 and ui.get(L_23_))
    --ui.set_visible(center_indicators_alpha, cur_tab == 3 and ui.get(center_indicators) and ui.get(center_indicators_type) == "Modern")
		ui.set_visible(L_26_, L_17_ == 3)
		ui.set_visible(L_27_, L_17_ == 3 and ui.get(L_26_))
		ui.set_visible(L_28_, L_17_ == 3 and ui.get(L_26_))
		ui.set_visible(L_31_, L_17_ == 3)
		ui.set_visible(L_32_, L_17_ == 3 and L_9_func(ui.get(L_31_), "Watermark"))
		ui.set_visible(L_33_, L_17_ == 3 and L_9_func(ui.get(L_31_), "Watermark"))
		ui.set_visible(L_34_, L_17_ == 3)
		ui.set_visible(L_35_, L_17_ == 3 and ui.get(L_34_))
		ui.set_visible(L_37_, L_17_ == 3 and ui.get(L_34_))
		ui.set_visible(L_38_, L_17_ == 3 and ui.get(L_34_))
		ui.set_visible(L_36_, L_17_ == 3 and ui.get(L_34_))
		ui.set_visible(L_39_, L_17_ == 3 and ui.get(L_34_))
		ui.set_visible(L_29_, L_17_ == 3)
		ui.set_visible(L_30_, L_17_ == 3 and ui.get(L_29_))
		ui.set_visible(L_40_, L_17_ == 3)
		ui.set_visible(L_41_, L_17_ == 3)
		ui.set_visible(L_42_, L_17_ == 3 and ui.get(L_41_))
		ui.set_visible(L_43_, L_17_ == 3)
		ui.set_visible(L_44_, L_17_ == 3 and ui.get(L_43_))
		ui.set_visible(L_45_, L_17_ == 3)
		ui.set_visible(L_46_, L_17_ == 3 and ui.get(L_45_))
		ui.set_visible(L_47_, L_17_ == 3)
		ui.set_visible(L_48_, L_17_ == 3)
		ui.set_visible(L_49_, L_17_ == 3 and ui.get(L_48_))

    --misc
		ui.set_visible(L_50_, L_17_ == 4)
		ui.set_visible(L_51_, L_17_ == 4)
		ui.set_visible(L_54_, L_17_ == 4)
		ui.set_visible(L_56_, L_17_ == 4)
		ui.set_visible(L_55_, L_17_ == 4)
		ui.set_visible(L_52_, L_17_ == 4)
		ui.set_visible(L_53_, L_17_ == 4)
		ui.set_visible(L_57_, L_17_ == 4)
		ui.set_visible(L_58_, L_17_ == 4)
	end
	menu_visibillity()

---@end

---@accent color logs
	local function L_80_func()
		if not ui.get(L_26_) then
			L_10_.r = 113
			L_10_.g = 104
			L_10_.b = 230
			return
		end
		L_10_.r, L_10_.g, L_10_.b = unpack({
			ui.get(L_27_)
		})
	end
---@end

---@manual
	local L_81_ = 0
	local L_82_ = 0
	local L_83_ = {
		{
			keyFunc = function()
				return ui.get(L_73_)
			end,
			value = -90
		},
		{
			keyFunc = function()
				return ui.get(L_74_)
			end,
			value = 90
		},
		{
			keyFunc = function()
				return ui.get(L_75_)
			end,
			value = 180
		},
		{
			keyFunc = function()
				return ui.get(L_76_)
			end,
			value = 0
		},
	}
	local function L_84_func(L_346_arg0)
		local L_347_ = globals.curtime()
		for L_348_forvar0, L_349_forvar1 in ipairs(L_83_) do
			if L_349_forvar1.keyFunc() and (L_82_ + 0.13 < L_347_) then
				L_81_ = (L_81_ == L_349_forvar1.value) and 0 or L_349_forvar1.value
				L_82_ = L_347_
				break
			end
		end
		if L_82_ > L_347_ then
			L_82_ = L_347_
		end
		if L_81_ ~= 0 then
			ui.set(ref.yaw_base, "Local view")
		end
	end

---@end

---@aa functions
	is_on_ground = false
	function get_player_state(L_350_arg0)
		local L_351_ = L_1_.get_lp()
		if not L_351_ or not L_1_.is_alive(L_351_) then
			return "Unknown"
		end
		local L_352_ = entity.get_prop(L_351_, 'm_fFlags')
		local L_353_ = L_1_.get_velocity(L_351_)
		local L_354_ = bit.band(L_352_, 1) == 1
		local L_355_ = bit.band(L_352_, 1) == 0 or L_350_arg0.in_jump == 1
		local L_356_ = entity.get_prop(L_351_, 'm_flDuckAmount') > 0.7
		local L_357_ = L_356_
		local L_358_ = ui.get(ref.slow_walk[1]) and ui.get(ref.slow_walk[2])
		is_on_ground = L_354_
		local L_359_ = entity.get_classname(entity.get_prop(L_351_, "m_hActiveWeapon"))
		local L_360_ = ui.get(L_71_)
		local L_361_ = 
        (L_359_ == "CKnife" and L_9_func(L_360_, "Knife")) or
        (L_359_ == "CWeaponTaser" and L_9_func(L_360_, "Zeus"))
		if L_355_ and L_357_ and L_361_ then
			return "Safe-Head"
		elseif L_9_func(L_360_, "Height Advantage") and height_advantaged(client.current_threat()) then
			return "Safe-Head"
		elseif L_81_ == -90 then
			return "Manual Left"
		elseif L_81_ == 90 then
			return "Manual Right"
		elseif L_81_ == 180 then
			return "Manual Forward"
		elseif L_355_ and L_357_ then
			return "Air-Duck"
		elseif L_355_ then
			return "Air"
		elseif L_357_ and L_353_ > 10 then
			return "Duck-Running"
		elseif L_357_ and L_353_ < 10 then
			return "Duck"
		elseif L_354_ and L_358_ and L_353_ > 10 then
			return "Slow-walk"
		elseif L_354_ and L_353_ > 5 then
			return "Running"
		elseif L_354_ and L_353_ < 5 then
			return "Stand"
		else
			return "Unknown"
		end
	end
	local L_85_ = nil
	local function L_86_func(L_362_arg0)
		L_85_ = get_player_state(L_362_arg0)
	end
---@end

---@centered indicators
	local L_87_ = 0.0
	local L_88_ = 1.0
	local L_89_ = 0.04
	function smooth_exploit()
		L_88_ = L_2_.get_dt() and 1.0 or 0.0
		L_87_ = L_87_ + (L_88_ - L_87_) * L_89_
		if math.abs(L_87_ - L_88_) < 0.01 then
			L_87_ = L_88_
		end
		return L_87_
	end
	renderer_rec = function(L_363_arg0, L_364_arg1, L_365_arg2, L_366_arg3, L_367_arg4, L_368_arg5, L_369_arg6, L_370_arg7, L_371_arg8)
		L_367_arg4 = math.min(L_363_arg0 / 2, L_364_arg1 / 2, L_367_arg4)
		renderer.rectangle(L_363_arg0, L_364_arg1 + L_367_arg4, L_365_arg2, L_366_arg3 - L_367_arg4 * 2, L_368_arg5, L_369_arg6, L_370_arg7, L_371_arg8)
		renderer.rectangle(L_363_arg0 + L_367_arg4, L_364_arg1, L_365_arg2 - L_367_arg4 * 2, L_367_arg4, L_368_arg5, L_369_arg6, L_370_arg7, L_371_arg8)
		renderer.rectangle(L_363_arg0 + L_367_arg4, L_364_arg1 + L_366_arg3 - L_367_arg4, L_365_arg2 - L_367_arg4 * 2, L_367_arg4, L_368_arg5, L_369_arg6, L_370_arg7, L_371_arg8)
		renderer.circle(L_363_arg0 + L_367_arg4, L_364_arg1 + L_367_arg4, L_368_arg5, L_369_arg6, L_370_arg7, L_371_arg8, L_367_arg4, 180, 0.25)
		renderer.circle(L_363_arg0 - L_367_arg4 + L_365_arg2, L_364_arg1 + L_367_arg4, L_368_arg5, L_369_arg6, L_370_arg7, L_371_arg8, L_367_arg4, 90, 0.25)
		renderer.circle(L_363_arg0 - L_367_arg4 + L_365_arg2, L_364_arg1 - L_367_arg4 + L_366_arg3, L_368_arg5, L_369_arg6, L_370_arg7, L_371_arg8, L_367_arg4, 0, 0.25)
		renderer.circle(L_363_arg0 + L_367_arg4, L_364_arg1 - L_367_arg4 + L_366_arg3, L_368_arg5, L_369_arg6, L_370_arg7, L_371_arg8, L_367_arg4, -90, 0.25)
		renderer.rectangle(L_363_arg0, L_364_arg1, L_365_arg2, 1, 0, 0, 0, 255)
		renderer.rectangle(L_363_arg0, L_364_arg1 + L_366_arg3 - 1, L_365_arg2, 1, 0, 0, 0, 255)
		renderer.rectangle(L_363_arg0, L_364_arg1, 1, L_366_arg3, 0, 0, 0, 255)
		renderer.rectangle(L_363_arg0 + L_365_arg2 - 1, L_364_arg1, 1, L_366_arg3, 0, 0, 0, 255)
	end
	local L_90_, L_91_, L_92_, L_93_, L_94_, L_95_ = 0, 0, 0, 0, 0, 0
	last_switch_time = 0
	function centered_indicators_legacy()
		if not ui.get(L_23_) then
			return
		end
		if ui.get(L_25_) ~= "Legacy" then
			return
		end
		local L_372_ = L_1_.get_lp()
		if not L_372_ or not L_1_.is_alive(L_372_) then
			return
		end
		local L_373_, L_374_ = client.screen_size()
		local L_375_, L_376_ = L_373_ / 2, L_374_ / 2
		local L_377_ = L_1_.get_velocity(L_372_)
		local L_378_ = math.min(L_377_ / 450, 1)
		local L_379_ = L_7_(1, 64, L_378_)
		local L_380_ = L_16_func() < 0 and "left" or "right"
		local L_381_ =
    (L_85_ and string.upper(L_85_)) or
    "UNKNOWN"
		local L_382_ = L_1_.isScoped(L_372_)
		if L_381_ == "AIR-DUCK" then
			L_90_ = L_8_(L_90_, L_382_ and 22 or 0, 15)
		elseif L_381_ == "RUNNING" then
			L_90_ = L_8_(L_90_, L_382_ and 21 or 0, 15)
		elseif L_381_ == "DUCK-RUNNING" then
			L_90_ = L_8_(L_90_, L_382_ and 32 or 0, 15)
		elseif L_381_ == "AIR" then
			L_90_ = L_8_(L_90_, L_382_ and 11 or 0, 15)
		elseif L_381_ == "DUCK" then
			L_90_ = L_8_(L_90_, L_382_ and 15 or 0, 15)
		elseif L_381_ == "STAND" then
			L_90_ = L_8_(L_90_, L_382_ and 17 or 0, 15)
		elseif L_381_ == "MANUAL LEFT" then
			L_90_ = L_8_(L_90_, L_382_ and 28 or 0, 15)
		elseif L_381_ == "MANUAL RIGHT" then
			L_90_ = L_8_(L_90_, L_382_ and 31 or 0, 15)
		else
			L_90_ = L_8_(L_90_, L_382_ and 26 or 0, 15)
		end
		L_93_ = L_8_(L_93_, L_382_ and 24 or 0, 15)
		L_91_ = L_8_(L_91_, L_382_ and 10 or 0, 15)
		L_95_ = L_8_(L_95_, L_382_ and 11 or 0, 15)
		L_92_ = L_8_(L_92_, L_382_ and 14 or 0, 15)
		L_94_ = L_8_(L_94_, L_382_ and 10 or 0, 15)
		local L_383_ = L_16_func()
		local L_384_ = globals.curtime()
		local L_385_ = L_383_ < 0 and "left" or "right"
		if L_385_ ~= L_380_ and L_384_ - last_switch_time >= 0.058 then
			L_380_ = L_385_
			last_switch_time = L_384_
		end
		local L_386_ = to_hex_a(ui.get(L_24_))
		local L_387_ = L_380_ == "left" and "\a" .. L_386_ or "\aFFFFFFFF"
		local L_388_ = L_380_ == "right" and "\a" .. L_386_ or "\aFFFFFFFF"
		local L_389_ = L_387_ .. "van" .. L_388_ .. "dal°"
		renderer.text(L_375_ + L_93_, L_376_ + 27, 255, 255, 255, 255, "cb", nil, L_389_)
		renderer.text(L_375_ + L_90_, L_376_ + 40, 255, 255, 255, 255, "c-", nil, L_381_)
		local L_390_ = 9.33
		if ui.get(ref.dt[2]) and ui.get(ref.dt[1]) then
			renderer.text(L_375_ - 1 + L_94_, L_376_ + 44 + L_390_, 255, 255, 255, 255, "c-", nil, "DT")
			renderer.circle_outline(L_375_ + 11 + L_94_, L_376_ + 44.95 + L_390_, 255, 255, 255, 255, 3, 90, smooth_exploit(), 1)
			L_390_ = L_390_ + 10
		elseif ui.get(ref.hs[1]) and ui.get(ref.hs[2]) then
			renderer.text(L_375_ - 1 + L_95_, L_376_ + 44 + L_390_, 255, 255, 255, 255, "c-", nil, "HS")
			L_390_ = L_390_ + 10
		end
		if ui.get(ref.min_damage_override[1]) and ui.get(ref.min_damage_override[2]) then
			renderer.text(L_375_ + L_91_, L_376_ + 44 + L_390_, 255, 255, 255, 255, "c-", nil, "MD")
			L_390_ = L_390_ + 10
		end
		if ui.get(ref.body) then
			renderer.text(L_375_ + L_92_, L_376_ + 44 + L_390_, 255, 255, 255, 255, "c-", nil, "BODY")
			L_390_ = L_390_ + 10
		end
	end
	local L_96_, L_97_, L_98_, L_99_, L_100_, L_101_, L_102_ = 0, 0, 0, 0, 0, 0, 0
	local L_103_, L_104_, L_105_, L_106_ = 0, 0, 0, 0
	local L_107_ = {
		dt = 0,
		hs = 0,
		dmg = 0,
		baim = 0
	}
	local function L_108_func()
		if not ui.get(L_23_) then
			return
		end
		if ui.get(L_25_) ~= "Modern" then
			return
		end
		local L_391_ = L_1_.get_lp()
		if not L_391_ or not L_1_.is_alive(L_391_) then
			return
		end
		local L_392_, L_393_ = client.screen_size()
		local L_394_, L_395_ = L_392_ / 2, L_393_ / 2
		local L_396_ = L_1_.get_velocity(L_391_)
		local L_397_ = math.min(L_396_ / 450, 1)
		local L_398_ = L_7_(1, 64, L_397_)
		local L_399_ = L_16_func() < 0 and "left" or "right"
		local L_400_ = (L_85_ and string.upper(L_85_)) or "UNKNOWN"
		local L_401_ = L_1_.isScoped(L_391_)
		if L_400_ == "AIR-DUCK" then
			L_96_ = L_8_(L_96_, L_401_ and 22 or 0, 15)
		elseif L_400_ == "RUNNING" then
			L_96_ = L_8_(L_96_, L_401_ and 21 or 0, 15)
		elseif L_400_ == "DUCK-RUNNING" then
			L_96_ = L_8_(L_96_, L_401_ and 32 or 0, 15)
		elseif L_400_ == "AIR" then
			L_96_ = L_8_(L_96_, L_401_ and 11 or 0, 15)
		elseif L_400_ == "DUCK" then
			L_96_ = L_8_(L_96_, L_401_ and 15 or 0, 15)
		elseif L_400_ == "STAND" then
			L_96_ = L_8_(L_96_, L_401_ and 17 or 0, 15)
		elseif L_400_ == "MANUAL LEFT" then
			L_96_ = L_8_(L_96_, L_401_ and 28 or 0, 15)
		elseif L_400_ == "MANUAL RIGHT" then
			L_96_ = L_8_(L_96_, L_401_ and 31 or 0, 15)
		else
			L_96_ = L_8_(L_96_, L_401_ and 26 or 0, 15)
		end
		L_99_ = L_8_(L_99_, L_401_ and 33 or 0, 15)
		L_97_ = L_8_(L_97_, L_401_ and 14 or 0, 15)
		L_101_ = L_8_(L_101_, L_401_ and 10 or 0, 15)
		L_98_ = L_8_(L_98_, L_401_ and 15 or 0, 15)
		L_100_ = L_8_(L_100_, L_401_ and 11 or 0, 15)
		local L_402_ = {
			ui.get(L_24_)
		}
		local L_403_, L_404_, L_405_, L_406_ = unpack(L_402_)
		local L_407_ = to_hex_a(ui.get(L_24_))
		local L_408_ = gradient_text_lower({
			L_403_,
			L_404_,
			L_405_
		}, {
			L_403_ / 12,
			L_404_ / 12,
			L_405_ / 12
		}, "vandal.tech", 2.33)
		renderer.text(L_394_ + L_99_, L_395_ + 27, 255, 255, 255, 255, "cb", nil, L_408_)
		renderer.text(L_394_ + L_96_, L_395_ + 40, 255, 255, 255, 255, "c-", nil, "\a" .. L_407_ .. L_400_)
		local L_409_ = 9.33
		local L_410_ = 255
		local L_411_ = 10
		local L_412_ = 8
		L_102_ = L_8_(L_102_, (smooth_exploit() > 0.5) and -2 or 2, 15)
		if L_401_ then
			L_102_ = 0
		end
		local L_413_ = 42 + L_409_
		local L_414_ = {}
		if ui.get(ref.dt[2]) and ui.get(ref.dt[1]) then
			L_414_.dt = L_413_
			L_413_ = L_413_ + 11
		end
		if ui.get(ref.hs[1]) and ui.get(ref.hs[2]) and not ui.get(ref.dt[2]) then
			L_414_.hs = L_413_
			L_413_ = L_413_ + 11
		end
		if ui.get(ref.min_damage_override[1]) and ui.get(ref.min_damage_override[2]) then
			L_414_.dmg = L_413_
			L_413_ = L_413_ + 11
		end
		if ui.get(ref.body) then
			L_414_.baim = L_413_
		end
		for L_415_forvar0, L_416_forvar1 in pairs(L_414_) do
			L_107_[L_415_forvar0] = L_8_(L_107_[L_415_forvar0] or 35, L_416_forvar1, L_412_)
		end
		for L_417_forvar0, L_418_forvar1 in pairs(L_107_) do
			if not L_414_[L_417_forvar0] then
				L_107_[L_417_forvar0] = L_8_(L_107_[L_417_forvar0], 35, L_412_)
			end
		end
		L_103_ = L_8_(L_103_, ui.get(ref.dt[2]) and ui.get(ref.dt[1]) and L_410_ or 0, L_411_)
		L_104_ = L_8_(L_104_, ui.get(ref.hs[1]) and ui.get(ref.hs[2]) and not ui.get(ref.dt[2]) and L_410_ or 0, L_411_)
		L_105_ = L_8_(L_105_, ui.get(ref.min_damage_override[1]) and ui.get(ref.min_damage_override[2]) and L_410_ or 0, L_411_)
		L_106_ = L_8_(L_106_, ui.get(ref.body) and L_410_ or 0, L_411_)
		if L_103_ > 0 and ui.get(ref.dt[2]) then
			local L_419_ = smooth_exploit() > 0.5 and "\a" .. L_407_ or "\aec5353FF"
			renderer.text(L_394_ + L_102_ - 1 + L_100_, L_395_ + L_107_.dt, 255, 255, 255, L_103_, "c-", nil, L_419_ .. "DT")
			renderer.circle_outline(L_394_ + L_102_ + 11 + L_100_, L_395_ + L_107_.dt + 0.95, L_403_, L_404_, L_405_, L_103_, 3, 90, smooth_exploit(), 1)
		end
		if L_104_ > 0 then
			renderer.text(L_394_ + L_101_, L_395_ + L_107_.hs, L_403_, L_404_, L_405_, L_104_, "c-", nil, "HS")
		end
		if L_105_ > 0 then
			renderer.text(L_394_ + L_97_, L_395_ + L_107_.dmg, L_403_, L_404_, L_405_, L_105_, "c-", nil, "DMG")
		end
		if L_106_ > 0 then
			renderer.text(L_394_ + L_98_, L_395_ + L_107_.baim, L_403_, L_404_, L_405_, L_106_, "c-", nil, "BAIM")
		end
	end

---@end

---@anti-aims

--local function do_desync(cmd, target_desync, mode, jitter_delay, real_yaw)
--
--    -- from supremacy :3
--    if entity.get_prop(lp, "m_MoveType") == 8 then return end
--
--    if not target_desync or not mode then
--        cmd.allow_send_packet = true
--        return
--    end
--
--    local choked = globals.chokedcommands()
--
--    if choked > 0 then
--        cmd.allow_send_packet = true
--        return
--    end
--
--    if mode == 1 then
--        cmd.allow_send_packet = false
--        ui.set(ref.yaw[2], delayjitter(-target_desync + real_yaw, target_desync - real_yaw, jitter_delay, math.random(0, 1) == 1))
--
--    elseif mode == 2 then
--        cmd.allow_send_packet = false
--        ui.set(ref.yaw[2], clamp(target_desync + real_yaw, -180, 180))
--
--    elseif mode == 3 then
--        cmd.allow_send_packet = false
--        local left = -target_desync + real_yaw
--        local right = target_desync - real_yaw
--        ui.set(ref.yaw[2], delayjitter(left, right, jitter_delay, math.random(0, 1) == 1))
--    end
--end


---@defensive check
	last_commandnumber = 0
	static = {
		tickbase_max = 0,
		diff = 0,
		defensive = false,
	}
	function update_defensive(L_420_arg0)
		local L_421_ = entity.get_local_player()
		local L_422_ = L_421_ and entity.is_alive(L_421_)
		if not L_422_ then
			return
		end
		local L_423_ = (((ui.get(ref.dt[2]) or ui.get(ref.hs[2])) and not ui.get(ref.fd)) and L_2_.get_dt())
		if not L_423_ then
			static.defensive = false
		end
		local L_424_ = entity.get_prop(L_421_, "m_nTickBase") or 0
		if last_commandnumber == L_420_arg0.command_number then
			static.diff = L_424_ - static.tickbase_max
			static.defensive = static.diff < -3
			if math.abs(static.diff) > 64 then
				static.tickbase_max = 0
			end
			static.tickbase_max = math.max(L_424_, static.tickbase_max or 0)
		end
		return static.defensive
	end
	function on_finish_command(L_425_arg0)
		local L_426_ = entity.get_local_player()
		local L_427_ = L_426_ and entity.is_alive(L_426_)
		if L_427_ then
			last_commandnumber = L_425_arg0.command_number
		end
	end

---@end

---@custom sway
	local L_109_ = {
		current_value = 0,
		increasing = true
	}
	function custom_sway(L_428_arg0, L_429_arg1)
		if L_109_.increasing then
			L_109_.current_value = L_109_.current_value + 3.33
			if L_109_.current_value >= L_429_arg1 then
				L_109_.current_value = L_429_arg1
				L_109_.increasing = false
			end
		else
			L_109_.current_value = L_109_.current_value - 3.33
			if L_109_.current_value <= L_428_arg0 then
				L_109_.current_value = L_428_arg0
				L_109_.increasing = true
			end
		end
		return L_109_.current_value
	end
---@end

---@sway yaw
	local L_110_ = {
		current_value = 0,
		increasing = true
	}
	function custom_sway_2(L_430_arg0, L_431_arg1)
		if L_110_.increasing then
			L_110_.current_value = L_110_.current_value + 3.33
			if L_110_.current_value >= L_431_arg1 then
				L_110_.current_value = L_431_arg1
				L_110_.increasing = false
			end
		else
			L_110_.current_value = L_110_.current_value - 3.33
			if L_110_.current_value <= L_430_arg0 then
				L_110_.current_value = L_430_arg0
				L_110_.increasing = true
			end
		end
		return L_110_.current_value
	end
---@end
	local function L_111_func(L_432_arg0)
		L_432_arg0 = (L_432_arg0 + 180) % 360
		if L_432_arg0 < 0 then
			L_432_arg0 = L_432_arg0 + 360
		end
		return L_432_arg0 - 180
	end
	local function L_112_func(L_433_arg0, L_434_arg1, L_435_arg2)
		local L_436_ = L_434_arg1 - L_433_arg0
		local L_437_ = globals.curtime() * L_435_arg2
		local L_438_ = (L_437_ % 1)
		return L_433_arg0 + L_436_ * L_438_
	end

---@end
	function delayjitter(L_439_arg0, L_440_arg1, L_441_arg2, L_442_arg3)
		if not L_1_.is_alive(L_1_.get_lp()) or not L_1_.get_lp() then
			return
		end
		local L_443_  = math.random(0, math.abs(L_439_arg0) * L_441_arg2 / 100)
		local L_444_ = math.random(0, math.abs(L_440_arg1) * L_441_arg2 / 100)
		local L_445_ = L_442_arg3 and (L_439_arg0 + L_443_) or (L_440_arg1 - L_444_)
		return clamp(L_445_, -180, 180)
	end
	local L_113_ = {
		active_until = 0,
		last_print = 0,
		current_offset = 0
	}
	local function L_114_func(L_446_arg0, L_447_arg1, L_448_arg2)
		local L_449_ = {
			L_448_arg2[1] - L_446_arg0[1],
			L_448_arg2[2] - L_446_arg0[2]
		}
		local L_450_ = {
			L_447_arg1[1] - L_446_arg0[1],
			L_447_arg1[2] - L_446_arg0[2]
		}
		local L_451_ = L_450_[1] ^ 2 + L_450_[2] ^ 2
		if L_451_ == 0 then
			return L_446_arg0
		end
		local L_452_ = L_449_[1] * L_450_[1] + L_449_[2] * L_450_[2]
		local L_453_ = math.max(0, math.min(1, L_452_ / L_451_))
		return {
			L_446_arg0[1] + L_450_[1] * L_453_,
			L_446_arg0[2] + L_450_[2] * L_453_
		}
	end
	client.set_event_callback("bullet_impact", function(L_454_arg0)
		if not ui.get(L_70_) then
			L_113_.current_offset = 0
			return
		end
		local L_455_ = client.userid_to_entindex(L_454_arg0.userid)
		if entity.is_enemy(L_455_) then
			local L_456_ = {
				entity.get_prop(L_455_, "m_vecOrigin")
			}
			local L_457_ = {
				entity.hitbox_position(entity.get_local_player(), 0)
			}
			local L_458_ = L_114_func(
            {
				L_456_[1],
				L_456_[2]
			},
            {
				L_454_arg0.x,
				L_454_arg0.y
			},
            {
				L_457_[1],
				L_457_[2]
			}
        )
			local L_459_ = (L_457_[1] - L_458_[1]) ^ 2 + (L_457_[2] - L_458_[2]) ^ 2
			if L_459_ <= 1600 then
				L_113_.active_until = globals.realtime() + 7
				repeat -- ебать я гений да хуений?
					L_113_.current_offset = math.random(-6, 6)
				until L_113_.current_offset ~= 0
				if globals.realtime() - L_113_.last_print > 1 then
					L_15_func(string.format("anti-bruteforce activated (offset: %d)", L_113_.current_offset), 3, 255, 255, 255)
					L_11_(string.format("anti-bruteforce activated (offset: %d)", L_113_.current_offset))
					L_113_.last_print = globals.realtime()
				end
			end
		end
	end)
	local L_115_ = 0
	local L_116_ = false
	local L_117_ = 0
	local L_118_ = false
	local L_119_ = 0
	function update_state(L_460_arg0, L_461_arg1, L_462_arg2, L_463_arg3, L_464_arg4, L_465_arg5, L_466_arg6, L_467_arg7, L_468_arg8, L_469_arg9, L_470_arg10, L_471_arg11, L_472_arg12)
		local L_473_ = L_1_.get_lp()
		if not L_473_ or not L_1_.is_alive(L_473_) then
			return true, L_461_arg1
		end
		local L_474_ = globals.tickinterval()
		if L_471_arg11 == 0 or L_471_arg11 == nil or L_461_arg1 < L_471_arg11 then
			return L_472_arg12, L_461_arg1
		end
		local L_475_ = L_460_arg0.chokedcommands == 0
		local L_476_ = L_461_arg1 - L_471_arg11
		if not L_475_ then
			return L_472_arg12, L_471_arg11
		end
		if L_462_arg2 == "Off" and L_476_ >= L_474_ then
			return not L_472_arg12, L_461_arg1
		elseif L_462_arg2 == "Tickbased" and L_476_ >= L_463_arg3 * L_474_ then
			return not L_472_arg12, L_461_arg1
		elseif L_462_arg2 == "Chance" and L_476_ >= L_474_ then
			if math.random(1, 100) <= L_470_arg10 then
				return not L_472_arg12, L_461_arg1
			end
		elseif L_462_arg2 == "Settable Random" then
			local L_477_ = {
				L_465_arg5,
				L_466_arg6,
				L_467_arg7,
				L_468_arg8,
				L_469_arg9
			}
			local L_478_ = math.random(1, math.max(1, L_464_arg4))
			local L_479_ = L_477_[L_478_] or L_465_arg5
			if L_476_ >= L_479_ * L_474_ then
				return not L_472_arg12, L_461_arg1
			end
		end
		return L_472_arg12, L_471_arg11
	end
	last_switch = 0
	side = 1
	threeway_value = 0
	function thrreway(L_480_arg0, L_481_arg1, L_482_arg2, L_483_arg3)
		if L_480_arg0.chokedcommands ~= 0 then
			return threeway_value
		end
		if last_switch > globals.curtime() then
			last_switch = 0
		end
		if globals.curtime() - last_switch >= 0.001 then
			side = side % 3 + 1
			last_switch = globals.curtime()
		end
		if side == 1 then
			threeway_value = L_481_arg1
		elseif side == 2 then
			threeway_value = L_482_arg2
		elseif side == 3 then
			threeway_value = L_483_arg3
		end
		return threeway_value
	end
	spin_val = 0
	dir_val = 1
	function update_dist(L_484_arg0)
		spin_val = spin_val + L_484_arg0 * dir_val
		if spin_val >= 180 or spin_val <= -180 then
			spin_val = math.max(-180, math.min(180, spin_val))
			dir_val = -dir_val
		end
		return spin_val
	end
	spin2_val = 0
	function normalize_spin(L_485_arg0)
		L_485_arg0 = L_485_arg0 % 360
		if L_485_arg0 > 180 then
			L_485_arg0 = L_485_arg0 - 360
		end
		return L_485_arg0
	end
	function update_spin(L_486_arg0)
		spin2_val = normalize_spin(spin2_val + L_486_arg0)
		return spin2_val
	end
	last_upd_t = 0
	cur_value_rnd = 0
	function static_random(L_487_arg0, L_488_arg1)
		local L_489_ = globals.curtime()
		if last_upd_t > L_489_ then
			last_upd_t = 0
			return
		end
		if L_489_ - last_upd_t >= 0.25 then
			cur_value_rnd = math.random(L_487_arg0, L_488_arg1)
			last_upd_t = L_489_
		end
		return cur_value_rnd
	end
	yaw_rl = 0
	yaw_rl_def = 0
	local L_120_ = 0
	change_debug("add", "antiaim:at_targets()", "L1")
	change_debug("add", "antiaim:custom_desync()", "L373")
	change_debug("add", "entity:shifting()", "-1")
	change_debug("add", "entity:exploit.get()", "0")
	change_debug("add", "entity:defensive_diff.get()", "0")
	local function L_121_func(L_490_arg0)
		L_490_arg0.allow_send_packet = true
		ui.set(ref.enabled, true)
		ui.set(ref.yaw_base, "At Targets")
		ui.set(ref.pitch[1], "Minimal")
		ui.set(ref.yaw[1], "180")
		ui.set(ref.yaw_jitter[1], "Off")
		ui.set(ref.freestanding_body_yaw, false)
		ui.set(ref.roll, 0)
		local L_491_ = get_player_state(L_490_arg0)
		local L_492_ = L_60_[L_491_]
		if not L_492_ or (L_491_ ~= "Global" and not ui.get(L_492_.allow)) then
			L_492_ = L_60_["Global"]
		end
		if not L_1_.is_alive(L_1_.get_lp()) or not L_1_.get_lp() then
			L_117_ = 0
			return
		end
		local L_493_ = globals.curtime()
		local L_494_ = ui.get(L_492_.delay)
		local L_495_ = ui.get(L_492_.delay_t)
		local L_496_ = ui.get(L_492_.delay_c)
		local L_497_ = ui.get(L_492_.delay_rnd_select)
		local L_498_ = ui.get(L_492_.delay_rnd_1)
		local L_499_ = ui.get(L_492_.delay_rnd_2)
		local L_500_ = ui.get(L_492_.delay_rnd_3)
		local L_501_ = ui.get(L_492_.delay_rnd_4)
		local L_502_ = ui.get(L_492_.delay_rnd_5)
		L_116_, L_115_ = update_state(L_490_arg0, L_493_, L_494_, L_495_, L_497_, L_498_, L_499_, L_500_, L_501_, L_502_, L_496_, L_115_, L_116_)
		if ui.get(L_492_.yaw_select) == "Static" then
			local L_507_ = ui.get(L_492_.static_yaw) + L_113_.current_offset
			yaw_rl = ui.get(L_492_.static_yaw) + L_113_.current_offset
			ui.set(ref.yaw[2], clamp(L_507_, -180, 180))
		elseif ui.get(L_492_.yaw_select) == "L/R" then
			local L_508_ = ui.get(L_492_.rnd_yaw)
			local L_509_ = delayjitter(ui.get(L_492_.l_yaw) + L_113_.current_offset, ui.get(L_492_.r_yaw) + L_113_.current_offset, L_508_, L_116_)
			ui.set(ref.yaw[2], clamp(L_509_, -180, 180))
			yaw_rl = L_509_
		end
		ui.set(ref.yaw_jitter[1], ui.get(L_492_.yaw_jitter))
		local L_503_ = ui.get(L_492_.yaw_jitter_value) + math.random(0, math.abs(ui.get(L_492_.yaw_jitter_value)) * ui.get(L_492_.yaw_jitter_rnd) / 100)
		ui.set(ref.yaw_jitter[2], clamp(L_503_, -180, 180))
		local L_504_ = ui.get(L_492_.body_yaw)
		local L_505_ = ui.get(L_492_.body_yaw_value)
		if L_504_ ~= "Off" then
			ui.set(ref.body_yaw[1], "Static")
		else
			ui.set(ref.body_yaw[1], "Off")
		end
		change_debug("set_active", "antiaim:custom_desync()", false)
		if L_504_ == "Static" then
			ui.set(ref.body_yaw[2], L_505_)
		elseif L_504_ == "Jitter" then
			local L_510_ = L_116_ and -L_505_ or L_505_
			ui.set(ref.body_yaw[2], L_510_)
		elseif L_504_ == "Custom Jitter" then
			change_debug("set_active", "antiaim:custom_desync()", true)
			local L_511_ = L_116_ and -L_505_ or L_505_
			ui.set(ref.body_yaw[2], 0)
			if L_2_.get_dt() then
				if L_490_arg0.chokedcommands == 0 then
					L_490_arg0.allow_send_packet = false
					ui.set(ref.yaw[2], clamp(-(L_511_ + yaw_rl), -180, 180))
				end
			else
				ui.set(ref.body_yaw[2], L_511_)
			end
		end
		change_debug("set_value", "antiaim:at_targets()", client.current_threat() ~= nil and "L" .. client.current_threat() or "ERR")
		change_debug("set_value", "entity:shifting()", string.format("%d", L_2_.shifting))
		change_debug("set_value", "entity:exploit.get()", L_2_.get_dt() == true and "1" or "0")
		if static.diff < 0 then
			change_debug("set_value", "entity:defensive_diff.get()", string.format("%d", static.diff))
			change_debug("set_active", "entity:defensive_diff.get()", true)
		else
			change_debug("set_active", "entity:defensive_diff.get()", false)
		end

    ---WARNING: НЕ ФОРСИТЬ ЛЦ НА ФОЛС ЕСЛИ НЕ БРИК ЛЦ ИНАЧЕ НАХУЙ ДЕФЕНСИВ ПИК УМРЁТ
		if (ui.get(L_492_.break_lc) and L_2_.get_dt()) then
			L_490_arg0.force_defensive = true
		end
		local L_506_ = static.defensive
		if L_506_ and ui.get(L_492_.defensive_aa) then
			delay_ticks_def = (ui.get(L_492_.defensive_yaw) == "Jitter" or ui.get(L_492_.defensive_yaw) == "Snap Jitter") and ui.get(L_492_.defensive_yaw_delay) or L_495_
			delay_mode_def = (ui.get(L_492_.defensive_yaw) == "Jitter" or ui.get(L_492_.defensive_yaw) == "Snap Jitter") and "Tickbased" or L_494_
			L_118_, L_117_ = update_state(L_490_arg0, L_493_, delay_mode_def, delay_ticks_def, L_497_, L_498_, L_499_, L_500_, L_501_, L_502_, L_496_, L_117_, L_118_)
			ui.set(ref.yaw_jitter[1], "Off")
			if ui.get(L_492_.defensive_pitch) == "Static" then
				ui.set(ref.pitch[1], "Custom")
				ui.set(ref.pitch[2], ui.get(L_492_.defensive_pitch_static))
			elseif ui.get(L_492_.defensive_pitch) == "Jitter" then
				local L_512_, L_513_ = ui.get(L_492_.defensive_pitch_static), ui.get(L_492_.defensive_pitch_2)
				ui.set(ref.pitch[1], "Custom")
				ui.set(ref.pitch[2], L_118_ and L_512_ or L_513_)
			elseif ui.get(L_492_.defensive_pitch) == "Random" then
				ui.set(ref.pitch[1], "Custom")
				ui.set(ref.pitch[2], math.random(ui.get(L_492_.defensive_pitch_static), ui.get(L_492_.defensive_pitch_2)))
			elseif ui.get(L_492_.defensive_pitch) == "Sway" then
				ui.set(ref.pitch[1], "Custom")
				ui.set(ref.pitch[2], custom_sway(ui.get(L_492_.defensive_pitch_static), ui.get(L_492_.defensive_pitch_2)))
			elseif ui.get(L_492_.defensive_pitch) == "Static Random" then
				ui.set(ref.pitch[1], "Custom")
				ui.set(ref.pitch[2], static_random(ui.get(L_492_.defensive_pitch_static), ui.get(L_492_.defensive_pitch_2)))
			elseif ui.get(L_492_.defensive_pitch) == "Spin" then
				ui.set(ref.pitch[1], "Custom")
				ui.set(ref.pitch[2], L_112_func(ui.get(L_492_.defensive_pitch_static), ui.get(L_492_.defensive_pitch_2), 2.55))
			end
			if ui.get(L_492_.defensive_yaw) == "Static" then
				ui.set(ref.yaw[2], clamp(ui.get(L_492_.defensive_yaw_static), -180, 180))
				yar_rl_def = ui.get(L_492_.defensive_yaw_static)
			elseif ui.get(L_492_.defensive_yaw) == "Jitter" then
				local L_514_, L_515_ = ui.get(L_492_.defensive_yaw_static), ui.get(L_492_.defensive_yaw_2)
				yar_rl_def = L_118_ and L_514_ or L_515_
				ui.set(ref.yaw[2], L_118_ and clamp(L_514_, -180, 180) or clamp(L_515_, -180, 180))
			elseif ui.get(L_492_.defensive_yaw) == "Random" then
				local L_516_ = math.random(ui.get(L_492_.defensive_yaw_static), ui.get(L_492_.defensive_yaw_2))
				yar_rl_def = L_516_
				ui.set(ref.yaw[2], clamp(L_516_, -180, 180))
			elseif ui.get(L_492_.defensive_yaw) == "Spin" then
				local L_517_ = -L_111_func(globals.curtime() * (ui.get(L_492_.defensive_yaw_spin) * 10))
				yaw_rl_def = L_517_
				ui.set(ref.yaw[2], clamp(L_517_, -180, 180))
			elseif ui.get(L_492_.defensive_yaw) == "Negative Spin" then
				local L_518_ = L_111_func(globals.curtime() * (ui.get(L_492_.defensive_yaw_spin) * 10))
				yaw_rl_def = L_518_
				ui.set(ref.yaw[2], clamp(L_518_, -180, 180))
			elseif ui.get(L_492_.defensive_yaw) == "Sway" then
				local L_519_ = custom_sway_2(ui.get(L_492_.defensive_yaw_static), ui.get(L_492_.defensive_yaw_2))
				yaw_rl_def = L_519_
				ui.set(ref.yaw[2], clamp(L_519_, -180, 180))
			elseif ui.get(L_492_.defensive_yaw) == "3-Way" then
				local L_520_, L_521_, L_522_ = ui.get(L_492_.defensive_yaw_static), ui.get(L_492_.defensive_yaw_2), ui.get(L_492_.defensive_yaw_3)
				local L_523_ = thrreway(L_490_arg0, L_520_, L_521_, L_522_)
				yaw_rl_def = L_523_
				ui.set(ref.yaw[2], clamp(L_523_, -180, 180))
			elseif ui.get(L_492_.defensive_yaw) == "Distortion" then
				local L_524_ = update_dist(14)
				yaw_rl_def = L_524_
				ui.set(ref.yaw[2], clamp(L_524_, -180, 180))
			elseif ui.get(L_492_.defensive_yaw) == "Vandal" then
				local L_525_ = update_spin(15)
				yaw_rl_def = L_525_
				ui.set(ref.yaw[2], clamp(L_525_, -180, 180))
			elseif ui.get(L_492_.defensive_yaw) == "Snap Jitter" then
				local L_526_, L_527_ = ui.get(L_492_.defensive_yaw_static), ui.get(L_492_.defensive_yaw_2)
				yar_rl_def = L_116_ and L_526_ or L_527_
				ui.set(ref.yaw[2], L_116_ and clamp(L_526_, -180, 180) or clamp(L_527_, -180, 180))
			end
			if ui.get(L_492_.defensive_yaw) ~= "Snap Jitter" then
				if L_504_ == "Custom Jitter" then
					if L_2_.get_dt() then
						if L_490_arg0.chokedcommands == 0 then
							L_490_arg0.allow_send_packet = false
							ui.set(ref.body_yaw[1], "Static")
							ui.set(ref.body_yaw[2], 0)
							ui.set(ref.yaw[2], clamp(60 + yaw_rl_def, -180, 180))
						end
					else
						ui.set(ref.body_yaw[1], "Opposite")
					end
				else
					ui.set(ref.body_yaw[1], "Opposite")
				end
			else
				if L_504_ == "Static" then
					ui.set(ref.body_yaw[2], L_505_)
				elseif L_504_ == "Jitter" then
					local L_528_ = L_116_ and -L_505_ or L_505_
					ui.set(ref.body_yaw[2], L_528_)
				elseif L_504_ == "Custom Jitter" then
					local L_529_ = L_116_ and -L_505_ or L_505_
					ui.set(ref.body_yaw[2], 0)
					if L_2_.get_dt() then
						if L_490_arg0.chokedcommands == 0 then
							L_490_arg0.allow_send_packet = false
							ui.set(ref.yaw[2], clamp(-(L_529_ + yaw_rl), -180, 180))
						end
					else
						ui.set(ref.body_yaw[2], L_529_)
					end
				end
			end
		end
		if ui.get(L_78_) then
			ui.set(ref.edge_yaw, true)
		else
			ui.set(ref.edge_yaw, false)
		end
	end
	local function L_122_func()
		if L_81_ ~= 0 then
			return
		end
		if ui.get(L_72_) then
			ui.set(ref.freestand[1], true)
			ui.set(ref.freestand[2], "Always On")
		else
			ui.set(ref.freestand[1], false)
			ui.set(ref.freestand[2], "On Hotkey")
		end
	end
	local function L_123_func()
		if not ui.get(L_65_) then
			return
		end
		local L_530_ = L_1_.get_lp()
		if not L_530_ or not L_1_.is_alive(L_530_) then
			return
		end
		local L_531_ = vector(entity.get_origin(L_530_))
		local L_532_ = entity.get_players(true)
		for L_533_forvar0 = 1, #L_532_ do
			local L_534_ = L_532_[L_533_forvar0]
			local L_535_ = entity.get_player_weapon(L_534_)
			if L_535_ and entity.get_classname(L_535_) == "CKnife" then
				if vector(entity.get_origin(L_534_)):dist2d(L_531_) < 250 then
					ui.set(ref.yaw[1], "180")
					ui.set(ref.yaw[2], 180)
					return
				end
			end
		end
	end
	local L_124_ = globals.tickcount()
	local L_125_ = 1
	local function L_126_func()
		if not ui.get(L_50_) then
			return
		end
		local L_536_ = L_1_.get_lp()
		if not L_1_.is_alive(L_536_) then
			return
		end
		local L_537_ = entity.get_player_weapon(L_536_)
		if not L_537_ then
			return
		end
		L_125_ = weapons(L_537_).is_revolver and 18 or 2
		if ( ui.get(ref.dt[2]) or ui.get(ref.hs[2]) ) then
			if globals.tickcount() >= L_124_ + L_125_ then
				ui.set(ref.aimbot, true)
			else
				ui.set(ref.aimbot, false)
			end
		else
			L_124_ = globals.tickcount()
			ui.set(ref.aimbot, true)
		end
	end

---@config
	local function L_127_func(L_538_arg0)
		local L_539_, L_540_ = pcall(base64.decode, L_538_arg0)
		if not L_539_ then
			L_15_func("Failed to decode default config data", 3, 255, 100, 100)
			return false
		end
		local L_541_, L_542_ = pcall(json.parse, L_540_)
		if not L_541_ or type(L_542_) ~= "table" then
			L_15_func("Failed to parse default config data", 3, 255, 100, 100)
			return false
		end
		L_542_.config_name = "Default"
		return L_542_
	end
	local function L_128_func()
		if database.read("vandal_configs") == nil then
			database.write("vandal_configs", {})
		end
		if database.read("vandal_config_names") == nil then
			database.write("vandal_config_names", {})
		end
		local L_543_ = database.read("vandal_configs")
		local L_544_ = database.read("vandal_config_names")
		local L_545_ = false
		for L_546_forvar0 = 1, #L_544_ do
			if L_544_[L_546_forvar0] == "Default" then
				L_545_ = true
				break
			end
		end
		if not L_545_ then
			local L_547_ = L_127_func(default_config)
			if L_547_ then
				table.insert(L_544_, "Default")
				L_543_["Default"] = L_547_
				database.write("vandal_configs", L_543_)
				database.write("vandal_config_names", L_544_)
				database.flush()
			end
		end
	end
	local function L_129_func()
		L_128_func()
		local L_548_ = database.read("vandal_config_names")
		local L_549_ = {}
		for L_550_forvar0 = 1, #L_548_ do
			L_549_[L_550_forvar0] = L_548_[L_550_forvar0]
		end
		if #L_549_ == 0 then
			L_549_[1] = "Please create a config"
		end
		return L_549_
	end
	local L_130_ = L_129_func()
	local L_131_ = ui.new_listbox("AA", "Anti-Aimbot angles", "Configs", L_130_)
	local L_132_ = ui.new_textbox("AA", "Anti-Aimbot angles", "Config name")
	local function L_133_func()
		L_128_func()
		local L_551_ = database.read("vandal_config_names")
		if #L_551_ == 0 then
			L_15_func("No configs to export", 3, 255, 100, 100)
			return
		end
		local L_552_ = ui.get(L_131_) + 1
		if L_552_ > #L_551_ then
			L_15_func("Invalid config selected", 3, 255, 100, 100)
			return
		end
		local L_553_ = L_551_[L_552_]
		local L_554_ = {}
		L_554_.config_name = L_553_
		L_554_.center_indicators = ui.get(L_23_)
		L_554_.center_indicators_type = ui.get(L_25_)
		L_554_.color = {
			ui.get(L_24_)
		}
		L_554_.hit_logs = ui.get(L_26_)
		L_554_.hit_logs_color = {
			ui.get(L_27_)
		}
		L_554_.hit_logs_type = ui.get(L_28_)
		L_554_.recharge_fix = ui.get(L_50_)
		L_554_.fix_exploits = ui.get(L_51_)
		L_554_.delay_fix = ui.get(L_52_)
		L_554_._trashtalk = ui.get(L_53_)
		L_554_.console_filter = ui.get(L_54_)
		L_554_.state = ui.get(L_62_)
		L_554_.aa = {}
		for L_556_forvar0, L_557_forvar1 in pairs(L_60_) do
			L_554_.aa[L_556_forvar0] = {}
			for L_558_forvar0, L_559_forvar1 in pairs(L_557_forvar1) do
				L_554_.aa[L_556_forvar0][L_558_forvar0] = ui.get(L_559_forvar1)
			end
		end
		L_554_.backstab = ui.get(L_65_)
		L_554_.legit_aa = ui.get(L_66_)
		L_554_.legit_aa_type = ui.get(L_67_)
		L_554_.warmup_aa = ui.get(L_69_)
		L_554_.anti_bruteforce = ui.get(L_70_)
		L_554_.safehead = ui.get(L_71_)
		L_554_.ui = ui.get(L_31_)
		L_554_.animfix = ui.get(L_58_)
		L_554_.freestand = ui.get(L_72_)
		L_554_.manual_l = ui.get(L_73_)
		L_554_.manual_r = ui.get(L_74_)
		L_554_.manual_f = ui.get(L_75_)
		L_554_.manual_type = ui.get(L_77_)
		L_554_.edge_yaw = ui.get(L_78_)
		L_554_._custom_scope = ui.get(L_34_)
		L_554_.custom_scope_color = {
			ui.get(L_35_)
		}
		L_554_.custom_scope_size = ui.get(L_37_)
		L_554_.custom_scope_gap = ui.get(L_38_)
		L_554_.custom_scope_style = ui.get(L_36_)
		L_554_.custom_scope_disable_animation = ui.get(L_39_)
		L_554_.teammate_aimbot = ui.get(L_56_)
		L_554_._clantag = ui.get(L_55_)
		L_554_.manual_ind = ui.get(L_29_)
		L_554_.manual_ind_color = ui.get(L_30_)
		L_554_.revolver_helper = ui.get(L_40_)
		L_554_.damage_indicator = ui.get(L_41_)
		L_554_.damage_indicator_font = ui.get(L_42_)
		L_554_.aspect_ratio_reference = ui.get(L_44_)
		L_554_.enable_aspect_ratio = ui, get(L_43_)
		L_554_.debug_text = ui.get(L_45_)
		L_554_.debug_text_position = ui.get(L_46_)
		L_554_.velocity_modifier = ui.get(L_47_)
		L_554_.animated_zoom = ui.get(L_48_)
		L_554_.zoom_val = ui.get(L_49_)
		L_554_.fast_ladder = ui.get(L_68_)
		L_554_.flick_opposite = ui.get(L_79_)
		L_554_.fps_optimize = ui.get(L_57_)
		local L_555_ = base64.encode(json.stringify(L_554_))
		clipboard.set(L_555_)
		L_15_func("Exported config '" .. L_553_ .. "'", 3, 100, 255, 100)
	end
	local function L_134_func(L_560_arg0)
		local L_561_, L_562_ = pcall(base64.decode, L_560_arg0 or clipboard.get())
		if not L_561_ then
			L_15_func("Failed to decode config data", 3, 255, 100, 100)
			return
		end
		local L_563_, L_564_ = pcall(json.parse, L_562_)
		if not L_563_ or type(L_564_) ~= "table" then
			L_15_func("Failed to parse config data", 3, 255, 100, 100)
			return
		end
		if not L_564_.config_name then
			L_15_func("Invalid config format - no name found", 3, 255, 100, 100)
			return
		end
		L_128_func()
		local L_565_ = database.read("vandal_configs")
		local L_566_ = database.read("vandal_config_names")
		local L_567_ = L_564_.config_name
		local L_568_ = L_567_
		local L_569_ = 1
		while true do
			local L_570_ = false
			for L_571_forvar0 = 1, #L_566_ do
				if L_566_[L_571_forvar0] == L_567_ then
					L_570_ = true
					break
				end
			end
			if not L_570_ then
				break
			end
			L_567_ = L_568_ .. " (" .. L_569_ .. ")"
			L_569_ = L_569_ + 1
		end
		table.insert(L_566_, L_567_)
		L_565_[L_567_] = L_564_
		database.write("vandal_configs", L_565_)
		database.write("vandal_config_names", L_566_)
		database.flush()
		if L_564_.center_indicators ~= nil then
			ui.set(L_23_, L_564_.center_indicators)
		end
		if L_564_.center_indicators_type ~= nil then
			ui.set(L_25_, L_564_.center_indicators_type)
		end
		if L_564_.color ~= nil then
			ui.set(L_24_, unpack(L_564_.color))
		end
		if L_564_.hit_logs ~= nil then
			ui.set(L_26_, L_564_.hit_logs)
		end
		if L_564_.hit_logs_color ~= nil then
			ui.set(L_27_, unpack(L_564_.hit_logs_color))
		end
		if L_564_.hit_logs_type ~= nil then
			ui.set(L_28_, L_564_.hit_logs_type)
		end
		if L_564_.recharge_fix ~= nil then
			ui.set(L_50_, L_564_.recharge_fix)
		end
		if L_564_.fix_exploits ~= nil then
			ui.set(L_51_, L_564_.fix_exploits)
		end
		if L_564_.delay_fix ~= nil then
			ui.set(L_52_, L_564_.delay_fix)
		end
		if L_564_._trashtalk ~= nil then
			ui.set(L_53_, L_564_._trashtalk)
		end
		if L_564_.console_filter ~= nil then
			ui.set(L_54_, L_564_.console_filter)
		end
		if L_564_.state ~= nil then
			ui.set(L_62_, L_564_.state)
		end
		if L_564_.aa ~= nil then
			for L_572_forvar0, L_573_forvar1 in pairs(L_60_) do
				if L_564_.aa[L_572_forvar0] ~= nil then
					for L_574_forvar0, L_575_forvar1 in pairs(L_573_forvar1) do
						local L_576_ = L_564_.aa[L_572_forvar0][L_574_forvar0]
						if L_576_ ~= nil then
							ui.set(L_575_forvar1, L_576_)
						end
					end
				end
			end
		end
		if L_564_.backstab ~= nil then
			ui.set(L_65_, L_564_.backstab)
		end
		if L_564_.legit_aa ~= nil then
			ui.set(L_66_, L_564_.legit_aa)
		end
		if L_564_.legit_aa_type ~= nil then
			ui.set(L_67_, L_564_.legit_aa_type)
		end
		if L_564_.warmup_aa ~= nil then
			ui.set(L_69_, L_564_.warmup_aa)
		end
		if L_564_.anti_bruteforce ~= nil then
			ui.set(L_70_, L_564_.anti_bruteforce)
		end
		if L_564_.safehead ~= nil then
			ui.set(L_71_, L_564_.safehead)
		end
		if L_564_.gui ~= nil then
			ui.set(L_31_, L_564_.gui)
		end
		if L_564_.animfix ~= nil then
			ui.set(L_58_, L_564_.animfix)
		end
		if L_564_.freestand ~= nil then
			ui.set(L_72_, L_564_.freestand)
		end
		if L_564_.manual_l ~= nil then
			ui.set(L_73_, L_564_.manual_l)
		end
		if L_564_.manual_r ~= nil then
			ui.set(L_74_, L_564_.manual_r)
		end
		if L_564_.manual_f ~= nil then
			ui.set(L_75_, L_564_.manual_f)
		end
		if L_564_.manual_type ~= nil then
			ui.set(L_77_, L_564_.manual_type)
		end
		if L_564_.edge_yaw ~= nil then
			ui.set(L_78_, L_564_.edge_yaw)
		end
		if L_564_._custom_scope ~= nil then
			ui.set(L_34_, L_564_._custom_scope)
		end
		if L_564_.custom_scope_color ~= nil then
			ui.set(L_35_, unpack(L_564_.custom_scope_color))
		end
		if L_564_.custom_scope_size ~= nil then
			ui.set(L_37_, L_564_.custom_scope_size)
		end
		if L_564_.custom_scope_gap ~= nil then
			ui.set(L_38_, L_564_.custom_scope_gap)
		end
		if L_564_.custom_scope_style ~= nil then
			ui.set(L_36_, L_564_.custom_scope_style)
		end
		if L_564_.custom_scope_disable_animation ~= nil then
			ui.set(L_39_, L_564_.custom_scope_disable_animation)
		end
		if L_564_.teammate_aimbot ~= nil then
			ui.set(L_56_, L_564_.teammate_aimbot)
		end
		if L_564_._clantag ~= nil then
			ui.set(L_55_, L_564_._clantag)
		end
		if L_564_.manual_ind ~= nil then
			ui.set(L_29_, L_564_.manual_ind)
		end
		if L_564_.manual_ind_color ~= nil then
			ui.set(L_30_, L_564_.manual_ind_color)
		end
		if L_564_.revolver_helper ~= nil then
			ui.set(L_40_, L_564_.revolver_helper)
		end
		if L_564_.damage_indicator ~= nil then
			ui.set(L_41_, L_564_.damage_indicator)
		end
		if L_564_.damage_indicator_font ~= nil then
			ui.set(L_42_, L_564_.damage_indicator_font)
		end
		if L_564_.aspect_ratio_reference ~= nil then
			ui.set(L_44_, L_564_.aspect_ratio_reference)
		end
		if L_564_.enable_aspect_ratio ~= nil then
			ui.set(L_43_, L_564_.enable_aspect_ratio)
		end
		if L_564_.debug_text ~= nil then
			ui.set(L_45_, L_564_.debug_text)
		end
		if L_564_.debug_text_position ~= nil then
			ui.set(L_46_, L_564_.debug_text_position)
		end
		if L_564_.velocity_modifier ~= nil then
			ui.set(L_47_, L_564_.velocity_modifier)
		end
		if L_564_.animated_zoom ~= nil then
			ui.set(L_48_, L_564_.animated_zoom)
		end
		if L_564_.zoom_val ~= nil then
			ui.set(L_49_, L_564_.zoom_val)
		end
		if L_564_.fast_ladder ~= nil then
			ui.set(L_68_, L_564_.fast_ladder)
		end
		if L_564_.flick_opposite ~= nil then
			ui.set(L_79_, L_564_.flick_opposite)
		end
		if L_564_.fps_optimize ~= nil then
			ui.set(L_57_, L_564_.fps_optimize)
		end
		ui.update(L_131_, L_566_)
		for L_577_forvar0 = 1, #L_566_ do
			if L_566_[L_577_forvar0] == L_567_ then
				ui.set(L_131_, L_577_forvar0 - 1)
				break
			end
		end
		L_15_func("Imported config as '" .. L_567_ .. "'", 3, 100, 255, 100)
	end
	local L_135_ = ui.new_button("AA", "Anti-Aimbot angles", "Create Config", function()
		local L_578_ = ui.get(L_132_)
		if L_578_ == nil or L_578_ == "" then
			L_15_func("Please enter a config name", 3, 255, 100, 100)
			return
		end
		if string.len(L_578_) > 32 then
			L_15_func("Config name too long", 3, 255, 100, 100)
			return
		end
		L_128_func()
		local L_579_ = database.read("vandal_configs")
		local L_580_ = database.read("vandal_config_names")
		for L_582_forvar0 = 1, #L_580_ do
			if L_580_[L_582_forvar0] == L_578_ then
				L_15_func("Config name already exists", 3, 255, 100, 100)
				return
			end
		end
		local L_581_ = {}
		L_581_.center_indicators = ui.get(L_23_)
		L_581_.center_indicators_type = ui.get(L_25_)
		L_581_.color = {
			ui.get(L_24_)
		}
		L_581_.hit_logs = ui.get(L_26_)
		L_581_.hit_logs_color = {
			ui.get(L_27_)
		}
		L_581_.hit_logs_type = ui.get(L_28_)
		L_581_.recharge_fix = ui.get(L_50_)
		L_581_.fix_exploits = ui.get(L_51_)
		L_581_.delay_fix = ui.get(L_52_)
		L_581_._trashtalk = ui.get(L_53_)
		L_581_.console_filter = ui.get(L_54_)
		L_581_.state = ui.get(L_62_)
		L_581_.aa = {}
		for L_583_forvar0, L_584_forvar1 in pairs(L_60_) do
			L_581_.aa[L_583_forvar0] = {}
			for L_585_forvar0, L_586_forvar1 in pairs(L_584_forvar1) do
				L_581_.aa[L_583_forvar0][L_585_forvar0] = ui.get(L_586_forvar1)
			end
		end
		L_581_.backstab = ui.get(L_65_)
		L_581_.legit_aa = ui.get(L_66_)
		L_581_.legit_aa_type = ui.get(L_67_)
		L_581_.warmup_aa = ui.get(L_69_)
		L_581_.anti_bruteforce = ui.get(L_70_)
		L_581_.safehead = ui.get(L_71_)
		L_581_.gui = ui.get(L_31_)
		L_581_.animfix = ui.get(L_58_)
		L_581_.freestand = ui.get(L_72_)
		L_581_.manual_l = ui.get(L_73_)
		L_581_.manual_r = ui.get(L_74_)
		L_581_.manual_f = ui.get(L_75_)
		L_581_.manual_type = ui.get(L_77_)
		L_581_.edge_yaw = ui.get(L_78_)
		L_581_._custom_scope = ui.get(L_34_)
		L_581_.custom_scope_color = {
			ui.get(L_35_)
		}
		L_581_.custom_scope_size = ui.get(L_37_)
		L_581_.custom_scope_gap = ui.get(L_38_)
		L_581_.custom_scope_style = ui.get(L_36_)
		L_581_.custom_scope_disable_animation = ui.get(L_39_)
		L_581_.teammate_aimbot = ui.get(L_56_)
		L_581_._clantag = ui.get(L_55_)
		L_581_.manual_ind = ui.get(L_29_)
		L_581_.manual_ind_color = ui.get(L_30_)
		L_581_.revolver_helper = ui.get(L_40_)
		L_581_.damage_indicator = ui.get(L_41_)
		L_581_.damage_indicator_font = ui.get(L_42_)
		L_581_.aspect_ratio_reference = ui.get(L_44_)
		L_581_.fast_ladder = ui.get(L_68_)
		L_581_.flick_opposite = ui.get(L_79_)
		L_581_.enable_aspect_ratio = ui.get(L_43_)
		L_581_.debug_text = ui.get(L_45_)
		L_581_.debug_text_position = ui.get(L_46_)
		L_581_.velocity_modifier = ui.get(L_47_)
		L_581_.animated_zoom = ui.get(L_48_)
		L_581_.zoom_val = ui.get(L_49_)
		L_581_.fps_optimize = ui.get(L_57_)
		table.insert(L_580_, L_578_)
		L_579_[L_578_] = L_581_
		database.write("vandal_configs", L_579_)
		database.write("vandal_config_names", L_580_)
		database.flush()
		ui.update(L_131_, L_580_)
		L_15_func("Config '" .. L_578_ .. "' created", 3, 100, 255, 100)
	end)
	local L_136_ = ui.new_button("AA", "Anti-Aimbot angles", "Save Config", function()
		L_128_func()
		local L_587_ = database.read("vandal_config_names")
		local L_588_ = database.read("vandal_configs")
		if #L_587_ == 0 then
			L_15_func("No configs to save to", 3, 255, 100, 100)
			return
		end
		local L_589_ = ui.get(L_131_) + 1
		if L_589_ > #L_587_ then
			L_15_func("Invalid config selected", 3, 255, 100, 100)
			return
		end
		local L_590_ = L_587_[L_589_]
		if L_590_ == "Default" then
			L_15_func("Cannot save to Default config", 3, 255, 100, 100)
			return
		end
		local L_591_ = {}
		L_591_.center_indicators = ui.get(L_23_)
		L_591_.center_indicators_type = ui.get(L_25_)
		L_591_.color = {
			ui.get(L_24_)
		}
		L_591_.hit_logs = ui.get(L_26_)
		L_591_.hit_logs_color = {
			ui.get(L_27_)
		}
		L_591_.hit_logs_type = ui.get(L_28_)
		L_591_.recharge_fix = ui.get(L_50_)
		L_591_.fix_exploits = ui.get(L_51_)
		L_591_.delay_fix = ui.get(L_52_)
		L_591_._trashtalk = ui.get(L_53_)
		L_591_.console_filter = ui.get(L_54_)
		L_591_.state = ui.get(L_62_)
		L_591_.aa = {}
		for L_592_forvar0, L_593_forvar1 in pairs(L_60_) do
			L_591_.aa[L_592_forvar0] = {}
			for L_594_forvar0, L_595_forvar1 in pairs(L_593_forvar1) do
				L_591_.aa[L_592_forvar0][L_594_forvar0] = ui.get(L_595_forvar1)
			end
		end
		L_591_.backstab = ui.get(L_65_)
		L_591_.legit_aa = ui.get(L_66_)
		L_591_.legit_aa_type = ui.get(L_67_)
		L_591_.warmup_aa = ui.get(L_69_)
		L_591_.anti_bruteforce = ui.get(L_70_)
		L_591_.safehead = ui.get(L_71_)
		L_591_.gui = ui.get(L_31_)
		L_591_.animfix = ui.get(L_58_)
		L_591_.freestand = ui.get(L_72_)
		L_591_.manual_l = ui.get(L_73_)
		L_591_.manual_r = ui.get(L_74_)
		L_591_.manual_f = ui.get(L_75_)
		L_591_.manual_type = ui.get(L_77_)
		L_591_.edge_yaw = ui.get(L_78_)
		L_591_._custom_scope = ui.get(L_34_)
		L_591_.custom_scope_color = {
			ui.get(L_35_)
		}
		L_591_.custom_scope_size = ui.get(L_37_)
		L_591_.custom_scope_gap = ui.get(L_38_)
		L_591_.custom_scope_style = ui.get(L_36_)
		L_591_.custom_scope_disable_animation = ui.get(L_39_)
		L_591_.teammate_aimbot = ui.get(L_56_)
		L_591_._clantag = ui.get(L_55_)
		L_591_.manual_ind = ui.get(L_29_)
		L_591_.manual_ind_color = ui.get(L_30_)
		L_591_.revolver_helper = ui.get(L_40_)
		L_591_.damage_indicator = ui.get(L_41_)
		L_591_.damage_indicator_font = ui.get(L_42_)
		L_591_.aspect_ratio_reference = ui.get(L_44_)
		L_591_.fast_ladder = ui.get(L_68_)
		L_591_.flick_opposite = ui.get(L_79_)
		L_591_.enable_aspect_ratio = ui.get(L_43_)
		L_591_.debug_text = ui.get(L_45_)
		L_591_.debug_text_position = ui.get(L_46_)
		L_591_.velocity_modifier = ui.get(L_47_)
		L_591_.animated_zoom = ui.get(L_48_)
		L_591_.zoom_val = ui.get(L_49_)
		L_591_.fps_optimize = ui.get(L_57_)
		L_588_[L_590_] = L_591_
		database.write("vandal_configs", L_588_)
		database.flush()
		L_15_func("Config '" .. L_590_ .. "' saved", 3, 100, 255, 100)
	end)
	local L_137_ = ui.new_button("AA", "Anti-Aimbot angles", "Load Config", function()
		L_128_func()
		local L_596_ = database.read("vandal_config_names")
		local L_597_ = database.read("vandal_configs")
		if #L_596_ == 0 then
			L_15_func("No configs to load", 3, 255, 100, 100)
			return
		end
		local L_598_ = ui.get(L_131_) + 1
		if L_598_ > #L_596_ then
			L_15_func("Invalid config selected", 3, 255, 100, 100)
			return
		end
		local L_599_ = L_596_[L_598_]
		local L_600_ = L_597_[L_599_]
		if not L_600_ then
			L_15_func("Config data not found", 3, 255, 100, 100)
			return
		end
		if L_600_.center_indicators ~= nil then
			ui.set(L_23_, L_600_.center_indicators)
		end
		if L_600_.center_indicators_type ~= nil then
			ui.set(L_25_, L_600_.center_indicators_type)
		end
		if L_600_.color ~= nil then
			ui.set(L_24_, unpack(L_600_.color))
		end
		if L_600_.hit_logs ~= nil then
			ui.set(L_26_, L_600_.hit_logs)
		end
		if L_600_.hit_logs_color ~= nil then
			ui.set(L_27_, unpack(L_600_.hit_logs_color))
		end
		if L_600_.hit_logs_type ~= nil then
			ui.set(L_28_, L_600_.hit_logs_type)
		end
		if L_600_.recharge_fix ~= nil then
			ui.set(L_50_, L_600_.recharge_fix)
		end
		if L_600_.fix_exploits ~= nil then
			ui.set(L_51_, L_600_.fix_exploits)
		end
		if L_600_.delay_fix ~= nil then
			ui.set(L_52_, L_600_.delay_fix)
		end
		if L_600_._trashtalk ~= nil then
			ui.set(L_53_, L_600_._trashtalk)
		end
		if L_600_.console_filter ~= nil then
			ui.set(L_54_, L_600_.console_filter)
		end
		if L_600_.state ~= nil then
			ui.set(L_62_, L_600_.state)
		end
		if L_600_.aa ~= nil then
			for L_601_forvar0, L_602_forvar1 in pairs(L_60_) do
				if L_600_.aa[L_601_forvar0] ~= nil then
					for L_603_forvar0, L_604_forvar1 in pairs(L_602_forvar1) do
						local L_605_ = L_600_.aa[L_601_forvar0][L_603_forvar0]
						if L_605_ ~= nil then
							ui.set(L_604_forvar1, L_605_)
						end
					end
				end
			end
		end
		if L_600_.backstab ~= nil then
			ui.set(L_65_, L_600_.backstab)
		end
		if L_600_.legit_aa ~= nil then
			ui.set(L_66_, L_600_.legit_aa)
		end
		if L_600_.legit_aa_type ~= nil then
			ui.set(L_67_, L_600_.legit_aa_type)
		end
		if L_600_.warmup_aa ~= nil then
			ui.set(L_69_, L_600_.warmup_aa)
		end
		if L_600_.anti_bruteforce ~= nil then
			ui.set(L_70_, L_600_.anti_bruteforce)
		end
		if L_600_.safehead ~= nil then
			ui.set(L_71_, L_600_.safehead)
		end
		if L_600_.gui ~= nil then
			ui.set(L_31_, L_600_.gui)
		end
		if L_600_.fps_optimize ~= nil then
			ui.set(L_57_, L_600_.fps_optimize)
		end
		if L_600_.animfix ~= nil then
			ui.set(L_58_, L_600_.animfix)
		end
		if L_600_.freestand ~= nil then
			ui.set(L_72_, L_600_.freestand)
		end
		if L_600_.manual_l ~= nil then
			ui.set(L_73_, L_600_.manual_l)
		end
		if L_600_.manual_r ~= nil then
			ui.set(L_74_, L_600_.manual_r)
		end
		if L_600_.manual_f ~= nil then
			ui.set(L_75_, L_600_.manual_f)
		end
		if L_600_.manual_type ~= nil then
			ui.set(L_77_, L_600_.manual_type)
		end
		if L_600_.edge_yaw ~= nil then
			ui.set(L_78_, L_600_.edge_yaw)
		end
		if L_600_._custom_scope ~= nil then
			ui.set(L_34_, L_600_._custom_scope)
		end
		if L_600_.custom_scope_color ~= nil then
			ui.set(L_35_, unpack(L_600_.custom_scope_color))
		end
		if L_600_.custom_scope_size ~= nil then
			ui.set(L_37_, L_600_.custom_scope_size)
		end
		if L_600_.custom_scope_gap ~= nil then
			ui.set(L_38_, L_600_.custom_scope_gap)
		end
		if L_600_.custom_scope_style ~= nil then
			ui.set(L_36_, L_600_.custom_scope_style)
		end
		if L_600_.custom_scope_disable_animation ~= nil then
			ui.set(L_39_, L_600_.custom_scope_disable_animation)
		end
		if L_600_.teammate_aimbot ~= nil then
			ui.set(L_56_, L_600_.teammate_aimbot)
		end
		if L_600_._clantag ~= nil then
			ui.set(L_55_, L_600_._clantag)
		end
		if L_600_.manual_ind ~= nil then
			ui.set(L_29_, L_600_.manual_ind)
		end
		if L_600_.manual_ind_color ~= nil then
			ui.set(L_30_, L_600_.manual_ind_color)
		end
		if L_600_.revolver_helper ~= nil then
			ui.set(L_40_, L_600_.revolver_helper)
		end
		if L_600_.damage_indicator ~= nil then
			ui.set(L_41_, L_600_.damage_indicator)
		end
		if L_600_.damage_indicator_font ~= nil then
			ui.set(L_42_, L_600_.damage_indicator_font)
		end
		if L_600_.aspect_ratio_reference ~= nil then
			ui.set(L_44_, L_600_.aspect_ratio_reference)
		end
		if L_600_.fast_ladder ~= nil then
			ui.set(L_68_, L_600_.fast_ladder)
		end
		if L_600_.flick_opposite ~= nil then
			ui.set(L_79_, L_600_.flick_opposite)
		end
		if L_600_.enable_aspect_ratio ~= nil then
			ui.set(L_43_, L_600_.enable_aspect_ratio)
		end
		if L_600_.debug_text ~= nil then
			ui.set(L_45_, L_600_.debug_text)
		end
		if L_600_.debug_text_position ~= nil then
			ui.set(L_46_, L_600_.debug_text_position)
		end
		if L_600_.velocity_modifier ~= nil then
			ui.set(L_47_, L_600_.velocity_modifier)
		end
		if L_600_.animated_zoom ~= nil then
			ui.set(L_48_, L_600_.animated_zoom)
		end
		if L_600_.zoom_val ~= nil then
			ui.set(L_49_, L_600_.zoom_val)
		end
		L_15_func("Config '" .. L_599_ .. "' loaded", 3, 100, 255, 100)
	end)
	local L_138_ = ui.new_button("AA", "Anti-Aimbot angles", "Delete Config", function()
		L_128_func()
		local L_606_ = database.read("vandal_config_names")
		local L_607_ = database.read("vandal_configs")
		if #L_606_ == 0 then
			L_15_func("No configs to delete", 3, 255, 100, 100)
			return
		end
		local L_608_ = ui.get(L_131_) + 1
		if L_608_ > #L_606_ then
			L_15_func("Invalid config selected", 3, 255, 100, 100)
			return
		end
		local L_609_ = L_606_[L_608_]
		if L_609_ == "Default" then
			L_15_func("Cannot delete Default config", 3, 255, 100, 100)
			return
		end
		table.remove(L_606_, L_608_)
		L_607_[L_609_] = nil
		database.write("vandal_configs", L_607_)
		database.write("vandal_config_names", L_606_)
		database.flush()
		ui.update(L_131_, L_606_)
		L_15_func("Config '" .. L_609_ .. "' deleted", 3, 255, 150, 150)
	end)
	local L_139_ = ui.new_button("AA", "Anti-Aimbot angles", "Import Config", function()
		L_134_func()
	end)
	local L_140_ = ui.new_button("AA", "Anti-Aimbot angles", "Export Config", function()
		L_128_func()
		local L_610_ = database.read("vandal_config_names")
		local L_611_ = database.read("vandal_configs")
		if #L_610_ == 0 then
			L_15_func("No configs to export", 3, 255, 100, 100)
			return
		end
		local L_612_ = ui.get(L_131_) + 1
		if L_612_ > #L_610_ then
			L_15_func("Invalid config selected", 3, 255, 100, 100)
			return
		end
		local L_613_ = L_610_[L_612_]
		if L_613_ == "Default" then
			L_15_func("Cannot export Default config", 3, 255, 100, 100)
			return
		end
		local L_614_ = L_611_[L_613_]
		if not L_614_ then
			L_15_func("Config data not found", 3, 255, 100, 100)
			return
		end
		L_614_.config_name = L_613_
		local L_615_ = base64.encode(json.stringify(L_614_))
		clipboard.set(L_615_)
		L_15_func("Exported config '" .. L_613_ .. "'", 3, 100, 255, 100)
	end)
	local function L_141_func()
		ui.set_visible(L_131_, L_17_ == 5)
		ui.set_visible(L_132_, L_17_ == 5)
		ui.set_visible(L_135_, L_17_ == 5)
		ui.set_visible(L_138_, L_17_ == 5)
		ui.set_visible(L_136_, L_17_ == 5)
		ui.set_visible(L_137_, L_17_ == 5)
		ui.set_visible(L_140_, L_17_ == 5)
		ui.set_visible(L_139_, L_17_ == 5)
	end
	L_128_func()

---@end



---@skeet_elements_hider_start
	local function L_142_func()
		local L_616_ = {
			ref.enabled,
			ref.pitch[1],
			ref.pitch[2],
			ref.yaw_base,
			ref.yaw[1],
			ref.yaw[2],
			ref.yaw_jitter[1],
			ref.yaw_jitter[2],
			ref.body_yaw[1],
			ref.body_yaw[2],
			ref.freestanding_body_yaw,
			ref.edge_yaw,
			ref.freestand[1],
			ref.freestand[2],
			ref.roll
		}
		for L_617_forvar0, L_618_forvar1 in ipairs(L_616_) do
			ui.set_visible(L_618_forvar1, false)
		end
	end
	local function L_143_func()
		local L_619_ = {
			ref.enabled,
			ref.pitch[1],
			ref.pitch[2],
			ref.yaw_base,
			ref.yaw[1],
			ref.yaw[2],
			ref.yaw_jitter[1],
			ref.yaw_jitter[2],
			ref.body_yaw[1],
			ref.body_yaw[2],
			ref.freestanding_body_yaw,
			ref.edge_yaw,
			ref.freestand[1],
			ref.freestand[2],
			ref.roll,
			ref.fakelag_limit,
			ref.variability,
			ref.falelag_enabled[1],
			ref.falelag_enabled[2],
			ref.fakelag_amount
		}
		for L_620_forvar0, L_621_forvar1 in ipairs(L_619_) do
			ui.set_visible(L_621_forvar1, true)
		end
	end
	local function L_144_func()
		local L_622_ = {
			ref.fakelag_limit,
			ref.variability,
			ref.falelag_enabled[1],
			ref.falelag_enabled[2],
			ref.fakelag_amount
		}
		for L_623_forvar0, L_624_forvar1 in ipairs(L_622_) do
			ui.set_visible(L_624_forvar1, L_17_ == 2)
		end
	end
---@skeet_elements_hider_end

---@hitlogs
	local L_145_ = 0
	local L_146_ = {
		"generic",
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
	}
	local L_147_ = {}
	local function L_148_func(L_625_arg0)
		local L_626_ = {}
		if L_625_arg0.teleported then
			table.insert(L_626_, "LC")
		end
		if L_625_arg0.interpolated then
			table.insert(L_626_, "I")
		end
		if L_625_arg0.extrapolated then
			table.insert(L_626_, "EX")
		end
		if L_625_arg0.high_priority then
			table.insert(L_626_, "HP")
		end
		L_147_[L_625_arg0.id] = {
			tick = L_625_arg0.tick,
			predicted_damage = L_625_arg0.damage,
			predicted_hitgroup = L_625_arg0.hitgroup,
			hit_chance = L_625_arg0.hit_chance,
			backtrack_ticks = globals.tickcount() - L_625_arg0.tick,
			flags = #L_626_ > 0 and table.concat(L_626_) or nil,
			timestamp = client.timestamp()
		}
	end
	local function L_149_func(L_627_arg0)
		if L_627_arg0.hitgroup == 1 and entity.get_prop(L_627_arg0.target, "m_iHealth") <= 0 then
			L_145_ = L_145_ + 1
		end
		if not ui.get(L_26_) then
			return
		end
		local L_628_ = L_147_[L_627_arg0.id]
		local L_629_ = L_628_ and L_628_.predicted_hitgroup or L_627_arg0.hitgroup
		local L_630_ = L_629_ ~= L_627_arg0.hitgroup and string.format("%s (%s)", L_146_[L_627_arg0.hitgroup + 1] or "?", L_146_[L_629_ + 1] or "?") or L_146_[L_627_arg0.hitgroup + 1] or "?"
		local L_631_ = L_628_ and L_628_.backtrack_ticks or 0
		local L_632_ = L_628_ and L_628_.predicted_damage or L_627_arg0.damage
		local L_633_ = L_632_ ~= L_627_arg0.damage and string.format("%d (%d)", L_627_arg0.damage, L_632_) or tostring(L_627_arg0.damage)
		local L_634_ = L_628_ and L_628_.hit_chance or "?"
		local L_635_ = math.ceil(client.timestamp() - L_628_.timestamp, 0)
		if L_9_func(ui.get(L_28_), "Under Crosshair") then
			L_15_func(string.format("Registered shot in %s's %s for %s dmg (hc: %d%%, lag_comp: %dt%s, delay: %s ms)",
            entity.get_player_name(L_627_arg0.target),
            L_630_,
            L_633_,
            L_634_,
            L_631_,
            "",
            L_635_
        ), 3, ui.get(L_27_))
		end
		if L_9_func(ui.get(L_28_), "Console") then
			L_11_(string.format("Registered shot in %s's %s for %s dmg (hc: %d%%, lag_comp: %dt%s, delay: %s ms)",
            entity.get_player_name(L_627_arg0.target),
            L_630_,
            L_633_,
            L_634_,
            L_631_,
            "",
            L_635_
        ))
		end
		L_147_[L_627_arg0.id] = nil
	end
	local function L_150_func(L_636_arg0)
		if not ui.get(L_26_) then
			return
		end
		local L_637_ = L_146_[L_636_arg0.hitgroup + 1] or "?"
		local L_638_ = L_147_[L_636_arg0.id]
		local L_639_ = L_638_ and L_638_.backtrack_ticks or 0
		local L_640_ = L_638_ and L_638_.hit_chance or "?"
		local L_641_ = L_638_ and L_638_.predicted_damage or "?"
		local L_642_ = L_638_ and L_638_.flags and string.format(", Flags: [%s]", L_638_.flags) or ""
		if L_9_func(ui.get(L_28_), "Under Crosshair") then
			L_15_func(string.format("Missed shot in %s's %s due to %s (%s dmg, hc: %d%%, lag_comp: %dt%s)",
            entity.get_player_name(L_636_arg0.target),
            L_637_,
            L_636_arg0.reason,
            L_641_,
            L_640_,
            L_639_,
            L_642_
        ), 3, ui.get(L_27_))
		end
		if L_9_func(ui.get(L_28_), "Console") then
			L_11_(string.format("Missed shot in %s's %s due to %s (%s dmg, hc: %d%%, lag_comp: %dt%s)",
            entity.get_player_name(L_636_arg0.target),
            L_637_,
            L_636_arg0.reason,
            L_641_,
            L_640_,
            L_639_,
            L_642_
        ))
		end
		L_147_[L_636_arg0.id] = nil
	end
---@end

---@console filter
	local function L_151_func()
		if ui.get(L_54_) then
			cvar.con_filter_enable:set_int(1)
			cvar.con_filter_text:set_string("IrWL5106TZZKNFPz4P4Gl3pSN?J370f5hi373ZjPg%VOVh6lN")
		else
			cvar.con_filter_enable:set_int(0)
			cvar.con_filter_text:set_string("")
		end
	end
	ui.set_callback(L_54_, L_151_func)
---@end

---@watermark
	local function L_152_func()
		if not L_9_func(ui.get(L_31_), "Watermark") then
			return
		end
		local L_643_ = ui.get(L_32_)
		local L_644_, L_645_ = client.screen_size()
		local L_646_ = math.floor(client.latency() * 1000)
		local L_647_ = {
			ui.get(L_33_)
		}
		local L_648_, L_649_, L_650_, L_651_ = unpack(L_647_)
		local L_652_ = gradient_text({
			L_648_,
			L_649_,
			L_650_
		}, {
			255,
			255,
			255
		}, "beta ", 3.33)
		local L_653_ = "vandal " .. L_652_ .. "\aFFFFFFFF" .. string.format("/ %s / %d ms", username, L_646_)
		local L_654_, L_655_ = 5, 5
		local L_656_ = "b"
		local L_657_, L_658_ = renderer.measure_text(L_656_, L_653_)
		local L_659_ = L_657_ + L_655_
		local L_660_ = L_658_ + L_655_
		local L_661_, L_662_
		if L_643_ == "Right upper" then
			L_661_ = L_644_ - L_659_ - L_654_
			L_662_ = L_654_
		elseif L_643_ == "Left upper" then
			L_661_ = L_654_
			L_662_ = L_654_
		elseif L_643_ == "Down centered" then
			L_661_ = (L_644_ - L_659_) / 2
			L_662_ = L_645_ - L_660_ - L_654_
		else
			L_661_ = L_644_ - L_659_ - L_654_
			L_662_ = L_654_
		end
		renderer.text(L_661_ + L_659_ - L_657_ - L_655_, L_662_ + L_655_, 255, 255, 255, 255, L_656_, 0, L_653_)
	end

---@end

---@scope overlay
	local function L_153_func(L_663_arg0, L_664_arg1, L_665_arg2, L_666_arg3, L_667_arg4, L_668_arg5, L_669_arg6)
		local L_670_, L_671_ = L_665_arg2 - L_663_arg0, L_666_arg3 - L_664_arg1
		local L_672_ = math.sqrt(L_670_ * L_670_ + L_671_ * L_671_)
		local L_673_ = 1  -- шаг в пикселях
		local L_674_ = math.max(1, math.floor(L_672_ / L_673_))
		for L_675_forvar0 = 0, L_674_ - 1 do
			local L_676_ = L_675_forvar0 / L_674_
			local L_677_ = L_667_arg4[1] + (L_668_arg5[1] - L_667_arg4[1]) * L_676_
			local L_678_ = L_667_arg4[2] + (L_668_arg5[2] - L_667_arg4[2]) * L_676_
			local L_679_ = L_667_arg4[3] + (L_668_arg5[3] - L_667_arg4[3]) * L_676_
			local L_680_ = L_667_arg4[4] + (L_668_arg5[4] - L_667_arg4[4]) * L_676_
			local L_681_ = L_663_arg0 + L_670_ * L_676_
			local L_682_ = L_664_arg1 + L_671_ * L_676_
			local L_683_ = (L_675_forvar0 + 1) / L_674_
			local L_684_ = L_663_arg0 + L_670_ * L_683_
			local L_685_ = L_664_arg1 + L_671_ * L_683_
			renderer.line(math.floor(L_681_ + 0.5), math.floor(L_682_ + 0.5), math.floor(L_684_ + 0.5), math.floor(L_685_ + 0.5), L_677_, L_678_, L_679_, L_680_)
		end
	end
	local L_154_ = 0
	local function L_155_func()
		local L_686_ = L_1_.get_lp()
		if not L_686_ or not L_1_.is_alive(L_686_) then
			return
		end
		if not ui.get(L_34_) then
			return
		end
		ui.set(ref.scope_overlay, false)
		local L_687_ = entity.get_local_player()
		if not L_687_ then
			return
		end
		local L_688_, L_689_ = client.screen_size()
		local L_690_ = ui.get(L_37_) * L_689_ / 1080
		local L_691_ = ui.get(L_38_) * L_689_ / 1080
		local L_692_ = entity.get_prop(L_687_, 'm_bIsScoped') == 1 and entity.get_prop(L_687_, 'm_bResumeZoom') == 0
		if ui.get(L_39_) then
			L_154_ = L_692_ and 1 or 0
		else
			L_154_ = L_7_(L_154_, L_692_ and 1 or 0, 10 * globals.frametime())
		end
		if L_154_ < 0.01 then
			return
		end
		local L_693_ = ui.get(L_36_)
		local L_694_ = L_690_ * L_154_
		local L_695_ = {
			ui.get(L_35_)
		}
		local L_696_ = {
			L_695_[1],
			L_695_[2],
			L_695_[3],
			0
		}
		local L_697_ = {
			L_695_[1],
			L_695_[2],
			L_695_[3],
			L_695_[4] * L_154_
		}
		if L_693_ == "Default" then
			renderer.gradient(L_688_ / 2, L_689_ / 2 - L_691_ - L_694_, 1, L_694_,
                          L_696_[1], L_696_[2], L_696_[3], L_696_[4],
                          L_697_[1], L_697_[2], L_697_[3], L_697_[4], false)
			renderer.gradient(L_688_ / 2, L_689_ / 2 + L_691_, 1, L_694_,
                          L_697_[1], L_697_[2], L_697_[3], L_697_[4],
                          L_696_[1], L_696_[2], L_696_[3], L_696_[4], false)
			renderer.gradient(L_688_ / 2 - L_691_ - L_694_, L_689_ / 2, L_694_, 1,
                          L_696_[1], L_696_[2], L_696_[3], L_696_[4],
                          L_697_[1], L_697_[2], L_697_[3], L_697_[4], true)
			renderer.gradient(L_688_ / 2 + L_691_, L_689_ / 2, L_694_, 1,
                          L_697_[1], L_697_[2], L_697_[3], L_697_[4],
                          L_696_[1], L_696_[2], L_696_[3], L_696_[4], true)
		elseif L_693_ == "Inverted" then
			renderer.gradient(L_688_ / 2, L_689_ / 2 - L_691_ - L_694_, 1, L_694_,
                          L_697_[1], L_697_[2], L_697_[3], L_697_[4],
                          L_696_[1], L_696_[2], L_696_[3], L_696_[4], false)
			renderer.gradient(L_688_ / 2, L_689_ / 2 + L_691_, 1, L_694_,
                          L_696_[1], L_696_[2], L_696_[3], L_696_[4],
                          L_697_[1], L_697_[2], L_697_[3], L_697_[4], false)
			renderer.gradient(L_688_ / 2 - L_691_ - L_694_, L_689_ / 2, L_694_, 1,
                          L_697_[1], L_697_[2], L_697_[3], L_697_[4],
                          L_696_[1], L_696_[2], L_696_[3], L_696_[4], true)
			renderer.gradient(L_688_ / 2 + L_691_, L_689_ / 2, L_694_, 1,
                          L_696_[1], L_696_[2], L_696_[3], L_696_[4],
                          L_697_[1], L_697_[2], L_697_[3], L_697_[4], true)
		elseif L_693_ == "X-Style" then
			local L_698_, L_699_ = (L_688_ / 2) + 0, (L_689_ / 2)
			local L_700_ = L_691_ + L_694_
			L_153_func(L_698_ - L_700_, L_699_ - L_700_, L_698_ - L_691_, L_699_ - L_691_, L_696_, L_697_, 1)
			L_153_func(L_698_ + L_700_, L_699_ + L_700_, L_698_ + L_691_, L_699_ + L_691_, L_696_, L_697_, 1)
			L_153_func(L_698_ + L_700_, L_699_ - L_700_, L_698_ + L_691_, L_699_ - L_691_, L_696_, L_697_, 1)
			L_153_func(L_698_ - L_700_, L_699_ + L_700_, L_698_ - L_691_, L_699_ + L_691_, L_696_, L_697_, 1)
		elseif L_693_ == "X-Style Inverted" then
			local L_701_, L_702_ = (L_688_ / 2) + 0, (L_689_ / 2)
			local L_703_ = L_691_ + L_694_
			L_153_func(L_701_ - L_703_, L_702_ - L_703_, L_701_ - L_691_, L_702_ - L_691_, L_697_, L_696_, 1)
			L_153_func(L_701_ + L_703_, L_702_ + L_703_, L_701_ + L_691_, L_702_ + L_691_, L_697_, L_696_, 1)
			L_153_func(L_701_ + L_703_, L_702_ - L_703_, L_701_ + L_691_, L_702_ - L_691_, L_697_, L_696_, 1)
			L_153_func(L_701_ - L_703_, L_702_ + L_703_, L_701_ - L_691_, L_702_ + L_691_, L_697_, L_696_, 1)
		end
		ui.set_visible(ref.scope_overlay, true)
	end


---@end

---@manual ind
	manual_alpha_left = 255
	manual_alpha_right = 255
	manual_offset = 0
	local function L_156_func()
		if not ui.get(L_29_) then
			manual_alpha_left = L_8_(manual_alpha_left, 170, 10)
			manual_alpha_right = L_8_(manual_alpha_right, 170, 10)
			return
		end
		local L_704_ = L_1_.get_lp()
		if not L_704_ or not L_1_.is_alive(L_704_) then
			manual_alpha_left = L_8_(manual_alpha_left, 170, 10)
			manual_alpha_right = L_8_(manual_alpha_right, 170, 10)
			return
		end
		local L_705_, L_706_ = client.screen_size()
		local L_707_ = L_1_.isScoped(L_704_)
		manual_offset = L_8_(manual_offset, L_707_ and 22 or 0, 15)
		local L_708_, L_709_, L_710_ = unpack({
			ui.get(L_30_)
		})
		local L_711_ = (L_81_ == -90) and 255 or 100
		local L_712_ = (L_81_ == 90) and 255 or 100
		manual_alpha_left = L_8_(manual_alpha_left, L_711_, 10)
		manual_alpha_right = L_8_(manual_alpha_right, L_712_, 10)
		if manual_alpha_left > 1 then
			renderer.text((L_705_ / 2) - 40, (L_706_ / 2) - 2 - manual_offset, L_708_, L_709_, L_710_, math.floor(manual_alpha_left), "cb+", 0, "<")
		end
		if manual_alpha_right > 1 then
			renderer.text((L_705_ / 2) + 40, (L_706_ / 2) - 2 - manual_offset, L_708_, L_709_, L_710_, math.floor(manual_alpha_right), "cb+", 0, ">")
		end
	end

---@end

---@force team aimbot
	local function L_157_func()
		cvar.mp_teammates_are_enemies:set_int(ui.get(L_56_) and 1 or 0)
	end
	L_157_func()
	ui.set_callback(L_56_, function()
		L_157_func()
	end)
---@end

---@clan tag
	local L_158_ = {
		"",
		"v",
		"va",
		"van",
		"vand",
		"vanda",
		"vandal",
		"vanda",
		"vand",
		"van",
		"va",
		"v",
		""
	}
	local L_159_ = -1
	local L_160_ = 25
	local function L_161_func()
		local L_713_ = ui.get(L_55_)
		if not L_713_ then
			if L_159_ ~= -1 then
				client.set_clan_tag("")
				L_159_ = -1
			end
			return
		end
		local L_714_ = globals.tickcount()
		local L_715_ = math.floor(L_714_ / L_160_)
		if L_715_ == L_159_ then
			return
		end
		L_159_ = L_715_
		local L_716_ = (L_715_ % #L_158_) + 1
		client.set_clan_tag(L_158_[L_716_])
	end
---@end

---@exploit fix
	local L_162_ = 1
	local function L_163_func()
		local L_717_ = ui.get(L_51_)
		local L_718_ = (((ui.get(ref.dt[2]) or ui.get(ref.hs[2])) and not ui.get(ref.fd)) and L_2_.get_dt())
		if L_718_ and L_717_ then
			if L_162_ == 1 then
				L_162_ = ui.get(ref.fakelag_limit)
			end
			ui.set(ref.fakelag_limit, 1)
			return
		end
		if L_162_ > 1 then
			ui.set(ref.fakelag_limit, L_162_)
			L_162_ = 1
		end
	end
	local function L_164_func()
		if L_162_ > 1 then
			ui.set(ref.fakelag_limit, L_162_)
		end
	end
---@end

---@session time
	local L_165_ = client.unix_time()
	local L_166_ = 0
	local L_167_ = 0
	local function L_168_func()
		local L_719_ = client.unix_time()
		local L_720_ = L_719_ - L_165_
		if L_720_ > 0 then
			L_166_ = L_166_ + L_720_
			L_165_ = L_719_
			while L_166_ >= 60 do
				L_167_ = L_167_ + 1
				L_166_ = L_166_ - 60
			end
		end
		ui.set(lua_session, "\a" .. L_63_ .. "Current Session\aC0C0C0FF - " .. L_167_ .. " min " .. L_166_ .. " sec")
	end
---@end

---@revolver helper
	local function L_169_func(L_721_arg0)
		local L_722_ = entity.get_prop(L_721_arg0, "m_iItemDefinitionIndex")
		return L_722_ == 64
	end
	local function L_170_func(L_723_arg0, L_724_arg1)
		if L_723_arg0 == nil or L_724_arg1 == nil then
			return 0
		end
		local L_725_ = entity.get_prop(L_723_arg0, "m_hActiveWeapon")
		if L_725_ == nil or not L_169_func(L_725_) then
			return 0
		end
		local L_726_, L_727_, L_728_ = entity.get_origin(L_723_arg0)
		local L_729_, L_730_, L_731_ = entity.get_origin(L_724_arg1)
		if L_726_ == nil or L_729_ == nil then
			return 0
		end
		local L_732_ = distance3d(L_726_, L_727_, L_728_, L_729_, L_730_, L_731_)
		local L_733_ = entity.get_prop(L_724_arg1, "m_ArmorValue") == 0
		local L_734_ = L_728_ - L_731_
		if L_734_ > 100 and L_732_ < 300 then
			return "DMG+"
		elseif L_732_ > 585 then
			return "DMG-"
		elseif L_732_ < 585 and L_732_ > 511 then
			return "DMG"
		elseif L_732_ <= 511 and L_733_ then
			return "DMG+"
		else
			return "DMG"
		end
	end
	local function L_171_func(L_735_arg0, L_736_arg1)
		local L_737_, L_738_, L_739_, L_740_, L_741_ = entity.get_bounding_box(L_735_arg0)
		if L_737_ == nil or L_741_ == 0 then
			return
		end
		local L_742_ = (L_737_ + L_739_) / 2
		local L_743_ = L_738_ - 20
		local L_744_ = {
			255,
			0,
			0
		}
		if L_736_arg1 == "DMG" then
			L_744_ = {
				255,
				255,
				0
			}
		elseif L_736_arg1 == "DMG+" then
			L_744_ = {
				50,
				205,
				50
			}
		end
		renderer.text(L_742_, L_743_, L_744_[1], L_744_[2], L_744_[3], 255, "cb", 0, L_736_arg1)
	end
	local function L_172_func()
		if not ui.get(L_40_) then
			return
		end
		local L_745_ = entity.get_local_player()
		if L_745_ == nil or not entity.is_alive(L_745_) then
			return
		end
		local L_746_ = entity.get_prop(L_745_, "m_hActiveWeapon")
		if L_746_ == nil or not L_169_func(L_746_) then
			return
		end
		local L_747_ = entity.get_players(true)
		if #L_747_ == 0 then
			return
		end
		for L_748_forvar0 = 1, #L_747_ do
			local L_749_ = L_747_[L_748_forvar0]
			if L_749_ ~= L_745_ then
				local L_750_ = L_170_func(L_745_, L_749_)
				if L_750_ ~= 0 then
					L_171_func(L_749_, L_750_)
				end
			end
		end
	end
---@end

---@damage indicator
	local L_173_ = 0
	local function L_174_func()
		if not ui.get(L_41_) then
			return
		end
		local L_751_ = entity.get_local_player()
		if not L_751_ or not entity.is_alive(L_751_) then
			return
		end
		local L_752_ = 0
		local L_753_ = 0
		local L_754_, L_755_ = client.screen_size()
		if font == "Verdana" then
			L_752_ = L_754_ / 2 + 5
			L_753_ = L_755_ / 2 - 16
		else
			L_752_ = L_754_ / 2 + 8
			L_753_ = L_755_ / 2 - 16
		end
		local L_756_ = ui.get(ref.min_damage)
		if ui.get(ref.min_damage_override[2]) then
			L_756_ = ui.get(ref.min_damage_override[3])
		end
		L_173_ = L_7_(L_173_, L_756_, 0.12)
		local L_757_ = ui.get(L_42_)
		if L_757_ == "Verdana" then
			renderer.text(L_752_, L_753_, 255, 255, 255, 255, "l", nil, string.format("%.0f", L_173_))
		elseif L_757_ == "Pixel" then
			renderer.text(L_752_ - 5, L_753_ + 2, 255, 255, 255, 255, "l-", nil, string.format("%.0f", L_173_))
		end
	end
---@end

---@legit aa
	local L_175_ = {
		"CWorld",
		"CCSPlayer",
		"CFuncBrush"
	}
	local function L_176_func(L_758_arg0)
		local L_759_ = entity.get_all("CC4")[1]
		return L_759_ ~= nil and entity.get_prop(L_759_, "m_hOwnerEntity") == L_758_arg0
	end
	local function L_177_func(L_760_arg0)
		if ui.get(L_66_) then
			if L_760_arg0.in_use == 1 then
				if ui.get(L_67_) == "Opposite" then
					ui.set(ref.pitch[1], "Off")
					ui.set(ref.yaw_base, "Local view")
					ui.set(ref.yaw[1], "180")
					ui.set(ref.yaw[2], 180)
					ui.set(ref.yaw_jitter[1], "Offset")
					ui.set(ref.yaw_jitter[2], 0)
					ui.set(ref.body_yaw[1], "Opposite")
					ui.set(ref.freestanding_body_yaw, true)
				elseif ui.get(L_67_) == "2-Way" then
					ui.set(ref.pitch[1], "Off")
					ui.set(ref.yaw_base, "Local view")
					ui.set(ref.yaw[1], "180")
					ui.set(ref.yaw[2], 180)
					ui.set(ref.yaw_jitter[1], "Center")
					ui.set(ref.yaw_jitter[2], 65)
					ui.set(ref.body_yaw[1], "Jitter")
					ui.set(ref.body_yaw[2], -1)
					ui.set(ref.freestanding_body_yaw, false)
				end
			end
			local L_761_ = entity.get_local_player()
			local L_762_ = 100
			local L_763_ = entity.get_all("CPlantedC4")[1]
			local L_764_, L_765_, L_766_ = entity.get_prop(L_763_, "m_vecOrigin")
			if L_764_ ~= nil then
				local L_786_, L_787_, L_788_ = entity.get_prop(L_761_, "m_vecOrigin")
				L_762_ = distance3d(L_764_, L_765_, L_766_, L_786_, L_787_, L_788_)
			end
			local L_767_ = entity.get_prop(L_761_, "m_iTeamNum")
			local L_768_ = L_767_ == 3 and L_762_ < 62
			local L_769_ = entity.get_prop(L_761_, "m_bInBombZone")
			local L_770_ = L_176_func(L_761_)
			local L_771_ = 3
			local L_772_ = L_769_ ~= 0 and L_767_ == 2 and L_770_ and L_771_ ~= 3
			local L_773_, L_774_, L_775_ = client.eye_position()
			local L_776_, L_777_ = client.camera_angles()
			local L_778_ = math.sin(math.rad(L_776_))
			local L_779_ = math.cos(math.rad(L_776_))
			local L_780_ = math.sin(math.rad(L_777_))
			local L_781_ = math.cos(math.rad(L_777_))
			local L_782_ = {
				L_779_ * L_781_,
				L_779_ * L_780_,
				-L_778_
			}
			local L_783_, L_784_ = client.trace_line(L_761_, L_773_, L_774_, L_775_, L_773_ + (L_782_[1] * 8192), L_774_ + (L_782_[2] * 8192), L_775_ + (L_782_[3] * 8192))
			local L_785_ = true
			if L_784_ ~= nil then
				for L_789_forvar0 = 0, #L_175_ do
					if entity.get_classname(L_784_) == L_175_[L_789_forvar0] then
						L_785_ = false
					end
				end
			end
			if not L_785_ and not L_772_ and not L_768_ then
				L_760_arg0.in_use = 0
			end
		end
	end
---@end

---@warmup
	local function L_178_func()
		local L_790_ = entity.get_local_player()
		if not L_790_ then
			return
		end
		local L_791_ = entity.get_all("CCSGameRulesProxy")[1]
		if not L_791_ or entity.get_prop(L_791_, "m_bWarmupPeriod") ~= 1 then
			return
		end
		if ui.get(L_69_) then
			ui.set(ref.body_yaw[1], 'Off')
			ui.set(ref.yaw[1], "180")
			local L_792_ = L_111_func(globals.curtime() * 300)
			ui.set(ref.yaw[2], L_792_)
			ui.set(ref.pitch[1], "Custom")
			ui.set(ref.pitch[2], 0)
		end
	end
---@end

---@aspect_ratio
	function set_aspect_ratio(L_793_arg0)
		local L_794_, L_795_ = client.screen_size()
		local L_796_ = (L_794_ * L_793_arg0) / L_795_
		if L_793_arg0 == 1 then
			L_796_ = 0
		end
		client.set_cvar("r_aspectratio", tonumber(L_796_))
	end
	function gcd(L_797_arg0, L_798_arg1)
	-- greatest common divisor
		while L_797_arg0 ~= 0 do
			L_797_arg0, L_798_arg1 = math.fmod(L_798_arg1, L_797_arg0), L_797_arg0;
		end
		return L_798_arg1
	end
	local L_179_, L_180_ = client.screen_size()
	for L_799_forvar0 = 1, 200 do
		local L_800_ = L_799_forvar0 * 0.01
		L_800_ = 2 - L_800_
		local L_801_ = gcd(L_179_ * L_800_, L_180_)
		if L_179_ * L_800_ / L_801_ < 100 or L_800_ == 1 then
			aspect_ratio_table[L_799_forvar0] = L_179_ * L_800_ / L_801_ .. ":" .. L_180_ / L_801_
		end
	end
	function on_aspect_ratio_changed()
		local L_802_ = ui.get(L_44_) * 0.01
		L_802_ = 2 - L_802_
		set_aspect_ratio(L_802_)
		if not ui.get(L_43_) then
			set_aspect_ratio(0)
		end
	end
	ui.set_callback(L_43_, on_aspect_ratio_changed)
	ui.set_callback(L_44_, on_aspect_ratio_changed)


---@end

---@fast_ladder
	client.set_event_callback("setup_command", function(L_803_arg0)
		local L_804_ = entity.get_local_player()
		if not L_804_ then
			return
		end
		local L_805_, L_806_ = client.camera_angles()
		if entity.get_prop(L_804_, "m_MoveType") == 9 then
			L_803_arg0.yaw = math.floor(L_803_arg0.yaw + 0.5)
			L_803_arg0.roll = 0
			if ui.get(L_68_) then
				if L_803_arg0.forwardmove > 0 then
					if L_805_ < 45 then
						L_803_arg0.pitch = 89
						L_803_arg0.in_moveright = 1
						L_803_arg0.in_moveleft = 0
						L_803_arg0.in_forward = 0
						L_803_arg0.in_back = 1
						if L_803_arg0.sidemove == 0 then
							L_803_arg0.yaw = L_803_arg0.yaw + 90
						elseif L_803_arg0.sidemove < 0 then
							L_803_arg0.yaw = L_803_arg0.yaw + 150
						else
							L_803_arg0.yaw = L_803_arg0.yaw + 30
						end
					end
				elseif L_803_arg0.forwardmove < 0 then
					L_803_arg0.pitch = 89
					L_803_arg0.in_moveleft = 1
					L_803_arg0.in_moveright = 0
					L_803_arg0.in_forward = 1
					L_803_arg0.in_back = 0
					if L_803_arg0.sidemove == 0 then
						L_803_arg0.yaw = L_803_arg0.yaw + 90
					elseif L_803_arg0.sidemove > 0 then
						L_803_arg0.yaw = L_803_arg0.yaw + 150
					else
						L_803_arg0.yaw = L_803_arg0.yaw + 30
					end
				end
			end
		end
	end)
---@end

---@fix delay
	local L_181_ = ref.dt[2]
	local L_182_ = ref.autostop[3]
	local L_183_ = ui.get(L_181_)
	local L_184_ = 0
	local L_185_ = false
	local L_186_ = {}
	local function L_187_func()
		local L_807_ = globals.curtime()
		local L_808_ = ui.get(L_181_)
		local L_809_ = ui.get(L_182_)
		if not ui.get(L_52_) then
			if L_185_ then
				ui.set(L_182_, L_186_)
				L_185_ = false
			end
			L_183_ = L_808_
			return
		end
		local L_810_
		for L_811_forvar0, L_812_forvar1 in ipairs(L_809_) do
			if L_812_forvar1 == "Early" then
				L_810_ = L_811_forvar0
				break
			end
		end
		if L_183_ and not L_808_ and L_810_ then
			L_186_ = L_5_func(L_809_)
			table.remove(L_809_, L_810_)
			ui.set(L_182_, L_809_)
			L_184_ = L_807_ + 0.53
			L_185_ = true
		end
		if L_185_ and L_807_ >= L_184_ then
			ui.set(L_182_, L_186_)
			L_185_ = false
		end
		L_183_ = L_808_
	end

---@end


---@kill say
	local L_188_ = {
		".gg/JzmhWb9xrq",
		"леее куда ты хуесос ебаный",
		"забавный факт, ты хуеглот",
		"пизда вандалтеч забустил",
		"не получилось чет у тебя",
		"я твоего кота ебал",
		"бомж ебаный, куда ты?",
		".gg/JzmhWb9xrq",
		"иди ноулава посмотри, тебе полезно будет",
		"выйди с сервера, заебался тя пиздить",
		"ты носом муваешься или почему так хуёво?",
		"до связи =D",
		"спонсор твоих миссов - .gg/JzmhWb9xrq",
		"у тебя флюид хитбоксы?",
		"сосал? Ток честно пж",
		".gg/JzmhWb9xrq",
		"снеговичок ам-ам-ам",
		"азази азаза",
		"чупеп ебаный",
		"спонсор твоих миссов - .gg/JzmhWb9xrq",
		"fuck yall niggas",
		"восстановление в ряды мёртвых",
		"купи себе рамоны с вб и задушись шнурками",
		"вандал вандал в рот дал",
		"получи отцовских пиздюлей бешбармак ебаный",
		"я думал такие после рождения умирают нахуй",
		"спонсор твоей смерти - .gg/JzmhWb9xrq",
		"за рецептом отправляйтесь в бахмут",
		"умри ради дога",
		"покааааааа",
		"верёвка стоит не так дорого..",
		"завандалил твою бошку нах",
		"спонсор моих киллов - .gg/JzmhWb9xrq",
	}
	local L_189_ = function(L_813_arg0)
		if not ui.get(L_53_) then
			return
		end
		local L_814_, L_815_ = L_813_arg0.userid, L_813_arg0.attacker
		if L_814_ == nil or L_815_ == nil then
			return
		end
		local L_816_   = client.userid_to_entindex(L_814_)
		local L_817_ = client.userid_to_entindex(L_815_)
		if L_817_ == entity.get_local_player() and entity.is_enemy(L_816_) then
			local L_818_ = L_188_[math.random(1, #L_188_)]
			local L_819_ = 'say ' .. L_818_
			client.exec(L_819_)
		end
	end

---@end

---@velocity
	local L_190_ = 0
	local L_191_ = false
	function render_velocity()
		if not ui.get(L_47_) then
			return
		end
		local L_820_ = entity.get_local_player()
		if not L_820_ or not entity.is_alive(L_820_) then
			L_190_ = 0
			L_191_ = false
			return
		end
		local L_821_ = entity.get_prop(L_820_, "m_flVelocityModifier")
		local L_822_ = L_821_ and L_821_ < 1
		if L_822_ then
			L_190_ = math.min(L_190_ + globals.frametime() * 5 * 255, 255)
		else
			L_190_ = math.max(L_190_ - globals.frametime() * 5 * 255, 0)
		end
		if L_190_ <= 0 then
			return
		end
		local L_823_, L_824_ = client.screen_size()
		local L_825_, L_826_ = L_823_ / 2, L_824_ / 2
		local L_827_ = math.floor((L_821_ or 1) * 100)
		renderer.text(L_825_, L_826_ - 300, 180, 180, 180, math.floor(L_190_), "c", nil, "velocity rejected: " .. L_827_ .. " %")
	end

---@end

---@animated zoom
	original_fov = ui.get(ref.fov)
	original_zoom = ui.get(ref.zoom)
	local L_192_ = {
		duration = 0.25,
		timer = 1.0,
		animating = false,
		start_fov = original_fov,
		target_fov = original_fov,
		last_fov = original_fov,
		reset_done = false,
	}
	function animate_zoom()
		local L_828_ = entity.get_local_player()
		if not L_828_ then
			return
		end
		if not ui.get(L_48_) then
			if not L_192_.reset_done then
				if L_192_.animating then
					L_192_.animating = false
					ui.set(ref.fov, ui.get(ref.fov))
				end
				ui.set_enabled(ref.fov, true)
				ui.set_enabled(ref.zoom, true)
				ui.set(ref.zoom, original_zoom)
				L_192_.reset_done = true
			end
			return
		end
		if ui.get(L_48_) then
			ui.set_enabled(ref.zoom, false)
		end
		L_192_.reset_done = false
		local L_829_ = L_1_.isScoped(L_828_)
		local L_830_ = L_829_ and (original_fov - ui.get(L_49_)) or original_fov
		if L_830_ ~= L_192_.target_fov then
			L_192_.start_fov = ui.get(ref.fov)
			L_192_.target_fov = L_830_
			L_192_.timer = 0.0
			L_192_.animating = true
		end
		ui.set(ref.zoom, 0)
		if L_192_.animating then
			L_192_.timer = math.min(L_192_.timer + globals.frametime(), L_192_.duration)
			local L_831_ = L_192_.timer / L_192_.duration
			local L_832_ = ease_in_out_quad(L_831_)
			local L_833_ = math.floor(L_7_(L_192_.start_fov, L_192_.target_fov, L_832_) + 0.5)
			if L_833_ ~= L_192_.last_fov then
				ui.set(ref.fov, L_833_)
				L_192_.last_fov = L_833_
			end
			if L_192_.timer >= L_192_.duration then
				L_192_.animating = false
				ui.set(ref.fov, L_192_.target_fov)
				L_192_.last_fov = L_192_.target_fov
			end
		end
	end

---@end


---@fps optimize
	groups = {
		["3d sky"] = {
			cvar.r_3dsky
		},
		["fog"] = {
			cvar.fog_enable,
			cvar.fog_enable_water_fog
		},
		["shadows"] = {
			cvar.r_shadows,
			cvar.cl_csm_static_prop_shadows,
			cvar.cl_csm_shadows,
			cvar.cl_csm_world_shadows,
			cvar.cl_foot_contact_shadows,
			cvar.cl_csm_viewmodel_shadows,
			cvar.cl_csm_rope_shadows,
			cvar.cl_csm_sprite_shadows,
			cvar.cl_csm_translucent_shadows,
			cvar.cl_csm_entity_shadows,
			cvar.cl_csm_world_shadows_in_viewmodelcascade
		},
		["blood"] = {
			cvar.violence_hblood
		},
		["decals"] = {
			cvar.r_drawdecals,
			cvar.r_drawropes,
			cvar.r_drawsprites
		},
		["bloom"] = {
			cvar.mat_disable_bloom
		},
		["other"] = {
			cvar.r_dynamic,
			cvar.r_eyegloss,
			cvar.r_eyes,
			cvar.r_drawtracers_firstperson,
			cvar.r_dynamiclighting
		}
	}
	backup, active = {}, {}
	function set(L_834_arg0, L_835_arg1)
		if not backup[L_834_arg0] then
			backup[L_834_arg0] = L_834_arg0:get_int()
		end
		L_834_arg0:set_int(L_835_arg1)
	end
	function update_cvar()
		local L_836_ = {}
		for L_837_forvar0, L_838_forvar1 in ipairs(ui.get(L_57_)) do
			L_836_[L_838_forvar1] = true
		end
		for L_839_forvar0, L_840_forvar1 in pairs(groups) do
			local L_841_, L_842_ = L_836_[L_839_forvar0], active[L_839_forvar0]
			if L_841_ and not L_842_ then
				for L_843_forvar0, L_844_forvar1 in ipairs(L_840_forvar1) do
					set(L_844_forvar1, 0)
				end
			elseif not L_841_ and L_842_ then
				for L_845_forvar0, L_846_forvar1 in ipairs(L_840_forvar1) do
					if backup[L_846_forvar1] then
						L_846_forvar1:set_int(backup[L_846_forvar1])
					end
				end
			end
		end
		active = L_836_
	end
	function reset_cvar()
		for L_847_forvar0, L_848_forvar1 in pairs(backup) do
			L_847_forvar0:set_int(L_848_forvar1)
		end
		backup, active = {}, {}
	end
	ui.set_callback(L_57_, update_cvar)

---@end

---@anim breakers
	local function L_193_func()
		local L_849_ = ui.get(L_58_)
		local L_850_ = entity.get_local_player()
		if not L_850_ or not entity.is_alive(L_850_) then
			return
		end
		local L_851_ = c_entity.new(L_850_)
		local L_852_ = L_851_:get_anim_state()
		if not L_852_ then
			return
		end
		if L_9_func(L_849_, "Body lean") then
			local L_853_ = L_851_:get_anim_overlay(12)
			if not L_853_ then
				return
			end
			local L_854_ = entity.get_prop(L_850_, "m_vecVelocity[0]")
			if math.abs(L_854_) >= 3 then
				L_853_.weight = 1
			end
		end
		if L_9_func(L_849_, "Jitter legs on ground") and is_on_ground then
			ui.set(ui.reference("AA", "other", "leg movement"), command_number % 3 == 0 and "Off" or "Always slide")
			entity.set_prop(L_850_, "m_flPoseParameter", 1, globals.tickcount() % 4 > 1 and 5 / 10 or 1)
		end
		if L_9_func(L_849_, "Static in Air") and not is_on_ground then
			entity.set_prop(L_850_, "m_flPoseParameter", 1 , 6)
		end
		if L_9_func(L_849_, "Kangaroo") then
			entity.set_prop(L_850_, "m_flPoseParameter", math.random(0, 10) / 10, 3)
			entity.set_prop(L_850_, "m_flPoseParameter", math.random(0, 10) / 10, 7)
			entity.set_prop(L_850_, "m_flPoseParameter", math.random(0, 10) / 10, 6)
		end
		if L_9_func(L_849_, "0 pitch on landing") then
			if not L_852_.hit_in_ground_animation or not is_on_ground then
				return
			end
			entity.set_prop(L_850_, "m_flPoseParameter", 0.5, 12)
		end
	end

---@end

---@lag in air ( azazi function btw )

---local function lag_air(cmd)
---    local need_to_lag = (ui.get(force_lag) and (current_state == "Air-Duck" or current_state == "Air") and player.get_dt()
---
---    if need_to_lag then
---        потом напишу лень пиздец
---    end

---@end

---@callbacks
	ui.set_enabled(ref.clantag, false)
	ui.set(ref.clantag, false)
	client.set_event_callback("shutdown", function()
		L_143_func()
		reset_cvar()
		database.flush()
		L_164_func()
		ui.set_enabled(ref.clantag, true)
		ui.set_enabled(ref.zoom, true)
		set_aspect_ratio(0)
		ui.set(ref.zoom, original_zoom)
		ui.set(ref.fov, original_fov)
		cvar.con_filter_enable:set_int(0)
		cvar.con_filter_text:set_string("")
		cvar.mp_teammates_are_enemies:set_int(0)
	end)
	client.set_event_callback("aim_miss", function(L_855_arg0)
		L_150_func(L_855_arg0)
	end)
	client.set_event_callback("aim_hit", function(L_856_arg0)
		L_149_func(L_856_arg0)
	end)
	client.set_event_callback("aim_fire", function(L_857_arg0)
		L_148_func(L_857_arg0)
	end)
	client.set_event_callback('player_death', L_189_)
	client.set_event_callback("pre_render", function()
		L_142_func()
		L_193_func()
		menu_visibillity()
		L_64_func()
		L_141_func()
		L_144_func()
		L_168_func()
		L_80_func()
	end)
	command_number = 0
	client.set_event_callback("setup_command", function(L_858_arg0)
		L_86_func(L_858_arg0)
    ---fake_lag(cmd)
		L_121_func(L_858_arg0)
		L_122_func(L_858_arg0)
		L_84_func(L_858_arg0)
		L_123_func()
		L_126_func()
		L_177_func(L_858_arg0)
		L_178_func()
		L_187_func()
		command_number = L_858_arg0.command_number
	end)
	client.set_event_callback("round_start", function()
		if L_113_.current_offset ~= 0 then
			L_113_.current_offset = 0
			L_15_func("anti-bruteforce reseted", 3, 255, 255, 255)
			L_11_("anti-bruteforce reseted")
		end
	end)
	client.set_event_callback("paint", function()
		centered_indicators_legacy()
		L_108_func()
		L_152_func()
		L_155_func()
		L_156_func()
		L_172_func()
		L_174_func()
		render_velocity()
		animate_zoom()
		if ui.get(L_45_) then
			L_4_func(ui.get(L_46_))
		end
		local L_859_ = entity.get_local_player()
		if not entity.is_alive(L_859_) then
			L_81_ = 0
			return
		end

    --- суда так как в ипаном сетапе пиздец КАПУТ нахуй
		if (globals.realtime() > L_113_.active_until and L_113_.current_offset ~= 0) then
			L_113_.current_offset = 0
			L_15_func("anti-bruteforce reseted", 3, 255, 255, 255)
			L_11_("anti-bruteforce reseted")
		end
		if not ui.get(L_70_) then
			L_113_.current_offset = 0 -- ну да иначе нахуярит писанины на весь экран пиздец плакать потом буду шо капец
		end
	end)
	client.set_event_callback('net_update_end', function()
		L_161_func()
		local L_860_ = L_1_.get_lp()
		if not L_860_ or not L_1_.is_alive(L_860_) then
			L_2_.choked = 0
		end
	end)
	client.set_event_callback('level_init', function()
		L_124_ = globals.tickcount()
		L_117_ = 0
	end)
	client.set_event_callback("paint_ui", function()
		render_logs()
		ui.set(ui.reference('VISUALS', 'Effects', 'Remove scope overlay'), true)
	end)
	client.set_event_callback("run_command", function(L_861_arg0)
		L_2_.run_command(L_861_arg0)
	end)
	client.set_event_callback('predict_command', function(L_862_arg0)
		L_163_func()
		update_defensive(L_862_arg0)
	end)
	client.set_event_callback('finish_command', on_finish_command)
	L_15_func("welcome back, " .. username, 3, 255, 255 , 255)
---@end
end)()