extends Area2D

class_name Apple

@export var mass = 10

var picked = false

@onready var apple_spawner = get_parent()

func pick():
	
	picked = true
	
	apple_spawner.add_new_apple()
	
	self.queue_free()

