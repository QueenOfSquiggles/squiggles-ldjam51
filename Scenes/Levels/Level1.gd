extends Node

onready var anim := $AnimationPlayer

func _on_WinCondition_win_condition_met() -> void:
	anim.play("win_condition_setup")
