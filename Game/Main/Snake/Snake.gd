extends Node2D

class_name Snake

@export_range(0, 180) var rotationSpeed: float = 1
@export_range(0, 300) var moveSpeed: float = 1

@onready var trail: Line2D = preload("res://Game/Main/Snake/SnakeTrail.tscn").instantiate()

var length = 50
#@onready var trail: Line2D = $SnakeTrail

func _ready() -> void:
	get_parent().get_node('SnakeTrails').add_child(trail)

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_left"):
		rotation_degrees -= rotationSpeed
	if Input.is_action_just_pressed("ui_right"):
		rotation_degrees += rotationSpeed

	position += Vector2(moveSpeed, 0).rotated(rotation)*delta
	
	var points = trail.get_points()
	points.push_back(position)
	
	if(points.size() > length):
		points.remove_at(0)
	
	trail.set_points(points)
