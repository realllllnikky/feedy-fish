extends Area2D

export var speed = 6
var direction
var blink_timer
var black_timer
var availableSound = true

func _ready():
	position = Vector2(-100, -100)
	direction = 0
	
	$Timer.connect("timeout", self, "_on_Timer_timeout")
	
	blink_timer = Timer.new()
	blink_timer.connect("timeout", self, "_on_blink_timeout")
	add_child(blink_timer)
	
	black_timer = Timer.new()
	black_timer.connect("timeout", self, "_on_black_timeout")
	add_child(black_timer)

func start():
	position = Vector2(500, 300)
	direction = 1

func _process(delta):
	playerMove()

func playerMove():
	if direction == 1:
		if Input.is_action_pressed("ui_left"):
			position.x -= speed
			$AnimatedSprite.play("left")
		elif Input.is_action_pressed("ui_right"):
			position.x += speed
			$AnimatedSprite.play("right")
		
		elif Input.is_action_pressed("ui_down"):
			position.y += speed
		elif Input.is_action_pressed("ui_up"):
			position.y -= speed
		
		position.x = clamp(position.x, 0, 1030)
		position.y = clamp(position.y, 0, 600)

	elif direction == -1:
		if Input.is_action_pressed("ui_right"):
			position.x -= speed
			$AnimatedSprite.play("left")
		elif Input.is_action_pressed("ui_left"):
			position.x += speed
			$AnimatedSprite.play("right")
		
		elif Input.is_action_pressed("ui_up"):
			position.y += speed
		elif Input.is_action_pressed("ui_down"):
			position.y -= speed
		position.x = clamp(position.x, 0, 1030)
		position.y = clamp(position.y, 0, 600)
		
	elif not direction == 0:
		print("there is error: direction = " + str(direction))


# function for bubble follow player
func _on_BubbleTimer_timeout():
	var trail = preload("res://Player/trailScene.tscn").instance()
	get_parent().add_child(trail)
	trail.position = position


func fastLighting():
	playSound($eatSound)
	$Timer.set_wait_time(3)
	$Timer.start()
	speed = 12

func loseControl():
	playSound($eatSound)
	$Timer.set_wait_time(4)
	$Timer.start()
	direction = -1

func slowDown():
	playSound($eatSound)
	$Timer.set_wait_time(3)
	$Timer.start()
	speed = 1

func newLevel():
	playSound($eatSound)
	playSound($funny)
	get_parent().addPoints(100)

func growUp(var newSize, newSpeed):
	scale = Vector2(newSize, newSize)
	speed = newSpeed


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


 
func start_blacking(interval):
	black_timer.set_wait_time(interval)
	black_timer.start()
	$AnimatedSprite.modulate = Color(0, 0, 1)


func _on_black_timeout():
	$AnimatedSprite.modulate = Color(1, 1, 1) # reset to default

func stop_blacking():
	$AnimatedSprite.modulate = Color(1, 1, 1) # reset to default
	black_timer.stop()


# become normal
func _on_Timer_timeout():
	speed = 4
	direction = 1
	stop_blacking()
	stop_blinking()


func die():
	queue_free()

func win():
	queue_free()

func playSound(sound):
	if availableSound == true:
		sound.play()

func turn_onSound():
	availableSound = true

func turn_offSound():
	availableSound = false
