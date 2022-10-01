extends PanelContainer
export (float) var log_duration := 2.5
onready var vbox := $"%LogSequence"
onready var scroll := $ScrollContainer

func _ready() -> void:
	EventBus.connect("ava_event", self, "log_event")
	EventBus.connect("graph_event", self, "log_event")
	EventBus.connect("node_graph_log", self, "log_label")

func log_event(event : String) -> void:
	log_label("[Ava] " + event)

func log_label(text : String) -> void:
	var lbl := Label.new()
	lbl.text = text
	lbl.autowrap = true
	vbox.add_child(lbl)
	if "warn" in text.to_lower():
		lbl.add_color_override("font_color", Color.yellow)
	elif "err" in text.to_lower():
		lbl.add_color_override("font_color", Color.red)

	# force scroll to bottom
	yield(VisualServer, "frame_post_draw")
	var scrollbar := scroll.get_v_scrollbar() as VScrollBar
	scroll.scroll_vertical = scrollbar.max_value


	if log_duration <= 0:
		return
	yield(get_tree().create_timer(log_duration), "timeout")
	lbl.queue_free()
