# RSA 5.9.0
### Paladin
* Added Intercession battle ress in Dragonflight

### Warrior
* Added Spell Reflection

# RSA 5.8.0
* Fixed an issue with zhTW localisation

### Druid
* Fixed Barkskin and Ironbark configuration options. *I got the two spells mixed up and thought Barksin was the external, and Ironbark was the personal one!*

### Evoker
* Fixed Quell's spell ID.
### Paladin
* Added Divine Plea in Wrath

### Rogue
* Added Shiv dispel in Dragonflight
* Fixed Sap configuration being incorrectly setup as an interrupt instead of a CC

## Known Issues
* Per Spell environment settings are currently not functioning, despite the options showing in game.
* UNIT_DIED events are not currently tracked.
* Various announcements that existed in the prior release of RSA are not currently implemented. Examples such as Misdirection and Tricks of the Trade being able to announce how much threat they transferred.
* Utility spells such as Cauldrons are not currently implemented, but will be returning shortly. The Utility options panel is supposed to be blank right now.
# RSA 5.7.0
* Fixed a reoccuring Lua error when using spells that trigger on an entire party or raid such as Aura Mastery.

### Hunter
* Added Tranquilizing Shot in DF & Wrath
### Mage
* Added Valdrakken Portal and Teleport in DF

### Paladin
* Added Divine Sacrifice & Hand of Salvation in Wrath

### Priest
* Added Hymn of Hope in Wrath

# RSA 5.6.2
* Fixed incorrect spell ID for Druid Rebirth on Dragonflight
* Fixed incorrect spell ID for Demon Hunter Blind
# RSA 5.6.1
* Fixed a Translation Issue with Traditional Chinese.

# RSA 5.6.0
* Added all spell ranks for supported spells for Wrath Classic.
* Added support for Evokers.
* Resurrect spells (and other spells that announce when starting a cast with a cast time) should work with the [TARGET] tag again.

# RSA 5.5.0-alpha
* RSA has undergone an extensive re-write to support multiple variants of the game. Some previously supported spells are not currently supported. All your settings will be reset - if you want to recover your old messages, view the information on the project page for how to do this.
* Add support for Dragonflight & Wrath Classic - Many Classic spells are not fully functioning, missing data for multiple ranks. This will come in the next few days.
