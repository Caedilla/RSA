local RSA = LibStub('AceAddon-3.0'):GetAddon('RSA')

local defaults = {
	['ancestralGuidance'] = {
		spellID = 108281,
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
	['ancestralProtectionTotem'] = {
		spellID = 207399,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] placed!",},
			},
			-- TODO save GUID of SPELL_SUMMON, and match this to that.
			--['SPELL_CAST_SUCCESS'] = {
			--	messages = {"[LINK] resurrected [TARGET]!",},
			--},
			['UNIT_DIED'] = {
				messages = {"[LINK] finished!",},
			},
		},
	},
	['ancestralSpirit'] = {
		spellID = 2008,
		events = {
			['SPELL_RESURRECT'] = {
				messages = {"Resurrected [TARGET]!",},
				tags = {TARGET = true,},
			},
			['SPELL_CAST_START'] = {
				messages = {"Casting [LINK] on [TARGET]!",},
				tags = {TARGET = true,},
			},
		},
	},
	['ancestralVision'] = {
		spellID = 212048,
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
	['ascendence'] = {
		spellID = 114050, -- Elemental
		additionalSpellIDs = {
			[114051] = true, -- Enhancement
			[114052] = true, -- Restoration
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
	['astralShift'] = {
		spellID = 108271,
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
	['bloodlust'] = {
		spellID = 2825, -- Bloodlust
		additionalSpellIDs = {
			[32182] = true, -- Heroism
		},
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] activated!",},
			},
			['SPELL_AURA_REMOVED'] = {
				dest = {'player'},
				messages = {"[LINK] finished!",},
			},
		},
	},
	['capacitorTotem'] = {
		spellID = 192058,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] placed!",},
			},
			-- TODO save GUID of SPELL_SUMMON, and match this to that.
			--['SPELL_CAST_SUCCESS'] = {
			--	uniqueSpellID = 118905,
			--	messages = {"[LINK] activated!",},
			--},
			['SPELL_AURA_REMOVED'] = {
			--	uniqueSpellID = 118905,
				messages = {"[LINK] finished!",},
			},
		},
	},
	['cleanseSpirit'] = {
		spellID = 51886,
		throttle = 0.25,
		additionalSpellIDs = {
			[77130] = true, -- Purify Spirit
		},
		events = {
			['SPELL_DISPEL'] = {
				messages = {"Cleansed [TARGET]'s [EXTRALINK]!",},
				tags = {
					TARGET = true,
					EXTRA = true,
				},
			},
		},
	},
	['cloudburstTotem'] = {
		spellID = 157153,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] placed!",},
			},
			-- TODO save GUID of SPELL_SUMMON, and match this to that.
			--['SPELL_CAST_SUCCESS'] = {
			--	uniqueSpellID = 201764,
			--	messages = {"[LINK] activated!",},
			--},
			['SPELL_HEAL'] = {
			--	uniqueSpellID = 118905,
				messages = {"[LINK] healed for [AMOUNT]!",},
				tags = {AMOUNT = true,},
			},
		},
	},
	['earthElemental'] = {
		spellID = 198103,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] activated!",},
			},
			['SPELL_AURA_REMOVED'] = {
				dest = {'player'},
				messages = {"[LINK] finished!",},
			},
		},
	},
	['earthenWallTotem'] = {
		spellID = 207399,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] placed!",},
			},
			-- TODO save GUID of SPELL_SUMMON, and match this to that.
			['UNIT_DIED'] = {
				messages = {"[LINK] finished!",},
			},
		},
	},
--[[
Earthgrab Totem
Feral Spirit
Fire Elemental
Grounding Totem
Healing Tide Totem
Hex
Purge
Reincarnation
Spirit Link Totem
Thunderstorm
Tremor Totem
Wind Rush Totem
]]--

	['hex'] = {
		spellID = 51514, -- Frog (Default)
		additionalSpellIDs = {
			[211004] = true, -- Spider
			[210873] = true, -- Compy
			[211010] = true, -- Snake
			[211015] = true, -- Cockroach
			[277784] = true, -- Wicker Mongrel
			[309328] = true, -- Living Honey
			[277778] = true, -- Zandalari Tendonripper
			[269352] = true, -- Skeletal Hatchling
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
			['SPELL_AURA_BROKEN_SPELL'] = {
				messages = {"[SOURCE] removed [LINK] on [TARGET] with [EXTRALINK]!",},
				tags = {
					TARGET = true,
					SOURCE = true,
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
	['purge'] = {
		spellID = 370,
		throttle = 0.25,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_DISPEL'] = {
				messages = {"Dispelled [TARGET]'s [EXTRALINK]!",},
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
	['windShear'] = {
		spellID = 57994,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_INTERRUPT'] = {
				messages = {"Interrupted [TARGET]'s [EXTRALINK]!",},
				tags = {
					TARGET = true,
					EXTRA = true, -- Replaces AURA and TARSPELL.
				},
			},
			['SPELL_MISSED'] = {
				messages = {"[LINK] [MISSTYPE] [TARGET]!",},
				tags = {
					TARGET = true,
					MISSTYPE = true,
				},
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

RSA.monitorData.shaman, RSA.configData.shaman = RSA.PrepareDataTables(defaults)