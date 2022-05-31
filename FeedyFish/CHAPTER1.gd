extends Node

var sta = 0
var gameEnded = false
var unitValue = 0.07
const winPoints = 2000

func _ready():
	set_process(true)
	$menu.setUnitValue(unitValue) # unitValue for bar runs
	$introCHAPTER1/intro/message.readFromFile("res://FileText/chapter1.txt")
	$introCHAPTER1.visible = true

func _on_introButton_pressed():
	$introCHAPTER1.hide()
	$Player.start()

func getPlayerPosition():
	if gameEnded:
		return Vector2(-100, -100)
	else:
		return $Player.position


func addPoints(var num):
	$music.play_eatSound()
	$menu.addPoints(num)
	
	#player grow up
	if $menu.reachNewSta() == true:
		# need more points to grow when player got bigger
		unitValue -= 0.01
		$menu.setUnitValue(unitValue)
		
		sta = $menu.getSta()
		$Player.growUp(sta + 0.8, 6 + sta / 2)
		
	if $menu.getPoints() >= winPoints:
		playerWin()


# func when player collides fishes
func hitsFishLevel1():
	addPoints(10)


func hitsFishLevel2():
	if sta >= 1:
		addPoints(20)
		return true
	else:
		playerLose()
		return false


func hitsFishLevel3():
	if sta >= 2:
		addPoints(30)
		return true
	else:
		playerLose()
		return false

func hitsFishLevel4():
	if sta >= 3:
		addPoints(40)
		return true
	else:
		playerLose()
		return false

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

func hitsShark():
	if sta >= 6:
		addPoints(70)
		return true
	else:
		playerLose()
		return false

func hitsJellyFish():
	$music.play_jellyOctoSound()
	$Player.slowDown()
	$Player.start_blinking(0.05)

func hitsOctopus():
	$music.play_jellyOctoSound()
	$Player.start_blacking(2.5)


func playerWin():
	$music.play_changeSceneSound()
	$Player.win()
	gameEnded = true
	$finishBox.win()

func playerLose():
	$music.play_eatSound()
	$music.play_gameOverSound()
	$Player.die()
	gameEnded = true
	$finishBox.lose()


func turn_onSound():
	$music.turn_onSound()
	if not gameEnded:
		$Player.turn_onSound()

func turn_offSound():
	$music.turn_offSound()
	if not gameEnded:
		$Player.turn_offSound()


	
