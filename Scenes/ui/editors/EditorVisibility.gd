extends Control

export (NodePath) var target_node : NodePath 
export (float) var alpha_hidden := 0.1

onready var target := get_node(target_node)

var enabled := false

func _ready() -> void:
	yield(get_tree().create_timer(0.5), "timeout")
	enabled = true

func _on_EditorVisibility_mouse_entered() -> void:
	if not enabled:
		return
	var tween := get_tree().create_tween()
	tween.tween_property(target, "modulate:a", alpha_hidden, 0.5)


func _on_EditorVisibility_mouse_exited() -> void:
	if not enabled:
		return
	var tween := get_tree().create_tween()
	tween.tween_property(target, "modulate:a", 1.0, 0.5)
