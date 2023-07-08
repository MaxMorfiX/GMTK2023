extends Apple

class_name Player

@export_range(100, 500) var moveSpeed = 400
@onready var screenSize: Vector2 = get_viewport().get_visible_rect().size

func _process(delta: float) -> void:
	
	if Input.is_action_pressed("ui_up"):
		position.y -= moveSpeed*delta
	elif Input.is_action_pressed("ui_down"):
		position.y += moveSpeed*delta
	elif Input.is_action_pressed("ui_left"):
		position.x -= moveSpeed*delta
	elif Input.is_action_pressed("ui_right"):
		position.x += moveSpeed*delta
		
	position.x = posmod(int(position.x), int(screenSize.x))
	position.y = posmod(int(position.y), int(screenSize.y))

func _on_area_entered(area: Area2D) -> void:
	if area is Snake:
		print("game over!")
