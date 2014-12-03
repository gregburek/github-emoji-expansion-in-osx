#Emoji Text Replacement in OS X Yosemite
Ever wished you could use `:thumbsup:` outside of Slack, GitHub, or any of the other apps [listed here](http://www.emoji-cheat-sheet.com/)?

This project is a fork of [Github Emoji Expansion in OSX](https://github.com/gregburek/github-emoji-expansion-in-osx) that rewrites the generator script to create a plist formatted in a way that allows it to be drag-n-dropped into Yosemite's Text preferences panel.

Feedback and suggestions are welcome, especially if you have ideas for making the installation even easier.

##Installation
Full installation instructions are available on the GitHub Pages site: https://noahmanger.github.io/emoji-text-replacement

##Development
Instructions from the original repo:

>The generation script has been tested on Ruby versions 1.9.2-p290 and 1.9.3-p327 and I recommend developing the project in a similar environment as unicode support in 1.8 is not best. Install dependencies locally by running bundle install.

Running `bundle exec ruby generate_plist.rb` will genereate `emoji.plist` which is for dragging into the Text Preferences panel in Yosemite, and `NSUserReplacementItems.plist` which can be used if you're following the terminal instructions in [the original repo](https://github.com/gregburek/github-emoji-expansion-in-osx)

##Credits
Thanks to [Greg Burek](https://github.com/gregburek) for writing the [original script](https://github.com/gregburek/github-emoji-expansion-in-osx) to generate the plist. If you're curious about getting this set up on non Yosemite machines, you'll want to head over to that repo for the full instructions.
