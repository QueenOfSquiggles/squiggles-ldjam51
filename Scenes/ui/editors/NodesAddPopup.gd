extends PopupMenu


export (Resource) var node_collection_raw : Resource
onready var node_collection := node_collection_raw as NodeCollection

signal on_node_selected(node)

func _on_NodesAddPopup_about_to_show() -> void:
	for i in range(node_collection.nodes.size()):
		var node = node_collection.nodes[i]
		var inst = node.instance()
		if inst:
			add_item(inst.name, i)


func _on_NodesAddPopup_index_pressed(index: int) -> void:
	var packed := node_collection.nodes[index] as PackedScene
	emit_signal("on_node_selected", packed)
	hide()

