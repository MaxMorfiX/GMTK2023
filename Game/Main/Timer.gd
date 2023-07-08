extends Label

var time: float

func _ready() -> void:
	time = 0
	
func _process(delta: float) -> void:
	time += delta
	
	var mils = fmod(time, 1)*100
	var secs = fmod(time, 60)
	var mins = fmod(time, 60*60) / 60
	
	var str_time = "Time: %02d : %02d : %02d" % [mins, secs, mils]
	
	text = str_time
