extends Apple

class_name CleverApple

var move_speed = 100

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
	var distances: Array[float] = []

	# Calculate distances and assign weights
	for snake in snakes:
		
		var wr = weakref(snake);
		if not wr.get_ref():
			snakes.earse(snake)
		
		var distance = position.distance_to(snake.position)
		distances.push_back(distance)

	# Calculate weights based on inverse distances
	var total_weight = 0.0
	var weights: Array[float] = []
	for distance in distances:
		var weight = 1.0 / distance  # Inverse of distance
		weights.push_back(weight)
		total_weight += weight

	# Normalize the weights
	for i in range(weights.size()):
		weights[i] /= total_weight

	# Generate a random number between 0 and 1
	var random_value = randf()

	# Select the snake based on weights
	var cumulative_weight = 0.0
	for i in range(snakes.size()):
		cumulative_weight += weights[i]
		if random_value <= cumulative_weight:
			return snakes[i]
	
	return snakes[0]

func update_nearest_snake() -> void:
	nearest_snake = get_nearest_snake()
