extends Control

export (PackedScene) var level_select_menu : PackedScene

func _on_BtnPlay_pressed() -> void:
	SceneTransition.load_level(level_select_menu)


func _on_BtnQuit_pressed() -> void:
	get_tree().quit()
