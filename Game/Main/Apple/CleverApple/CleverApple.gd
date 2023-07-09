extends Apple

class_name CleverApple

var move_speed = 350

@onready var screen_size: Vector2 = get_viewport().get_visible_rect().size
@onready var snakes_container = get_parent().get_parent().get_node("Snakes") #I'm too lazy to make this more readable

var nearest_snake: Snake

func _process(delta: float) -> void:
	
	if nearest_snake == null:
		update_nearest_snake()
		return
	
	var direction = (position - nearest_snake.position).normalized()
	
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			position.x += move_speed * delta
		else:
			position.x -= move_speed * delta
	else:
		if direction.y > 0:
			position.y += move_speed * delta
		else:
			position.y -= move_speed * delta
#
#	position.x = fposmod(position.x, screen_size.x)
#	position.y = fposmod(position.y, screen_size.y)
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)



func get_nearest_snake() -> Snake:
	var snakes = snakes_container.get_children()
	
	var nearest_snake: Snake
	var nearest_sqr_dist: float = 9999999
	
	for snake in snakes:
		var dist = position.distance_squared_to(snake.position)
		
		if dist < nearest_sqr_dist:
			nearest_sqr_dist = dist
			nearest_snake = snake
			
#	print("snakes: " + str(snakes))
#	print("nearest snake: " + str(nearest_snake))
	
	return nearest_snake

func update_nearest_snake() -> void:
	nearest_snake = get_nearest_snake()
