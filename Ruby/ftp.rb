puts "+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+"
puts "|F|T|P| |M|i|c|r|o|C|l|i|e|n|t|"
puts "+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+"
puts ""

require 'net/ftp'

print "Please enter server : "
server = gets.chomp
print "Please enter user : "
username = gets.chomp
print "Please enter password for #{username} : "
pw = gets.chomp
puts ""

ftp = Net::FTP.new(server)
	connection = ftp.login(user=username, passwd=pw)
	puts connection
	puts ""
	puts ftp.welcome
ftp.close
puts ""

puts "Press Enter to continue..."
gets