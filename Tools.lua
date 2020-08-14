local RSA = RSA or LibStub('AceAddon-3.0'):GetAddon('RSA')

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