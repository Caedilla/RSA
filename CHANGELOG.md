# RSA 5.9.2
* Fixed a bug preventing proper randomisation of multiple messages
* Fixed a bug when updating default spell data from a prior version (If you play a Rogue and changed setting related to Sap, this should fix RSA being broken in versions past 5.7.0)

### Priest
* Power Infusion with Twins of the Sun Priestess should now only announce once per event (In the future there will be more granular options to specify if it will only announce on targets and not yourself)

## Known Issues
* Per Spell environment settings are currently not functioning, despite the options showing in game.
* UNIT_DIED events are not currently tracked.
* Various announcements that existed in the prior release of RSA are not currently implemented. Examples such as Misdirection and Tricks of the Trade being able to announce how much threat they transferred.
* Utility spells such as Cauldrons are not currently implemented, but will be returning shortly. The Utility options panel is supposed to be blank right now.
# RSA 5.9.1
* Fixed a bug referring to currentSpell
### Hunter
* Added Silencing Shot for Wrath
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