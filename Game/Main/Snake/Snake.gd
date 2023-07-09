extends Area2D

class_name Snake

@export var max_rotate_speed: float = 1
@export var ang_deceleration: float = 10
@export_range(0, 300) var moveSpeed: float = 1

@onready var trail: Line2D = preload("res://Game/Main/Snake/SnakeTrail.tscn").instantiate()
@onready var apples_container = get_parent().get_parent().get_node("Apples")
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var length = 50
var target: Apple

func _ready() -> void:
	get_parent().get_parent().get_node('SnakeTrails').add_child(trail)
	
	var hue = rng.randf()
	
	$SnakeHead.self_modulate = Color.from_hsv(hue, 1, 0.7)
	
	trail.gradient = Gradient.new()
	
	trail.gradient.offsets = [0, 1]
	trail.gradient.colors = [
		Color.from_hsv(hue, 1, 0.5),
		Color.from_hsv(hue, 1, 1)
	]

func _process(delta: float) -> void:
	
#	if Input.is_action_pressed("ui_left"):
#		rotation_degrees -= rotationSpeed
#	if Input.is_action_pressed("ui_right"):
#		rotation_degrees += rotationSpeed

	ai_process(delta)

	position += Vector2(moveSpeed, 0).rotated(rotation)*delta
	
	var points = trail.get_points()
	points.push_back(position)
	
	if(points.size() > length):
		points.remove_at(0)
	
	trail.set_points(points)
	
func ai_process(delta: float) -> void:
	
	if target == null:
		change_target()
		return
	
	var wr = weakref(target);
	if not wr.get_ref():
		target = get_new_target()
		return
	
	var ang: float = get_angle_to(target.position)
	
	var speed_ratio = 1.0
	if ang < ang_deceleration:
		speed_ratio = ang / ang_deceleration

	var rotate_speed = max_rotate_speed * speed_ratio
	rotation += rotate_speed*delta
	
func get_new_target() -> Apple:
	
	var apples = apples_container.get_children()
	var distances: Array[float] = []

	# Calculate distances and assign weights
	for apple in apples:
		
		var wr = weakref(apple);
		if not wr.get_ref():
			apples.earse(apple)
		
		var distance = position.distance_to(apple.position)
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

	# Select the apple based on weights
	var cumulative_weight = 0.0
	for i in range(apples.size()):
		cumulative_weight += weights[i]
		if random_value <= cumulative_weight:
			return apples[i]
	
	return apples[0]

func change_target() -> void:
	
	target = get_new_target()

func _on_area_entered(area: Area2D) -> void:
	
	if not area is Apple: return
		
	var apple = area
	
	if apple.picked: return
	
	length += apple.mass
	
	apple.pick()
	
	change_target()
	
	if rng.randf() > 0.9: reproduce()

func reproduce():
	
	var pos: Vector2 = position
	
	get_parent().add_new_snake_with_position(pos)
