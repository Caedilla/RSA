# RSA 5.6.1
* Fixed a Translation Issue with Traditional Chinese.

# RSA 5.6.1
* Added all spell ranks for supported spells for Wrath Classic.
* Added support for Evokers.
* Resurrect spells (and other spells that announce when starting a cast with a cast time) should work with the [TARGET] tag again.

# RSA 5.5.0-alpha
* RSA has undergone an extensive re-write to support multiple variants of the game. Some previously supported spells are not currently supported. All your settings will be reset - if you want to recover your old messages, view the information on the project page for how to do this.
* Add support for Dragonflight & Wrath Classic - Many Classic spells are not fully functioning, missing data for multiple ranks. This will come in the next few days.

## Known Issues
* Per Spell environment settings are currently not functioning, despite the options showing in game.
* UNIT_DIED events are not currently tracked.
* Various announcements that existed in the prior release of RSA are not currently implemented. Examples such as Misdirection and Tricks of the Trade being able to announce how much threat they transferred.
* Utility spells such as Cauldrons are not currently implemented, but will be returning shortly. The Utility options panel is supposed to be blank right now.