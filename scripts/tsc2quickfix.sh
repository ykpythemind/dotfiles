#! /usr/bin/ruby

# in vim command mode
# execute '!yarn tsc --noEmit 2>/dev/null | ~/dotfiles/scripts/tsc2quickfix.sh > /tmp/tscquickfix' | cfile /tmp/tscquickfix

$stdin.each_line do |line|
  a = line.match(/(.*)\((.*),(.*)\): error (.*)$/)
  puts "#{a[1]}:#{a[2]}:#{a[3]}: #{a[4]}" if a
end
