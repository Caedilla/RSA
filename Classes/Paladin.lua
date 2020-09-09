local RSA = RSA or LibStub('AceAddon-3.0'):GetAddon('RSA')

-- Global Frames and Event Registers
RSA.spellData = RSA.spellData or {}
RSA.monitorData = RSA.monitorData or {}

local paladinData = {
	['absolution'] = {
		profile = 'absolution',
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
		profile = 'ardentDefender',
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
				messages = {"[LINK] Activated!",},
			},
			['SPELL_AURA_REMOVED'] = {
				tracker = 1,
				messages = {"[LINK] faded!",},
			},
		},
	},
	['auraMastery'] = {
		profile = 'auraMastery',
		spellID = 31821,
		configDisplay = {
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] Activated!",},
			},
			--TODO: Implement source/dest options and code support for event based targets and sources.
			['SPELL_AURA_REMOVED'] = {
				target = {'player'},
				messages = {"[LINK] Finished!",},
			},
		},
	},
	['avengersShield'] = {
		profile = 'avengersShield',
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
		profile = 'avengingWrath',
		spellID = 31884,
		additionalSpellIDs = {
			[231895] = true,
			[216331] = true,
		},
		configDisplay = {
			disabledChannels = {whisper = true},
			customName = GetSpellInfo(31884) .. ' / ' .. GetSpellInfo(216331) .. ' / ' .. GetSpellInfo(231895),
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] Activated!",},
			},
			['SPELL_AURA_REMOVED'] = {
				messages = {"[LINK] Finished!",},
			},
		},
	},
	['blessingOfFreedom'] = {
		profile = 'blessingOfFreedom',
		spellID = 305395,
		additionalSpellIDs = {[1044] = true,},
		events = {
			['SPELL_AURA_APPLIED'] = {
				messages = {"[LINK] Activated!",},
				tags = {TARGET = true,},
			},
			['SPELL_AURA_REMOVED'] = {
				messages = {"[LINK] faded!"},
				tags = {TARGET = true,},
			},
		},
	},
}


RSA.monitorData.paladin, RSA.spellData.paladin = RSA.PrepareDataTables(paladinData)