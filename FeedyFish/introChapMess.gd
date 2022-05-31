extends Label

var chapGuild = ""

func readFromFile(filePath):
	var fileChap = File.new()
	fileChap.open(filePath, File.READ)
	
	while not fileChap.eof_reached():
		var line = fileChap.get_line()
		chapGuild = chapGuild + line + "\n"
		
	fileChap.close()
	set_text(chapGuild)
