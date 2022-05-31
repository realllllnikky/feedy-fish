extends Area2D

var speed
var direction

func _ready():
	setStartPos()
	$AnimatedSprite.play("swim")
	
func _process(delta):
	position.y += direction * speed
	if position.y < -200 or position.y > 1000:
		setStartPos()



func _on_JellyFishScene_area_entered(area):
	if area.get_name() == "Player":
		get_parent().hitsJellyFish()



func setStartPos():
	randomize()
	speed = rand_range(1, 5)
	
	direction = rand_range(-2, 2)
	if direction < 0:
		direction = -1
		position.x = rand_range(10, 1000)
		position.y = rand_range(600, 1000)
	else:
		direction = 1
		position.x = rand_range(10, 1000)
		position.y = rand_range(-200, -50)
		
	var newSize = randi() % 100
	newSize = 1 + newSize / 50
	scale = Vector2(newSize, newSize) 
