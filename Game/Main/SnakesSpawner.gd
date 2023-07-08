extends Node2D

class_name SnakesSpawner

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
@onready var screenSize: Vector2 = get_viewport().get_visible_rect().size

func add_new_snake():
	call_deferred("_really_add_new_snake")
	
func _really_add_new_snake():
	var new_snake: Snake = preload('res://Game/Main/Snake/Snake.tscn').instantiate()
	
	var x: float = rng.randf()*screenSize.x
	var y: float = rng.randf()*screenSize.y
	
	new_snake.position = Vector2(x, y)
	
	add_child(new_snake)
