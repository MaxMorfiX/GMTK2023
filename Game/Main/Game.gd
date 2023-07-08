extends Node2D

@export var snakes: int = 3
@export var apples: int = 3

@onready var snakes_spawner: SnakesSpawner = $Snakes
@onready var apples_spawner: ApplesSpawner = $Apples

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
@onready var screenSize: Vector2 = get_viewport().get_visible_rect().size

func _ready() -> void:
	
	var x: float = rng.randf()*screenSize.x
	var y: float = rng.randf()*screenSize.y
	
	$Apples/Player.position = Vector2(x, y)
	
	for i in snakes:
		snakes_spawner.add_new_snake()
	for i in apples:
		apples_spawner.add_new_apple()
