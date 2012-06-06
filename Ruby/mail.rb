mailstring = "<a href='mailto:alexander.teves@web.de'>email</a>"
puts mailstring
if /\w+\@\w+.\w+/ =~ mailstring
	puts mailstring.scan(/\w+\@\w+.\w+/)
#elseif /\w+.\w+\@\w+.\w+/ =~ mailstring
#	puts mailstring.scan(/\w+.\w+\@\w+.\w+/)
elseif /\w+_\w+\@\w+.\w+/ =~ mailstring
	puts mailstring.scan(/\w+_\w+\@\w+.\w+/)
#elseif /\w+-\w+\@\w+.\w+/ =~mailstring
#	puts mailstring.scan(/\w+-\w+\@\w+.\w+/)
end
gets