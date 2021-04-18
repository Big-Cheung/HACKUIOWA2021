extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	updateGameData()
	
func updateGameData():
	$"MaxFuel/CurrentFuel".text = str(Globals.currentFuel)
	$"MaxFuel/MaxFuel".text = str(Globals.maxFuel)
	$"HealthInfo/CurrentHealth".text = str(Globals.currentHealth)
	$"HealthInfo/MaxHealth".text = str(Globals.maxHealth)
	$"RocksContainer/RocksValue".text = str(Globals.rocks)
	$"PointsContainer/PointsValue".text = str(Globals.points)
	$"MaxFuel/FuelBar".anchor_right = float(Globals.currentFuel)/float(Globals.maxFuel)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
