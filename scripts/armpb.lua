include "constants.lua"

--pieces
local concrete, belt = piece('Concrete','Belt');
local wheel, arm, hand, cannon = piece('Wheel', 'Arm','Hand', 'Cannon');
local barrel1, barrel2, barrel3, muzzle = piece("Barrel1","Barrel2","Barrel3","Muzzle");
local lidLeft, lidRight = piece("lidLeft","lidRight");
local aimProxy = piece("AimProxy");

local spGetUnitRulesParam 	= Spring.GetUnitRulesParam
local spGetUnitIsStunned = Spring.GetUnitIsStunned
local spGetUnitHealth = Spring.GetUnitHealth
local spSetUnitHealth = Spring.SetUnitHealth

local unpackSpeed = 5;

local smokePiece = { lidLeft, lidRight, wheel}

--variables
local is_open = false
local restore_delay = 2000;

--signals
local aim = 2
local open = 8
local close = 16

local BUNKERED_AUTOHEAL = tonumber (UnitDef.customParams.armored_regen or 20) / 2 -- applied every 0.5s

-- private functions

local function Open()
	
	Spring.SetUnitArmored(unitID,false);
	Signal(close) --kill the closing animation if it is in process
	SetSignalMask(open) --set the signal to kill the opening animation

	
	Turn(lidLeft, z_axis, math.rad(0), unpackSpeed);
	Turn(lidRight, z_axis, math.rad(0), unpackSpeed);
	
	WaitForTurn(lidLeft, z_axis);
	
	Turn(wheel, x_axis, math.rad(-15),unpackSpeed);
	
	WaitForTurn(wheel, x_axis);
	
	Turn(hand, x_axis, math.rad(20), unpackSpeed);
	Turn(arm,x_axis,math.rad(20), unpackSpeed);
	Turn(wheel, x_axis, math.rad(-30), unpackSpeed);
	Turn(cannon, x_axis, math.rad(-10), unpackSpeed);
	
	WaitForTurn(cannon, x_axis);
	WaitForTurn(wheel, x_axis);
	
	Move(barrel1,z_axis,0,6);
	Move(barrel2,z_axis,0,6);
	Move(barrel3,z_axis,0,6);
	
	is_open = true
end

local function AimBlink()
	while true do 
		EmitSfx(aimProxy, 1024)
		Sleep(200)
	end
end

--closing animation of the factory
local function Close()
	Signal(aim)
	Signal(close)
	Signal(open) --kill the opening animation if it is in process
	SetSignalMask(close) --set the signal to kill the closing animation
	is_open = false;
	
	Move(barrel1,z_axis,-1,2);
	Move(barrel2,z_axis,-1,2);
	Move(barrel3,z_axis,-1,2); 
		
	Turn(wheel, x_axis, math.rad(-15),math.rad(90));
	Turn(cannon, x_axis, math.rad(65),math.rad(90));
	
	
	
	Turn(hand, x_axis, math.rad(60),math.rad(90));
	Turn(arm,x_axis,math.rad(107),math.rad(90));
	
	WaitForTurn(arm,x_axis);
	
	Turn(wheel, x_axis, math.rad(55),math.rad(160));
	
	WaitForTurn(wheel, x_axis);
	
	Turn(wheel, x_axis, math.rad(65),math.rad(20));
	
	Turn(lidLeft, z_axis, math.rad(90), math.rad(180));
	Turn(lidRight, z_axis, math.rad(-90), math.rad(180));

	Spring.SetUnitArmored(unitID,true);
	
	while true do
		local stunned_or_inbuild = spGetUnitIsStunned(unitID) or (spGetUnitRulesParam(unitID, "disarmed") == 1)
		if not stunned_or_inbuild then
			local hp = spGetUnitHealth(unitID)
			local slowMult = 1 - (spGetUnitRulesParam(unitID,"slowState") or 0)
			local newHp = hp + slowMult*BUNKERED_AUTOHEAL
			spSetUnitHealth(unitID, newHp)
		end
		Sleep(500)
	end
end

function RestoreAfterDelay()
	Sleep(restore_delay);
	
	repeat
		local inactive = spGetUnitIsStunned(unitID)
		if inactive then
			Sleep(restore_delay)
		end
	until not inactive
	StartThread(Close);
end

-- event handlers

function script.Activate ()
	StartThread(Open)
end

function script.Deactivate ()
	is_open = false
	StartThread(Close)
end

function script.Create()
	is_open = true;
		
	--StartThread(AimBlink);
	StartThread(SmokeUnit, smokePiece)
	StartThread(RestoreAfterDelay);
end


function script.QueryWeapon(n)
	return muzzle
end

function script.AimFromWeapon(n) 
	return aimProxy 
end

function script.AimWeapon(num, heading, pitch)
	Signal(aim)
	SetSignalMask(aim)
	
	Turn(belt, y_axis, heading, math.rad(200));
	
	if (not is_open) then
		StartThread(Open);

		while(not is_open) do
			Sleep(250);
		end
	end

	--Turn(cannon, y_axis, heading, 1.2)
	Turn(belt, y_axis, heading, math.rad(200));
	Turn(wheel, x_axis, -math.rad(30), math.rad(200));
	Turn(arm, x_axis, math.rad(30),10);
	Turn(hand, x_axis, math.rad(30),10);
	Turn(cannon, x_axis, -pitch-math.rad(30),10);
	 
	WaitForTurn (belt, y_axis)
	WaitForTurn (wheel, x_axis)
	
	StartThread(RestoreAfterDelay);

	return is_open;	
end

function script.FireWeapon(n)
	EmitSfx(muzzle, 1024)
	Move(barrel1,z_axis,-1,5);
	Move(barrel2,z_axis,-1,7);
	Move(barrel3,z_axis,-1,9);
	
	Sleep(200);
	Move(barrel3,z_axis,0,2);
	Sleep(100);
	Move(barrel2,z_axis,0,2);
	Sleep(100);
	Move(barrel1,z_axis,0,2);
end

function script.Killed(recentDamage, maxHealth)
	local severity = recentDamage / maxHealth

	if (severity <= .25) then
		return 1 -- corpsetype
	elseif (severity <= .5) then
		return 1 -- corpsetype
	else		
		return 2 -- corpsetype
	end
end
