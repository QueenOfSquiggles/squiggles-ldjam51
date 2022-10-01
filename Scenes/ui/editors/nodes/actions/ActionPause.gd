extends AvaNode

onready var input_seconds := $TimeSeconds

func tick(graph : GraphEdit, event : String) -> void:
	EventBus.trigger_ava_action("pause %s" % str(input_seconds.value))
	.tick(graph, event)

func get_save_data() -> Dictionary:
	return {
		"seconds" : input_seconds.value
	}

func load_save_data(data : Dictionary) -> void:
	input_seconds.value = data.seconds
