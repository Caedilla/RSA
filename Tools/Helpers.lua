local RSA = RSA or LibStub('AceAddon-3.0'):GetAddon('RSA')

function RSA.AnnouncementCheck() -- Checks against user settings to see if we are allowed to announce.
	local InInstance, InstanceType = IsInInstance()
	local LFParty = IsInGroup(LE_PARTY_CATEGORY_INSTANCE) -- party group found through group finder
	local LFRaid = IsInRaid(LE_PARTY_CATEGORY_INSTANCE) -- raid grounp found through group finder
	if RSA.db.profile.General.GlobalAnnouncements.OnlyInCombat and not InCombatLockdown() then return false end -- If we're not in combat and only announce in combat, stop right here.
	if RSA.db.profile.General.GlobalAnnouncements.InWarMode and C_PvP.IsWarModeActive() and InstanceType == "none" and not LFParty and not LFRaid then return true end -- Enable in World PvP.
	if RSA.db.profile.General.GlobalAnnouncements.Arena and InstanceType == "arena" then return true end
	if RSA.db.profile.General.GlobalAnnouncements.Battlegrounds and LFRaid and (InstanceType == "pvp" or InstanceType == "none") then return true end
	if RSA.db.profile.General.GlobalAnnouncements.InDungeon and InstanceType == "party" and not LFParty then return true end
	if RSA.db.profile.General.GlobalAnnouncements.InRaid and InstanceType == "raid" and not LFRaid then return true end
	if RSA.db.profile.General.GlobalAnnouncements.InScenario and InstanceType == "scenario" == true then return true end
	if RSA.db.profile.General.GlobalAnnouncements.InLFG_Party and (InstanceType == "party" and LFParty) then return true end
	if RSA.db.profile.General.GlobalAnnouncements.InLFG_Raid and (InstanceType == "raid" and LFRaid) then return true end
	if RSA.db.profile.General.GlobalAnnouncements.InWorld and InstanceType == "none" and not LFParty and not LFRaid and not C_PvP.IsWarModeActive() then return true end -- Enable in World PvE.
	return false
end

function RSA.GetMyRandomNumber()
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

function RSA.PrepareDataTables(dataTable)
	-- Ensure barebones config data is properly populated and also reverse link all spellIDs used in a profile to that profile
	-- so that the Monitor can easily check if a spellID is used in a profile, rather than having to iterate through each profile's event data.
	-- Why not store the profile in this manner by default? It's more human readable to have everything needed for a spell to function within
	--one table, rather than having multiple references to the profile in separate event tables as RSA used to do.

	local spellToProfile = {}

	for i = 1, #dataTable do
		spellToProfile[dataTable[i].spellID] = dataTable[i].profile
		if not dataTable[i].environments then
			dataTable[i].environments = {
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
		end
		for k, v in pairs(dataTable[i].events) do
			table.insert(dataTable[i].configDisplay.messageAreas, k)
		end
		for j = 1, #dataTable[i].events do
			spellToProfile[dataTable[i].events[j].uniqueSpellID] = spellToProfile[i].profile

			if not dataTable[i].events[j].channels then
				dataTable[i].events[j].channels = {}
			end
			if not dataTable[i].events[j].tags then
				dataTable[i].events[j].tags = {}
			end
		end
	end

	return dataTable, spellToProfile
end