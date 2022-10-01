extends KinematicBody2D


var action_stack := []
var current_action :String = ""

var current_interactable : Node = null

func _ready() -> void:
	EventBus.connect("ava_action", self, "queue_action")

func queue_action(action : String) -> void:
	action_stack.push_back(action)

func _process(delta: float) -> void:
	if current_action.empty() and not action_stack.empty():
		current_action = action_stack.pop_front()
		perform_action(current_action)

func perform_action(action : String) -> void:
	EventBus.trigger_ava_event(("event " + action))
	var tokens := action.split(" ", false)
	match tokens[0]:
		"move":
			_action_move(tokens)
		"pause":
			_action_pause(tokens)
		"interact":
			_action_interact()

func _action_completed() -> void:
	current_action = ""

func _action_move(tokens : Array) -> void:
	var n_pos := Vector2(int(tokens[1]), int(tokens[2]))
	if not test_move(transform, n_pos):
		var tween := get_tree().create_tween()
		tween.tween_property(self, "position",n_pos+position, 0.5).set_trans(Tween.TRANS_CUBIC)
		yield(tween, "finished")
	else:
		EventBus.trigger_node_graph_log("error: ava would collide with action %s. Skipping action" % str(tokens))
	_action_completed()

func _action_pause(tokens: Array) -> void:
	var seconds := float(tokens[1])
	yield(get_tree().create_timer(seconds), "timeout")
	_action_completed()

func _action_interact() -> void:
	if current_interactable:
		current_interactable.interact()
	else:
		EventBus.trigger_ava_event("error: cannot interact with nothing!")
	_action_completed()


func _on_Interactables_body_entered(body: Node) -> void:
	if body.has_method("interact"):
		EventBus.emit_signal("graph_event", "can interact")
		current_interactable = body


func _on_Interactables_body_shape_exited(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	if body == current_interactable:
		current_interactable = null
