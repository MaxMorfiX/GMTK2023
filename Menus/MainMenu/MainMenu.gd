extends CanvasLayer

@onready var game_scene := preload("res://Game/Main/Main.tscn")

func play() -> void:
	get_tree().change_scene_to_packed(game_scene)
