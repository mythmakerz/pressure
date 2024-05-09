extends Control

const SceneLoader = preload("res://scripts/SceneLoader.gd")

func sceneLoad(scene, transition):
	var newSceneLoader = SceneLoader.new()
	print("LOADING SCENE: " + scene)
	newSceneLoader.loadScene(scene, transition)
	


