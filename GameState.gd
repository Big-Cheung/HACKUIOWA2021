extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
var meteor = load("res://Meteor.tscn")

func _ready():
	rand_seed(OS.get_unix_time())
	for i in range(2):
		var newMeteor = meteor.instance()
		add_child(newMeteor)



func _process(delta):
	if rand_range(1,50) == 1:
		var newMeteor = meteor.instance()
		add_child(newMeteor)
