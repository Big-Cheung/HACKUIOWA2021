extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 200


# Called when the node enters the scene tree for the first time.
var meteor = load("res://Meteor.tscn")
var rockparticles = load("res://RockParticles.tscn")
var delay = 1000
var extending = false
var isRunning = true

func _ready():
	randomize()
	$Player/Area2D.connect("area_shape_entered",self,"collide")
	$GUI.connect("upgradeClicked",self,"openUpgrades")
	$Upgrades.connect("closed",self,"closeUpgrades")
	rand_seed(OS.get_unix_time())



func _process(delta):
	if not isRunning:
		return
	if delay >= 1:
		Globals.currentFuel -= 1
		if Globals.currentFuel <= 0:
			loseGame()
		var newMeteor = meteor.instance()
		add_child(newMeteor)
		delay = 0
	delay += delta
	
	if Input.is_action_pressed("down") and $Player.position.y < 500 and not extending:
		$Player.position.y += speed*delta
	elif Input.is_action_pressed("up") and $Player.position.y > 100 and not extending:
		$Player.position.y -= speed*delta

func _input(event):
	if not isRunning:
		return
	if event.is_action("fire"):
		$Player/Animator.play("Chain",-1,1 + (Globals.grabLevel / 5))
		extending = true
		Globals.currentFuel -= 1
		yield(get_node("Player/Animator"),"animation_finished")
		extending = false
		
func collide(areaID,obj,area_shape,self_shape):
	if not isRunning:
		return
	if obj.get_parent().getName() == "Meteor":
		if self_shape == 1:
			Globals.rocks += (randi()%5 + 5)
			Globals.currentFuel = min(Globals.currentFuel +(randi()%5 + 5), Globals.maxFuel)
			obj.get_parent().queue_free()
			$Player/Animator.advance(max(0,2*(0.5-$Player/Animator.current_animation_position)/($Player/Animator.get_playing_speed())))
		else:
			Globals.currentHealth -= 1
			if Globals.currentHealth <= 0:
				loseGame()
			obj.get_parent().queue_free()
		var particle = rockparticles.instance()
		add_child(particle)
		particle.position = obj.get_parent().position

func running():
	return isRunning

func openUpgrades():
	isRunning = false
	$Upgrades.visible = true
	$Upgrades.setDefaults()
	$Upgrades.updateDisplay()

func closeUpgrades():
	isRunning = true
	$Upgrades.visible = false


func loseGame():
	isRunning = false
