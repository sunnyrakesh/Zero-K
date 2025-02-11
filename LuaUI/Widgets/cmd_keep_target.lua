function widget:GetInfo()
  return {
    name      = "Keep Target",
    desc      = "Simple and slowest usage of target on the move",
    author    = "Google Frog",
    date      = "29 Sep 2011",
    license   = "GNU GPL, v2 or later",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end

VFS.Include("LuaRules/Configs/customcmds.h.lua")

--------------------------------------------------------------------------------
-- Epic Menu Options
--------------------------------------------------------------------------------

options_path = 'Game/Target AI'
options = {
	keepTarget = {
		name = "Keep overridden attack target",
		type = "bool",
		value = true,
		desc = "Units with an attack command will still proritize their target after being given a move command.",
	},
	removeTarget = {
		name = "Stop clears target",
		type = "bool",
		value = true,
		desc = "Issuing the commands Stop, Fight, Guard and Attack cancel priority target orders.",
	},
}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function isValidUnit(unitID)
	local unitDefID = Spring.GetUnitDefID(unitID)
	if unitDefID and Spring.ValidUnitID(unitID) then
		local ud = UnitDefs[unitDefID]
		return ud and not (ud.isBomber or ud.isFactory)
	end
	return false
end

local TargetKeepingCommand = {
	[CMD.MOVE] = true,
	[CMD_JUMP] = true
}

local TargetCancelingCommand = {
	[CMD.STOP] = true,
	[CMD.ATTACK] = true,
	[CMD.FIGHT] = true,
	[CMD.GUARD] = true,
}

function widget:CommandNotify(id, params, cmdOptions)
    if options.keepTarget.value and TargetKeepingCommand[id] then
        local units = Spring.GetSelectedUnits()
        for i = 1, #units do
            local unitID = units[i]
            if isValidUnit(unitID) then
                local cmd = Spring.GetCommandQueue(unitID, 1)
                if cmd and #cmd ~= 0 and cmd[1].id == CMD.ATTACK and #cmd[1].params == 1 and not cmd[1].options.internal then
					Spring.GiveOrderToUnit(unitID, CMD_UNIT_SET_TARGET, cmd[1].params, {internal = true})
                end
            end
        end
    elseif options.removeTarget.value and TargetCancelingCommand[id] then
        local units = Spring.GetSelectedUnits()
        for i = 1, #units do
            local unitID = units[i]
            if isValidUnit(unitID) then
                Spring.GiveOrderToUnit(unitID,CMD_UNIT_CANCEL_TARGET,params,{})
            end
        end
	end	
    return false
end