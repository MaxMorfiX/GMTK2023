extends CanvasLayer

@onready var game_scene: PackedScene = preload("res://Game/Main/Main.tscn")

func play() -> void:
	SceneManager.change_scene_to(game_scene)
