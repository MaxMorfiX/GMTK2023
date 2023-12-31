extends Node2D

@export var start_snakes: int = 3
@export var start_apples: int = 3
@export var time_between_snakes_spawn: int = 5*60

@onready var snakes_spawner: SnakesSpawner = $Snakes
@onready var apples_spawner: ApplesSpawner = $Apples
@onready var timer = get_parent().get_node("CanvasLayer/Control/Time")

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
@onready var screenSize: Vector2 = get_viewport().get_visible_rect().size

var spawned_player: bool = false

func start_game() -> void:
	
	for i in start_apples:
		apples_spawner.add_new_apple()
	for i in start_snakes:
		snakes_spawner.add_new_snake()

func spawn_player():
	var player: Player = preload('res://Game/Main/Apple/Player/Player.tscn').instantiate()
	
	#yes it's shitcode that was used for declaring x and y without error
	if true: 
		var x: float = rng.randf()*screenSize.x
		var y: float = rng.randf()*screenSize.y
		
		player.position = Vector2(x, y)
		
	while nearest_distance_from_point_to_snake(player.position) < 300:
		
		var x: float = rng.randf()*screenSize.x
		var y: float = rng.randf()*screenSize.y
		
		player.position = Vector2(x, y)
		
	get_node("Apples").add_child(player)

func nearest_distance_from_point_to_snake(p: Vector2) -> float:
	
	var nearest_dist: float = 999999
	
	for snake in get_node("Snakes").get_children():
		var dist = snake.position.distance_to(p)
		
		if nearest_dist > dist:
			nearest_dist = dist
	
	return nearest_dist

func _process(delta: float) -> void:
	if not spawned_player and $Snakes.get_child_count() > 0:
		spawn_player()
		spawned_player = true
