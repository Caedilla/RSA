local RSA = LibStub('AceAddon-3.0'):GetAddon('RSA')
local L = LibStub('AceLocale-3.0'):GetLocale('RSA')

local function CombatState()

	local profile = RSA.db.profile.general.globalAnnouncements.combatState
	local canAnnounce = false
	if InCombatLockdown() then
		if profile.inCombat then
			canAnnounce = true
		end
	else
		if profile.noCombat then
			canAnnounce = true
		end
	end

	return canAnnounce
end

function RSA.AnnouncementCheck() -- Checks against user settings to see if we are allowed to announce.
	if 1 == 1 then return true end
	local InstanceType = select(2, IsInInstance())
	local LFParty = IsInGroup(LE_PARTY_CATEGORY_INSTANCE) -- party group found through group finder
	local LFRaid = IsInRaid(LE_PARTY_CATEGORY_INSTANCE) -- raid grounp found through group finder

	local profile = RSA.db.profile.general.globalAnnouncements

	if not CombatState() then return false end

	if profile.warModeWorld and C_PvP.IsWarModeActive() and InstanceType == "none" and not LFParty and not LFRaid then return true end -- Enable in World PvP.
	if profile.nonWarWorld and InstanceType == "none" and not LFParty and not LFRaid and not C_PvP.IsWarModeActive() then return true end -- Enable in World PvE.
	if profile.arenas and InstanceType == "arena" then return true end
	if profile.bgs and LFRaid and (InstanceType == "pvp" or InstanceType == "none") then return true end
	if profile.dungeons and InstanceType == "party" and not LFParty then return true end
	if profile.raids and InstanceType == "raid" and not LFRaid then return true end
	if profile.scenarios and InstanceType == "scenario" == true then return true end
	if profile.lfg and (InstanceType == "party" and LFParty) then return true end
	if profile.lfr and (InstanceType == "raid" and LFRaid) then return true end

	return false
end

function RSA.GetPersonalID()
	local random = math.random(1,time())
	local namebytes = 0
	for i = 1,string.len(UnitName("player")) do
		namebytes = namebytes + string.byte(UnitName("player"),i)
	end
	random = tostring(random) .. tostring(namebytes)
	return random
end

function RSA.GetMobID(mobGUID) -- extracts the mob ID from the GUID
	--[Unit type]-0-[server ID]-[instance ID]-[zone UID]-[ID]-[Spawn UID] (Example: "Creature-0-1461-1158-1458-61146-000136DF91")
	local _, _, _, _, _, _, _, mob_id = string.find(mobGUID, "(%a+)-(%d+)-(%d+)-(%d+)-(%d+)-(%d+)-(%d+)")
	return tonumber(mob_id)
end

local bor,band = bit.bor, bit.band -- get a local reference to some bitlib functions for faster lookups
local CL_OBJECT_PLAYER_MINE = bor(COMBATLOG_OBJECT_TYPE_PLAYER,COMBATLOG_OBJECT_AFFILIATION_MINE) -- construct a bitmask for a player controlled by me
function RSA.IsMe(unitFlags)
	if unitFlags == "Me" then return true end
	if unitFlags == true then return true end
	if unitFlags == false then return false end
	if band(CL_OBJECT_PLAYER_MINE,unitFlags) == CL_OBJECT_PLAYER_MINE then
		return true
	end
end

local CL_OBJECT_FRIENDLY_PLAYER = bor(COMBATLOG_OBJECT_TYPE_PLAYER,COMBATLOG_OBJECT_REACTION_FRIENDLY) -- construct a friendly player bitmask
function RSA.Whisperable(destFlags) -- Checks if the unit is a player or not. Since RSA can announce casts for any unit, not just units that fall under UnitID.

	--When we send a fake event through the announcement monitor, ingnore flags.
	if destFlags == true then return true end
	if destFlags == false then return false end

	if band(CL_OBJECT_FRIENDLY_PLAYER,destFlags) == CL_OBJECT_FRIENDLY_PLAYER and not RSA.IsMe(destFlags) then -- check if players in vehicle need special handling
		return true
	end
end

function RSA.AffiliationMine(sourceFlags)
if not sourceFlags then return end
	if band(COMBATLOG_OBJECT_AFFILIATION_MINE,sourceFlags) == COMBATLOG_OBJECT_AFFILIATION_MINE then
		return true
	end
end

function RSA.AffiliationGroup(sourceFlags)
	if not sourceFlags then return end
	if band(COMBATLOG_OBJECT_AFFILIATION_MINE,sourceFlags) == COMBATLOG_OBJECT_AFFILIATION_MINE then
		return true
	end
	if band(COMBATLOG_OBJECT_AFFILIATION_PARTY,sourceFlags) == COMBATLOG_OBJECT_AFFILIATION_PARTY then
		return true
	end
	if band(COMBATLOG_OBJECT_AFFILIATION_RAID,sourceFlags) == COMBATLOG_OBJECT_AFFILIATION_RAID then
		return true
	end
end

function RSA.PrepareDataTables(configData)
	-- Ensure barebones config data is properly populated and also reverse link all spellIDs used in a profile to that profile
	-- so that the Monitor can easily check if a spellID is used in a profile, rather than having to iterate through each profile's event data.
	-- Why not store the profile in this manner by default? It's more human readable to have everything needed for a spell to function within
	-- one table, rather than having multiple references to the profile in separate event tables as RSA used to do.
	local monitorData = {}

	--/dump LibStub('AceAddon-3.0'):GetAddon('RSA').monitorData
	for profile in pairs(configData) do
		monitorData[configData[profile].spellID] = profile

		if configData[profile].additionalSpellIDs then -- Add the additional spell variants to the list of spellIDs for the monitor to... monitor.
			for k in pairs(configData[profile].additionalSpellIDs) do
				if configData[profile].additionalSpellIDs[k] then
					monitorData[k] = profile
				end
			end
		else
			configData[profile].additionalSpellIDs = {}
		end

		if not configData[profile].environments then
			configData[profile].environments = {
				useGlobal = true, -- This spell will use the global envrionment settings to determine where it can announce, this overrides the other values in this section.
				alwaysWhisper = false, -- Allows whispers to always be sent.
				enableIn = {
					arenas = false,
					bgs = false,
					warModeWorld = false, -- Enable in War Mode world zones.
					nonWarWorld = false, -- Enable in world zones without war mode enabled.
					dungeons = false,
					raids = false,
					lfg = false,
					lfr = false,
					scenarios = false,
				},
				groupToggles = { -- When true, only announce to these channels if you are in a group
					emote = true,
					say = true,
					yell = true,
					whisper = true,
				},
				combatState = {
					inCombat = true, -- Announce only in Combat
					noCombat = false, -- Announce not in Combat
				},
			}
		else
			local environments = {
				useGlobal = true, -- This spell will use the global envrionment settings to determine where it can announce, this overrides the other values in this section.
				alwaysWhisper = false, -- Allows whispers to always be sent.
				enableIn = {
					arenas = false,
					bgs = false,
					warModeWorld = false, -- Enable in War Mode world zones.
					nonWarWorld = false, -- Enable in world zones without war mode enabled.
					dungeons = false,
					raids = false,
					lfg = false,
					lfr = false,
					scenarios = false,
				},
				groupToggles = { -- When true, only announce to these channels if you are in a group
					emote = true,
					say = true,
					yell = true,
					whisper = true,
				},
				combatState = {
					inCombat = true, -- Announce only in Combat
					noCombat = false, -- Announce not in Combat
				},
			}
			for k in pairs(environments) do
				if not configData[profile].environments[k] then
					configData[profile].environments[k] = environments[k]
				elseif type(environments[k]) == 'table' then
					for i = 1, #configData[profile].environments[k] do
						if not configData[profile].environments[k][i] then
							configData[profile].environments[k][i] = environments[k][i]
						end
					end
				end
			end
		end

		for k in pairs(configData[profile].events) do
			if not configData[profile].configDisplay then
				configData[profile].configDisplay = {}
			end
			if not configData[profile].configDisplay.disabledChannels then
				configData[profile].configDisplay.disabledChannels = {}
			end

			if not configData[profile].configDisplay.messageAreas then
				configData[profile].configDisplay.messageAreas = {}
			end
			configData[profile].configDisplay.messageAreas[k] = k

			if monitorData[configData[profile].events[k].uniqueSpellID] then -- Add uniqueSpellID for a specific event (i.e where SPELL_CAST_SUCCESS and SPELL_HEAL use different IDs) so that they are both tracked by the monitor.
				monitorData[configData[profile].events[k].uniqueSpellID] = monitorData[profile]
			end

			if not configData[profile].events[k].channels then
				configData[profile].events[k].channels = {}
			end

			if not configData[profile].events[k].tags then
				configData[profile].events[k].tags = {}
			end

			if not configData[profile].events[k].messages then
				configData[profile].events[k].messages = {}
			end
		end

	end

	return monitorData, configData
end

function RSA.RefreshMonitorData(section)
	if RSA.monitorData[section] then
		RSA.monitorData[section] = RSA.PrepareDataTables(RSA.db.profile[section])
	else
		RSA.SendMessage.ChatFrame(L["Unexpected Data Table"])
	end
end