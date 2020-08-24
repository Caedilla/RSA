local RSA = RSA or LibStub('AceAddon-3.0'):GetAddon('RSA')

-- Global Frames and Event Registers
RSA.spellData = RSA.spellData or {}
RSA.monitorData = RSA.monitorData or {}

local paladinData = {
	['ardentDefender'] = {
		profile = 'ardentDefender',
		spellID = 31850,
		configDisplay = {
			messageAreas = {},
			disabledChannels = {whisper = true},
			validTags = {'[AMOUNT]'}, -- [SPELL] and [LINK] are implied.
		},
		events = {
			SPELL_HEAL = {
				uniqueSpellID = 66235, -- Ardent Defender uses a different spell ID when the heal effect triggers.
				tracker = 1, -- Tells the monitor to not announce any further messages for this spell, so that we don't also announce the finishing message.
				messages = {"[LINK] saved my life and healed me for [AMOUNT] hp!",},
				tags = {AMOUNT = true,},
			},
			SPELL_CAST_SUCCESS = {
				tracker = 2, -- Tells the monitor to start tracking this spell so that we can prevent both the Heal and Finish message from playing if the heal triggers.
				messages = {"[LINK] Activated!",},
			},
			SPELL_AURA_REMOVED = {
				tracker = 1,
				messages = {"[LINK] faded!",},
			},
		},
	},
	['blessingOfFreedom'] = {
		profile = 'blessingOfFreedom',
		spellID = 305395,
		additionalSpellIDs = {1044},
		configDisplay = {
			messageAreas = {},
			disabledChannels = {},
			validTags = {'[TARGET]'}, -- [SPELL] and [LINK] are implied.
		},
		events = {
			SPELL_AURA_APPLIED = {
				messages = {"[LINK] Activated!",},
				tags = {TARGET = true,},
			},
			SPELL_AURA_REMOVED = {
				messages = {"[LINK] faded!"},
				tags = {TARGET = true,},
			},
		},
	},
}


RSA.spellData.paladin, RSA.monitorData.paladin = RSA.PrepareDataTables(paladinData)