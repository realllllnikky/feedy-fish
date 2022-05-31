extends Area2D

var speed
var direction
var sta = 0
var playerPosition
const maxSpeed = 3.6


func _ready():
	comeback()
	
func _process(delta):
	playerPosition = get_parent().getPlayerPosition()
	sta =  get_parent().get_node("menu").getSta()
	if sta < 3:
		chasePlayer()
	else:
		avoidPlayer()
	
	if position.x < -2000 or position.x > 3000:
		comeback()

func move():
	position.x += direction * speed

func nearPlayer():
	var distanceX = abs(playerPosition.x - position.x)
	var distanceY = abs(playerPosition.y - position.y)
	
	if distanceX < 220 + 10 * sta and distanceX > 200 + 10 * sta and distanceY < 10 * sta + 15:
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


func _on_fishLevel4_area_entered(area):
	if area.get_name() == "Player":
		# if player can eat fish
		if get_parent().hitsFishLevel4() == true:
			comeback()
		# else it keeps moving

func comeback():
	randomize()
	speed = rand_range(2,4)
	var temp = rand_range(-1, 2)
	if temp >= 0:
		position.x = rand_range(-2000, -500)
		turnRight()
	else:
		position.x = rand_range(1800, 3000)
		turnLeft()
	position.y = rand_range(10, 590)


func turnLeft():
	direction = -1
	$AnimSprite.play("left")
	$CollisionShape2D.set_position(Vector2(-20, 0))

func turnRight():
	direction = 1
	$AnimSprite.play("right")
	$CollisionShape2D.set_position(Vector2(20, 0))
