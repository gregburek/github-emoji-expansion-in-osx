Github emoji expansion in OS X
=============================
Add github emoji codes to OS X's symbol and text substitution.

This project contains a plist that is suitable to import into OS X's text substitution pref pane and the code used to generate it.

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
5. (optional) Enable text replacement in all apps by default:
```bash
defaults write -g WebAutomaticTextReplacementEnabled -bool true
```

Develop
-------
The generation script has been tested on Ruby versions 1.9.2-p290 and 1.9.3-p327 and I recommend developing the project in a similar environment as unicode support in 1.8 is not best.
Install dependencies locally by running `bundle install`. To regenerate the `NSUserReplacementItems.plist` file, run `bundle exec ruby generate_plist.rb`

Todo
----
- Emoji listed below are not included in this plist and ignored by the generation script. As they rely on multi-part unicode like [Regional Indicator Symbols](http://en.wikipedia.org/wiki/Regional_Indicator_Symbol), supporting them would require a minor refactor. 
 * :0: - 0030 20E3
 * :1: - 0031 20E3
 * :2: - 0032 20E3
 * :3: - 0033 20E3
 * :4: - 0034 20E3
 * :5: - 0035 20E3
 * :6: - 0036 20E3
 * :7: - 0037 20E3
 * :8: - 0038 20E3
 * :9: - 0039 20E3
 * :cn: - 1F1E8 1F1F3
 * :de: - 1F1E9 1F1EA
 * :es: - 1F1EA 1F1F8
 * :fr: - 1F1EB 1F1F7
 * :gb: - 1F1EC 1F1E7
 * :hash: - 0023 20E3
 * :it: - 1F1EE 1F1F9
 * :jp: - 1F1EF 1F1F5
 * :kr: - 1F1F0 1F1F7
 * :ru: - 1F1F7 1F1FA
 * :uk: - D83C DDEC D83C DDE7
 * :us: - 1F1FA 1F1F8
- Find a way to use the official [gemoji](https://github.com/github/gemoji) gem for emoji->unicode generation

Credits
-------
- `emoji.sqlite` is from the [ZWEmoji](https://github.com/zachwaugh/ZWEmoji) project and was the only direct github emoji code to unicode map that I could easily find.
- [Ben Alman](https://github.com/cowboy)'s [dotfiles](https://github.com/cowboy/dotfiles) repo provided significant inspiration for how to [merge](https://github.com/cowboy/dotfiles/blob/master/source/50_osx.sh) in the generated [NSReplacement.plist](https://github.com/cowboy/dotfiles/blob/master/conf/osx/NSUserReplacementItems.plist) file.
