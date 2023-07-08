extends Node2D

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
	get_parent().get_node('SnakeTrails').add_child(trail)
	_on_change_target_timer_timeout()

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

func _on_change_target_timer_timeout() -> void:
	
	target = get_new_target()