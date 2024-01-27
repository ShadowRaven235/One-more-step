extends Node2D

func _physics_process(_delta):
	if Utils.slope == Utils.slopes.NONE:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "rotation", 0.0, 0.5)
		
	elif Utils.slope == Utils.slopes.SLOPE_RIGHT:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "rotation", 0.3, 0.5)
		
	elif Utils.slope == Utils.slopes.SLOPE_LEFT:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "rotation", -0.3, 0.5)
