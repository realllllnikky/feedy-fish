extends Area2D

var speed

func _ready():
	comeback()
	
func _process(delta):
	position.y += 1
	if position.y > 600:
		comeback()
		

	

func _on_loseControl_area_entered(area):
	
	if area.get_name() == "Player":
		get_parent().get_parent().get_node("Player").loseControl()
		comeback()

func comeback():
	randomize()
	position.x = rand_range(10, 1000)
	position.y = rand_range(-1000, 0)
