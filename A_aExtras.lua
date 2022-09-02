--[[

	A_aExtras is code part of ScriptStash
	Made by Roy007: https://www.unknowncheats.me/forum/members/4362780.html
	Some code added and modified to fit my needs

	Script for Kiddion's Modest External Menu: https://www.unknowncheats.me/forum/grand-theft-auto-v/497052-kiddions-modest-external-menu-thread-3-a.html
	
]]--

local enable = true			--QuickFire default(on/off>true/false)
local enable4 = true		--VehAcclTweaksHotKey

-- Hotkey
local UOR=122				--UndeadOffradar Toggle, F11
local RefIn=73				--Refill Snack/Armor, i
local VehTw=192				--Vehicle Tweaks, ~

local function mpx() return stats.get_int("MPPLY_LAST_MP_CHAR") end

Ext=menu.add_submenu("Extras")

	-- Set Number Plate
		local Plates={ "POLICE", "OPEN BO", "RI 1", "IM GAY", "IM HORNY", "FUCK ME", "SANGEAN", "CATCH ME", "LUKONTOL" }
		local function Veh() if localplayer:is_in_vehicle() then return localplayer:get_current_vehicle() else return nil end end
		
		Ext:add_array_item("Set Number Plate", Plates, function() if Veh() then for x=1, #Plates do if Plates[x]==Veh():get_number_plate_text() then
		return x end end end return 1 end, function(t) if Veh() then Veh():set_number_plate_text(Plates[t]) end end)
	--

	-- Undead Offradar
		local original_max_health = 0.0
		local function GetUndeadOffradar()
		if not localplayer then return nil end max_health = localplayer:get_max_health() return max_health < 100.0
		end
		local function SetUndeadOffradar(value)
		if value == nil or localplayer == nil then return end if value then max_health = localplayer:get_max_health()
		if max_health >= 100.0 then original_max_health = max_health end localplayer:set_max_health(0.0) else
		if original_max_health >= 100 then localplayer:set_max_health(original_max_health) else localplayer:set_max_health(328.0) end end end
		
		Ext:add_toggle("Undead offradar", GetUndeadOffradar, SetUndeadOffradar)
		local function ToggleUndeadOffradar()
		value = GetUndeadOffradar() if value ~= nil then SetUndeadOffradar(not value) end end
		
		menu.register_hotkey(UOR, ToggleUndeadOffradar)
	--

	-- QuickFire Atomizer/StunGun
		local bT,WR,LR=0,0,0
		local function OnWeaponChanged(oldWeapon, newWeapon)
		if newWeapon ~= nil then NAME=localplayer:get_current_weapon():get_name_hash()
		if NAME==joaat("weapon_hominglauncher") then newWeapon:set_range(1500) elseif NAME==joaat("weapon_raypistol") then
		newWeapon:set_heli_force(1075) newWeapon:set_ped_force(63) newWeapon:set_vehicle_force(1075) end
		if bT==0 then if NAME==joaat("weapon_stungun_mp") then newWeapon:set_time_between_shots(1)
		elseif NAME==joaat("weapon_raypistol") then newWeapon:set_time_between_shots(0.5) end
		else newWeapon:set_time_between_shots(bT) end
		if WR~=0 then newWeapon:set_range(WR) else if NAME==joaat("weapon_raypistol") then newWeapon:set_range(1200)
		elseif NAME==joaat("weapon_stungun_mp") then newWeapon:set_range(1000) end end
		if LR==0 then if NAME==joaat("weapon_hominglauncher") then newWeapon:set_lock_on_range(1500) end
		else newWeapon:set_lock_on_range(LR) end end end
		if WCD then menu.remove_callback(WCD) end local WCD=nil
		if enable then local WCD = menu.register_callback('OnWeaponChanged', OnWeaponChanged) end

		local function WpCD(e)
		if e then WCD = menu.register_callback('OnWeaponChanged', OnWeaponChanged)
		else menu.remove_callback(WCD) bT,WR,LR=0,0,0 end end
		
		Ext:add_toggle("QuickFire Atomizer/StunGun", function() return enable end, function()
		enable = not enable WpCD(enable) end)
	--

	-- Vehicle Tweaks
		local OlA,OlG,OlVeh=nil,nil,nil
		local function VehicleTweaks()
		if localplayer:is_in_vehicle() then OlVeh=Veh()
		if Veh():get_acceleration()==0.59 then if OlA then Veh():set_acceleration(OlA) end
		if OlG then Veh():set_gravity(OlG) end if not OlVeh:get_can_be_visibly_damaged() then OlVeh:set_can_be_visibly_damaged(true) end
		if OlVeh:get_window_collisions_disabled() then OlVeh:set_window_collisions_disabled(false) end
		if OlVeh:get_godmode() then OlVeh:set_godmode(false) end OlA,OlG,OlVeh=nil,nil,nil
		elseif Veh():get_acceleration() < 0.59 and Veh():get_acceleration() > 0.1 then
		OlA=Veh():get_acceleration() OlG=Veh():get_gravity() OlV=Veh():get_can_be_visibly_damaged()
		Veh():set_acceleration(0.59) Veh():set_gravity(14.8) Veh():set_max_speed(220) end
		if Veh():get_acceleration()==40 then Veh():set_acceleration(OlA)
		if not OlVeh:get_can_be_visibly_damaged() then OlVeh:set_can_be_visibly_damaged(true) end
		if OlVeh:get_window_collisions_disabled() then OlVeh:set_window_collisions_disabled(false) end
		if OlVeh:get_godmode() then  OlVeh:set_godmode(false) end OlA,OlG,OlVeh=nil,nil,nil
		elseif  Veh():get_acceleration() < 40 and Veh():get_acceleration() > 5 then
		OlA=Veh():get_acceleration() Veh():set_acceleration(40) Veh():set_max_speed(220) end
		else if not OlVeh then return end if OlA then OlVeh:set_acceleration(OlA) end if OlG then OlVeh:set_gravity(OlG) end
		if not OlVeh:get_can_be_visibly_damaged() then OlVeh:set_can_be_visibly_damaged(true) end
		if OlVeh:get_window_collisions_disabled() then OlVeh:set_window_collisions_disabled(false) end
		if OlVeh:get_godmode() then  OlVeh:set_godmode(false) end OlA,OlG,OlVeh=nil,nil,nil end end
		
		if enable4 then menu.register_hotkey(VehTw, VehicleTweaks) end
	--

	-- Refill Inventory
		local function refillInventory()
		stats.set_int("MP"..mpx().."_NO_BOUGHT_YUM_SNACKS", 30) stats.set_int("MP"..mpx().."_NO_BOUGHT_HEALTH_SNACKS", 15)
		stats.set_int("MP"..mpx().."_NO_BOUGHT_EPIC_SNACKS", 5) stats.set_int("MP"..mpx().."_NUMBER_OF_ORANGE_BOUGHT", 10)
		stats.set_int("MP"..mpx().."_NUMBER_OF_BOURGE_BOUGHT", 10) stats.set_int("MP"..mpx().."_NUMBER_OF_CHAMP_BOUGHT", 5)
		stats.set_int("MP"..mpx().."_CIGARETTES_BOUGHT", 20) stats.set_int("MP"..mpx().."_MP_CHAR_ARMOUR_5_COUNT", 10)
		stats.set_int("MP"..mpx().."_BREATHING_APPAR_BOUGHT", 20) if stats.get_int("MP"..mpx().."_SR_INCREASE_THROW_CAP") then 
		if localplayer:get_weapon_by_hash(joaat("slot_stickybomb")) then localplayer:get_weapon_by_hash(joaat("slot_stickybomb")):set_current_ammo(30) end
		if localplayer:get_weapon_by_hash(joaat("slot_smokegrenade")) then localplayer:get_weapon_by_hash(joaat("slot_smokegrenade")):set_current_ammo(30) end
		if localplayer:get_weapon_by_hash(joaat("slot_grenade")) then localplayer:get_weapon_by_hash(joaat("slot_grenade")):set_current_ammo(30) end
		if localplayer:get_weapon_by_hash(joaat("slot_molotov")) then localplayer:get_weapon_by_hash(joaat("slot_molotov")):set_current_ammo(30) end
		if localplayer:get_weapon_by_hash(joaat("slot_proxmine")) then localplayer:get_weapon_by_hash(joaat("slot_proxmine")):set_current_ammo(10) end
		if localplayer:get_weapon_by_hash(joaat("slot_pipebomb")) then localplayer:get_weapon_by_hash(joaat("slot_pipebomb")):set_current_ammo(10) end end end
		
		menu.register_hotkey(RefIn, refillInventory)
	--

	-- Nightclub Popularity
		Ext:add_action("Max Nightclub Popularity", function()
		stats.set_int("MP"..mpx().."_club_popularity", 1000) end)
	--

	-- Service Carbine
		Ext:add_toggle("Get Service Carbine", function()
		return globals.get_boolean(262145 + 32775) end, function(value)
		globals.set_boolean(262145 + 32775, value) end)
	--

--- Info
	Ext:add_action("  __________________Hotkey__________________", function() end)
	Ext:add_action("Vehicle Tweaks                                     [~]", function() end)
	Ext:add_action("Refill Snack/Armor/Ammo                     [i]", function() end)
---