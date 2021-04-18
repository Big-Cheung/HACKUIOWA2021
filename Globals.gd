extends Node

var points = 0
var multiplier = 1.0

var rocks = 0

var currentFuel = 100
var maxFuel = 100
var fuelLevel = 0
var fuelLevelCosts = [10, 12, 15, 20, 25, 32, 40, 50, 60, 75, "max"]

var shipSpeed = 100
var speedLevel = 0
var speedLevelCosts = [10, 12, 15, 20, 25, 32, 40, 50, 60, 75, "max"]

var currentHealth = 5
var maxHealth = 5
var healthLevel = 0
var healthPurchased = 0
var healthLevelCosts = [20, 40, 60, 80, 100, "max"]

var grabSpeed = 1
var grabLevel = 0
var grabLevelCosts = [20, 40, 60, 80, 100, "max"]

func resetGlobalValues():
	points = 0
	multiplier = 1
	rocks = 0
	currentFuel = 100
	maxFuel = 100
	fuelLevel = 0
	shipSpeed = 100
	speedLevel = 0
	currentHealth = 5
	maxHealth = 5
	healthLevel = 0
	grabSpeed = 1
	grabLevel = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
