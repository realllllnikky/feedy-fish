extends Node


func _ready():
	$Panel.visible = false
	$gamesound.play()

func _on_Play_pressed():
	get_tree().change_scene("res://CHAPTERSscenes/CHAPTER1.tscn")


func _on_Guild_pressed():
	$Panel.visible = true
	$guildText.visible = true


func _on_Quit_pressed():
	get_tree().quit()


func _on_skip_pressed():
	$Panel.visible = false
	$guildText.visible = false
