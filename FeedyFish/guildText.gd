extends Label

var guild = ""

func _ready():
	visible = false
	var fileGuild = File.new()
	fileGuild.open("res://FileText/guildText.txt", File.READ)
	while not fileGuild.eof_reached():
		var line = fileGuild.get_line()
		guild = guild + line + "\n"
	
	fileGuild.close()
	set_text(guild)
