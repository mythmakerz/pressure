extends Control

const PlayScene = "res://scenes/GameInitialize.tscn"
const SettingsScene = "res://scenes/GameInitialize.tscn" # TODO: change this to an actual settings scene later

func _on_play_button_pressed():
	get_tree().change_scene_to_file(PlayScene)
