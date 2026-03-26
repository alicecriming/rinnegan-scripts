local L_1_ = require('neverlose/pui')
local L_2_ = require(
'neverlose/base64')
local L_3_ = require('neverlose/clipboard')
local
L_4_ = require('neverlose/gradient')
local L_5_ = require(
'neverlose/mtools')
local L_6_ = false
math.lerp = function(L_69_arg0, L_70_arg1, L_71_arg2)
	return L_69_arg0 + (L_70_arg1 - L_69_arg0) *
globals.frametime * L_71_arg2
end
math.interpolate = function(L_72_arg0, L_73_arg1, L_74_arg2)
	return L_72_arg0 + L_74_arg2 * (L_73_arg1
- L_72_arg0)
end
math.compute_vector = function(L_75_arg0, L_76_arg1)
	local L_77_ = math.sin(math.rad(L_75_arg0))
	local L_78_ = math.cos(math.rad(L_75_arg0))
	local L_79_ = math.sin(math.rad(L_76_arg1))
	local L_80_ = math
.cos(math.rad(L_76_arg1))
	return vector(L_78_ * L_80_, L_78_ * L_79_, -L_77_)
end
math.
calculate_direction = function(L_81_arg0, L_82_arg1)
	local L_83_ = math.sin(math.rad(pitch))
	local L_84_ =
math.cos(math.rad(pitch))
	local L_85_ = math.sin(math.rad(yaw))
	local L_86_ = math.cos(
math.rad(yaw))
	return vector(L_84_ * L_86_, L_84_ * L_85_, -L_83_)
end
math.randomize = function(L_87_arg0
, L_88_arg1)
	local L_89_ = L_87_arg0 - L_87_arg0 * L_88_arg1 / 100
	local L_90_ = L_87_arg0 + L_87_arg0 * L_88_arg1 / 100
	return math.random(L_89_,
L_90_)
end
math.spin = function(L_91_arg0, L_92_arg1)
	if L_92_arg1 == 0 then
		return 0
	elseif L_91_arg0 >= 0 then
		tick = globals.tickcount * L_91_arg0
		result = tick % L_92_arg1 - L_92_arg1 / 2
		return result
	else
		tick = globals
.tickcount * L_91_arg0
		result = tick % -L_92_arg1 + L_92_arg1 / 2
		return result
	end
end
ffi.cdef(
[[    typedef void*(__thiscall* get_client_entity_t)(void*, int);
    typedef struct {
        char  pad_0000[20];
        int m_nOrder;
        int m_nSequence;
        float m_flPrevCycle;
        float m_flWeight;
        float m_flWeightDeltaRate;
        float m_flPlaybackRate;
        float m_flCycle;
        void *m_pOwner;
        char  pad_0038[4];
    } animstate_layer_t;
]]
)
local L_7_ = {
	aa_enable = ui.find('Aimbot', 'Anti Aim', 'Angles', 'Enabled'),
	pitch = ui.
find('Aimbot', 'Anti Aim', 'Angles', 'Pitch'),
	yaw = ui.find('Aimbot', 'Anti Aim',
'Angles', 'Yaw'),
	yawbase = ui.find('Aimbot', 'Anti Aim', 'Angles', 'Yaw', 'Base'),
	yawoffset = ui.find('Aimbot', 'Anti Aim', 'Angles', 'Yaw', 'Offset'),
	avoidbackstab = ui.
find('Aimbot', 'Anti Aim', 'Angles', 'Yaw', 'Avoid Backstab'),
	hidden = ui.find(
'Aimbot', 'Anti Aim', 'Angles', 'Yaw', 'Hidden'),
	yawmodifier = ui.find('Aimbot',
'Anti Aim', 'Angles', 'Yaw Modifier'),
	yawmodoffset = ui.find('Aimbot', 'Anti Aim',
'Angles', 'Yaw Modifier', 'Offset'),
	bodyyaw = ui.find('Aimbot', 'Anti Aim', 'Angles',
'Body Yaw'),
	inverter = ui.find('Aimbot', 'Anti Aim', 'Angles', 'Body Yaw', 'Inverter')
,
	leftlimit = ui.find('Aimbot', 'Anti Aim', 'Angles', 'Body Yaw', 'Left Limit'),
	rightlimit = ui.find('Aimbot', 'Anti Aim', 'Angles', 'Body Yaw', 'Right Limit'),
	options = ui.find('Aimbot', 'Anti Aim', 'Angles', 'Body Yaw', 'Options'),
	bodyfrees = ui.
find('Aimbot', 'Anti Aim', 'Angles', 'Body Yaw', 'Freestanding'),
	freestanding = ui.
find('Aimbot', 'Anti Aim', 'Angles', 'Freestanding'),
	disableyawmod = ui.find('Aimbot'
, 'Anti Aim', 'Angles', 'Freestanding', 'Disable Yaw Modifiers'),
	bodyfreestanding = ui
.find('Aimbot', 'Anti Aim', 'Angles', 'Freestanding', 'Body Freestanding'),
	extendedangles = ui.find('Aimbot', 'Anti Aim', 'Angles', 'Extended Angles'),
	extendedpitch = ui.find('Aimbot', 'Anti Aim', 'Angles', 'Extended Angles',
'Extended Pitch'),
	extendedroll = ui.find('Aimbot', 'Anti Aim', 'Angles',
'Extended Angles', 'Extended Roll'),
	fakelag = ui.find('Aimbot', 'Anti Aim',
'Fake Lag', 'Enabled'),
	fakelaglimit = ui.find('Aimbot', 'Anti Aim', 'Fake Lag',
'Limit'),
	fakelagvariab = ui.find('Aimbot', 'Anti Aim', 'Fake Lag', 'Variability'),
	fakeduck = ui.find('Aimbot', 'Anti Aim', 'Misc', 'Fake Duck'),
	slowwalk = ui.find(
'Aimbot', 'Anti Aim', 'Misc', 'Slow Walk'),
	legmovement = ui.find('Aimbot', 'Anti Aim',
'Misc', 'Leg Movement'),
	scopeoverlay = ui.find('Visuals', 'World', 'Main',
'Override Zoom', 'Scope Overlay'),
	clantag = ui.find('Miscellaneous', 'Main',
'In-Game', 'Clan Tag'),
	lagoptions = ui.find('Aimbot', 'Ragebot', 'Main', 'Double Tap',
'Lag Options'),
	hsoptions = ui.find('Aimbot', 'Ragebot', 'Main', 'Hide Shots',
'Options')
}
local L_8_ = {
	tab = L_1_.create('\n', 1),
	config = L_1_.create('\n\n', 2)
,
	info = L_1_.create('\n\n\n', 1),
	t_ct = L_1_.create('\n\n\n\n\n\n\n\n\n', 2),
	aa =
L_1_.create('\n\n\n\n', 1),
	builder = L_1_.create('\n\n\n\n\n', 2),
	func = L_1_
.create('\n\n\n\n\n\n', 2),
	visuals = L_1_.create('\n\n\n\n\n\n\n', 1),
	misc =
L_1_.create('\n\n\n\n\n\n\n\n', 2),
	leader = L_1_.create(
'\n\n\n\n\n\n\n\n\n\n', 1)
}
local L_9_ = {
	tab = L_8_.tab:list('\n', {
		[1] =
'\v\f<house-night>\r  Home',
		[2] = '\v\f<user-helmet-safety>\r  Anti-Aim',
		[3] =
'\v\f<gears>\r  Other'
	})
}
L_8_.info:label('\v\f<chevrons-right>\r  Renaissance'):
depend({
	[1] = nil,
	[2] = 1,
	[1] = L_9_.tab
})
L_8_.info:button(
'                \v1.1                ', function()
end, true):depend({
	[1] = nil,
	[2] =
1,
	[1] = L_9_.tab
})
L_8_.info:label('\v\f<chevrons-right>\r  Socials'):depend({
	[1] = nil
,
	[2] = 1,
	[1] = L_9_.tab
})
L_8_.info:button('      \v\f<discord>\r     ', function()
	panorama.SteamOverlayAPI.OpenExternalBrowserURL('https://discord.gg/4wJxGA4zRu')
end, true):depend({
	[1] = nil,
	[2] = 1,
	[1] = L_9_.tab
})
L_8_.info:button(
'     \v\f<youtube>\r     ', function()
	panorama.SteamOverlayAPI.
OpenExternalBrowserURL('https://www.youtube.com/@hheartless')
end, true):depend({
	[
1] = nil,
	[2] = 1,
	[1] = L_9_.tab
})
L_8_.info:label('\v\f<chevrons-right>\r  Configs'):
depend({
	[1] = nil,
	[2] = 1,
	[1] = L_9_.tab
})
L_8_.info:button(
'                \v\f<gears>\r               ', function()
	panorama.
SteamOverlayAPI.OpenExternalBrowserURL(
'https://ru.neverlose.cc/market/item?id=EtTpA7')
end, true):depend({
	[1] = nil,
	[2] = 1,
	[1] = L_9_.tab
})
L_8_.info:label('\v\f<chevrons-right>\r  Author Discord'):depend({
	[1
] = nil,
	[2] = 1,
	[1] = L_9_.tab
})
L_8_.info:button('     \vheartlessuwu     ', function()
end, true):depend({
	[1] = nil,
	[2] = 1,
	[1] = L_9_.tab
})
local L_10_ = {
	[1] = 'Global',
	[2] = 'Stand'
,
	[3] = 'Move',
	[4] = 'Walk',
	[5] = 'Crouch',
	[6] = 'Crouch Move',
	[7] = 'Air',
	[8] = 'Air+C',
	[9] =
'Discharged'
}
local L_11_ = {
	side = L_8_.t_ct:list('\n', {
		[1] = '\v\f<shield>  \rCT-Side',
		[
2] = '\v\f<gun>  \rT-Side'
	}):depend({
		[1] = nil,
		[2] = 2,
		[1] = L_9_.tab
	}, check_side),
	condition = L_8_.builder:combo('\v\f<street-view>\r  Current State', L_10_):depend({
		[1
] = nil,
		[2] = 2,
		[1] = L_9_.tab
	}, check_side),
	label = L_8_.aa:label(
'\v\f<chevrons-right>\r  Sponsored by '):depend({
		[1] = nil,
		[2] = 2,
		[1] = L_9_.tab
	},
check_side)
}
L_8_.aa:button('  \v\f<discord>\r  HvH League   \v\f<discord>\r  ',
function()
	panorama.SteamOverlayAPI.OpenExternalBrowserURL(
'https://discord.gg/hvhleague')
end, true):depend({
	[1] = nil,
	[2] = 2,
	[1] = L_9_.tab
},
check_side)
L_11_.pitch = L_8_.aa:combo('\v\f<user-helmet-safety>\r  Pitch', L_7_.pitch:
list()):depend({
	[1] = nil,
	[2] = 2,
	[1] = L_9_.tab
}, check_side)
L_11_.yaw_base = L_8_.aa:combo(
'\v\f<arrows-up-down-left-right>\r  Yaw Base', {
	[1] = 'At Target',
	[2] = 'Local View',
	[3] = 'Forward',
	[4] = 'Left',
	[5] = 'Right'
}):depend({
	[1] = nil,
	[2] = 2,
	[1] = L_9_.tab
},
check_side)
L_11_.yaw_base_create = L_11_.yaw_base:create()
L_11_.yaw_base_static = L_11_.
yaw_base_create:switch('Static')
L_11_.yaw_base_flick = L_11_.yaw_base_create:switch(
'Head-Spam')
L_11_.yaw_base_flick_offset = L_11_.yaw_base_create:slider('Pitch Offset',
-89, 89, 0):depend(L_11_.yaw_base_flick)
L_11_.safe_head = L_8_.aa:selectable(
'\v\f<helmet-battle>\r  Safe Head', {
	[1] = 'Air+C Knife',
	[2] = 'Air+C Zeus'
}):depend(
{
	[1] = nil,
	[2] = 2,
	[1] = L_9_.tab
}, check_side)
L_11_.avoid_backstab = L_8_.aa:slider(
'\v\f<sword>\r  Avoid Backstab', 1, 2, 1, 1, function(L_93_arg0)
	if L_93_arg0 == 1 then
		return
'Disabled'
	else
		return 'Enabled'
	end
end):depend({
	[1] = nil,
	[2] = 2,
	[1] = L_9_.tab
},
check_side)
L_11_.freestanding = L_8_.aa:switch('\v\f<street-view>\r  Freestanding'):
depend({
	[1] = nil,
	[2] = 2,
	[1] = L_9_.tab
}, check_side)
L_11_.freestanding_create = L_11_.
freestanding:create()
L_11_.freestanding_static = L_11_.freestanding_create:switch(
'Static')
L_11_.freestanding_flick = L_11_.freestanding_create:switch('Head-Spam')
L_11_.
freestanding_flick_offset = L_11_.freestanding_create:slider('Pitch Offset', -89, 89, 0
):depend(L_11_.freestanding_flick)
L_11_.aa_override = L_8_.aa:selectable(
'\v\f<arrows-spin>\r  AA Override', {
	[1] = 'No Enemies Alive',
	[2] = 'Warmup'
}):
depend({
	[1] = nil,
	[2] = 2,
	[1] = L_9_.tab
}, check_side)
L_11_.anim_break = L_8_.aa:switch(
'\v\f<socks>\r  Anim. Breaker'):depend({
	[1] = nil,
	[2] = 2,
	[1] = L_9_.tab
}, check_side)
L_11_.anim_break_create = L_11_.anim_break:create():depend(L_11_.anim_break)
L_11_.
anim_break_ground = L_11_.anim_break_create:combo('On Ground', {
	[1] = 'Disabled',
	[2] =
'Static',
	[3] = 'Jitter',
	[4] = 'Better Jitter',
	[5] = 'Moonwalk'
})
L_11_.
anim_break_ground_amount = L_11_.anim_break_create:slider('Amount', 0, 10, 80, 0.1, '%'):
depend({
	[1] = L_11_.anim_break_ground,
	[2] = function()
		return L_11_.anim_break_ground:
get() == 'Static' or L_11_.anim_break_ground:get() == 'Jitter'
	end
})
L_11_.anim_break_air =
L_11_.anim_break_create:combo('In Air', {
	[1] = 'Disabled',
	[2] = 'Static',
	[3] = 'Jitter',
	[
4] = 'Better Jitter',
	[5] = 'Moonwalk'
})
L_11_.anim_break_other = L_11_.anim_break_create:
selectable('Other', {
	[1] = 'Pitch 0 On Land',
	[2] = 'EarthQuake',
	[3] = 'Move Lean'
})
L_11_.
anim_break_lean = L_11_.anim_break_create:slider('Move Lean Value', 0, 10, 100, 0.1, '%')
:depend({
	[1] = nil,
	[2] = 'Move Lean',
	[1] = L_11_.anim_break_other
})
local L_12_ = {
	main_func =
L_8_.func:listable('\n\n', {
		[1] = '\v\f<bomb>\r  Super Toss',
		[2] =
'\v\f<water-ladder>\r  Fast Ladder',
		[3] = '\v\f<person-falling>\r  No Fall Damage'
	}):depend({
		[1] = nil,
		[2] = 3,
		[1] = L_9_.tab
	}),
	screen_logs = L_8_.visuals:switch(
'\v\f<blog>\r  Screen Logs'):depend({
		[1] = nil,
		[2] = 3,
		[1] = L_9_.tab
	})
}
L_12_.
screen_logs_create = L_12_.screen_logs:create():depend(L_12_.screen_logs)
L_12_.
screen_logs_hit = L_12_.screen_logs_create:color_picker('Hit', color(201, 199, 255))
L_12_
.screen_logs_miss = L_12_.screen_logs_create:color_picker('Miss', color(200, 112, 112))
L_12_.aspectratio = L_8_.visuals:switch('\v\f<desktop>\r  Aspect Ratio'):depend({
	[1] =
nil,
	[2] = 3,
	[1] = L_9_.tab
})
L_12_.aspectratio_create = L_12_.aspectratio:create():depend(
L_12_.aspectratio)
L_12_.aspectratio_value = L_12_.aspectratio_create:slider('Value', 0,
200, 0, 0.01, function(L_94_arg0)
	if L_94_arg0 == 125 then
		return '5:4'
	elseif L_94_arg0 == 133 then
		return
'4:3'
	elseif L_94_arg0 == 150 then
		return '3:2'
	elseif L_94_arg0 == 160 then
		return '16:10'
	elseif
L_94_arg0 == 180 then
		return '16:9'
	else
		return
	end
end)
L_12_.aspectratio_create:button(
'  \v5:4  ', function()
	L_12_.aspectratio_value:set(125)
end, true)
L_12_.
aspectratio_create:button('  \v4:3  ', function()
	L_12_.aspectratio_value:set(133)
end, true)
L_12_.aspectratio_create:button('  \v3:2  ', function()
	L_12_.
aspectratio_value:set(150)
end, true)
L_12_.aspectratio_create:button('  \v16:10  ',
function()
	L_12_.aspectratio_value:set(160)
end, true)
L_12_.aspectratio_create:button(
'  \v16:9  ', function()
	L_12_.aspectratio_value:set(180)
end, true)
L_12_.custom_hud = L_8_
.visuals:switch('\v\f<gamepad-modern>\r  Custom Hud'):depend({
	[1] = nil,
	[2] = 3,
	[1] =
L_9_.tab
})
L_12_.custom_hud_color = L_12_.custom_hud:create():color_picker('Color',
color(100, 100, 100, 150)):depend(L_12_.custom_hud)
L_12_.custom_hud_text_color = L_12_.
custom_hud:create():color_picker('Icons Color', color(153, 153, 153, 255)):depend(
L_12_.custom_hud)
L_12_.custom_scope = L_8_.visuals:switch(
'\v\f<crosshairs>\r  Custom Scope'):depend({
	[1] = nil,
	[2] = 3,
	[1] = L_9_.tab
})
L_12_.
custom_scope_create = L_12_.custom_scope:create():depend(L_12_.custom_scope)
L_12_.
custom_scope_color = L_12_.custom_scope_create:color_picker('Color', color(200, 200,
200, 200))
L_12_.custom_scope_length = L_12_.custom_scope_create:slider('Length', 50, 300,
150)
L_12_.custom_scope_offset = L_12_.custom_scope_create:slider('Offset', 0, 50, 10)
L_12_.
viewmodel = L_8_.visuals:switch('\v\f<hands-holding-heart>\r  Viewmodel Changer'):
depend({
	[1] = nil,
	[2] = 3,
	[1] = L_9_.tab
})
L_12_.viewmodel_create = L_12_.viewmodel:create():
depend(L_12_.viewmodel)
L_12_.viewmodel_fov = L_12_.viewmodel_create:slider('Fov', -100,
100, 68)
L_12_.viewmodel_x = L_12_.viewmodel_create:slider('X', -100, 100, 25, 0.1)
L_12_.
viewmodel_y = L_12_.viewmodel_create:slider('Y', -100, 100, 0, 0.1)
L_12_.viewmodel_z = L_12_.
viewmodel_create:slider('Z', -100, 100, -15, 0.1)
L_12_.viewmodel_reset = L_12_.
viewmodel_create:button(
'                                  \vReset                                  ',
function()
	L_12_.viewmodel_fov:set(68)
	L_12_.viewmodel_x:set(25)
	L_12_.viewmodel_y:set(0)
	L_12_.viewmodel_z:set(-15)
end, true)
L_12_.min_damage = L_8_.visuals:switch(
'\v\f<gun>\r  Min. Damage Indicator'):depend({
	[1] = nil,
	[2] = 3,
	[1] = L_9_.tab
})
L_12_.
min_damage_create = L_12_.min_damage:create():depend(L_12_.min_damage)
L_12_.
min_damage_color = L_12_.min_damage_create:color_picker('Color', color(255))
L_12_.
min_damage_font = L_12_.min_damage_create:list('\n\n\n', {
	[1] = 'Default',
	[2] = 'Small',
	[
3] = 'Console',
	[4] = 'Bold'
})
L_12_.watermark = L_8_.visuals:combo(
'\v\f<indent>\r  Watermark Style', {
	[1] = 'Default',
	[2] = 'Alternative'
}):depend({
	[1]
= nil,
	[2] = 3,
	[1] = L_9_.tab
})
L_12_.nade_fix = L_8_.misc:switch(' \v\f<bomb>\r  Nade Fix'):
depend({
	[1] = nil,
	[2] = 3,
	[1] = L_9_.tab
})
L_12_.fake_ping = L_8_.misc:switch(
'\v\f<wifi>\r  Fake Ping'):depend({
	[1] = nil,
	[2] = 3,
	[1] = L_9_.tab
})
L_12_.
fake_ping_create = L_12_.fake_ping:create():depend(L_12_.fake_ping)
L_12_.fake_ping_value
= L_12_.fake_ping_create:slider('Value', 0, 200, 0)
L_12_.fd_settings = L_8_.misc:switch(
'\v\f<duck>\r  FD Settings'):depend({
	[1] = nil,
	[2] = 3,
	[1] = L_9_.tab
})
L_12_.
fd_settings_list = L_12_.fd_settings:create():listable('\n', {
	[1] = 'Fast Fake Duck',
	[2
] = 'Fake Duck On Freeze Time'
}):depend(L_12_.fd_settings)
L_12_.avoid_collision = L_8_.
misc:switch('\v\f<person-walking-dashed-line-arrow-right>\r  Avoid Collision'):
depend({
	[1] = nil,
	[2] = 3,
	[1] = L_9_.tab
})
L_12_.auto_hideshots = L_8_.misc:switch(
'\v\f<user-shield>\r  Auto Hide Shots'):depend({
	[1] = nil,
	[2] = 3,
	[1] = L_9_.tab
})
L_12_.
dormant_aimbot = L_8_.misc:switch('\v\f<eye-low-vision>\r  Dormant Aimbot'):depend(
{
	[1] = nil,
	[2] = 3,
	[1] = L_9_.tab
})
L_12_.lc_teleport = L_8_.misc:switch(
'\v\f<chart-network>\r  LC Teleport'):depend({
	[1] = nil,
	[2] = 3,
	[1] = L_9_.tab
})
L_12_.
logs = L_8_.misc:selectable('\v\f<rectangle-terminal>\r   Ragebot Logs', {
	[1] =
'Console',
	[2] = 'Event'
}):depend({
	[1] = nil,
	[2] = 3,
	[1] = L_9_.tab
})
L_12_.logs_create = L_12_.
logs:create():depend({
	[1] = L_12_.logs,
	[2] = function()
		return L_12_.logs:get('Console')
or L_12_.logs:get('Event')
	end
})
L_12_.logs_hit = L_12_.logs_create:color_picker('Hit',
color(201, 199, 255))
L_12_.logs_miss = L_12_.logs_create:color_picker('Miss', color(200,
112, 112))
local L_13_ = {}
for L_95_forvar0 = 1, #L_10_ do
	L_13_[L_95_forvar0] = {}
	L_13_[L_95_forvar0].enable = L_8_.builder:
switch('\v\f<shield>  \rEnable \v' .. L_10_[L_95_forvar0] .. '\r State')
	L_13_[L_95_forvar0].yaw_type = L_8_.
builder:slider('\v\f<arrows-turn-to-dots>\r  Yaw Type', 1, 3, 1, 1, function(L_96_arg0)
		if
L_96_arg0 == 1 then
			return '1-Way'
		elseif L_96_arg0 == 2 then
			return '2-Way'
		else
			return 'Slow'
		end
	end)
	L_13_[L_95_forvar0].yaw = L_8_.builder:slider('\v\f<arrows-up-down>\r  Yaw', -180, 180, 0, 1,
'\194\176')
	L_13_[L_95_forvar0].yaw_left = L_8_.builder:slider('\v\f<arrow-left>\r  Yaw Left', -
180, 180, 0, 1, '\194\176')
	L_13_[L_95_forvar0].yaw_right = L_8_.builder:slider(
'\v\f<arrow-right>\r  Yaw Right', -180, 180, 0, 1, '\194\176')
	L_13_[L_95_forvar0].yaw_random = L_8_
.builder:slider('\v\f<dice>\r  Random', 0, 100, 0, 1, '%')
	L_13_[L_95_forvar0].yaw_delay = L_13_[L_95_forvar0]
.yaw_type:create():slider('\v\f<snake>\r  Delay', 1, 10, 4, 1, 't')
	L_13_[L_95_forvar0].
yaw_delay_rand = L_13_[L_95_forvar0].yaw_type:create():slider('\v\f<dice-d6>\r  Delay Random'
, 0, 6, 0, 1, 't')
	L_13_[L_95_forvar0].mod_type = L_8_.builder:combo(
'\v\f<arrows-repeat>\r  Modifier', L_7_.yawmodifier:list())
	L_13_[L_95_forvar0].mod_offset = L_13_
[L_95_forvar0].mod_type:create():slider('\v\f<value-absolute>\r  Offset', -180, 180, 0, 1,
'\194\176')
	L_13_[L_95_forvar0].mod_random = L_13_[L_95_forvar0].mod_type:create():slider(
'\v\f<dice>\r  Random', 0, 100, 0, 1, '%')
	L_13_[L_95_forvar0].body_yaw = L_8_.builder:switch(
'\v\f<angle>\r  Body Yaw')
	L_13_[L_95_forvar0].body_yaw_create = L_13_[L_95_forvar0].body_yaw:create()
	L_13_
[L_95_forvar0].invert = L_13_[L_95_forvar0].body_yaw_create:switch('Invert')
	L_13_[L_95_forvar0].lby_l = L_13_[L_95_forvar0].
body_yaw_create:slider('Left Limit', 0, 60, 60, 1, '\194\176')
	L_13_[L_95_forvar0].lby_r = L_13_[L_95_forvar0]
.body_yaw_create:slider('Right Limit', 0, 60, 60, 1, '\194\176')
	L_13_[L_95_forvar0].lby_random =
L_13_[L_95_forvar0].body_yaw_create:slider('Random', 0, 100, 0, 1, '%')
	L_13_[L_95_forvar0].options = L_13_[L_95_forvar0]
.body_yaw_create:selectable('Options', L_7_.options:list())
	L_13_[L_95_forvar0].freestand = L_13_[
L_95_forvar0].body_yaw_create:combo('Freestanding', L_7_.bodyfrees:list())
	L_13_[L_95_forvar0].
force_defensive = L_8_.builder:selectable('\v\f<bomb>\r  Force Defensive', {
		[1] = 'DT'
,
		[2] = 'Hide Shots'
	})
	L_13_[L_95_forvar0].defensive_flick = L_8_.builder:combo(
'\v\f<radiation>  Silent Yaw', {
		[1] = 'Disabled',
		[2] = 'Offset',
		[3] = 'L&R'
	})
	L_13_[L_95_forvar0].
defensive_flick_create = L_13_[L_95_forvar0].defensive_flick:create()
	L_13_[L_95_forvar0].
defensive_flick_offset = L_13_[L_95_forvar0].defensive_flick_create:slider('Offset', -180, 180,
0, 1, '\194\176')
	L_13_[L_95_forvar0].defensive_flick_l = L_13_[L_95_forvar0].defensive_flick_create:
slider('Offset Left', -180, 180, 0, 1, '\194\176')
	L_13_[L_95_forvar0].defensive_flick_r = L_13_[L_95_forvar0]
.defensive_flick_create:slider('Offset Right', -180, 180, 0, 1, '\194\176')
	L_13_[L_95_forvar0].
defensive_flick_random = L_13_[L_95_forvar0].defensive_flick_create:slider('Random', 0, 100, 0, 1
, '%')
	L_13_[L_95_forvar0].defensive_yaw = L_8_.builder:combo(
'\v\f<arrow-rotate-right>\r  Defensive Yaw', {
		[1] = 'Disabled',
		[2] = 'Default',
		[3] =
'Spin',
		[4] = 'Side-Ways',
		[5] = 'Offset',
		[6] = 'Random'
	})
	L_13_[L_95_forvar0].defensive_yaw_create =
L_13_[L_95_forvar0].defensive_yaw:create()
	L_13_[L_95_forvar0].def_yaw_offset = L_13_[L_95_forvar0].
defensive_yaw_create:slider('Offset', -180, 180, 0, 1, '\194\176')
	L_13_[L_95_forvar0].
def_yaw_spin = L_13_[L_95_forvar0].defensive_yaw_create:slider('Offset', 0, 360, 360, 1,
'\194\176')
	L_13_[L_95_forvar0].def_yaw_speed = L_13_[L_95_forvar0].defensive_yaw_create:slider(
'Spin Speed', -50, 50, 20, 0.1, 't')
	L_13_[L_95_forvar0].defensive_pitch = L_8_.builder:combo(
'\v\f<arrow-up-from-arc>\r  Defensive Pitch', {
		[1] = 'Disabled',
		[2] = 'Spin',
		[3] =
'Side-Ways',
		[4] = 'Offset',
		[5] = 'Random'
	})
	L_13_[L_95_forvar0].defensive_pitch_create = L_13_[L_95_forvar0].
defensive_pitch:create()
	L_13_[L_95_forvar0].def_pitch_offset = L_13_[L_95_forvar0].
defensive_pitch_create:slider('Offset', -89, 89, 0, 1, '\194\176')
	L_13_[L_95_forvar0].
def_pitch_spin = L_13_[L_95_forvar0].defensive_pitch_create:slider('Offset', 0, 178, 178, 1,
'\194\176')
	L_13_[L_95_forvar0].def_pitch_speed = L_13_[L_95_forvar0].defensive_pitch_create:slider(
'Spin Speed', -50, 50, 20, 0.1, 't')
	L_13_[L_95_forvar0].send_to_t = L_8_.builder:button(
'                                 \v\f<shield>  \r\f<arrow-right-to-arc>   \v\f<gun>                                 '
, function()
	end, true)
	L_13_[L_95_forvar0].send_to_t:tooltip('Send AA Settings To T-Side')
end
for L_97_forvar0 = 1, #L_10_ do
	do
		local L_98_ = L_97_forvar0
		local L_99_ = {
			[1] = L_11_.condition,
			[2] = function
()
				return L_98_ ~= 1
			end
		}
		local L_100_ = {
			[1] = L_13_[L_98_].enable,
			[2] = function()
				if
L_98_ == 1 then
					return true
				else
					return L_13_[L_98_].enable:get()
				end
			end
		}
		local
L_101_ = {
			[1] = L_11_.condition,
			[2] = L_10_[L_98_]
		}
		local L_102_ = {
			[1] = nil,
			[2] = 1,
			[1] = L_11_.side
		}
		L_13_[L_98_].enable:depend(L_99_, L_101_, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].
yaw_type:depend(L_100_, L_101_, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].yaw:depend(
L_100_, L_101_, {
			[1] = nil,
			[2] = 1,
			[1] = L_13_[L_98_].yaw_type
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		},
L_102_)
		L_13_[L_98_].yaw_left:depend(L_100_, L_101_, {
			[1] = L_13_[L_98_].yaw_type,
			[2] = function
()
				return L_13_[L_98_].yaw_type:get() ~= 1
			end
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_
[L_98_].yaw_right:depend(L_100_, L_101_, {
			[1] = L_13_[L_98_].yaw_type,
			[2] = function()
				return L_13_[L_98_].yaw_type:get() ~= 1
			end
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[
L_98_].yaw_random:depend(L_100_, L_101_, {
			[1] = L_13_[L_98_].yaw_type,
			[2] = function()
				return L_13_[L_98_].yaw_type:get() ~= 1
			end
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[
L_98_].yaw_delay:depend(L_100_, L_101_, {
			[1] = nil,
			[2] = 3,
			[1] = L_13_[L_98_].yaw_type
		}, {
			[1]
= nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].yaw_delay_rand:depend(L_100_, L_101_, {
			[1] = nil,
			[2] = 3,
			[1] = L_13_[L_98_].yaw_type
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].
mod_type:depend(L_100_, L_101_, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].mod_offset:
depend(L_100_, L_101_, {
			[1] = L_13_[L_98_].mod_type,
			[2] = function()
				return L_13_[L_98_].
mod_type:get() ~= 'Disabled'
			end
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].
mod_random:depend(L_100_, L_101_, {
			[1] = L_13_[L_98_].mod_type,
			[2] = function()
				return L_13_[
L_98_].mod_type:get() ~= 'Disabled'
			end
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[
L_98_].body_yaw:depend(L_100_, L_101_, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].
invert:depend(L_100_, L_101_, L_13_[L_98_].body_yaw, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[
L_98_].lby_l:depend(L_100_, L_101_, L_13_[L_98_].body_yaw, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		},
L_102_)
		L_13_[L_98_].lby_r:depend(L_100_, L_101_, L_13_[L_98_].body_yaw, {
			[1] = nil,
			[2] = 2,
			[1] =
L_9_.tab
		}, L_102_)
		L_13_[L_98_].lby_random:depend(L_100_, L_101_, L_13_[L_98_].body_yaw, {
			[1] =
nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].options:depend(L_100_, L_101_, L_13_[L_98_].
body_yaw, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].freestand:depend(L_100_, L_101_,
L_13_[L_98_].body_yaw, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].
force_defensive:depend(L_100_, L_101_, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].
defensive_flick:depend(L_100_, L_101_, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].
defensive_flick_offset:depend(L_100_, L_101_, {
			[1] = nil,
			[2] = 'Offset',
			[1] = L_13_[L_98_].
defensive_flick
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].defensive_flick_l:
depend(L_100_, L_101_, {
			[1] = nil,
			[2] = 'L&R',
			[1] = L_13_[L_98_].defensive_flick
		}, {
			[1] = nil,
			[2]
= 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].defensive_flick_r:depend(L_100_, L_101_, {
			[1] = nil,
			[2] =
'L&R',
			[1] = L_13_[L_98_].defensive_flick
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[
L_98_].defensive_flick_random:depend(L_100_, L_101_, {
			[1] = nil,
			[2] = 'L&R',
			[1] = L_13_[
L_98_].defensive_flick
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].
defensive_yaw:depend(L_100_, L_101_, {
			[1] = nil,
			[2] = 'Disabled',
			[1] = L_13_[L_98_].
defensive_flick
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].def_yaw_offset:
depend(L_100_, L_101_, {
			[1] = L_13_[L_98_].defensive_yaw,
			[2] = function()
				return L_13_[L_98_]
.defensive_yaw:get() == 'Random' or not(L_13_[L_98_].defensive_yaw:get() ~= 'Offset')
or L_13_[L_98_].defensive_yaw:get() == 'Side-Ways'
			end
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}
, L_102_)
		L_13_[L_98_].def_yaw_spin:depend(L_100_, L_101_, {
			[1] = nil,
			[2] = 'Spin',
			[1] = L_13_[
L_98_].defensive_yaw
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].
def_yaw_speed:depend(L_100_, L_101_, {
			[1] = nil,
			[2] = 'Spin',
			[1] = L_13_[L_98_].defensive_yaw
		}
, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].defensive_pitch:depend(L_100_, L_101_, {
			[1
] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].def_pitch_offset:depend(L_100_, L_101_, {
			[1] =
L_13_[L_98_].defensive_pitch,
			[2] = function()
				return L_13_[L_98_].defensive_pitch:
get() == 'Random' or not(L_13_[L_98_].defensive_pitch:get() ~= 'Offset') or L_13_[
L_98_].defensive_pitch:get() == 'Side-Ways'
			end
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].def_pitch_spin:depend(L_100_, L_101_, {
			[1] = nil,
			[2] = 'Spin',
			[1] = L_13_[L_98_].
defensive_pitch
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].def_pitch_speed:
depend(L_100_, L_101_, {
			[1] = nil,
			[2] = 'Spin',
			[1] = L_13_[L_98_].defensive_pitch
		}, {
			[1] = nil,
			[2
] = 2,
			[1] = L_9_.tab
		}, L_102_)
		L_13_[L_98_].send_to_t:depend(L_100_, L_101_, {
			[1] = nil,
			[2] = 2,
			[1] =
L_9_.tab
		}, L_102_)
	end
end
local L_14_ = {}
for L_103_forvar0 = 1, #L_10_ do
	L_14_[L_103_forvar0] = {}
	L_14_[L_103_forvar0].enable =
L_8_.builder:switch('\v\f<gun>  \rEnable \v' .. L_10_[L_103_forvar0] .. '\r State')
	L_14_[L_103_forvar0].
yaw_type = L_8_.builder:slider('\v\f<arrows-turn-to-dots>\r  Yaw Type', 1, 3, 1, 1,
function(L_104_arg0)
		if L_104_arg0 == 1 then
			return '1-Way'
		elseif L_104_arg0 == 2 then
			return '2-Way'
		else
			return 'Slow'
		end
	end)
	L_14_[L_103_forvar0].yaw = L_8_.builder:slider(
'\v\f<arrows-up-down>\r  Yaw', -180, 180, 0, 1, '\194\176')
	L_14_[L_103_forvar0].yaw_left = L_8_.
builder:slider('\v\f<arrow-left>\r  Yaw Left', -180, 180, 0, 1, '\194\176')
	L_14_[L_103_forvar0].
yaw_right = L_8_.builder:slider('\v\f<arrow-right>\r  Yaw Right', -180, 180, 0, 1,
'\194\176')
	L_14_[L_103_forvar0].yaw_random = L_8_.builder:slider('\v\f<dice>\r  Random', 0, 100, 0
, 1, '%')
	L_14_[L_103_forvar0].yaw_delay = L_14_[L_103_forvar0].yaw_type:create():slider(
'\v\f<snake>\r  Delay', 1, 10, 4, 1, 't')
	L_14_[L_103_forvar0].yaw_delay_rand = L_14_[L_103_forvar0].yaw_type:
create():slider('\v\f<dice-d6>\r  Delay Random', 0, 6, 0, 1, 't')
	L_14_[L_103_forvar0].mod_type =
L_8_.builder:combo('\v\f<arrows-repeat>\r  Modifier', L_7_.yawmodifier:list())
	L_14_[
L_103_forvar0].mod_offset = L_14_[L_103_forvar0].mod_type:create():slider(
'\v\f<value-absolute>\r  Offset', -180, 180, 0, 1, '\194\176')
	L_14_[L_103_forvar0].mod_random = L_14_
[L_103_forvar0].mod_type:create():slider('\v\f<dice>\r  Random', 0, 100, 0, 1, '%')
	L_14_[L_103_forvar0].
body_yaw = L_8_.builder:switch('\v\f<angle>\r  Body Yaw')
	L_14_[L_103_forvar0].body_yaw_create =
L_14_[L_103_forvar0].body_yaw:create()
	L_14_[L_103_forvar0].invert = L_14_[L_103_forvar0].body_yaw_create:switch(
'Invert')
	L_14_[L_103_forvar0].lby_l = L_14_[L_103_forvar0].body_yaw_create:slider('Left Limit', 0, 60, 60, 1,
'\194\176')
	L_14_[L_103_forvar0].lby_r = L_14_[L_103_forvar0].body_yaw_create:slider('Right Limit', 0, 60, 60,
1, '\194\176')
	L_14_[L_103_forvar0].lby_random = L_14_[L_103_forvar0].body_yaw_create:slider('Random', 0, 100,
0, 1, '%')
	L_14_[L_103_forvar0].options = L_14_[L_103_forvar0].body_yaw_create:selectable('Options', L_7_.
options:list())
	L_14_[L_103_forvar0].freestand = L_14_[L_103_forvar0].body_yaw_create:combo('Freestanding',
L_7_.bodyfrees:list())
	L_14_[L_103_forvar0].force_defensive = L_8_.builder:selectable(
'\v\f<bomb>\r  Force Defensive', {
		[1] = 'DT',
		[2] = 'Hide Shots'
	})
	L_14_[L_103_forvar0].
defensive_flick = L_8_.builder:combo('\v\f<radiation>\r  Silent Yaw', {
		[1] =
'Disabled',
		[2] = 'Offset',
		[3] = 'L&R'
	})
	L_14_[L_103_forvar0].defensive_flick_create = L_14_[L_103_forvar0].
defensive_flick:create()
	L_14_[L_103_forvar0].defensive_flick_offset = L_14_[L_103_forvar0].
defensive_flick_create:slider('Offset', -180, 180, 0, 1, '\194\176')
	L_14_[L_103_forvar0].
defensive_flick_l = L_14_[L_103_forvar0].defensive_flick_create:slider('Offset Left', -180, 180,
0, 1, '\194\176')
	L_14_[L_103_forvar0].defensive_flick_r = L_14_[L_103_forvar0].defensive_flick_create:
slider('Offset Right', -180, 180, 0, 1, '\194\176')
	L_14_[L_103_forvar0].defensive_flick_random =
L_14_[L_103_forvar0].defensive_flick_create:slider('Random', 0, 100, 0, 1, '%')
	L_14_[L_103_forvar0].
defensive_yaw = L_8_.builder:combo('\v\f<arrow-rotate-right>\r  Defensive Yaw', {
		[1]
= 'Disabled',
		[2] = 'Default',
		[3] = 'Spin',
		[4] = 'Side-Ways',
		[5] = 'Offset',
		[6] = 'Random'
	})
	L_14_[L_103_forvar0].defensive_yaw_create = L_14_[L_103_forvar0].defensive_yaw:create()
	L_14_[L_103_forvar0].
def_yaw_offset = L_14_[L_103_forvar0].defensive_yaw_create:slider('Offset', -180, 180, 0, 1,
'\194\176')
	L_14_[L_103_forvar0].def_yaw_spin = L_14_[L_103_forvar0].defensive_yaw_create:slider('Offset', 0
, 360, 360, 1, '\194\176')
	L_14_[L_103_forvar0].def_yaw_speed = L_14_[L_103_forvar0].defensive_yaw_create:
slider('Spin Speed', -50, 50, 20, 0.1, 't')
	L_14_[L_103_forvar0].defensive_pitch = L_8_.builder:
combo('\v\f<arrow-up-from-arc>\r  Defensive Pitch', {
		[1] = 'Disabled',
		[2] = 'Spin',
		[3
] = 'Side-Ways',
		[4] = 'Offset',
		[5] = 'Random'
	})
	L_14_[L_103_forvar0].defensive_pitch_create = L_14_[L_103_forvar0
].defensive_pitch:create()
	L_14_[L_103_forvar0].def_pitch_offset = L_14_[L_103_forvar0].
defensive_pitch_create:slider('Offset', -89, 89, 0, 1, '\194\176')
	L_14_[L_103_forvar0].
def_pitch_spin = L_14_[L_103_forvar0].defensive_pitch_create:slider('Offset', 0, 178, 178, 1,
'\194\176')
	L_14_[L_103_forvar0].def_pitch_speed = L_14_[L_103_forvar0].defensive_pitch_create:slider(
'Spin Speed', -50, 50, 20, 0.1, 't')
	L_14_[L_103_forvar0].send_to_t = L_8_.builder:button(
'                                 \v\f<gun>  \r\f<arrow-right-to-arc>   \v\f<shield>                                 '
, function()
	end, true)
	L_14_[L_103_forvar0].send_to_t:tooltip('Send AA Settings To CT-Side')
end
for L_105_forvar0 = 1, #L_10_ do
	do
		local L_106_ = L_105_forvar0
		local L_107_ = {
			[1] = L_11_.condition,
			[2] = function
()
				return L_106_ ~= 1
			end
		}
		local L_108_ = {
			[1] = L_14_[L_106_].enable,
			[2] = function()
				if
L_106_ == 1 then
					return true
				else
					return L_14_[L_106_].enable:get()
				end
			end
		}
		local
L_109_ = {
			[1] = L_11_.condition,
			[2] = L_10_[L_106_]
		}
		local L_110_ = {
			[1] = nil,
			[2] = 2,
			[1] = L_11_.side
		}
		L_14_[L_106_].enable:depend(L_107_, L_109_, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].
yaw_type:depend(L_108_, L_109_, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].yaw:depend(
L_108_, L_109_, {
			[1] = nil,
			[2] = 1,
			[1] = L_14_[L_106_].yaw_type
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		},
L_110_)
		L_14_[L_106_].yaw_left:depend(L_108_, L_109_, {
			[1] = L_14_[L_106_].yaw_type,
			[2] = function
()
				return L_14_[L_106_].yaw_type:get() ~= 1
			end
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_
[L_106_].yaw_right:depend(L_108_, L_109_, {
			[1] = L_14_[L_106_].yaw_type,
			[2] = function()
				return L_14_[L_106_].yaw_type:get() ~= 1
			end
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[
L_106_].yaw_random:depend(L_108_, L_109_, {
			[1] = L_14_[L_106_].yaw_type,
			[2] = function()
				return L_14_[L_106_].yaw_type:get() ~= 1
			end
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[
L_106_].yaw_delay:depend(L_108_, L_109_, {
			[1] = nil,
			[2] = 3,
			[1] = L_14_[L_106_].yaw_type
		}, {
			[1]
= nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].yaw_delay_rand:depend(L_108_, L_109_, {
			[1] = nil,
			[2] = 3,
			[1] = L_14_[L_106_].yaw_type
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].
mod_type:depend(L_108_, L_109_, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].mod_offset:
depend(L_108_, L_109_, {
			[1] = L_14_[L_106_].mod_type,
			[2] = function()
				return L_14_[L_106_].
mod_type:get() ~= 'Disabled'
			end
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].
mod_random:depend(L_108_, L_109_, {
			[1] = L_14_[L_106_].mod_type,
			[2] = function()
				return L_14_[
L_106_].mod_type:get() ~= 'Disabled'
			end
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[
L_106_].body_yaw:depend(L_108_, L_109_, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].
invert:depend(L_108_, L_109_, L_14_[L_106_].body_yaw, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[
L_106_].lby_l:depend(L_108_, L_109_, L_14_[L_106_].body_yaw, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		},
L_110_)
		L_14_[L_106_].lby_r:depend(L_108_, L_109_, L_14_[L_106_].body_yaw, {
			[1] = nil,
			[2] = 2,
			[1] =
L_9_.tab
		}, L_110_)
		L_14_[L_106_].lby_random:depend(L_108_, L_109_, L_14_[L_106_].body_yaw, {
			[1] =
nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].options:depend(L_108_, L_109_, L_14_[L_106_].
body_yaw, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].freestand:depend(L_108_, L_109_,
L_14_[L_106_].body_yaw, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].
force_defensive:depend(L_108_, L_109_, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].
defensive_flick:depend(L_108_, L_109_, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].
defensive_flick_offset:depend(L_108_, L_109_, {
			[1] = nil,
			[2] = 'Offset',
			[1] = L_14_[L_106_].
defensive_flick
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].defensive_flick_l:
depend(L_108_, L_109_, {
			[1] = nil,
			[2] = 'L&R',
			[1] = L_14_[L_106_].defensive_flick
		}, {
			[1] = nil,
			[2]
= 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].defensive_flick_r:depend(L_108_, L_109_, {
			[1] = nil,
			[2] =
'L&R',
			[1] = L_14_[L_106_].defensive_flick
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[
L_106_].defensive_flick_random:depend(L_108_, L_109_, {
			[1] = nil,
			[2] = 'L&R',
			[1] = L_14_[
L_106_].defensive_flick
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].
defensive_yaw:depend(L_108_, L_109_, {
			[1] = nil,
			[2] = 'Disabled',
			[1] = L_14_[L_106_].
defensive_flick
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].def_yaw_offset:
depend(L_108_, L_109_, {
			[1] = L_14_[L_106_].defensive_yaw,
			[2] = function()
				return L_14_[L_106_]
.defensive_yaw:get() == 'Random' or not(L_14_[L_106_].defensive_yaw:get() ~= 'Offset')
or L_14_[L_106_].defensive_yaw:get() == 'Side-Ways'
			end
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}
, L_110_)
		L_14_[L_106_].def_yaw_spin:depend(L_108_, L_109_, {
			[1] = nil,
			[2] = 'Spin',
			[1] = L_14_[
L_106_].defensive_yaw
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].
def_yaw_speed:depend(L_108_, L_109_, {
			[1] = nil,
			[2] = 'Spin',
			[1] = L_14_[L_106_].defensive_yaw
		}
, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].defensive_pitch:depend(L_108_, L_109_, {
			[1
] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].def_pitch_offset:depend(L_108_, L_109_, {
			[1] =
L_14_[L_106_].defensive_pitch,
			[2] = function()
				return L_14_[L_106_].defensive_pitch:
get() == 'Random' or not(L_14_[L_106_].defensive_pitch:get() ~= 'Offset') or L_14_[
L_106_].defensive_pitch:get() == 'Side-Ways'
			end
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].def_pitch_spin:depend(L_108_, L_109_, {
			[1] = nil,
			[2] = 'Spin',
			[1] = L_14_[L_106_].
defensive_pitch
		}, {
			[1] = nil,
			[2] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].def_pitch_speed:
depend(L_108_, L_109_, {
			[1] = nil,
			[2] = 'Spin',
			[1] = L_14_[L_106_].defensive_pitch
		}, {
			[1] = nil,
			[2
] = 2,
			[1] = L_9_.tab
		}, L_110_)
		L_14_[L_106_].send_to_t:depend(L_108_, L_109_, {
			[1] = nil,
			[2] = 2,
			[1] =
L_9_.tab
		}, L_110_)
	end
end
local function L_15_func(L_111_arg0)
	local L_112_ = L_11_.side:get() == 1 and L_14_[
L_111_arg0] or L_13_[L_111_arg0]
	local L_113_ = L_11_.side:get() == 1 and L_13_[L_111_arg0] or L_14_[L_111_arg0]
	L_112_.enable:
set(L_113_.enable:get())
	L_112_.yaw_type:set(L_113_.yaw_type:get())
	L_112_.yaw:set(L_113_.yaw:
get())
	L_112_.yaw_left:set(L_113_.yaw_left:get())
	L_112_.yaw_right:set(L_113_.yaw_right:get())
	L_112_.yaw_random:set(L_113_.yaw_random:get())
	L_112_.yaw_delay:set(L_113_.yaw_delay:get())
	L_112_.yaw_delay_rand:set(L_113_.yaw_delay_rand:get())
	L_112_.mod_type:set(L_113_.mod_type:
get())
	L_112_.mod_offset:set(L_113_.mod_offset:get())
	L_112_.mod_random:set(L_113_.mod_random:
get())
	L_112_.body_yaw:set(L_113_.body_yaw:get())
	L_112_.invert:set(L_113_.invert:get())
	L_112_.
lby_l:set(L_113_.lby_l:get())
	L_112_.lby_r:set(L_113_.lby_r:get())
	L_112_.lby_random:set(L_113_.
lby_random:get())
	L_112_.options:set(L_113_.options:get())
	L_112_.freestand:set(L_113_.
freestand:get())
	L_112_.force_defensive:set(L_113_.force_defensive:get())
	L_112_.
defensive_flick:set(L_113_.defensive_flick:get())
	L_112_.defensive_flick_offset:set(L_113_
.defensive_flick_offset:get())
	L_112_.defensive_flick_l:set(L_113_.defensive_flick_l:
get())
	L_112_.defensive_flick_r:set(L_113_.defensive_flick_r:get())
	L_112_.
defensive_flick_random:set(L_113_.defensive_flick_random:get())
	L_112_.defensive_yaw:
set(L_113_.defensive_yaw:get())
	L_112_.def_yaw_offset:set(L_113_.def_yaw_offset:get())
	L_112_.
def_yaw_spin:set(L_113_.def_yaw_spin:get())
	L_112_.def_yaw_speed:set(L_113_.def_yaw_speed:
get())
	L_112_.defensive_pitch:set(L_113_.defensive_pitch:get())
	L_112_.def_pitch_offset:
set(L_113_.def_pitch_offset:get())
	L_112_.def_pitch_spin:set(L_113_.def_pitch_spin:get())
	L_112_.def_pitch_speed:set(L_113_.def_pitch_speed:get())
end
for L_114_forvar0 = 1, #L_10_ do
	do
		local
L_115_ = L_114_forvar0
		L_13_[L_115_].send_to_t:set_callback(function()
			L_15_func(L_115_)
		end)
		L_14_[
L_115_].send_to_t:set_callback(function()
			L_15_func(L_115_)
		end)
	end
end
local L_16_ = 1
local L_17_ = false
local L_18_ = 0
local L_19_ = {}
local L_20_ = nil
local function L_21_func(L_116_arg0)
	local L_117_ = entity.get_local_player()
	if not L_117_ then
		return
	else
		local L_118_ = bit.
band(L_117_.m_fFlags, 1) == 1
		local L_119_ = bit.band(L_117_.m_fFlags, 1) == 0 or L_116_arg0.in_jump
		local L_120_ = L_117_.m_flDuckAmount > 0.7 or L_7_.fakeduck:get()
		local L_121_ = L_117_.
m_vecVelocity:length() > 5
		if L_117_.m_iTeamNum ~= 3 then
			if L_14_[9].enable:get() and
rage.exploit:get() < 0.9 then
				L_16_ = 9
			elseif L_14_[8].enable:get() and L_120_ and L_119_ then
				L_16_ = 8
			elseif L_14_[7].enable:get() and L_119_ then
				L_16_ = 7
			elseif L_14_[6].enable:get() and
L_120_ and L_121_ then
				L_16_ = 6
			elseif L_14_[5].enable:get() and L_120_ then
				L_16_ = 5
			elseif L_14_[4
].enable:get() and L_118_ and L_7_.slowwalk:get() and L_121_ then
				L_16_ = 4
			elseif L_14_[3].
enable:get() and L_118_ and L_121_ then
				L_16_ = 3
			elseif L_14_[2].enable:get() and L_118_ and not
L_121_ then
				L_16_ = 2
			else
				L_16_ = 1
			end
			L_20_ = L_14_[L_16_]
		else
			if L_13_[9].enable:get() and rage.
exploit:get() < 0.9 then
				L_16_ = 9
			elseif L_13_[8].enable:get() and L_120_ and L_119_ then
				L_16_ =
8
			elseif L_13_[7].enable:get() and L_119_ then
				L_16_ = 7
			elseif L_13_[6].enable:get() and L_120_
and L_121_ then
				L_16_ = 6
			elseif L_13_[5].enable:get() and L_120_ then
				L_16_ = 5
			elseif L_13_[4].
enable:get() and L_118_ and L_7_.slowwalk:get() and L_121_ then
				L_16_ = 4
			elseif L_13_[3].
enable:get() and L_118_ and L_121_ then
				L_16_ = 3
			elseif L_13_[2].enable:get() and L_118_ and not
L_121_ then
				L_16_ = 2
			else
				L_16_ = 1
			end
			L_20_ = L_13_[L_16_]
		end
		if globals.tickcount > L_18_ + L_20_.
yaw_delay:get() + math.random(0, L_20_.yaw_delay_rand:get()) then
			if L_116_arg0.
choked_commands == 0 then
				L_17_ = not L_17_
				L_18_ = globals.tickcount
			end
		elseif globals.
tickcount < L_18_ then
			L_18_ = globals.tickcount
		end
		L_7_.aa_enable:override(true)
		L_7_.
hidden:override(true)
		L_7_.yaw:override('Backward')
		L_7_.pitch:override(L_11_.pitch:
get())
		L_7_.avoidbackstab:override(L_11_.avoid_backstab:get() == 2)
		L_7_.freestanding:
override(L_11_.freestanding:get())
		L_7_.disableyawmod:override(L_11_.
freestanding_static:get())
		L_7_.bodyfreestanding:override(L_11_.freestanding_static:
get())
		L_7_.yawmodifier:override(L_20_.mod_type:get())
		L_7_.yawmodoffset:override(math
.randomize(L_20_.mod_offset:get(), L_20_.mod_random:get()))
		L_7_.bodyyaw:override(L_20_.
body_yaw:get())
		L_7_.inverter:override(L_20_.invert:get())
		L_7_.leftlimit:override(
math.randomize(L_20_.lby_l:get(), L_20_.lby_random:get()))
		L_7_.rightlimit:override(
math.randomize(L_20_.lby_r:get(), L_20_.lby_random:get()))
		L_7_.options:override(L_20_.
options:get())
		L_7_.bodyfrees:override(L_20_.freestand:get())
		if L_20_.yaw_type:get() ==
1 then
			L_7_.yawoffset:override(L_20_.yaw:get())
		else
			L_7_.yawoffset:override(rage.
antiaim:inverter() and math.randomize(L_20_.yaw_left:get(), L_20_.yaw_random:get()) or
math.randomize(L_20_.yaw_right:get(), L_20_.yaw_random:get()))
		end
		if L_20_.yaw_type:
get() == 3 then
			L_7_.options:override('')
			L_7_.inverter:override(L_17_)
		end
		L_7_.
lagoptions:override(L_20_.force_defensive:get('DT') and 'Always On' or 'On Peek')
		L_7_.
hsoptions:override(L_20_.force_defensive:get('Hide Shots') and 'Break LC' or
'Favor Fire Rate')
		if L_20_.defensive_flick:get() == 'Offset' then
			L_116_arg0.force_defensive
= L_116_arg0.choked_commands == 1 and L_116_arg0.send_packet == true and L_116_arg0.command_number % 13 > 8
			rage.antiaim:override_hidden_yaw_offset(L_20_.defensive_flick_offset:get())
		elseif
L_20_.defensive_flick:get() == 'L&R' then
			L_116_arg0.force_defensive = L_116_arg0.choked_commands == 1
and L_116_arg0.send_packet == true and L_116_arg0.command_number % 13 > 8
			rage.antiaim:
override_hidden_yaw_offset(rage.antiaim:inverter() and math.randomize(L_20_.
defensive_flick_l:get(), L_20_.defensive_flick_random:get()) or math.randomize(L_20_.
defensive_flick_r:get(), L_20_.defensive_flick_random:get()))
		end
		if L_20_.
defensive_flick:get() == 'Disabled' then
			if L_20_.defensive_yaw:get() == 'Disabled' then
				rage.antiaim:override_hidden_yaw_offset(0)
			elseif L_20_.defensive_yaw:get() ==
'Side-Ways' then
				rage.antiaim:override_hidden_yaw_offset(rage.antiaim:inverter()
and L_20_.def_yaw_offset:get() or -L_20_.def_yaw_offset:get())
			elseif L_20_.defensive_yaw
:get() == 'Offset' then
				rage.antiaim:override_hidden_yaw_offset(L_20_.def_yaw_offset:
get())
			elseif L_20_.defensive_yaw:get() == 'Random' then
				rage.antiaim:
override_hidden_yaw_offset(math.random(-L_20_.def_yaw_offset:get(), L_20_.
def_yaw_offset:get()))
			elseif L_20_.defensive_yaw:get() == 'Spin' then
				rage.antiaim:
override_hidden_yaw_offset(math.spin(L_20_.def_yaw_speed:get(), L_20_.def_yaw_spin:
get()))
			end
		end
		if L_20_.defensive_pitch:get() == 'Spin' then
			rage.antiaim:
override_hidden_pitch(math.spin(L_20_.def_pitch_speed:get(), L_20_.def_pitch_spin:
get()))
		elseif L_20_.defensive_pitch:get() == 'Side-Ways' then
			rage.antiaim:
override_hidden_pitch(rage.antiaim:inverter() and L_20_.def_pitch_offset:get() or -
L_20_.def_pitch_offset:get())
		elseif L_20_.defensive_pitch:get() == 'Offset' then
			rage.
antiaim:override_hidden_pitch(L_20_.def_pitch_offset:get())
		elseif L_20_.
defensive_pitch:get() == 'Random' then
			rage.antiaim:override_hidden_pitch(math.
random(-L_20_.def_pitch_offset:get(), L_20_.def_pitch_offset:get()))
		end
		entity.
get_players(true, true, function(L_123_arg0)
			if L_123_arg0:is_alive() then
				table.insert(L_19_, L_123_arg0)
			end
		end)
		if L_11_.aa_override:get('No Enemies Alive') and #L_19_ == 0 then
			L_7_.yawoffset:
override(math.spin(10, 360))
			L_7_.hidden:override(false)
			L_7_.bodyyaw:override(false)
			L_7_.lagoptions:override('Disabled')
			L_7_.hsoptions:override('Favor Fire Rate')
			L_7_.
yawmodifier:override('Disabled')
			L_7_.options:override('')
			L_7_.pitch:override(
'Disabled')
		end
		if L_11_.aa_override:get('Warmup') and entity.get_game_rules().
m_bWarmupPeriod then
			L_7_.yawoffset:override(math.spin(10, 360))
			L_7_.hidden:
override(false)
			L_7_.bodyyaw:override(false)
			L_7_.lagoptions:override('Disabled')
			L_7_
.hsoptions:override('Favor Fire Rate')
			L_7_.yawmodifier:override('Disabled')
			L_7_.
options:override('')
			L_7_.pitch:override('Disabled')
		end
		L_19_ = {}
		local L_122_ = L_117_:
get_player_weapon()
		if not L_122_ then
			return
		else
			local L_124_ = L_122_:get_classname()
			if
not L_124_ then
				return
			else
				if L_11_.safe_head:get('Air+C Knife') and L_124_ == 'CKnife' and
L_120_ and L_119_ then
					L_7_.pitch:override('Down')
					L_7_.yawmodifier:override('Disabled')
					L_7_.yawoffset:override(26)
					L_7_.options:override('')
					L_7_.inverter:override(false)
					L_7_.hidden:override(false)
				end
				if L_11_.safe_head:get('Air+C Zeus') and L_124_ ==
'CWeaponTaser' and L_120_ and L_119_ then
					L_7_.pitch:override('Down')
					L_7_.yawmodifier:
override('Disabled')
					L_7_.yawoffset:override(26)
					L_7_.options:override('')
					L_7_.
inverter:override(false)
					L_7_.hidden:override(false)
				end
				if L_11_.freestanding:get()
and L_11_.freestanding_flick:get() and rage.antiaim:get_target(true) then
					L_7_.hidden
:override(true)
					L_7_.lagoptions:override('Always On')
					L_7_.hsoptions:override(
'Break LC')
					rage.antiaim:override_hidden_yaw_offset(180)
					rage.antiaim:
override_hidden_pitch(L_11_.freestanding_flick_offset:get())
				end
				if L_11_.yaw_base:
get() == 'At Target' then
					L_7_.yawbase:override('At Target')
				elseif L_11_.yaw_base:get(
) == 'Local View' then
					L_7_.yawbase:override('Local View')
				elseif L_11_.yaw_base:get()
== 'Left' then
					L_7_.yawbase:override('Local View')
					L_7_.yawoffset:override(-90)
					L_7_.
hidden:override(false)
					L_7_.freestanding:override(false)
					if L_11_.yaw_base_static:
get() then
						L_7_.yawmodifier:override('Disabled')
						L_7_.options:override('')
						L_7_.
inverter:override(false)
						L_7_.hidden:override(false)
					end
					if L_11_.yaw_base_flick:get(
) then
						L_7_.hidden:override(true)
						L_7_.lagoptions:override('Always On')
						L_7_.hsoptions
:override('Break LC')
						rage.antiaim:override_hidden_yaw_offset(180)
						rage.antiaim:
override_hidden_pitch(L_11_.yaw_base_flick_offset:get())
					end
				elseif L_11_.yaw_base:
get() == 'Right' then
					L_7_.yawbase:override('Local View')
					L_7_.yawoffset:override(90)
					L_7_.hidden:override(false)
					L_7_.freestanding:override(false)
					if L_11_.yaw_base_static
:get() then
						L_7_.yawmodifier:override('Disabled')
						L_7_.options:override('')
						L_7_.
inverter:override(false)
						L_7_.hidden:override(false)
					end
					if L_11_.yaw_base_flick:get(
) then
						L_7_.hidden:override(true)
						L_7_.lagoptions:override('Always On')
						L_7_.hsoptions
:override('Break LC')
						rage.antiaim:override_hidden_yaw_offset(180)
						rage.antiaim:
override_hidden_pitch(L_11_.yaw_base_flick_offset:get())
					end
				elseif L_11_.yaw_base:
get() == 'Forward' then
					L_7_.yawbase:override('Local View')
					L_7_.yawoffset:override(
180)
					L_7_.hidden:override(false)
					if L_11_.yaw_base_static:get() then
						L_7_.yawmodifier:
override('Disabled')
						L_7_.options:override('')
						L_7_.inverter:override(false)
						L_7_.
hidden:override(false)
					end
					if L_11_.yaw_base_flick:get() then
						L_7_.hidden:override(
true)
						L_7_.lagoptions:override('Always On')
						L_7_.hsoptions:override('Break LC')
						rage.
antiaim:override_hidden_yaw_offset(180)
						rage.antiaim:override_hidden_pitch(L_11_.
yaw_base_flick_offset:get())
					end
				end
				return
			end
		end
	end
end
local L_22_ = ffi.typeof(
'uintptr_t**')
local L_23_ = utils.get_vfunc('client.dll', 'VClientEntityList003', 3,
'void*(__thiscall*)(void*, int)')
local L_24_ = 0
local L_25_ = 0
local function L_26_func()
	local L_125_ = entity.get_local_player()
	if not L_125_ then
		return
	else
		if bit.band(L_125_.
m_fFlags, 1) == 1 then
			L_24_ = L_24_ + 1
		else
			L_24_ = 0
			L_25_ = globals.curtime + 1
		end
		return L_24_ > 1
and L_25_ > globals.curtime
	end
end
local function L_27_func()
	if not L_6_ then
		return
	else
		lp = entity.get_local_player()
		if lp == nil then
			return
		elseif not lp:is_alive() then
			return
		elseif lp:get_index() == nil then
			return
		else
			local L_126_ = lp.m_vecVelocity:
length() > 5
			local L_127_ = L_23_(lp:get_index())
			if not L_11_.anim_break:get() then
				return
			else
				if L_11_.anim_break_ground:get() == 'Static' then
					lp.m_flPoseParameter[0] = L_11_.
anim_break_ground_amount:get() / 10
					L_7_.legmovement:override('Sliding')
				elseif L_11_.
anim_break_ground:get() == 'Jitter' then
					L_7_.legmovement:override('Sliding')
					lp.
m_flPoseParameter[0] = globals.tickcount % 4 > 1 and L_11_.anim_break_ground_amount:get(
) / 10 or 1
				elseif L_11_.anim_break_ground:get() == 'Better Jitter' then
					L_7_.
legmovement:override('Sliding')
					lp.m_flPoseParameter[0] = math.random(0, 10) / 10
				elseif L_11_.anim_break_ground:get() == 'Moonwalk' then
					L_7_.legmovement:override(
'Walking')
					lp.m_flPoseParameter[7] = 1
				end
				if L_11_.anim_break_air:get() == 'Static'
then
					lp.m_flPoseParameter[6] = 1
				elseif L_11_.anim_break_air:get() == 'Jitter' then
					lp.
m_flPoseParameter[6] = globals.tickcount % 4 > 1 and 0 or 1
				elseif L_11_.anim_break_air:
get() == 'Moonwalk' and L_126_ and bit.band(lp.m_fFlags, 1) == 0 then
					ffi.cast(
'animstate_layer_t**', ffi.cast('uintptr_t', L_127_) + 10640)[0][6].m_flWeight = 1
				end
				if
L_11_.anim_break_other:get('Pitch 0 On Land') and L_26_func() then
					lp.m_flPoseParameter[12
] = 0.5
				end
				if L_11_.anim_break_other:get('EarthQuake') then
					ffi.cast(
'animstate_layer_t**', ffi.cast('uintptr_t', L_127_) + 10640)[0][12].m_flWeight = math.
random(0, 100) / 100
				end
				if L_11_.anim_break_other:get('Move Lean') and not L_11_.
anim_break_other:get('EarthQuake') then
					if not L_126_ then
						return
					else
						ffi.cast(
'animstate_layer_t**', ffi.cast('uintptr_t', L_127_) + 10640)[0][12].m_flWeight = L_11_.
anim_break_lean:get() / 10
					end
				end
				return
			end
		end
	end
end
events.
post_update_clientside_animation:set(L_27_func)
local L_28_ = {}
local L_29_ = render.
screen_size()
local L_30_ = L_29_ / 2
L_28_.dmg_ind = function()
	local L_128_ = entity.
get_local_player()
	if not L_128_ then
		return
	elseif not L_128_:is_alive() then
		return
	else
		render.text(L_12_.min_damage_font:get(), vector(L_30_.x + 5, L_30_.y - 15), L_12_.
min_damage_color:get(), '', ui.find('Aimbot', 'Ragebot', 'Selection', 'Min. Damage'):
get())
		return
	end
end
local L_31_ = 0
local L_32_ = L_31_
local function L_33_func()
	utils.
execute_after(0.1, function()
		L_32_ = L_31_
		L_33_func()
	end)
end
L_33_func()
local L_34_ = render.
load_font('Verdana', 15, 'ad')
L_28_.custom_hud = function()
	if not entity.
get_local_player() then
		return
	else
		L_31_ = L_5_.Client.GetFPS()
		local L_129_ = utils
.net_channel()
		local L_130_ = math.floor(L_129_.latency[1] * 1000)
		local L_131_ = L_129_.loss[0]
		local L_132_ = math.floor(L_131_ * 100 + 0.5)
		local L_133_ = L_12_.custom_hud_text_color:get():
to_hex()
		local L_134_ = '\a' .. L_133_ .. ui.get_icon('computer') .. '\aDCDCDCFF fps: ' ..
L_32_ .. '  \a' .. L_133_ .. ui.get_icon('code-branch') .. ' \aDCDCDCFFloss: ' .. L_132_ ..
'  \a' .. L_133_ .. ui.get_icon('wifi') .. ' \aDCDCDCFFping: ' .. L_130_
		local L_135_ = render.
measure_text(L_34_, 'ad', L_134_)
		render.rect(vector(L_29_.x / 2 - 5 - L_135_.x / 2, L_29_.y - 32),
vector(L_29_.x / 2 + L_135_.x + 5 - L_135_.x / 2, L_29_.y - 8), color(40, 40, 40, 150), 4)
		render.
rect_outline(vector(L_29_.x / 2 - 5 - L_135_.x / 2, L_29_.y - 32), vector(L_29_.x / 2 + L_135_.x + 5 - L_135_.x /
2, L_29_.y - 8), color(L_12_.custom_hud_color:get().r, L_12_.custom_hud_color:get().g, L_12_.
custom_hud_color:get().b, 150), 1, 4)
		render.shadow(vector(L_29_.x / 2 - 5 - L_135_.x / 2, L_29_.y -
32), vector(L_29_.x / 2 + L_135_.x + 5 - L_135_.x / 2, L_29_.y - 8), color(L_12_.custom_hud_color:get().r
, L_12_.custom_hud_color:get().g, L_12_.custom_hud_color:get().b, 255), 20, 0, 4)
		render.
text(L_34_, vector(L_29_.x / 2 - L_135_.x / 2, L_29_.y - 29), color(220), '', L_134_)
		return
	end
end
local L_35_ = L_5_.Client.GetAvatar()
L_28_.watermark = function()
	local L_136_ =
entity.get_local_player()
	if not L_136_ then
		return
	elseif not L_136_:is_alive() then
		return
	else
		local L_137_ = L_4_.text_animate('R E N A I S S A N C E', -1, {
			color(220),
			color(190),
			color(160)
		})
		if L_12_.watermark:get() == 'Default' then
			L_137_:
animate()
			render.text(1, vector(25, L_30_.y - 15), color(255), '', L_137_:get_animated_text(
))
		else
			render.text(2, vector(55, L_30_.y - 50), color(255), '', 'RENAISSANCE')
			render.
text(2, vector(55, L_30_.y - 40), color(255), '', '[DEV]')
			render.texture(L_35_, vector(10,
L_30_.y - 57), vector(40, 40))
		end
		return
	end
end
local L_36_ = 0
L_28_.customscope = function
()
	local L_138_ = L_30_.x
	local L_139_ = L_30_.y
	local L_140_ = entity.get_local_player()
	if not
L_140_ then
		return
	elseif not L_140_:is_alive() then
		return
	else
		local
L_141_ = L_140_.m_bIsScoped
		L_36_ = math.lerp(L_36_, L_141_ and L_12_.
custom_scope_color:get().a or 0, 10)
		local L_142_ = color(L_12_.custom_scope_color:get()
.r, L_12_.custom_scope_color:get().g, L_12_.custom_scope_color:get().b, L_36_)
		local L_143_
= color(L_142_.r, L_142_.g, L_142_.b, 1)
		if L_141_ then
			render.gradient(vector(
L_138_, L_139_ + L_12_.custom_scope_offset:get()), vector(L_138_ + 1, L_139_ + L_12_.
custom_scope_length:get() + L_12_.custom_scope_offset:get()), L_142_, L_142_, L_143_, L_143_)
			render.gradient(vector(L_138_ + L_12_.custom_scope_length:get() + L_12_.
custom_scope_offset:get(), L_139_), vector(L_138_ + L_12_.custom_scope_offset:get(),
L_139_ + 1), L_143_, L_142_, L_143_, L_142_)
			render.gradient(vector(L_138_, L_139_ - (L_12_.
custom_scope_offset:get() - 1) - L_12_.custom_scope_length:get()), vector(L_138_ + 1, L_139_
- (L_12_.custom_scope_offset:get() - 1)), L_143_, L_143_, L_142_, L_142_)
			render.gradient(vector(
L_138_ - L_12_.custom_scope_length:get() - (L_12_.custom_scope_offset:get() - 1), L_139_),
vector(L_138_ - (L_12_.custom_scope_offset:get() - 1), L_139_ + 1), L_143_, L_142_, L_143_, L_142_)
		end
		return
	end
end
local L_37_ = {}
L_28_.screen_notify = function()
	local L_144_ = 0
	local L_145_ =
L_29_.y * 0.9
	for L_146_forvar0, L_147_forvar1 in ipairs(L_37_) do
		local L_148_, L_149_, L_150_, L_151_ = unpack(L_147_forvar1)
		local L_152_ = globals.curtime - L_150_ < 4 and (not(#L_37_ > 6) or L_146_forvar0 >= #L_37_ - 5)
		local L_153_ =
math.lerp(L_149_, L_152_ and 255 or 0, 20)
		L_147_forvar1[2] = L_153_
		L_144_ = L_144_ + 25 * (L_153_ / 255)
		local
L_154_ = render.measure_text(1, 'od', L_148_)
		local L_155_ = L_30_.x
		local L_156_ = vector(L_155_ -
L_154_.x / 2, L_145_ - L_144_ + 6)
		local L_157_ = vector(L_155_ + L_154_.x / 2, L_145_ - L_144_ + 6)
		render.shadow(
L_156_, L_157_, color(L_151_.r, L_151_.g, L_151_.b, L_153_), 30, 0, 0)
		local L_158_ = vector(L_155_ - L_154_.x
/ 2, L_145_ - L_144_)
		render.text(1, L_158_, color(255, 255, 255, L_153_), 'od', L_148_)
		if L_153_ < 0.1 or
not entity.get_local_player() then
			table.remove(L_37_, L_146_forvar0)
		end
	end
end
render.
notify = function(L_159_arg0, L_160_arg1)
	table.insert(L_37_, {
		[1] = nil,
		[2] = 0,
		[1] = L_159_arg0,
		[3] = globals.
curtime,
		[4] = L_160_arg1
	})
end
L_28_.lc_teleport = function(L_161_arg0)
	local L_162_ = entity.
get_local_player()
	if not L_162_ then
		return
	elseif not L_162_:is_alive() then
		return
	else
		local L_163_ = bit.band(L_162_.m_fFlags, 1) == 0
		local L_164_ = L_162_.m_vecVelocity:
length() > 10
		if L_163_ and L_164_ and entity.get_threat(true) then
			L_161_arg0.
force_defensive = true
			utils.execute_after(0.07, function()
				rage.exploit:
force_teleport()
			end)
		end
		return
	end
end
local L_38_ = {
	freezetime_status = false,
	freeze_check = false,
	fd = ui.find('Aimbot', 'Anti Aim', 'Misc', 'Fake Duck'),
	is_fd_on =
ui.find('Aimbot', 'Anti Aim', 'Misc', 'Fake Duck'):get()
}
L_38_.fd:set_callback(
function()
	L_38_.is_fd_on = L_38_.fd:get()
end)
L_28_.fast_fd = function(L_165_arg0)
	if not L_38_.
is_fd_on then
		return
	else
		local L_166_ = entity.get_local_player()
		if not L_166_ or not
L_166_:is_alive() then
			return
		else
			local L_167_ = 5
			local L_168_ = L_165_arg0.
forwardmove
			local L_169_ = L_165_arg0.sidemove
			if L_167_ < math.abs(L_168_) or
L_167_ < math.abs(L_169_) then
				local L_170_ = 450 / (L_168_ * L_168_ +
L_169_ * L_169_) ^ 0.5
				L_165_arg0.forwardmove = L_168_ * L_170_
				L_165_arg0.
sidemove = L_169_ * L_170_
			end
			return
		end
	end
end
L_28_.freeze_fd = function()
	local
L_171_ = entity.get_game_rules()
	if not L_171_ then
		return
	else
		L_38_.freezetime_status =
L_171_.m_bFreezePeriod
		if L_38_.freezetime_status then
			L_171_.m_bFreezePeriod = false
			L_38_.freeze_check = true
		end
		return
	end
end
L_28_.freeze_fd_run = function()
	if not
L_38_.freeze_check then
		return
	else
		local L_172_ = entity.get_game_rules()
		if L_172_
then
			L_172_.m_bFreezePeriod = L_38_.freezetime_status
			L_38_.freeze_check = false
		end
		return
	end
end
local L_39_ = false
L_28_.hegrenade_fix = function(L_173_arg0)
	ui.find('Aimbot'
, 'Ragebot', 'Main', 'Double Tap', 'Lag Options'):override()
	ui.find('Miscellaneous',
'Main', 'Other', 'Weapon Actions'):override('Auto Pistols')
	local L_174_ = entity.
get_local_player()
	if not L_174_ then
		return
	else
		local L_175_ = L_174_:
get_player_weapon()
		if not L_175_ then
			return
		else
			local L_176_ = L_175_:get_classname()
			if not L_176_ then
				return
			else
				if string.match(L_176_, 'Grenade') then
					rage.exploit:
allow_defensive(false)
					L_173_arg0.force_defensive = false
					ui.find('Aimbot', 'Ragebot',
'Main', 'Double Tap', 'Lag Options'):override('Disabled')
					local L_177_ =
L_175_.m_fThrowTime
					if L_177_ ~= nil and L_177_ ~= 0 then
						L_39_ =
true
						for L_178_forvar0 = 1, 10 do
							L_173_arg0.in_attack = true
						end
					elseif L_39_ then
						L_173_arg0.in_attack = true
						utils.execute_after(0.01, function()
							utils.console_exec('slot2')
							utils.
console_exec('slot1')
						end)
						L_39_ = false
					end
				else
					L_39_ = false
				end
				if L_173_arg0.weaponselect
~= 0 then
					L_173_arg0.force_defensive = true
				end
				return
			end
		end
	end
end
L_28_.
avoid_collision = function(L_179_arg0)
	local L_180_ = entity.get_local_player()
	if not L_180_ or
not L_179_arg0.in_jump then
		return
	else
		local L_181_ = math.huge
		local L_182_ = nil
		local
L_183_ = L_180_.m_vecOrigin
		local L_184_ = render.camera_angles().y
		for L_185_forvar0 = 1
, 180 do
			local L_186_ = L_184_ + L_185_forvar0 - 90
			local L_187_ = math.compute_vector(0, L_186_)
			local
L_188_ = vector(L_183_.x + L_187_.x * 70, L_183_.y + L_187_.y * 70,
L_183_.z + 60)
			local L_189_ = L_183_:dist(utils.trace_line(
L_183_, L_188_, nil, nil, 1).end_pos)
			if L_189_ < L_181_ then
				L_181_ = L_189_
				L_182_
= L_185_forvar0
			end
		end
		if L_182_ and L_181_ < 40 and not L_179_arg0.in_back and not L_179_arg0.
in_moveleft and not L_179_arg0.in_moveright then
			local L_190_ = L_180_.m_vecVelocity:length(
)
			local L_191_ = math.rad(L_182_)
			L_179_arg0.sidemove = L_190_ * math.sin(L_191_)
			if L_182_ < 90 then
				L_179_arg0.
sidemove = -L_179_arg0.sidemove
			end
			L_179_arg0.forwardmove = math.abs(L_190_ * math.cos(L_191_))
		end
		return
	end
end
L_28_.autostop_func = function(L_192_arg0, L_193_arg1)
	local L_194_ = math.sqrt(L_192_arg0.
forwardmove * L_192_arg0.forwardmove + L_192_arg0.sidemove * L_192_arg0.sidemove)
	if L_193_arg1 <= 0 or L_194_ <= 0
then
		return
	else
		if L_192_arg0.in_duck == 1 then
			L_193_arg1 = L_193_arg1 * 2.94117647
		end
		if L_194_ <= L_193_arg1
then
			return
		else
			local L_195_ = L_193_arg1 / L_194_
			L_192_arg0.forwardmove = L_192_arg0.forwardmove * L_195_
			L_192_arg0.sidemove = L_192_arg0.sidemove * L_195_
			return
		end
	end
end
L_28_.check_attack = function(
L_196_arg0)
	if not L_196_arg0 then
		return
	else
		local L_197_ = L_196_arg0:get_player_weapon()
		if not L_197_
then
			return
		else
			return L_197_.m_flNextPrimaryAttack < globals.curtime
		end
	end
end
L_28_.dormantaimbot = function(L_198_arg0)
	local L_199_ = entity.get_local_player()
	if not L_199_
then
		return
	else
		local L_200_ = L_199_:get_player_weapon()
		if not L_200_ then
			return
		else
			local L_201_ = L_200_:get_inaccuracy()
			if not L_201_ then
				return
			else
				local L_202_ = L_200_:
get_weapon_info()
				local L_203_ = bit.band(L_199_.m_fFlags, 1) == 1
				local L_204_ = L_199_:
get_eye_position()
				local L_205_ = L_199_.m_bIsScoped
				local L_206_ = entity.
get_players(true, true)
				for L_207_forvar0 = 1, #L_206_ do
					local L_208_ = L_206_[L_207_forvar0]
					if L_208_:
is_dormant() then
						origin = L_208_:get_origin()
						local L_209_ = L_208_:get_bbox()
						if origin.x ~=
0 and L_209_.alpha ~= 0 and (L_208_:get_network_state() == 1 or not(L_208_:
get_network_state() ~= 2) or not(L_208_:get_network_state() ~= 3) or L_208_:
get_network_state() == 4) then
							local L_210_ = origin + vector(0, 0, 30)
							local L_211_ = L_204_:to(
L_210_):angles()
							local L_212_, L_213_ = utils.trace_bullet(L_199_, vector(L_204_.x, L_204_.y, L_204_.
z), vector(L_210_.x, L_210_.y, L_210_.z), true)
							if L_213_ then
								if not L_213_:did_hit_world()
then
									return
								elseif (L_213_.fraction < 1 or L_213_.fraction_left_solid == 1) and ui.find(
'Aimbot', 'Ragebot', 'Selection', 'Min. Damage'):get() < L_212_ and not L_208_:
is_visible() and L_28_.check_attack(L_199_) then
									L_28_.autostop_func(L_198_arg0, (
L_205_ and L_202_.max_player_speed_alt or L_202_.max_player_speed) * 0.33)
									if
L_202_.weapon_class == 'primary_sniper' and not L_205_ then
										L_198_arg0.in_attack2 =
1
									end
									if L_201_ < 0.009 and not ui.find('Aimbot', 'Anti Aim', 'Misc', 'Fake Duck'):get(
) then
										L_198_arg0.no_choke = true
									end
									if L_201_ < 0.009 and L_198_arg0.choked_commands == 0 then
										L_198_arg0
.view_angles.x = L_211_.x
										L_198_arg0.view_angles.y = L_211_.y
										L_198_arg0.in_attack = 1
									end
								end
							end
						end
					end
				end
				return
			end
		end
	end
end
L_28_.no_fall_damage = function(L_214_arg0)
	local L_215_ =
entity.get_local_player()
	if not L_215_ then
		return
	elseif L_215_.m_vecVelocity.z > -
500 then
		return
	else
		local L_216_ = L_215_:get_origin()
		local L_217_ = vector(L_216_.x, L_216_.y
, L_216_.z)
		local L_218_ = vector(L_216_.x, L_216_.y, L_216_.z - 15)
		local L_219_ = vector(L_216_.x, L_216_.
y, L_216_.z - 50)
		local L_220_ = utils.trace_line(L_217_, L_218_)
		local L_221_ = utils.trace_line(
L_217_, L_219_)
		if L_220_.fraction ~= 1 then
			L_214_arg0.in_duck = 0
		elseif L_221_.fraction ~= 1 then
			L_214_arg0.in_duck = 1
		end
		return
	end
end
L_28_.fastladder = function(L_222_arg0)
	local L_223_ = entity
.get_local_player()
	if not L_223_ or L_223_.m_MoveType ~= 9 then
		return
	else
		local
L_224_ = L_222_arg0.view_angles
		if L_222_arg0.sidemove == 0 then
			L_224_.y =
L_224_.y + 45
		elseif L_222_arg0.sidemove < 0 and L_222_arg0.in_forward then
			L_224_.y = L_224_.y + 90
		elseif L_222_arg0.sidemove > 0 and L_222_arg0.in_back
then
			L_224_.y = L_224_.y + 90
		end
		L_222_arg0.in_moveleft = L_222_arg0.in_back
		L_222_arg0.in_moveright = L_222_arg0.in_forward
		if L_224_.x < 0 then
			L_224_.x =
-45
		end
		return
	end
end
L_28_.auto_hs = function(L_225_arg0)
	local L_226_ = entity.
get_local_player()
	if not L_226_ then
		return
	else
		local L_227_ = L_226_:
get_player_weapon()
		if not L_227_ then
			return
		else
			local L_228_ = L_227_:get_weapon_info(
)
			if not L_228_ then
				return
			else
				local L_229_ = bit.band(L_226_.m_fFlags, 1) == 1
				local L_230_
= L_226_.m_vecVelocity:length() < 3 and L_229_
				local L_231_ = L_226_.m_flDuckAmount > 0.7 or
L_7_.fakeduck:get()
				if L_12_.auto_hideshots:get() and ui.find('Aimbot', 'Ragebot',
'Main', 'Double Tap'):get() and L_228_.cycle_time > 1 and rage.exploit:get() > 0.99 and (
L_231_ and L_229_ or L_230_) then
					ui.find('Aimbot', 'Ragebot', 'Main', 'Hide Shots'):
override(true)
					ui.find('Aimbot', 'Ragebot', 'Main', 'Double Tap'):override(false)
				else
					ui.find('Aimbot', 'Ragebot', 'Main', 'Hide Shots'):override()
					ui.find('Aimbot',
'Ragebot', 'Main', 'Double Tap'):override()
				end
				return
			end
		end
	end
end
local L_40_ = {
	adjust = function(L_232_arg0)
		if L_232_arg0.x > -10 then
			L_232_arg0.x = 0.9 * L_232_arg0.x + 9
		else
			L_232_arg0.x = 1.125 *
L_232_arg0.x + 11.25
		end
		return L_232_arg0
	end
}
L_40_.calculate_grenade_path = function(L_233_arg0, L_234_arg1,
L_235_arg2, L_236_arg3)
	L_233_arg0.x = L_233_arg0.x - 10 + math.abs(L_233_arg0.x) / 9
	local L_237_ = vector():angles(L_233_arg0)
	local L_238_ = L_236_arg3 * 1.25
	local L_239_ = math.clamp(L_234_arg1 * 0.9, 15, 750)
	local L_240_ = math.
clamp(L_235_arg2, 0, 1)
	L_239_ = L_239_ * math.interpolate(0.3, 1, L_240_)
	local L_241_ = L_237_
	for L_243_forvar0 = 1
, 8 do
		L_241_ = (L_237_ * (L_241_ * L_239_ + L_238_):length() - L_238_) / L_239_
		L_241_:
normalize()
	end
	local L_242_ = L_241_.angles(L_241_)
	return (L_40_.adjust(L_242_))
end
events.grenade_override_view:set(function(L_244_arg0)
	if not L_6_ then
		return
	elseif not
L_12_.main_func:get(1) then
		return
	else
		local L_245_ = entity.get_local_player()
		if not
L_245_ then
			return
		else
			local L_246_ = L_245_:get_player_weapon()
			if not L_246_ then
				return
			else
				local L_247_ = L_246_:get_weapon_info()
				if not L_247_ then
					return
				else
					L_244_arg0.angles =
L_40_.calculate_grenade_path(L_244_arg0.angles, L_247_.throw_velocity, L_246_.
m_flThrowStrength, L_244_arg0.velocity)
					return
				end
			end
		end
	end
end)
L_28_.super_toss =
function(L_248_arg0)
	if not L_6_ then
		return
	elseif L_248_arg0.jitter_move ~= true then
		return
	else
		local L_249_ = entity.get_local_player()
		if not L_249_ then
			return
		else
			local L_250_
= L_249_:get_player_weapon()
			if not L_250_ then
				return
			else
				local L_251_ = L_250_:
get_weapon_info()
				if not L_251_ or L_251_.weapon_type ~= 9 then
					return
				elseif L_250_.
m_fThrowTime < globals.curtime - to_time(globals.clock_offset) then
					return
				else
					L_248_arg0.
in_speed = true
					local L_252_ = L_249_:simulate_movement()
					L_252_:think()
					L_248_arg0.view_angles =
L_40_.calculate_grenade_path(L_248_arg0.view_angles, L_251_.throw_velocity, L_250_.
m_flThrowStrength, L_252_.velocity)
					return
				end
			end
		end
	end
end
L_28_.set_aspectratio =
function()
	cvar.r_aspectratio:float(L_12_.aspectratio:get() and L_12_.
aspectratio_value:get() / 100 or 0)
end
L_28_.set_aspectratio()
L_12_.aspectratio:
set_callback(function()
	L_28_.set_aspectratio()
end)
L_12_.aspectratio_value:
set_callback(function()
	L_28_.set_aspectratio()
end)
L_28_.set_viewmodel = function()
	cvar
.sv_competitive_minspec:int(0)
	cvar.viewmodel_fov:int(L_12_.viewmodel:get() and L_12_.
viewmodel_fov:get() or 68)
	cvar.viewmodel_offset_x:float(L_12_.viewmodel:get() and
L_12_.viewmodel_x:get() / 10 or 2.5)
	cvar.viewmodel_offset_y:float(L_12_.viewmodel:get(
) and L_12_.viewmodel_y:get() / 10 or 0)
	cvar.viewmodel_offset_z:float(L_12_.viewmodel:
get() and L_12_.viewmodel_z:get() / 10 or -1.5)
end
L_28_.set_viewmodel()
L_12_.viewmodel:
set_callback(function()
	L_28_.set_viewmodel()
end)
L_12_.viewmodel_fov:set_callback(
function()
	L_28_.set_viewmodel()
end)
L_12_.viewmodel_x:set_callback(function()
	L_28_.
set_viewmodel()
end)
L_12_.viewmodel_y:set_callback(function()
	L_28_.set_viewmodel()
end
)
L_12_.viewmodel_z:set_callback(function()
	L_28_.set_viewmodel()
end)
local L_41_ = {
	[0] =
'generic',
	[1] = 'head',
	[2] = 'chest',
	[3] = 'stomach',
	[4] = 'left arm',
	[5] = 'right arm',
	[6
] = 'left leg',
	[7] = 'right leg',
	[8] = 'neck',
	[9] = 'generic',
	[10] = 'gear'
}
events.aim_ack
:set(function(L_253_arg0)
	if not L_6_ then
		return
	else
		local L_254_ = entity.get(L_253_arg0.target)
		if not L_254_ then
			return
		else
			local L_255_ = L_12_.screen_logs_hit:get()
			local L_256_ =
color(L_255_.r, L_255_.g, L_255_.b, 255)
			local L_257_ = L_256_:to_hex()
			local L_258_ = L_12_.logs_hit:
get()
			local L_259_ = '\a' .. color(L_258_.r, L_258_.g, L_258_.b, 255):to_hex()
			local L_260_ = L_41_[
L_253_arg0.hitgroup]
			local L_261_ = L_253_arg0.damage
			if L_253_arg0.state == nil then
				if L_253_arg0.
wanted_hitgroup ~= L_253_arg0.hitgroup then
					L_260_ = string.format('%s (%s)', L_260_, L_41_[L_253_arg0.
wanted_hitgroup or L_253_arg0.hitgroup])
				end
				if L_253_arg0.wanted_damage ~= L_253_arg0.damage then
					L_261_ = string.format('%s (%s)', L_261_, L_253_arg0.wanted_damage)
				end
				local L_262_ =
string.format(
'%s[renaissance]\aFFFFFFFF Registered shot in %s%s\aFFFFFFFF %s for%s %s damage\aFFFFFFFF (hitchance: %s%d%%\aFFFFFFFF | safety: %s1\aFFFFFFFF | history(\206\148): %s%d\aFFFFFFFF)'
, L_259_, L_259_, L_254_:get_name(), L_260_, L_259_, L_261_, L_259_, L_253_arg0.hitchance, L_259_, L_259_,
L_253_arg0.backtrack)
				local L_263_ = string.format(
"\a%s%s \aFFFFFFFFHit \a%s%s's \aFFFFFFFF%s (\a%s%d%%\aFFFFFFFF) for \a%s%s \aFFFFFFFFdmg"
, L_257_, ui.get_icon('crosshairs'), L_257_, L_254_:get_name(), L_260_, L_257_, L_253_arg0.hitchance,
L_257_, L_261_)
				if L_12_.screen_logs:get() then
					render.notify(L_263_, L_256_)
				end
				if L_12_.
logs:get('Event') then
					print_dev(L_262_)
				end
				if L_12_.logs:get('Console') then
					print_raw(L_262_)
				end
			else
				L_260_ = L_41_[L_253_arg0.wanted_hitgroup]
				L_261_ = L_253_arg0.damage
				local L_264_ = L_12_.screen_logs_miss:get()
				local L_265_ = color(L_264_.r, L_264_.g, L_264_.b, 255)
				local L_266_ = L_265_:to_hex()
				local L_267_ = L_12_.logs_miss:get()
				local L_268_ = '\a' .. color(
L_267_.r, L_267_.g, L_267_.b, 255):to_hex()
				local L_269_ = string.format(
'%s[renaissance]\aFFFFFFFF Missed shot at %s%s\aFFFFFFFF %s(%d%%) due to%s %s \aFFFFFFFFdmg:%s %d \aFFFFFFFFsafety: %s1\aFFFFFFFF history(\206\148):%s%d\aFFFFFFFF)'
, L_268_, L_268_, L_254_:get_name(), L_260_, L_253_arg0.hitchance, L_268_, L_253_arg0.state, L_268_, L_253_arg0.
wanted_damage, L_268_, L_268_, L_253_arg0.backtrack)
				local L_270_ = string.format(
"\a%s%s \aFFFFFFFFMissed \a%s%s's \aFFFFFFFF%s (\a%s%d%%\aFFFFFFFF) due to \a%s%s"
, L_266_, ui.get_icon('location-crosshairs'), L_266_, L_254_:get_name(), L_260_, L_266_, L_253_arg0.
hitchance, L_266_, L_253_arg0.state)
				if L_12_.screen_logs:get() then
					render.notify(L_270_, L_265_)
				end
				if L_12_.logs:get('Event') then
					print_dev(L_269_)
				end
				if L_12_.logs:get('Console')
then
					print_raw(L_269_)
				end
			end
			return
		end
	end
end)
events.createmove_run:set(
function(L_271_arg0)
	if not L_6_ then
		return
	else
		if L_12_.fd_settings:get() then
			if L_12_.
fd_settings_list:get(1) then
				L_28_.fast_fd(L_271_arg0)
			end
			if L_12_.fd_settings_list:get(2)
then
				L_28_.freeze_fd_run()
			end
		end
		return
	end
end)
events.createmove:set(function(
L_272_arg0)
	if not L_6_ then
		return
	elseif not entity.get_local_player() then
		return
	else
		if L_12_.fake_ping:get() then
			ui.find('Miscellaneous', 'Main', 'Other', 'Fake Latency'
):override(L_12_.fake_ping_value:get())
		else
			ui.find('Miscellaneous', 'Main', 'Other'
, 'Fake Latency'):override()
		end
		L_21_func(L_272_arg0)
		if L_12_.avoid_collision:get() then
			L_28_.
avoid_collision(L_272_arg0)
		end
		if L_12_.nade_fix:get() then
			L_28_.hegrenade_fix(L_272_arg0)
		else
			ui.find('Miscellaneous', 'Main', 'Other', 'Weapon Actions'):override()
		end
		if L_12_.
main_func:get(3) then
			L_28_.no_fall_damage(L_272_arg0)
		end
		if L_12_.main_func:get(2) then
			L_28_
.fastladder(L_272_arg0)
		end
		if L_12_.dormant_aimbot:get() then
			L_28_.dormantaimbot(L_272_arg0)
		end
		if L_12_.main_func:get(1) then
			L_28_.super_toss(L_272_arg0)
		end
		if L_12_.fd_settings:get() and
L_12_.fd_settings_list:get(2) then
			L_28_.freeze_fd()
		end
		if L_12_.lc_teleport:get() then
			L_28_.lc_teleport(L_272_arg0)
		end
		L_28_.auto_hs(L_272_arg0)
		return
	end
end)
events.render:set(
function()
	local L_273_ = L_4_.text_animate('renaissance ~ 1.1', -1, {
		color(220
),
		color(190),
		color(160)
	})
	if ui.get_alpha() > 0 then
		L_273_:animate()
		ui.sidebar(L_273_:
get_animated_text(), ui.get_icon('bug'))
	end
	if not L_6_ then
		return
	else
		L_28_.
screen_notify()
		if L_12_.min_damage:get() then
			L_28_.dmg_ind()
		end
		L_28_.watermark()
		if
L_12_.custom_scope:get() then
			ui.find('Visuals', 'World', 'Main', 'Override Zoom',
'Scope Overlay'):override('Remove All')
			L_28_.customscope()
		else
			ui.find('Visuals',
'World', 'Main', 'Override Zoom', 'Scope Overlay'):override()
		end
		if L_12_.custom_hud:
get() then
			L_28_.custom_hud()
		end
		return
	end
end)
events.round_start:set(function()
	L_37_ = {}
end)
events.level_init:set(function()
	L_37_ = {}
end)
local L_42_ = L_1_.setup({
	[1] = L_11_,
	[2] = L_12_,
	[3] = L_13_,
	[4] = L_14_
}, true)
local L_43_ = {}
local L_44_ = {}
local L_45_ = db.
renaissance_cfg1 or {}
L_45_.config_list = L_45_.config_list or {
	[1] = {
		[1] = 'Default',
		[2]
=
[[W3siYWFfb3ZlcnJpZGUiOlsifiJdLCJhbmltX2JyZWFrIjp0cnVlLCJhbmltX2JyZWFrX2FpciI6IlN0YXRpYyIsImFuaW1fYnJlYWtfZ3JvdW5kIjoiQmV0dGVyIEppdHRlciIsImFuaW1fYnJlYWtfZ3JvdW5kX2Ftb3VudCI6MTAuMCwiYW5pbV9icmVha19sZWFuIjoxMC4wLCJhbmltX2JyZWFrX290aGVyIjpbIk1vdmUgTGVhbiIsIn4iXSwiYXZvaWRfYmFja3N0YWIiOjIuMCwiY29uZGl0aW9uIjoiQWlyK0MiLCJmcmVlc3RhbmRpbmciOmZhbHNlLCJmcmVlc3RhbmRpbmdfZmxpY2siOmZhbHNlLCJmcmVlc3RhbmRpbmdfZmxpY2tfb2Zmc2V0IjowLjAsImZyZWVzdGFuZGluZ19zdGF0aWMiOnRydWUsInBpdGNoIjoiRG93biIsInNhZmVfaGVhZCI6WyJBaXIrQyBLbmlmZSIsIn4iXSwic2lkZSI6MS4wLCJ5YXdfYmFzZSI6IkF0IFRhcmdldCIsInlhd19iYXNlX2ZsaWNrIjpmYWxzZSwieWF3X2Jhc2VfZmxpY2tfb2Zmc2V0IjowLjAsInlhd19iYXNlX3N0YXRpYyI6ZmFsc2V9LHsiYXNwZWN0cmF0aW8iOnRydWUsImFzcGVjdHJhdGlvX3ZhbHVlIjoxMzMuMCwiYXV0b19oaWRlc2hvdHMiOnRydWUsImF2b2lkX2NvbGxpc2lvbiI6dHJ1ZSwiY3VzdG9tX2h1ZCI6dHJ1ZSwiY3VzdG9tX2h1ZF9jb2xvciI6IiM2NDY0NjQ5NiIsImN1c3RvbV9odWRfdGV4dF9jb2xvciI6IiM5OTk5OTlGRiIsImN1c3RvbV9zY29wZSI6dHJ1ZSwiY3VzdG9tX3Njb3BlX2NvbG9yIjoiI0M4QzhDOEM4IiwiY3VzdG9tX3Njb3BlX2xlbmd0aCI6MTg4LjAsImN1c3RvbV9zY29wZV9vZmZzZXQiOjMuMCwiZG9ybWFudF9haW1ib3QiOmZhbHNlLCJmYWtlX3BpbmciOmZhbHNlLCJmYWtlX3BpbmdfdmFsdWUiOjAuMCwiZmRfc2V0dGluZ3MiOmZhbHNlLCJmZF9zZXR0aW5nc19saXN0IjpbIn4iXSwibGNfdGVsZXBvcnQiOmZhbHNlLCJsb2dzIjpbIkNvbnNvbGUiLCJ+Il0sImxvZ3NfaGl0IjoiI0M5QzdGRkZGIiwibG9nc19taXNzIjoiIzZBNkE2QUZGIiwibWFpbl9mdW5jIjpbMS4wLDIuMCwifiJdLCJtaW5fZGFtYWdlIjp0cnVlLCJtaW5fZGFtYWdlX2NvbG9yIjoiI0ExQTFBMUZGIiwibWluX2RhbWFnZV9mb250IjoyLjAsIm5hZGVfZml4Ijp0cnVlLCJzY3JlZW5fbG9ncyI6dHJ1ZSwic2NyZWVuX2xvZ3NfaGl0IjoiIzZDODFDQkZGIiwic2NyZWVuX2xvZ3NfbWlzcyI6IiM2QTZBNkFGRiIsInZpZXdtb2RlbCI6dHJ1ZSwidmlld21vZGVsX2ZvdiI6NzkuMCwidmlld21vZGVsX3giOi03LjAsInZpZXdtb2RlbF95IjotMjUuMCwidmlld21vZGVsX3oiOjEwLjAsIndhdGVybWFyayI6IkRlZmF1bHQifSxbeyJib2R5X3lhdyI6dHJ1ZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjotOTAuMCwiZGVmX3lhd19zcGVlZCI6MjAuMCwiZGVmX3lhd19zcGluIjowLjAsImRlZmVuc2l2ZV9mbGljayI6IkwmUiIsImRlZmVuc2l2ZV9mbGlja19sIjozNS4wLCJkZWZlbnNpdmVfZmxpY2tfb2Zmc2V0IjotOTAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOi0zNS4wLCJkZWZlbnNpdmVfZmxpY2tfcmFuZG9tIjoxMC4wLCJkZWZlbnNpdmVfcGl0Y2giOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV95YXciOiJEaXNhYmxlZCIsImVuYWJsZSI6ZmFsc2UsImZvcmNlX2RlZmVuc2l2ZSI6WyJEVCIsIkhpZGUgU2hvdHMiLCJ+Il0sImZyZWVzdGFuZCI6Ik9mZiIsImludmVydCI6ZmFsc2UsImxieV9sIjo2MC4wLCJsYnlfciI6NjAuMCwibGJ5X3JhbmRvbSI6MjAuMCwibW9kX29mZnNldCI6LTE0LjAsIm1vZF9yYW5kb20iOjEwLjAsIm1vZF90eXBlIjoiQ2VudGVyIiwib3B0aW9ucyI6WyJKaXR0ZXIiLCJ+Il0sInlhdyI6MC4wLCJ5YXdfZGVsYXkiOjQuMCwieWF3X2RlbGF5X3JhbmQiOjAuMCwieWF3X2xlZnQiOjMuMCwieWF3X3JhbmRvbSI6MC4wLCJ5YXdfcmlnaHQiOjIxLjAsInlhd190eXBlIjoxLjB9LHsiYm9keV95YXciOmZhbHNlLCJkZWZfcGl0Y2hfb2Zmc2V0IjowLjAsImRlZl9waXRjaF9zcGVlZCI6MjAuMCwiZGVmX3BpdGNoX3NwaW4iOjAuMCwiZGVmX3lhd19vZmZzZXQiOjAuMCwiZGVmX3lhd19zcGVlZCI6MjAuMCwiZGVmX3lhd19zcGluIjowLjAsImRlZmVuc2l2ZV9mbGljayI6IkRpc2FibGVkIiwiZGVmZW5zaXZlX2ZsaWNrX2wiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX29mZnNldCI6MC4wLCJkZWZlbnNpdmVfZmxpY2tfciI6MC4wLCJkZWZlbnNpdmVfZmxpY2tfcmFuZG9tIjowLjAsImRlZmVuc2l2ZV9waXRjaCI6IkRpc2FibGVkIiwiZGVmZW5zaXZlX3lhdyI6IkRpc2FibGVkIiwiZW5hYmxlIjpmYWxzZSwiZm9yY2VfZGVmZW5zaXZlIjpbIn4iXSwiZnJlZXN0YW5kIjoiT2ZmIiwiaW52ZXJ0IjpmYWxzZSwibGJ5X2wiOjYwLjAsImxieV9yIjo2MC4wLCJsYnlfcmFuZG9tIjowLjAsIm1vZF9vZmZzZXQiOjAuMCwibW9kX3JhbmRvbSI6MC4wLCJtb2RfdHlwZSI6IkRpc2FibGVkIiwib3B0aW9ucyI6WyJ+Il0sInlhdyI6MC4wLCJ5YXdfZGVsYXkiOjQuMCwieWF3X2RlbGF5X3JhbmQiOjAuMCwieWF3X2xlZnQiOjAuMCwieWF3X3JhbmRvbSI6MC4wLCJ5YXdfcmlnaHQiOjAuMCwieWF3X3R5cGUiOjEuMH0seyJib2R5X3lhdyI6dHJ1ZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjowLjAsImRlZl95YXdfc3BlZWQiOjIwLjAsImRlZl95YXdfc3BpbiI6MC4wLCJkZWZlbnNpdmVfZmxpY2siOiJMJlIiLCJkZWZlbnNpdmVfZmxpY2tfbCI6MTAuMCwiZGVmZW5zaXZlX2ZsaWNrX29mZnNldCI6MC4wLCJkZWZlbnNpdmVfZmxpY2tfciI6LTEwLjAsImRlZmVuc2l2ZV9mbGlja19yYW5kb20iOjEwLjAsImRlZmVuc2l2ZV9waXRjaCI6IkRpc2FibGVkIiwiZGVmZW5zaXZlX3lhdyI6IkRpc2FibGVkIiwiZW5hYmxlIjp0cnVlLCJmb3JjZV9kZWZlbnNpdmUiOlsifiJdLCJmcmVlc3RhbmQiOiJPZmYiLCJpbnZlcnQiOmZhbHNlLCJsYnlfbCI6NjAuMCwibGJ5X3IiOjYwLjAsImxieV9yYW5kb20iOjAuMCwibW9kX29mZnNldCI6LTY2LjAsIm1vZF9yYW5kb20iOjAuMCwibW9kX3R5cGUiOiJDZW50ZXIiLCJvcHRpb25zIjpbIkppdHRlciIsIn4iXSwieWF3IjozLjAsInlhd19kZWxheSI6NC4wLCJ5YXdfZGVsYXlfcmFuZCI6MC4wLCJ5YXdfbGVmdCI6MC4wLCJ5YXdfcmFuZG9tIjowLjAsInlhd19yaWdodCI6MC4wLCJ5YXdfdHlwZSI6MS4wfSx7ImJvZHlfeWF3IjpmYWxzZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjowLjAsImRlZl95YXdfc3BlZWQiOjIwLjAsImRlZl95YXdfc3BpbiI6MC4wLCJkZWZlbnNpdmVfZmxpY2siOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV9mbGlja19sIjowLjAsImRlZmVuc2l2ZV9mbGlja19vZmZzZXQiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3JhbmRvbSI6MC4wLCJkZWZlbnNpdmVfcGl0Y2giOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV95YXciOiJEaXNhYmxlZCIsImVuYWJsZSI6ZmFsc2UsImZvcmNlX2RlZmVuc2l2ZSI6WyJ+Il0sImZyZWVzdGFuZCI6Ik9mZiIsImludmVydCI6ZmFsc2UsImxieV9sIjo2MC4wLCJsYnlfciI6NjAuMCwibGJ5X3JhbmRvbSI6MC4wLCJtb2Rfb2Zmc2V0IjowLjAsIm1vZF9yYW5kb20iOjAuMCwibW9kX3R5cGUiOiJEaXNhYmxlZCIsIm9wdGlvbnMiOlsifiJdLCJ5YXciOjAuMCwieWF3X2RlbGF5Ijo0LjAsInlhd19kZWxheV9yYW5kIjowLjAsInlhd19sZWZ0IjowLjAsInlhd19yYW5kb20iOjAuMCwieWF3X3JpZ2h0IjowLjAsInlhd190eXBlIjoxLjB9LHsiYm9keV95YXciOnRydWUsImRlZl9waXRjaF9vZmZzZXQiOjAuMCwiZGVmX3BpdGNoX3NwZWVkIjoyMC4wLCJkZWZfcGl0Y2hfc3BpbiI6MC4wLCJkZWZfeWF3X29mZnNldCI6MC4wLCJkZWZfeWF3X3NwZWVkIjoyMC4wLCJkZWZfeWF3X3NwaW4iOjAuMCwiZGVmZW5zaXZlX2ZsaWNrIjoiTCZSIiwiZGVmZW5zaXZlX2ZsaWNrX2wiOjIyLjAsImRlZmVuc2l2ZV9mbGlja19vZmZzZXQiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOi0yMC4wLCJkZWZlbnNpdmVfZmxpY2tfcmFuZG9tIjo3LjAsImRlZmVuc2l2ZV9waXRjaCI6IkRpc2FibGVkIiwiZGVmZW5zaXZlX3lhdyI6IkRpc2FibGVkIiwiZW5hYmxlIjp0cnVlLCJmb3JjZV9kZWZlbnNpdmUiOlsiRFQiLCJIaWRlIFNob3RzIiwifiJdLCJmcmVlc3RhbmQiOiJPZmYiLCJpbnZlcnQiOmZhbHNlLCJsYnlfbCI6NjAuMCwibGJ5X3IiOjYwLjAsImxieV9yYW5kb20iOjAuMCwibW9kX29mZnNldCI6LTM4LjAsIm1vZF9yYW5kb20iOjguMCwibW9kX3R5cGUiOiJDZW50ZXIiLCJvcHRpb25zIjpbIkppdHRlciIsIn4iXSwieWF3Ijo2LjAsInlhd19kZWxheSI6NC4wLCJ5YXdfZGVsYXlfcmFuZCI6MC4wLCJ5YXdfbGVmdCI6MC4wLCJ5YXdfcmFuZG9tIjowLjAsInlhd19yaWdodCI6MC4wLCJ5YXdfdHlwZSI6MS4wfSx7ImJvZHlfeWF3Ijp0cnVlLCJkZWZfcGl0Y2hfb2Zmc2V0IjowLjAsImRlZl9waXRjaF9zcGVlZCI6MjAuMCwiZGVmX3BpdGNoX3NwaW4iOjAuMCwiZGVmX3lhd19vZmZzZXQiOjAuMCwiZGVmX3lhd19zcGVlZCI6MjAuMCwiZGVmX3lhd19zcGluIjowLjAsImRlZmVuc2l2ZV9mbGljayI6IkwmUiIsImRlZmVuc2l2ZV9mbGlja19sIjoxNS4wLCJkZWZlbnNpdmVfZmxpY2tfb2Zmc2V0IjowLjAsImRlZmVuc2l2ZV9mbGlja19yIjotMTUuMCwiZGVmZW5zaXZlX2ZsaWNrX3JhbmRvbSI6OC4wLCJkZWZlbnNpdmVfcGl0Y2giOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV95YXciOiJEaXNhYmxlZCIsImVuYWJsZSI6dHJ1ZSwiZm9yY2VfZGVmZW5zaXZlIjpbIkRUIiwiSGlkZSBTaG90cyIsIn4iXSwiZnJlZXN0YW5kIjoiT2ZmIiwiaW52ZXJ0IjpmYWxzZSwibGJ5X2wiOjYwLjAsImxieV9yIjo2MC4wLCJsYnlfcmFuZG9tIjowLjAsIm1vZF9vZmZzZXQiOi0zMy4wLCJtb2RfcmFuZG9tIjowLjAsIm1vZF90eXBlIjoiQ2VudGVyIiwib3B0aW9ucyI6WyJKaXR0ZXIiLCJ+Il0sInlhdyI6NS4wLCJ5YXdfZGVsYXkiOjQuMCwieWF3X2RlbGF5X3JhbmQiOjAuMCwieWF3X2xlZnQiOjAuMCwieWF3X3JhbmRvbSI6MC4wLCJ5YXdfcmlnaHQiOjAuMCwieWF3X3R5cGUiOjEuMH0seyJib2R5X3lhdyI6dHJ1ZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjowLjAsImRlZl95YXdfc3BlZWQiOjIwLjAsImRlZl95YXdfc3BpbiI6MC4wLCJkZWZlbnNpdmVfZmxpY2siOiJMJlIiLCJkZWZlbnNpdmVfZmxpY2tfbCI6LTIyLjAsImRlZmVuc2l2ZV9mbGlja19vZmZzZXQiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOjIyLjAsImRlZmVuc2l2ZV9mbGlja19yYW5kb20iOjcuMCwiZGVmZW5zaXZlX3BpdGNoIjoiRGlzYWJsZWQiLCJkZWZlbnNpdmVfeWF3IjoiRGlzYWJsZWQiLCJlbmFibGUiOnRydWUsImZvcmNlX2RlZmVuc2l2ZSI6WyJEVCIsIkhpZGUgU2hvdHMiLCJ+Il0sImZyZWVzdGFuZCI6Ik9mZiIsImludmVydCI6ZmFsc2UsImxieV9sIjo2MC4wLCJsYnlfciI6NjAuMCwibGJ5X3JhbmRvbSI6MC4wLCJtb2Rfb2Zmc2V0IjotNS4wLCJtb2RfcmFuZG9tIjoxOS4wLCJtb2RfdHlwZSI6IkNlbnRlciIsIm9wdGlvbnMiOlsiSml0dGVyIiwifiJdLCJ5YXciOjAuMCwieWF3X2RlbGF5Ijo0LjAsInlhd19kZWxheV9yYW5kIjoxLjAsInlhd19sZWZ0IjotNS4wLCJ5YXdfcmFuZG9tIjowLjAsInlhd19yaWdodCI6MTUuMCwieWF3X3R5cGUiOjEuMH0seyJib2R5X3lhdyI6dHJ1ZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjowLjAsImRlZl95YXdfc3BlZWQiOjIwLjAsImRlZl95YXdfc3BpbiI6MC4wLCJkZWZlbnNpdmVfZmxpY2siOiJMJlIiLCJkZWZlbnNpdmVfZmxpY2tfbCI6LTIyLjAsImRlZmVuc2l2ZV9mbGlja19vZmZzZXQiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOjI3LjAsImRlZmVuc2l2ZV9mbGlja19yYW5kb20iOjguMCwiZGVmZW5zaXZlX3BpdGNoIjoiRGlzYWJsZWQiLCJkZWZlbnNpdmVfeWF3IjoiRGlzYWJsZWQiLCJlbmFibGUiOnRydWUsImZvcmNlX2RlZmVuc2l2ZSI6WyJEVCIsIkhpZGUgU2hvdHMiLCJ+Il0sImZyZWVzdGFuZCI6Ik9mZiIsImludmVydCI6ZmFsc2UsImxieV9sIjo2MC4wLCJsYnlfciI6NjAuMCwibGJ5X3JhbmRvbSI6MTAuMCwibW9kX29mZnNldCI6MC4wLCJtb2RfcmFuZG9tIjowLjAsIm1vZF90eXBlIjoiQ2VudGVyIiwib3B0aW9ucyI6WyJKaXR0ZXIiLCJ+Il0sInlhdyI6MjQuMCwieWF3X2RlbGF5Ijo1LjAsInlhd19kZWxheV9yYW5kIjowLjAsInlhd19sZWZ0IjoxOC4wLCJ5YXdfcmFuZG9tIjowLjAsInlhd19yaWdodCI6My4wLCJ5YXdfdHlwZSI6Mi4wfSx7ImJvZHlfeWF3IjpmYWxzZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjowLjAsImRlZl95YXdfc3BlZWQiOjIwLjAsImRlZl95YXdfc3BpbiI6MC4wLCJkZWZlbnNpdmVfZmxpY2siOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV9mbGlja19sIjowLjAsImRlZmVuc2l2ZV9mbGlja19vZmZzZXQiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3JhbmRvbSI6MC4wLCJkZWZlbnNpdmVfcGl0Y2giOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV95YXciOiJEaXNhYmxlZCIsImVuYWJsZSI6ZmFsc2UsImZvcmNlX2RlZmVuc2l2ZSI6WyJ+Il0sImZyZWVzdGFuZCI6Ik9mZiIsImludmVydCI6ZmFsc2UsImxieV9sIjo2MC4wLCJsYnlfciI6NjAuMCwibGJ5X3JhbmRvbSI6MC4wLCJtb2Rfb2Zmc2V0IjowLjAsIm1vZF9yYW5kb20iOjAuMCwibW9kX3R5cGUiOiJEaXNhYmxlZCIsIm9wdGlvbnMiOlsifiJdLCJ5YXciOjAuMCwieWF3X2RlbGF5Ijo0LjAsInlhd19kZWxheV9yYW5kIjowLjAsInlhd19sZWZ0IjowLjAsInlhd19yYW5kb20iOjAuMCwieWF3X3JpZ2h0IjowLjAsInlhd190eXBlIjoxLjB9XSxbeyJib2R5X3lhdyI6dHJ1ZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjotOTAuMCwiZGVmX3lhd19zcGVlZCI6MjAuMCwiZGVmX3lhd19zcGluIjowLjAsImRlZmVuc2l2ZV9mbGljayI6IkwmUiIsImRlZmVuc2l2ZV9mbGlja19sIjozNS4wLCJkZWZlbnNpdmVfZmxpY2tfb2Zmc2V0IjotOTAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOi0zNS4wLCJkZWZlbnNpdmVfZmxpY2tfcmFuZG9tIjoxMC4wLCJkZWZlbnNpdmVfcGl0Y2giOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV95YXciOiJEaXNhYmxlZCIsImVuYWJsZSI6ZmFsc2UsImZvcmNlX2RlZmVuc2l2ZSI6WyJEVCIsIkhpZGUgU2hvdHMiLCJ+Il0sImZyZWVzdGFuZCI6Ik9mZiIsImludmVydCI6ZmFsc2UsImxieV9sIjo2MC4wLCJsYnlfciI6NjAuMCwibGJ5X3JhbmRvbSI6MjAuMCwibW9kX29mZnNldCI6LTE0LjAsIm1vZF9yYW5kb20iOjEwLjAsIm1vZF90eXBlIjoiQ2VudGVyIiwib3B0aW9ucyI6WyJKaXR0ZXIiLCJ+Il0sInlhdyI6MC4wLCJ5YXdfZGVsYXkiOjQuMCwieWF3X2RlbGF5X3JhbmQiOjAuMCwieWF3X2xlZnQiOjMuMCwieWF3X3JhbmRvbSI6MC4wLCJ5YXdfcmlnaHQiOjIxLjAsInlhd190eXBlIjoxLjB9LHsiYm9keV95YXciOmZhbHNlLCJkZWZfcGl0Y2hfb2Zmc2V0IjowLjAsImRlZl9waXRjaF9zcGVlZCI6MjAuMCwiZGVmX3BpdGNoX3NwaW4iOjAuMCwiZGVmX3lhd19vZmZzZXQiOjAuMCwiZGVmX3lhd19zcGVlZCI6MjAuMCwiZGVmX3lhd19zcGluIjowLjAsImRlZmVuc2l2ZV9mbGljayI6IkRpc2FibGVkIiwiZGVmZW5zaXZlX2ZsaWNrX2wiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX29mZnNldCI6MC4wLCJkZWZlbnNpdmVfZmxpY2tfciI6MC4wLCJkZWZlbnNpdmVfZmxpY2tfcmFuZG9tIjowLjAsImRlZmVuc2l2ZV9waXRjaCI6IkRpc2FibGVkIiwiZGVmZW5zaXZlX3lhdyI6IkRpc2FibGVkIiwiZW5hYmxlIjpmYWxzZSwiZm9yY2VfZGVmZW5zaXZlIjpbIn4iXSwiZnJlZXN0YW5kIjoiT2ZmIiwiaW52ZXJ0IjpmYWxzZSwibGJ5X2wiOjYwLjAsImxieV9yIjo2MC4wLCJsYnlfcmFuZG9tIjowLjAsIm1vZF9vZmZzZXQiOjAuMCwibW9kX3JhbmRvbSI6MC4wLCJtb2RfdHlwZSI6IkRpc2FibGVkIiwib3B0aW9ucyI6WyJ+Il0sInlhdyI6MC4wLCJ5YXdfZGVsYXkiOjQuMCwieWF3X2RlbGF5X3JhbmQiOjAuMCwieWF3X2xlZnQiOjAuMCwieWF3X3JhbmRvbSI6MC4wLCJ5YXdfcmlnaHQiOjAuMCwieWF3X3R5cGUiOjEuMH0seyJib2R5X3lhdyI6dHJ1ZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjowLjAsImRlZl95YXdfc3BlZWQiOjIwLjAsImRlZl95YXdfc3BpbiI6MC4wLCJkZWZlbnNpdmVfZmxpY2siOiJMJlIiLCJkZWZlbnNpdmVfZmxpY2tfbCI6MTAuMCwiZGVmZW5zaXZlX2ZsaWNrX29mZnNldCI6MC4wLCJkZWZlbnNpdmVfZmxpY2tfciI6LTEwLjAsImRlZmVuc2l2ZV9mbGlja19yYW5kb20iOjEwLjAsImRlZmVuc2l2ZV9waXRjaCI6IkRpc2FibGVkIiwiZGVmZW5zaXZlX3lhdyI6IkRpc2FibGVkIiwiZW5hYmxlIjp0cnVlLCJmb3JjZV9kZWZlbnNpdmUiOlsifiJdLCJmcmVlc3RhbmQiOiJPZmYiLCJpbnZlcnQiOmZhbHNlLCJsYnlfbCI6NjAuMCwibGJ5X3IiOjYwLjAsImxieV9yYW5kb20iOjAuMCwibW9kX29mZnNldCI6LTY2LjAsIm1vZF9yYW5kb20iOjAuMCwibW9kX3R5cGUiOiJDZW50ZXIiLCJvcHRpb25zIjpbIkppdHRlciIsIn4iXSwieWF3IjozLjAsInlhd19kZWxheSI6NC4wLCJ5YXdfZGVsYXlfcmFuZCI6MC4wLCJ5YXdfbGVmdCI6MC4wLCJ5YXdfcmFuZG9tIjowLjAsInlhd19yaWdodCI6MC4wLCJ5YXdfdHlwZSI6MS4wfSx7ImJvZHlfeWF3IjpmYWxzZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjowLjAsImRlZl95YXdfc3BlZWQiOjIwLjAsImRlZl95YXdfc3BpbiI6MC4wLCJkZWZlbnNpdmVfZmxpY2siOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV9mbGlja19sIjowLjAsImRlZmVuc2l2ZV9mbGlja19vZmZzZXQiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3JhbmRvbSI6MC4wLCJkZWZlbnNpdmVfcGl0Y2giOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV95YXciOiJEaXNhYmxlZCIsImVuYWJsZSI6ZmFsc2UsImZvcmNlX2RlZmVuc2l2ZSI6WyJ+Il0sImZyZWVzdGFuZCI6Ik9mZiIsImludmVydCI6ZmFsc2UsImxieV9sIjo2MC4wLCJsYnlfciI6NjAuMCwibGJ5X3JhbmRvbSI6MC4wLCJtb2Rfb2Zmc2V0IjowLjAsIm1vZF9yYW5kb20iOjAuMCwibW9kX3R5cGUiOiJEaXNhYmxlZCIsIm9wdGlvbnMiOlsifiJdLCJ5YXciOjAuMCwieWF3X2RlbGF5Ijo0LjAsInlhd19kZWxheV9yYW5kIjowLjAsInlhd19sZWZ0IjowLjAsInlhd19yYW5kb20iOjAuMCwieWF3X3JpZ2h0IjowLjAsInlhd190eXBlIjoxLjB9LHsiYm9keV95YXciOnRydWUsImRlZl9waXRjaF9vZmZzZXQiOjAuMCwiZGVmX3BpdGNoX3NwZWVkIjoyMC4wLCJkZWZfcGl0Y2hfc3BpbiI6MC4wLCJkZWZfeWF3X29mZnNldCI6MC4wLCJkZWZfeWF3X3NwZWVkIjoyMC4wLCJkZWZfeWF3X3NwaW4iOjAuMCwiZGVmZW5zaXZlX2ZsaWNrIjoiTCZSIiwiZGVmZW5zaXZlX2ZsaWNrX2wiOjIyLjAsImRlZmVuc2l2ZV9mbGlja19vZmZzZXQiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOi0yMC4wLCJkZWZlbnNpdmVfZmxpY2tfcmFuZG9tIjo3LjAsImRlZmVuc2l2ZV9waXRjaCI6IkRpc2FibGVkIiwiZGVmZW5zaXZlX3lhdyI6IkRpc2FibGVkIiwiZW5hYmxlIjp0cnVlLCJmb3JjZV9kZWZlbnNpdmUiOlsiRFQiLCJIaWRlIFNob3RzIiwifiJdLCJmcmVlc3RhbmQiOiJPZmYiLCJpbnZlcnQiOmZhbHNlLCJsYnlfbCI6NjAuMCwibGJ5X3IiOjYwLjAsImxieV9yYW5kb20iOjAuMCwibW9kX29mZnNldCI6LTM4LjAsIm1vZF9yYW5kb20iOjguMCwibW9kX3R5cGUiOiJDZW50ZXIiLCJvcHRpb25zIjpbIkppdHRlciIsIn4iXSwieWF3Ijo2LjAsInlhd19kZWxheSI6NC4wLCJ5YXdfZGVsYXlfcmFuZCI6MC4wLCJ5YXdfbGVmdCI6MC4wLCJ5YXdfcmFuZG9tIjowLjAsInlhd19yaWdodCI6MC4wLCJ5YXdfdHlwZSI6MS4wfSx7ImJvZHlfeWF3Ijp0cnVlLCJkZWZfcGl0Y2hfb2Zmc2V0IjowLjAsImRlZl9waXRjaF9zcGVlZCI6MjAuMCwiZGVmX3BpdGNoX3NwaW4iOjAuMCwiZGVmX3lhd19vZmZzZXQiOjAuMCwiZGVmX3lhd19zcGVlZCI6MjAuMCwiZGVmX3lhd19zcGluIjowLjAsImRlZmVuc2l2ZV9mbGljayI6IkwmUiIsImRlZmVuc2l2ZV9mbGlja19sIjoxNS4wLCJkZWZlbnNpdmVfZmxpY2tfb2Zmc2V0IjowLjAsImRlZmVuc2l2ZV9mbGlja19yIjotMTUuMCwiZGVmZW5zaXZlX2ZsaWNrX3JhbmRvbSI6OC4wLCJkZWZlbnNpdmVfcGl0Y2giOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV95YXciOiJEaXNhYmxlZCIsImVuYWJsZSI6dHJ1ZSwiZm9yY2VfZGVmZW5zaXZlIjpbIkRUIiwiSGlkZSBTaG90cyIsIn4iXSwiZnJlZXN0YW5kIjoiT2ZmIiwiaW52ZXJ0IjpmYWxzZSwibGJ5X2wiOjYwLjAsImxieV9yIjo2MC4wLCJsYnlfcmFuZG9tIjowLjAsIm1vZF9vZmZzZXQiOi0zMy4wLCJtb2RfcmFuZG9tIjowLjAsIm1vZF90eXBlIjoiQ2VudGVyIiwib3B0aW9ucyI6WyJKaXR0ZXIiLCJ+Il0sInlhdyI6NS4wLCJ5YXdfZGVsYXkiOjQuMCwieWF3X2RlbGF5X3JhbmQiOjAuMCwieWF3X2xlZnQiOjAuMCwieWF3X3JhbmRvbSI6MC4wLCJ5YXdfcmlnaHQiOjAuMCwieWF3X3R5cGUiOjEuMH0seyJib2R5X3lhdyI6dHJ1ZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjowLjAsImRlZl95YXdfc3BlZWQiOjIwLjAsImRlZl95YXdfc3BpbiI6MC4wLCJkZWZlbnNpdmVfZmxpY2siOiJMJlIiLCJkZWZlbnNpdmVfZmxpY2tfbCI6LTIyLjAsImRlZmVuc2l2ZV9mbGlja19vZmZzZXQiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOjIyLjAsImRlZmVuc2l2ZV9mbGlja19yYW5kb20iOjcuMCwiZGVmZW5zaXZlX3BpdGNoIjoiRGlzYWJsZWQiLCJkZWZlbnNpdmVfeWF3IjoiRGlzYWJsZWQiLCJlbmFibGUiOnRydWUsImZvcmNlX2RlZmVuc2l2ZSI6WyJEVCIsIkhpZGUgU2hvdHMiLCJ+Il0sImZyZWVzdGFuZCI6Ik9mZiIsImludmVydCI6ZmFsc2UsImxieV9sIjo2MC4wLCJsYnlfciI6NjAuMCwibGJ5X3JhbmRvbSI6MC4wLCJtb2Rfb2Zmc2V0IjotNS4wLCJtb2RfcmFuZG9tIjoxOS4wLCJtb2RfdHlwZSI6IkNlbnRlciIsIm9wdGlvbnMiOlsiSml0dGVyIiwifiJdLCJ5YXciOjAuMCwieWF3X2RlbGF5Ijo0LjAsInlhd19kZWxheV9yYW5kIjoxLjAsInlhd19sZWZ0IjotNS4wLCJ5YXdfcmFuZG9tIjowLjAsInlhd19yaWdodCI6MTUuMCwieWF3X3R5cGUiOjEuMH0seyJib2R5X3lhdyI6dHJ1ZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjowLjAsImRlZl95YXdfc3BlZWQiOjIwLjAsImRlZl95YXdfc3BpbiI6MC4wLCJkZWZlbnNpdmVfZmxpY2siOiJMJlIiLCJkZWZlbnNpdmVfZmxpY2tfbCI6LTIyLjAsImRlZmVuc2l2ZV9mbGlja19vZmZzZXQiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOjI3LjAsImRlZmVuc2l2ZV9mbGlja19yYW5kb20iOjguMCwiZGVmZW5zaXZlX3BpdGNoIjoiRGlzYWJsZWQiLCJkZWZlbnNpdmVfeWF3IjoiRGlzYWJsZWQiLCJlbmFibGUiOnRydWUsImZvcmNlX2RlZmVuc2l2ZSI6WyJEVCIsIkhpZGUgU2hvdHMiLCJ+Il0sImZyZWVzdGFuZCI6Ik9mZiIsImludmVydCI6ZmFsc2UsImxieV9sIjo2MC4wLCJsYnlfciI6NjAuMCwibGJ5X3JhbmRvbSI6MTAuMCwibW9kX29mZnNldCI6MC4wLCJtb2RfcmFuZG9tIjowLjAsIm1vZF90eXBlIjoiQ2VudGVyIiwib3B0aW9ucyI6WyJKaXR0ZXIiLCJ+Il0sInlhdyI6MjQuMCwieWF3X2RlbGF5Ijo1LjAsInlhd19kZWxheV9yYW5kIjowLjAsInlhd19sZWZ0IjoxOC4wLCJ5YXdfcmFuZG9tIjowLjAsInlhd19yaWdodCI6My4wLCJ5YXdfdHlwZSI6Mi4wfSx7ImJvZHlfeWF3IjpmYWxzZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjowLjAsImRlZl95YXdfc3BlZWQiOjIwLjAsImRlZl95YXdfc3BpbiI6MC4wLCJkZWZlbnNpdmVfZmxpY2siOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV9mbGlja19sIjowLjAsImRlZmVuc2l2ZV9mbGlja19vZmZzZXQiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3JhbmRvbSI6MC4wLCJkZWZlbnNpdmVfcGl0Y2giOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV95YXciOiJEaXNhYmxlZCIsImVuYWJsZSI6ZmFsc2UsImZvcmNlX2RlZmVuc2l2ZSI6WyJ+Il0sImZyZWVzdGFuZCI6Ik9mZiIsImludmVydCI6ZmFsc2UsImxieV9sIjo2MC4wLCJsYnlfciI6NjAuMCwibGJ5X3JhbmRvbSI6MC4wLCJtb2Rfb2Zmc2V0IjowLjAsIm1vZF9yYW5kb20iOjAuMCwibW9kX3R5cGUiOiJEaXNhYmxlZCIsIm9wdGlvbnMiOlsifiJdLCJ5YXciOjAuMCwieWF3X2RlbGF5Ijo0LjAsInlhd19kZWxheV9yYW5kIjowLjAsInlhd19sZWZ0IjowLjAsInlhd19yYW5kb20iOjAuMCwieWF3X3JpZ2h0IjowLjAsInlhd190eXBlIjoxLjB9XV0=]]
	}
}
L_45_.menu_list = L_45_.menu_list or {
	[1] = 'Default'
}
L_45_.config_list[1][2] =
[[W3siYWFfb3ZlcnJpZGUiOlsifiJdLCJhbmltX2JyZWFrIjp0cnVlLCJhbmltX2JyZWFrX2FpciI6IlN0YXRpYyIsImFuaW1fYnJlYWtfZ3JvdW5kIjoiQmV0dGVyIEppdHRlciIsImFuaW1fYnJlYWtfZ3JvdW5kX2Ftb3VudCI6MTAuMCwiYW5pbV9icmVha19sZWFuIjoxMC4wLCJhbmltX2JyZWFrX290aGVyIjpbIk1vdmUgTGVhbiIsIn4iXSwiYXZvaWRfYmFja3N0YWIiOjIuMCwiY29uZGl0aW9uIjoiQWlyK0MiLCJmcmVlc3RhbmRpbmciOmZhbHNlLCJmcmVlc3RhbmRpbmdfZmxpY2siOmZhbHNlLCJmcmVlc3RhbmRpbmdfZmxpY2tfb2Zmc2V0IjowLjAsImZyZWVzdGFuZGluZ19zdGF0aWMiOnRydWUsInBpdGNoIjoiRG93biIsInNhZmVfaGVhZCI6WyJBaXIrQyBLbmlmZSIsIn4iXSwic2lkZSI6MS4wLCJ5YXdfYmFzZSI6IkF0IFRhcmdldCIsInlhd19iYXNlX2ZsaWNrIjpmYWxzZSwieWF3X2Jhc2VfZmxpY2tfb2Zmc2V0IjowLjAsInlhd19iYXNlX3N0YXRpYyI6ZmFsc2V9LHsiYXNwZWN0cmF0aW8iOnRydWUsImFzcGVjdHJhdGlvX3ZhbHVlIjoxMzMuMCwiYXV0b19oaWRlc2hvdHMiOnRydWUsImF2b2lkX2NvbGxpc2lvbiI6dHJ1ZSwiY3VzdG9tX2h1ZCI6dHJ1ZSwiY3VzdG9tX2h1ZF9jb2xvciI6IiM2NDY0NjQ5NiIsImN1c3RvbV9odWRfdGV4dF9jb2xvciI6IiM5OTk5OTlGRiIsImN1c3RvbV9zY29wZSI6dHJ1ZSwiY3VzdG9tX3Njb3BlX2NvbG9yIjoiI0M4QzhDOEM4IiwiY3VzdG9tX3Njb3BlX2xlbmd0aCI6MTg4LjAsImN1c3RvbV9zY29wZV9vZmZzZXQiOjMuMCwiZG9ybWFudF9haW1ib3QiOmZhbHNlLCJmYWtlX3BpbmciOmZhbHNlLCJmYWtlX3BpbmdfdmFsdWUiOjAuMCwiZmRfc2V0dGluZ3MiOmZhbHNlLCJmZF9zZXR0aW5nc19saXN0IjpbIn4iXSwibGNfdGVsZXBvcnQiOmZhbHNlLCJsb2dzIjpbIkNvbnNvbGUiLCJ+Il0sImxvZ3NfaGl0IjoiI0M5QzdGRkZGIiwibG9nc19taXNzIjoiIzZBNkE2QUZGIiwibWFpbl9mdW5jIjpbMS4wLDIuMCwifiJdLCJtaW5fZGFtYWdlIjp0cnVlLCJtaW5fZGFtYWdlX2NvbG9yIjoiI0ExQTFBMUZGIiwibWluX2RhbWFnZV9mb250IjoyLjAsIm5hZGVfZml4Ijp0cnVlLCJzY3JlZW5fbG9ncyI6dHJ1ZSwic2NyZWVuX2xvZ3NfaGl0IjoiIzZDODFDQkZGIiwic2NyZWVuX2xvZ3NfbWlzcyI6IiM2QTZBNkFGRiIsInZpZXdtb2RlbCI6dHJ1ZSwidmlld21vZGVsX2ZvdiI6NzkuMCwidmlld21vZGVsX3giOi03LjAsInZpZXdtb2RlbF95IjotMjUuMCwidmlld21vZGVsX3oiOjEwLjAsIndhdGVybWFyayI6IkRlZmF1bHQifSxbeyJib2R5X3lhdyI6dHJ1ZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjotOTAuMCwiZGVmX3lhd19zcGVlZCI6MjAuMCwiZGVmX3lhd19zcGluIjowLjAsImRlZmVuc2l2ZV9mbGljayI6IkwmUiIsImRlZmVuc2l2ZV9mbGlja19sIjozNS4wLCJkZWZlbnNpdmVfZmxpY2tfb2Zmc2V0IjotOTAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOi0zNS4wLCJkZWZlbnNpdmVfZmxpY2tfcmFuZG9tIjoxMC4wLCJkZWZlbnNpdmVfcGl0Y2giOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV95YXciOiJEaXNhYmxlZCIsImVuYWJsZSI6ZmFsc2UsImZvcmNlX2RlZmVuc2l2ZSI6WyJEVCIsIkhpZGUgU2hvdHMiLCJ+Il0sImZyZWVzdGFuZCI6Ik9mZiIsImludmVydCI6ZmFsc2UsImxieV9sIjo2MC4wLCJsYnlfciI6NjAuMCwibGJ5X3JhbmRvbSI6MjAuMCwibW9kX29mZnNldCI6LTE0LjAsIm1vZF9yYW5kb20iOjEwLjAsIm1vZF90eXBlIjoiQ2VudGVyIiwib3B0aW9ucyI6WyJKaXR0ZXIiLCJ+Il0sInlhdyI6MC4wLCJ5YXdfZGVsYXkiOjQuMCwieWF3X2RlbGF5X3JhbmQiOjAuMCwieWF3X2xlZnQiOjMuMCwieWF3X3JhbmRvbSI6MC4wLCJ5YXdfcmlnaHQiOjIxLjAsInlhd190eXBlIjoxLjB9LHsiYm9keV95YXciOmZhbHNlLCJkZWZfcGl0Y2hfb2Zmc2V0IjowLjAsImRlZl9waXRjaF9zcGVlZCI6MjAuMCwiZGVmX3BpdGNoX3NwaW4iOjAuMCwiZGVmX3lhd19vZmZzZXQiOjAuMCwiZGVmX3lhd19zcGVlZCI6MjAuMCwiZGVmX3lhd19zcGluIjowLjAsImRlZmVuc2l2ZV9mbGljayI6IkRpc2FibGVkIiwiZGVmZW5zaXZlX2ZsaWNrX2wiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX29mZnNldCI6MC4wLCJkZWZlbnNpdmVfZmxpY2tfciI6MC4wLCJkZWZlbnNpdmVfZmxpY2tfcmFuZG9tIjowLjAsImRlZmVuc2l2ZV9waXRjaCI6IkRpc2FibGVkIiwiZGVmZW5zaXZlX3lhdyI6IkRpc2FibGVkIiwiZW5hYmxlIjpmYWxzZSwiZm9yY2VfZGVmZW5zaXZlIjpbIn4iXSwiZnJlZXN0YW5kIjoiT2ZmIiwiaW52ZXJ0IjpmYWxzZSwibGJ5X2wiOjYwLjAsImxieV9yIjo2MC4wLCJsYnlfcmFuZG9tIjowLjAsIm1vZF9vZmZzZXQiOjAuMCwibW9kX3JhbmRvbSI6MC4wLCJtb2RfdHlwZSI6IkRpc2FibGVkIiwib3B0aW9ucyI6WyJ+Il0sInlhdyI6MC4wLCJ5YXdfZGVsYXkiOjQuMCwieWF3X2RlbGF5X3JhbmQiOjAuMCwieWF3X2xlZnQiOjAuMCwieWF3X3JhbmRvbSI6MC4wLCJ5YXdfcmlnaHQiOjAuMCwieWF3X3R5cGUiOjEuMH0seyJib2R5X3lhdyI6dHJ1ZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjowLjAsImRlZl95YXdfc3BlZWQiOjIwLjAsImRlZl95YXdfc3BpbiI6MC4wLCJkZWZlbnNpdmVfZmxpY2siOiJMJlIiLCJkZWZlbnNpdmVfZmxpY2tfbCI6MTAuMCwiZGVmZW5zaXZlX2ZsaWNrX29mZnNldCI6MC4wLCJkZWZlbnNpdmVfZmxpY2tfciI6LTEwLjAsImRlZmVuc2l2ZV9mbGlja19yYW5kb20iOjEwLjAsImRlZmVuc2l2ZV9waXRjaCI6IkRpc2FibGVkIiwiZGVmZW5zaXZlX3lhdyI6IkRpc2FibGVkIiwiZW5hYmxlIjp0cnVlLCJmb3JjZV9kZWZlbnNpdmUiOlsifiJdLCJmcmVlc3RhbmQiOiJPZmYiLCJpbnZlcnQiOmZhbHNlLCJsYnlfbCI6NjAuMCwibGJ5X3IiOjYwLjAsImxieV9yYW5kb20iOjAuMCwibW9kX29mZnNldCI6LTY2LjAsIm1vZF9yYW5kb20iOjAuMCwibW9kX3R5cGUiOiJDZW50ZXIiLCJvcHRpb25zIjpbIkppdHRlciIsIn4iXSwieWF3IjozLjAsInlhd19kZWxheSI6NC4wLCJ5YXdfZGVsYXlfcmFuZCI6MC4wLCJ5YXdfbGVmdCI6MC4wLCJ5YXdfcmFuZG9tIjowLjAsInlhd19yaWdodCI6MC4wLCJ5YXdfdHlwZSI6MS4wfSx7ImJvZHlfeWF3IjpmYWxzZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjowLjAsImRlZl95YXdfc3BlZWQiOjIwLjAsImRlZl95YXdfc3BpbiI6MC4wLCJkZWZlbnNpdmVfZmxpY2siOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV9mbGlja19sIjowLjAsImRlZmVuc2l2ZV9mbGlja19vZmZzZXQiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3JhbmRvbSI6MC4wLCJkZWZlbnNpdmVfcGl0Y2giOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV95YXciOiJEaXNhYmxlZCIsImVuYWJsZSI6ZmFsc2UsImZvcmNlX2RlZmVuc2l2ZSI6WyJ+Il0sImZyZWVzdGFuZCI6Ik9mZiIsImludmVydCI6ZmFsc2UsImxieV9sIjo2MC4wLCJsYnlfciI6NjAuMCwibGJ5X3JhbmRvbSI6MC4wLCJtb2Rfb2Zmc2V0IjowLjAsIm1vZF9yYW5kb20iOjAuMCwibW9kX3R5cGUiOiJEaXNhYmxlZCIsIm9wdGlvbnMiOlsifiJdLCJ5YXciOjAuMCwieWF3X2RlbGF5Ijo0LjAsInlhd19kZWxheV9yYW5kIjowLjAsInlhd19sZWZ0IjowLjAsInlhd19yYW5kb20iOjAuMCwieWF3X3JpZ2h0IjowLjAsInlhd190eXBlIjoxLjB9LHsiYm9keV95YXciOnRydWUsImRlZl9waXRjaF9vZmZzZXQiOjAuMCwiZGVmX3BpdGNoX3NwZWVkIjoyMC4wLCJkZWZfcGl0Y2hfc3BpbiI6MC4wLCJkZWZfeWF3X29mZnNldCI6MC4wLCJkZWZfeWF3X3NwZWVkIjoyMC4wLCJkZWZfeWF3X3NwaW4iOjAuMCwiZGVmZW5zaXZlX2ZsaWNrIjoiTCZSIiwiZGVmZW5zaXZlX2ZsaWNrX2wiOjIyLjAsImRlZmVuc2l2ZV9mbGlja19vZmZzZXQiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOi0yMC4wLCJkZWZlbnNpdmVfZmxpY2tfcmFuZG9tIjo3LjAsImRlZmVuc2l2ZV9waXRjaCI6IkRpc2FibGVkIiwiZGVmZW5zaXZlX3lhdyI6IkRpc2FibGVkIiwiZW5hYmxlIjp0cnVlLCJmb3JjZV9kZWZlbnNpdmUiOlsiRFQiLCJIaWRlIFNob3RzIiwifiJdLCJmcmVlc3RhbmQiOiJPZmYiLCJpbnZlcnQiOmZhbHNlLCJsYnlfbCI6NjAuMCwibGJ5X3IiOjYwLjAsImxieV9yYW5kb20iOjAuMCwibW9kX29mZnNldCI6LTM4LjAsIm1vZF9yYW5kb20iOjguMCwibW9kX3R5cGUiOiJDZW50ZXIiLCJvcHRpb25zIjpbIkppdHRlciIsIn4iXSwieWF3Ijo2LjAsInlhd19kZWxheSI6NC4wLCJ5YXdfZGVsYXlfcmFuZCI6MC4wLCJ5YXdfbGVmdCI6MC4wLCJ5YXdfcmFuZG9tIjowLjAsInlhd19yaWdodCI6MC4wLCJ5YXdfdHlwZSI6MS4wfSx7ImJvZHlfeWF3Ijp0cnVlLCJkZWZfcGl0Y2hfb2Zmc2V0IjowLjAsImRlZl9waXRjaF9zcGVlZCI6MjAuMCwiZGVmX3BpdGNoX3NwaW4iOjAuMCwiZGVmX3lhd19vZmZzZXQiOjAuMCwiZGVmX3lhd19zcGVlZCI6MjAuMCwiZGVmX3lhd19zcGluIjowLjAsImRlZmVuc2l2ZV9mbGljayI6IkwmUiIsImRlZmVuc2l2ZV9mbGlja19sIjoxNS4wLCJkZWZlbnNpdmVfZmxpY2tfb2Zmc2V0IjowLjAsImRlZmVuc2l2ZV9mbGlja19yIjotMTUuMCwiZGVmZW5zaXZlX2ZsaWNrX3JhbmRvbSI6OC4wLCJkZWZlbnNpdmVfcGl0Y2giOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV95YXciOiJEaXNhYmxlZCIsImVuYWJsZSI6dHJ1ZSwiZm9yY2VfZGVmZW5zaXZlIjpbIkRUIiwiSGlkZSBTaG90cyIsIn4iXSwiZnJlZXN0YW5kIjoiT2ZmIiwiaW52ZXJ0IjpmYWxzZSwibGJ5X2wiOjYwLjAsImxieV9yIjo2MC4wLCJsYnlfcmFuZG9tIjowLjAsIm1vZF9vZmZzZXQiOi0zMy4wLCJtb2RfcmFuZG9tIjowLjAsIm1vZF90eXBlIjoiQ2VudGVyIiwib3B0aW9ucyI6WyJKaXR0ZXIiLCJ+Il0sInlhdyI6NS4wLCJ5YXdfZGVsYXkiOjQuMCwieWF3X2RlbGF5X3JhbmQiOjAuMCwieWF3X2xlZnQiOjAuMCwieWF3X3JhbmRvbSI6MC4wLCJ5YXdfcmlnaHQiOjAuMCwieWF3X3R5cGUiOjEuMH0seyJib2R5X3lhdyI6dHJ1ZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjowLjAsImRlZl95YXdfc3BlZWQiOjIwLjAsImRlZl95YXdfc3BpbiI6MC4wLCJkZWZlbnNpdmVfZmxpY2siOiJMJlIiLCJkZWZlbnNpdmVfZmxpY2tfbCI6LTIyLjAsImRlZmVuc2l2ZV9mbGlja19vZmZzZXQiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOjIyLjAsImRlZmVuc2l2ZV9mbGlja19yYW5kb20iOjcuMCwiZGVmZW5zaXZlX3BpdGNoIjoiRGlzYWJsZWQiLCJkZWZlbnNpdmVfeWF3IjoiRGlzYWJsZWQiLCJlbmFibGUiOnRydWUsImZvcmNlX2RlZmVuc2l2ZSI6WyJEVCIsIkhpZGUgU2hvdHMiLCJ+Il0sImZyZWVzdGFuZCI6Ik9mZiIsImludmVydCI6ZmFsc2UsImxieV9sIjo2MC4wLCJsYnlfciI6NjAuMCwibGJ5X3JhbmRvbSI6MC4wLCJtb2Rfb2Zmc2V0IjotNS4wLCJtb2RfcmFuZG9tIjoxOS4wLCJtb2RfdHlwZSI6IkNlbnRlciIsIm9wdGlvbnMiOlsiSml0dGVyIiwifiJdLCJ5YXciOjAuMCwieWF3X2RlbGF5Ijo0LjAsInlhd19kZWxheV9yYW5kIjoxLjAsInlhd19sZWZ0IjotNS4wLCJ5YXdfcmFuZG9tIjowLjAsInlhd19yaWdodCI6MTUuMCwieWF3X3R5cGUiOjEuMH0seyJib2R5X3lhdyI6dHJ1ZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjowLjAsImRlZl95YXdfc3BlZWQiOjIwLjAsImRlZl95YXdfc3BpbiI6MC4wLCJkZWZlbnNpdmVfZmxpY2siOiJMJlIiLCJkZWZlbnNpdmVfZmxpY2tfbCI6LTIyLjAsImRlZmVuc2l2ZV9mbGlja19vZmZzZXQiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOjI3LjAsImRlZmVuc2l2ZV9mbGlja19yYW5kb20iOjguMCwiZGVmZW5zaXZlX3BpdGNoIjoiRGlzYWJsZWQiLCJkZWZlbnNpdmVfeWF3IjoiRGlzYWJsZWQiLCJlbmFibGUiOnRydWUsImZvcmNlX2RlZmVuc2l2ZSI6WyJEVCIsIkhpZGUgU2hvdHMiLCJ+Il0sImZyZWVzdGFuZCI6Ik9mZiIsImludmVydCI6ZmFsc2UsImxieV9sIjo2MC4wLCJsYnlfciI6NjAuMCwibGJ5X3JhbmRvbSI6MTAuMCwibW9kX29mZnNldCI6MC4wLCJtb2RfcmFuZG9tIjowLjAsIm1vZF90eXBlIjoiQ2VudGVyIiwib3B0aW9ucyI6WyJKaXR0ZXIiLCJ+Il0sInlhdyI6MjQuMCwieWF3X2RlbGF5Ijo1LjAsInlhd19kZWxheV9yYW5kIjowLjAsInlhd19sZWZ0IjoxOC4wLCJ5YXdfcmFuZG9tIjowLjAsInlhd19yaWdodCI6My4wLCJ5YXdfdHlwZSI6Mi4wfSx7ImJvZHlfeWF3IjpmYWxzZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjowLjAsImRlZl95YXdfc3BlZWQiOjIwLjAsImRlZl95YXdfc3BpbiI6MC4wLCJkZWZlbnNpdmVfZmxpY2siOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV9mbGlja19sIjowLjAsImRlZmVuc2l2ZV9mbGlja19vZmZzZXQiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3JhbmRvbSI6MC4wLCJkZWZlbnNpdmVfcGl0Y2giOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV95YXciOiJEaXNhYmxlZCIsImVuYWJsZSI6ZmFsc2UsImZvcmNlX2RlZmVuc2l2ZSI6WyJ+Il0sImZyZWVzdGFuZCI6Ik9mZiIsImludmVydCI6ZmFsc2UsImxieV9sIjo2MC4wLCJsYnlfciI6NjAuMCwibGJ5X3JhbmRvbSI6MC4wLCJtb2Rfb2Zmc2V0IjowLjAsIm1vZF9yYW5kb20iOjAuMCwibW9kX3R5cGUiOiJEaXNhYmxlZCIsIm9wdGlvbnMiOlsifiJdLCJ5YXciOjAuMCwieWF3X2RlbGF5Ijo0LjAsInlhd19kZWxheV9yYW5kIjowLjAsInlhd19sZWZ0IjowLjAsInlhd19yYW5kb20iOjAuMCwieWF3X3JpZ2h0IjowLjAsInlhd190eXBlIjoxLjB9XSxbeyJib2R5X3lhdyI6dHJ1ZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjotOTAuMCwiZGVmX3lhd19zcGVlZCI6MjAuMCwiZGVmX3lhd19zcGluIjowLjAsImRlZmVuc2l2ZV9mbGljayI6IkwmUiIsImRlZmVuc2l2ZV9mbGlja19sIjozNS4wLCJkZWZlbnNpdmVfZmxpY2tfb2Zmc2V0IjotOTAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOi0zNS4wLCJkZWZlbnNpdmVfZmxpY2tfcmFuZG9tIjoxMC4wLCJkZWZlbnNpdmVfcGl0Y2giOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV95YXciOiJEaXNhYmxlZCIsImVuYWJsZSI6ZmFsc2UsImZvcmNlX2RlZmVuc2l2ZSI6WyJEVCIsIkhpZGUgU2hvdHMiLCJ+Il0sImZyZWVzdGFuZCI6Ik9mZiIsImludmVydCI6ZmFsc2UsImxieV9sIjo2MC4wLCJsYnlfciI6NjAuMCwibGJ5X3JhbmRvbSI6MjAuMCwibW9kX29mZnNldCI6LTE0LjAsIm1vZF9yYW5kb20iOjEwLjAsIm1vZF90eXBlIjoiQ2VudGVyIiwib3B0aW9ucyI6WyJKaXR0ZXIiLCJ+Il0sInlhdyI6MC4wLCJ5YXdfZGVsYXkiOjQuMCwieWF3X2RlbGF5X3JhbmQiOjAuMCwieWF3X2xlZnQiOjMuMCwieWF3X3JhbmRvbSI6MC4wLCJ5YXdfcmlnaHQiOjIxLjAsInlhd190eXBlIjoxLjB9LHsiYm9keV95YXciOmZhbHNlLCJkZWZfcGl0Y2hfb2Zmc2V0IjowLjAsImRlZl9waXRjaF9zcGVlZCI6MjAuMCwiZGVmX3BpdGNoX3NwaW4iOjAuMCwiZGVmX3lhd19vZmZzZXQiOjAuMCwiZGVmX3lhd19zcGVlZCI6MjAuMCwiZGVmX3lhd19zcGluIjowLjAsImRlZmVuc2l2ZV9mbGljayI6IkRpc2FibGVkIiwiZGVmZW5zaXZlX2ZsaWNrX2wiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX29mZnNldCI6MC4wLCJkZWZlbnNpdmVfZmxpY2tfciI6MC4wLCJkZWZlbnNpdmVfZmxpY2tfcmFuZG9tIjowLjAsImRlZmVuc2l2ZV9waXRjaCI6IkRpc2FibGVkIiwiZGVmZW5zaXZlX3lhdyI6IkRpc2FibGVkIiwiZW5hYmxlIjpmYWxzZSwiZm9yY2VfZGVmZW5zaXZlIjpbIn4iXSwiZnJlZXN0YW5kIjoiT2ZmIiwiaW52ZXJ0IjpmYWxzZSwibGJ5X2wiOjYwLjAsImxieV9yIjo2MC4wLCJsYnlfcmFuZG9tIjowLjAsIm1vZF9vZmZzZXQiOjAuMCwibW9kX3JhbmRvbSI6MC4wLCJtb2RfdHlwZSI6IkRpc2FibGVkIiwib3B0aW9ucyI6WyJ+Il0sInlhdyI6MC4wLCJ5YXdfZGVsYXkiOjQuMCwieWF3X2RlbGF5X3JhbmQiOjAuMCwieWF3X2xlZnQiOjAuMCwieWF3X3JhbmRvbSI6MC4wLCJ5YXdfcmlnaHQiOjAuMCwieWF3X3R5cGUiOjEuMH0seyJib2R5X3lhdyI6dHJ1ZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjowLjAsImRlZl95YXdfc3BlZWQiOjIwLjAsImRlZl95YXdfc3BpbiI6MC4wLCJkZWZlbnNpdmVfZmxpY2siOiJMJlIiLCJkZWZlbnNpdmVfZmxpY2tfbCI6MTAuMCwiZGVmZW5zaXZlX2ZsaWNrX29mZnNldCI6MC4wLCJkZWZlbnNpdmVfZmxpY2tfciI6LTEwLjAsImRlZmVuc2l2ZV9mbGlja19yYW5kb20iOjEwLjAsImRlZmVuc2l2ZV9waXRjaCI6IkRpc2FibGVkIiwiZGVmZW5zaXZlX3lhdyI6IkRpc2FibGVkIiwiZW5hYmxlIjp0cnVlLCJmb3JjZV9kZWZlbnNpdmUiOlsifiJdLCJmcmVlc3RhbmQiOiJPZmYiLCJpbnZlcnQiOmZhbHNlLCJsYnlfbCI6NjAuMCwibGJ5X3IiOjYwLjAsImxieV9yYW5kb20iOjAuMCwibW9kX29mZnNldCI6LTY2LjAsIm1vZF9yYW5kb20iOjAuMCwibW9kX3R5cGUiOiJDZW50ZXIiLCJvcHRpb25zIjpbIkppdHRlciIsIn4iXSwieWF3IjozLjAsInlhd19kZWxheSI6NC4wLCJ5YXdfZGVsYXlfcmFuZCI6MC4wLCJ5YXdfbGVmdCI6MC4wLCJ5YXdfcmFuZG9tIjowLjAsInlhd19yaWdodCI6MC4wLCJ5YXdfdHlwZSI6MS4wfSx7ImJvZHlfeWF3IjpmYWxzZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjowLjAsImRlZl95YXdfc3BlZWQiOjIwLjAsImRlZl95YXdfc3BpbiI6MC4wLCJkZWZlbnNpdmVfZmxpY2siOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV9mbGlja19sIjowLjAsImRlZmVuc2l2ZV9mbGlja19vZmZzZXQiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3JhbmRvbSI6MC4wLCJkZWZlbnNpdmVfcGl0Y2giOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV95YXciOiJEaXNhYmxlZCIsImVuYWJsZSI6ZmFsc2UsImZvcmNlX2RlZmVuc2l2ZSI6WyJ+Il0sImZyZWVzdGFuZCI6Ik9mZiIsImludmVydCI6ZmFsc2UsImxieV9sIjo2MC4wLCJsYnlfciI6NjAuMCwibGJ5X3JhbmRvbSI6MC4wLCJtb2Rfb2Zmc2V0IjowLjAsIm1vZF9yYW5kb20iOjAuMCwibW9kX3R5cGUiOiJEaXNhYmxlZCIsIm9wdGlvbnMiOlsifiJdLCJ5YXciOjAuMCwieWF3X2RlbGF5Ijo0LjAsInlhd19kZWxheV9yYW5kIjowLjAsInlhd19sZWZ0IjowLjAsInlhd19yYW5kb20iOjAuMCwieWF3X3JpZ2h0IjowLjAsInlhd190eXBlIjoxLjB9LHsiYm9keV95YXciOnRydWUsImRlZl9waXRjaF9vZmZzZXQiOjAuMCwiZGVmX3BpdGNoX3NwZWVkIjoyMC4wLCJkZWZfcGl0Y2hfc3BpbiI6MC4wLCJkZWZfeWF3X29mZnNldCI6MC4wLCJkZWZfeWF3X3NwZWVkIjoyMC4wLCJkZWZfeWF3X3NwaW4iOjAuMCwiZGVmZW5zaXZlX2ZsaWNrIjoiTCZSIiwiZGVmZW5zaXZlX2ZsaWNrX2wiOjIyLjAsImRlZmVuc2l2ZV9mbGlja19vZmZzZXQiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOi0yMC4wLCJkZWZlbnNpdmVfZmxpY2tfcmFuZG9tIjo3LjAsImRlZmVuc2l2ZV9waXRjaCI6IkRpc2FibGVkIiwiZGVmZW5zaXZlX3lhdyI6IkRpc2FibGVkIiwiZW5hYmxlIjp0cnVlLCJmb3JjZV9kZWZlbnNpdmUiOlsiRFQiLCJIaWRlIFNob3RzIiwifiJdLCJmcmVlc3RhbmQiOiJPZmYiLCJpbnZlcnQiOmZhbHNlLCJsYnlfbCI6NjAuMCwibGJ5X3IiOjYwLjAsImxieV9yYW5kb20iOjAuMCwibW9kX29mZnNldCI6LTM4LjAsIm1vZF9yYW5kb20iOjguMCwibW9kX3R5cGUiOiJDZW50ZXIiLCJvcHRpb25zIjpbIkppdHRlciIsIn4iXSwieWF3Ijo2LjAsInlhd19kZWxheSI6NC4wLCJ5YXdfZGVsYXlfcmFuZCI6MC4wLCJ5YXdfbGVmdCI6MC4wLCJ5YXdfcmFuZG9tIjowLjAsInlhd19yaWdodCI6MC4wLCJ5YXdfdHlwZSI6MS4wfSx7ImJvZHlfeWF3Ijp0cnVlLCJkZWZfcGl0Y2hfb2Zmc2V0IjowLjAsImRlZl9waXRjaF9zcGVlZCI6MjAuMCwiZGVmX3BpdGNoX3NwaW4iOjAuMCwiZGVmX3lhd19vZmZzZXQiOjAuMCwiZGVmX3lhd19zcGVlZCI6MjAuMCwiZGVmX3lhd19zcGluIjowLjAsImRlZmVuc2l2ZV9mbGljayI6IkwmUiIsImRlZmVuc2l2ZV9mbGlja19sIjoxNS4wLCJkZWZlbnNpdmVfZmxpY2tfb2Zmc2V0IjowLjAsImRlZmVuc2l2ZV9mbGlja19yIjotMTUuMCwiZGVmZW5zaXZlX2ZsaWNrX3JhbmRvbSI6OC4wLCJkZWZlbnNpdmVfcGl0Y2giOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV95YXciOiJEaXNhYmxlZCIsImVuYWJsZSI6dHJ1ZSwiZm9yY2VfZGVmZW5zaXZlIjpbIkRUIiwiSGlkZSBTaG90cyIsIn4iXSwiZnJlZXN0YW5kIjoiT2ZmIiwiaW52ZXJ0IjpmYWxzZSwibGJ5X2wiOjYwLjAsImxieV9yIjo2MC4wLCJsYnlfcmFuZG9tIjowLjAsIm1vZF9vZmZzZXQiOi0zMy4wLCJtb2RfcmFuZG9tIjowLjAsIm1vZF90eXBlIjoiQ2VudGVyIiwib3B0aW9ucyI6WyJKaXR0ZXIiLCJ+Il0sInlhdyI6NS4wLCJ5YXdfZGVsYXkiOjQuMCwieWF3X2RlbGF5X3JhbmQiOjAuMCwieWF3X2xlZnQiOjAuMCwieWF3X3JhbmRvbSI6MC4wLCJ5YXdfcmlnaHQiOjAuMCwieWF3X3R5cGUiOjEuMH0seyJib2R5X3lhdyI6dHJ1ZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjowLjAsImRlZl95YXdfc3BlZWQiOjIwLjAsImRlZl95YXdfc3BpbiI6MC4wLCJkZWZlbnNpdmVfZmxpY2siOiJMJlIiLCJkZWZlbnNpdmVfZmxpY2tfbCI6LTIyLjAsImRlZmVuc2l2ZV9mbGlja19vZmZzZXQiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOjIyLjAsImRlZmVuc2l2ZV9mbGlja19yYW5kb20iOjcuMCwiZGVmZW5zaXZlX3BpdGNoIjoiRGlzYWJsZWQiLCJkZWZlbnNpdmVfeWF3IjoiRGlzYWJsZWQiLCJlbmFibGUiOnRydWUsImZvcmNlX2RlZmVuc2l2ZSI6WyJEVCIsIkhpZGUgU2hvdHMiLCJ+Il0sImZyZWVzdGFuZCI6Ik9mZiIsImludmVydCI6ZmFsc2UsImxieV9sIjo2MC4wLCJsYnlfciI6NjAuMCwibGJ5X3JhbmRvbSI6MC4wLCJtb2Rfb2Zmc2V0IjotNS4wLCJtb2RfcmFuZG9tIjoxOS4wLCJtb2RfdHlwZSI6IkNlbnRlciIsIm9wdGlvbnMiOlsiSml0dGVyIiwifiJdLCJ5YXciOjAuMCwieWF3X2RlbGF5Ijo0LjAsInlhd19kZWxheV9yYW5kIjoxLjAsInlhd19sZWZ0IjotNS4wLCJ5YXdfcmFuZG9tIjowLjAsInlhd19yaWdodCI6MTUuMCwieWF3X3R5cGUiOjEuMH0seyJib2R5X3lhdyI6dHJ1ZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjowLjAsImRlZl95YXdfc3BlZWQiOjIwLjAsImRlZl95YXdfc3BpbiI6MC4wLCJkZWZlbnNpdmVfZmxpY2siOiJMJlIiLCJkZWZlbnNpdmVfZmxpY2tfbCI6LTIyLjAsImRlZmVuc2l2ZV9mbGlja19vZmZzZXQiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOjI3LjAsImRlZmVuc2l2ZV9mbGlja19yYW5kb20iOjguMCwiZGVmZW5zaXZlX3BpdGNoIjoiRGlzYWJsZWQiLCJkZWZlbnNpdmVfeWF3IjoiRGlzYWJsZWQiLCJlbmFibGUiOnRydWUsImZvcmNlX2RlZmVuc2l2ZSI6WyJEVCIsIkhpZGUgU2hvdHMiLCJ+Il0sImZyZWVzdGFuZCI6Ik9mZiIsImludmVydCI6ZmFsc2UsImxieV9sIjo2MC4wLCJsYnlfciI6NjAuMCwibGJ5X3JhbmRvbSI6MTAuMCwibW9kX29mZnNldCI6MC4wLCJtb2RfcmFuZG9tIjowLjAsIm1vZF90eXBlIjoiQ2VudGVyIiwib3B0aW9ucyI6WyJKaXR0ZXIiLCJ+Il0sInlhdyI6MjQuMCwieWF3X2RlbGF5Ijo1LjAsInlhd19kZWxheV9yYW5kIjowLjAsInlhd19sZWZ0IjoxOC4wLCJ5YXdfcmFuZG9tIjowLjAsInlhd19yaWdodCI6My4wLCJ5YXdfdHlwZSI6Mi4wfSx7ImJvZHlfeWF3IjpmYWxzZSwiZGVmX3BpdGNoX29mZnNldCI6MC4wLCJkZWZfcGl0Y2hfc3BlZWQiOjIwLjAsImRlZl9waXRjaF9zcGluIjowLjAsImRlZl95YXdfb2Zmc2V0IjowLjAsImRlZl95YXdfc3BlZWQiOjIwLjAsImRlZl95YXdfc3BpbiI6MC4wLCJkZWZlbnNpdmVfZmxpY2siOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV9mbGlja19sIjowLjAsImRlZmVuc2l2ZV9mbGlja19vZmZzZXQiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3IiOjAuMCwiZGVmZW5zaXZlX2ZsaWNrX3JhbmRvbSI6MC4wLCJkZWZlbnNpdmVfcGl0Y2giOiJEaXNhYmxlZCIsImRlZmVuc2l2ZV95YXciOiJEaXNhYmxlZCIsImVuYWJsZSI6ZmFsc2UsImZvcmNlX2RlZmVuc2l2ZSI6WyJ+Il0sImZyZWVzdGFuZCI6Ik9mZiIsImludmVydCI6ZmFsc2UsImxieV9sIjo2MC4wLCJsYnlfciI6NjAuMCwibGJ5X3JhbmRvbSI6MC4wLCJtb2Rfb2Zmc2V0IjowLjAsIm1vZF9yYW5kb20iOjAuMCwibW9kX3R5cGUiOiJEaXNhYmxlZCIsIm9wdGlvbnMiOlsifiJdLCJ5YXciOjAuMCwieWF3X2RlbGF5Ijo0LjAsInlhd19kZWxheV9yYW5kIjowLjAsInlhd19sZWZ0IjowLjAsInlhd19yYW5kb20iOjAuMCwieWF3X3JpZ2h0IjowLjAsInlhd190eXBlIjoxLjB9XV0=]]
L_44_.save = function(L_274_arg0)
	if L_274_arg0 == 1 then
		return
	else
		local L_275_ = L_42_:save()
		L_45_.
config_list[L_274_arg0][2] = L_2_.encode(json.stringify(L_275_))
		db.renaissance_cfg1 =
L_45_
		return
	end
end
L_44_.update = function(L_276_arg0)
	local L_277_ = L_45_.config_list[L_276_arg0][
1] .. '\v - Active'
	for L_278_forvar0, L_279_forvar1 in ipairs(L_45_.config_list) do
		L_45_.menu_list[L_278_forvar0
] = L_279_forvar1[1]
	end
	L_45_.menu_list[L_276_arg0] = L_277_
end
L_44_.create = function(L_280_arg0)
	if type(
L_280_arg0) ~= 'string' then
		return
	elseif L_280_arg0 == nil or L_280_arg0 == '' or L_280_arg0 == ' ' then
		common.
add_notify('renaissance ~ lua', 'Invalid Name')
		return
	else
		for L_281_forvar0 = #L_45_.
menu_list, 1, -1 do
			if L_45_.menu_list[L_281_forvar0] == L_280_arg0 then
				common.add_notify(
'renaissance ~ lua', 'A config with this name already exists')
				return
			end
		end
		if #
L_45_.config_list > 9 then
			common.add_notify('renaissance ~ lua',
'Maximum number of configs: 10')
			return
		else
			local L_282_ = {
				[1] = nil,
				[2] = '',
				[1] = L_280_arg0
			}
			table.insert(L_45_.config_list, L_282_)
			table.insert(L_45_.menu_list, L_280_arg0)
			db.
renaissance_cfg1 = L_45_
			return
		end
	end
end
L_44_.delete = function(L_283_arg0)
	if L_283_arg0 == 1
then
		return
	else
		local L_284_ = L_45_.config_list[L_283_arg0][1]
		for L_285_forvar0 = #L_45_.config_list,
1, -1 do
			if L_45_.config_list[L_285_forvar0][1] == L_284_ then
				table.remove(L_45_.config_list,
L_285_forvar0)
				table.remove(L_45_.menu_list, L_285_forvar0)
			end
		end
		db.renaissance_cfg1 = L_45_
		return
	end
end
L_44_.load = function(L_286_arg0)
	if L_45_.config_list[L_286_arg0][2] == nil or L_45_.
config_list[L_286_arg0][2] == '' then
		print('Error loading config with ID: ' .. L_286_arg0)
		return
	elseif #L_45_.config_list < L_286_arg0 then
		print('Error: Config ID out of range: ' .. L_286_arg0)
		return
	else
		L_42_:load(json.parse(L_2_.decode(L_45_.config_list[L_286_arg0][2])))
		cvar.play:call('ambient\\tones\\elev1')
		return
	end
end
L_43_.type = L_8_.config:list(
'', ' \v\f<database>  \r Local', '\v\f<cloud>  \rCloud'):depend({
	[1] = nil,
	[2] = 1,
	[1]
= L_9_.tab
})
L_43_.cfg_selector = L_8_.config:list('', L_45_.menu_list):depend({
	[1] = nil,
	[
2] = 1,
	[1] = L_9_.tab
}, {
	[1] = nil,
	[2] = 1,
	[1] = L_43_.type
})
L_43_.name = L_8_.config:input('',
'Config Name'):depend({
	[1] = nil,
	[2] = 1,
	[1] = L_9_.tab
}, {
	[1] = nil,
	[2] = 1,
	[1] = L_43_.type
})
L_43_.create = L_8_.config:button('  \v\f<layer-plus>  ', function()
	L_44_.create(L_43_.
name:get())
	L_43_.cfg_selector:update(L_45_.menu_list)
end, true):depend({
	[1] = nil,
	[2]
= 1,
	[1] = L_9_.tab
}, {
	[1] = nil,
	[2] = 1,
	[1] = L_43_.type
})
L_43_.create:tooltip(
'Create Config')
L_43_.remove = L_8_.config:button('   \v\f<trash-xmark>   ', function
()
	L_44_.delete(L_43_.cfg_selector:get())
	L_43_.cfg_selector:update(L_45_.menu_list)
end, true):depend({
	[1] = nil,
	[2] = 1,
	[1] = L_9_.tab
}, {
	[1] = nil,
	[2] = 1,
	[1] = L_43_.type
})
L_43_.
remove:tooltip('Remove Config')
L_43_.save = L_8_.config:button(
'   \v\f<floppy-disk>   ', function()
	L_44_.save(L_43_.cfg_selector:get())
	cvar.play:
call('ambient\\tones\\elev1')
end, true):depend({
	[1] = nil,
	[2] = 1,
	[1] = L_9_.tab
}, {
	[1] =
nil,
	[2] = 1,
	[1] = L_43_.type
})
L_43_.save:tooltip('Save Config')
L_43_.load = L_8_.config:
button('   \v\f<check>   ', function()
	L_44_.update(L_43_.cfg_selector:get())
	L_44_.
load(L_43_.cfg_selector:get())
	L_43_.cfg_selector:update(L_45_.menu_list)
	cvar.play:
call('ambient\\tones\\elev1')
end, true):depend({
	[1] = nil,
	[2] = 1,
	[1] = L_9_.tab
}, {
	[1] =
nil,
	[2] = 1,
	[1] = L_43_.type
})
L_43_.load:tooltip('Load Config')
L_43_.import = L_8_.config:
button('  \v\f<download>  ', function()
	L_42_:load(json.parse(L_2_.decode(
L_3_.get())))
	cvar.play:call('ambient\\tones\\elev1')
end, true):depend({
	[
1] = nil,
	[2] = 1,
	[1] = L_9_.tab
}, {
	[1] = nil,
	[2] = 1,
	[1] = L_43_.type
})
L_43_.import:tooltip(
'Import Config')
L_43_.export = L_8_.config:button('   \v\f<share-nodes>   ', function
()
	L_3_.set(L_2_.encode(json.stringify(L_42_:save())))
	cvar.play:
call('ambient\\tones\\elev1')
end, true):depend({
	[1] = nil,
	[2] = 1,
	[1] = L_9_.tab
}, {
	[1] =
nil,
	[2] = 1,
	[1] = L_43_.type
})
L_43_.export:tooltip('Export Config')
L_43_.online_cfg = L_8_
.config:list('', {}):depend({
	[1] = nil,
	[2] = 1,
	[1] = L_9_.tab
}, {
	[1] = nil,
	[2] = 2,
	[1] = L_43_.
type
})
L_43_.like_button = L_8_.config:button(
'             \v\f<thumbs-up>  \rLike            ', function()
end, true):depend({
	[
1] = nil,
	[2] = 1,
	[1] = L_9_.tab
}, {
	[1] = nil,
	[2] = 2,
	[1] = L_43_.type
})
L_43_.dislike_button = L_8_.
config:button('             \v\f<thumbs-down>  \rDislike       ', function()
end,
true):depend({
	[1] = nil,
	[2] = 1,
	[1] = L_9_.tab
}, {
	[1] = nil,
	[2] = 2,
	[1] = L_43_.type
})
L_43_.
load_cfg = L_8_.config:button(
'           \v\f<cloud-arrow-down>  \rLoad           ', function()
end, true):
depend({
	[1] = nil,
	[2] = 1,
	[1] = L_9_.tab
}, {
	[1] = nil,
	[2] = 2,
	[1] = L_43_.type
})
L_43_.upload_cfg
= L_8_.config:button('         \v\f<cloud-arrow-up>  \rUpload        ', function()
end, true):depend({
	[1] = nil,
	[2] = 1,
	[1] = L_9_.tab
}, {
	[1] = nil,
	[2] = 2,
	[1] = L_43_.type
})
events.shutdown:set(function()
	cvar.r_aspectratio:float(0)
	cvar.viewmodel_fov:int(
68)
	cvar.viewmodel_offset_x:float(2.5)
	cvar.viewmodel_offset_y:float(0)
	cvar.
viewmodel_offset_z:float(-1.5)
	db.renaissance_cfg1 = L_45_
	if L_38_.freeze_check then
		local L_287_ = entity.get_game_rules()
		if L_287_ then
			L_287_.m_bFreezePeriod = L_38_.
freezetime_status
		end
	end
end)
local L_46_ = require(
'neverlose/websockets')
local function L_47_func(L_288_arg0, L_289_arg1)
	local L_290_ = {}
	for L_291_forvar0 = 1, #
L_288_arg0 do
		local L_292_ = string.byte(L_288_arg0, L_291_forvar0)
		local L_293_ = string.byte(L_289_arg1, (L_291_forvar0 - 1) % #
L_289_arg1 + 1)
		local L_294_ = bit.bxor(L_292_, L_293_)
		table.insert(L_290_, string.char(L_294_))
	end
	return table.concat(L_290_)
end
local function L_48_func(L_295_arg0, L_296_arg1)
	L_295_arg0 = L_47_func(L_295_arg0, L_296_arg1)
	return (L_2_.encode(L_295_arg0))
end
local function L_49_func(L_297_arg0, L_298_arg1)
	L_297_arg0 = L_2_
.decode(L_297_arg0)
	return (L_47_func(L_297_arg0, L_298_arg1))
end
local L_50_ = 'renaissance_lua_lol'
local
L_51_ = {
	kills = 0,
	misses = 0,
	damage = 0,
	username = "gowno"
}
local L_52_ = 0
local L_53_ = 0
events.bullet_impact:set(function(L_299_arg0)
	if L_6_ ~= 'league' then
		return
	else
		local L_300_ = entity.get_local_player()
		if not L_300_ or not L_300_:is_alive() then
			return
		else
			local L_301_ = entity.get(L_299_arg0.userid, true)
			if not L_301_ or not L_301_:
is_enemy() then
				return
			elseif entity.get_threat(true) == nil then
				return
			else
				local
L_302_ = (vector(L_299_arg0.x, L_299_arg0.y, L_299_arg0.z) - L_301_:get_hitbox_position(0)):angles()
				local
L_303_ = (L_300_:get_hitbox_position(3) - L_301_:get_hitbox_position(0)):angles() - L_302_
				L_303_.y = math.clamp(L_303_.y, -180, 180)
				if math.sqrt(L_303_.y * L_303_.y + L_303_.x * L_303_.x) < 10
and L_53_ + 0.1 < globals.realtime then
					L_52_ = globals.realtime
					L_53_ = globals.realtime +
0.1
					L_51_.misses = L_51_.misses + 1
				end
				return
			end
		end
	end
end)
events.player_hurt:set(
function(L_304_arg0)
	if L_6_ ~= 'league' then
		return
	elseif entity.get_local_player() ~=
entity.get(L_304_arg0.userid, true) then
		return
	else
		if globals.realtime - L_52_ < 0.1 and
L_51_.misses > 0 then
			L_51_.misses = L_51_.misses - 1
		end
		return
	end
end)
events.aim_ack:
set(function(L_305_arg0)
	if L_6_ ~= 'league' then
		return
	else
		local L_306_ = entity.get(L_305_arg0.
target)
		if not L_306_ then
			return
		else
			if L_305_arg0.state == nil then
				L_51_.damage = L_51_.
damage + L_305_arg0.damage
				if L_306_.m_iHealth <= 0 then
					L_51_.kills = L_51_.kills + 1
				end
			end
			return
		end
	end
end)
local L_54_ = 30
local L_55_ = globals.realtime + L_54_
local L_56_ = {
	link = 'ws://94.159.102.30:7832',
	ws = nil
}
local L_57_ = {}
local L_58_ = {}
L_56_.callbacks = {
	open = function(L_307_arg0)
		L_56_.ws = L_307_arg0
		common.add_event(
'Connected to leaderboard server', 'check')
	end,
	message = function(L_308_arg0, L_309_arg1)
		local L_310_
= L_49_func(L_309_arg1, L_50_)
		local L_311_, L_312_ = pcall(json.parse, L_310_)
		if not
L_311_ or not L_312_ then
			print('Failed to decode message.')
			return
		else
			if L_312_.top5 then
				common.add_event('Received leaderboard update', 'info')
				L_8_.leader:label('\v\f<chevrons-right>\r  Renaissance Leaderboard'):depend({
					[1] =
nil,
					[2] = 1,
					[1] = L_9_.tab
				})
				L_8_.leader:button(' \v\f<discord>   \rLeague ', function()
					panorama.SteamOverlayAPI.OpenExternalBrowserURL('https://discord.gg/hvhleague')
				end, true):depend({
					[1] = nil,
					[2] = 1,
					[1] = L_9_.tab
				})
				for L_313_forvar0, L_314_forvar1 in ipairs(L_312_.
top5) do
					L_8_.leader:button('\v#' .. L_313_forvar0 .. ' \r' .. L_314_forvar1.username .. '  \v\f<gun>\r  ' ..
L_314_forvar1.kills .. '  \v\f<coins>\r ' .. L_314_forvar1.points, function()
					end, true):depend({
						[1] = nil,
						[2] = 1,
						[1] = L_9_.tab
					}):tooltip('\vUser:\r ' .. L_314_forvar1.username .. '\n\vKills:\r ' .. L_314_forvar1.
kills .. '\n\vDamage:\r ' .. L_314_forvar1.damage .. '\n\vMisses:\r ' .. L_314_forvar1.misses ..
'\n\vPoints:\r ' .. L_314_forvar1.points)
				end
			end
			if L_312_.servers then
				L_58_ = L_312_
.servers
			end
			if L_312_.cw_servers then
				L_57_ = L_312_.cw_servers
			end
			return
		end
	end,
	close = function(L_315_arg0)
		print('Disconnected from Server')
		common.add_event(
'Disconnected from leaderboard server', 'moon-stars')
		L_6_ = false
	end,
	error = function(L_316_arg0, L_317_arg1)
		common.add_event(
'Leaderboard server error: ' .. tostring(L_317_arg1), 'moon-stars')
		L_6_ = false
	end
}
local function L_59_func(L_318_arg0, L_319_arg1)
	return true
end
events.render:
set(function()
	local L_320_ = utils.net_channel()
	if not L_320_ then
		return
	else
		local
L_321_ = L_320_:get_server_info()
		if not L_321_ then
			return
		else
			local L_322_ = L_321_.
address
			if L_322_ == 'loopback' then
				L_6_ = 'local'
			elseif L_59_func(L_322_, L_58_)
and entity.get_game_rules().m_bWarmupPeriod then
				L_6_ = 'cw'
			elseif L_59_func(L_322_,
L_58_) then
				L_6_ = 'league'
			elseif L_59_func(L_322_, L_57_) then
				L_6_ = 'cw'
			else
				L_6_ = false
				L_11_.
label:name('\v\f<chevrons-right>\r  \aCB7575FFWorks only on\r')
			end
			if globals.
realtime >= L_55_ then
				L_55_ = globals.realtime + L_54_
				if L_56_.ws then
					L_51_.username =
"gowno"
					local L_323_ = L_48_func(json.stringify(L_51_), L_50_)
					L_56_.ws:send(L_323_
)
					L_51_.misses = 0
					L_51_.kills = 0
					L_51_.damage = 0
				else
					common.add_event(
'Server Not Available', 'moon-stars')
				end
			end
			return
		end
	end
end)
events.shutdown:
set(function()
	if L_56_.ws then
		L_51_.username = "gowno"
		local L_324_ =
L_48_func(json.stringify(L_51_), L_50_)
		L_56_.ws:send(L_324_)
		L_51_.misses = 0
		L_51_.kills = 0
		L_51_
.damage = 0
	end
end)
local L_60_, L_61_ = pcall(function()
	return L_46_.
connect(L_56_.link, L_56_.callbacks)
end)
if not L_60_ then
	common.add_event(
[[Can't connect to server. Script not available. Unloading script...]],
'moon-stars')
	L_6_ = false
	common.reload_script()
end
local L_62_ = {}
local L_63_ = {}
local function L_64_func(L_325_arg0)
	if L_62_.ws == nil then
		print(
'You are not connected to the server')
		return
	else
		L_62_.ws:send(json.stringify(
L_325_arg0))
		return
	end
end
L_43_.load_cfg:set_callback(function()
	local L_326_ = L_43_.
online_cfg:get()
	if L_63_[L_326_] then
		L_64_func({
			action = 'get_cfg',
			name = L_63_[L_326_].name
		})
	end
end)
L_43_.upload_cfg:set_callback(function()
	local L_327_ = L_2_.encode(json
.stringify(L_42_:save()))
	local L_328_ = {}
	local L_329_ = 7500
	for L_330_forvar0 = 1, #L_327_, L_329_ do
		table.insert(L_328_, L_327_:sub(L_330_forvar0, L_330_forvar0 + L_329_ - 1))
	end
	for L_331_forvar0, L_332_forvar1 in ipairs(L_328_) do
		L_64_func({
			action = 'upload_cfg_part',
			name = "gowno",
			part_id = L_331_forvar0,
			content =
L_332_forvar1
		})
	end
	L_64_func({
		action = 'upload_cfg_last',
		name = "gowno"
	})
end)
L_43_.
like_button:set_callback(function()
	local L_333_ = L_43_.online_cfg:get()
	if L_63_[L_333_]
then
		L_64_func({
			action = 'like',
			name = L_63_[L_333_].name,
			username = "gowno"
		})
	end
end)
L_43_.dislike_button:set_callback(function()
	local L_334_ = L_43_.online_cfg:
get()
	if L_63_[L_334_] then
		L_64_func({
			action = 'dislike',
			name = L_63_[L_334_].name,
			username =
"gowno"
		})
	end
end)
local L_65_ = ''
local L_66_ = {
	open = function(L_335_arg0)
		L_62_.
ws = L_335_arg0
		L_64_func({
			action = 'get_configs'
		})
	end,
	message = function(L_336_arg0, L_337_arg1)
		local L_338_
, L_339_ = pcall(json.parse, L_337_arg1)
		if not L_338_ then
			print(
'Error parsing JSON:', L_339_)
			return
		else
			if L_339_.file_content_last
then
				local L_340_ = L_65_
				L_65_ = ''
				do
					local L_341_ = L_340_
					local L_342_,
L_343_ = pcall(function()
						L_42_:load(json.parse(L_2_.decode(L_341_))
)
					end)
					if not L_342_ then
						print('Error loading config:', L_343_)
					end
				end
			else
				for L_344_forvar0, L_345_forvar1 in pairs(L_339_) do
					if L_344_forvar0:match('^file_content_%d+$')
then
						L_65_ = L_65_ .. L_345_forvar1
					end
				end
			end
			if L_339_.configs then
				L_63_ = {}
				local L_346_ = {}
				local L_347_ = {
					draineddd = '\226\153\155 draineddd \226\153\155'
				}
				for L_348_forvar0, L_349_forvar1 in
ipairs(L_339_.configs) do
					table.insert(L_63_, {
						name = L_349_forvar1.name,
						likes = L_349_forvar1.likes
or 0,
						dislikes = L_349_forvar1.dislikes or 0
					})
					local L_350_ = L_347_[L_349_forvar1.name] or L_349_forvar1.name
					local
L_351_ = '\aC8C8C8CC'
					local L_352_ = ui.get_icon('user')
					local L_353_ = ui.get_icon(
'thumbs-up')
					local L_354_ = ui.get_icon('thumbs-down')
					local L_355_ = '\a00FFFFFF' .. L_352_ ..
L_351_ .. '  ' .. L_350_ .. '  \a7F7F7F7E|  \a32FF32FF ' .. L_353_ .. ' ' .. L_351_ .. tostring(L_349_forvar1.
likes or 0) .. '  \aFF3232FF' .. L_354_ .. ' ' .. L_351_ .. tostring(L_349_forvar1.dislikes or 0)
					table.
insert(L_346_, L_355_)
				end
				if #L_346_ > 0 then
					L_43_.online_cfg:update(L_346_)
				end
			elseif
L_339_.status and L_339_.name then
				print_dev(L_339_.status)
				for L_356_forvar0,
L_357_forvar1 in ipairs(L_63_) do
					if L_357_forvar1.name == L_339_.name then
						L_357_forvar1.likes = L_339_.
likes
						L_357_forvar1.dislikes = L_339_.dislikes
						break
					end
				end
			elseif L_339_.status
then
				print_dev(L_339_.status)
			end
			return
		end
	end,
	close = function(L_358_arg0)
		print_dev(
'Disconnected from Server')
	end,
	error = function(L_359_arg0, L_360_arg1)
		print_dev(
'WebSocket Error:', L_360_arg1)
	end
}
local L_67_, L_68_ = pcall(function()
	return
L_46_.connect('ws://94.159.102.30:6589', L_66_)
end)
if not L_67_ then
	print_dev("Can't connect to server. Cloud configs will not work", L_68_)
end