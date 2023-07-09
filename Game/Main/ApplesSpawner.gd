extends Node2D

class_name ApplesSpawner

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
@onready var screenSize: Vector2 = get_viewport().get_visible_rect().size

func add_new_apple():
	call_deferred("_really_add_new_apple")
	
func _really_add_new_apple():
	var new_apple: Apple = preload('res://Game/Main/Apple/CleverApple/CleverApple.tscn').instantiate()
	
	var x: float = rng.randf()*screenSize.x
	var y: float = rng.randf()*screenSize.y
	
	new_apple.position = Vector2(x, y)
	
	add_child(new_apple)
