require 'erb'
require 'rubygems'
require 'gemoji'

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

def get_yosemite_template()
  %{
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <array>
        <% for @item in @items %>
        <dict>
          <key>phrase</key>
          <string><%= [@item['unicode'].hex].pack('U').force_encoding('utf-8')  %></string>
          <key>shortcut</key>
          <string><%= @item['code'] %></string>
        </dict>
      <% end %>
      </array>
    </plist>
  }
end

def get_items()

  missing = []
  too_complex = []
  emoji_pairs = []

  Emoji.names.each do |emoji|
    code = ":#{emoji}:"
    begin
      unicode_filename = File.readlink("#{Emoji.images_path}/emoji/#{emoji}.png")
    rescue
      missing << code
      next
    end
    unicode = unicode_filename.split("/")[1].split(".")[0]

    if unicode.nil?
      puts "ERROR"
    elsif unicode.length <= 5
      emoji_pairs << {'code' => code, 'unicode' => unicode}
    elsif unicode.length == 9
      # parts = unicode.split(' ')
      too_complex << {'code' => code, 'unicode' => unicode}
    elsif unicode.length == 11
      # parts = unicode.split(' ')
      too_complex << {'code' => code, 'unicode' => unicode}
    elsif unicode.length == 19
      # parts = unicode.split(' ')
      too_complex << {'code' => code, 'unicode' => unicode}
    else
      puts "** Unhandled unicode: #{unicode}"
      exit()
    end
  end

  puts "** Emoji present in Github but not in unicode:"
  missing.each {|code| puts " * #{code}"}

  puts "** Unicode not currently supported by this script: "
  too_complex.each {|emoji| puts " * #{emoji['code']} - #{emoji['unicode']}"}

  return emoji_pairs
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

yosemite_list = EmojiList.new(get_items, get_yosemite_template)
yosemite_list.save(File.join(File.dirname(__FILE__), 'emoji.plist'))
