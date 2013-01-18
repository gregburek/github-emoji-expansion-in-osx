GitHub emoji expansion in OS X
=============================
Add GitHub emoji codes to OS X's symbol and text substitution.

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

3. Download and install the GitHub emoji expansion plist
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
** Emoji present in Github but not in unicode:
 * :bowtie:
 * :feelsgood:
 * :finnadie:
 * :fu:
 * :goberserk:
 * :godmode:
 * :hurtrealbad:
 * :metal:
 * :neckbeard:
 * :octocat:
 * :rage1:
 * :rage2:
 * :rage3:
 * :rage4:
 * :shipit:
 * :squirrel:
 * :suspect:
 * :trollface:
** Unicode not currently supported by this script: 
 * :cn: - 1f1e8-1f1f3
 * :de: - 1f1e9-1f1ea
 * :es: - 1f1ea-1f1f8
 * :fr: - 1f1eb-1f1f7
 * :gb: - 1f1ec-1f1e7
 * :it: - 1f1ee-1f1f9
 * :jp: - 1f1ef-1f1f5
 * :kr: - 1f1f0-1f1f7
 * :ru: - 1f1f7-1f1fa
 * :uk: - 1f1ec-1f1e7
 * :us: - 1f1fa-1f1f8

Credits
-------
- [Ben Alman](https://github.com/cowboy)'s [dotfiles](https://github.com/cowboy/dotfiles) repo provided significant inspiration for how to [merge](https://github.com/cowboy/dotfiles/blob/master/source/50_osx.sh) in the generated [NSReplacement.plist](https://github.com/cowboy/dotfiles/blob/master/conf/osx/NSUserReplacementItems.plist) file.
