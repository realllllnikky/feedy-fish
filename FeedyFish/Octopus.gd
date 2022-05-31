extends Area2D

var speed
var direction
var playerPosition

func _ready():
	comeback()

func _process(delta):
	playerPosition = get_parent().getPlayerPosition()
	chasePlayer()
	
	if position.x < -5000 or position.x > 6000:
		comeback()


func move():
	position.x += direction * speed

func nearPlayer():
	var distanceX = abs(playerPosition.x - position.x)
	var distanceY = abs(playerPosition.y - position.y)
	
	if distanceX < 220  and distanceY < 20:
		return true
	else:
		return false


func chasePlayer():
	if nearPlayer():
		if position.x < playerPosition.x:
			turnRight()
		else:
			turnLeft()
	move()


func _on_Octopus_area_entered(area):
	if area.get_name() == "Player":
		get_parent().hitsOctopus()
			

func comeback():
	randomize()
	speed = rand_range(1,2)
	var temp = rand_range(-1, 2)
	if temp >= 0:
		position.x = rand_range(-5000, -2000)
		turnRight()
	else:
		position.x = rand_range(2500, 6000)
		turnLeft()
	position.y = rand_range(10, 590)

func turnLeft():
	direction = -1
	$AnimSprite.play("left")
	$CollisionShape2D.set_position(Vector2(3, 0))

func turnRight():
	direction = 1
	$AnimSprite.play("right")
	$CollisionShape2D.set_position(Vector2(-3, 0))
