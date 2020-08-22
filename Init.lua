local RSA = RSA or LibStub('AceAddon-3.0'):GetAddon('RSA')
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local uClass = string.lower(select(2, UnitClass('player')))

local function BuildDefaults()
	local defaults = {
		profile = {
			deathknight = RSA.spellData.deathknight,
			demonhunter = RSA.spellData.demonhunter,
			druid = RSA.spellData.druid,
			hunter = RSA.spellData.hunter,
			mage = RSA.spellData.mage,
			monk = RSA.spellData.monk,
			paladin = RSA.spellData.paladin,
			priest = RSA.spellData.priest,
			rogue = RSA.spellData.rogue,
			shaman = RSA.spellData.shaman,
			warlock = RSA.spellData.warlock,
			warrior = RSA.spellData.warrior,
			racials = RSA.spellData.racials,
			utilities = RSA.spellData.utilities,
			general = {
				globalAnnouncements = {
					--useGlobal = true, -- Implement as button in config to toggle this ON for all sub spells.
					alwaysWhisper = false, -- Allows whispers to always be sent.
					removeServerNames = true,
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
						emote = false,
						say = true,
						yell = true,
						whisper = true,
					},
					combatState = {
						inCombat = true, -- Announce only in Combat
						noCombat = false, -- Announce not in Combat
					},
				},
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

local function TempOptions()
	-- Register Various Options
	local Options = {
		type = "group",
		name = "RSA [|c5500DBBDRaeli's Spell Announcer|r] - ".."|cffFFCC00"..L["Current Version: %s"]:format("r|r|c5500DBBD"..RSA.db.global.revision).."|r",
		order = 0,
		args = {
				Open = {
					name = L["Open Configuration Panel"],
					type = "execute",
					order = 0,
					func = function()
						if not InCombatLockdown() then
							-- Ensure we don't taint the UI from 8.2 change when trying to call HideUIPanel in combat
							HideUIPanel(InterfaceOptionsFrame)
							HideUIPanel(GameMenuFrame)
							RSA:ChatCommand()
						end
					end,
				},
			},
		}
	LibStub("AceConfig-3.0"):RegisterOptionsTable("RSA_Blizz", Options) -- Register Options
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("RSA_Blizz", "RSA")
end

function RSA:ChatCommand(input)
	if not InCombatLockdown() then
		if not IsAddOnLoaded("RSA_Options") then
			local loaded, reason = LoadAddOn("RSA_Options")
			if not loaded then
				ChatFrame1:AddMessage(L["%s is disabled. If you want to configure RSA, you need to enable it."]:format("|cFFFF75B3RSA|r [|cffFFCC00Options|r]"))
			else
				LibStub("AceConfigDialog-3.0"):Open("RSA")
			end
		else
			LibStub("AceConfigDialog-3.0"):Open("RSA")
		end
	end
end

function RSA:RefreshConfig()
	RSA.db.profile = self.db.profile
end

function RSA:OnInitialize()

	-- TEMP until implemented.
	RSA.spellData.racials = {}
	RSA.spellData.utilities = {}
	RSA.monitorData.racials = {}
	RSA.monitorData.utilities = {}

	RSA.spellData.customCategories = {
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

	TempOptions()

	-- Profile Management
	self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")

	--RSA.Comm.Registry()
end