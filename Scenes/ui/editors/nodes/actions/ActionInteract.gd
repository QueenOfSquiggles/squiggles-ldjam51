extends AvaNode

func tick(graph : GraphEdit, event : String) -> void:
	EventBus.trigger_ava_action("interact")
	.tick(graph, event)
