extends Apple

class_name Player

@export_range(100, 500) var moveSpeed = 400

func _process(delta: float) -> void:
	
	if Input.is_action_pressed("ui_up"):
		position.y -= moveSpeed*delta
	elif Input.is_action_pressed("ui_down"):
		position.y += moveSpeed*delta
	elif Input.is_action_pressed("ui_left"):
		position.x -= moveSpeed*delta
	elif Input.is_action_pressed("ui_right"):
		position.x += moveSpeed*delta
