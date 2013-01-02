Github emoji expansion in OSX
=============================
Add github emoji codes to OS X's symbol and text substitution. 

This project contains a plist that is suitable to import into OS X's text substitution settings and the code used to generate it. 

Install
-------

1. (optional) Back up your existing custom text substitution rules:
```bash
/usr/libexec/PlistBuddy -x -c "Print NSUserReplacementItems" ~/Library/Preferences/.GlobalPreferences.plist > backup.plist
```

2. Initialize NSUserReplacements:
  - Go to System Preferences > Language & Text > Text
  - Click the "Restore Defaults" button
  - Make sure "Use symbol and text substitution" is checked 

3. Download and install the Github emoji expansion plist
```bash
curl -O https://raw.github.com/gregburek/github-emoji-expansion-in-osx/master/NSUserReplacementItems.plist
/usr/libexec/PlistBuddy -c "Merge '`pwd`/NSUserReplacementItems.plist' NSUserReplacementItems" ~/Library/Preferences/.GlobalPreferences.plist
```
4. (optional) Restore your previous custom text substitution rules:
```bash
/usr/libexec/PlistBuddy -c "Merge '`pwd`/backup.plist' NSUserReplacementItems" ~/Library/Preferences/.GlobalPreferences.plist
```
5. (Only for OS X 10.6 and earlier) Enable text replacement in all apps by default:
```bash
defaults write -g WebAutomaticTextReplacementEnabled -bool true
```

Develop
-------


Todo
----
- Some of the more complex emoji are not included in this plist and ignored by the generation script, including emoji that rely on multi-part unicode like [Regional Indicator Symbols](http://en.wikipedia.org/wiki/Regional_Indicator_Symbol). Supporting them would require a minor refactor. 
- Find a way to use the official [gemoji](https://github.com/github/gemoji) gem for emoji->unicode generation

Credits
-------
 - `emoji.sqlite` is from the [ZWEmoji](https://github.com/zachwaugh/ZWEmoji) project and was the only direct github emoji code to unicode map that I could find. 
