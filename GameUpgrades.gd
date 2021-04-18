extends Node2D

var newFuelLevel
var newSpeedLevel
var newHealthLevel
var newHealth
var newHealthPurchased
var newGrabLevel
var newRockBalance

signal closed

func _ready():
	setDefaults();
	updateDisplay();
	
	$"Menu/FuelCapacity/UpgradeFC".connect("pressed", self, "upgradeFuel")
	$"Menu/ShipSpeed/UpgradeSS".connect("pressed", self, "upgradeSpeed")
	$"Menu/ShipDurability/UpgradeSD".connect("pressed", self, "upgradeHealth")
	$"Menu/GrabSpeed/UpgradeGS".connect("pressed", self, "upgradeGrab")
	$"Menu/ExtraHealth/PurchaseHealth".connect("pressed", self, "getHealth")
	
	$"Menu/Data/Cancel-button".connect("pressed", self, "setDefaults")
	$"Menu/Data/Save-close".connect("pressed", self, "saveChanges")

func setDefaults():
	newFuelLevel = Globals.fuelLevel
	newSpeedLevel = Globals.speedLevel
	newHealthLevel = Globals.healthLevel
	newHealth = Globals.currentHealth
	newHealthPurchased = Globals.healthPurchased
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
	Globals.healthLevel = newHealthLevel
	Globals.currentHealth = newHealth
	Globals.healthPurchased = newHealthPurchased
	
	Globals.grabSpeed += (int(newGrabLevel) - int(Globals.grabLevel)) * 0.2
	Globals.grabLevel = newGrabLevel
	
	Globals.rocks = newRockBalance
	setDefaults()
	emit_signal("closed")
	
	

func updateDisplay():
	$"Menu/FuelCapacity/FullBarFC/CurrentBarFC".anchor_right = newFuelLevel/10.0
	$"Menu/ShipSpeed/FullBarSS/CurrentBarSS".anchor_right = newSpeedLevel/10.0
	$"Menu/ShipDurability/FullBarSD/CurrentBarSD".anchor_right = newHealthLevel/5.0
	$"Menu/GrabSpeed/FullBarGS/CurrentBarGS".anchor_right = newGrabLevel/5.0
	$"Menu/ExtraHealth/CurrentHealthValue".text = str(newHealth)
	
	$"Menu/FuelCapacity/UpgradeCost".text = str(Globals.fuelLevelCosts[newFuelLevel])
	$"Menu/ShipSpeed/UpgradeCost".text = str(Globals.speedLevelCosts[newSpeedLevel])
	$"Menu/ShipDurability/UpgradeCost".text = str(Globals.healthLevelCosts[newHealthLevel])
	$"Menu/GrabSpeed/UpgradeCost".text = str(Globals.grabLevelCosts[newGrabLevel])
	$"Menu/ExtraHealth/UpgradeCost".text = str(100 + (20*newHealthPurchased))
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
		newHealth = 5 + newHealthLevel
		updateDisplay()	
		
func upgradeGrab():
	var cost = Globals.grabLevelCosts[newGrabLevel]
	if (int(newRockBalance) >= int(cost)) && (int(newGrabLevel) < 5):
		newRockBalance -= cost
		newGrabLevel += 1
		updateDisplay()	
		
func getHealth():
	var cost = 100 + (20*newHealthPurchased)
	if (int(newRockBalance) >= int(cost)) && (int(newHealth) < newHealthLevel + 5):
		newRockBalance -= cost
		newHealth += 1
		newHealthPurchased += 1
		updateDisplay()	
