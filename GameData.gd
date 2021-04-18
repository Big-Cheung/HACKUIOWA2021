extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal upgradeClicked

# Called when the node enters the scene tree for the first time.
func _ready():
	$UpgradesButton.connect("pressed",self,"trigger")
	updateGameData()
	
func _process(delta):
	updateGameData()
	
func updateGameData():
	$"MaxFuel/CurrentFuel".text = str(Globals.currentFuel)
	$"MaxFuel/MaxFuel".text = str(Globals.maxFuel)
	$"HealthInfo/CurrentHealth".text = str(Globals.currentHealth)
	$"HealthInfo/MaxHealth".text = str(Globals.maxHealth)
	$"RocksContainer/RocksValue".text = str(Globals.rocks)
	$"PointsContainer/PointsValue".text = str(Globals.points)
	$"MaxFuel/FuelBar".anchor_right = float(Globals.currentFuel)/float(Globals.maxFuel)

func trigger():
	emit_signal("upgradeClicked")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
