local RSA = LibStub('AceAddon-3.0'):GetAddon('RSA')
local L = LibStub("AceLocale-3.0"):GetLocale("RSA")

local defaults = {
	['antiMagicShell'] = {
		spellID = 48707,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] activated!",},
			},
			['SPELL_AURA_REMOVED'] = {
				messages = {"[LINK] finished!",},
			},
		},
	},
	['antiMagicZone'] = {
		spellID = 51052,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] activated!",},
			},
			['RSA_END_TIMER'] = {
				duration = 10,
				messages = {"[LINK] finished!",},
			},
		},
	},
	['armyOfTheDead'] = {
		spellID = 42650,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] activated!",},
			},
			['SPELL_AURA_REMOVED'] = {
				messages = {"[LINK] finished!",},
			},
		},
	},
	['asphyxiate'] = {
		spellID = 108194, -- Frost / Unholy talent version
		additionalSpellIDs = {
			[221562] = true, -- Blood baseline version
		},
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_AURA_APPLIED'] = {
				messages = {"[LINK] cast on [TARGET]!",},
				tags = {TARGET = true,},
			},
			['SPELL_AURA_REMOVED'] = {
				messages = {"[LINK] on [TARGET] finished!",},
				tags = {TARGET = true,},
			},
		},
	},
	['dancingRuneWeapon'] = {
		spellID = 49028,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				uniqueSpellID = 81256,
				messages = {"[LINK] activated!",},
			},
			['SPELL_AURA_REMOVED'] = {
				messages = {"[LINK] finished!",},
			},
		},
	},
	['darkCommand'] = {
		spellID = 56222,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_AURA_APPLIED'] = {
				messages = {"Taunted [TARGET]!",},
				tags = {
					TARGET = true,
				},
			},
			['SPELL_MISSED'] = {
				messages = {"[LINK] [MISSTYPE] [TARGET]!",},
				tags = {
					TARGET = true,
					MISSTYPE = true,
				},
			},
			['RSA_SPELL_IMMUNE'] = {
				messages = {"[TARGET] [MISSTYPE] [LINK]!"},
				tags = {
					TARGET = true,
					MISSTYPE = true,
				},
			},
		},
	},
	['deathGrip'] = {
		spellID = 49576,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] cast on [TARGET]!",},
				tags = {TARGET = true,},
			},
			['SPELL_MISSED'] = {
				messages = {"[LINK] [MISSTYPE] [TARGET]!",},
				tags = {
					TARGET = true,
					MISSTYPE = true,
				},
			},
			['RSA_SPELL_IMMUNE'] = {
				messages = {"[TARGET] [MISSTYPE] [LINK]!"},
				tags = {
					TARGET = true,
					MISSTYPE = true,
				},
			},
		},
	},
	['gorefiendsGrasp'] = {
		spellID = 108199,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] activated!",},
			},
		},
	},
	['iceboundFortitude'] = {
		spellID = 48792,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] activated!",},
			},
			['SPELL_AURA_REMOVED'] = {
				messages = {"[LINK] finished!",},
			},
		},
	},
	['mindFreeze'] = {
		spellID = 47528,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_INTERRUPT'] = {
				messages = {"Interrupted [TARGET]'s [EXTRALINK]!",},
				tags = {
					TARGET = true,
					EXTRA = true,
				},
			},
			['SPELL_MISSED'] = {
				messages = {"[LINK] [MISSTYPE] [TARGET]!",},
				tags = {
					TARGET = true,
					MISSTYPE = true,
				},
			},
			['RSA_SPELL_IMMUNE'] = {
				messages = {"[TARGET] [MISSTYPE] [LINK]!"},
				tags = {
					TARGET = true,
					MISSTYPE = true,
				},
			},
		},
	},
	['perdition'] = { -- Forbearance effect of Purgatory
		spellID = 114556, -- ID of the talent so [LINK] links that, rather than Perdition. Unused in any events since all have a uniqueSpellID.
		configDisplay = {
			defaultName = L["Purgatory Cooldown"],
			defaultDesc = '|cffFFCC00'..GetSpellInfo(123981) .. ':|r |cffd1d1d1' .. GetSpellDescription(123981) .. '|r',
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_AURA_REMOVED'] = {
				uniqueSpellID = 123981,
				messages = {"[LINK] available again!",},
			},
		},
	},
	['purgatory'] = {
		spellID = 114556, -- ID of the talent so [LINK] links that, rather than Shroud of Purgatory. Unused in any events since all have a uniqueSpellID.
		throttle = 0.25,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_INSTAKILL'] = {
				uniqueSpellID = 123982,
				tracker = 1,
				messages = {"[LINK] killed me!",},
			},
			['SPELL_AURA_APPLIED'] = {
				uniqueSpellID = 116888,
				tracker = 2,
				messages = {"[LINK] saved my life!",},
			},
			['SPELL_AURA_REMOVED'] = {
				uniqueSpellID = 116888,
				tracker = 1,
				messages = {"[LINK] healing absorb removed!",},
			},
		},
	},
	['raiseAlly'] = {
		spellID = 61999,
		events = {
			['SPELL_RESURRECT'] = {
				messages = {"Resurrected [TARGET]!",},
				tags = {TARGET = true,},
			},
		},
	},
	['runeTap'] = {
		spellID = 194679,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] activated!",},
			},
			['SPELL_AURA_REMOVED'] = {
				messages = {"[LINK] finished!",},
			},
		},
	},
	['strangulate'] = {
		spellID = 47476,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_AURA_APPLIED'] = {
				messages = {"[LINK] cast on [TARGET]!",},
				tags = {TARGET = true,},
			},
			['SPELL_AURA_REMOVED'] = {
				messages = {"[LINK] on [TARGET] finished!",},
				tags = {TARGET = true,},
			},
		},
	},
	['vampiricBlood'] = {
		spellID = 55233,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] activated!",},
			},
			['SPELL_AURA_REMOVED'] = {
				messages = {"[LINK] finished!",},
			},
		},
	},
}

RSA.monitorData.deathknight, RSA.configData.deathknight = RSA.PrepareDataTables(defaults)