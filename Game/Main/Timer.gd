extends Label

var time: float
var active: bool = false

var record: float

func _ready() -> void:
	time = 0
	
func _process(delta: float) -> void:
	
	if not active:
		return
	
	time += delta
	
	text = "Time: " + str_time(time)

func str_time(time_to_stingify: float) -> String:
	var mils = fmod(time_to_stingify, 1)*100
	var secs = fmod(time_to_stingify, 60)
	var mins = time_to_stingify / 60
	
	return "%02d:%02d.%02d" % [mins, secs, mils]
