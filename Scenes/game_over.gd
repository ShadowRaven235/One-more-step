extends Control

func _physics_process(_delta):
	if Utils.gameOver:
		visible = true
		get_node("MarginContainer/VBoxContainer/Distance").set_text("You Made It " + str(Utils.distance/10.0).pad_decimals(0) + " Steps!")
	else:
		visible = false

func _on_retry_pressed():
	Utils.distance = 0
	Utils.canStep = false
	Utils.tripped = false
	Utils.gameOver = false
	Utils.slope = Utils.slopes.NONE
	Utils.waitForFirstInput = true
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	
func _on_menu_pressed():
	Utils.distance = 0
	Utils.canStep = false
	Utils.tripped = false
	Utils.gameOver = false
	Utils.slope = Utils.slopes.NONE
	Utils.waitForFirstInput = true
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
