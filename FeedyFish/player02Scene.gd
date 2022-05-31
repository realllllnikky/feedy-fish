extends Area2D

export var speed = 5
var direction
var blink_timer

func _ready():
	direction = 0
	position = Vector2(-200, -200)
	$Timer.connect("timeout", self, "_on_Timer_timeout")
	
	blink_timer = Timer.new()
	blink_timer.connect("timeout", self, "_on_blink_timeout")
	add_child(blink_timer)

func start():
	position = Vector2(500, 300)
	turnLeft()
	direction = 1

func _process(delta):
	playerMove()

func playerMove():
	if direction == 1:
		if Input.is_action_pressed("ui_left"):
			turnLeft()
			position.x -= speed
		
		elif Input.is_action_pressed("ui_right"):
			turnRight()
			position.x += speed
		
		elif Input.is_action_pressed("ui_down"):
			position.y += speed
		
		elif Input.is_action_pressed("ui_up"):
			position.y -= speed
		
		position.x = clamp(position.x, 10, 1030)
		position.y = clamp(position.y, 10, 600)

	elif direction == -1:
		if Input.is_action_pressed("ui_right"):
			position.x -= speed
			turnLeft()
		
		elif Input.is_action_pressed("ui_left"):
			position.x += speed
			turnRight()
		
		elif Input.is_action_pressed("ui_up"):
			position.y += speed
		
		elif Input.is_action_pressed("ui_down"):
			position.y -= speed
		
		position.x = clamp(position.x, 10, 1030)
		position.y = clamp(position.y, 10, 600)
		
	elif not direction == 0:
		print("there is error: direction = " + str(direction))

func growUp(var newSize, var newSpeed):
	scale = Vector2(newSize, newSize)
	speed = newSpeed

func slowDown():
	$Timer.set_wait_time(3)
	$Timer.start()
	speed = 1
	
func die():
	queue_free()

func win():
	queue_free()

func turnLeft():
	$AnimSprite.play("left")
	$CollisionShape2D.set_position(Vector2(-20, 5))
	$Light2D.set_position(Vector2(-30, -20))

func turnRight():
	$AnimSprite.play("right")
	$CollisionShape2D.set_position(Vector2(20, 5))
	$Light2D.set_position(Vector2(30, -20))

func start_blinking(interval):
	blink_timer.set_wait_time(interval)
	blink_timer.start()

func _on_blink_timeout():
	if is_visible():
		hide()
	else:
		show()

func stop_blinking():
	show()
	blink_timer.stop()

func _on_Timer_timeout():
	speed = 5
	direction = 1
	
	stop_blinking()
