extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
var meteor = load("res://Meteor.tscn")
var rockparticles = load("res://RockParticles.tscn")
var delay = 1
var d_meteor = 4
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
		Globals.currentFuel -= 4
		Globals.points += 10 * (Globals.multiplier)
		Globals.multiplier += (10 * (Globals.multiplier))/2000
		if Globals.currentFuel <= 0:
			Globals.currentFuel = 0
			loseGame()
		delay = 0
	if d_meteor >= (6/(2*(Globals.multiplier))):
		var newMeteor = meteor.instance()
		add_child(newMeteor)
		d_meteor = 0
	delay += delta
	d_meteor += delta
	
	if Input.is_action_pressed("down") and $Player.position.y < 500 and not extending:
		$Player.position.y += 150*(1+Globals.speedLevel/5)*delta
	elif Input.is_action_pressed("up") and $Player.position.y > 100 and not extending:
		$Player.position.y -= 150*(1+Globals.speedLevel/5)*delta

func _input(event):
	if not isRunning:
		return
	if event.is_action("fire"):
		$Player/Animator.play("Chain",-1,1 + (Globals.grabLevel / 5))
		extending = true
		yield(get_node("Player/Animator"),"animation_finished")
		extending = false
	elif event.is_action("upgrades"):
		openUpgrades()
		
func collide(areaID,obj,area_shape,self_shape):
	if not isRunning:
		return
	if obj.get_parent().getName() == "Meteor":
		if self_shape == 1:
			Globals.points += 100 * (Globals.multiplier)
			Globals.multiplier += (100 * (Globals.multiplier))/2000
			Globals.rocks += (randi()%5 + 5)
			Globals.currentFuel = min(Globals.currentFuel +(randi()%5 + 5), Globals.maxFuel)
			obj.get_parent().queue_free()
			$Player/Animator.advance(max(0,2*(0.5-$Player/Animator.current_animation_position)/($Player/Animator.get_playing_speed())))
		else:
			Globals.currentHealth -= 1
			Globals.multiplier = 1
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
