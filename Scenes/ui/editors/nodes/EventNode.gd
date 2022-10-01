extends AvaNode
class_name EventNode

onready var line := $LineEdit

func get_event_name() -> String:
	return line.text
