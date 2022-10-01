extends AvaNode

onready var text_edit := $TextEdit

func tick(graph : GraphEdit, event :String) -> void:
	print("[PrintNode | '%s'] %s" % [event, text_edit.text])
	.tick(graph, event)

func get_save_data() -> Dictionary:
	return {
		"text": text_edit.text
	}

func load_save_data(data : Dictionary) -> void:
	text_edit.text = data.text
