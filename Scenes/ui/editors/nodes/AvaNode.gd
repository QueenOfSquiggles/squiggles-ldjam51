extends GraphNode
class_name AvaNode

func _ready() -> void:
	show_close = true

func tick(graph : GraphEdit, event : String) -> void:
	var list := graph.get_connection_list()
	for conn in list:
		if conn.from == name:
			# connection on this node
			var connected_node = graph.find_node(conn.to, false, false)
			if connected_node.has_method("tick"):
				connected_node.tick(graph, event)

func get_save_data() -> Dictionary:
	return {}

func load_save_data(data : Dictionary) -> void:
	pass
