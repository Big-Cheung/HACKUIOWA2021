extends Node2D

var newFuelLevel
var newSpeedLevel
var newHealthLevel
var newGrabLevel
var newRockBalance

func _ready():
	setDefaults();
	updateDisplay();
	
	$"Menu/FuelCapacity/UpgradeFC".connect("pressed", self, "upgradeFuel")
	$"Menu/ShipSpeed/UpgradeSS".connect("pressed", self, "upgradeSpeed")
	$"Menu/ShipDurability/UpgradeSD".connect("pressed", self, "upgradeHealth")
	$"Menu/GrabSpeed/UpgradeGS".connect("pressed", self, "upgradeGrab")
	
	$"Menu/Data/Cancel-button".connect("pressed", self, "setDefaults")
	$"Menu/Data/Save-close".connect("pressed", self, "saveChanges")

func setDefaults():
	newFuelLevel = Globals.fuelLevel
	newSpeedLevel = Globals.speedLevel
	newHealthLevel = Globals.healthLevel
	newGrabLevel = Globals.grabLevel
	newRockBalance = Globals.rocks
	updateDisplay()
	#print(str(newFuelLevel) + '\n' + str(newSpeedLevel) + '\n' + str(newHealthLevel) + '\n' + str(newGrabLevel))
	#print(Globals.currentFuel)
	#print(Globals.shipSpeed)
	#print(Globals.currentHealth)
	#print(Globals.grabSpeed)

func saveChanges():
	Globals.currentFuel += (int(newFuelLevel) - int(Globals.fuelLevel)) * 5
	Globals.maxFuel += (int(newFuelLevel) - int(Globals.fuelLevel)) * 5
	Globals.fuelLevel = newFuelLevel
	
	Globals.shipSpeed += (int(newSpeedLevel) - int(Globals.speedLevel)) * 10
	Globals.speedLevel = newSpeedLevel
	
	Globals.maxHealth += (int(newHealthLevel) - int(Globals.healthLevel))
	Globals.currentHealth = Globals.maxHealth
	Globals.healthLevel = newHealthLevel
	
	Globals.grabSpeed += (int(newGrabLevel) - int(Globals.grabLevel)) * 0.2
	Globals.grabLevel = newGrabLevel
	
	Globals.rocks = newRockBalance
	setDefaults()
	

func updateDisplay():
	$"Menu/FuelCapacity/FullBarFC/CurrentBarFC".anchor_right = newFuelLevel/10.0
	$"Menu/ShipSpeed/FullBarSS/CurrentBarSS".anchor_right = newSpeedLevel/10.0
	$"Menu/ShipDurability/FullBarSD/CurrentBarSD".anchor_right = newHealthLevel/5.0
	$"Menu/GrabSpeed/FullBarGS/CurrentBarGS".anchor_right = newGrabLevel/5.0
	
	$"Menu/FuelCapacity/UpgradeCost".text = str(Globals.fuelLevelCosts[newFuelLevel])
	$"Menu/ShipSpeed/UpgradeCost".text = str(Globals.speedLevelCosts[newSpeedLevel])
	$"Menu/ShipDurability/UpgradeCost".text = str(Globals.healthLevelCosts[newHealthLevel])
	$"Menu/GrabSpeed/UpgradeCost".text = str(Globals.grabLevelCosts[newGrabLevel])
	$"Menu/Data/points-value".text = str(newRockBalance)

func upgradeFuel():
	var cost = Globals.fuelLevelCosts[newFuelLevel]
	if (int(newRockBalance) >= int(cost)) && (int(newFuelLevel) < 10):
		newRockBalance -= cost
		newFuelLevel += 1
		updateDisplay()
		
func upgradeSpeed():
	var cost = Globals.speedLevelCosts[newSpeedLevel]
	if (int(newRockBalance) >= int(cost)) && (int(newSpeedLevel) < 10):
		newRockBalance -= cost
		newSpeedLevel += 1
		updateDisplay()
	
func upgradeHealth():
	var cost = Globals.healthLevelCosts[newHealthLevel]
	if (int(newRockBalance) >= int(cost)) && (int(newHealthLevel) < 5):
		newRockBalance -= cost
		newHealthLevel += 1
		updateDisplay()	
		
func upgradeGrab():
	var cost = Globals.grabLevelCosts[newGrabLevel]
	if (int(newRockBalance) >= int(cost)) && (int(newGrabLevel) < 5):
		newRockBalance -= cost
		newGrabLevel += 1
		updateDisplay()	
