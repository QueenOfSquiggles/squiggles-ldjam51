extends Control

export (NodePath) var target_node : NodePath 
export (float) var alpha_hidden := 0.1

onready var target := get_node(target_node)

func _on_EditorVisibility_mouse_entered() -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(target, "modulate:a", alpha_hidden, 0.5)


func _on_EditorVisibility_mouse_exited() -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(target, "modulate:a", 1.0, 0.5)
