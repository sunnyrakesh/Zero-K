--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "Cloak Fire State",
    desc      = "Sets units to Hold Fire when cloaked, reverts to original state when decloaked",
    author    = "KingRaptor (L.J. Lim)",
    date      = "Feb 14, 2010",
    license   = "GNU GPL, v2 or later",
    layer     = -1,
    enabled   = false  --  loaded by default?
  }
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Speedups
local GiveOrderToUnit  = Spring.GiveOrderToUnit
local GetUnitStates    = Spring.GetUnitStates
local GetUnitDefID     = Spring.GetUnitDefID
local GetMyTeamID      = Spring.GetMyTeamID
local GetSelectedUnits = Spring.GetSelectedUnits
local GetUnitIsCloaked = Spring.GetUnitIsCloaked
local GetPlayerInfo    = Spring.GetPlayerInfo

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local team = GetMyTeamID()

local exceptionList = {	--add exempt units here
	"armsnipe",
	"armjeth",
}

local exceptionArray = {}	--used by the widget code; don't mess with this kthx

for _,name in pairs(exceptionList) do
	local ud = UnitDefNames[name]
	if ud then
		exceptionArray[ud.id] = true
	end
end
-- auto-add to exceptionArray
for id,ud in pairs(UnitDefs) do
	if (not ud.canMove) or ud.isFactory or (not ud.canCloak) then
		exceptionArray[id] = true
	end
end

local cloakUnit = {}	--stores the desired fire state when decloaked of each unitID

function widget:UnitCloaked(unitID, unitDefID, teamID)
	if (teamID ~= team) or exceptionArray[unitDefID] then return end	--only affects units with intrinsic cloak, i.e. not just anything under a field
	local states = GetUnitStates(unitID)
	cloakUnit[unitID] = states.firestate	--store last state
	if states.firestate ~= 0 then
		GiveOrderToUnit(unitID, CMD.FIRE_STATE, {0}, {})
		--Spring.Echo("Unit holding fire")
	end
end

function widget:UnitDecloaked(unitID, unitDefID, teamID)
	if (teamID ~= team) or exceptionArray[unitDefID] then return end
	local states = GetUnitStates(unitID)
	if states.firestate == 0 then
		local targetState = cloakUnit[unitID] or 2
		GiveOrderToUnit(unitID, CMD.FIRE_STATE, {targetState}, {})	--revert to last state
		--Spring.Echo("Unit compromised - weapons free!")
	end
	cloakUnit[unitID] = nil
end

local function CheckSpecState()
  if Spring.GetSpectatingState() then
	Spring.Echo("<Cloak Fire State> Spectator mode. Widget removed.")
	widgetHandler:RemoveWidget()
  end
end

function widget:GameFrame(n)
	if (n%16 < 1) then
		CheckSpecState()
	end
end

function widget:Initialize()
   if (Spring.GetSpectatingState() or Spring.IsReplay()) and (not Spring.IsCheatingEnabled()) then
    widgetHandler:RemoveWidget()
    return true
  end
end

function widget:UnitCreated(unitID, unitDefID, unitTeam)
  if (unitTeam == team) then
	local states = GetUnitStates(unitID)
	cloakUnit[unitID] = states.firestate
  elseif (cloakUnit[unitID]) then
    cloakUnit[unitID] = nil
  end
end

function widget:UnitGiven(unitID, unitDefID, unitTeam)
  widget:UnitCreated(unitID, unitDefID, unitTeam)
end

function widget:UnitDestroyed(unitID, unitDefID, unitTeam)
    cloakUnit[unitID] = nil
end

--[[
function widget:CommandNotify(commandID, params, options)
  if (commandID == CMD.FIRE_STATE) then
    local selUnits = GetSelectedUnits()
	if selUnits then
		for i,unitID in pairs(selUnits) do    
			if not GetUnitIsCloaked(unitID) then
				cloakUnit[unitID] = params[1]
				Spring.Echo("Cloak unit entry for unitID "..unitID.." updated to "..params[1])
			end
		end
	end
  end   
end
]]

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--dinosaur code
--[[
local function CheckCloakedUnits()
	for unitID in pairs(cloakUnit) do
		local states = GetUnitStates(unitID)
		if GetUnitIsCloaked(unitID) and states.firestate == 2 then
			GiveOrderToUnit(unitID, CMD.FIRE_STATE, {0}, {})
			Spring.Echo("Unit holding fire")
		elseif (not GetUnitIsCloaked(unitID)) and states.firestate == 0 then
			GiveOrderToUnit(unitID, CMD.FIRE_STATE, {2}, {})
			Spring.Echo("Unit compromised - weapons free!")
		end
	end
end
function widget:UnitCreated(unitID, unitDefID, unitTeam)
  if (unitTeam == team) then
	local ud = UnitDefs[unitDefID]
    if ud.initCloaked == true or ud.cloakCost > 0 or ud.name == "armflea" then
	  cloakUnit[unitID] = true
	  --Spring.Echo(ud.humanName .. " (unit ID " .. unitID .. ") added to cloak list")
    end
  elseif (cloakUnit[unitID]) then
    cloakUnit[unitID] = nil
  end
end

function widget:UnitGiven(unitID, unitDefID, unitTeam)
  widget:UnitCreated(unitID, unitDefID, unitTeam)
end

function widget:UnitDestroyed(unitID, unitDefID, unitTeam)
    cloakUnit[unitID] = nil
	local ud = UnitDefs[unitDefID]
	--Spring.Echo(ud.humanName .. " (unit ID " .. unitID .. ") removed from cloak list")
end
]]--
