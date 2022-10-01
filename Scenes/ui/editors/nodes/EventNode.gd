extends AvaNode
class_name EventNode

onready var line := $LineEdit

func get_event_name() -> String:
	return line.text
	
func get_save_data() -> Dictionary:
	return {
		"event": line.text
	}

func load_save_data(data : Dictionary) -> void:
	line.text = data.event
