#!/usr/bin/ruby
require 'rexml/document'
include REXML

system("cp test.xml test.xml.bak")

doc = Document.new(File.open("test.xml.bak"))

root = doc.root

def getHeaders(rootElement)
	rootElement.each_element('//note') {|note| print note.elements['ID'].text +
" " + note.elements['header'].text + "\n"}
end

def getNote(rootElement, noteID)
	rootElement.each_element('//note') {|note| if note.elements['ID'].text == noteID then puts note.elements['text'].text end}
end

def delNote(rootElement, noteID)
	rootElement.each_element('//note') {|note| if note.elements['ID'].text == noteID then rootElement.delete_element(note) end}
end

until false do
	print "RoCu>"
	command = gets.chomp
	if command == "ls"
		getHeaders(root)
	elsif command == "exit"
		break
	elsif command == "get"
		print "Note ID: "
		noteID = gets.chomp
		getNote(root, noteID)
	elsif command == "rm"
		print "Note ID: "
		noteID = gets.chomp
		delNote(root, noteID)
	elsif command == "commit"
		updatedContent = doc.write()
		system("rm test.xml")
		File.new("test.xml", "a").puts(updatedContent)
	else
		print "Unknown command " + command + "\n"
	end
end
