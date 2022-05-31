extends Area2D

func _ready():
	randomize()
	setStartPos()
	
func _process(delta):
	position.y += 2
	if position.y > 600:
		setStartPos()


func _on_fastLighting_area_entered(area):
	
	if area.get_name() == "Player":
		get_parent().get_parent().get_node("Player").fastLighting()
		setStartPos()

func setStartPos():
	position.x = rand_range(10, 1000)
	position.y = rand_range(-3000, -20)
