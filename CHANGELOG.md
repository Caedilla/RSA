# RSA 5.6.0
* Added all spell ranks for supported spells for Wrath Classic.
* Added support for Evokers.
* Resurrect spells (and other spells that announce when starting a cast with a cast time) should work with the [TARGET] tag again.

## Known Issues
* Per Spell environment settings are currently not functioning, despite the options showing in game.
* UNIT_DIED events are not currently tracked.
* Various announcements that existed in the prior release of RSA are not currently implemented. Examples such as Misdirection and Tricks of the Trade being able to announce how much threat they transferred.
* Utility spells such as Cauldrons are not currently implemented, but will be returning shortly. The Utility options panel is supposed to be blank right now.