extends Area2D

var speed
var direction
var playerPosition
const maxSpeed = 4

func _ready():
	comeback()

func _process(delta):
	playerPosition = get_parent().getPlayerPosition()
	if get_parent().get_node("menu").getSta() < 4:
		chasePlayer()
	else:
		avoidPlayer()
	
	if position.x < -35000 or position.x > 4000:
		comeback()


func move():
	position.x += direction * speed

func nearPlayer():
	var distanceX = abs(playerPosition.x - position.x)
	var distanceY = abs(playerPosition.y - position.y)
	
	if distanceX < 220 and distanceX > 200 and distanceY < 20:
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

func avoidPlayer():
	if nearPlayer():
		if position.x > playerPosition.x:
			turnRight()
			speed = maxSpeed
		else:
			turnLeft()
			speed = maxSpeed
	move()



func _on_fishLevel5_area_entered(area):
	if area.get_name() == "Player":
		# if player can eat fish
		if get_parent().hitsFishLevel5() == true:
			comeback()
		# else it keeps moving

func comeback():
	randomize()
	speed = rand_range(1,3)
	var temp = rand_range(-1, 2)
	if temp >= 0:
		position.x = rand_range(-3500, -2000)
		turnRight()
	else:
		position.x = rand_range(2500, 4000)
		turnLeft()
	position.y = rand_range(10, 590)

func turnLeft():
	direction = -1
	$AnimSprite.play("left")
	$CollisionShape2D.set_position(Vector2(-20, 2))

func turnRight():
	direction = 1
	$AnimSprite.play("right")
	$CollisionShape2D.set_position(Vector2(20, 2))
