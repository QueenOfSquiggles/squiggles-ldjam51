extends Node

signal ava_action(action)
signal ava_event(event)
signal node_graph_log(log_text)

func trigger_ava_action(action : String) -> void:
	emit_signal("ava_action", action)

func trigger_ava_event(event : String) -> void:
	emit_signal("ava_event", event)

func trigger_node_graph_log(log_text : String) -> void:
	emit_signal("node_graph_log", log_text)
