local RSA = RSA or LibStub('AceAddon-3.0'):GetAddon('RSA')

local paladinData = {
	['ardentDefender'] = {
		profile = 'ardentDefender',
		spellID = 31850,
		configDisplay = {
			messageAreas = {},
			disabledChannels = {['Whisper'] = true},
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
				},
				channels = {
				},
			},
			SPELL_AURA_REMOVED = {
				tracker = 1,
				tags = {},
				messages = {"[LINK] faded!",},
				channels = {},
			},

			SPELL_MISSED = {
				messages = {'blah'},
				immuneMessages = {'blah'}, -- immuneMessages is required for SPELL_MISSED events.
			}
		},
	},
}

local function PrepareDataTables(dataTable)
	-- Ensure barebones config data is properly populated and also reverse link all spellIDs used in a profile to that profile
	-- so that the Monitor can easily check if a spellID is used in a profile, rather than having to iterate through each profile's event data.
	-- Why not store the profile in this manner by default? It's more human readable to have everything needed for a spell to function within
	--one table, rather than having multiple references to the profile in separate event tables as RSA used to do.

	-- TODO: Move to appropriate file space.
	local spellToProfile = {}

	for i = 1, #dataTable do
		spellToProfile[dataTable[i].spellID] = dataTable[i].profile
		if not dataTable[i].environments then
			paladinData[i].environments = {
				useGlobal = true, -- This spell will use the global envrionment settings to determine where it can announce, this overrides the other values in this section.
				alwaysWhisper = false, -- Allows whispers to always be sent.
				enableIn = {
					arenas = false,
					bgs = false,
					warModeWorld = false, -- Enable in War Mode world zones.
					nonWarWorld = false, -- Enable in world zones without war mode enabled.
					dungeons = false,
					raids = false,
					lfg = false,
					lfr = false,
					scenarios = false,
				},
				groupToggles = { -- When true, only announce to these channels if you are in a group
					emote = true,
					say = true,
					yell = true,
					whisper = true,
				},
				combatState = {
					inCombat = true, -- Announce only in Combat
					noCombat = false, -- Announce not in Combat
				},
			}
		end
		for k, v in pairs(dataTable[i].events) do
			table.insert(dataTable[i].configDisplay.messageAreas, k)
		end
		for j = 1, #dataTable[i].events do
			spellToProfile[dataTable[i].events[j].uniqueSpellID] = spellToProfile[i].profile

			if not dataTable[i].events[j].channels then
				dataTable[i].events[j].channels = {}
			end
			if not dataTable[i].events[j].tags then
				dataTable[i].events[j].tags = {}
			end
		end
	end

	return dataTable, spellToProfile
end

RSA.SpellData.Paladin, RSA.MonitorData.Paladin = PrepareDataTables(paladinData)