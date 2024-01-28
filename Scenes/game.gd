extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Player/Camera2D/HighScore").set_text("HighScore: " + str(Utils.highScore))
	get_node("Player/Camera2D/TotalDistance").set_text("Total Steps: " + str(Utils.totalDistance))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Utils.gameOver:
		get_node("Player/Camera2D/HighScore").set_text("HighScore: " + str(Utils.highScore))
		get_node("Player/Camera2D/TotalDistance").set_text("Total Steps: " + str(Utils.totalDistance))
