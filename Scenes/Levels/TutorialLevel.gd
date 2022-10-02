extends Node

export (String) var opening_dialog_name := ""
onready var anim := $AnimationPlayer

func play_dialogue() -> void:
	var d = Dialogic.start(opening_dialog_name)
	add_child(d)
	d.connect("dialogic_signal", self, "dialog_listener")

func dialog_listener(signal_name : String) -> void:
	if signal_name == "start_tutorial":
		anim.play("start_tutorial")


func _on_WinCondition_win_condition_met() -> void:
	anim.play("win_condition_setup")
