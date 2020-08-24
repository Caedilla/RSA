local RSA = RSA or LibStub('AceAddon-3.0'):GetAddon('RSA')
local L = LibStub('AceLocale-3.0'):GetLocale('RSA')
local LDS = LibStub('LibDualSpec-1.0')
local localisedClass, uClass = UnitClass('player')
uClass = string.lower(uClass)
RSA.Options = RSA:NewModule('Options')

local colors = {
	['titles'] = 'FF00DBBD',
	['descriptions'] = 'FFD1D1D1',
	['deepRed'] = 'FFCF374D',
	['orange'] = 'FFFF8019',
	['green'] = 'FF91BE0F',
	['gold'] = 'FFFFCC00',
	['blue'] = 'FF00B2FA',
}

-- TODO fill in the rest of the event types.
local eventList = {
	["SPELL_HEAL"] = L["Heal"],
	["SPELL_CAST_SUCCESS"] = L["Cast"],
	["SPELL_AURA_APPLIED"] = L["Start"],
	["SPELL_AURA_REMOVED"] = L["End"],
}

local eventOrder = {
	["SPELL_HEAL"] = 6,
	["SPELL_CAST_SUCCESS"] = 3,
	["SPELL_AURA_APPLIED"] = 1,
	["SPELL_AURA_REMOVED"] = 14,

}

local eventDescriptions = {
	['SPELL_AURA_APPLIED'] = 'When you start casting this spell or when this spell starts.',
	--[2] = 'When you have placed this in the world.',
	['SPELL_CAST_SUCCESS'] = 'When you cast this spell.',
	--[4] = 'When you dispel a buff or debuff.',
	--[5] = 'When you deal damage.',
	['SPELL_HEAL'] = 'When you heal.',
	--[7] = 'When you debuff a unit.',
	--[8] = 'When you absorb damage.',
	--[9] = 'When you absorb a debuff.',
	--[10] = 'When you interrupt a spell cast.',
	--[11] = 'When your spell is resisted.',
	--[12] = 'When the target is immune to your spell.',
	--[13] = 'When the spell failed.',
	['SPELL_AURA_REMOVED'] = 'When the spell ends.',
	--[15] = 'When you cast Provoke on your Statue of the Black Ox.',
	--[16] = 'When someone accepts the resurrect you cast on them.',
}

local channels = {
	'say',
	'yell',
	'emote',
	'party',
	'raid',
	'instance',
	'personal',
	'smartGroup',
	'whisper',
}

local channelStrings = {
	['smartGroup'] = 'Smart Group Channel',
	['personal'] = 'Local Output',
}

local channelOrder = {
	['say'] = 1,
	['yell'] = 2,
	['emote'] = 3,
	['party'] = 4,
	['raid'] = 5,
	['instance'] = 6,
	['personal'] = 7,
	['smartGroup'] = 8,
	['whisper'] = 9,
}

local channelColor = {
	['say'] = colors['deepRed'],
	['yell'] = colors['deepRed'],
	['emote'] = colors['deepRed'],
	['party'] = colors['green'],
	['raid'] = colors['green'],
	['instance'] = colors['green'],
	['personal'] = colors['blue'],
	['smartGroup'] = colors['gold'],
	['whisper'] = colors['gold'],
}

local channelDescriptions = {
	['say'] = L["%s can only function inside instances since 8.2.5."]:format(L["Say"]),
	['yell'] = L["%s can only function inside instances since 8.2.5."]:format(L["Yell"]),
	['emote'] = '',
	['party'] = L["Sends a message to one of the following channels in order of priority:"] .. '\n' .. L["|cff91BE0F/party|r if you're in a manually formed group."] .. '\n' .. L["|cff91BE0F/instance|r if you're in an instance group such as when in LFR or Battlegrounds."],
	['raid'] = L["Sends a message to one of the following channels in order of priority:"] .. '\n' .. L["|cff91BE0F/raid|r if you're in a manually formed raid."] .. '\n' .. L["|cff91BE0F/instance|r if you're in an instance group such as when in LFR or Battlegrounds."],
	['instance'] = L["|cff91BE0F/instance|r if you're in an instance group such as when in LFR or Battlegrounds."],
	['personal'] = L["Sends a message locally only visible to you. To choose which part of the UI this is displayed in go to the |cff00B2FALocal Message Output Area|r in the General options."],
	['smartGroup'] = L["Sends a message to one of the following channels in order of priority:"] .. '\n' .. L["|cff91BE0F/instance|r if you're in an instance group such as when in LFR or Battlegrounds."] .. '\n' .. L["|cff91BE0F/raid|r if you're in a manually formed raid."] .. '\n' .. L["|cff91BE0F/party|r if you're in a manually formed group."],
	['whisper'] = L["|cffFFCC00Whispers|r the target of the spell."],
}

local function GetChannelColor(channel)
	if channelColor[channel] then
		return channelColor[channel]
	else
		return 'FF00FFFF'
	end
end

local function GetChannelName(channel)
	local globalString = _G[string.upper(channel)] or nil
	if channelStrings[channel] then
		return channelStrings[channel]
	elseif globalString then
		return globalString
	end
end

local function GetEventName(event)
	if eventList[event] then
		return eventList[event]
	else
		return event
	end
end

local function GetEventDescription(event)
	if eventDescriptions[event] then
		return eventDescriptions[event]
	else
		return event
	end
end

local function GetEventOrder(event)
	if eventOrder[event] then
		return eventOrder[event]
	else
		return 100
	end
end

local function BaseOptions()
	local optionsTable = {
		type = 'group',
		name = "RSA [|c5500DBBDRaeli's Spell Announcer|r] r|c5500DBBD" .. RSA.db.global.revision .. '|r',
		order = 0,
		args = {
			general = {
				name = L["General"],
				type = 'group',
				order = 0,
				args = {
					moduleSettings = {
						name = L["Module Settings"],
						type = 'header',
						order = 0,
						hidden = true,
					},
					groupToggles = {
						name = '|c' .. colors['deepRed'] .. L["Channel Options"] .. '|r',
						type = 'group',
						inline = true,
						order = 100.2,
						args = {
							emote = {
								name = '|c' .. colors['deepRed'] .. L["%s only while grouped"]:format(_G['EMOTE']) .. '|r',
								type = 'toggle',
								desc = L["Allow announcements in /%s only when you are in a group."]:format(_G['EMOTE']),
								width = 'double',
								get = function(info)
									return RSA.db.profile.general.globalAnnouncements.groupToggles.emote
								end,
								set = function (info, value)
									RSA.db.profile.general.globalAnnouncements.groupToggles.emote = value
								end,
							},
							say = {
								name = '|c' .. colors['deepRed'] .. L["%s only while grouped"]:format(_G['SAY']) .. '|r',
								type = 'toggle',
								desc = L["Allow announcements in /%s only when you are in a group."]:format(_G['SAY']),
								width = 'double',
								get = function(info)
									return RSA.db.profile.general.globalAnnouncements.groupToggles.say
								end,
								set = function (info, value)
									RSA.db.profile.general.globalAnnouncements.groupToggles.say = value
								end,
							},
							yell = {
								name = '|c' .. colors['deepRed'] .. L["%s only while grouped"]:format(_G['YELL']) .. '|r',
								type = 'toggle',
								desc = L["Allow announcements in /%s only when you are in a group."]:format(_G['YELL']),
								width = 'double',
								get = function(info)
									return RSA.db.profile.general.globalAnnouncements.groupToggles.yell
								end,
								set = function (info, value)
									RSA.db.profile.general.globalAnnouncements.groupToggles.yell = value
								end,
							},
							whisper = {
								name = '|c' .. colors['deepRed'] .. L["%s only while grouped"]:format(_G['WHISPER']) .. '|r',
								type = 'toggle',
								desc = L["Allow announcements in /%s only when you are in a group."]:format(_G['WHISPER']),
								width = 'double',
								get = function(info)
									return RSA.db.profile.general.globalAnnouncements.groupToggles.whisper
								end,
								set = function (info, value)
									RSA.db.profile.general.globalAnnouncements.groupToggles.whisper = value
								end,
							},
						},
					},
					enableInPVPAreas = {
						name = '|c' .. colors['orange'] .. L["PvP Options"] .. '|r',
						type = 'group',
						inline = true,
						order = 100.3,
						args = {
							arenas = {
								name = '|c' .. colors['orange'] .. L["Enable in Arenas"] .. '|r',
								type = 'toggle',
								order = 0,
								width = 'double',
								get = function(info)
									return RSA.db.profile.general.globalAnnouncements.arenas
								end,
								set = function(info, value)
									RSA.db.profile.general.globalAnnouncements.arenas = value
								end,
							},
							bgs = {
								name = '|c' .. colors['orange'] .. L["Enable in Battlegrounds"] .. '|r',
								type = 'toggle',
								order = 0,
								width = 'double',
								get = function(info)
									return RSA.db.profile.general.globalAnnouncements.bgs
								end,
								set = function(info, value)
									RSA.db.profile.general.globalAnnouncements.bgs = value
								end,
							},
							warModeWorld = {
								name = '|c' .. colors['orange'] .. L["Enable in War Mode"] .. '|r',
								type = 'toggle',
								order = 1,
								desc = L["Enable in the non-instanced world area when playing with War Mode %s."]:format(L["turned on"]),
								descStyle = 'inline',
								width = 'double',
								get = function(info)
									return RSA.db.profile.general.globalAnnouncements.warModeWorld
								end,
								set = function(info, value)
									RSA.db.profile.general.globalAnnouncements.warModeWorld = value
								end,
							},
						},
					},
					enableInPvEAreas = {
						name = '|c' .. colors['green'] .. L["PvE Options"] .. '|r',
						type = 'group',
						inline = true,
						order = 100.4,
						args = {
							dungeons = {
								name = '|c' .. colors['green'] .. L["Enable in Dungeons"] .. '|r',
								type = 'toggle',
								order = 0,
								desc = L["Enable in manually formed dungeon groups."],
								descStyle = 'inline',
								width = 'double',
								get = function(info)
									return RSA.db.profile.general.globalAnnouncements.dungeons
								end,
								set = function(info, value)
									RSA.db.profile.general.globalAnnouncements.dungeons = value
								end,
							},
							raids = {
								name = '|c' .. colors['green'] .. L["Enable in Raid Instances"] .. '|r',
								type = 'toggle',
								order = 0,
								desc = L["Enable in manually formed raid groups."],
								descStyle = 'inline',
								width = 'double',
								get = function(info)
									return RSA.db.profile.general.globalAnnouncements.raids
								end,
								set = function(info, value)
									RSA.db.profile.general.globalAnnouncements.raids = value
								end,
							},
							lfg = {
								name = '|c' .. colors['green'] .. L["Enable in Group Finder Dungeons"] .. '|r',
								type = 'toggle',
								order = 1,
								width = 'double',
								get = function(info)
									return RSA.db.profile.general.globalAnnouncements.lfg
								end,
								set = function(info, value)
									RSA.db.profile.general.globalAnnouncements.lfg = value
								end,
							},
							lfr = {
								name = '|c' .. colors['green'] .. L["Enable in Group Finder Raids"] .. '|r',
								type = 'toggle',
								order = 1,
								width = 'double',
								get = function(info)
									return RSA.db.profile.general.globalAnnouncements.lfr
								end,
								set = function(info, value)
									RSA.db.profile.general.globalAnnouncements.lfr = value
								end,
							},
							scenarios = {
								name = '|c' .. colors['green'] .. L["Enable in Scenarios"] .. '|r',
								type = 'toggle',
								order = 2,
								desc = L["Enable in scenario instances."],
								descStyle = 'inline',
								width = 'double',
								get = function(info)
									return RSA.db.profile.general.globalAnnouncements.scenarios
								end,
								set = function(info, value)
									RSA.db.profile.general.globalAnnouncements.scenarios = value
								end,
							},
							nonWarWorld = {
								name = '|c' .. colors['green'] .. L["Enable in the World"] .. '|r',
								type = 'toggle',
								order = 2,
								desc = L["Enable in the non-instanced world area when playing with War Mode %s."]:format(L["turned off"]),
								descStyle = 'inline',
								width = 'double',
								get = function(info)
									return RSA.db.profile.general.globalAnnouncements.nonWarWorld
								end,
								set = function(info, value)
									RSA.db.profile.general.globalAnnouncements.nonWarWorld = value
								end,
							},
						},
					},
					combatState = {
						name = '|c' .. colors['gold'] .. L["Other Options"] .. '|r',
						type = 'group',
						inline = true,
						order = 100.5,
						args = {
							inCombat = {
								name = '|c' .. colors['gold'] .. L["Enable in Combat"] .. '|r',
								type = 'toggle',
								order = 110,
								desc = L["Allow announcements if you are in combat."],
								descStyle = 'inline',
								width = 'double',
								get = function(info)
									return RSA.db.profile.general.globalAnnouncements.combatState.inCombat
								end,
								set = function(info, value)
									RSA.db.profile.general.globalAnnouncements.combatState.inCombat = value
								end,
							},
							noCombat = {
								name = '|c' .. colors['gold'] .. L["Enable out of Combat"] .. '|r',
								type = 'toggle',
								order = 110,
								desc = L["Allow announcements if you are not in combat."],
								descStyle = 'inline',
								width = 'double',
								get = function(info)
									return RSA.db.profile.general.globalAnnouncements.combatState.noCombat
								end,
								set = function(info, value)
									RSA.db.profile.general.globalAnnouncements.combatState.noCombat = value
								end,
							},
							alwaysWhisper = {
								name = '|c' .. colors['gold'] .. L["Always allow Whispers"] .. '|r',
								type = 'toggle',
								order = 110,
								desc = L["Always allow whispers to be sent, ignoring the PvP and PvE Options on this page."],
								descStyle = 'inline',
								width = 'double',
								get = function(info)
									return RSA.db.profile.general.globalAnnouncements.alwaysWhisper
								end,
								set = function(info, value)
									RSA.db.profile.general.globalAnnouncements.alwaysWhisper = value
								end,
							},
						},
					},
				},
			},
			spells = {
				name = L["Announcements"],
				type = 'group',
				childGroups = 'tab',
				order = 1,
				args = {
					Racials = {
						name = L["Racials"],
						type = 'group',
						args = {
							Disabled_Notification = {
								name = 'Coming Soon',
								type = 'description',
								order = 0.02,
								fontSize = 'large',
							},
						},
					},
					Utilities = {
						name = L["Utilities"],
						type = 'group',
						args = {
							Disabled_Notification = {
								name = 'Coming Soon',
								type = 'description',
								order = 0.03,
								fontSize = 'large',
							},
						},
					},
				},
			},
			tags = {
				name = L["Tag Options"],
				type = 'group',
				order = 10,
				args = {
					Target = {
						name = '|c5500DBBD[TARGET]|r ' .. L["Tag Options"],
						type = 'group',
						order = 10,
						inline = true,
						args = {
							removeServerNames = {
								name = '|c' .. colors['gold'] .. L["Remove Server Names"] .. '|r',
								type = 'toggle',
								order = 0,
								desc = L["Removes server name from |c5500DBBD[TARGET]|r tags."],
								descStyle = 'inline',
								width = 'double',
								get = function(info)
									return RSA.db.profile.general.globalAnnouncements.removeServerNames
								end,
								set = function(info, value)
									RSA.db.profile.general.globalAnnouncements.removeServerNames = value
								end,
							},
							AlwaysUseName = {
								name = '|c' .. colors['gold'] .. L["Always uses spell target's name"] .. '|r',
								type = 'toggle',
								order = 10,
								desc = L["If selected, |c5500DBBD[TARGET]|r will always use the spell target's name, rather than using the input below for whispers."],
								descStyle = 'inline',
								width = 'full',
								get = function(info)
									return RSA.db.profile.general.replacements.target.alwaysUseName
								end,
								set = function(info, value)
									RSA.db.profile.general.replacements.target.alwaysUseName = value
								end,
							},
							Replacement = {
								name = L["Replacement"],
								desc = L["|c5500DBBD[TARGET]|r will be replaced with this when whispering someone."],
								type = 'input',
								order = 10.1,
								width = 'double',
								disabled = function()
									if RSA.db.profile.general.replacements.target.alwaysUseName == true then
										return true
									else
										return false
									end
								end,
								get = function(info)
									return RSA.db.profile.general.replacements.target.replacement
								end,
								set = function(info, value)
									RSA.db.profile.general.replacements.target.replacement = value
								end,
							},
						},
					},
					missType = {
						name = '|c5500DBBD[MISSTYPE]|r ' .. L["Tag Options"],
						type = 'group',
						order = 20,
						inline = true,
						args = {
							useGeneralReplacement = {
								name = '|c' .. colors['gold'] .. L["Use Single Replacement"] .. '|r',
								type = 'toggle',
								order = 10,
								desc = L["If selected, |c5500DBBD[MISSTYPE]|r will always use the General Replacement set below."] .. '\n' .. L["Does not affect Immune, Immune will always use its own replacement."],
								descStyle = 'inline',
								width = 'full',
								get = function(info)
									return RSA.db.profile.general.replacements.missType.useGeneralReplacement
								end,
								set = function(info, value)
									RSA.db.profile.general.replacements.missType.useGeneralReplacement = value
								end,
							},
							generalReplacement = {
								name = L["General Replacement"],
								desc = L["Whether the target blocks, dodges, absorbs etc. your attack, |c5500DBBD[MISSTYPE]|r will be replaced to this."],
								type = 'input',
								order = 10.1,
								width = 'double',
								disabled = function()
									if RSA.db.profile.general.replacements.missType.useGeneralReplacement == false then
										return true
									else
										return false
									end
								end,
								get = function(info)
									return RSA.db.profile.general.replacements.missType.generalReplacement
								end,
								set = function(info, value)
									RSA.db.profile.general.replacements.missType.generalReplacement = value
								end,
							},
							generalReplacementSpacer = {
								name = ' ',
								type = 'description',
								order = 10.2,
							},
							miss = {
								name = MISS,
								desc = L["When your spell misses the target |c5500DBBD[MISSTYPE]|r will be replaced with this."],
								type = 'input',
								order = 20.1,
								width = 'double',
								disabled = function()
									if RSA.db.profile.general.replacements.missType.useGeneralReplacement == true then
										return true
									else
										return false
									end
								end,
								get = function(info)
									return RSA.db.profile.general.replacements.missType.miss
								end,
								set = function(info, value)
									RSA.db.profile.general.replacements.missType.miss = value
								end,
							},
							resist = {
								name = RESIST,
								desc = L["When the target resists your spell |c5500DBBD[MISSTYPE]|r will be replaced with this."],
								type = 'input',
								order = 20.1,
								width = 'double',
								disabled = function()
									if RSA.db.profile.general.replacements.missType.useGeneralReplacement == true then
										return true
									else
										return false
									end
								end,
								get = function(info)
									return RSA.db.profile.general.replacements.missType.resist
								end,
								set = function(info, value)
									RSA.db.profile.general.replacements.missType.resist = value
								end,
							},
							absorb = {
								name = ABSORB,
								desc = L["When the target absorbs your spell |c5500DBBD[MISSTYPE]|r will be replaced with this."],
								type = 'input',
								order = 20.1,
								width = 'double',
								disabled = function()
									if RSA.db.profile.general.replacements.missType.useGeneralReplacement == true then
										return true
									else
										return false
									end
								end,
								get = function(info)
									return RSA.db.profile.general.replacements.missType.absorb
								end,
								set = function(info, value)
									RSA.db.profile.general.replacements.missType.absorb = value
								end,
							},
							block = {
								name = BLOCK,
								desc = L["When the target blocks your spell |c5500DBBD[MISSTYPE]|r will be replaced with this."],
								type = 'input',
								order = 20.1,
								width = 'double',
								disabled = function()
									if RSA.db.profile.general.replacements.missType.useGeneralReplacement == true then
										return true
									else
										return false
									end
								end,
								get = function(info)
									return RSA.db.profile.general.replacements.missType.block
								end,
								set = function(info, value)
									RSA.db.profile.general.replacements.missType.block = value
								end,
							},
							deflect = {
								name = DEFLECT,
								desc = L["When the target deflects your spell |c5500DBBD[MISSTYPE]|r will be replaced with this."],
								type = 'input',
								order = 20.1,
								width = 'double',
								disabled = function()
									if RSA.db.profile.general.replacements.missType.useGeneralReplacement == true then
										return true
									else
										return false
									end
								end,
								get = function(info)
									return RSA.db.profile.general.replacements.missType.deflect
								end,
								set = function(info, value)
									RSA.db.profile.general.replacements.missType.deflect = value
								end,
							},
							dodge = {
								name = DODGE,
								desc = L["When the target dodges your spell |c5500DBBD[MISSTYPE]|r will be replaced with this."],
								type = 'input',
								order = 20.1,
								width = 'double',
								disabled = function()
									if RSA.db.profile.general.replacements.missType.useGeneralReplacement == true then
										return true
									else
										return false
									end
								end,
								get = function(info)
									return RSA.db.profile.general.replacements.missType.dodge
								end,
								set = function(info, value)
									RSA.db.profile.general.replacements.missType.dodge = value
								end,
							},
							evade = {
								name = EVADE,
								desc = L["When the target evades your spell |c5500DBBD[MISSTYPE]|r will be replaced with this."],
								type = 'input',
								order = 20.1,
								width = 'double',
								disabled = function()
									if RSA.db.profile.general.replacements.missType.useGeneralReplacement == true then
										return true
									else
										return false
									end
								end,
								get = function(info)
									return RSA.db.profile.general.replacements.missType.evade
								end,
								set = function(info, value)
									RSA.db.profile.general.replacements.missType.evade = value
								end,
							},
							parry = {
								name = PARRY,
								desc = L["When the target parries your spell |c5500DBBD[MISSTYPE]|r will be replaced with this."],
								type = 'input',
								order = 20.1,
								width = 'double',
								disabled = function()
									if RSA.db.profile.general.replacements.missType.useGeneralReplacement == true then
										return true
									else
										return false
									end
								end,
								get = function(info)
									return RSA.db.profile.general.replacements.missType.parry
								end,
								set = function(info, value)
									RSA.db.profile.general.replacements.missType.parry = value
								end,
							},
							immune = {
								name = IMMUNE,
								desc = L["When the target is immune to your spell |c5500DBBD[MISSTYPE]|r will be replaced with this."],
								type = 'input',
								order = 20.1,
								width = 'double',
								get = function(info)
									return RSA.db.profile.general.replacements.missType.immune
								end,
								set = function(info, value)
									RSA.db.profile.general.replacements.missType.immune = value
								end,
							},
							reflect = {
								name = REFLECT,
								desc = L["When the target reflects your spell |c5500DBBD[MISSTYPE]|r will be replaced with this."],
								type = 'input',
								order = 20.1,
								width = 'double',
								disabled = function()
									if RSA.db.profile.general.replacements.missType.useGeneralReplacement == true then
										return true
									else
										return false
									end
								end,
								get = function(info)
									return RSA.db.profile.general.replacements.missType.reflect
								end,
								set = function(info, value)
									RSA.db.profile.general.replacements.missType.reflect = value
								end,
							},
						},
					},
				},
			},
			Feedback = {
				name = L["Feedback"],
				type = 'group',
				order = 1000,
				args = {
					Head = {
						name = L["Feedback"],
						type = 'header',
						order = 0,
					},
					Revision = {
						name = "|cffFFCC00" .. L["Current Version: %s"]:format("r|r|c5500DBBD" .. RSA.db.global.revision) .. "|r",
						type = 'description',
						order = 0.5,
						fontSize = 'large',
					},
					RevisionDescription = {
						name = L["When reporting an issue, please also post the revision number above. Thanks!"],
						type = 'description',
						order = 0.6,
					},
					Spacer_FeedbackOnline = {
						name = '\n',
						type = 'description',
						order = 1,
					},
					Curseforge_Header = {
						name = '|c' .. colors['green'] .. L["Curseforge"] .. '|r',
						type = 'description',
						order = 50,
						fontSize = 'large',
					},
					Curseforge_URL = {
						name = L["URL"],
						type = 'input',
						order = 50.2,
						width = 'full',
						get = function() return 'https://wow.curseforge.com/projects/rsa/issues' end,
						set = function() return 'https://wow.curseforge.com/projects/rsa/issues' end,
					},
					Spacer_OnlineCommunity = {
						name = '\n\n',
						type = 'description',
						order = 75,
					},
					Community_Header = {
						name = '|cff00B2FA' .. L["Discord"] .. '|r',
						type = 'description',
						order = 100,
						fontSize = 'large',
					},
					Community_URL = {
						name = L["Invite Link"],
						type = 'input',
						order = 100.2,
						width = 'full',
						get = function() return 'https://discord.gg/99QZ6sd' end,
						set = function() return 'https://discord.gg/99QZ6sd' end,
					},
				},
			},
			--[[CommunityTest = {
				name = 'TEST',
				type = 'group',
				args = {
					List = {
						name = 'List of Communities',
						type = 'select',
						values = ListNames,
					},
					Channels ={
						name = 'Channels',
						type = 'select',
						values = ListChannels,
					},
				},
			},]]--
		},
	}

	return optionsTable
end

local function GetSpellConfigName(selected)
	local configDisplay = selected.configDisplay
	if configDisplay.customName then
		return configDisplay.customName
	else
		return GetSpellInfo(selected.spellID)
	end
end

local function GetSpellConfigDesc(selected)
	local configDisplay = selected.configDisplay
	if configDisplay.customDesc then
		return configDisplay.customDesc
	else
		return GetSpellDescription(selected.spellID)
	end
end

local function GenerateClassOptions()
	local optionsData = RSA.db.profile[uClass]
	if not optionsData then return
		{
			name = localisedClass,
			type = 'group',
			args = {
				missing = {
					name = "Missing class options.",
					type = 'description',
					order = 0.02,
					fontSize = 'large',
				},
			},
		}
	end

	local optionsTable = {
		name = localisedClass,
		type = 'group',
		order = 0,
		args = {
		},
	}

	for k in pairs(optionsData) do
		local selected = optionsData[k]
		local configDisplay = selected.configDisplay
		optionsTable.args[selected.profile] = {
			name = GetSpellConfigName(selected),
			desc = GetSpellConfigDesc(selected),
			hidden = configDisplay.hidden or false,
			disabled = configDisplay.disabled or false,
			order = configDisplay.order or 50,
			type = 'group',
			childGroups = 'tab',
			args = {
				title = {
					--name = '|cFF00DBBD' .. L["Configuring"] .. ':|r ' .. GetSpellConfigName(selected),
					name = '|c' .. colors['titles'] .. L["Configuring:|r %s"]:format(GetSpellConfigName(selected)),
					type = 'description',
					order = 1,
					fontSize = 'large',
				},
				description = {
					--name = '|cffd1d1d1' .. Spells[i].Desc .. '|r',
					name = '|c' .. colors['descriptions'] .. GetSpellConfigDesc(selected) .. '|r',
					type = 'description',
					order = 1.01,
				},
			},
		}

		for i = 1, #configDisplay.messageAreas do
			local event = configDisplay.messageAreas[i]

			optionsTable.args[selected.profile].args[event] = {
				name = GetEventName(event),
				type = 'group',
				order = 100 + GetEventOrder(event),
				args = {
					eventDescription = {
						name = '|c' .. colors['titles'] .. GetEventName(event) .. ':|r ' .. '|c' .. colors['descriptions'] .. GetEventDescription(event) .. '|r\n',
						type = 'description',
						order = 0,
						fontSize = 'medium',
					},
					addNewMessage = {
						name = L["Add New Message"],
						type = 'input',
						order = 10,
						width = 'full',
						 -- TODO Move out and reuse same func in messages.
						validate = function(info, value)
							if value == '' then return true end -- Pressed enter without entering anything, we don't need to warn about this.
							if not string.match(value,'%w') then
								RSA.SendMessage.ChatFrame(L["Your message must contain at least one number or letter!"])
								return L["Your message must contain at least one number or letter!"]
							else
								return true
							end
						end,
						set = function(info, value)
							table.insert(RSA.db.profile[uClass][k].events[event].messages, value)
							RSA.Options:UpdateOptions()
							RSA:WipeMessageCache()
						end,
					},
					numMessagesDescription = {
						name = 'temp',
						type = 'description',
						order = 11,
						fontSize = 'medium',
					},
					currentMessages = {
						name = '|c' .. colors['titles'] .. L["Current Messages:"] .. '|r',
						type = 'description',
						order = 12,
						fontSize = 'medium',
						hidden = #selected.events[event].messages <1,
					}
				},
			}
			local numMessages = #selected.events[event].messages

			if numMessages == 0 then
				optionsTable.args[selected.profile].args[event].args.numMessagesDescription.name = '\n'.. L["You have no messages for this section."]..L[" If you wish to add a message for this section, enter it above in the |cffFFD100Add New Message|r box. As no messages exist, nothing will be announced for this section."]
			elseif numMessages == 1 then
				optionsTable.args[selected.profile].args[event].args.numMessagesDescription.name = '\n'.. L["You have %d message for this section."]:format(numMessages)..L[" RSA will choose a message from this section at random, if you wish to remove a message, delete the contents and press enter. If no messages exist, nothing will be announced for this section."]
			else
				optionsTable.args[selected.profile].args[event].args.numMessagesDescription.name = '\n'.. L["You have %d messages for this section."]:format(numMessages)..L[" RSA will choose a message from this section at random, if you wish to remove a message, delete the contents and press enter. If no messages exist, nothing will be announced for this section."]
			end

			for m = 1, numMessages do
				local curMessage = selected.events[event].messages[m]
				local curNumAsString = tostring(m)

				optionsTable.args[selected.profile].args[event].args[curNumAsString] = {
					name = '',
					type = 'input',
					order = 20,
					width = 'full',
					validate = function(info, value)
						if value == '' then return true end
						if not string.match(value,'%w') then
							RSA.SendMessage.ChatFrame(L["Your message must contain at least one number or letter!"])
							return L["Your message must contain at least one number or letter!"]
						else
							return true
						end
					end,
					get = function(info)
						if curMessage == '' then
							table.remove(RSA.db.profile[uClass][k].events[event].messages,m)
						end
						RSA.Options:UpdateOptions()
						return curMessage
					end,
					set = function(info, value)
						if value == '' then
							RSA.db.profile[uClass][k].events[event].messages[m] = ''
						else
							RSA.db.profile[uClass][k].events[event].messages[m] = value
						end
						RSA.Options:UpdateOptions()
						RSA:WipeMessageCache()
					end,
				}

			end

			for c = 1, #channels do
				optionsTable.args[selected.profile].args[event].args[channels[c]] = {
					name = '|c' .. GetChannelColor(channels[c]) .. L[GetChannelName(channels[c])] .. '|r',
					type = 'toggle',
					order = 0.11 + channelOrder[channels[c]],
					desc = channelDescriptions[channels[c]] or nil,
					hidden = function()
						if configDisplay.disabledChannels then
							if configDisplay.disabledChannels[channels[c]] then
								return true
							end
						end
					end,
					get = function(info)
						return RSA.db.profile[uClass][k].events[event].channels[channels[c]]
					end,
					set = function (info, value)
						RSA.db.profile[uClass][k].events[event].channels[channels[c]] = value
					end,
				}
			end

			-- TODO implement environments for each spell, essentially a mirror of global options.

		end
	end

	return optionsTable
end

function RSA:RegisterOptions()
	local optionsTable = BaseOptions()
	LibStub('AceConfig-3.0'):RegisterOptionsTable('RSA', optionsTable)

	local profiles = LibStub('AceDBOptions-3.0'):GetOptionsTable(self.db)
	optionsTable.args.profiles = profiles
	optionsTable.args.profiles.order = 100

	optionsTable.args.general.args.output = RSA:GetSinkAce3OptionsDataTable() -- Add LibSink Options.
	optionsTable.args.general.args.output.args.Channel = nil -- We don't want to display this, and it's broken since 8.2.5 anyway.
	optionsTable.args.general.args.output.name = '|c' .. colors['blue'] .. L["Local Message Output Area"] .. '|r'
	optionsTable.args.general.args.output.order = 100.6
	optionsTable.args.general.args.output.inline = true

	for k in pairs(optionsTable.args.general.args.output.args) do
		optionsTable.args.general.args.output.args[k].name = '|c' .. colors['blue'] .. optionsTable.args.general.args.output.args[k].name .. '|r'
	end

	optionsTable.args.spells.args[uClass] = GenerateClassOptions()
	LDS:EnhanceDatabase(self.db, 'RSA')
	LDS:EnhanceOptions(profiles, self.db)
end

function RSA.Options:UpdateOptions()
	RSA:RegisterOptions()
	LibStub('AceConfigRegistry-3.0'):NotifyChange('RSA')
end

function RSA.Options:OnInitialize()
	self.db = RSA.db
	RSA:SetSinkStorage(self.db.profile) -- Setup Saved Variables for LibSink

	RSA:RegisterOptions()
	LibStub('AceConfigDialog-3.0'):SetDefaultSize('RSA',985,750)
	InterfaceAddOnsList_Update()

	self.db.RegisterCallback(RSA, 'OnProfileChanged', 'RefreshConfig')
	self.db.RegisterCallback(RSA, 'OnProfileCopied', 'RefreshConfig')
	self.db.RegisterCallback(RSA, 'OnProfileReset', 'RefreshConfig')
end

function RSA:RefreshConfig()
	RSA.db.profile = self.db.profile
	RSA.Options:UpdateOptions()
end