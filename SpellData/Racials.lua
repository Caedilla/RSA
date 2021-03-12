local RSA = LibStub('AceAddon-3.0'):GetAddon('RSA')

local defaults = {
	['arcaneTorrent'] = {
		spellID = 28730, -- Warlock, Mage
		throttle = 0.25,
		additionalSpellIDs = {
			[25046] = true, -- Rogue
			[50613] = true, -- Death Knight
			[69179] = true, -- Warrior
			[80483] = true, -- Hunter
			[129597] = true, -- Monk
			[155145] = true, -- Paladin
			[202719] = true, -- Demon Hunter
			[232633] = true, -- Priest
		},
		configDisplay = {
			isDefault = true,
			disabledChannels = {whisper = true},
		},
		events = {
			['SPELL_CAST_SUCCESS'] = {
				messages = {"[LINK] activated!",},
			},
			['SPELL_DISPEL'] = {
				messages = {"Purged [TARGET]'s [EXTRALINK]!",},
				tags = {
					TARGET = true,
					EXTRA = true,
				},
			},
		},
	},
}

RSA.monitorData.racials, RSA.configData.racials = RSA.PrepareDataTables(defaults)