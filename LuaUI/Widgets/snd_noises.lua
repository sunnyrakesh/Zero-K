--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    snd_chatterbox.lua
--  brief:   annoys sounds
--  author:  Dave Rodgers
--
--  Copyright (C) 2007.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local versionNum = '1.11'

function widget:GetInfo()
  return {
    name      = "Noises",
    desc      = "v".. (versionNum) .." Selection, move and attack warning sounds.",
    author    = "quantum",
    date      = "Oct 24, 2007",
    license   = "GNU GPL, v2 or later",
    layer     = -10,
    enabled   = true  --  loaded by default?
  }
end
---- CHANGELOG -----
-- versus666, 		v1.1	(26oct2010)	:	Clean up code/corrected typo.
-- quantum,			v1.0				:	creation

--REMINDER to do:
-- Disable robotic sounds heard when playing chicken faction.
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Uses the SelectionChanged call-in
-- Replace your LuaUI/widgets.lua with our LuaUI/cawidgets.lua to benefit from
-- it in other mods

local GetSelectedUnits	= Spring.GetSelectedUnits
local GetUnitDefID		= Spring.GetUnitDefID
local GetGameSeconds	= Spring.GetGameSeconds
local spInView			= Spring.IsUnitInView
local PlaySoundFile		= Spring.PlaySoundFile
local spGetUnitHealth	= Spring.GetUnitHealth

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

options_path = 'Settings/Audio/Unit Replies'
options_order = { 
'selectnoisevolume','ordernoisevolume','attacknoisevolume', 
}
options = {
	selectnoisevolume = {
		name = 'Selection Volume',
		type = "number", 
		value = 1, 
		min = 0,
		max = 1,
		step = 0.02,
	},
	ordernoisevolume = {
		name = 'Command Volume',
		type = "number", 
		value = 1, 
		min = 0,
		max = 1,
		step = 0.02,
	},
	attacknoisevolume = {
		name = 'Commander Under Attack Volume',
		type = "number", 
		value = 1, 
		min = 0,
		max = 1,
		step = 0.02,
	},
}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local SOUND_DIRNAME = 'Sounds/reply/'
local SOUND_DIRNAME_SHORT = 'reply/'
local LUAUI_DIRNAME = 'LuaUI/'
local SOUNDTABLE_FILENAME = LUAUI_DIRNAME.."Configs/sounds_noises.lua"
local soundTable = VFS.Include(SOUNDTABLE_FILENAME, nil, VFS.RAW_FIRST)
local myTeamID
local cooldown = {}
local previousSelection

local unitInSelection = {}
local doNotPlayNextSelection = false

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function playSound(filename, ...)
	local path = SOUND_DIRNAME..filename..".WAV"
	if (VFS.FileExists(path)) then
		PlaySoundFile(SOUND_DIRNAME_SHORT .. filename, ...)
	else
	--Spring.Echo(filename)
		Spring.Echo("<snd_noises.lua>: Error file "..path.." doesn't exist.")
	end
end


local function CoolNoisePlay(category, cooldownTime, volume) 
	cooldownTime = cooldownTime or 0
	local t = GetGameSeconds()
	if ( (not cooldown[category]) or ((t - cooldown[category]) > cooldownTime) ) then
		playSound(category, volume or 1, 'userinterface')
		cooldown[category] = t
	end
end

function widget:Initialize()
	local _, _, spec, team = Spring.GetPlayerInfo(Spring.GetMyPlayerID()) 
	myTeamID = team
	WG.noises = true
end

function widget:Shutdown()
	WG.noises = nil
end

function widget:SelectionChanged(selection)
	if doNotPlayNextSelection then
		doNotPlayNextSelection = false
		return
	end
	if (not selection[1]) then
		return
	end
	unitInSelection = {}
	for i = 1, #selection do
		unitInSelection[selection[i]] = true
	end
	local unitDefID = GetUnitDefID(selection[1])
	if (unitDefID) then --only make sound when selecting own units
		local unitName = UnitDefs[unitDefID].name
		if (unitName and soundTable[unitName]) then
			local sound = soundTable[unitName].select[1]
			if (sound) then
				CoolNoisePlay((sound), 0.5, (soundTable[unitName].select.volume or 1)*options.selectnoisevolume.value)
			end
		end
	end
end

function WG.sounds_gaveOrderToUnit(unitID, isBuild)
	if unitID then
		local unitDefID = GetUnitDefID(unitID)
		local unitName = UnitDefs[unitDefID].name
		local sounds = soundTable[unitName] or soundTable[default]
		if not isBuild then
			if (sounds and sounds.ok) then
				CoolNoisePlay(sounds.ok[1], 0.5, sounds.ok.volume)
			end
		elseif (sounds and sounds.build) then
			CoolNoisePlay(sounds.build, 0.5)
		end
	end
end

function widget:CommandNotify(cmdID)
	local unitID = GetSelectedUnits()[1]
	if (not unitID) then
		return
	end
	local unitDefID = GetUnitDefID(unitID)
	local unitName = UnitDefs[unitDefID].name
	local sounds = soundTable[unitName] or soundTable[default]
	if (CMD[cmdID]) then
		if (sounds and sounds.ok) then
			CoolNoisePlay(sounds.ok[1], 0.5, (sounds.ok.volume or 1)*options.ordernoisevolume.value)
		end
	elseif (sounds and sounds.build) then
		CoolNoisePlay(sounds.build, 0.5, options.ordernoisevolume.value)
	end
end

function widget:UnitDamaged(unitID, unitDefID, unitTeam, damage)
	if (unitTeam == myTeamID)  and damage>1 then
		local unitDefID = GetUnitDefID(unitID)
		local unitName = UnitDefs[unitDefID].name
		local sounds = soundTable[unitName] or soundTable[default]
		if sounds and sounds.underattack and sounds.underattack[1] and (sounds.attackonscreen or not spInView(unitID)) then
			if sounds.attackdelay then
				local health, maxhealth = spGetUnitHealth(unitID)
				CoolNoisePlay(sounds.underattack[1], sounds.attackdelay(health/maxhealth), (sounds.underattack.volume or 1)*options.attacknoisevolume.value)
			else
				CoolNoisePlay(sounds.underattack[1], 40, (sounds.underattack.volume or 1)*options.attacknoisevolume.value)
			end
		end
	end
end

function widget:UnitDestroyed(unitID, unitDefID, unitTeam)
	if unitInSelection[unitID] then
		doNotPlayNextSelection = true
	end
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

