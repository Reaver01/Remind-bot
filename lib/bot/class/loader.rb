def loadArr(ar,loc)
	if File.exist?(loc)
#puts 'Opened file'
		f = File.open(loc,"r")
	else
#puts 'No file!'
	end
	buff = f.read
	ar=JSON.parse(buff)
#puts 'Loaded array!'
	return ar
end

def getline(loc,line)
	if File.exist?(loc)
		f = File.open(loc,"r")
		line.times{ f.gets }
		$temp = $_
		f.close
		$temp
	else
		puts 'No file to open!'
	end
end