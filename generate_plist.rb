require 'erb'
require 'rubygems'
require 'sqlite3'

def get_template()
  %{
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <array>
    <% for @item in @items %>
  <dict>
        <key>on</key>
        <integer>1</integer>
        <key>replace</key>
        <string><%= @item['code'] %></string>
        <key>with</key>
        <string><%= [@item['unicode'].hex].pack('U').force_encoding('utf-8')  %></string>
      </dict>
    <% end %>
    </array>
    </plist>
  }
end

def get_items()
  dir = File.dirname(__FILE__)
  db = SQLite3::Database.new(dir + '/emoji.sqlite')

  rows = db.execute('SELECT * FROM emoji ORDER BY code ASC');

  missing = []
  emoji = []

  rows.each do |row|
    raw_code = row[0].chomp

    code = ":#{raw_code}:"
    unicode = row[2]

    if unicode.nil?
      puts "*** Emoji present in Github but not in unicode: #{code}"
    elsif unicode.length <= 5
      emoji << {'code' => code, 'unicode' => unicode}
    else
      puts "*** Unhandled unicode: #{code} - #{unicode}"
    end

  end

  return emoji
end

class EmojiList
  include ERB::Util
  attr_accessor :items, :template

  def initialize(items, template)
    @items = items
    @template = template
  end

  def render()
    ERB.new(@template, 0, '>').result(binding)
  end

  def save(file)
    File.open(file, "w+") do |f|
      f.write(render)
    end
  end

end

list = EmojiList.new(get_items, get_template)
list.save(File.join(File.dirname(__FILE__), 'NSUserReplacementItems.plist'))
