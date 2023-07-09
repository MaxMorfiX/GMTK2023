extends Apple

class_name Player

@export_range(100, 500) var move_speed = 350
@onready var screen_size: Vector2 = get_viewport().get_visible_rect().size

func _process(delta: float) -> void:
	
	if Input.is_action_pressed("player_up"):
		position.y -= move_speed*delta
	elif Input.is_action_pressed("player_down"):
		position.y += move_speed*delta
	elif Input.is_action_pressed("player_left"):
		position.x -= move_speed*delta
	elif Input.is_action_pressed("player_right"):
		position.x += move_speed*delta
#
#	position.x = fposmod(position.x, screen_size.x)
#	position.y = fposmod(position.y, screen_size.y)
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func _on_area_entered(area: Area2D) -> void:
	if area is Snake:
		get_tree().current_scene.game_over()
