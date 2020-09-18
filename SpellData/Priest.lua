local RSA = LibStub('AceAddon-3.0'):GetAddon('RSA')

local priestData = {
	['apotheosis'] = {
		spellID = 200183,
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
	['archangel'] = {
		spellID = 197862,
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
	['bodyAndSoul'] = {
		spellID = 65081,
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
	['dispelMagic'] = {
		spellID = 528,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_DISPEL'] = {
				messages = {"Dispelled [TARGET]'s [AURALINK]!",},
				tags = {
					TARGET = true,
					EXTRA = true,
				},
			},
			['SPELL_DISPEL_FAILED'] = {
				messages = {"[TARGET] [MISSTYPE] [LINK]!"},
				tags = {
					TARGET = true,
					MISSTYPE = true,
				},
			},
		},
	},
	['divineHymn'] = {
		spellID = 64843,
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
	['evangelism'] = {
		spellID = 246287,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] activated!",},
			},
		},
	},
	['fade'] = {
		spellID = 586,
		additionalSpellIDs = {
			[213602] = true, -- Greater Fade
		},
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
	['guardianSpirit'] = {
		spellID = 47788,
		events = {
			['SPELL_AURA_APPLIED'] = {
				tracker = 2,
				messages = {"[LINK] cast on [TARGET]!",},
				tags = {TARGET = true,},
			},
			['SPELL_HEAL'] = {
				uniqueSpellID = 48153,
				tracker = 1,
				messages = {"[LINK] prevented [TARGET]'s death and healed them for [AMOUNT]!",},
				tags = {AMOUNT = true,},
			},
			['SPELL_AURA_REMOVED'] = {
				tracker = 1,
				messages = {"[LINK] on [TARGET] finished!",},
				tags = {TARGET = true,},
			},
		},
	},
	['holyWard'] = {
		spellID = 213610,
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
	['holyWordChastise'] = {
		spellID = 200196,
		additionalSpellIDs = {
			[200200] = true, -- Chastise modified by Censure talent.
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
	['holyWordSalvation'] = {
		spellID = 265202,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] activated!",},
			},
		},
	},
	['leapOfFaith'] = {
		spellID = 73325,
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] cast on [TARGET]!",},
				tags = {TARGET = true,},
			},
		},
	},
	['levitate'] = {
		spellID = 1706,
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] cast on [TARGET]!",},
				tags = {TARGET = true,},
			},
		},
	},
	['massDispel'] = {
		spellID = 32375,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_START'] = {
				messages = {"Casting [LINK]!",},
			},
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] activated!",},
			},
		},
	},
	['massResurrection'] = {
		spellID = 212036,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_START'] = {
				messages = {'Casting [LINK]!',},
			},
			['SPELL_CAST_SUCCESS'] = {
				messages = {'[LINK] finished, get up!',},
			},
		},
	},
	['mindBomb'] = {
		throttle = 3,
		spellID = 205369,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] cast on [TARGET]!",},
				tags = {TARGET = true,},
			},
			['SPELL_AURA_REMOVED'] = {
				uniqueSpellID = 226943,
				messages = {"[LINK] on [TARGET] finished!",},
				tags = {TARGET = true,},
			},
		},
	},
	['mindControl'] = {
		spellID = 605,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] cast on [TARGET]!",},
				tags = {TARGET = true,},
			},
			['SPELL_AURA_REMOVED'] = {
				messages = {"[LINK] on [TARGET] finished!",},
				tags = {TARGET = true,},
			},
			['RSA_SPELL_IMMUNE'] = { -- Fake event to easily generate options for immune specific messages.
			messages = {"[TARGET] [MISSTYPE] [LINK]!"},
			tags = {
				TARGET = true,
				MISSTYPE = true,
			},
		},
		},
	},
}

RSA.monitorData.priest, RSA.configData.priest = RSA.PrepareDataTables(priestData)