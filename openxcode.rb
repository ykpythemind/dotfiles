#! /usr/bin/env ruby

file = nil

Dir.foreach(Dir.pwd) do |f|
  if f.include? '.xcworkspace'
    # CocoaPodsを使っていたら優先的に開く
    file = f
    break
  end
  file = f if f.include? '.xcodeproj'
end

if file
  system "open #{file}"
else
  system 'open -a xcode'
end
