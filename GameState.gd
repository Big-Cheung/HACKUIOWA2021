extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 200


# Called when the node enters the scene tree for the first time.
var meteor = load("res://Meteor.tscn")
var delay = 1000

func _ready():
	rand_seed(OS.get_unix_time())



func _process(delta):
	if delay >= 1:
		var newMeteor = meteor.instance()
		add_child(newMeteor)
		delay = 0
	delay += delta
	
	if Input.is_action_pressed("down") and $Player.position.y < 500:
		$Player.position.y += speed*delta
	elif Input.is_action_pressed("up") and $Player.position.y > 100:
		$Player.position.y -= speed*delta
