extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 300
var index = int(rand_range(0,Globals.asteroids.size()-1))
func getName():
	return "Meteor"
	
func getAsteroidName():
	return $Name.text
# Called when the node enters the scene tree for the first time.
func _ready():
	rand_seed(OS.get_unix_time())
	position.y = rand_range(100,500)
	position.x = 1075
	if Globals.asteroids.size() >= 1:
		$Name.text = Globals.asteroids[index]
		Globals.asteroids.remove(index)
	else:
		queue_free()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not get_parent().running():
		return
	position.x = position.x - delta*speed
	if position.x < -50:
		Globals.asteroids.push_back(getAsteroidName())
		queue_free()
		

