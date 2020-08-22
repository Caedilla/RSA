local RSA = RSA or LibStub('AceAddon-3.0'):GetAddon('RSA')
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local uClass = string.lower(select(2, UnitClass('player')))



local function BuildDefaults()
	local defaults = {
		profile = {
			deathknight = RSA.SpellData.deathknight,
			demonhunter = RSA.SpellData.demonhunter,
			druid = RSA.SpellData.druid,
			hunter = RSA.SpellData.hunter,
			mage = RSA.SpellData.mage,
			monk = RSA.SpellData.monk,
			paladin = RSA.SpellData.paladin,
			priest = RSA.SpellData.priest,
			rogue = RSA.SpellData.rogue,
			shaman = RSA.SpellData.shaman,
			warlock = RSA.SpellData.warlock,
			warrior = RSA.SpellData.warrior,
			racials = RSA.SpellData.racials,
			utilities = RSA.SpellData.utilities,
			general = {
				["*"] = true,
				globalAnnouncements = {
					smartSay = true,
					smartYell = true,
					smartEmote = false,
					smartCustomChannel = true,
					arena = true,
					battlegrounds = false,
					inWarMode = false,
					inDungeon = true,
					inRaid = true,
					InLFG_Party = false,
					InLFG_Raid = false,
					InScenario = false,
					InWorld = false,
					OnlyInCombat = false,
					removeServerNames = true,
					AlwaysAllowWhispers = true,
				},
				Local = {
					["*"] = true,
				},
				globalCustomChannel = "MyCustomChannel",
				replacements = {
					target = {
						alwaysUseName = false,
						replacement = "You",
					},
					missType = {
						useGeneralReplacement = false,
						generalReplacement = "missed",
						miss = "missed",
						resist = "was resisted by",
						absorb = "was absorbed by",
						block = "was blocked by",
						deflect = "was deflected by",
						dodge = "was dodged by",
						evade = "was evaded by",
						parry = "was parried by",
						immune = "immune",
						reflect = "was reflected by",
					},
				},
			},
		},
	}

	return defaults
end

function RSA:OnInitialize()

	-- TEMP until implemented.
	RSA.SpellData.racials = {}
	RSA.SpellData.utilities = {}
	RSA.monitorData.racials = {}
	RSA.monitorData.utilities = {}

	RSA.SpellData.customCategories = {
		['General'] = {

		},
	}
	RSA.monitorData.customCategories = {
		['General'] = {

		},
	}

	local defaults = BuildDefaults()

	self.db = LibStub("AceDB-3.0"):New("RSADB", defaults, uClass) -- Setup Saved Variables
	self:SetSinkStorage(self.db.profile) -- Setup Saved Variables for LibSink

	-- project-revision
	self.db.global.version = 5.0
	self.db.global.revision = string.match(GetAddOnMetadata("RSA","Version"),"%d+") or 0
	self.db.global.releaseType = string.match(GetAddOnMetadata('RSA','Version'),'%a+',2) or 'dev'

	if not RSA.db.global.personalID then
		RSA.db.global.personalID = RSA.GetPersonalID() --RSA.GetGetMyRandomNumber()
	end

	local LibDualSpec = LibStub('LibDualSpec-1.0')
	LibDualSpec:EnhanceDatabase(self.db, "RSA")

	self:RegisterChatCommand("RSA", "ChatCommand")


	-- TODO Reimplement everything below
	--RSA:TempOptions()

	-- Profile Management
	--self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	--self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
	--self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")

	--RSA.Comm.Registry()
end