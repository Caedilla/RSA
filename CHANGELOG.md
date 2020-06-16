# RSA r531-Release

### Changes
* RSA should now also run a version check with your guild members.

* RSA should now prioritise group announcements (such as repair bot announcements) by leaders followed by assistants when in a group. If the leader doesn't have RSA it will choose an assistant, if none of the assistants have RSA, it will choose a random member. Announcements still follow the settings set by the person chosen to announce though, so if they have them disabled, you will not see any announcements. This means leaders who do not want to see RSA announcements can use it and effectively mute these types of announcements from RSA.

### Fixes
* RSA should no longer warn you about newer versions if they are of a more unstable release type. i.e if you are using the release versions, you should no longer get warned about newer beta or alpha versions.

### Warrior
* Updated Spell Reflect tracking method, should hopefully reduce false positives.