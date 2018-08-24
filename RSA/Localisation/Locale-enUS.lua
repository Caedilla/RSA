local L = LibStub("AceLocale-3.0"):NewLocale("RSA", "enUS", true)
if not L then return end
L = L or {}

---- Base Localisation
L["Corpse of "] = true -- Tooltip mouseover of a released corpse.
L["Couldn't find target for Soulstone."] = true -- Invalid Target warning for Soulstone

L[" is Missing!"] = true
L[" Refreshed!"] = true

L["You"] = true
L["missed"] = true
L["was resisted by"] = true
L["was absorbed by"] = true
L["was blocked by"] = true
L["was deflected by"] = true
L["was dodged by"] = true
L["was evaded by"] = true
L["was parried by"] = true
L["Immune"] = true
L["Unknown"] = true


---- Options

-- General Tab
L["General"] = true
L["Module Settings"] = true
L["Enable Buff Reminder Module"] = true
L["Smart Channel Options"] = true
L["Smart Say"] = true
L["Only announce in /yell while you are in a manually formed group."] = true
L["Smart Yell"] = true
L["Only announce in /say while you are in a manually formed group."] = true
L["Smart Custom Channel"] = true
L["Announce to custom channels only while you are in a manually formed group."] = true

L["PvP Options"] = true
L["Enable in Arenas"] = true
L["Enable in Battlegrounds"] = true
L["Enable in War Mode"] = true
L["Enable in the world area if you have War Mode active."] = true

L["PvE Options"] = true
L["Enable in Dungeons"] = true
L["Enable in manually formed dungeon groups."] = true
L["Enable in Raid Instances"] = true
L["Enable in manually formed raid groups."] = true
L["Enable in Group Finder Dungeons"] = true
L["Enable in Group Finder Raids"] = true
L["Enable in Scenarios"] = true
L["Enable in scenario instances."] = true
L["Enable in the World"] = true
L["Enable in the world area when playing with War Mode disabled."] = true

L["Other Options"] = true
L["Enable Only in Combat"] = true
L["Only announce if you are in combat."] = true
L["Remove Server Names"] = true

L["Local Message Output Area"] = true

-- Spells Tab
L["Spells"] = true
L["Class Abilities"] = true
L["Racials"] = true
L["Utilities"] = true

L["Configuring"] = true

L["Message Announce Area"] = true
L["Say"] = true
L["Yell"] = true
L["Emote"] = true
L["Custom Channel"] = true
L["Send to player created channel."] = true
L["Channel Name"] = true
L["Only usable for player created channels, do not use for Blizzard channels such as |cff91BE0F/party|r."] = true
L["Raid"] = true
L["Party"] = true
L["Local"] = true
L["Whisper"] = true
L["Smart Group Channel"] = true


L["|cff91BE0F/raid|r. Only for manually formed raid groups."] = true
L["|cff91BE0F/party|r. Only for manually formed parties."] = true
L["Doesn't do anything in group finder parties, use |cffFFCC00Instance|r or |cffFFCC00Smart Group Channel|r for that."] = true





L["Sends a message locally only visible to you. To choose which part of the UI this is displayed in go to the |cff00B2FALocal Message Output Area|r in the General options."] = true



L["|cffFFCC00Whispers|r the target of the spell."] = true
L["This setting also does not follow the global announcement settings, and will, if checked, announce regardless of those settings."] = true




L["|cff91BE0F/raid|r if you're in a raid."] = true
L["|cff91BE0F/party|r if you're in a dungeon."] = true
L["|cff91BE0F/instance|r if you're in a group finder group."] = true

L["Message Texts"] = true
L["The following tags are available for use with this spell:"] = true

L["Cast"] = true
L["Placed"] = true
L["Start"] = true
L["Heal"] = true
L["Success"] = true
L["Damage"] = true
L["Debuff"] = true
L["Dispel"] = true
L["Interrupt"] = true
L["Resist"] = true
L["Immune"] = true
L["End"] = true
L["StatueOfTheBlackOx"] = "Black Ox AoE Taunt"

L["Add New Message"] = true
L["You have no messages for this section."] = true
L[" If you wish to add a message for this section, enter it above in the |cffFFD100Add New Message|r box. As no messages exist, nothing will be announced for this section."] = true
L["You have "] = true
L[" message for this section."] = true
L[" messages for this section."] = true
L[" RSA will choose a message from this section at random, if you wish to remove a message, delete the contents and press enter. If no messages exist, nothing will be announced for this section."] = true
L["This section requires LibResInfo-1.0 to work. As you don't have it, nothing from this section will announce."] = true



L["Feedback"] = true
L["Current Revision"] = true
L["When reporting an issue, please also post the revision number above. Thanks!"] = true
L["Online"] = true
L["If you encounter a bug, or have a feature request, please file a ticket on Curseforge using the link below."] = true
L["RSA on Curseforge"] = true
L["In Game"] = true
L["I have a Battle.net community for my addons. If you have any issues, now you can easily report them to me in game. Just copy the invite link below and throw me a message."] = true
L["Invite Link"] = true







-- Load on Demand Descriptions
L[" is disabled. If you want to configure RSA, you need to enable it."] = true
L.OptionsDisabled = "Module disabled."
L.OptionsMissing = "Module could not be found, please delete your RSA folders, download, and install again."
L.OptionsClass = " If you want to use RSA with this class, please enable the module."
