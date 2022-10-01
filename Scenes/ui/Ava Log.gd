extends PanelContainer
export (float) var log_duration := 2.5
onready var vbox := $"%LogSequence"

func _ready() -> void:
	#EventBus.connect("ava_action", self, "log_action")
	EventBus.connect("ava_event", self, "log_event")
	EventBus.connect("node_graph_log", self, "log_label")

func log_event(event : String) -> void:
	log_label("[Ava] " + event)

func log_label(text : String) -> void:
	var lbl := Label.new()
	lbl.text = text
	vbox.add_child(lbl)
	if text.begins_with("warning"):
		lbl.add_color_override("font_color", Color.yellow)
	if log_duration <= 0:
		return
	yield(get_tree().create_timer(log_duration), "timeout")
	lbl.queue_free()
