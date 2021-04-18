extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 200


# Called when the node enters the scene tree for the first time.
var meteor = load("res://Meteor.tscn")
var delay = 1000
var extending = false

func _ready():
	randomize()
	$Player/Chain/Area2D.connect("area_entered",self,"collide")
	rand_seed(OS.get_unix_time())



func _process(delta):
	if Globals.currentFuel <= 0:
		print("L")
		return
	if delay >= 1:
		Globals.currentFuel -= 1
		var newMeteor = meteor.instance()
		add_child(newMeteor)
		delay = 0
	delay += delta
	
	if Input.is_action_pressed("down") and $Player.position.y < 500 and not extending:
		$Player.position.y += speed*delta
	elif Input.is_action_pressed("up") and $Player.position.y > 100 and not extending:
		$Player.position.y -= speed*delta

func _input(event):
	if event.is_action("fire"):
		$Player/Animator.play("Chain",-1,2)
		extending = true
		yield(get_node("Player/Animator"),"animation_finished")
		extending = false
		
func collide(obj):
	if obj.get_parent().getName() == "Meteor":
		Globals.rocks += (randi()%5 + 5)
		Globals.currentFuel = max(Globals.currentFuel +(randi()%5 + 5), 100)
		obj.get_parent().queue_free()
		print("Added fuel and rocks")

func loseGame():
	pass
