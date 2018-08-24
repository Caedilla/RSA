local RSA =  RSA or LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_O = RSA:NewModule("RSA_Options", "LibSink-2.0")
local _, PlayerClass = UnitClass('player')

--[[
local function CommunityLists()
	local Communities = C_Club.GetSubscribedClubs()
	local CommunityNames = {}
	for i = 1,#Communities do
		CommunityNames[i] = Communities[i].name
		print(CommunityNames[i])
	end
	return CommunityNames
end

local Communities = C_Club.GetSubscribedClubs()
local CommunityData = {}

local ListNames = {}
local ListChannels = {}

for i = 1,#Communities do
	Communities[i].channels = C_Club.GetStreams(Communities[i].clubId)
	ListNames[i] = Communities[i].name
end

for j = 1,#Communities[3].channels do
	ListChannels[j] = Communities[3].channels[j].name
end

RSAC = Communities
RSAL = ListNames
RSAM = ListChannels
]]--



local Options = {
	type = "group",
	name = "RSA [|c5500DBBDRaeli's Spell Announcer|r]",
	order = 0,
	args = {
		General = {
			name = L["General"],
			type = "group",
			order = 0,
			args = {
				Module_Settings = {
					name = L["Module Settings"],
					type = "header",					
					order = 0,
					hidden = true,
				},
				Buff_Reminders = {
					hidden = true,
					name = "|cff00CCFF" .. L["Enable Buff Reminder Module"] .. "|r",
					type = "toggle",
					order = 5,
					width = "full",
					descStyle = "inline",
					get = function(info)
						return RSA.db.profile.Modules.Reminders
					end,
					set = function(info, value)
						RSA.db.profile.Modules.Reminders = value
						if value == false and (LoadAddOn("RSA_Reminders") == 1) then
							RSA:DisableModule("Reminders")
						elseif value == true then
							local loaded, reason = LoadAddOn("RSA_Reminders")
							if not loaded then
								if reason == "DISABLED" or reason == "INTERFACE_VERSION" then
									ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Reminders " .. L.OptionsDisabled)
								elseif reason == "MISSING" or reason == "CORRUPT" then
									ChatFrame1:AddMessage("|cFFFF75B3RSA:|r Reminders " .. L.OptionsMissing)
								end
							else
								RSA:EnableModule("Reminders")
							end
						end
					end,
				},
				Smart_Channel_Options = {
					name = "|cffCF374D"..L["Smart Channel Options"].."|r",
					type = "group",
					inline = true,
					order = 100.2,
					args = {
						Smart_Say = {
							name = "|cffCF374D"..L["Smart Say"].."|r",
							type = "toggle",
							order = 0,
							desc = L["Only announce in /yell while you are in a manually formed group."],
							descStyle = "inline",
							width = "double",
							get = function(info)
								return RSA.db.profile.General.GlobalAnnouncements.SmartSay
							end,
							set = function (info, value)
								RSA.db.profile.General.GlobalAnnouncements.SmartSay = value
							end,
						},
						Smart_Yell = {
							name = "|cffCF374D"..L["Smart Yell"].."|r",
							type = "toggle",
							order = 0,
							desc = L["Only announce in /say while you are in a manually formed group."],
							descStyle = "inline",
							width = "double",
							get = function(info)
								return RSA.db.profile.General.GlobalAnnouncements.SmartYell
							end,
							set = function (info, value)
								RSA.db.profile.General.GlobalAnnouncements.SmartYell = value
							end,
						},
						Smart_Custom_Channel = {
							name = "|cffCF374D"..L["Smart Custom Channel"].."|r",
							type = "toggle",
							order = 1,
							desc = L["Announce to custom channels only while you are in a manually formed group."],
							descStyle = "inline",
							width = "double",
							get = function(info)
								return RSA.db.profile.General.GlobalAnnouncements.SmartCustomChannel
							end,
							set = function(info, value)
								RSA.db.profile.General.GlobalAnnouncements.SmartCustomChannel = value
							end,
						},
					},
				},
				PvP_Options = {
					name = "|cffFF8019"..L["PvP Options"].."|r",
					type = "group",
					inline = true,
					order = 100.3,
					args = {
						Enable_In_Arenas = {
							name = "|cffFF8019"..L["Enable in Arenas"].."|r",
							type = "toggle",
							order = 0,
							width = "double",
							get = function(info)
								return RSA.db.profile.General.GlobalAnnouncements.Arena
							end,
							set = function(info, value)
								RSA.db.profile.General.GlobalAnnouncements.Arena = value
							end,
						},
						Enable_In_Battlegrounds = {
							name = "|cffFF8019"..L["Enable in Battlegrounds"].."|r",
							type = "toggle",
							order = 0,
							width = "double",
							get = function(info)
								return RSA.db.profile.General.GlobalAnnouncements.Battlegrounds
							end,
							set = function(info, value)
								RSA.db.profile.General.GlobalAnnouncements.Battlegrounds = value
							end,
						},
						Enable_In_War_Mode = {
							name = "|cffFF8019"..L["Enable in War Mode"].."|r",
							type = "toggle",
							order = 1,
							desc = L["Enable in the world area if you have War Mode active."],
							descStyle = "inline",
							width = "double",
							get = function(info)
								return RSA.db.profile.General.GlobalAnnouncements.InWarMode
							end,
							set = function(info, value)
								RSA.db.profile.General.GlobalAnnouncements.InWarMode = value
							end,
						},
					},
				},
				PvE_Options = {
					name = "|cff91BE0F"..L["PvE Options"].."|r",
					type = "group",
					inline = true,
					order = 100.4,
					args = {
						Enable_In_Dungeons = {
							name = "|cff91BE0F"..L["Enable in Dungeons"].."|r",
							type = "toggle",
							order = 0,
							desc = L["Enable in manually formed dungeon groups."],
							descStyle = "inline",
							width = "double",
							get = function(info)
								return RSA.db.profile.General.GlobalAnnouncements.InDungeon
							end,
							set = function(info, value)
								RSA.db.profile.General.GlobalAnnouncements.InDungeon = value
							end,
						},
						Enable_In_Raids = {
							name = "|cff91BE0F"..L["Enable in Raid Instances"].."|r",
							type = "toggle",
							order = 0,					
							desc = L["Enable in manually formed raid groups."],
							descStyle = "inline",
							width = "double",
							get = function(info)
								return RSA.db.profile.General.GlobalAnnouncements.InRaid
							end,
							set = function(info, value)
								RSA.db.profile.General.GlobalAnnouncements.InRaid = value
							end,
						},
						Enable_In_Group_Finder_Dungeons = {
							name = "|cff91BE0F"..L["Enable in Group Finder Dungeons"].."|r",
							type = "toggle",
							order = 1,
							width = "double",		
							get = function(info)
								return RSA.db.profile.General.GlobalAnnouncements.InLFG_Party
							end,
							set = function(info, value)
								RSA.db.profile.General.GlobalAnnouncements.InLFG_Party = value
							end,
						},
						Enable_In_Group_Finder_Raids = {
							name = "|cff91BE0F"..L["Enable in Group Finder Raids"].."|r",
							type = "toggle",
							order = 1,
							width = "double",		
							get = function(info)
								return RSA.db.profile.General.GlobalAnnouncements.InLFG_Raid
							end,
							set = function(info, value)
								RSA.db.profile.General.GlobalAnnouncements.InLFG_Raid = value
							end,
						},
						Enable_In_Scenarios = {
							name = "|cff91BE0F"..L["Enable in Scenarios"].."|r",
							type = "toggle",
							order = 2,
							desc = L["Enable in scenario instances."],
							descStyle = "inline",
							width = "double",					
							get = function(info)
								return RSA.db.profile.General.GlobalAnnouncements.InScenario
							end,
							set = function(info, value)
								RSA.db.profile.General.GlobalAnnouncements.InScenario = value
							end,
						},
						Enable_In_World = {
							name = "|cff91BE0F"..L["Enable in the World"].."|r",
							type = "toggle",
							order = 2,
							desc = L["Enable in the world area when playing with War Mode disabled."],
							descStyle = "inline",
							width = "double",
							get = function(info)
								return RSA.db.profile.General.GlobalAnnouncements.InWorld
							end,
							set = function(info, value)
								RSA.db.profile.General.GlobalAnnouncements.InWorld = value
							end,
						},
					},
				},
				Other_Options = {
					name = "|cffFFCC00"..L["Other Options"].."|r",
					type = "group",
					inline = true,
					order = 100.5,
					args = {
						Enable_Only_In_Combat = {
							name = "|cffFFCC00"..L["Enable Only in Combat"].."|r",
							type = "toggle",
							order = 110,
							desc = L["Only announce if you are in combat."],
							descStyle = "inline",
							width = "double",
							get = function(info)
								return RSA.db.profile.General.GlobalAnnouncements.OnlyInCombat
							end,
							set = function(info, value)
								RSA.db.profile.General.GlobalAnnouncements.OnlyInCombat = value
							end,
						},
						Remove_Server_Names = {
							name = "|cffFFCC00"..L["Remove Server Names"].."|r",
							type = "toggle",
							order = 110,
							width = "double",
							get = function(info)
								return RSA.db.profile.General.GlobalAnnouncements.RemoveServerNames
							end,
							set = function(info, value)
								RSA.db.profile.General.GlobalAnnouncements.RemoveServerNames = value
							end,
						},

					},					
				},
			},
		},
		Spells = {
			name = L["Spells"],
			type = "group",
			childGroups = "tab",
			order = 1,
			args = {
				Racials = {
					name = L["Racials"],
					type = "group",
					args = {
						Disabled_Notification = {
							name = "Coming Soon",
							type = "description",
							order = 0.02,
							fontSize = "large",
						},
					},
				},
				Utilities = {
					name = L["Utilities"],
					type = "group",
					args = {
						Disabled_Notification = {
							name = "Coming Soon",
							type = "description",
							order = 0.03,
							fontSize = "large",
						},
					},
				},
			},
		},
		Feedback = {
			name = L["Feedback"],
			type = "group",
			order = 1000,
			args = {
				Head = {
					name = L["Feedback"],
					type = "header",					
					order = 0,
				},
				Revision = {
					name = "|cffFFCC00"..L["Current Revision"].."|r |c5500DBBD".. RSA.db.global.revision.. "|r",
					type = "description",
					order = 0.5,
					fontSize = "large",
				},
				RevisionDescription = {
					name = L["When reporting an issue, please also post the revision number above. Thanks!"],
					type = "description",
					order = 0.6,
				},
				Spacer_FeedbackOnline = {
					name = "\n",
					type = "description",
					order = 1,
				},
				Curseforge_Header = {
					name = "|cff91BE0F"..L["Online"].."|r",
					type = "description",
					order = 50,
					fontSize = "large",
				},
				Curseforge_Description = {
					name = L["If you encounter a bug, or have a feature request, please file a ticket on Curseforge using the link below."],
					type = "description",
					order = 50.1,
				},
				Curseforge_URL = {
					name = L["RSA on Curseforge"],
					type = "input",
					order = 50.2,
					width = "full",
					get = function() return "https://wow.curseforge.com/projects/rsa/issues" end,
					set = function() return "https://wow.curseforge.com/projects/rsa/issues" end,
				},
				Spacer_OnlineCommunity = {
					name = "\n\n\n\n",
					type = "description",
					order = 75,
				},
				Community_Header = {
					name = "|cff00B2FA"..L["In Game"].."|r",
					type = "description",
					order = 100,
					fontSize = "large",
				},
				Community_Description = {
					name = L["I have a Battle.net community for my addons. If you have any issues, now you can easily report them to me in game. Just copy the invite link below and throw me a message."],
					type = "description",
					order = 100.1,
				},
				Community_URL = {
					name = L["Invite Link"],
					type = "input",
					order = 100.2,
					width = "full",
					get = function() return "https://blizzard.com/invite/WqRG7EUgOR" end,
					set = function() return "https://blizzard.com/invite/WqRG7EUgOR" end,
				},
			},
		},
		--[[CommunityTest = {
			name = "TEST",
			type = "group",
			args = {
				List = {
					name = "List of Communities",
					type = "select",
					values = ListNames,
				},
				Channels ={
					name = "Channels",
					type = "select",
					values = ListChannels,
				},
			},
		},]]--
	},
}

local function DeathKnight_Options()
	local Spells = {
		[1] = {
			Profile = "Army",
			Name = GetSpellInfo(42650),
			Desc = GetSpellDescription(42650),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[2] = {
			Profile = "AMS",
			Name = GetSpellInfo(48707),
			Desc = GetSpellDescription(48707),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[3] = {
			Profile = "AMZ",
			Name = GetSpellInfo(51052),
			Desc = GetSpellDescription(51052),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[4] = {
			Profile = "DarkCommand",
			Name = GetSpellInfo(56222),
			Desc = GetSpellDescription(56222),
			Message_Amount = 3,
			Message_Areas = {"Cast", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[MISSTYPE]"},
		},
		[5] = {
			Profile = "IceboundFortitude",
			Name = GetSpellInfo(48792),
			Desc = GetSpellDescription(48792),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[6] = {
			Profile = "Strangulate",
			Name = GetSpellInfo(47476),
			Desc = GetSpellDescription(47476),
			Message_Amount = 4,
			Message_Areas = {"Start", "End", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[MISSTYPE]"},
		},
		[7] = {
			Profile = "Asphyxiate",
			Name = GetSpellInfo(108194),
			Desc = GetSpellDescription(108194),
			Message_Amount = 4,
			Message_Areas = {"Start", "End", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[MISSTYPE]"},
		},
		[8] = {
			Profile = "MindFreeze",
			Name = GetSpellInfo(47528),
			Desc = GetSpellDescription(47528),
			Message_Amount = 3,
			Message_Areas = {"Interrupt", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[TARSPELL]", "[TARLINK]", "[MISSTYPE]"},
		},
		[9] = {
			Profile = "DeathGrip",
			Name = GetSpellInfo(49576),
			Desc = GetSpellDescription(49576),
			Message_Amount = 3,
			Message_Areas = {"Cast", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[MISSTYPE]"},
		},
		[10] = {
			Profile = "VampiricBlood",
			Name = GetSpellInfo(55233),
			Desc = GetSpellDescription(55233),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[11] = {
			Profile = "RuneTap",
			Name = GetSpellInfo(194679),
			Desc = GetSpellDescription(194679),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[12] = {
			Profile = "DancingRuneWeapon",
			Name = GetSpellInfo(81256),
			Desc = GetSpellDescription(81256),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[13] = {
			Profile = "RaiseAlly",
			Name = GetSpellInfo(61999),
			Desc = GetSpellDescription(61999),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[14] = {
			Profile = "PillarOfFrost",
			Name = GetSpellInfo(51271),
			Desc = GetSpellDescription(51271),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[15] = {
			Profile = "Purgatory",
			Name = GetSpellInfo(114556),
			Desc = GetSpellDescription(114556),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
	}
	return Spells
end

local function DemonHunter_Options()
	local Spells = {
		[1] = {
			Profile = "SpectralSight",
			Name = GetSpellInfo(188501),
			Desc = GetSpellDescription(188501),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[2] = {
			Profile = "Disrupt",
			Name = GetSpellInfo(183752),
			Desc = GetSpellDescription(183752),
			Message_Amount = 3,
			Message_Areas = {"Interrupt", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[TARSPELL]", "[TARLINK]", "[MISSTYPE]"},
		},
		[3] = {
			Profile = "Blur",
			Name = GetSpellInfo(212800),
			Desc = GetSpellDescription(212800),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[4] = {
			Profile = "Netherwalk",
			Name = GetSpellInfo(196555),
			Desc = GetSpellDescription(196555),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[5] = {
			Profile = "LastResort",
			Name = GetSpellInfo(209261),
			Desc = GetSpellDescription(209258),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[6] = {
			Profile = "MetamorphosisTank",
			Name = GetSpellInfo(187827)..": "..TANK,
			Desc = GetSpellDescription(187827),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[7] = {
			Profile = "MetamorphosisDD",
			Name = GetSpellInfo(191427)..": "..COMBATLOG_HIGHLIGHT_DAMAGE,
			Desc = GetSpellDescription(191427),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[8] = {
			Profile = "FieryBrand",
			Name = GetSpellInfo(207744),
			Desc = GetSpellDescription(207744),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[9] = {
			Profile = "SigilOfChains",
			Name = GetSpellInfo(202138),
			Desc = GetSpellDescription(202138),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[10] = {
			Profile = "SigilOfMisery",
			Name = GetSpellInfo(207684),
			Desc = GetSpellDescription(207684),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[11] = {
			Profile = "SigilOfSilence",
			Name = GetSpellInfo(202137),
			Desc = GetSpellDescription(202137),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[12] = {
			Profile = "Torment",
			Name = GetSpellInfo(185245),
			Desc = GetSpellDescription(185245),
			Message_Amount = 3,
			Message_Areas = {"Cast", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[MISSTYPE]"},
		},
		[13] = {
			Profile = "ChaosNova",
			Name = GetSpellInfo(179057),
			Desc = GetSpellDescription(179057),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[14] = {
			Profile = "Darkness",
			Name = GetSpellInfo(196718),
			Desc = GetSpellDescription(196718),
			Message_Amount = 1,
			Message_Areas = {"Start"},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[15] = {
			Profile = "Consume", -- Consume Magic
			Name = GetSpellInfo(278326),
			Desc = GetSpellDescription(278326),
			Message_Amount = 2,
			Message_Areas = {"Dispel", "Resist"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[AURA]", "[AURALINK]"},
		},
	}
	return Spells
end

local function Druid_Options()
	local Spells = {
		[1] = {
			Profile = "SurvivalInstincts",
			Name = GetSpellInfo(61336),
			Desc = GetSpellDescription(61336),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[2] = {
			Profile = "Cyclone",
			Name = GetSpellInfo(33786),
			Desc = GetSpellDescription(33786),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[3] = {
			Profile = "IncapacitatingRoar",
			Name = GetSpellInfo(99),
			Desc = GetSpellDescription(99),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[4] = {
			Profile = "FrenziedRegeneration",
			Name = GetSpellInfo(22842),
			Desc = GetSpellDescription(22842),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[5] = {
			Profile = "UrsolsVortex",
			Name = GetSpellInfo(102793),
			Desc = GetSpellDescription(102793),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[6] = {
			Profile = "Ironbark",
			Name = GetSpellInfo(102342),
			Desc = GetSpellDescription(102342),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[7] = {
			Profile = "SkullBash",
			Name = GetSpellInfo(93985),
			Desc = GetSpellDescription(93985),
			Message_Amount = 3,
			Message_Areas = {"Interrupt", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[TARSPELL]", "[TARLINK]", "[MISSTYPE]"},
		},
		[8] = {
			Profile = "Growl",
			Name = GetSpellInfo(6795),
			Desc = GetSpellDescription(6795),
			Message_Amount = 3,
			Message_Areas = {"Cast", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[MISSTYPE]"},
		},
		[9] = {
			Profile = "Revive",
			Name = GetSpellInfo(50769),
			Desc = GetSpellDescription(50769),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[10] = {
			Profile = "Rebirth",
			Name = GetSpellInfo(20484),
			Desc = GetSpellDescription(20484),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[11] = {
			Profile = "TreeOfLife",
			Name = GetSpellInfo(33891),
			Desc = GetSpellDescription(33891),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[12] = {
			Profile = "Barkskin",
			Name = GetSpellInfo(22812),
			Desc = GetSpellDescription(22812),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[13] = {
			Profile = "MightyBash",
			Name = GetSpellInfo(5211),
			Desc = GetSpellDescription(5211),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[13] = {
			Profile = "Tranquility",
			Name = GetSpellInfo(740),
			Desc = GetSpellDescription(740),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[14] = {
			Profile = "NaturesVigil",
			Name = GetSpellInfo(124974),
			Desc = GetSpellDescription(124974),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[15] = {
			Profile = "Berserk",
			Name = GetSpellInfo(106951),
			Desc = GetSpellDescription(106951),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[16] = {
			Profile = "RemoveCorruption",
			Name = GetSpellInfo(2782) .. " / " .. GetSpellInfo(88423),
			Desc = GetSpellDescription(2782),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[AURA]", "[AURALINK]"},
		},
		[17] = {
			Profile = "Roots",
			Name = GetSpellInfo(339),
			Desc = GetSpellDescription(339),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[18] = {
			Profile = "StampedingRoar",
			Name = GetSpellInfo(106898),
			Desc = GetSpellDescription(106898),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[19] = {
			Profile = "SolarBeam",
			Name = GetSpellInfo(97547),
			Desc = GetSpellDescription(97547),
			Message_Amount = 1,
			Message_Areas = {"Interrupt"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[TARSPELL]", "[TARLINK]"},
		},
		[20] = {
			Profile = "Revitalize",
			Name = GetSpellInfo(212040),
			Desc = GetSpellDescription(212040),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[21] = {
			Profile = "Innervate",
			Name = GetSpellInfo(29166),
			Desc = GetSpellDescription(29166),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[22] = {
			Profile = "Ironfur",
			Name = GetSpellInfo(192081),
			Desc = GetSpellDescription(192081),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[23] = {
			Profile = "DemoralizingRoar",
			Name = GetSpellInfo(201664),
			Desc = GetSpellDescription(201664),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[24] = {
			Profile = "Soothe",
			Name = GetSpellInfo(2908),
			Desc = GetSpellDescription(2908),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[AURA]", "[AURALINK]"},
		},
		[25] = {
			Profile = "MassEntanglement",
			Name = GetSpellInfo(102359),
			Desc = GetSpellDescription(102359),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
	}
	return Spells
end

local function Hunter_Options()
	local Spells = {
		[1] = {
			Profile = "Misdirection",
			Name = GetSpellInfo(34477),
			Desc = GetSpellDescription(34477),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]","[AMOUNT]"},
		},
		[2] = {
			Profile = "ConcussiveShot",
			Name = GetSpellInfo(5116),
			Desc = GetSpellDescription(5116),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[3] = {
			Profile = "Intimidation",
			Name = GetSpellInfo(24394),
			Desc = GetSpellDescription(24394),
			Message_Amount = 3,
			Message_Areas = {"Start", "Cast", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[4] = {
			Profile = "FreezingTrap",
			Name = GetSpellInfo(3355),
			Desc = GetSpellDescription(3355),
			Message_Amount = 3,
			Message_Areas = {"Placed", "Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[5] = {
			Profile = "SilencingShot", -- Counter Shot
			Name = GetSpellInfo(147362),
			Desc = GetSpellDescription(147362),
			Message_Amount = 3,
			Message_Areas = {"Interrupt", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[TARSPELL]", "[TARLINK]", "[MISSTYPE]"},
		},
		[6] = {
			Profile = "Deterrence",
			Name = GetSpellInfo(186265),
			Desc = GetSpellDescription(186265),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[7] = {
			Profile = "Camoflage",
			Name = GetSpellInfo(199483),
			Desc = GetSpellDescription(199483),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[8] = {
			Profile = "RoarOfSacrifice",
			Name = GetSpellInfo(53480),
			Desc = GetSpellDescription(53480),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[9] = {
			Profile = "Muzzle",
			Name = GetSpellInfo(187707),
			Desc = GetSpellDescription(187707),
			Message_Amount = 3,
			Message_Areas = {"Interrupt", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[TARSPELL]", "[TARLINK]", "[MISSTYPE]"},
		},
		[10] = {
			Profile = "BindingShot",
			Name = GetSpellInfo(109248),
			Desc = GetSpellDescription(109248),
			Message_Amount = 3,
			Message_Areas = {"Placed", "Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[11] = {
			Profile = "Tranq",
			Name = L["Pet Dispels"],
			Desc = GetSpellDescription(264263),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[AURA]", "[AURALINK]"},
		},
	}
	return Spells
end

local function Mage_Options()
	local Spells = {
		[1] = {
			Profile = "TimeWarp",
			Name = GetSpellInfo(80353),
			Desc = GetSpellDescription(80353),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[2] = {
			Profile = "Spellsteal",
			Name = GetSpellInfo(30449),
			Desc = GetSpellDescription(30449),
			Message_Amount = 3,
			Message_Areas = {"Cast", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[AURA]", "[AURALINK]", "[MISSTYPE]"},
		},
		[3] = {
			Profile = "Polymorph",
			Name = GetSpellInfo(118),
			Desc = GetSpellDescription(118),
			Message_Amount = 4,
			Message_Areas = {"Start", "End", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[MISSTYPE]"},
		},
		[4] = {
			Profile = "Counterspell",
			Name = GetSpellInfo(2139),
			Desc = GetSpellDescription(2139),
			Message_Amount = 3,
			Message_Areas = {"Interrupt", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[TARSPELL]", "[TARLINK]", "[MISSTYPE]"},
		},
		[5] = {
			Profile = "Portals",
			Name = GetSpellInfo(109400),
			Desc = GetSpellDescription(11419),
			Message_Amount = 1,
			Message_Areas = {"Start"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[6] = {
			Profile = "Teleport",
			Name = GetSpellInfo(223199),
			Desc = GetSpellDescription(3563),
			Message_Amount = 1,
			Message_Areas = {"Start"},
			Message_Channels_Disabled = {["Whisper"] = true, ["Custom"] = true, ["Raid"] = true, ["Party"] = true, ["SmartGroup"] = true, ["Say"] = true, ["Yell"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[7] = {
			Profile = "RefreshmentTable",
			Name = GetSpellInfo(190336),
			Desc = GetSpellDescription(190336),
			Message_Amount = 1,
			Message_Areas = {"Start"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[8] = {
			Profile = "RingOfFrost",
			Name = GetSpellInfo(113724),
			Desc = GetSpellDescription(113724),
			Message_Amount = 1,
			Message_Areas = {"Cast", "Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[9] = {
			Profile = "Cauterize",
			Name = GetSpellInfo(87023),
			Desc = GetSpellDescription(87023),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[10] = {
			Profile = "IceBlock",
			Name = GetSpellInfo(45438),
			Desc = GetSpellDescription(45438),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[10] = {
			Profile = "SlowFall",
			Name = GetSpellInfo(130),
			Desc = GetSpellDescription(130),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
	}
	return Spells
end

local function Monk_Options()
	local Spells = {
		[1] = {
			Profile = "ZenMeditation",
			Name = GetSpellInfo(115176),
			Desc = GetSpellDescription(115176),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[2] = {
			Profile = "Provoke",
			Name = GetSpellInfo(116189),
			Desc = GetSpellDescription(116189),
			Message_Amount = 4,
			Message_Areas = {"Cast", "Resist", "Immune", "StatueOfTheBlackOx"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[MISSTYPE]"},
		},
		[3] = {
			Profile = "FortifyingBrew",
			Name = GetSpellInfo(120954),
			Desc = GetSpellDescription(120954),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},		
		[4] = {
			Profile = "SpearHandStrike",
			Name = GetSpellInfo(116705),
			Desc = GetSpellDescription(116705),
			Message_Amount = 3,
			Message_Areas = {"Interrupt", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[TARSPELL]", "[TARLINK]", "[MISSTYPE]"},
		},
		[5] = {
			Profile = "Paralysis",
			Name = GetSpellInfo(115078),
			Desc = GetSpellDescription(115078),
			Message_Amount = 4,
			Message_Areas = {"Start", "End", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[MISSTYPE]"},
		},
		[6] = {
			Profile = "Guard",
			Name = GetSpellInfo(202162),
			Desc = GetSpellDescription(202162),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[7] = {
			Profile = "ElusiveBrew",
			Name = GetSpellInfo(115308),
			Desc = GetSpellDescription(115308),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[8] = {
			Profile = "PurifyingBrew",
			Name = GetSpellInfo(119582),
			Desc = GetSpellDescription(119582),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[9] = {
			Profile = "DampenHarm",
			Name = GetSpellInfo(122278),
			Desc = GetSpellDescription(122278),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[10] = {
			Profile = "LifeCocoon",
			Name = GetSpellInfo(116849),
			Desc = GetSpellDescription(116849),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[11] = {
			Profile = "RingOfPeace",
			Name = GetSpellInfo(116844),
			Desc = GetSpellDescription(116844),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[12] = {
			Profile = "DiffuseMagic",
			Name = GetSpellInfo(122783),
			Desc = GetSpellDescription(122783),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[13] = {
			Profile = "TouchOfKarma",
			Name = GetSpellInfo(122470),
			Desc = GetSpellDescription(122470),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[14] = {
			Profile = "Detox",
			Name = GetSpellInfo(115450),
			Desc = GetSpellDescription(115450),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[AURA]", "[AURALINK]"},
		},
		[15] = {
			Profile = "Resuscitate",
			Name = GetSpellInfo(115178),
			Desc = GetSpellDescription(115178),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
			Requirements = {"LRI"},
		},
		[16] = {
			Profile = "Revival",
			Name = GetSpellInfo(115310),
			Desc = GetSpellDescription(115310),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[17] = {
			Profile = "Reawaken",
			Name = GetSpellInfo(212051),
			Desc = GetSpellDescription(212051),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[18] = {
			Profile = "LegSweep",
			Name = GetSpellInfo(119381),
			Desc = GetSpellDescription(119381),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
	}
	return Spells
end

local function Paladin_Options()
	local Spells = {
		[1] = {
			Profile = "ArdentDefender",
			Name = GetSpellInfo(31850),
			Desc = GetSpellDescription(31850),
			Message_Amount = 3,
			Message_Areas = {"Start", "End", "Heal"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[AMOUNT]"},
		},
		[2] = {
			Profile = "HandOfFreedom",
			Name = GetSpellInfo(1044),
			Desc = GetSpellDescription(1044),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[3] = {
			Profile = "Forbearance",
			Name = GetSpellInfo(25771),
			Desc = GetSpellDescription(25771),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true, ["Custom"] = true, ["Raid"] = true, ["Party"] = true, ["SmartGroup"] = true, ["Say"] = true, ["Yell"] = true, ["Emote"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[4] = {
			Profile = "DevotionAura",
			Name = GetSpellInfo(31821),
			Desc = GetSpellDescription(31821),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[5] = {
			Profile = "DivineProtection",
			Name = GetSpellInfo(498),
			Desc = GetSpellDescription(498),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[6] = {
			Profile = "HandOfProtection",
			Name = GetSpellInfo(204018) .. " / " .. GetSpellInfo(74234), -- Too long to fit in game, 74234 is a spell called Protection. Should translate well enough.
			Desc = GetSpellDescription(1022),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[7] = {
			Profile = "HandOfSacrifice",
			Name = GetSpellInfo(6940),
			Desc = GetSpellDescription(6940),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[8] = {
			Profile = "BlessingOfSanctuary",
			Name = GetSpellInfo(210256),
			Desc = GetSpellDescription(210256),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[9] = {
			Profile = "ForgottenQueen",
			Name = GetSpellInfo(228049),
			Desc = GetSpellDescription(228049),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[10] = {
			Profile = "LayOnHands",
			Name = GetSpellInfo(633),
			Desc = GetSpellDescription(633),
			Message_Amount = 1,
			Message_Areas = {"Heal"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[AMOUNT]"},
		},
		[11] = {
			Profile = "GoAK",
			Name = GetSpellInfo(86659),
			Desc = GetSpellDescription(86659),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[12] = {
			Profile = "HolyAvenger",
			Name = GetSpellInfo(105809),
			Desc = GetSpellDescription(105809),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[13] = {
			Profile = "Repentance",
			Name = GetSpellInfo(20066),
			Desc = GetSpellDescription(20066),
			Message_Amount = 3,
			Message_Areas = {"Start", "End", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[MISSTYPE]"},
		},
		[14] = {
			Profile = "Rebuke",
			Name = GetSpellInfo(96231),
			Desc = GetSpellDescription(96231),
			Message_Amount = 3,
			Message_Areas = {"Interrupt", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[TARSPELL]", "[TARLINK]", "[MISSTYPE]"},
		},
		[15] = {
			Profile = "HandOfReckoning",
			Name = GetSpellInfo(62124),
			Desc = GetSpellDescription(62124),
			Message_Amount = 3,
			Message_Areas = {"Cast", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[MISSTYPE]"},
		},
		[16] = {
			Profile = "Beacon",
			Name = GetSpellInfo(53563),
			Desc = GetSpellDescription(53563),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[17] = {
			Profile = "Redemption",
			Name = GetSpellInfo(7328),
			Desc = GetSpellDescription(7328),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
			Requirements = {"LRI"},
		},
		[18] = {
			Profile = "AvengersShield",
			Name = GetSpellInfo(31935),
			Desc = GetSpellDescription(31935),
			Message_Amount = 3,
			Message_Areas = {"Interrupt", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[TARSPELL]", "[TARLINK]", "[MISSTYPE]"},
		},
		[19] = {
			Profile = "HammerOfJustice",
			Name = GetSpellInfo(853),
			Desc = GetSpellDescription(853),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[20] = {
			Profile = "Cleanse",
			Name = GetSpellInfo(4987) .. " / " .. GetSpellInfo(213644),
			Desc = GetSpellDescription(4987),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[AURA]", "[AURALINK]"},
		},
		[21] = {
			Profile = "DivineShield",
			Name = GetSpellInfo(642),
			Desc = GetSpellDescription(642),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[22] = {
			Profile = "AvengingWrath",
			Name = GetSpellInfo(31884),
			Desc = GetSpellDescription(31884),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[23] = {
			Profile = "ShieldOfVengeance",
			Name = GetSpellInfo(184662),
			Desc = GetSpellDescription(184662),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[24] = {
			Profile = "FinalStand",
			Name = GetSpellInfo(204077),
			Desc = GetSpellDescription(204077),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[25] = {
			Profile = "Absolution",
			Name = GetSpellInfo(212056),
			Desc = GetSpellDescription(212056),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[26] = {
			Profile = "AegisOfLight",
			Name = GetSpellInfo(204150),
			Desc = GetSpellDescription(204150),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[27] = {
			Profile = "EyeForAnEye",
			Name = GetSpellInfo(205191),
			Desc = GetSpellDescription(205191),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
	}
	return Spells
end

local function Priest_Options()
	local Spells = {
		[1] = {
			Profile = "MassDispel",
			Name = GetSpellInfo(32375),
			Desc = GetSpellDescription(32375),
			Message_Amount = 2,
			Message_Areas = {"Start", "Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[2] = {
			Profile = "VampiricEmbrace",
			Name = GetSpellInfo(15286),
			Desc = GetSpellDescription(15286),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[3] = {
			Profile = "LeapOfFaith",
			Name = GetSpellInfo(73325),
			Desc = GetSpellDescription(73325),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[4] = {
			Profile = "DivineHymn",
			Name = GetSpellInfo(64843),
			Desc = GetSpellDescription(64843),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[5] = {
			Profile = "Levitate",
			Name = GetSpellInfo(1706),
			Desc = GetSpellDescription(1706),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[6] = {
			Profile = "ShackleUndead",
			Name = GetSpellInfo(9484),
			Desc = GetSpellDescription(9484),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[7] = {
			Profile = "DispelMagic",
			Name = GetSpellInfo(528),
			Desc = GetSpellDescription(528),
			Message_Amount = 2,
			Message_Areas = {"Cast", "Resist"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[AURA]", "[AURALINK]"},
		},
		[8] = {
			Profile = "Purify",
			Name = GetSpellInfo(527),
			Desc = GetSpellDescription(527),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[AURA]", "[AURALINK]"},
		},
		[9] = {
			Profile = "GuardianSpirit",
			Name = GetSpellInfo(47788),
			Desc = GetSpellDescription(47788),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[10] = {
			Profile = "PainSuppression",
			Name = GetSpellInfo(33206),
			Desc = GetSpellDescription(33206),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[11] = {
			Profile = "PowerWordBarrier",
			Name = GetSpellInfo(62618),
			Desc = GetSpellDescription(62618),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[12] = {
			Profile = "Resurrection",
			Name = GetSpellInfo(2006),
			Desc = GetSpellDescription(2006),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
			Requirements = {"LRI"},
		},
		[13] = {
			Profile = "MassRess",
			Name = GetSpellInfo(212036),
			Desc = GetSpellDescription(212036),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[14] = {
			Profile = "Fade",
			Name = GetSpellInfo(586),
			Desc = GetSpellDescription(586),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[15] = {
			Profile = "PsychicScream",
			Name = GetSpellInfo(8122),
			Desc = GetSpellDescription(8122),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[16] = {
			Profile = "MindBomb",
			Name = GetSpellInfo(205369),
			Desc = GetSpellDescription(205369),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[17] = {
			Profile = "MindControl",
			Name = GetSpellInfo(605),
			Desc = GetSpellDescription(605),
			Message_Amount = 2,
			Message_Areas = {"Cast", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[18] = {
			Profile = "Silence",
			Name = GetSpellInfo(15487),
			Desc = GetSpellDescription(15487),
			Message_Amount = 3,
			Message_Areas = {"Interrupt", "Cast", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[TARSPELL]", "[TARLINK]"},
		},
		[19] = {
			Profile = "BodyAndSoul",
			Name = GetSpellInfo(65081),
			Desc = GetSpellDescription(65081),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[20] = {
			Profile = "Shadowfiend",
			Name = GetSpellInfo(34433),
			Desc = GetSpellDescription(34433),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[21] = {
			Profile = "SymbolOfHope",
			Name = GetSpellInfo(64901),
			Desc = GetSpellDescription(64901),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[22] = {
			Profile = "PsychicHorror",
			Name = GetSpellInfo(64044),
			Desc = GetSpellDescription(64044),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
	}
	return Spells
end

local function Rogue_Options()
	local Spells = {
		[1] = {
			Profile = "Sap",
			Name = GetSpellInfo(6770),
			Desc = GetSpellDescription(6770),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[2] = {
			Profile = "Blind",
			Name = GetSpellInfo(2094) .. " / " .. GetSpellInfo(199743),
			Desc = GetSpellDescription(2094),
			Message_Amount = 4,
			Message_Areas = {"Start", "End", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[MISSTYPE]"},
		},
		[3] = {
			Profile = "Kick",
			Name = GetSpellInfo(1766),
			Desc = GetSpellDescription(1766),
			Message_Amount = 3,
			Message_Areas = {"Interrupt", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[TARSPELL]", "[TARLINK]", "[MISSTYPE]"},
		},
		[4] = {
			Profile = "Tricks",
			Name = GetSpellInfo(57934),
			Desc = GetSpellDescription(57934),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[5] = {
			Profile = "SmokeBomb",
			Name = GetSpellInfo(76577),
			Desc = GetSpellDescription(76577),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[6] = {
			Profile = "Shroud",
			Name = GetSpellInfo(115834),
			Desc = GetSpellDescription(115834),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[7] = {
			Profile = "CloakOfShadows",
			Name = GetSpellInfo(31224),
			Desc = GetSpellDescription(31224),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		
	}
	return Spells
end

local function Shaman_Options()
	local Spells = {
		[1] = {
			Profile = "Hex",
			Name = GetSpellInfo(51514),
			Desc = GetSpellDescription(51514),
			Message_Amount = 3,
			Message_Areas = {"Start", "End", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[MISSTYPE]"},
		},
		[2] = {
			Profile = "Heroism",
			Name = GetSpellInfo(2825),
			Desc = GetSpellDescription(2825),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[3] = {
			Profile = "WindShear",
			Name = GetSpellInfo(57994),
			Desc = GetSpellDescription(57994),
			Message_Amount = 3,
			Message_Areas = {"Interrupt", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[TARSPELL]", "[TARLINK]", "[MISSTYPE]"},
		},
		[4] = {
			Profile = "Purge",
			Name = GetSpellInfo(370),
			Desc = GetSpellDescription(370),
			Message_Amount = 2,
			Message_Areas = {"Dispel", "Resist"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[AURA]", "[AURALINK]"},
		},
		[5] = {
			Profile = "CleanseSpirit",
			Name = GetSpellInfo(4987) .. " / " .. GetSpellInfo(77130),
			Desc = GetSpellDescription(77130),
			Message_Amount = 1,
			Message_Areas = {"Dispel"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[AURA]", "[AURALINK]"},
		},
		[6] = {
			Profile = "HealingTide",
			Name = GetSpellInfo(108280),
			Desc = GetSpellDescription(108280),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[7] = {
			Profile = "EarthElemental",
			Name = GetSpellInfo(198103),
			Desc = GetSpellDescription(198103),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[8] = {
			Profile = "FireElemental",
			Name = GetSpellInfo(198067),
			Desc = GetSpellDescription(198067),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[9] = {
			Profile = "AncestralSpirit",
			Name = GetSpellInfo(2008),
			Desc = GetSpellDescription(2008),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
			Requirements = {"LRI"},
		},
		[10] = {
			Profile = "SpiritLink",
			Name = GetSpellInfo(98008),
			Desc = GetSpellDescription(98008),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[11] = {
			Profile = "TremorTotem",
			Name = GetSpellInfo(8143),
			Desc = GetSpellDescription(8143),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[12] = {
			Profile = "Thunderstorm",
			Name = GetSpellInfo(51490),
			Desc = GetSpellDescription(51490),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[13] = {
			Profile = "FeralSpirit",
			Name = GetSpellInfo(51533),
			Desc = GetSpellDescription(51533),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[14] = {
			Profile = "Reincarnation",
			Name = GetSpellInfo(21169),
			Desc = GetSpellDescription(21169),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[15] = {
			Profile = "AncestralGuidance",
			Name = GetSpellInfo(108281),
			Desc = GetSpellDescription(108281),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[16] = {
			Profile = "AstralShift",
			Name = GetSpellInfo(108271),
			Desc = GetSpellDescription(108271),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[17] = {
			Profile = "WindRushTotem",
			Name = GetSpellInfo(192077),
			Desc = GetSpellDescription(192077),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[18] = {
			Profile = "Ascendance",
			Name = GetSpellInfo(114050),
			Desc = GetSpellDescription(114050),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[19] = {
			Profile = "AncestralVision",
			Name = GetSpellInfo(212048),
			Desc = GetSpellDescription(212048),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[20] = {
			Profile = "AncestralProtection",
			Name = GetSpellInfo(207399),
			Desc = GetSpellDescription(207399),
			Message_Amount = 3,
			Message_Areas = {"Start", "Cast", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[21] = {
			Profile = "LightningSurge", -- Capacitor Totem
			Name = GetSpellInfo(192058),
			Desc = GetSpellDescription(192058),
			Message_Amount = 3,
			Message_Areas = {"Start", "Cast", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[22] = {
			Profile = "Cloudburst",
			Name = GetSpellInfo(157153),
			Desc = GetSpellDescription(157153),
			Message_Amount = 3,
			Message_Areas = {"Start", "End", "Heal"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[AMOUNT]"},
		},
		[23] = {
			Profile = "EarthenShieldTotem",
			Name = GetSpellInfo(198838),
			Desc = GetSpellDescription(198838),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
	}
	return Spells
end

local function Warlock_Options()
	local Spells = {
		[1] = {
			Profile = "SoulWell",
			Name = GetSpellInfo(29893),
			Desc = GetSpellDescription(29893),
			Message_Amount = 1,
			Message_Areas = {"Start"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[2] = {
			Profile = "SummonStone",
			Name = GetSpellInfo(698),
			Desc = GetSpellDescription(698),
			Message_Amount = 1,
			Message_Areas = {"Start"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[3] = {
			Profile = "Suffering",
			Name = GetSpellInfo(17735),
			Desc = GetSpellDescription(17735),
			Message_Amount = 3,
			Message_Areas = {"Cast", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[MISSTYPE]"},
		},
		[4] = {
			Profile = "SingeMagic",
			Name = GetSpellInfo(89808),
			Desc = GetSpellDescription(89808),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[AURA]", "[AURALINK]"},
		},
		[5] = {
			Profile = "Banish",
			Name = GetSpellInfo(710),
			Desc = GetSpellDescription(710),
			Message_Amount = 4,
			Message_Areas = {"Cast", "End", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[MISSTYPE]"},
		},
		[6] = {
			Profile = "Fear",
			Name = GetSpellInfo(5782),
			Desc = GetSpellDescription(5782),
			Message_Amount = 4,
			Message_Areas = {"Cast", "End", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[MISSTYPE]"},
		},
		[7] = {
			Profile = "Seduce",
			Name = GetSpellInfo(6358),
			Desc = GetSpellDescription(6358),
			Message_Amount = 4,
			Message_Areas = {"Cast", "End", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[MISSTYPE]"},
		},
		[8] = {
			Profile = "SpellLock",
			Name = GetSpellInfo(19647),
			Desc = GetSpellDescription(19647),
			Message_Amount = 3,
			Message_Areas = {"Interrupt", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[TARSPELL]", "[TARLINK]", "[MISSTYPE]"},
		},
		[9] = {
			Profile = "Soulstone",
			Name = GetSpellInfo(20707),
			Desc = GetSpellDescription(20707),
			Message_Amount = 2,
			Message_Areas = {"Start", "Cast"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[10] = {
			Profile = "DeathCoil",
			Name = GetSpellInfo(6789),
			Desc = GetSpellDescription(6789),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[11] = {
			Profile = "Shadowfury",
			Name = GetSpellInfo(30283),
			Desc = GetSpellDescription(30283),
			Message_Amount = 3,
			Message_Areas = {"Start", "Cast", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[12] = {
			Profile = "UnendingResolve",
			Name = GetSpellInfo(104773),
			Desc = GetSpellDescription(104773),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[13] = {
			Profile = "Gateway",
			Name = GetSpellInfo(111771),
			Desc = GetSpellDescription(111771),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[14] = {
			Profile = "DarkPact",
			Name = GetSpellInfo(108416),
			Desc = GetSpellDescription(108416),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
	}
	return Spells
end

local function Warrior_Options()
	local Spells = {
		[1] = {
			Profile = "ShieldWall",
			Name = GetSpellInfo(871),
			Desc = GetSpellDescription(871),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[2] = {
			Profile = "Pummel",
			Name = GetSpellInfo(6552),
			Desc = GetSpellDescription(6552),
			Message_Amount = 3,
			Message_Areas = {"Interrupt", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[TARSPELL]", "[TARLINK]", "[MISSTYPE]"},
		},
		[3] = {
			Profile = "DemoralizingShout",
			Name = GetSpellInfo(1160),
			Desc = GetSpellDescription(1160),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[4] = {
			Profile = "Taunt",
			Name = GetSpellInfo(355),
			Desc = GetSpellDescription(355),
			Message_Amount = 3,
			Message_Areas = {"Cast", "Resist", "Immune"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]", "[MISSTYPE]"},
		},
		[5] = {
			Profile = "LastStand",
			Name = GetSpellInfo(12975),
			Desc = GetSpellDescription(12975),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[6] = {
			Profile = "EnragedRegeneration",
			Name = GetSpellInfo(184364),
			Desc = GetSpellDescription(184364),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[7] = {
			Profile = "SpellReflect",
			Name = GetSpellInfo(23920),
			Desc = GetSpellDescription(23920),
			Message_Amount = 3,
			Message_Areas = {"Damage", "Debuff", "Resist"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]","[TARGET]","[AMOUNT]"},
		},
		[8] = {
			Profile = "Recklessness",
			Name = GetSpellInfo(1719),
			Desc = GetSpellDescription(1719),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[9] = {
			Profile = "RallyingCry",
			Name = GetSpellInfo(97463),
			Desc = GetSpellDescription(97463),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[10] = {
			Profile = "Intercept",
			Name = GetSpellInfo(198758),
			Desc = GetSpellDescription(198758),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[11] = {
			Profile = "DieByTheSword",
			Name = GetSpellInfo(118038),
			Desc = GetSpellDescription(118038),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[12] = {
			Profile = "StormBolt",
			Name = GetSpellInfo(107570),
			Desc = GetSpellDescription(107570),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[13] = {
			Profile = "MassSpellReflection",
			Name = GetSpellInfo(213915),
			Desc = GetSpellDescription(213915),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[14] = {
			Profile = "IntimidatingShout",
			Name = GetSpellInfo(5246),
			Desc = GetSpellDescription(5246),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
	}
	return Spells
end

local function Racial_Options()
	local Spells = {
		[1] = {
			Profile = "EMFH",
			Name = GetSpellInfo(59752),
			Desc = GetSpellDescription(59752),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[2] = {
			Profile = "Stoneform",
			Name = GetSpellInfo(20594),
			Desc = GetSpellDescription(20594),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[3] = {
			Profile = "Shadowmeld",
			Name = GetSpellInfo(58984),
			Desc = GetSpellDescription(58984),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[4] = {
			Profile = "EscapeArtist",
			Name = GetSpellInfo(20589),
			Desc = GetSpellDescription(20589),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[5] = {
			Profile = "GOTN",
			Name = GetSpellInfo(28880),
			Desc = GetSpellDescription(28880),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[6] = {
			Profile = "Darkflight",
			Name = GetSpellInfo(68992),
			Desc = GetSpellDescription(68992),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]",},
		},
		[7] = {
			Profile = "BloodFury",
			Name = GetSpellInfo(33697),
			Desc = GetSpellDescription(33697),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[8] = {
			Profile = "WOTF",
			Name = GetSpellInfo(7744),
			Desc = GetSpellDescription(7744),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[9] = {
			Profile = "WarStomp",
			Name = GetSpellInfo(20549),
			Desc = GetSpellDescription(20549),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[10] = {
			Profile = "Berserking",
			Name = GetSpellInfo(26297),
			Desc = GetSpellDescription(26297),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[11] = {
			Profile = "ArcaneTorrent",
			Name = GetSpellInfo(155145),
			Desc = GetSpellDescription(155145),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[12] = {
			Profile = "RocketJump",
			Name = GetSpellInfo(69070),
			Desc = GetSpellDescription(69070),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[13] = {
			Profile = "SpacialRift",
			Name = GetSpellInfo(256948),
			Desc = GetSpellDescription(256948),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[14] = {
			Profile = "FireBlood",
			Name = GetSpellInfo(265221),
			Desc = GetSpellDescription(265221),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[15] = {
			Profile = "ArcanePulse",
			Name = GetSpellInfo(260364),
			Desc = GetSpellDescription(260364),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]", "[TARGET]"},
		},
		[16] = {
			Profile = "BullRush",
			Name = GetSpellInfo(255654),
			Desc = GetSpellDescription(255654),
			Message_Amount = 1,
			Message_Areas = {"Cast"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
		[17] = {
			Profile = "AncestralCall",
			Name = GetSpellInfo(274738),
			Desc = GetSpellDescription(274738),
			Message_Amount = 2,
			Message_Areas = {"Start", "End"},
			Message_Channels_Disabled = {["Whisper"] = true},
			Valid_Tags = {"[SPELL]", "[LINK]"},
		},
	}
	return Spells
end

function RSA:FixDB()
	local Profiles = {
		[1] = "DeathKnight",
		[2] = "DemonHunter",
		[3] = "Druid",
		[4] = "Hunter",
		[5] = "Mage",
		[6] = "Monk",
		[7] = "Paladin",
		[8] = "Priest",
		[9] = "Rogue",
		[10] = "Shaman",
		[11] = "Warlock",
		[12] = "Warrior",
	}
	local Functions = {
		[1] = DeathKnight_Options(),
		[2] = DemonHunter_Options(),
		[3] = Druid_Options(),
		[4] = Hunter_Options(),
		[5] = Mage_Options(),
		[6] = Monk_Options(),
		[7] = Paladin_Options(),
		[8] = Priest_Options(),
		[9] = Rogue_Options(),
		[10] = Shaman_Options(),
		[11] = Warlock_Options(),
		[12] = Warrior_Options(),
	}
	for c = 1,#Profiles do
		local Spells = Functions[c]
		local ProfileName = Profiles[c]
		for i = 1,#Spells do
			for k=1,Spells[i].Message_Amount do 
				if type(RSA.db.profile[ProfileName].Spells [Spells[i].Profile].Messages[Spells[i].Message_Areas[k]]) == "string" then
					if not RSA.db.profile.Fixed then RSA.Print_Self("Fixing Database") end
					RSA.db.profile[ProfileName].Spells [Spells[i].Profile].Messages[Spells[i].Message_Areas[k]] = {RSA.db.profile[ProfileName].Spells [Spells[i].Profile].Messages[Spells[i].Message_Areas[k]]}
				end
			end
		end
	end
	RSA.db.profile.Fixed = true
end

local function Spell_Options(NonClass)
	local Spells, ProfileName
	local OptionName = L["Class Abilities"]
	if NonClass then
		if NonClass == "Racials" then
			Spells = Racial_Options()
			ProfileName = "Racials"
			OptionName = L["Racials"]
		end
	elseif PlayerClass == "DEATHKNIGHT" then
		Spells = DeathKnight_Options()
		ProfileName = "DeathKnight"
	elseif PlayerClass == "DEMONHUNTER" then
		Spells = DemonHunter_Options()
		ProfileName = "DemonHunter"
	elseif PlayerClass == "DRUID" then
		Spells = Druid_Options()
		ProfileName = "Druid"
	elseif PlayerClass == "HUNTER" then
		Spells = Hunter_Options()
		ProfileName = "Hunter"
	elseif PlayerClass == "MAGE" then
		Spells = Mage_Options()
		ProfileName = "Mage"
	elseif PlayerClass == "MONK" then
		Spells = Monk_Options()
		ProfileName = "Monk"
	elseif PlayerClass == "PALADIN" then
		Spells = Paladin_Options()
		ProfileName = "Paladin"
	elseif PlayerClass == "PRIEST" then
		Spells = Priest_Options()
		ProfileName = "Priest"
	elseif PlayerClass == "ROGUE" then
		Spells = Rogue_Options()
		ProfileName = "Rogue"
	elseif PlayerClass == "SHAMAN" then
		Spells = Shaman_Options()
		ProfileName = "Shaman"
	elseif PlayerClass == "WARLOCK" then
		Spells = Warlock_Options()
		ProfileName = "Warlock"
	elseif PlayerClass == "WARRIOR" then
		Spells = Warrior_Options()
		ProfileName = "Warrior"
	end
	local Area_Orders = {
		[1] = "Start",
		[2] = "Placed",
		[3] = "Cast",
		[4] = "Dispel",
		[5] = "Success",
		[6] = "Damage",
		[7] = "Heal",
		[8] = "Debuff",
		[9] = "Interrupt",
		[10] = "Resist",
		[11] = "Immune",
		[12] = "End",
		[13] = "StatueOfTheBlackOx",
	}
	local Options = {
		name = OptionName,
		type = "group",
		order = 0.01,
		childGroups ="tree",
		args = {
		},
	}
	for i = 1,#Spells do
		if Spells[i] then
			Options.args[Spells[i].Profile] = {
				name = Spells[i].Name,
				desc = Spells[i].Desc,
				type = "group",
				childGroups = "tab",
				args = {
					Spell_Name = {
						name = "|c5500DBBD"..L["Configuring"]..":|r "..Spells[i].Name,
						type = "description",
						order = 0.01,
						fontSize = "large",
					},
					Spell_Desc = {
						name = "|cffFFCC00"..Spells[i].Desc.."|r",
						type = "description",
						order = 0.02,
					},
					Channel_Header = {
						name = L["Message Announce Area"],
						type = "header",
						order = 0.1,
					},
					Say = {
						name = "|cffCF374D"..L["Say"].."|r",
						type = "toggle",
						order = 0.11,
						hidden = function() if Spells[i].Message_Channels_Disabled then if Spells[i].Message_Channels_Disabled["Say"] then return true end end end,
						get = function(info)
							return RSA.db.profile[ProfileName].Spells[Spells[i].Profile].Say
						end,
						set = function (info, value)
							RSA.db.profile[ProfileName].Spells[Spells[i].Profile].Say = value
						end,
					},
					Yell = {
						name = "|cffCF374D"..L["Yell"].."|r",
						type = "toggle",
						order = 0.11,
						hidden = function() if Spells[i].Message_Channels_Disabled then if Spells[i].Message_Channels_Disabled["Yell"] then return true end end end,
						get = function(info)
							return RSA.db.profile[ProfileName].Spells[Spells[i].Profile].Yell
						end,
						set = function (info, value)
							RSA.db.profile[ProfileName].Spells[Spells[i].Profile].Yell = value
						end,
					},
					Emote = {
						name = "|cffCF374D"..L["Emote"].."|r",
						type = "toggle",
						hidden = true,
						order = 0.11,
						--hidden = function() if Spells[i].Message_Channels_Disabled then if Spells[i].Message_Channels_Disabled["Emote"] then return true end end end,
						get = function(info)
							return RSA.db.profile[ProfileName].Spells[Spells[i].Profile].Emote
						end,
						set = function (info, value)
							RSA.db.profile[ProfileName].Spells[Spells[i].Profile].Emote = value
						end,
					},
					Custom_Channel_Toggle = {
						name = "|cffCF374D"..L["Custom Channel"].."|r",
						type = "toggle",
						order = 1,
						desc = L["Send to player created channel."],
						hidden = function() if Spells[i].Message_Channels_Disabled then if Spells[i].Message_Channels_Disabled["Custom"] then return true end end end,
						get = function(info)
							return RSA.db.profile[ProfileName].Spells[Spells[i].Profile].CustomChannel.Enabled
						end,
						set = function (info, value)
							RSA.db.profile[ProfileName].Spells[Spells[i].Profile].CustomChannel.Enabled = value
						end,
					},
					Custom_Channel_Name = {
						name = "|cffCF374D"..L["Channel Name"].."|r",
						type = "input",
						order = 2,
						desc = L["Only usable for player created channels, do not use for Blizzard channels such as |cff91BE0F/party|r."],
						width = "full",
						hidden = function()
							if Spells[i].Message_Channels_Disabled then
								if Spells[i].Message_Channels_Disabled["Custom"] then 
									return true
								else
									return RSA.db.profile[ProfileName].Spells[Spells[i].Profile].CustomChannel.Enabled ~= true
								end
							else
								return RSA.db.profile[ProfileName].Spells[Spells[i].Profile].CustomChannel.Enabled ~= true
							end
						end,
						get = function(info)
							return RSA.db.profile[ProfileName].Spells[Spells[i].Profile].CustomChannel.Channel
						end,
						set = function (info, value)
							RSA.db.profile[ProfileName].Spells[Spells[i].Profile].CustomChannel.Channel = value
						end,
					},
					Raid = {
						name = "|cff91BE0F"..L["Raid"].."|r",
						type = "toggle",
						order = 4,
						desc = L["|cff91BE0F/raid|r. Only for manually formed raid groups."] .. "\n" .. L["Doesn't do anything in group finder parties, use |cffFFCC00Instance|r or |cffFFCC00Smart Group Channel|r for that."],
						hidden = function() if Spells[i].Message_Channels_Disabled then if Spells[i].Message_Channels_Disabled["Raid"] then return true end end end,
						get = function(info)
							return RSA.db.profile[ProfileName].Spells[Spells[i].Profile].Raid
						end,
						set = function (info, value)
							RSA.db.profile[ProfileName].Spells[Spells[i].Profile].Raid = value
						end,
					},
					Party = {
						name = "|cff91BE0F"..L["Party"].."|r",
						type = "toggle",
						order = 4,
						desc = L["|cff91BE0F/party|r. Only for manually formed parties."] .. "\n" .. L["Doesn't do anything in group finder parties, use |cffFFCC00Instance|r or |cffFFCC00Smart Group Channel|r for that."],
						hidden = function() if Spells[i].Message_Channels_Disabled then if Spells[i].Message_Channels_Disabled["Party"] then return true end end end,
						get = function(info)
							return RSA.db.profile[ProfileName].Spells[Spells[i].Profile].Party
						end,
						set = function (info, value)
							RSA.db.profile[ProfileName].Spells[Spells[i].Profile].Party = value
						end,
					},
					Local = {
						name = "|cff00B2FA"..L["Local"].."|r",
						type = "toggle",
						order = 5,					
						desc = L["Sends a message locally only visible to you. To choose which part of the UI this is displayed in go to the |cff00B2FALocal Message Output Area|r in the General options."],
						hidden = function() if Spells[i].Message_Channels_Disabled then if Spells[i].Message_Channels_Disabled["Local"] then return true end end end,
						get = function(info)
							return RSA.db.profile[ProfileName].Spells[Spells[i].Profile].Local
						end,
						set = function (info, value)
							RSA.db.profile[ProfileName].Spells[Spells[i].Profile].Local = value
						end,
					},
					Whisper = {
						name = "|cffFFCC00"..L["Whisper"].."|r",
						type = "toggle",
						desc = L["|cffFFCC00Whispers|r the target of the spell."] .. "\n" .. L["This setting also does not follow the global announcement settings, and will, if checked, announce regardless of those settings."],
						order = 6,
						hidden = function() if Spells[i].Message_Channels_Disabled then if Spells[i].Message_Channels_Disabled["Whisper"] then return true end end end,
						get = function(info)
							return RSA.db.profile[ProfileName].Spells[Spells[i].Profile].Whisper
						end,
						set = function (info, value)
							RSA.db.profile[ProfileName].Spells[Spells[i].Profile].Whisper = value
						end,
					},
					Smart_Group = {
						name = "|cffFFCC00"..L["Smart Group Channel"].."|r",
						type = "toggle",
						order = 7,
						desc = L["|cff91BE0F/raid|r if you're in a raid."] .. "\n" .. L["|cff91BE0F/party|r if you're in a dungeon."] .. "\n" .. L["|cff91BE0F/instance|r if you're in a group finder group."],
						hidden = function() if Spells[i].Message_Channels_Disabled then if Spells[i].Message_Channels_Disabled["SmartGroup"] then return true end end end,
						get = function(info)
							return RSA.db.profile[ProfileName].Spells[Spells[i].Profile].SmartGroup
						end,
						set = function (info, value)
							RSA.db.profile[ProfileName].Spells[Spells[i].Profile].SmartGroup = value
						end,
					},
					Message_Header = {
						name = L["Message Texts"],
						type = "header",
						order = 100,						
					},
					Message_Description = {
						name = L["The following tags are available for use with this spell:"],
						type = "description",
						order = 100.1,
						fontSize = "medium",
					},
				},
			}
		end
		
		-- Add usable tags to description.
		local TagList = ""
		for j = 1,#Spells[i].Valid_Tags do
			TagList = TagList .."\n".. "|c5500DBBD" .. Spells[i].Valid_Tags[j] .. "|r"
		end
		Options.args[Spells[i].Profile].args.Message_Description.name = L["The following tags are available for use with this spell:"] .. TagList

		-- Iterate Messages
		for k=1,Spells[i].Message_Amount do -- Order message areas logically (i.e Start message is displayed before End message)
			local OrderVal
			for n = 1,#Area_Orders do
				if Spells[i].Message_Areas[k] == Area_Orders[n] then
					OrderVal = n
				end
			end
			local Messages = {}
			for _,v in pairs(RSA.db.profile[ProfileName].Spells[Spells[i].Profile].Messages[Spells[i].Message_Areas[k]]) do
				if v ~= "" then
					table.insert(Messages,v)
				end
			end
			Options.args[Spells[i].Profile].args[Spells[i].Message_Areas[k]] = {
				name = L[Spells[i].Message_Areas[k]],
				type = "group",
				order = 110 + OrderVal,
				args = {
					Add = {
						name = L["Add New Message"],
						type = "input",
						order = 101,
						width = "full",
						set = function(info, value)
							if value == " " then return end
							table.insert(RSA.db.profile[ProfileName].Spells[Spells[i].Profile].Messages[Spells[i].Message_Areas[k]],value)
							RSA:UpdateOptions()
						end,
					},
					List_Description = {
						name = "Placeholder",
						type = "description",
						order = 101.1,
						fontSize = "medium",
					},
				},
			}
			if #Messages == 0 then
				Options.args[Spells[i].Profile].args[Spells[i].Message_Areas[k]].args.List_Description.name = "\n".. L["You have no messages for this section."]..L[" If you wish to add a message for this section, enter it above in the |cffFFD100Add New Message|r box. As no messages exist, nothing will be announced for this section."]
			elseif #Messages == 1 then
				Options.args[Spells[i].Profile].args[Spells[i].Message_Areas[k]].args.List_Description.name = "\n".. L["You have "].. #Messages ..L[" message for this section."]..L[" RSA will choose a message from this section at random, if you wish to remove a message, delete the contents and press enter. If no messages exist, nothing will be announced for this section."]
			else
				Options.args[Spells[i].Profile].args[Spells[i].Message_Areas[k]].args.List_Description.name = "\n".. L["You have "].. #Messages ..L[" messages for this section."]..L[" RSA will choose a message from this section at random, if you wish to remove a message, delete the contents and press enter. If no messages exist, nothing will be announced for this section."]
			end


			if Spells[i].Requirements then
				for r=1,#Spells[i].Requirements do
					if Spells[i].Requirements[r] == "LRI" and k == 2 then -- k == 2 means it's the second message. The second message for resses in RSA is always the end message.
					local LRI = LibStub("LibResInfo-1.0",true)
					if not LRI then
						Options.args[Spells[i].Profile].args[Spells[i].Message_Areas[k]].args.List_Description.name = L["This section requires LibResInfo-1.0 to work. As you don't have it, nothing from this section will announce."]
					end
					end
				end
			end



			for l=1,#Messages do
				Options.args[Spells[i].Profile].args[Spells[i].Message_Areas[k]].args[tostring(l)] = {
					type = "input",
					width = "full",
					name = tostring(l),
					order = 110,
					get = function(info)
						if RSA.db.profile[ProfileName].Spells[Spells[i].Profile].Messages[Spells[i].Message_Areas[k]][l] == "" then
							table.remove(RSA.db.profile[ProfileName].Spells[Spells[i].Profile].Messages[Spells[i].Message_Areas[k]],l)
						end
						RSA:UpdateOptions()
						return RSA.db.profile[ProfileName].Spells[Spells[i].Profile].Messages[Spells[i].Message_Areas[k]][l]
					end,
					set = function(info, value)
						if value == "" then
							RSA.db.profile[ProfileName].Spells[Spells[i].Profile].Messages[Spells[i].Message_Areas[k]][l] = ""
						else
							RSA.db.profile[ProfileName].Spells[Spells[i].Profile].Messages[Spells[i].Message_Areas[k]][l] = value
						end
						RSA:UpdateOptions()
					end,
				}
			end
		end
	end
	return Options
end

local function LibSink_Options()
	Options.args.General.args.Output = RSA_O:GetSinkAce3OptionsDataTable() -- Add LibSink Options.
	Options.args.General.args.Output.args.Channel = nil -- Hide Channel options, we don't want those.
	Options.args.General.args.Output.name = "|cff00B2FA"..L["Local Message Output Area"].."|r"
	Options.args.General.args.Output.order = 100.6
	Options.args.General.args.Output.inline = true
end

local function AddOptions()
	Options.args.General.args.LibSink = LibSink_Options()
	Options.args.Spells.args.Class = Spell_Options()
	--Options.args.Spells.args.Racials = Spell_Options("Racials")
	--Options.args.Spells.args.Consumables = Consumable_Options()
	--Options.args.Spells.args.Utilities = Utility_Options()
end

-----------------------
---- Ace functions ----
-----------------------
function RSA_O:OnInitialize()
	self.db = RSA.db
	self:SetSinkStorage(self.db.profile) -- Setup Saved Variables for LibSink

	-- Profile Management
	self.db.RegisterCallback(RSA, "OnProfileChanged", "RefreshConfig")
	self.db.RegisterCallback(RSA, "OnProfileCopied", "RefreshConfig")
	self.db.RegisterCallback(RSA, "OnProfileReset", "RefreshConfig")
	if not self.db.profile.Fixed then
		RSA:FixDB()
	end

	-- Register Various Options
	LibStub("AceConfig-3.0"):RegisterOptionsTable("RSA", Options) -- Register Options
	local Profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	Options.args.profiles = Profiles
	Options.args.profiles.order = 99
	AddOptions()
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("RSA", "RSA")
	LibStub("AceConfigDialog-3.0"):SetDefaultSize("RSA",1000,725)
	local LibDualSpec = LibStub('LibDualSpec-1.0')
	LibDualSpec:EnhanceDatabase(self.db, "RSA")
	LibDualSpec:EnhanceOptions(Profiles, self.db)
	InterfaceAddOnsList_Update()
end

function RSA:UpdateOptions()
	AddOptions()
	LibStub("AceConfigRegistry-3.0"):NotifyChange("RSA")
end

function RSA_O:RefreshConfig()
	RSA.db.profile = self.db.profile
	RSA:UpdateOptions()
end
