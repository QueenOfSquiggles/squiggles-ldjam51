extends Control

export (String) var data_file_name := "temp_data"
export (PackedScene) var node_popup : PackedScene
onready var graph :GraphEdit = $"%GraphEdit"
onready var progressBar := $"%TimeProgress"

func _ready() -> void:
	deserialize()
	EventBus.connect("graph_event", self, "tick_event")

func _input(event: InputEvent) -> void:
	if event.is_action("save"):
		serialize()

func tick_event(event : String) -> void:
	var flag := false
	for n in graph.get_children():
		if n is EventNode && (n as EventNode).get_event_name().to_lower() == event.to_lower():
			n.tick(graph, event)
			flag = true
	if not flag:
		EventBus.trigger_node_graph_log("warning: unhandled event '%s'" % event)

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

func create_node(node : PackedScene, position : Vector2, node_name : String = "") -> GraphNode:
	var inst := node.instance() as GraphNode
	graph.add_child(inst)
	inst.owner = graph
	if not node_name.empty():
		inst.name = node_name
	inst.offset = position + graph.scroll_offset
	inst.connect("close_request", self, "_on_GraphEdit_delete_nodes_request", [[inst.name.replace('@', '')]])
	return inst

func _on_BtnReset_pressed() -> void:
	var nodes := []
	for c in graph.get_children():
		if c is GraphNode:
			nodes.append((c as GraphNode).name)
	_on_GraphEdit_delete_nodes_request(nodes)

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
		var node := graph.find_node(strname)
		if node:
			for c in graph.get_connection_list():
				if c.from == strname or c.to == strname:
					graph.disconnect_node(c.from, c.from_port, c.to, c.to_port)
			node.queue_free()
		else:
			push_warning("failed to delete node '%s'" % str(strname))

func _on_GraphEdit_disconnection_request(from: String, from_slot: int, to: String, to_slot: int) -> void:
	graph.disconnect_node(from, from_slot, to, to_slot)

func _on_TickEvent_pressed() -> void:
	EventBus.trigger_graph_event("tick")

func _on_BtnSave_pressed() -> void:
	serialize()


func serialize() -> void:
	var data := {}
	for c in graph.get_children():
		if c is GraphNode:
			data[c.name] = {
				"resource_path": c.filename,
				"offsetx": (c as GraphNode).offset.x,
				"offsety": (c as GraphNode).offset.y,
				"name" : c.name
			}
			if c is AvaNode:
				data[c.name]["node_data"] = c.get_save_data()
	data["graph_data"] = {
		"connection_list": graph.get_connection_list(),
		"graph_scroll_x": graph.scroll_offset.x,
		"graph_scroll_y": graph.scroll_offset.y,
		"graph_zoom": graph.zoom
	}
	var path := "user://graphs/" + data_file_name + ".json"
	Directory.new().make_dir("user://graphs/")
	
	var file := File.new()
	if file.open(path, File.WRITE) == OK:
		file.store_string(JSON.print(data, "\t"))
		file.close()
	
	

func deserialize() -> void:
	var data := {}
	var file := File.new()
	var path := "user://graphs/" + data_file_name + ".json"
	if file.open(path, File.READ) == OK:
		data = parse_json(file.get_as_text())
		file.close()
	if data.empty():
		return
	var connection_list := []
	for e in data.keys():
		if e == "graph_data":
			var graph_data := data[e] as Dictionary
			connection_list = graph_data["connection_list"]
			graph.scroll_offset = Vector2(graph_data["graph_scroll_x"], graph_data["graph_scroll_y"])
			graph.zoom = graph_data["graph_zoom"]
		else:
			var node_data := data[e] as Dictionary
			var packed := load(node_data["resource_path"])
			var node := create_node(packed, Vector2(node_data["offsetx"],node_data["offsety"]), (node_data.name as String).replace('@', ""))
			if node is AvaNode and node_data.has("node_data"):
				(node as AvaNode).load_save_data(node_data["node_data"])

	for c in connection_list:
		graph.connect_node((c.from as String).replace('@', ""), c.from_port, (c.to as String).replace('@', ""), c.to_port)
