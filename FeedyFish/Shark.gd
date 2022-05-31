extends Area2D

export var speed = 2
var direction = 1

func _ready():
	comeback()
	
func _process(delta):
	position.x += direction * speed
	if position.x < -8000 or position.x > 9000:
		comeback()

func _on_Shark_area_entered(area):
	if area.get_name() == "Player":
		# if player can eat fish
		if get_parent().hitsShark() == true:
			comeback()
		# else it keeps moving

func comeback():
	randomize()
	var temp = rand_range(-1, 2)
	if temp >= 0:
		position.x = rand_range(-8000, -7000)
		direction = 1
		$AnimatedSprite.play("right")
	else:
		position.x = rand_range(7000, 9000)
		direction = -1
		$AnimatedSprite.play("left")
	position.y = rand_range(20, 590)

