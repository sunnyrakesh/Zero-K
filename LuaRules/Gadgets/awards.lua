function gadget:GetInfo()
	return {
		name    = "Awards",
		desc    = "v1.002 Awards players at end of battle with shiny trophies.",
		author  = "CarRepairer",
		date    = "2008-10-15", --2013-09-05
		license = "GNU GPL, v2 or later",
		layer   = 1000000, -- Must be after all other build steps and before unit_spawner.lua for queen kill award.
		enabled = not (Game.version:find('91.0') == 1),
	}
end

--local TESTMODE = true
include("LuaRules/Configs/constants.lua")

local spGetAllyTeamList = Spring.GetAllyTeamList
local spIsGameOver      = Spring.IsGameOver
local spGetTeamInfo     = Spring.GetTeamInfo
local gaiaTeamID        = Spring.GetGaiaTeamID()

local echo = Spring.Echo

local totalTeamList = {}

local awardDescs =
{
	pwn     = 'Complete Annihilation Award',
	navy    = 'Fleet Admiral',
	air     = 'Airforce General',
	nux     = 'Apocalyptic Achievement Award',
	friend  = 'Friendly Fire Award',
	shell   = 'Turtle Shell Award',
	fire    = 'Master Grill-Chef',
	emp     = 'EMP Wizard',
	slow    = 'Traffic Cop',
	t3      = 'Experimental Engineer',
	cap     = 'Capture Award',
	share   = 'Share Bear',
	terra   = 'Legendary Landscaper',
	reclaim = 'Spoils of War',
	rezz    = 'Necromancy Award',
	vet     = 'Decorated Veteran',
	ouch    = 'Big Purple Heart',
	kam     = 'Kamikaze Award',
	comm    = 'Master and Commander',
	mex     = 'Mineral Prospector',
	mexkill = 'Loot & Pillage',
	rage    = 'Rage Inducer',
	head    = 'Head Hunter',
	dragon  = 'Dragon Slayer',
	heart   = 'Queen Heart Breaker',
	sweeper = 'Land Sweeper',
}

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
if (gadgetHandler:IsSyncedCode()) then
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
local spAreTeamsAllied      = Spring.AreTeamsAllied
local spGetGameSeconds      = Spring.GetGameSeconds
local spGetTeamStatsHistory = Spring.GetTeamStatsHistory
local spGetUnitHealth       = Spring.GetUnitHealth
local spGetAllUnits         = Spring.GetAllUnits
local spGetUnitTeam         = Spring.GetUnitTeam
local spGetUnitDefID        = Spring.GetUnitDefID
local spGetUnitExperience   = Spring.GetUnitExperience
local spGetTeamResources    = Spring.GetTeamResources

local floor = math.floor

local terraunitDefID = UnitDefNames["terraunit"].id
local terraformCost  = UnitDefNames["terraunit"].metalCost

local mexDefID = UnitDefNames["cormex"].id
local mexCost  = UnitDefNames["cormex"].metalCost

local reclaimListByFeature = {}
local shareListTemp1 = {}
local shareListTemp2 = {}

local cappedComs = {}

local awardData = {}

local basicEasyFactor = 0.5
local veryEasyFactor = 0.3

local empFactor     = veryEasyFactor*4
local reclaimFactor = veryEasyFactor*0.2 -- wrecks aren't guaranteed to leave more than 0.2 of value

local minFriendRatio = 0.25
local minReclaimRatio = 0.15

local awardAbsolutes = {
	cap         = 1000,
	share       = 5000,
	terra       = 1000,
	rezz        = 3000,
	mex         = 15,
	mexkill     = 15,
	head        = 3,
	dragon      = 3,
	sweeper     = 20,
	heart       = 1*10^9, --we should not exceed 2*10^9 because math.floor-ing the value will return integer -2147483648. Reference: https://code.google.com/p/zero-k/source/detail?r=9681
	vet         = 3,
}

local awardEasyFactors = {
	shell     = basicEasyFactor,
	fire      = basicEasyFactor,

	nux       = veryEasyFactor,
	kam       = veryEasyFactor,
	comm      = veryEasyFactor,

	reclaim   = reclaimFactor,
	emp       = empFactor,
}

local expUnitTeam, expUnitDefID, expUnitExp = 0,0,0

local awardList = {}
local sentAwards = false

local shareList_update = TEAM_SLOWUPDATE_RATE*60*5 -- five minute frames

local boats, t3Units, comms = {}, {}, {}

local staticO_small = {
	armbrtha = 1,
	seismic = 1,
	tacnuke = 1,
	empmissile = 1,
	napalmmissile = 1,
}

local staticO_big = {
	corsilo = 1,
	mahlazer = 1,
	zenith = 1,
	raveparty = 1,
}

local kamikaze = {
	corroach=1,
	corsktl=1,
	blastwing=1,
	puppy=1,
}

local flamerWeaponDefs = {}

-------------------
-- Resource tracking


local allyTeamInfo = {}
--local resourceInfo = {count = 0, data = {}}

do
	local allyTeamList = Spring.GetAllyTeamList()
	for i=1,#allyTeamList do
		local allyTeamID = allyTeamList[i]
		allyTeamInfo[allyTeamID] = {
			team = {},
			teams = 0,
		}

		local teamList = Spring.GetTeamList(allyTeamID)
		for j=1,#teamList do
			local teamID = teamList[j]
			allyTeamInfo[allyTeamID].teams = allyTeamInfo[allyTeamID].teams + 1
			allyTeamInfo[allyTeamID].team[allyTeamInfo[allyTeamID].teams] = teamID
		end
	end
end

------------------------------------------------
-- functions

local function comma_value(amount)
	local formatted = amount .. ''
	local k
	while true do
		formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end

local function getMeanDamageExcept(excludeTeam)
	local mean = 0
	local count = 0
	--for team,dmg in pairs(damageList) do
	for team,dmg in pairs(awardData.pwn) do
		if team ~= excludeTeam
			and dmg > 100
		then
			mean = mean + dmg
			count = count + 1
		end
	end
	return (count>0) and (mean/count) or 0
end

local function getMaxVal(valList)
	local winTeam, maxVal = false,0
	for team,val in pairs(valList) do
		if val and val > maxVal then
			winTeam = team
			maxVal = val
			--Spring.Echo(" Team ".. winTeam .." maxVal ".. maxVal) --debug
		end
	end

	return winTeam, maxVal
end

local function getMeanMetalIncome()
	local num, sum = 0, 0
	for _,team in pairs(totalTeamList) do
		sum = sum + select(2, Spring.GetTeamResourceStats(team, "metal"))
		num = num + 1
	end
	return (sum/num)
end

local function awardAward(team, awardType, record)
	if not awardList[team] then --random check for devving.
		echo('<Award Error> Missing award list for team ' .. team)
		return
	end
	awardList[team][awardType] = record

	if TESTMODE then
		for _,curTeam in pairs(totalTeamList) do
			if curTeam ~= team then
				awardList[curTeam][awardType] = nil
			end
		end
	end
end

local function CopyTable(original) -- Warning: circular table references lead to
	local copy = {}                -- an infinite loop.
	for k, v in pairs(original) do
		if (type(v) == "table") then
			copy[k] = CopyTable(v)
		else
			copy[k] = v
		end
	end
	return copy
end

local function UpdateShareList()
	awardData.share = CopyTable(shareListTemp2)
	shareListTemp2 = CopyTable(shareListTemp1)
end

local function UpdateResourceStats(t)

	resourceInfo.count = resourceInfo.count + 1
	resourceInfo.data[resourceInfo.count] = {allyRes = {}, teamRes = {}, t = t}

	for allyTeamID, allyTeamData in pairs(allyTeamInfo) do
		local teams = allyTeamData.teams
		local team = allyTeamData.team

		local allyOverdriveResources = GG.Overdrive_allyTeamResources[allyTeamID] or {}

		resourceInfo.data[resourceInfo.count].allyRes[allyTeamID] = {
			metal_income_total = 0,
			metal_income_base = allyOverdriveResources.baseMetal or 0,
			metal_income_overdrive = allyOverdriveResources.overdriveMetal or 0,
			metal_income_other = 0,

			metal_spend_total = 0,
			metal_spend_construction = 0,
			metal_spend_waste = 0,

			metal_storage_current = 0,
			metal_storage_free = 0,

			energy_income_total = allyOverdriveResources.baseEnergy or 0,

			energy_spend_total = 0,
			energy_spend_overdrive = allyOverdriveResources.overdriveEnergy or 0,
			energy_spend_construction = 0,
			energy_spend_other = 0,
			energy_spend_waste = allyOverdriveResources.wasteEnergy or 0,

			energy_storage_current = 0,
		}

		local aRes = resourceInfo.data[resourceInfo.count].allyRes[allyTeamID]

		for i = 1, teams do
			local teamID = team[i]
			local mCurr, mStor, mPull, mInco, mExpe, mShar, mSent, mReci = spGetTeamResources(teamID, "metal")
			aRes.metal_spend_construction = aRes.metal_spend_construction + mExpe
			aRes.metal_income_total = aRes.metal_income_total + mInco
			aRes.metal_spend_total = aRes.metal_spend_total + mExpe
			aRes.metal_storage_free = aRes.metal_storage_free + mStor - mCurr
			aRes.metal_storage_current = aRes.metal_storage_current + mCurr

			local eCurr, eStor, ePull, eInco, eExpe, eShar, eSent, eReci = spGetTeamResources(teamID, "energy")
			aRes.energy_spend_total = aRes.energy_spend_total + eExpe
			aRes.energy_storage_current = aRes.energy_storage_current + eCurr

			local teamOverdriveResources = GG.Overdrive_teamResources[teamID] or {}

			resourceInfo.data[resourceInfo.count].teamRes[teamID] = {
				metal_income_total = mInco + mReci,
				metal_income_base = teamOverdriveResources.baseMetal or 0,
				metal_income_overdrive = teamOverdriveResources.overdriveMetal or 0,
				metal_income_other = 0,

				metal_spend_total = mExpe + mSent,
				metal_spend_construction = mExpe,

				metal_share_net = mReci - mSent,

				metal_storage_current = mCurr,

				energy_income_total = eInco,

				energy_spend_total = eExpe,
				energy_spend_construction = mExpe,
				energy_spend_other = 0,

				energy_share_net = teamOverdriveResources.overdriveEnergyChange or 0,

				energy_storage_current = eCurr,
			}

			local tRes = resourceInfo.data[resourceInfo.count].teamRes[teamID]

			tRes.metal_income_other = tRes.metal_income_total - tRes.metal_income_base - tRes.metal_income_overdrive - mReci
			tRes.energy_spend_other = tRes.energy_spend_total - tRes.energy_spend_construction + math.min(0, tRes.energy_share_net)
		end

		aRes.metal_income_other = aRes.metal_income_total - aRes.metal_income_base - aRes.metal_income_overdrive
		aRes.metal_spend_waste = math.min(aRes.metal_storage_free - aRes.metal_income_total - aRes.metal_spend_total,0)

		aRes.energy_spend_construction = aRes.metal_spend_construction
		aRes.energy_spend_other = aRes.energy_spend_total - (aRes.energy_spend_overdrive + aRes.energy_spend_construction + aRes.energy_spend_waste)
	end
end

local function AddAwardPoints( awardType, teamID, amount )
	if (teamID and (teamID ~= gaiaTeamID)) then
		awardData[awardType][teamID] = awardData[awardType][teamID] + (amount or 0)
	end
end

local function AddFeatureReclaim(featureID)
	local featureData = reclaimListByFeature[featureID]
	local metal = featureData.metal
	featureData.metal = nil

	for team, part in pairs(featureData) do
		if (part < 0) then --more metal was reclaimed from feature than spent on repairing it (during resurrecting)
			if metal then
				AddAwardPoints( 'reclaim', team, - metal * part )
			end
		end
	end
end

local function FinalizeReclaimList()
	for featureID, _ in pairs(reclaimListByFeature) do
		AddFeatureReclaim(featureID)
	end
	reclaimListByFeature = {}
end

local function ProcessAwardData()

	for awardType, data in pairs(awardData) do
		local winningTeam
		local maxVal
		local easyFactor = awardEasyFactors[awardType] or 1
		local absolute = awardAbsolutes[awardType]
		local message

		if awardType == 'vet' then
			maxVal = expUnitExp
			winningTeam = expUnitTeam
		elseif awardType == 'friend' then

			maxVal = 0
			for team,dmg in pairs(data) do

				--local totalDamage = dmg+damageList[team]
				local totalDamage = dmg + awardData.pwn[team]
				local damageRatio = totalDamage>0 and dmg/totalDamage or 0

				if damageRatio > maxVal then
					winningTeam = team
					maxVal = damageRatio
				end
			end

		else
			winningTeam, maxVal = getMaxVal(data)

		end

		if winningTeam then

			local compare
			if absolute then
				compare = absolute

			else
				compare = getMeanDamageExcept(winningTeam) * easyFactor
			end

			--if reclaimTeam and maxReclaim > getMeanMetalIncome() * minReclaimRatio then
			if maxVal > compare then
				maxVal = floor(maxVal)
				maxValWrite = comma_value(maxVal)

				if awardType == 'cap' then
					message = 'Captured value: ' .. maxValWrite
				elseif awardType == 'share' then
					message = 'Shared value: ' .. maxValWrite
				elseif awardType == 'terra' then
					message = 'Terraform: ' .. maxValWrite
				elseif awardType == 'rezz' then
					message = 'Resurrected value: ' .. maxValWrite
				elseif awardType == 'fire' then
					message = 'Burnt value: ' .. maxValWrite
				elseif awardType == 'emp' then
					message = 'Stunned value: ' .. maxValWrite
				elseif awardType == 'slow' then
					message = 'Slowed value: ' .. maxValWrite
				elseif awardType == 'ouch' then
					message = 'Damage received: ' .. maxValWrite
				elseif awardType == 'reclaim' then
					message = 'Reclaimed value: ' .. maxValWrite
				elseif awardType == 'friend' then
					message = 'Damage inflicted on allies: '.. floor(maxVal * 100) ..'%'
				elseif awardType == 'mex' then
					message = 'Mexes built: '.. maxVal
				elseif awardType == 'mexkill' then
					message = 'Mexes destroyed: '.. maxVal
				elseif awardType == 'head' then
					message = maxVal .. ' Commanders eliminated'
				elseif awardType == 'dragon' then
					message = maxVal .. ' White Dragons annihilated'
				elseif awardType == 'heart' then
					local maxQueenKillDamage = maxVal - absolute --remove the queen kill signature: +1000000000 from the total damage
					message = 'Damage: '.. comma_value(maxQueenKillDamage)
				elseif awardType == 'sweeper' then
					message = maxVal .. ' Nests wiped out'

				elseif awardType == 'vet' then
					local vetName = UnitDefs[expUnitDefID] and UnitDefs[expUnitDefID].humanName
					local expUnitExpRounded = ''..floor(expUnitExp * 10)
					expUnitExpRounded = expUnitExpRounded:sub(1,-2) .. '.' .. expUnitExpRounded:sub(-1)
					message = vetName ..', '.. expUnitExpRounded ..' XP'
				else
					message = 'Damaged value: '.. maxValWrite
				end
			end
		end --if winningTeam
		if message then
			awardAward(winningTeam, awardType, message)
		end

	end
end

-------------------
-- Callins

function gadget:Initialize()

	GG.Awards = GG.Awards or {}
	GG.Awards.AddAwardPoints = AddAwardPoints
	
	--_G.resourceInfo = resourceInfo

	local tempTeamList = Spring.GetTeamList()
	for i=1, #tempTeamList do
		local team = tempTeamList[i]
		--Spring.Echo('team', team)
		if team ~= gaiaTeamID then
			totalTeamList[team] = team
		end
	end

	--new
	for awardType, _ in pairs(awardDescs) do
		awardData[awardType] = {}
	end
	for _,team in pairs(totalTeamList) do
		awardList[team] = {}

		shareListTemp1[team] = 0
		shareListTemp2[team] = 0

		for awardType, _ in pairs(awardDescs) do
			awardData[awardType][team] = 0
		end

	end

	local boatFacs = {'factoryship', 'striderhub'}
	for _, boatFac in pairs(boatFacs) do
		local udBoatFac = UnitDefNames[boatFac]
		if udBoatFac then
			for _, boatDefID in pairs(udBoatFac.buildOptions) do
				if (UnitDefs[boatDefID].minWaterDepth > 0) then -- because striderhub
					boats[boatDefID] = true
				end
			end
		end
	end

	--[[
	local t3Facs = {'armshltx', 'corgant', }
	for _, t3Fac in pairs(t3Facs) do
		local udT3Fac = UnitDefNames[t3Fac]
		for _, t3DefID in pairs(udT3Fac.buildOptions) do
			t3Units[t3DefID] = true
		end
	end
	--]]

	for i=1,#WeaponDefs do
		local wcp = WeaponDefs[i].customParams or {}
		if (wcp.setunitsonfire) then
			flamerWeaponDefs[i] = true
		end
	end

	for i=1,#UnitDefs do
		if(UnitDefs[i].customParams.level) then comms[i] = true
	end

 end

end --Initialize

function gadget:UnitTaken(unitID, unitDefID, oldTeam, newTeam)
	-- Units given to neutral?
	if oldTeam == gaiaTeamID or newTeam == gaiaTeamID then
		return
	end
	if not spAreTeamsAllied(oldTeam,newTeam) then
		if awardData['cap'][newTeam] then --if team exist, then:
			local ud = UnitDefs[unitDefID]
			local mCost = ud and ud.metalCost or 0
			AddAwardPoints( 'cap', newTeam, mCost )
			if (ud.customParams.commtype) then
				if (not cappedComs[unitID]) then
					cappedComs[unitID] = select(6, spGetTeamInfo(oldTeam))
				elseif (cappedComs[unitID] == select(6, spGetTeamInfo(newTeam))) then
					cappedComs[unitID] = nil
				end
			end
		end
	else -- teams are allied
		if (unitDefID ~= terraunitDefID) and shareListTemp1[oldTeam] and shareListTemp1[newTeam] then
			local ud = UnitDefs[unitDefID]
			local mCost = ud and ud.metalCost or 0

			shareListTemp1[oldTeam] = shareListTemp1[oldTeam] + mCost
			shareListTemp1[newTeam] = shareListTemp1[newTeam] - mCost

			--[[
			AddAwardPoints( 'share', oldTeam, mCost )
			AddAwardPoints( 'share', newTeam, 0-mCost )
			--]]
		end
	end
end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam, _, _, killerTeam)
	local experience = spGetUnitExperience(unitID)
	if experience > expUnitExp then
		expUnitExp = experience
		expUnitTeam = unitTeam
		expUnitDefID = unitDefID
	end

	if (cappedComs[unitID]) then
		cappedComs[unitID] = nil
		if (unitTeam ~= gaiaTeamID) then
			AddAwardPoints( 'head', unitTeam, 1 )
		end
		return
	end

	if (killerTeam == unitTeam) or (killerTeam == gaiaTeamID) or (unitTeam == gaiaTeamID) or (killerTeam == nil) then
		return
	elseif (unitDefID == mexDefID) then
		if ((not spIsGameOver()) and (select(5, spGetUnitHealth(unitID)) > 0.9) and (not spAreTeamsAllied(killerTeam, unitTeam))) then
			AddAwardPoints( 'mexkill', killerTeam, 1 )
		end
	else
		local ud = UnitDefs[unitDefID]
		if (ud.customParams.commtype and (not spAreTeamsAllied(killerTeam, unitTeam))) then
			AddAwardPoints( 'head', killerTeam, 1 )
		elseif ud.name == "chicken_dragon" then
			AddAwardPoints( 'dragon', killerTeam, 1 )
		elseif ud.name == "chickenflyerqueen" or ud.name == "chickenlandqueen" then
			for killerFrienz, _ in pairs(awardData['heart']) do --give +1000000000 points for all frienz that kill queen and won
				AddAwardPoints( 'heart', killerFrienz, awardAbsolutes['heart']) --the extra points is for id purpose. Will deduct later
			end
		elseif ud.name == "roost" then
			AddAwardPoints( 'sweeper', killerTeam, 1 )
		else
			--
		end
	end
end

function gadget:AllowFeatureBuildStep(builderID, builderTeam, featureID, featureDefID, part)
	if builderTeam == gaiaTeamID then
		return true
	end
	reclaimListByFeature[featureID] = reclaimListByFeature[featureID] or { metal = FeatureDefs[featureDefID].metal }
	reclaimListByFeature[featureID][builderTeam] = (reclaimListByFeature[featureID][builderTeam] or 0) + part
	return true
end

function gadget:FeatureDestroyed (featureID, allyTeam)
	if (reclaimListByFeature[featureID]) then
		AddFeatureReclaim(featureID)
		reclaimListByFeature[featureID] = nil
	end
end

function gadget:UnitDamaged(unitID, unitDefID, unitTeam, fullDamage, paralyzer, weaponID,
		attackerID, attackerDefID, attackerTeam)
	if (not attackerTeam)
		or (attackerTeam == unitTeam)
		or (attackerTeam == gaiaTeamID)
		or (unitTeam == gaiaTeamID)
		then return end

	local hp = spGetUnitHealth(unitID)
	local damage = (hp > 0) and fullDamage or fullDamage + hp
	local ud = UnitDefs[unitDefID]
	local costdamage = (damage / ud.health) * ud.metalCost

	if spAreTeamsAllied(attackerTeam, unitTeam) then
		if not paralyzer then
			AddAwardPoints( 'friend', attackerTeam, costdamage )
		end
	else
		if paralyzer then
			AddAwardPoints( 'emp', attackerTeam, costdamage )
		else
			if ud.name == "chickenflyerqueen" or ud.name == "chickenlandqueen" then
				AddAwardPoints( 'heart', attackerTeam, damage )
			end
			AddAwardPoints( 'pwn', attackerTeam, costdamage )
			AddAwardPoints( 'ouch', unitTeam, damage )
			local ad = UnitDefs[attackerDefID]

			if (flamerWeaponDefs[weaponID]) then
				AddAwardPoints( 'fire', attackerTeam, costdamage )
			end

			-- Static Weapons
			if (not ad.canMove) then

				-- bignukes, zenith, starlight
				if staticO_big[ad.name] then
					AddAwardPoints( 'nux', attackerTeam, costdamage )

				-- not lrpc, tacnuke, emp missile
				elseif not staticO_small[ad.name] then
					AddAwardPoints( 'shell', attackerTeam, costdamage )
				end

			elseif kamikaze[ad.name] then
				AddAwardPoints( 'kam', attackerTeam, costdamage )

			elseif ad.canFly then
				AddAwardPoints( 'air', attackerTeam, costdamage )

			elseif boats[attackerDefID] then
				AddAwardPoints( 'navy', attackerTeam, costdamage )

			elseif t3Units[attackerDefID] then
				AddAwardPoints( 't3', attackerTeam, costdamage )

			elseif comms[attackerDefID] then
				AddAwardPoints( 'comm', attackerTeam, costdamage )

			end
		end
	end
end

function gadget:UnitFinished(unitID, unitDefID, teamID)
	if unitDefID == mexDefID then
		AddAwardPoints( 'mex', teamID, 1 )
	end
end

function gadget:GameFrame(n)

	--if n%TEAM_SLOWUPDATE_RATE == 2 then
	--	UpdateResourceStats((n-2)/TEAM_SLOWUPDATE_RATE)
	--end

	if n % shareList_update == 1 and not spIsGameOver() then
		UpdateShareList()
	end

	if TESTMODE then
		local frame32 = (n) % 32
		if (frame32 < 0.1) then
			sentAwards = false
		end
		awardAward(0, 'rezz', '12 super rezz go')
		awardAward(0, 'pwn', '100000 damage!')
		awardAward(0, 'ouch', '3400000 damage ouch!')
		awardAward(0, 'navy', '3400000 damage ouch!')
		awardAward(0, 'air', '3400000 damage ouch!')
		awardAward(0, 'nux', '3400000 damage ouch!')
		awardAward(0, 'kam', '3400000 damage ouch!')
		
		awardAward(1, 'mex', '20 mexes built super')

	else
		if not spIsGameOver() then return end
	end

	if not sentAwards then
		local units = spGetAllUnits()
		for i=1,#units do
			local unitID = units[i]
			local teamID = spGetUnitTeam(unitID)
			local unitDefID = spGetUnitDefID(unitID)
			gadget:UnitDestroyed(unitID, unitDefID, teamID)
		end

		FinalizeReclaimList()

		--new
		ProcessAwardData()

		--test values
		if TESTMODE then
			local testteam = 0

		--]]
		end

		_G.awardList = awardList
		sentAwards = true
	end
end --GameFrame

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
else -- UNSYNCED
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

local spSendCommands  = Spring.SendCommands

local gameOver = false
local sentToPlanetWars = false

local teamNames     = {}
local awardList

function gadget:Initialize()
	local tempTeamList = Spring.GetTeamList()
	for i=1, #tempTeamList do
		local team = tempTeamList[i]
		--Spring.Echo('team', team)
		if team ~= gaiaTeamID then
			totalTeamList[team] = team
		end
	end

	for _,team in pairs(totalTeamList) do
		local _, leaderPlayerID, _, isAI = spGetTeamInfo(team)
		local name
		if isAI then
			local _, aiName, _, shortName = Spring.GetAIInfo(team)
			name = aiName ..' ('.. shortName .. ')'
		else
			name = Spring.GetPlayerInfo(leaderPlayerID)
		end
		teamNames[team] = name
	end
	--spSendCommands({'endgraph 0'})
	if TESTMODE then
		gadget:GameOver()
	end
end

local function SendEconomyDataToWidget()

	if (Script.LuaUI('WriteResourceStatsToFile')) then
		Spring.Echo("Awards: Writing resource data to widget")
		local resourceInfo = SYNCED.resourceInfo
		local count = resourceInfo.count
		local data = resourceInfo.data
		local reallyBigString = ""

		for i = 1, count do
			if data[i] then
				local toSend = data[i].t .. " "
				for allyTeamID, allyData in spairs(data[i].allyRes) do
					toSend = toSend .. " " .. allyTeamID .. " " ..
					allyData.metal_income_total .. " " ..
					allyData.metal_income_base .. " " ..
					allyData.metal_income_overdrive .. " " ..
					allyData.metal_income_other .. " " ..

					allyData.metal_spend_total .. " " ..
					allyData.metal_spend_construction .. " " ..
					allyData.metal_spend_waste .. " " ..

					allyData.metal_storage_current .. " " ..
					allyData.metal_storage_free .. " " ..

					allyData.energy_income_total .. " " ..

					allyData.energy_spend_total .. " " ..
					allyData.energy_spend_overdrive .. " " ..
					allyData.energy_spend_construction .. " " ..
					allyData.energy_spend_other .. " " ..
					allyData.energy_spend_waste .. " " ..

					allyData.energy_storage_current
				end
				--Spring.SendCommands("wbynum 255 SPRINGIE: allyResourceData " .. toSend)
				reallyBigString = reallyBigString .. toSend .. "\n"

				toSend = data[i].t .. " "

				for teamID, teamData in spairs(data[i].teamRes) do
					toSend = toSend .. " " .. teamID .. " " ..
					teamData.metal_income_total .. " " ..
					teamData.metal_income_base .. " " ..
					teamData.metal_income_overdrive .. " " ..
					teamData.metal_income_other .. " " ..

					teamData.metal_spend_total .. " " ..
					teamData.metal_spend_construction .. " " ..

					teamData.metal_share_net .. " " ..

					teamData.metal_storage_current .. " " ..

					teamData.energy_income_total .. " " ..

					teamData.energy_spend_total .. " " ..
					teamData.energy_spend_construction .. " " ..
					teamData.energy_spend_other .. " " ..

					teamData.energy_share_net .. " " ..

					teamData.energy_storage_current
				end

				reallyBigString = reallyBigString .. toSend .. "\n"
			end
		end

		Script.LuaUI.WriteResourceStatsToFile(reallyBigString, teamNames)
	end

end

function gadget:GameOver()
	gameOver = true
	--Spring.Echo("Game over (awards unsynced)")
		
	--// Resources
	--SendEconomyDataToWidget()
end

-- function to convert SYNCED table to regular table. assumes no self referential loops
local function ConvertToRegularTable(stable)
	local ret = {}
	local stableLocal = stable
	for k,v in spairs(stableLocal) do
		if type(v) == 'table' then
			v = ConvertToRegularTable(v)
		end
		ret[k] = v
	end
	return ret
end

function gadget:Update()
	if not gameOver then
		return
	end
	if (not awardList) and SYNCED.awardList then
		awardList = ConvertToRegularTable( SYNCED.awardList )
		Script.LuaUI.SetAwardList( awardList )
	end
	if awardList and not sentToPlanetWars then
		for team,awards in pairs(awardList) do
			for awardType, record in pairs(awards) do
				local planetWarsData = (teamNames[team] or "no_name") ..' '.. awardType ..' '.. awardDescs[awardType] ..', '.. record
				Spring.SendCommands("wbynum 255 SPRINGIE:award,".. planetWarsData)
				--Spring.Echo(planetWarsData)
			end
		end
		sentToPlanetWars = true
	end
end

--unsynced
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
end
