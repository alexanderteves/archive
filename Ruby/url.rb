def getDocumentFromUrl(url)
	File.basename(url)
end
 
def getHostFromUrl(url)
	if /\w+:\/\// =~ url
	    url = url.gsub(url.scan(/\w+:\/\//)[0], '')
	end
	url = url[0..url.index('/')-1]
	if /:+\d+/ =~ url
	    url.gsub(url.scan(/:\d+/)[0], '')
	else
	    url
	end
end
 
def getPortFromUrl(url)
	if /\w+:\/\// =~ url
	    url = url.gsub(url.scan(/\w+:\/\//)[0], '')
	end
	url = url[0..url.index('/')-1]
	if /:+\d+/ =~ url
	    url.scan(/:\d+/)[0].gsub(':', '')
	else
	    "80"
	end
end
 
def getPathFromUrl(url)
	if /\w+:\/\// =~ url
	    url.gsub!(url.scan(/\w+:\/\//)[0], '')
	end
	url = url.gsub(getHostFromUrl(url), '')
	url = url.gsub(getDocumentFromUrl(url), '')
	url[url.index('/'), url.size]
end
 
url_in = "http://www.foo.org:8080/alex/jerk.php"
puts ""

puts "Host : " + getHostFromUrl(url_in)
puts "Port : " + getPortFromUrl(url_in)
puts "Path : " + getPathFromUrl(url_in)
puts "Document : " + getDocumentFromUrl(url_in)

gets