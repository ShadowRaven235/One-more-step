extends Node

const SAVE_PATH = "res://savegame.bin"
enum slopes {NONE, SLOPE_RIGHT, SLOPE_LEFT}

var highScore = 0
var newHighScore = false
var totalDistance = 0
var distance = 0
var canStep = false
var tripped = false
var gameOver = false
var slope = slopes.NONE
var waitForFirstInput = true

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"highScore": highScore,
		"totalDistance": totalDistance,
	}
	var jsonStr = JSON.stringify(data)
	file.store_line(jsonStr)
	
func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH):
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				highScore = current_line["highScore"]
				totalDistance = current_line["totalDistance"]
