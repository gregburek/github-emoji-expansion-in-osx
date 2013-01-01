Github emoji expansion in OSX
=============================


```bash
curl -O https://raw.github.com/gregburek/github-emoji-expansion-in-osx/master/NSUserReplacementItems.plist
/usr/libexec/PlistBuddy -c "Merge '`pwd`/NSUserReplacementItems.plist' NSUserReplacementItems" ~/Library/Preferences/.GlobalPreferences.plist
defaults write -g WebAutomaticTextReplacementEnabled -bool true

```

