extends Path2D

onready var follow = $PathFollow2D

func _ready():
	set_process(true)
	$PathFollow2D/AnimatedSprite.play()
	
func _process(delta):
	follow.set_offset(follow.get_offset() + 2)
