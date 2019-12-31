require 'yaml'

def psys(str)
  puts str
  system str
end

data = YAML.load(File.read('dep.yml'))

puts "* install via brew..."

list = data["brew"].to_a.join(" ")
psys "brew install #{list}"

psys "brew doctor"

puts "* install fish plugins..."

psys "curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish"

fisherlist = data["fisher"].to_a.join(" ")
psys "fisher add #{fisherlist}"

puts "* link diff-highlight"

psys "ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight"
