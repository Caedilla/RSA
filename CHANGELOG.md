# RSA r455-Alpha
### New
* Added Instance chat option for Message Announce Area
   * usage would be where you only want to announce something in LFR for example but not in your guild raids.
### Changed
* Party option will now prefer /party chat over /instance chat where possible
    * e.g if you are in a normal party, then enter an arena, it will use /party instead of /instance.
* Raid has received the same change.
* Smart Group prefers /instance, then /raid, then /party but is now handled after Party, Raid (and the new Instance option) rather than being handled before.
   * This means that if you have Party and Smart Group selected, the priority would now be /party, /instance, /raid instead.
### Fixed
* RSA should now no longer fail to announce under certain circumstances when you have deleted the default message after adding your own custom message, or after deleting multiple messages.
