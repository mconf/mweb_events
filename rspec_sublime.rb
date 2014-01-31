#!/usr/bin/env ruby

#Usage:
#rspec spec -f h > results.html; ./sublimeRspecUrl.rb `pwd` ./results.html; open ./results.html

path = Dir.pwd;
filename = ARGV[0];
file = File.open(path+'/'+filename)
contents = file.read
contents = contents.gsub(/([A-Za-z:0-9_.\/ ]+rb):([0-9]+)/, '<a href="txmt://open/?url=file://' + path + '/\1&line=\2">\1:\2</a>')
File.open(path+'/'+filename, 'w') {|f| f.write(contents) }