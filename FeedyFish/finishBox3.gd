extends Sprite

func _ready():
	visible = false



func _on_backToStart_pressed():
	get_tree().change_scene("res://CHAPTERSscenes/startScene.tscn")



func _on_playAgain_pressed():
	get_tree().change_scene("res://CHAPTERSscenes/CHAPTER3.tscn")



func _on_quit_pressed():
	get_tree().quit()

func win():
	$mesage.set_text("You win!")
	visible = true

func lose():
	$mesage.set_text("game over")
	visible = true


