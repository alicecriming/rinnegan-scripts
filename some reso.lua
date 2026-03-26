local L_1_ = require("ffi") or error("error, reload script or cheat")
local L_2_ = require("vector") or error("error, reload script or cheat")
local L_3_ = function(L_23_arg0, L_24_arg1, L_25_arg2)
	return math.min(math.max(L_23_arg0, L_24_arg1), L_25_arg2)
end
local L_4_ = function(L_26_arg0)
	if L_26_arg0 == nil then
		return 0
	end
	while L_26_arg0 > 180 do
		L_26_arg0 = L_26_arg0 - 360
	end
	while L_26_arg0 < -180 do
		L_26_arg0 = L_26_arg0 + 360
	end
	return L_26_arg0
end
local L_5_ = function(L_27_arg0)
	return (0.0054931640625) * bit.band(math.floor(L_27_arg0 * (182.04444444444445)), 65535)
end
local L_6_ = function(L_28_arg0, L_29_arg1, L_30_arg2)
	L_28_arg0 = L_5_(L_28_arg0)
	L_29_arg1 = L_5_(L_29_arg1)
	local L_31_ = L_4_(L_28_arg0 - L_29_arg1)
	L_30_arg2 = math.abs(L_30_arg2)
	if L_31_ > L_30_arg2 then
		L_29_arg1 = L_29_arg1 + L_30_arg2
	elseif L_31_ < -L_30_arg2 then
		L_29_arg1 = L_29_arg1 - L_30_arg2
	else
		L_29_arg1 = L_28_arg0
	end
	return L_29_arg1
end
local L_7_ = function(L_32_arg0)
	return L_32_arg0 * (math.pi / 180)
end
local L_8_ = function(L_33_arg0)
	return L_33_arg0 * (180 / math.pi)
end
L_1_.cdef [[
    struct animation_layer_t1 {
        char pad20[24];
        uint32_t m_nSequence;
        float m_flPrevCycle;
        float m_flWeight;
        char pad20[8];
        float m_flCycle;
        void *m_pOwner;
        char pad_0038[ 4 ];
    };
    struct c_animstate1 { 
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
        float m_flMaxYaw; //0x334
    };
]]
local L_9_ = L_1_.typeof 'struct { int layer_order_preset; bool first_run_since_init; bool first_foot_plant_since_init; int last_update_tick; float eye_position_smooth_lerp; float strafe_change_weight_smooth_fall_off; float stand_walk_duration_state_has_been_valid; float stand_walk_duration_state_has_been_invalid; float stand_walk_how_long_to_wait_until_transition_can_blend_in; float stand_walk_how_long_to_wait_until_transition_can_blend_out; float stand_walk_blend_value; float stand_run_duration_state_has_been_valid; float stand_run_duration_state_has_been_invalid; float stand_run_how_long_to_wait_until_transition_can_blend_in; float stand_run_how_long_to_wait_until_transition_can_blend_out; float stand_run_blend_value; float crouch_walk_duration_state_has_been_valid; float crouch_walk_duration_state_has_been_invalid; float crouch_walk_how_long_to_wait_until_transition_can_blend_in; float crouch_walk_how_long_to_wait_until_transition_can_blend_out; float crouch_walk_blend_value; int cached_model_index; float step_height_left; float step_height_right; void* weapon_last_bone_setup; void* player; void* weapon; void* weapon_last; float last_update_time; int last_update_frame; float last_update_increment; float eye_yaw; float eye_pitch; float abs_yaw; float abs_yaw_last; float move_yaw; float move_yaw_ideal; float move_yaw_current_to_ideal; char pad1[4]; float primary_cycle; float move_weight; float move_weight_smoothed; float anim_duck_amount; float duck_additional; float recrouch_weight; float position_current[3]; float position_last[3]; float velocity[3]; float velocity_normalized[3]; float velocity_normalized_non_zero[3]; float velocity_length_xy; float velocity_length_z; float speed_as_portion_of_run_top_speed; float speed_as_portion_of_walk_top_speed; float speed_as_portion_of_crouch_top_speed; float duration_moving; float duration_still; bool on_ground; bool landing; float jump_to_fall; float duration_in_air; float left_ground_height; float land_anim_multiplier; float walk_run_transition; bool landed_on_ground_this_frame; bool left_the_ground_this_frame; float in_air_smooth_value; bool on_ladder; float ladder_weight; float ladder_speed; bool walk_to_run_transition_state; bool defuse_started; bool plant_anim_started; bool twitch_anim_started; bool adjust_started; char activity_modifiers_server[20]; float next_twitch_time; float time_of_last_known_injury; float last_velocity_test_time; float velocity_last[3]; float target_acceleration[3]; float acceleration[3]; float acceleration_weight; float aim_matrix_transition; float aim_matrix_transition_delay; bool flashed; float strafe_change_weight; float strafe_change_target_weight; float strafe_change_cycle; int strafe_sequence; bool strafe_changing; float duration_strafing; float foot_lerp; bool feet_crossed; bool player_is_accelerating; char pad2[24]; float duration_move_weight_is_too_high; float static_approach_speed; int previous_move_state; float stutter_step; float action_weight_bias_remainder; char pad3[112]; float camera_smooth_height; bool smooth_height_valid; float last_time_velocity_over_ten; float unk; float aim_yaw_min; float aim_yaw_max; float aim_pitch_min; float aim_pitch_max; int animstate_model_version; } **'
local L_10_ = L_1_.typeof 'struct { bool client_blend; float blend_in; void *studio_hdr; int dispatch_sequence; int second_dispatch_sequence; uint32_t order; uint32_t sequence; float prev_cycle; float weight; float weight_delta_rate; float playback_rate; float cycle; void *entity; char pad_0x0038[0x4]; } **'
local L_11_ = vtable_bind("client.dll", "VClientEntityList003", 3, "void*(__thiscall*)(void*, int)")
local L_12_ = ui.new_checkbox("Rage", "Other", "Enable jitter fix\aCFCFCFCF  [2.0]")
local L_13_ = function(L_34_arg0, L_35_arg1)
	if not L_34_arg0 then
		return false
	end
	local L_36_ = type(L_34_arg0) == "cdata" and L_34_arg0 or L_11_(L_34_arg0)
	if not L_36_ or L_36_ == L_1_.NULL then
		return false
	end
	local L_37_ = L_1_.cast("void***", L_36_)
	if L_35_arg1 == 1 then
		return L_1_.cast(L_9_, L_1_.cast("char*", L_37_) + 39264)[0]
	else
		return L_1_.cast("struct c_animstate1**", L_1_.cast("char*", L_37_) + 39264)[0]
	end
end
local L_14_ = function(L_38_arg0, L_39_arg1)
	if not L_38_arg0 then
		return false
	end
	local L_40_ = type(L_38_arg0) == "cdata" and L_38_arg0 or L_11_(L_38_arg0)
	if not L_40_ or L_40_ == L_1_.NULL then
		return false
	end
	local L_41_ = L_1_.cast("void***", L_40_)
	local L_42_ = L_1_.cast("char*", L_40_)
	return (L_1_.cast(L_10_, L_42_ + 10640)[0])[L_39_arg1]
end
local L_15_ = function(L_43_arg0)
	local L_44_ = L_13_(L_43_arg0, 0)
	local L_45_ = L_3_(L_44_.m_flFeetSpeedForwardsOrSideWays, 0, 1)
	local L_46_ = (L_44_.m_flStopToFullRunningFraction * - 0.30000001 - 0.19999999) * L_45_ + 1
	local L_47_ = L_44_.m_fDuckAmount
	if L_47_ > 0 then
		local L_48_ = L_3_(L_44_.m_flFeetSpeedForwardsOrSideWays, 0, 1)
		local L_49_ = L_47_ * L_48_
		L_46_ = L_46_ + (L_49_ * (0.5 - L_46_))
	end
	return L_46_
end
local L_16_ = function(L_50_arg0)
	local L_51_ = L_11_(L_50_arg0)
	if L_51_ and L_51_ ~= nil and L_50_arg0 then
		return entity.get_prop(L_50_arg0, "m_flSimulationTime") - client.real_latency(), L_1_.cast("float*", L_1_.cast("uintptr_t", L_51_) + 620)[0] - client.real_latency()
	else
		return 0, 0
	end
end
local L_17_ = function(L_52_arg0)
	local L_53_, L_54_ = L_16_(L_52_arg0)
	return toticks(L_53_ - L_54_) <= 1
end
local L_18_ = {}
for L_55_forvar0 = 1, 64 do
	L_18_[L_55_forvar0] = {
		jitter = {},
	}
end
local function L_19_func(L_56_arg0)
	L_18_[L_56_arg0] = {
		jitter = {
			yaw_cache = {},
			yaw_cache_offset = 0,
			static_ticks = 0,
			jitter_ticks = 0,
			is_jitter = false,
			diff = 0,
		}
	}
	L_18_[L_56_arg0].animstate1 = L_13_(L_56_arg0, 1)
	L_18_[L_56_arg0].jitter.yaw_cache[L_18_[L_56_arg0].jitter.yaw_cache_offset % 6 + 1] = L_18_[L_56_arg0].animstate1.eye_yaw
	L_18_[L_56_arg0].jitter.yaw_cache_offset = L_18_[L_56_arg0].jitter.yaw_cache_offset + 1
	if L_18_[L_56_arg0].jitter.yaw_cache_offset >= 7 then
		L_18_[L_56_arg0].jitter.yaw_cache_offset = 0
	end
end
local function L_20_func(L_57_arg0)
	L_19_func(L_57_arg0)
	L_18_[L_57_arg0].animstate1 = L_13_(L_57_arg0, 1)
	L_18_[L_57_arg0].first_angle = L_4_(L_18_[L_57_arg0].jitter.yaw_cache[6] or 0)
	L_18_[L_57_arg0].second_angle = L_4_(L_18_[L_57_arg0].jitter.yaw_cache[5] or 0)
	L_18_[L_57_arg0].sin_first = math.sin(L_7_(L_18_[L_57_arg0].first_angle))
	L_18_[L_57_arg0].sin_second = math.sin(L_7_(L_18_[L_57_arg0].second_angle))
	L_18_[L_57_arg0].cos_first = math.cos(L_7_(L_18_[L_57_arg0].first_angle))
	L_18_[L_57_arg0].cos_second = math.cos(L_7_(L_18_[L_57_arg0].second_angle))
	L_18_[L_57_arg0].avg_yaw = L_4_(L_8_(math.atan2(
        (L_18_[L_57_arg0].sin_first + L_18_[L_57_arg0].sin_second) / 2, 
        (L_18_[L_57_arg0].cos_first + L_18_[L_57_arg0].cos_second) / 2
    )))
	L_18_[L_57_arg0].jitter.diff = L_4_((L_18_[L_57_arg0].avg_yaw - L_18_[L_57_arg0].animstate1.eye_yaw) / 3)
	if math.abs(L_18_[L_57_arg0].jitter.diff) <= 0 then
		L_18_[L_57_arg0].jitter.static_ticks = math.min(L_18_[L_57_arg0].jitter.static_ticks + 1, 3)
		L_18_[L_57_arg0].jitter.jitter_ticks = 0
	elseif math.abs(L_18_[L_57_arg0].jitter.diff) >= 10 then
		L_18_[L_57_arg0].jitter.jitter_ticks = math.min(L_18_[L_57_arg0].jitter.jitter_ticks + 1, 3)
		L_18_[L_57_arg0].jitter.static_ticks = 0
	end
	L_18_[L_57_arg0].jitter.is_jitter = L_18_[L_57_arg0].jitter.jitter_ticks > L_18_[L_57_arg0].jitter.static_ticks
	if not L_18_[L_57_arg0].jitter.is_jitter then
		L_18_[L_57_arg0].jitter.diff = 0
	end
end
local function L_21_func(L_58_arg0)
	L_18_[L_58_arg0].animstate = L_13_(L_58_arg0, 0)
	L_18_[L_58_arg0].animstate1 = L_13_(L_58_arg0, 1)
	L_18_[L_58_arg0].angle_diff = L_4_(L_18_[L_58_arg0].animstate1.abs_yaw - L_18_[L_58_arg0].animstate1.eye_yaw)
	L_18_[L_58_arg0].desync_delta = L_4_(L_18_[L_58_arg0].angle_diff - L_15_(L_58_arg0) * 58)
	L_18_[L_58_arg0].legs_jitter = L_4_((L_18_[L_58_arg0].prev_goal_feet_yaw or 0) - L_18_[L_58_arg0].animstate1.abs_yaw)
	if math.abs(L_18_[L_58_arg0].legs_jitter) > 50 then
		L_18_[L_58_arg0].side = L_18_[L_58_arg0].legs_jitter > 0 and 1 or -1
	elseif desync_delta == 0 then
		L_18_[L_58_arg0].side = L_18_[L_58_arg0].angle_diff > 0 and 1 or -1
	else
		L_18_[L_58_arg0].side = L_18_[L_58_arg0].desync_delta > 0 and 1 or -1
	end
	L_18_[L_58_arg0].prev_goal_feet_yaw = L_18_[L_58_arg0].animstate1.abs_yaw
end
local function L_22_func(L_59_arg0)
	L_20_func(L_59_arg0)
	L_21_func(L_59_arg0)
	L_18_[L_59_arg0].animstate = L_13_(L_59_arg0, 0)
	L_18_[L_59_arg0].animstate1 = L_13_(L_59_arg0, 1)
	L_18_[L_59_arg0].max_yaw = math.abs(L_18_[L_59_arg0].animstate.m_flMaxYaw)
	L_18_[L_59_arg0].velocity = L_2_(entity.get_prop(L_59_arg0, "m_vecVelocity"))
	L_18_[L_59_arg0].animlayer3 = L_14_(L_59_arg0, 3)
	L_18_[L_59_arg0].animlayer6 = L_14_(L_59_arg0, 6)
	L_18_[L_59_arg0].m_extending = L_18_[L_59_arg0].animlayer3.cycle == 0 and L_18_[L_59_arg0].animlayer3.weight == 0
	L_18_[L_59_arg0].invalid_weight = L_18_[L_59_arg0].velocity:length2dsqr() <= 1 and math.abs(L_18_[L_59_arg0].velocity.z) <= 100 and (L_18_[L_59_arg0].animlayer6.weight == 0 or L_18_[L_59_arg0].animlayer6.weight == 1)
	L_18_[L_59_arg0].max_rotation = L_15_(L_59_arg0)
	L_18_[L_59_arg0].angle_diff = L_4_(L_18_[L_59_arg0].animstate1.abs_yaw - L_18_[L_59_arg0].animstate1.eye_yaw)
	L_18_[L_59_arg0].abs_angle_diff = math.abs(L_18_[L_59_arg0].angle_diff)
	L_18_[L_59_arg0].abs_prev_angle_diff = math.abs(L_18_[L_59_arg0].prev_angle_diff or 0)
	L_18_[L_59_arg0].networked_diff = math.max(L_18_[L_59_arg0].abs_angle_diff, L_18_[L_59_arg0].abs_prev_angle_diff)
	if L_18_[L_59_arg0].abs_angle_diff <= 10 and L_18_[L_59_arg0].abs_prev_angle_diff <= 10 then
		L_18_[L_59_arg0].networked_desync = L_18_[L_59_arg0].networked_diff
	elseif L_18_[L_59_arg0].abs_angle_diff <= 35 and L_18_[L_59_arg0].abs_prev_angle_diff <= 35 then
		L_18_[L_59_arg0].networked_desync = math.min(29, L_18_[L_59_arg0].networked_diff)
	else
		L_18_[L_59_arg0].networked_desync = L_18_[L_59_arg0].max_yaw * L_18_[L_59_arg0].max_rotation / 1.8
	end
	if L_17_(L_59_arg0) or L_18_[L_59_arg0].invalid_weight then
		L_18_[L_59_arg0].desync = 0
	elseif L_18_[L_59_arg0].m_extending then
		L_18_[L_59_arg0].desync = L_18_[L_59_arg0].max_yaw * L_18_[L_59_arg0].max_rotation * L_18_[L_59_arg0].side
	else
		L_18_[L_59_arg0].desync = L_3_(L_18_[L_59_arg0].networked_desync, 0, L_18_[L_59_arg0].max_yaw * L_18_[L_59_arg0].max_rotation) * L_18_[L_59_arg0].side
	end
	if L_18_[L_59_arg0].velocity:length2dsqr() > 1 or math.abs(L_18_[L_59_arg0].velocity.z) > 100 then
		L_18_[L_59_arg0].goal_feet_yaw = L_4_(L_6_(
            L_4_(L_18_[L_59_arg0].avg_yaw + L_18_[L_59_arg0].desync),
            L_18_[L_59_arg0].animstate1.abs_yaw,
            (L_18_[L_59_arg0].animstate.m_flStopToFullRunningFraction * 20 + 30) * L_18_[L_59_arg0].animstate.m_flLastClientSideAnimationUpdateTime
        ))
	else
		L_18_[L_59_arg0].goal_feet_yaw = L_4_(L_6_(
            L_4_(L_18_[L_59_arg0].avg_yaw + L_18_[L_59_arg0].desync),
            entity.get_prop(L_59_arg0, "m_flLowerBodyYawTarget"),
            L_18_[L_59_arg0].animstate.m_flLastClientSideAnimationUpdateTime * 100
        ))
	end
	L_18_[L_59_arg0].prev_angle_diff = angle_diff
end
client.set_event_callback("net_update_end", function()
	if not ui.get(L_12_) then
		return
	end
	for L_60_forvar0 = 1, globals.maxplayers() do
		if L_60_forvar0 ~= entity.get_local_player() and entity.is_enemy(L_60_forvar0) and entity.is_alive(L_60_forvar0) and not entity.is_dormant(L_60_forvar0) then
			L_22_func(L_60_forvar0)
			entity.set_prop(L_60_forvar0, "m_angEyeAngles", 
                L_18_[L_60_forvar0].animstate.m_flPitch, 
                L_4_(L_18_[L_60_forvar0].animstate1.eye_yaw + L_18_[L_60_forvar0].desync), 
                0
            )
			L_18_[L_60_forvar0].animstate1.abs_yaw = L_18_[L_60_forvar0].goal_feet_yaw
		end
	end
end)