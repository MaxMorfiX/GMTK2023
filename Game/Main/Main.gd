extends Node2D

@onready var game_over_menu: Control = $CanvasLayer/Control/GameOverMenu
@onready var timer = $CanvasLayer/Control/Time
@onready var TimeRecord = $CanvasLayer/Control/TimeRecord

func game_over():
	
	game_over_menu.show()
	timer.active = false
	
	if timer.time > Game.record:
		Game.record = timer.time
		TimeRecord.text = "Record: " + timer.str_time(Game.record)
	

func restart_game():
	get_tree().reload_current_scene()

func _ready() -> void:
	TimeRecord.text = "Record: " + timer.str_time(Game.record)
