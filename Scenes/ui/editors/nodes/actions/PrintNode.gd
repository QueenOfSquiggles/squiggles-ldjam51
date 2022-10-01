extends AvaNode

onready var text_edit := $TextEdit

func tick(graph : GraphEdit) -> void:
	.tick(graph)
	print(text_edit.text)
