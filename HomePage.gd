extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var date

# Called when the node enters the scene tree for the first time.
func _ready():
	date = OS.get_unix_time()
	date += 7889231
	date = OS.get_datetime_from_unix_time(date)
	var day = "%02d" % date.day
	var month = "%02d" % date.month
	var year = date.year
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "completed")
	var url = "https://ssd-api.jpl.nasa.gov/cad.api?date-max=%s-%s-%s&dist-max=0.2" % [year,month,day]
	http_request.request(url)
	print(date,day,month,year)
	$"PlayButton".connect("pressed", self, "displayGame")
	$"InfoButton".connect("pressed", self, "displayInfo")
	$"InfoScreen".connect("pressed", self, "hideInfo")
	$"InfoScreen".visible = false

func completed(result, response_code, headers, body):
	var response = parse_json(body.get_string_from_utf8())
	for item in response.data:
		Globals.asteroids.push_back(item[0])
	print(Globals.asteroids)
	$Anim.play("Loading")

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
