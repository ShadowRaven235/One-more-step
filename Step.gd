extends Area2D

var direction = 1

func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position + Vector2(100 * direction,0), 2)

func _physics_process(delta):
	if Utils.canStep and ((direction == 1 and Input.is_action_just_pressed("ui_right")) or (direction == -1 and Input.is_action_just_pressed("ui_left"))):
		direction = direction * -1
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position + Vector2(100 * direction,0), 2)
		Utils.canStep = false

func _on_area_entered(area):
	if area.name == "Trip":
		Utils.tripped = true
		queue_free()
	if "Marker" in area.name:
		Utils.canStep = true


func _on_area_exited(area):
	if "Marker" in area.name:
		Utils.canStep = false
