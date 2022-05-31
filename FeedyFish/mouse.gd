extends Node2D

	
func _process(delta):
	if Input.is_action_just_pressed("Left_Mouse"):
		$mouse.play()
