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
			--customDesc = 'My custom description',
			--customName = 'My custom spell name',
		},
		environments = {},
		events = {
			SPELL_HEAL = {
				uniqueSpellID = 66235, -- Ardent Defender uses a different spell ID when the heal effect triggers.
				tracker = 1, -- Tells the monitor to not announce any further messages for this spell, so that we don't also announce the finishing message.
				tags = {
					TARGET = true,
					SOURCE = true,
					MISSTYPE = true,
					AMOUNT = true,
					EXTRA = '[AURA]', -- Valid string values: [AURA], [TARSPELL]
				},
				messages = {
					"[LINK] saved my life and healed me for [AMOUNT] hp!",
				},
				channels = {
					emote = true,
					-- Channels enabled by default, or in saved vars the channels actually enabled. None listed means this event doesn't announce by default.
				},
			},
			SPELL_CAST_SUCCESS = {
				--uniqueSpellID = 66235, -- We use the primary spell ID for this spell, 31850.
				tracker = 2, -- Tells the monitor to start tracking this spell so that we can prevent both the Heal and Finish message from playing if the heal triggers.
				tags = {
					-- No additional tags needed for this event.
				},
				messages = {
					"[LINK] Activated!",
					"AD STARTED",
				},
				channels = {
					emote = true,
				},
			},
			SPELL_AURA_REMOVED = {
				tracker = 1,
				tags = {},
				messages = {"[LINK] faded!",},
				channels = {emote = true,},
			},
			--SPELL_MISSED = {
			--	messages = {'blah'},
			--	immuneMessages = {'blah'}, -- immuneMessages is required for SPELL_MISSED events.
			--},
		},
	},
	['blessingOfFreedom'] = {
		profile = 'blessingOfFreedom',
		spellID = 305395,
		additionalSpellIDs = {1044}, -- If a spell has multiple variants, i.e differnt Polymorphs or the same spell but modified by talents we should probably just have one profile for all of those, rather than a whole buunch which would be confusing.
		configDisplay = {
			messageAreas = {},
			disabledChannels = {['Whisper'] = true},
			validTags = {'[AMOUNT]'}, -- [SPELL] and [LINK] are implied.
			--customDesc = 'My custom description',
			--customName = 'My custom spell name',
		},
		environments = {},
		events = {
			SPELL_AURA_APPLIED = {
				--uniqueSpellID = 66235, -- We use the primary spell ID for this spell, 31850.
				--tracker = 2, -- Tells the monitor to start tracking this spell so that we can prevent both the Heal and Finish message from playing if the heal triggers.
				tags = {
					-- No additional tags needed for this event.
				},
				messages = {
					"[LINK] Activated!",
					"RANOM MESSAGE START",
					"ANOTHER START MESSAGE",
				},
				channels = {
					emote = true,
				},
			},
			SPELL_AURA_REMOVED = {
				--tracker = 1,
				tags = {},
				messages = {"[LINK] faded!", "END MESSAGE ONE"},
				channels = {emote = true,},
			},
			--SPELL_MISSED = {
			--	messages = {'blah'},
			--	immuneMessages = {'blah'}, -- immuneMessages is required for SPELL_MISSED events.
			--},
		},
	},
}


RSA.spellData.paladin, RSA.monitorData.paladin = RSA.PrepareDataTables(paladinData)