extends AvaNode

onready var spinX := $HBoxContainer/SpinInputX
onready var spinY := $HBoxContainer2/SpinInputY

func tick(graph : GraphEdit, event : String) -> void:
	EventBus.trigger_ava_action("move %s %s" % [str(int(spinX.value)),str(int(spinY.value))])
	.tick(graph, event)

func get_save_data() -> Dictionary:
	return {
		"x" : spinX.value,
		"y" : spinY.value
	}

func load_save_data(data : Dictionary) -> void:
	spinX.value = data.x
	spinY.value = data.y
