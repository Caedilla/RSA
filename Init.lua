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
		},
	}

	return defaults
end

function RSA:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("RSADB", BuildDefaults, uClass) -- Setup Saved Variables
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
	RSA:TempOptions()

	-- Profile Management
	self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")

	RSA.Comm.Registry()
end