extends Panel

var points = 0
var oldSta = 0
var unitValue
const startBarValue = 20
# star 0: value = 20
# star 1: value = 34
# star 2: value = 46
# star 3: value = 58
# star 4: value = 70
# star 5: value = 82
# star 6: value = 94

func _ready():
	$pointsShow.set_text(str(points))
	$progressBar.value = startBarValue


func setUnitValue(var unitValue_):
	unitValue = unitValue_

func addPoints(var num):
	points += num
	$pointsShow.set_text(str(points))
	$progressBar.value += num * unitValue

func reachNewSta():
	# it is 12 btw each sta 
	# reach sta01 when value = 34
	# begin value is 20
	# 34 - 12 = 22, assume begin value = 22 when actually not
	var newSta = int(($progressBar.value - 22) / 12)
	if newSta > oldSta:
		oldSta = newSta
		return true
	
	return false

func getSta():
	return oldSta

func getPoints():
	return points


func _on_playSound_pressed():
	get_parent().turn_onSound()




func _on_stopSound_pressed():
	get_parent().turn_offSound()



func _on_backToStartScene_pressed():
	get_tree().change_scene("res://CHAPTERSscenes/startScene.tscn")
