extends Node

enum slopes {NONE, SLOPE_RIGHT, SLOPE_LEFT}

var distance = 0
var canStep = false
var tripped = false
var gameOver = false
var slope = slopes.NONE
var waitForFirstInput = true
