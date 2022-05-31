extends Node

var numOfFish
var gameTime = 99
var gameEnded = false
var addTime = 3

func _ready():
	$menu.setUnitValue(0.5)
	numOfFish = 0
	
	$menu.addPoints(0)
	
	$introCHAPTER2/intro/message.readFromFile("res://FileText/chapter2.txt")
	$introCHAPTER2.visible = true

func _on_introButton_pressed():
	$introCHAPTER2.hide()
	$Player.start()
	showTime()

func getPlayerPosition():
	if gameEnded:
		return Vector2(-100, -100)
	else:
		return $Player.position

func addNumOfFishes():
	numOfFish += 1
	$menu.addPoints(10)
	if numOfFish == 24:
		playerWin()

func showTime():
	$clock/MessageTimer.set_text(str(gameTime)) # 99s
	$clock/CHAPTER2Timer.start()


func hitsFishLevel1():
	$music.play_eatSound()
	addNumOfFishes()

func hitsJellyFish():
	$music.play_jellyOctoSound()
	$Player.start_blinking(0.05)
	$Player.slowDown()

func hitsClock():
	$music/eatSound.play()
	gameTime += addTime

func playerWin():
	$music.play_changeSceneSound()
	gameEnded = true
	$Player.win()
	$finishBox.win()
	$clock/CHAPTER2Timer.stop()

func playerLose():
	$music.play_gameOverSound()
	gameEnded = true
	$Player.die()
	$finishBox.lose()
	$clock/CHAPTER2Timer.stop()


func _on_CHAPTER2Timer_timeout():
	if gameTime > 0:
		gameTime -= 1
		showTime()

	elif gameTime == 0:
		playerLose()
		$clock/MessageTimer.set_text("0")
		$clock/CHAPTER2Timer.stop()


func turn_onSound():
	$music.turn_onSound()
	if not gameEnded:
		$Player.turn_onSound()

func turn_offSound():
	$music.turn_offSound()
	if not gameEnded:
		$Player.turn_offSound()


