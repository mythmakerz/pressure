extends Control

const SceneLoader = preload("res://scripts/SceneLoader.gd")

func sceneLoad(scene, transition):
	var newSceneLoader = SceneLoader.new()
	newSceneLoader.loadScene(scene, transition)
	print("LOADING SCENE: " + scene)
