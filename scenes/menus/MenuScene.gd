extends Control

const PlayScene = "res://scenes/GameInitialize.tscn"
const SettingsScene = "res://scenes/menus/SettingsScene.tscn"

func _ready():
	$MidiPlayer.play()

func _on_play_button_pressed():
	get_tree().change_scene_to_file(PlayScene)


func _on_settings_button_pressed():
	get_tree().change_scene_to_file(SettingsScene)
