extends Node2D

class_name SnakesSpawner

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
@onready var screenSize: Vector2 = get_viewport().get_visible_rect().size

func add_new_snake() -> Snake:
	
	var x: float = rng.randf()*screenSize.x
	var y: float = rng.randf()*screenSize.y
	
	return add_new_snake_with_position(Vector2(x, y))
	
func add_new_snake_with_position(pos: Vector2) -> Snake:
	return call_deferred("_really_add_new_snake", pos)
	
func _really_add_new_snake(pos: Vector2) -> Snake:
	var snake: Snake = preload('res://Game/Main/Snake/Snake.tscn').instantiate()	
	
	snake.position = pos
	
	add_child(snake)
	
	return snake
