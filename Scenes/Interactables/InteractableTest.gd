extends StaticBody2D

func interact() -> void:
	EventBus.trigger_node_graph_log("test object was interacted with!")
