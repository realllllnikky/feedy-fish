extends Node

var sta = 0
var winPoints = 2000
var gameEnded = false
var unitValue = 0.05

func _ready():
	set_process(true)
	$menu.setUnitValue(unitValue)
	$introCHAPTER3/intro/message.readFromFile("res://FileText/chapter3.txt")
	$introCHAPTER3.visible = true

func _on_introButton_pressed():
	$introCHAPTER3.hide()
	$Player.start()


func getPlayerPosition():
	if gameEnded:
		return Vector2(-100, -100)
	else:
		return $Player.position


func addPoints(var num):
	$music.play_eatSound()
	$menu.addPoints(num)
	
	if $menu.reachNewSta() == true:
		sta = $menu.getSta()
		
		# need more points to grow when player got bigger
		if sta >= 4:
			unitValue -= 0.01
			$menu.setUnitValue(unitValue)
			$Player.growUp(0.1 + sta / 100 , 5 + sta / 2)
			$music.play_funnySound()
	
	if $menu.getPoints() >= winPoints:
		playerWin()


func hitsFishLevel1():
	addPoints(10)

func hitsFishLevel5():
	if sta >= 4:
		addPoints(50)
		return true
	else:
		playerLose()
		return false

func hitsFishLevel6():
	if sta >= 5:
		addPoints(60)
		return true
	else:
		playerLose()
		return false

func hitsSharkPlus():
	
	if $SharkPlus.getNumOfFlags() == 0:
		addPoints(70)
		return true
	else:
		playerLose()
		return false


func hitsJellyFish():
	$music.play_jellyOctoSound()
	$Player.slowDown()
	$Player.start_blinking(0.05)


func playerWin():
	$music.play_changeSceneSound()
	gameEnded = true
	$Player.win()
	$finishBox.win()

func playerLose():
	$music.play_gameOverSound()
	gameEnded = true
	$Player.die()
	$finishBox.lose()


func turn_onSound():
	$music.turn_onSound()

func turn_offSound():
	$music.turn_offSound()

