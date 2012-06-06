def GetID3(datei)
    aFile = File.open(datei, "r")
    aFile.pos = File.size(datei) - 125
    result = [aFile.read(30), aFile.read(30), aFile.read(30), aFile.read(4)]
    return result
end

puts "+-+-+-+ +-+-+-+-+-+-+"
puts "|I|D|3| |R|e|a|d|e|r|"
puts "+-+-+-+ +-+-+-+-+-+-+"

puts ""

print "Enter the song including the path or drag it into the window : "
file = gets.chomp
puts ""
list = GetID3(file.gsub(/"/, ''))
puts "Title  : " + list[0]
puts "Artist : " + list[1]
puts "Album  : " + list[2]
puts "Year   : " + list[3]
puts ""
puts "Press Enter to continue..."
gets