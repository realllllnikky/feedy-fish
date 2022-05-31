extends Area2D

func _ready():
	comeback()

func _process(delta):
	position.y += 2
	if  position.y > 800:
		comeback()

func comeback():
	randomize()
	position.x = rand_range(30, 930)
	position.y = rand_range(-500, -100)


func _on_Area2D_area_entered(area):
	if area.get_name() == "Player":
		comeback()
		get_parent().hitsClock()
