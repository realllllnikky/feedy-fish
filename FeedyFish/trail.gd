extends Sprite

func _ready():
	scale = 0.6 * get_parent().get_node("Player").scale 
	$Tween.interpolate_property(self, 
	"modulate", 
	Color(1,1,1,1),Color(1,1,1,0),
	0.6,
	Tween.TRANS_SINE,Tween.EASE_OUT)

	$Tween.start()


func _on_Tween_tween_completed(object, key):
	queue_free()
