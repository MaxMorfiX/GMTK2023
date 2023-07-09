extends Node

var TransitionAnimation = preload('res://Singletons/TransitionAnimation/TransitionAnimatinon.tscn')

var scene_to_run: PackedScene

func change_scene_to(scene):
	
	scene_to_run = scene
	
	var transition = TransitionAnimation.instantiate()
	get_tree().current_scene.add_child(transition)
	
	transition.fade_out(run_scene)

func run_scene():
	get_tree().change_scene_to_packed(scene_to_run)
	
