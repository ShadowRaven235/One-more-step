extends Area2D

var canStep = false
var direction = 1

func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position + Vector2(100 * direction,0), 2)

func _process(delta):
	if canStep and Input.is_action_just_pressed("ui_accept"):
		direction = direction * -1
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position + Vector2(100 * direction,0), 2)
		canStep = false
		print("step")

func _on_area_entered(area):
	if area.name == "Trip":
		print("trip")
		queue_free()
	if "Marker" in area.name:
		canStep = true
		print("step on")


func _on_area_exited(area):
	if "Marker" in area.name:
		canStep = false
		print("step off")
