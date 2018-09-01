----------------------------------------------
---- Raeli's Spell Announcer DemonHunter Module ----
----------------------------------------------
local RSA = LibStub("AceAddon-3.0"):GetAddon("RSA")
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")
local RSA_DemonHunter = RSA:NewModule("DemonHunter")
function RSA_DemonHunter:OnInitialize()
	if RSA.db.profile.General.Class == "DEMONHUNTER" then
		RSA_DemonHunter:SetEnabledState(true)
	else
		RSA_DemonHunter:SetEnabledState(false)
	end
end -- End OnInitialize
local spellinfo,spelllinkinfo,extraspellinfo,extraspellinfolink,missinfo
function RSA_DemonHunter:OnEnable()
	RSA.db.profile.Modules.DemonHunter = true -- Set state to loaded, to know if we should announce when a spell is refreshed.
	local pName = UnitName("player")
	local MonitorConfig_DemonHunter = {
		player_profile = RSA.db.profile.DemonHunter,
		SPELL_CAST_SUCCESS = {
			[202138] = { -- SIGIL OF CHAINS
				profile = 'SigilOfChains',
				section = 'Cast'
			},
			[207684] = { -- SIGIL OF MISERY
				profile = 'SigilOfMisery',
				section = 'Cast'
			},
			[202137] = { -- SIGIL OF SILENCE
				profile = 'SigilOfSilence',
				section = 'Cast'
			},
			[187827] = { -- METAMORPHOSIS VENGEANCE TANK
				profile = 'MetamorphosisTank',
				tracker = 2
			}, 
			[196718] = { -- DARKNESS
				profile = 'Darkness',
			},
		},
		SPELL_AURA_APPLIED = {
			[188501] = { -- SPECTRAL SIGHT
				profile = 'SpectralSight'
			},
			[212800] = { -- BLUR
				profile = 'Blur',
				linkID = 198589
			},
			[196555] = { -- Netherwalk
				profile = 'Netherwalk',
			},
			[209261] = { -- LAST RESORT
				profile = 'LastResort',
				tracker = 2,
				section = "Cast",
				linkID = 209258
			},
			[162264] = { -- METAMORPHOSIS HAVOC DPS
				profile = 'MetamorphosisDD',
				linkID = 191427
			},
			[187827] = { -- METAMORPHOSIS VENGEANCE TANK
				profile = 'MetamorphosisTank', 
				tracker = 2
			},
			[207744] = { -- FIERY BRAND
				profile = 'FieryBrand',
				replacements = { TARGET = 1 }
			},
			[204843] = { -- SIGIL OF CHAINS
				profile = 'SigilOfChains',
				--replacements = { TARGET = 1 },
				tracker = 2,
				linkID = 202138
			},
			[207685] = { -- SIGIL OF MISERY
				profile = 'SigilOfMisery',
				--replacements = { TARGET = 1 },
				tracker = 2,
				linkID = 207684
			},
			[204490] = { -- SIGIL OF SILENCE
				profile = 'SigilOfSilence',
				--replacements = { TARGET = 1 },
				tracker = 2,
				linkID = 202137
			},
			[185245] = { -- TORMENT
				profile = 'Torment',
				section = "Cast",
				replacements = { TARGET = 1 }
			},
			[179057] = { -- CHAOS NOVA
				profile = 'ChaosNova',
				--replacements = { TARGET = 1 },
				tracker = 2
			},
			[211881] = { -- Fel Eruption Havoc DPS Talent
				profile = 'FelEruption',
				replacements = { TARGET = 1 }
			},
		},
		SPELL_AURA_REMOVED = {
			[188501] = { -- SPECTRAL SIGHT
				profile = 'SpectralSight',
				section = 'End',
			},		
			[212800] = { -- BLUR
				profile = 'Blur',
				section = 'End',
				linkID = 198589
			},
			[196555] = { -- Netherwalk
				profile = 'Netherwalk',
				section = 'End',
			},
			--[[[187827] = { -- LAST RESORT
				profile = 'LastResort',
				section = 'End',
				tracker = 1,
				linkID = 209258
			},]]--
			[187827] = { -- METAMORPHOSIS VENGEANCE TANK
				profile = 'MetamorphosisTank',
				section = 'End',
				tracker = 1
			},
			[162264] = { -- METAMORPHOSIS VENGEANCE DPS
				profile = 'MetamorphosisDD',
				section = 'End',
				linkID = 191427
			},
			[207744] = { -- FIERY BRAND
				profile = 'FieryBrand',
				section = 'End',
				replacements = { TARGET = 1 }
			},
			[204843] = { -- SIGIL OF CHAINS
				profile = 'SigilOfChains',
				--replacements = { TARGET = 1 },
				section = 'End',
				tracker = 1,
				linkID = 202138
			},
			[207685] = { -- SIGIL OF MISERY
				profile = 'SigilOfMisery',
				--replacements = { TARGET = 1 },
				section = 'End',
				tracker = 1,
				linkID = 207684
			},
			[204490] = { -- SIGIL OF SILENCE
				profile = 'SigilOfSilence',
				--replacements = { TARGET = 1 },
				section = 'End',
				tracker = 1,
				linkID = 202137
			},
			[179057] = { -- CHAOS NOVA
				profile = 'ChaosNova',
				--replacements = { TARGET = 1 },
				section = 'End',
				tracker = 1
			},
			[211881] = { -- Fel Eruption Havoc DPS Talent
				profile = 'FelEruption',
				section = 'End',
				replacements = { TARGET = 1 }
			},
		},
		SPELL_INTERRUPT = {
			[183752] = { -- CONSUME MAGIC
				profile = 'Disrupt',
				section = "Interrupt",
				replacements = { TARGET = 1, extraSpellName = "[TARSPELL]", extraSpellLink = "[TARLINK]" }
			}
		},
		SPELL_DISPEL = {
			[278326] = { -- Consume Magic
				profile = 'Consume',
				section = "Dispel",
				replacements = { TARGET = 1, extraSpellName = "[AURA]", extraSpellLink = "[AURALINK]" }
			},
		},
		SPELL_DISPEL_FAILED = {
			[278326] = { -- Consume Magic
				profile = 'Consume',
				section = 'Resist',
				replacements = { TARGET = 1}
			},
		},
		SPELL_MISSED = {
			[183752] = {-- CONSUME MAGIC
				profile = 'Disrupt',
				section = 'Resist',
				immuneSection = "Immune",
				replacements = { TARGET = 1, MISSTYPE = 1 },
			},
			[185245] = {-- TORMENT
				profile = 'Torment',
				section = 'Resist',
				immuneSection = "Immune",
				replacements = { TARGET = 1, MISSTYPE = 1 },
			},
		},
	}
	RSA.MonitorConfig(MonitorConfig_DemonHunter, UnitGUID("player"))
	local MonitorAndAnnounce = RSA.MonitorAndAnnounce
	local function DemonHunter_Spells()
		local timestamp, event, hideCaster, sourceGUID, source, sourceFlags, sourceRaidFlag, destGUID, dest, destFlags, destRaidFlags, spellID, spellName, spellSchool, missType, overheal, ex3, ex4 = CombatLogGetCurrentEventInfo()
		if RSA.AffiliationMine(sourceFlags) then
			if (event == "SPELL_CAST_SUCCESS" and RSA.db.profile.Modules.Reminders_Loaded == true) then -- Reminder Refreshed
				local ReminderSpell = RSA.db.profile.DemonHunter.Reminders.SpellName
				if spellName == ReminderSpell and (dest == pName or dest == nil) then
					RSA.Reminder:SetScript("OnUpdate", nil)
					if RSA.db.profile.Reminders.RemindChannels.Chat == true then
						RSA.Print_Self(ReminderSpell .. L[" Refreshed!"])
					end
					if RSA.db.profile.Reminders.RemindChannels.RaidWarn == true then
						RSA.Print_Self_RW(ReminderSpell .. L[" Refreshed!"])
					end
				end
			end -- BUFF REMINDER
			MonitorAndAnnounce(self, timestamp, event, hideCaster, sourceGUID, source, sourceFlags, sourceRaidFlag, destGUID, dest, destFlags, destRaidFlags, spellID, spellName, spellSchool, missType, overheal, ex3, ex4)
		end -- IF SOURCE IS PLAYER
	end -- END ENTIRELY
	RSA.CombatLogMonitor:SetScript("OnEvent", DemonHunter_Spells)
end -- END ON ENABLED
function RSA_DemonHunter:OnDisable()
	RSA.CombatLogMonitor:SetScript("OnEvent", nil)
end
