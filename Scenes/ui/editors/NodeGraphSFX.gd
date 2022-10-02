extends Node

onready var sfx_graph_saved := $SFX_GraphSaved
onready var sfx_node_created := $SFX_NodeCreated
onready var sfx_node_connected := $SFX_NodeConnected
onready var sfx_node_deleted := $SFX_NodeDeleted
onready var sfx_node_disconnected := $SFX_NodeDiconnected


func _on_NodeGraphEditor_graph_saved() -> void:
	sfx_graph_saved.play()

func _on_NodeGraphEditor_node_created() -> void:
	sfx_node_created.play()

func _on_GraphEdit_connection_request(from: String, from_slot: int, to: String, to_slot: int) -> void:
	sfx_node_connected.play()

func _on_GraphEdit_disconnection_request(from: String, from_slot: int, to: String, to_slot: int) -> void:
	sfx_node_disconnected.play()

func _on_NodeGraphEditor_node_deleted_internal() -> void:
	sfx_node_deleted.play()
