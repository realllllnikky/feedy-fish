extends Sprite

func _ready():
	visible = false


func _on_next_pressed():
	get_tree().change_scene("res://CHAPTERSscenes/CHAPTER3.tscn")




func _on_playAgain_pressed():
	get_tree().change_scene("res://CHAPTERSscenes/CHAPTER2.tscn")




func _on_quit_pressed():
	get_tree().quit()

func win():
	$message.set_text("You win!")
	$next.visible = true
	visible = true

func lose():
	$message.set_text("game over")
	$next.visible = false
	visible = true
