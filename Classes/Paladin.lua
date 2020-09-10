local RSA = RSA or LibStub('AceAddon-3.0'):GetAddon('RSA')

-- Global Frames and Event Registers
RSA.configData = RSA.configData or {}
RSA.monitorData = RSA.monitorData or {}

local paladinData = {
	['absolution'] = {
		spellID = 212056,
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
	['ardentDefender'] = {
		spellID = 31850,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_HEAL'] = {
				uniqueSpellID = 66235, -- Ardent Defender uses a different spell ID when the heal effect triggers.
				tracker = 1, -- Tells the monitor to not announce any further messages for this spell, so that we don't also announce the finishing message.
				messages = {"[LINK] saved my life and healed me for [AMOUNT] hp!",},
				tags = {AMOUNT = true,},
			},
			['SPELL_CAST_SUCCESS'] = {
				tracker = 2, -- Tells the monitor to start tracking this spell so that we can prevent both the Heal and Finish message from playing if the heal triggers.
				messages = {"[LINK] activated!",},
			},
			['SPELL_AURA_REMOVED'] = {
				tracker = 1,
				messages = {"[LINK] finished!",},
			},
		},
	},
	['auraMastery'] = {
		spellID = 31821,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] activated!",},
			},
			--TODO: Implement source/dest options and code support for event based targets and sources.
			['SPELL_AURA_REMOVED'] = {
				target = {'player'},
				messages = {"[LINK] finished!",},
			},
		},
	},
	['avengersShield'] = {
		spellID = 31935,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_INTERRUPT'] = {
				messages = {"Interrupted [TARGET]'s [TARLINK]!",},
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
					EXTRA = true,
				},
			},
			--TODO: Support fake events in monitor.
			['RSA_SPELL_MISSED_IMMUNE'] = { -- Fake event to easily generate options for immune specific messages.
				messages = {"[TARGET] [MISSTYPE] [LINK]!"},
				tags = {
					TARGET = true,
					MISSTYPE = true,
				},
			},
		},
	},
	['avengingWrath'] = {
		spellID = 31884,
		additionalSpellIDs = {
			[231895] = true, -- Crusade
			[216331] = true, -- Avenging Crusader
		},
		configDisplay = {
			disabledChannels = {whisper = true},
			defaultName = GetSpellInfo(31884) .. ' | ' .. GetSpellInfo(216331) .. ' | ' .. GetSpellInfo(231895),
			defaultDesc = '|cffFFCC00'..GetSpellInfo(31884) .. ':|r |cffd1d1d1' .. GetSpellDescription(31884) .. '|r\n\n|cffFFCC00' .. GetSpellInfo(216331) .. ':|r |cffd1d1d1' .. GetSpellDescription(216331) .. '|r\n\n|cffFFCC00' .. GetSpellInfo(231895) .. ':|r |cffd1d1d1' .. GetSpellDescription(231895) .. '|r',
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
	['beaconOfLight'] = {
		spellID = 53563,
		additionalSpellIDs = {
			[156910] = true, -- Beacon of Faith
		},
		configDisplay = {
			defaultName = GetSpellInfo(53563) .. ' | ' .. GetSpellInfo(156910),
			defaultDesc = '|cffFFCC00'..GetSpellInfo(53563) .. ':|r |cffd1d1d1' .. GetSpellDescription(53563) .. '|r\n\n|cffFFCC00' .. GetSpellInfo(156910) .. ':|r |cffd1d1d1' .. GetSpellDescription(156910) .. '|r',
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
		},
	},
	['blessingOfFreedom'] = {
		spellID = 1044,
		additionalSpellIDs = {
			[305395] = true, -- Unbound Freedom
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
	['blessingOfSacrifice'] = {
		spellID = 6940,
		additionalSpellIDs = {
			[199448] = true, -- Ultimate Sacrifice
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
	['blessingOfSanctuary'] = {
		spellID = 210256,
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
	['blessingOfProtection'] = {
		spellID = 1022,
		additionalSpellIDs = {
			[204018] = true, -- Blessing of Spellwarding
		},
		configDisplay = {
			defaultName = GetSpellInfo(1022) .. ' | ' .. GetSpellInfo(204018),
			defaultDesc = '|cffFFCC00'..GetSpellInfo(1022) .. ':|r |cffd1d1d1' .. GetSpellDescription(1022) .. '|r\n\n|cffFFCC00' .. GetSpellInfo(204018) .. ':|r |cffd1d1d1' .. GetSpellDescription(204018) .. '|r',
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
}


RSA.monitorData.paladin, RSA.configData.paladin = RSA.PrepareDataTables(paladinData)