extends Control


onready var graph :GraphEdit = $"%GraphEdit"
onready var progressBar := $"%TimeProgress"

export (PackedScene) var node_popup : PackedScene

func tick_event(event : String) -> void:
	for n in graph.get_children():
		if n is EventNode && (n as EventNode).get_event_name().to_lower() == event.to_lower():
			n.tick(graph)

func create_node_popup(position : Vector2) -> void:
	var inst := node_popup.instance() as Popup
	add_child(inst)
	inst.connect("on_node_selected", self, "create_node", [position], CONNECT_ONESHOT)
	var rect := Rect2()
	rect.position = position
	rect.size = inst.rect_size
	inst.popup(rect)
	yield(inst, "popup_hide")
	inst.queue_free()

func create_node(node : PackedScene, position : Vector2) -> void:
	var inst := node.instance() as GraphNode
	graph.add_child(inst)
	inst.offset = position + graph.scroll_offset
	

func _on_BtnReset_pressed() -> void:
	push_warning("Not implemented")


func _on_GraphEdit_connection_from_empty(to: String, to_slot: int, release_position: Vector2) -> void:
	create_node_popup(release_position)


func _on_GraphEdit_connection_request(from: String, from_slot: int, to: String, to_slot: int) -> void:
	graph.connect_node(from, from_slot, to, to_slot)


func _on_GraphEdit_connection_to_empty(from: String, from_slot: int, release_position: Vector2) -> void:
	create_node_popup(release_position)


func _on_GraphEdit_popup_request(position: Vector2) -> void:
	create_node_popup(position)


func _on_GraphEdit_delete_nodes_request(nodes: Array) -> void:
	for strname in nodes:
		var node := graph.find_node(strname, false, false)
		if node:
			node.queue_free()


func _on_GraphEdit_disconnection_request(from: String, from_slot: int, to: String, to_slot: int) -> void:
	graph.disconnect_node(from, from_slot, to, to_slot)



func _on_TickEvent_pressed() -> void:
	tick_event("tick")
