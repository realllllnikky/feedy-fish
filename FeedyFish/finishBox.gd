extends Sprite

func _ready():
	$Next.visible = false
	visible = false


func _on_Next_pressed():
	get_tree().change_scene("res://CHAPTERSscenes/CHAPTER2.tscn")



func _on_PlayAgain_pressed():
	get_tree().change_scene("res://CHAPTERSscenes/CHAPTER1.tscn")



func _on_Quit_pressed():
	get_tree().quit()

func win():
	$Next.visible = true
	$message.set_text("You win!")
	visible = true

func lose():
	$Next.visible = false
	$message.set_text("Game Over")
	visible = true
