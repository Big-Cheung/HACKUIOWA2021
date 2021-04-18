extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 300

func getName():
	return "Meteor"
# Called when the node enters the scene tree for the first time.
func _ready():
	rand_seed(OS.get_unix_time())
	position.y = rand_range(100,500)
	position.x = 1075


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = position.x - delta*speed
	if position.x < -50:
		queue_free()
		

