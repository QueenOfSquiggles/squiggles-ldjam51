extends Node

onready var anim := $AnimationPlayer

func _ready() -> void:
	pass

func play_dialogue(dialog : String) -> void:
	var d = Dialogic.start(dialog)
	add_child(d)
	d.connect("dialogic_signal", self, "dialog_listener")

func dialog_listener(signal_name : String) -> void:
	if signal_name == "start_tutorial":
		anim.play("start_tutorial")
