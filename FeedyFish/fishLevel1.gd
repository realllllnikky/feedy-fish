extends Area2D

var speed
const maxSpeed = 2
var direction
var playerPosition

func _ready():
	comeback()
	
func _process(delta):
	playerPosition = get_parent().getPlayerPosition()
	var distanceX = abs(position.x - playerPosition.x)
	var distanceY = abs(position.y - playerPosition.y)
	if distanceX < 90 and distanceY < 50:
		if position.x < playerPosition.x:
			turnLeft()
		else:
			turnRight()
	
	position.x += direction * speed
	
	if position.x < -300 or position.x > 1600:
		comeback()
	

func _on_fishLevel1_area_entered(area):
	if area.get_name() == "Player":
		get_parent().hitsFishLevel1()
		comeback()

func comeback():
	randomize()
	speed = rand_range(7, 15) / 10
	
	var temp = rand_range(-1, 2)
	if temp > 0:
		position.x = rand_range(-300, -50)
		direction = 1
		$AnimatedSprite.play("right")
	else:
		position.x = rand_range(1100, 1600)
		direction = -1
		$AnimatedSprite.play("left")
	position.y = rand_range(10, 590)
	
func turnLeft():
	direction = -1
	speed = maxSpeed
	$AnimatedSprite.play("left")

func turnRight():
	direction = 1
	speed = maxSpeed
	$AnimatedSprite.play("right")
