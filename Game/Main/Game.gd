extends Node2D

@export var start_snakes: int = 3
@export var start_apples: int = 3
@export var time_between_snakes_spawn: int = 5*60

@onready var snakes_spawner: SnakesSpawner = $Snakes
@onready var apples_spawner: ApplesSpawner = $Apples
@onready var timer = get_parent().get_node("CanvasLayer/Control/Timer")

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
@onready var screenSize: Vector2 = get_viewport().get_visible_rect().size

func _ready() -> void:
	
	var x: float = rng.randf()*screenSize.x
	var y: float = rng.randf()*screenSize.y
	
	$Apples/Player.position = Vector2(x, y)
	
	for i in start_snakes:
		snakes_spawner.add_new_snake()
	for i in start_apples:
		apples_spawner.add_new_apple()

func _process(delta: float) -> void:
	
	if Engine.get_process_frames() % time_between_snakes_spawn == 0:
		
		var snakes: Array[Node] = snakes_spawner.get_children()
		var rand_snake: Snake = snakes[rng.randf()*snakes.size()]
		
		var pos: Vector2 = rand_snake.position
		
		snakes_spawner.add_new_snake_with_position(pos)
