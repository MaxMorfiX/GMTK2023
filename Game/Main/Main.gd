extends Node2D

@onready var game_over_menu: Control = $CanvasLayer/Control/GameOverMenu
@onready var timer = $CanvasLayer/Control/Time
@onready var time_record = $CanvasLayer/Control/TimeRecord

var TransitionAnimation: PackedScene = preload('res://Singletons/TransitionAnimation/TransitionAnimatinon.tscn')
var instantiated_transition_animation: CanvasItem

func game_over():
	
	game_over_menu.show()
	timer.active = false
	
	if timer.time > Game.record:
		Game.record = timer.time
		time_record.text = "Record: " + timer.str_time(Game.record)

func restart_game():
	instantiated_transition_animation.fade_out(get_tree().reload_current_scene)

func _ready() -> void:
	time_record.text = "Record: " + timer.str_time(Game.record)
	
	instantiated_transition_animation = TransitionAnimation.instantiate()
	$CanvasLayer.add_child(instantiated_transition_animation)
	
	instantiated_transition_animation.fade_in(start_game)

func start_game():
	$Game.start_game()
	timer.active = true
