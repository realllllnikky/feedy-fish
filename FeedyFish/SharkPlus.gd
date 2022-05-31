extends Node2D

var speed
const speedUp = 2
var maxSpeed = 5
var direction = 1
var numOfFlags = 5
var playerPosition = Vector2(0, 0)

func _ready():
	comeback()
	turnLeft()

func _process(delta):
	playerPosition = get_parent().getPlayerPosition()
	if numOfFlags == 0:
		# become weak and need to run from player
		avoidPlayerApproach()
	else:
		chasePlayer()
	
	if position.x < -5000 or position.x > 6000:
		comeback()

func getNumOfFlags():
	return numOfFlags

func move():
	position.x += direction * speed

func comeback():
	randomize()
	speed = rand_range(2,3)
	
	var temp = rand_range(-1, 2)
	if temp > 0:
		position.x = rand_range(-5000, -100)
		turnRight()
	else:
		position.x = rand_range(1500, 6000)
		turnLeft()
	
	position.y = rand_range(10, 590)

func nearPlayer():
	var distanceX = abs(playerPosition.x - position.x)
	var distanceY = abs(playerPosition.y - position.y)
	
	if distanceX < 200 and distanceY < 50:
		return true
	else:
		return false

func nearChasedPlayer():
	var distanceX = abs(playerPosition.x - position.x)
	var distanceY = abs(playerPosition.y - position.y)
	
	if distanceX < 220 and distanceX > 210 and distanceY < 50:
		# distanceX > 210 so there is space for player to run
		return true
	else:
		return false

func chasePlayer():
	if nearChasedPlayer():
		findChasingDirection()
		move()
	else:
		move()

func avoidPlayerApproach():
	if nearPlayer():
		findNewDirection()
		move()
	else:
		move()


func findNewDirection():
	if playerPosition.x < position.x:
		turnRight()
	else:
		turnLeft()

func findChasingDirection():
	if position.x < playerPosition.x:
		turnRight()
	else:
		turnLeft()

func turnRight():
	direction = 1
	$Shark/AnimSprite.play("right")
	# flip-h sharkPlus
	if numOfFlags > 0:
		$Flag.set_position(Vector2(-106, 2))
		$Shark/CollisionShape2D.set_position(Vector2(35, 9))

func turnLeft():
	direction = -1
	$Shark/AnimSprite.play("left")
	# flip-h sharkPlus
	if numOfFlags > 0:
		$Flag.set_position(Vector2(106, 2))
		$Shark/CollisionShape2D.set_position(Vector2(-35, 9))


func _on_Shark_area_entered(area):
	if area.get_name() == "Player":
		# if player can eat fish
		if get_parent().hitsSharkPlus() == true:
			queue_free()
		# else it keeps moving
		else:
			numOfFlags = -1


func _on_Flag_area_entered(area):
	if area.get_name() == "Player":
		numOfFlags -= 1
		speed = maxSpeed
		scale -= Vector2(0.15, 0.15)
		if numOfFlags == 0:
			$Flag.queue_free()


