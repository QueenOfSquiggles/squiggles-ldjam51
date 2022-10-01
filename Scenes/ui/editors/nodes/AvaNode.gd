extends GraphNode
class_name AvaNode

func tick(graph : GraphEdit) -> void:
	var list := graph.get_connection_list()
	for conn in list:
		if conn.from == name:
			# connection on this node
			var connected_node = graph.find_node(conn.to, false, false)
			if connected_node.has_method("tick"):
				connected_node.tick(graph)

