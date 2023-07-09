extends CanvasItem

enum Anim {FADE_IN, FADE_OUT, NONE}
var curr_anim: Anim = Anim.NONE

var anim_proggression: float = 0

var callback: Callable

var anim_length: float = 0.5

var color: Color = Color(0, 0, 0, 1)

func _process(delta: float) -> void:
	if curr_anim == Anim.NONE: return
	
	if curr_anim == Anim.FADE_IN:
		color.a = 1-anim_proggression*anim_proggression
	elif curr_anim == Anim.FADE_OUT:
		color.a = anim_proggression*anim_proggression
	
	if anim_proggression >= 1:
		curr_anim = Anim.NONE
		callback.call()
		
	anim_proggression += 1/anim_length * delta

	queue_redraw()

func _draw():
	
	var rect = Rect2(Vector2(0, 0), Vector2(99999, 999999))
	draw_rect(rect, color)



func fade_in(when_ended: Callable):
	curr_anim = Anim.FADE_IN
	
	callback = when_ended
	
	anim_proggression = 0
	
func fade_out(when_ended: Callable):
	curr_anim = Anim.FADE_OUT
	
	callback = when_ended
	
	anim_proggression = 0
