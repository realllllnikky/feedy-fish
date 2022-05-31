extends Area2D

var num = 2

func _ready():
	randomize()
	comeback()
	
func _process(delta):
	position.y += 2
	if position.y > 600:
		comeback()
		

func _on_newLevel_area_entered(area):
	
	if area.get_name() == "Player":
		num -= 1
		get_parent().get_parent().get_node("Player").newLevel()
		if num > 0:
			comeback()
		else:
			queue_free()

func comeback():
	position.x = rand_range(10, 1000)
	position.y = rand_range(-1800, -1700)


