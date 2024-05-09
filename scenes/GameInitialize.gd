extends Node3D

const SceneLoader = preload("res://scripts/SceneLoader.gd")

func sceneLoad(scene, transition):
	var newSceneLoader = SceneLoader.new()
	newSceneLoader.loadScene(scene, transition)
	print("LOADING SCENE: " + scene)

func _ready():
	const SCENELOL = "res://scenes/LoadingScene.tscn"
	await get_tree().create_timer(1.0)
	sceneLoad(SCENELOL, false)
	queue_free()
