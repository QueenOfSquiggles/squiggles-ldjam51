extends CanvasLayer

signal win_condition_met

onready var anim := $AnimationPlayer

func _ready() -> void:
	EventBus.connect("refresh_win_condition", self, "update_state")

func update_state() -> void:
	yield(get_tree().create_timer(0.2), "timeout")
	
	print("Updating win state")
	var trash := get_tree().get_nodes_in_group("trash")
	if trash.size() <= 0:
		print("Win condition")
		BGM.play_bgm(null)
		emit_signal("win_condition_met")
		yield(VisualServer, "frame_post_draw")
		anim.play("level_complete")


func _on_BtnNextLevel_pressed() -> void:
	push_warning("This does nothing right now")


func _on_BtnLevelSelector_pressed() -> void:
	get_tree().paused = false
	SceneTransition.load_level_by_name("res://Scenes/Menus/LevelSelect.tscn")
