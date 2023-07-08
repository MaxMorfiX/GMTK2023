extends Node2D

@onready var game_over_menu: Control = $CanvasLayer/Control/GameOverMenu
@onready var timer = $CanvasLayer/Control/Timer

func game_over():
	
	game_over_menu.show()
	timer.active = false

func restart_game():
	get_tree().reload_current_scene()
