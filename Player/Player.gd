extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const maxStepTime = 0.5
@onready var startPosition = position.x

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animations = get_node("AnimationPlayer")

var stepping = false
var stepTime = maxStepTime

func _ready():
	animations.play("Idle")
	get_node("AnimatedSprite2D").flip_h = true

func _physics_process(delta):
	if Utils.waitForFirstInput == false:
		if Utils.victory and not Utils.gameOver:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			animations.play("Win")
			$Yay.play()
			Utils.distance = floor((position.x - startPosition)/10.0)
			Utils.gameOver = true
			if Utils.distance > Utils.highScore:
				Utils.highScore = Utils.distance
				Utils.newHighScore = true
			Utils.totalDistance = Utils.totalDistance + Utils.distance
			Utils.saveGame()
		elif Utils.gameOver == false:
			var floorAngle = get_floor_angle()
			
			if floorAngle == 0:
				Utils.slope = Utils.slopes.NONE
			elif floorAngle > 0.75 and floorAngle < 1:
				Utils.slope = Utils.slopes.SLOPE_LEFT
			elif floorAngle > 0.6 and floorAngle < 0.7 or floorAngle > 1:
				Utils.slope = Utils.slopes.SLOPE_RIGHT
				
			# Add the gravity.
			if not is_on_floor():
				velocity.y += gravity * delta
			
			if Utils.tripped and not Utils.gameOver:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				animations.play("Death")
				$TripGrunt.play()
				Utils.distance = floor((position.x - startPosition)/10.0)
				Utils.gameOver = true
				if Utils.distance > Utils.highScore:
					Utils.highScore = Utils.distance
					Utils.newHighScore = true
				Utils.totalDistance = Utils.totalDistance + Utils.distance
				Utils.saveGame()
			
			if not Utils.tripped:
				if Utils.canStep and (Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right")) or stepping:
					velocity.x = SPEED
					animations.play("Step")
					$Step.play()
					stepping = true
					stepTime -= delta
					if stepTime <= 0:
						stepping = false
						stepTime = maxStepTime
				else:
					velocity.x = move_toward(velocity.x, 0, SPEED)
					animations.play("Idle")
					stepping = false
					stepTime = maxStepTime
	move_and_slide()
		
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			Utils.waitForFirstInput = false


func _on_end_body_entered(body):
	if body.name == "Player":
		Utils.victory = true
