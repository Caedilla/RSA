
# RSA r513-Alpha

### Fixed
* Several classes had duplicate end messages for resurrects when the SPELL_RESURRECT and SPELL_CAST_SUCCESS events fired. They now only trigger from SPELL_RESURRECT, so only one end message should trigger now.



# RSA r512-Alpha

### New
* Tag Options now available:
    * You can customise whether [TARGET] replaces to "you" when whispering or just the spell target's name.
    * You can customise what the [TARGET] tag replaces to when whispering also. So if you use RSA in a language it doesn't have localisation for, you can change this to ensure grammatically correct messages.
    * You can set whether [MISSTYPE] will replace for each miss type (Absorb, Dodge, Parry, etc.) or just use one generic replacement.
    * You can also customise what each of the miss type replacements change to.
