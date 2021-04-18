extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$"PlayButton".connect("pressed", self, "displayGame")
	$"InfoButton".connect("pressed", self, "displayInfo")
	$"InfoScreen".connect("pressed", self, "hideInfo")
	$"InfoScreen".visible = false

func displayGame():
	#do nothing
	var x = 1+2
	
func displayInfo():
	$"InfoScreen".visible = true
	
func hideInfo():
	$"InfoScreen".visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
