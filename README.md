# RSA - Raeli's Spell Announcer
Easy spell announcements

## Download
<https://www.curseforge.com/wow/addons/rsa>

## About
RSA is an addon that can announce spell casts to various chat channels. It supports all classes, and abilities such as interrupts, defensive cooldowns, and utility spells e.g Soulstone.

## Options
### Announcement Conditions
You can configure RSA to only send messages when you are doing certain content or under certain conditions:
* **PvP:** Choose whether to enable in Arenas, Battlegrounds, and War Mode (BFA).
* **PvE:** Choose whether to enable in manually formed Dungeons, Raids, LFG Dungeons, LFG Raids, or out in the world when War Mode is off.
* Choose whether to only announce in Combat

### Messages
The messages sent by RSA are completely customisable, you can add several messages (as of BFA) for each announcement, and RSA will choose a random one to use each time.
    You can remove messages by simply clearing the box containing your message and pressing enter, this will remove it from the list of potential messages.
    If you have no messages for a given spell or section, then it will not announce.
    You can use the Tags below in your messages to make your messages more informative.
    
### Tags
Every spell uses the first two tags, other tags are usable only on spells where they would return anything useful.

* **[SPELL]** will be replaced with the name of the spell.
* **[LINK]** will be replaced by a clickable spell link of the spell cast.
* **[TARGET]** will be replaced with the target of the spell.
* **[AMOUNT]** will be replaced with the amount of damage or healing done.
* **[MISSTYPE]** will be replaced with Immune/Blocked/Resisted etc.
* **[AURA]** will be replaced with the buff or debuff removed by dispels.
* **[AURALINK]** will be replaced with a clickable spell link of the buff or debuff removed by dispels.
* **[TARCAST]** will be replaced by the spell that you have just interrupted.
* **[TARLINK]** will be replaced by a clickable spell link of the spell that you have just interrupted.

### Channels
Each spell can be announced in a variety of different channels:

* **Local** - Sends a message locally only visible to you. You can choose which part of your UI this is sent to in the Local Message Output Area in the General Options.
* **Raid** - Sends to /raid if you're in a raid group.
* **Party** -Sends to /party if you're in a party or raid group.
* **Smart Group Channel** - /raid if you're in a manually formed raid group, /party if you're in a manually formed party, or /instance if you're in a group finder dungeon/raid/battleground/arena.
* **Say**
* **Emote**
* **Yell**
* **Whisper** - sends a whisper to the target. Only available if the target has the potential to be someone other than yourself.
* **Custom Channel** - You can send it to a custom channel, like, say, your healing channel.

## Feedback

You can [report issues on Curseforge](https://wow.curseforge.com/projects/rsa/issues) or contact me directly through my [Battle.net community](https://blizzard.com/invite/WqRG7EUgOR).

## Localisation

RSA supports localisation, if you want to help me out by localising RSA, please go to the [localisation page on Curseforge](https://wow.curseforge.com/projects/rsa/localization).
