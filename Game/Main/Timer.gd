extends Label

var time: float
var active: bool = true

func _ready() -> void:
	time = 0
	
func _process(delta: float) -> void:
	
	if not active:
		return
	
	time += delta
	
	var mils = fmod(time, 1)*100
	var secs = fmod(time, 60)
	var mins = time / 60
	
	var str_time = "Time: %02d:%02d.%02d" % [mins, secs, mils]
	
	text = str_time

