local L = LibStub("AceLocale-3.0"):NewLocale("RSA", "zhTW")
if not L then return end
L[" If you wish to add a message for this section, enter it above in the |cffFFD100Add New Message|r box. As no messages exist, nothing will be announced for this section."] = "如果你想要為此階段新增訊息，在|cffFFD100增加新訊息|r框中輸入。由於沒有訊息存在，此階段將不會有任何通告。"
L[" RSA will choose a message from this section at random, if you wish to remove a message, delete the contents and press enter. If no messages exist, nothing will be announced for this section."] = "RSA將隨機選擇本階段中的訊息，如果你要刪除訊息，請刪除訊息內容並按下Enter。如果沒有任何訊息存在，本階段將不會有任何通告。"
L["%s can only function inside instances since 8.2.5."] = "自從8.2.5以後，%s只能在副本內有用。"
--[[Translation missing --]]
L["%s only while grouped"] = "%s only while grouped"
L["|c5500DBBD[TARGET]|r will be replaced with this when whispering someone."] = "|c5500DBBD[TARGET]|r 將在密語某人時被替換。"
L["|cff91BE0F/instance|r if you're in an instance group such as when in LFR or Battlegrounds."] = "|cff91BE0F/副本|r 如果您是在如團隊搜尋器或戰場的團隊中。"
L["|cff91BE0F/party|r if you're in a manually formed group."] = "|cff91BE0F/隊伍|r 如果您在手動組建的隊伍中。"
L["|cff91BE0F/raid|r if you're in a manually formed raid."] = "|cff91BE0F/團隊|r 如果你在手動組建的團隊中。"
L["|cffFFCC00Whispers|r the target of the spell."] = "|cffFFCC00密語|r法術的目標。"
--[[Translation missing --]]
L["A custom description for this announcement in the options menu. Leave blank to use the spell name for the spell in the Spell ID field."] = "A custom description for this announcement in the options menu. Leave blank to use the spell name for the spell in the Spell ID field."
--[[Translation missing --]]
L["A custom name for this announcement in the options menu. Leave blank to use the spell name for the spell in the Spell ID field."] = "A custom name for this announcement in the options menu. Leave blank to use the spell name for the spell in the Spell ID field."
--[[Translation missing --]]
L["A Fake event supplied by RSA to allow only announcing when a SPELL_MISSED event is Immune."] = "A Fake event supplied by RSA to allow only announcing when a SPELL_MISSED event is Immune."
--[[Translation missing --]]
L["A Fake event supplied by RSA to that occurs when a player accepts a ressurect."] = "A Fake event supplied by RSA to that occurs when a player accepts a ressurect."
--[[Translation missing --]]
L["A Fake event supplied by RSA to trigger an announcement after a set number of seconds. Useful when a spell doesn't have an appropriate combat log event to track when it expires. You can modify the duration in the Spell Setup tab."] = "A Fake event supplied by RSA to trigger an announcement after a set number of seconds. Useful when a spell doesn't have an appropriate combat log event to track when it expires. You can modify the duration in the Spell Setup tab."
--[[Translation missing --]]
L["Accepted Resurrect"] = "Accepted Resurrect"
--[[Translation missing --]]
L["Add a Spell"] = "Add a Spell"
--[[Translation missing --]]
L["Add Announcement"] = "Add Announcement"
--[[Translation missing --]]
L["Add Event"] = "Add Event"
L["Add New Message"] = "增加新訊息"
--[[Translation missing --]]
L["Additional Spell IDs"] = "Additional Spell IDs"
--[[Translation missing --]]
L["Advanced Mode"] = "Advanced Mode"
--[[Translation missing --]]
L["Allow announcements if you are in combat."] = "Allow announcements if you are in combat."
--[[Translation missing --]]
L["Allow announcements if you are not in combat."] = "Allow announcements if you are not in combat."
--[[Translation missing --]]
L["Allow announcements in /%s only when you are in a group."] = "Allow announcements in /%s only when you are in a group."
--[[Translation missing --]]
L["Allows whispers to ignore the %s and %s location options on this page. Does not ignore %s."] = "Allows whispers to ignore the %s and %s location options on this page. Does not ignore %s."
L["Always allow Whispers"] = "永遠允許密語"
L["Always uses spell target's name"] = "總是使用法術目標的名稱"
--[[Translation missing --]]
L["Announcements"] = "Announcements"
--[[Translation missing --]]
L["Are you sure you want to remove this spell ID?"] = "Are you sure you want to remove this spell ID?"
--[[Translation missing --]]
L["Aura Applied"] = "Aura Applied"
--[[Translation missing --]]
L["Aura Removed"] = "Aura Removed"
--[[Translation missing --]]
L["Basic Spell Settings"] = "Basic Spell Settings"
--[[Translation missing --]]
L["Cannot configure while in combat."] = "Cannot configure while in combat."
L["Cast"] = "施放"
--[[Translation missing --]]
L["Caster & Target Settings"] = "Caster & Target Settings"
L["Cauldrons"] = "大鍋"
--[[Translation missing --]]
L["CC Broken"] = "CC Broken"
L["Channel Name"] = "頻道名稱"
--[[Translation missing --]]
L["Channel Options"] = "Channel Options"
--[[Translation missing --]]
L["Combat Log Events"] = "Combat Log Events"
--[[Translation missing --]]
L["Configure each spell's announcement settings, such as what channels to announce in and what messages to send."] = "Configure each spell's announcement settings, such as what channels to announce in and what messages to send."
--[[Translation missing --]]
L["Configure how this spell functions."] = "Configure how this spell functions."
--[[Translation missing --]]
L["Configuring:|r %s"] = "Configuring:|r %s"
--[[Translation missing --]]
L["Control the areas of the game that RSA is allowed announce in."] = "Control the areas of the game that RSA is allowed announce in."
--[[Translation missing --]]
L["Control the areas of the game this spell is allowed to be announced."] = "Control the areas of the game this spell is allowed to be announced."
--[[Translation missing --]]
L["Current Messages:"] = "Current Messages:"
L["Current Version: %s"] = "當前版本：%s"
L["Curseforge"] = true
--[[Translation missing --]]
L["Custom Caster"] = "Custom Caster"
--[[Translation missing --]]
L["Custom Description"] = "Custom Description"
--[[Translation missing --]]
L["Custom Name"] = "Custom Name"
--[[Translation missing --]]
L["Custom Target"] = "Custom Target"
L["Damage"] = "傷害"
--[[Translation missing --]]
L["Damage Absorb"] = "Damage Absorb"
--[[Translation missing --]]
L["Disabled Channels"] = "Disabled Channels"
L["Discord"] = true
L["Dispel"] = "驅散"
--[[Translation missing --]]
L["Dispel Resist"] = "Dispel Resist"
L["Does not affect Immune, Immune will always use its own replacement."] = "不影響免疫，免疫將始終使用自己的替代品。"
L["Drums"] = "戰鼓"
--[[Translation missing --]]
L["Duration"] = "Duration"
L["Enable in Arenas"] = "啟用於競技場"
L["Enable in Battlegrounds"] = "啟用於戰場"
--[[Translation missing --]]
L["Enable in Combat"] = "Enable in Combat"
L["Enable in Dungeons"] = "啟用於副本"
L["Enable in Group Finder Dungeons"] = "啟用在地城搜尋器隊伍"
L["Enable in Group Finder Raids"] = "啟用在團隊搜尋器的團隊"
L["Enable in manually formed dungeon groups."] = "啟用在手動組建的地城隊伍。"
L["Enable in manually formed raid groups."] = "啟用在手動組建的團隊。"
L["Enable in Raid Instances"] = "啟用於團隊副本"
L["Enable in scenario instances."] = "啟用在事件副本。"
L["Enable in Scenarios"] = "啟用於事件中"
--[[Translation missing --]]
L["Enable in the non-instanced world area when playing with PvP %s."] = "Enable in the non-instanced world area when playing with PvP %s."
--[[Translation missing --]]
L["Enable in the non-instanced world area when playing with War Mode %s."] = "Enable in the non-instanced world area when playing with War Mode %s."
L["Enable in the World"] = "啟用於世界環境"
L["Enable in War Mode"] = "啟用在戰爭模式"
--[[Translation missing --]]
L["Enable out of Combat"] = "Enable out of Combat"
L["End"] = "結束"
--[[Translation missing --]]
L["Environments"] = "Environments"
--[[Translation missing --]]
L["Event unique spell ID"] = "Event unique spell ID"
--[[Translation missing --]]
L["Exposes more options to allow custom setup of spells."] = "Exposes more options to allow custom setup of spells."
L["Failed"] = "失敗了"
L["Feasts"] = "盛宴"
L["Feedback"] = "反饋"
L["General Replacement"] = "一般替換"
--[[Translation missing --]]
L["Group Announcement"] = "Group Announcement"
L["Heal"] = "治療"
--[[Translation missing --]]
L["How long before this fake event triggers after any other event for this spell has been processed."] = "How long before this fake event triggers after any other event for this spell has been processed."
L["If selected, |c5500DBBD[MISSTYPE]|r will always use the General Replacement set below."] = "勾選後，|c5500DBBD[MISSTYPE]|r 將始終使用以下的一般替換設置。"
L["If selected, |c5500DBBD[TARGET]|r will always use the spell target's name, rather than using the input below for whispers."] = "勾選後，|c5500DBBD[TARGET]|r 將始終使用法術目標的名稱，而不是使用下面輸入的密語者。"
--[[Translation missing --]]
L["If this event uses a different spell ID to the primary one, enter it here."] = "If this event uses a different spell ID to the primary one, enter it here."
--[[Translation missing --]]
L["If this spell can trigger multiple events at the same time, such as if it is an AoE spell, you can start the event tracker when you trigger the spell, and set it to end on all events where you want to prevent subsequent announcements. Where multiple events can trigger the final message, you should select Spell Ends on both events."] = "If this spell can trigger multiple events at the same time, such as if it is an AoE spell, you can start the event tracker when you trigger the spell, and set it to end on all events where you want to prevent subsequent announcements. Where multiple events can trigger the final message, you should select Spell Ends on both events."
--[[Translation missing --]]
L["If this spell has multiple spell IDs, such as if you are trying to announce different Portals, or if it is modified by a talent which changes its Spell ID, you can enter those additional IDs here. Entering an ID already in the list will prompt you to remove it."] = "If this spell has multiple spell IDs, such as if you are trying to announce different Portals, or if it is modified by a talent which changes its Spell ID, you can enter those additional IDs here. Entering an ID already in the list will prompt you to remove it."
L["Interrupt"] = "中斷"
L["Invite Link"] = "邀請連結"
--[[Translation missing --]]
L["Killed"] = "Killed"
--[[Translation missing --]]
L["List of Additional Spell IDs"] = "List of Additional Spell IDs"
L["Local Message Output Area"] = "本地訊息輸出區域"
--[[Translation missing --]]
L["Local Output"] = "Local Output"
--[[Translation missing --]]
L["Manage Announcements"] = "Manage Announcements"
--[[Translation missing --]]
L["Missing options. Please report this!"] = "Missing options. Please report this!"
L["Module Settings"] = "模組設置"
--[[Translation missing --]]
L["No tracking required"] = "No tracking required"
L["Open Configuration Panel"] = "開啟設置面板"
L["Other Options"] = "其他選項"
--[[Translation missing --]]
L["Prevent duplicate announcements"] = "Prevent duplicate announcements"
--[[Translation missing --]]
L["Prevents multiple announcements from occuring within this duration. Useful for abilities that can affect multiple targets at the same time. Select 0 to disable."] = "Prevents multiple announcements from occuring within this duration. Useful for abilities that can affect multiple targets at the same time. Select 0 to disable."
--[[Translation missing --]]
L["Prevents multiple RSA users from announcing this spell."] = "Prevents multiple RSA users from announcing this spell."
--[[Translation missing --]]
L["Primary spell ID"] = "Primary spell ID"
--[[Translation missing --]]
L["Purgatory Cooldown"] = "Purgatory Cooldown"
--[[Translation missing --]]
L["PvE"] = "PvE"
L["PvE Options"] = "PvE選項"
--[[Translation missing --]]
L["PvP"] = "PvP"
L["PvP Options"] = "PvP選項"
L["Racials"] = "種族"
--[[Translation missing --]]
L["racials"] = "Racials"
--[[Translation missing --]]
L["Remove a Spell"] = "Remove a Spell"
L["Remove Server Names"] = "去除伺服器名稱"
--[[Translation missing --]]
L["Remove Spell"] = "Remove Spell"
L["Removes server name from |c5500DBBD[TARGET]|r tags."] = "移除|c5500DBBD[TARGET]|r的伺服器名稱標籤。"
L["Repair Bots"] = "修理機器人"
L["Replacement"] = "替換"
--[[Translation missing --]]
L["Resurrect"] = "Resurrect"
--[[Translation missing --]]
L["RSA takes the name and description for this to show in the configuration panel if a custom name & description are not set."] = "RSA takes the name and description for this to show in the configuration panel if a custom name & description are not set."
L["Say"] = "說"
L["Sends a message locally only visible to you. To choose which part of the UI this is displayed in go to the |cff00B2FALocal Message Output Area|r in the General options."] = "在本地發送只有你可見的訊息。選擇UI顯示的部分請到一般選項中的|cff00B2FA本地訊息輸出區域|r。"
L["Sends a message to one of the following channels in order of priority:"] = "依據優先順序向以下頻道發送訊息："
L["Sleeping Mana Potions"] = "回復藥水"
--[[Translation missing --]]
L["Smart Group"] = "Smart Group"
--[[Translation missing --]]
L["Spell Ends"] = "Spell Ends"
--[[Translation missing --]]
L["Spell ID"] = "Spell ID"
--[[Translation missing --]]
L["Spell Setup"] = "Spell Setup"
--[[Translation missing --]]
L["Spell Setup for this spell is locked."] = "Spell Setup for this spell is locked."
--[[Translation missing --]]
L["Spell Starts"] = "Spell Starts"
--[[Translation missing --]]
L["Spell Stolen"] = "Spell Stolen"
L["Start"] = "開始"
--[[Translation missing --]]
L["Summon"] = "Summon"
L["Tag Options"] = "標籤選項"
--[[Translation missing --]]
L["Tags"] = "Tags"
--[[Translation missing --]]
L["This event is not currently supported by RSA or is not a valid event."] = "This event is not currently supported by RSA or is not a valid event."
--[[Translation missing --]]
L["Throttle Duration"] = "Throttle Duration"
--[[Translation missing --]]
L["turned off"] = "turned off"
--[[Translation missing --]]
L["turned on"] = "turned on"
--[[Translation missing --]]
L["Unlock setup"] = "Unlock setup"
L["URL"] = "網址"
--[[Translation missing --]]
L["Use Global Environment Settings"] = "Use Global Environment Settings"
L["Use Single Replacement"] = "使用單一替換"
--[[Translation missing --]]
L["Use the global settings to determine where it can be announced."] = "Use the global settings to determine where it can be announced."
L["Utilities"] = "工具"
--[[Translation missing --]]
L["Valid Tags:"] = "Valid Tags:"
--[[Translation missing --]]
L["WARNING: This spell is included with RSA by default and my cease to function correctly if you unlock and alter these settings."] = "WARNING: This spell is included with RSA by default and my cease to function correctly if you unlock and alter these settings."
--[[Translation missing --]]
L["When disabled, use the Environments tab below to configure where this spell is allowed to announce. Affects all events this spell can announce."] = "When disabled, use the Environments tab below to configure where this spell is allowed to announce. Affects all events this spell can announce."
--[[Translation missing --]]
L["When reporting an issue, please also post the version number above. Thanks!"] = "When reporting an issue, please also post the version number above. Thanks!"
--[[Translation missing --]]
L["When the casting of this spell begins."] = "When the casting of this spell begins."
--[[Translation missing --]]
L["When the spell's usual duration ends."] = "When the spell's usual duration ends."
L["When the target absorbs your spell |c5500DBBD[MISSTYPE]|r will be replaced with this."] = "當目標吸收你的法術時 |c5500DBBD[MISSTYPE]|r 將會替換為此。"
L["When the target blocks your spell |c5500DBBD[MISSTYPE]|r will be replaced with this."] = "當目標格檔你的法術時 |c5500DBBD[MISSTYPE]|r 將會替換為此。"
L["When the target deflects your spell |c5500DBBD[MISSTYPE]|r will be replaced with this."] = "當目標偏斜你的法術時 |c5500DBBD[MISSTYPE]|r 將會替換為此。"
L["When the target dodges your spell |c5500DBBD[MISSTYPE]|r will be replaced with this."] = "當目標閃躲你的法術時 |c5500DBBD[MISSTYPE]|r 將會替換為此。"
L["When the target evades your spell |c5500DBBD[MISSTYPE]|r will be replaced with this."] = "當目標閃避你的法術時 |c5500DBBD[MISSTYPE]|r 將會替換為此。"
L["When the target is immune to your spell |c5500DBBD[MISSTYPE]|r will be replaced with this."] = "當目標免疫你的法術時 |c5500DBBD[MISSTYPE]|r 將會替換為此。"
L["When the target is immune to your spell."] = "當目標免疫你的法術時。"
--[[Translation missing --]]
L["When the target of this spell accepts the resurrection."] = "When the target of this spell accepts the resurrection."
L["When the target parries your spell |c5500DBBD[MISSTYPE]|r will be replaced with this."] = "當目標招架你的法術時 |c5500DBBD[MISSTYPE]|r 將會替換為此。"
L["When the target reflects your spell |c5500DBBD[MISSTYPE]|r will be replaced with this."] = "當目標反射你的法術時 |c5500DBBD[MISSTYPE]|r 將會替換為此。"
L["When the target resists your spell |c5500DBBD[MISSTYPE]|r will be replaced with this."] = "當目標抵抗你的法術時 |c5500DBBD[MISSTYPE]|r 將會替換為此。"
--[[Translation missing --]]
L["When this buff or debuff is applied to a target."] = "When this buff or debuff is applied to a target."
--[[Translation missing --]]
L["When this buff or debuff is expires."] = "When this buff or debuff is expires."
--[[Translation missing --]]
L["When this CC ability is broken prematurely by another spell."] = "When this CC ability is broken prematurely by another spell."
--[[Translation missing --]]
L["When this resurrection spell finishes, giving the target the option to return to life."] = "When this resurrection spell finishes, giving the target the option to return to life."
--[[Translation missing --]]
L["When this spell absorbs damage or effects."] = "When this spell absorbs damage or effects."
--[[Translation missing --]]
L["When this spell captures a buff from the target."] = "When this spell captures a buff from the target."
--[[Translation missing --]]
L["When this spell causes damage."] = "When this spell causes damage."
--[[Translation missing --]]
L["When this spell causes healing."] = "When this spell causes healing."
--[[Translation missing --]]
L["When this spell fails to connect with the target. See the Tag Options to configure what the [MISSTYPE] tag will turn into when used."] = "When this spell fails to connect with the target. See the Tag Options to configure what the [MISSTYPE] tag will turn into when used."
--[[Translation missing --]]
L["When this spell instantly kills the target."] = "When this spell instantly kills the target."
--[[Translation missing --]]
L["When this spell interrupts another spell cast."] = "When this spell interrupts another spell cast."
--[[Translation missing --]]
L["When this spell is cast. If the spell has a cast-time, this is when you finish the cast. If the spell is instant, this is when the spell begins its effect."] = "When this spell is cast. If the spell has a cast-time, this is when you finish the cast. If the spell is instant, this is when the spell begins its effect."
--[[Translation missing --]]
L["When this spell is resisted by the target."] = "When this spell is resisted by the target."
--[[Translation missing --]]
L["When this spell removes a buff or debuff."] = "When this spell removes a buff or debuff."
--[[Translation missing --]]
L["When this spell spawns another creature or object in the world."] = "When this spell spawns another creature or object in the world."
L["When your spell misses the target |c5500DBBD[MISSTYPE]|r will be replaced with this."] = "當你的法術未命中目標時 |c5500DBBD[MISSTYPE]|r 將會替換為此。"
L["Whether the target blocks, dodges, absorbs etc. your attack, |c5500DBBD[MISSTYPE]|r will be replaced to this."] = "目標對你的攻擊是否格檔、閃躲、吸收等等，|c5500DBBD[MISSTYPE]|r 將會替換為此。"
L["Yell"] = "大喊"
--[[Translation missing --]]
L["You can click a spell in this list to remove it."] = "You can click a spell in this list to remove it."
L["You have %d message for this section."] = "您在本階段有%d條訊息。"
L["You have %d messages for this section."] = "您在本階段有%d條訊息。"
L["You have no messages for this section."] = "您在此階段沒有訊息。"
--[[Translation missing --]]
L["You must enter a number."] = "You must enter a number."
--[[Translation missing --]]
L["You must enter a valid Spell ID."] = "You must enter a valid Spell ID."
L["Your message must contain at least one number or letter!"] = "您的訊息需要包含至少一個數字或字母！"
L["Your version of RSA is out of date. You may want to grab the latest version from https://www.curseforge.com/wow/addons/rsa"] = "你的RSA版本已經過期了。你或許想獲取最新版本從 https://www.curseforge.com/wow/addons/rsa"