local RSA = LibStub('AceAddon-3.0'):GetAddon('RSA')
local L = LibStub('AceLocale-3.0'):GetLocale('RSA')

local defaults = {
	['demoralizingShout'] = {
		spellID = 1160,
		throttle = 2,
		configDisplay = {
			isDefault = true,
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_AURA_APPLIED'] = {
				messages = {"[LINK] activated!",},
			},
			['SPELL_AURA_REMOVED'] = {
				messages = {"[LINK] finished!",},
			},
		},
	},
	['dieByTheSword'] = {
		spellID = 118038,
		configDisplay = {
			isDefault = true,
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
	['enragedRegeneration'] = {
		spellID = 184364,
		configDisplay = {
			isDefault = true,
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
	['intervene'] = {
		spellID = 3411,
		configDisplay = {
			isDefault = true,
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
	['intimidatingShout'] = {
		spellID = 5246,
		throttle = 2,
		configDisplay = {
			isDefault = true,
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_AURA_APPLIED'] = {
				messages = {"[LINK] activated!",},
			},
			['SPELL_AURA_REMOVED'] = {
				messages = {"[LINK] finished!",},
			},
		},
	},
	['lastStand'] = {
		spellID = 12975,
		configDisplay = {
			isDefault = true,
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
	['pummel'] = {
		spellID = 6552,
		configDisplay = {
			isDefault = true,
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
	['rallyingCry'] = {
		spellID = 97462,
		configDisplay = {
			isDefault = true,
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
	['recklessness'] = {
		spellID = 1719,
		configDisplay = {
			isDefault = true,
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
	['shieldWall'] = {
		spellID = 871,
		configDisplay = {
			isDefault = true,
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
	--TODO: Spell Reflection
	['stormBolt'] = {
		spellID = 132169,
		configDisplay = {
			isDefault = true,
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
	['taunt'] = {
		spellID = 355,
		configDisplay = {
			isDefault = true,
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
}

local wrath = {
	['demoralizingShout'] = {
		spellID = 1160,
		throttle = 2,
		configDisplay = {
			isDefault = true,
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_AURA_APPLIED'] = {
				messages = {"[LINK] activated!",},
			},
			['SPELL_AURA_REMOVED'] = {
				messages = {"[LINK] finished!",},
			},
		},
	},
	['enragedRegeneration'] = {
		spellID = 55694,
		configDisplay = {
			isDefault = true,
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
	['intervene'] = {
		spellID = 3411,
		configDisplay = {
			isDefault = true,
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
	['intimidatingShout'] = {
		spellID = 5246,
		throttle = 2,
		configDisplay = {
			isDefault = true,
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_AURA_APPLIED'] = {
				messages = {"[LINK] activated!",},
			},
			['SPELL_AURA_REMOVED'] = {
				messages = {"[LINK] finished!",},
			},
		},
	},
	['lastStand'] = {
		spellID = 12975,
		configDisplay = {
			isDefault = true,
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
	['pummel'] = {
		spellID = 6552,
		configDisplay = {
			isDefault = true,
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
	['recklessness'] = {
		spellID = 1719,
		configDisplay = {
			isDefault = true,
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
	['shieldWall'] = {
		spellID = 871,
		configDisplay = {
			isDefault = true,
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
	--TODO: Spell Reflection
	['taunt'] = {
		spellID = 355,
		configDisplay = {
			isDefault = true,
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
}

if RSA.IsRetail() then
	RSA.monitorData.warrior, RSA.configData.warrior = RSA.PrepareDataTables(defaults)
elseif RSA.IsWrath() then
	RSA.monitorData.warrior, RSA.configData.warrior = RSA.PrepareDataTables(wrath)
end