extends Area2D

var speed
var direction
var sta = 0
var playerPosition
const maxSpeed = 2

func _ready():
	comeback()


func _process(delta):
	playerPosition = get_parent().getPlayerPosition()
	sta = get_parent().get_node("menu").getSta()
	if sta < 1:
		chasePlayer()
	else:
		avoidPlayer()
	
	if position.x < -500 or position.x > 1300:
		comeback()


func move():
	position.x += direction * speed

func nearPlayer():
	var distanceX = abs(playerPosition.x - position.x)
	var distanceY = abs(playerPosition.y - position.y)
	
	if distanceX < 90 + 10 * sta and distanceY < 10 * sta + 10:
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


func _on_fishLevel2_area_entered(area):
	if area.get_name() == "Player":
		if get_parent().hitsFishLevel2() == true:
			comeback()


func comeback():
	randomize()
	speed = rand_range(9, 16) / 10
	var temp = rand_range(-1, 2)
	if temp >= 0:
		position.x = rand_range(-500, -100)
		turnRight()
	else:
		position.x = rand_range(1050, 1300)
		turnLeft()
	position.y = rand_range(10, 590)


func turnLeft():
	direction = -1
	$Sprite.flip_h = true

func turnRight():
	direction = 1
	$Sprite.flip_h = false
