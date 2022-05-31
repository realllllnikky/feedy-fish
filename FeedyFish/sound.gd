extends Node

var availableSound = true

func _ready():
	$gameSound.play()
	$startSound.play()

#mouseSound
func _process(delta):
	if Input.is_action_just_pressed("Left_Mouse"):
			playSound($mouseClickSound)

func playSound(sound):
	if availableSound == true:
		sound.play()

func play_gameOverSound():
	playSound($gameOverSound)

func play_changeSceneSound():
	playSound($changeSceneSound)

func play_eatSound():
	playSound($eatSound)

func play_jellyOctoSound():
	playSound($jelly_octorSound)

func play_funnySound():
	playSound($funnySound)

func turn_onSound():
	availableSound = true

func turn_offSound():
	availableSound = false
	$gameSound.stop()

func getAvailableSound():
	return availableSound
