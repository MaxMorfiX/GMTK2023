extends Area2D

class_name Apple

@export var mass = 10

var picked = false

func pick():
	
	picked = true
	
	get_parent().add_new_apple()
	
	self.queue_free()

