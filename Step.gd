extends Area2D

var direction = 1
var rightSpeedMultiplier = 1.0
var leftSpeedMultiplier = 1.0

func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", position + Vector2(300 * direction,0), 2)

func _physics_process(delta):
	if Utils.slope == Utils.slopes.NONE:
		rightSpeedMultiplier = 1.0
		leftSpeedMultiplier = 1.0
	elif Utils.slope == Utils.slopes.SLOPE_RIGHT:
		rightSpeedMultiplier = 0.5
		leftSpeedMultiplier = 1.5
	elif Utils.slope == Utils.slopes.SLOPE_LEFT:
		rightSpeedMultiplier = 1.5
		leftSpeedMultiplier = 0.5
	
	if Utils.canStep and ((direction == 1 and Input.is_action_just_pressed("ui_right")) or (direction == -1 and Input.is_action_just_pressed("ui_left"))):
		direction = direction * -1
		var tween = get_tree().create_tween()
		
		# Change direction to the right
		if direction == 1:
			tween.tween_property(self, "position", position + Vector2(300 * direction,0), 2 * rightSpeedMultiplier)
			Utils.canStep = false
			
		# Change direction to the left
		if direction == -1:
			tween.tween_property(self, "position", position + Vector2(300 * direction,0), 2 * leftSpeedMultiplier)
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
