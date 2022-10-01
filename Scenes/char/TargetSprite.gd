extends Sprite


var action_stack := []
var current_action :String = ""

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

func _action_completed() -> void:
	current_action = ""
	if action_stack.empty():
		EventBus.trigger_ava_event("action stack complete")

func _action_move(tokens : Array) -> void:
	var n_pos := position + Vector2(int(tokens[1]), int(tokens[2]))
	var tween := get_tree().create_tween()
	tween.tween_property(self, "position",n_pos, 0.5).set_trans(Tween.TRANS_CUBIC)
	yield(tween, "finished")
	_action_completed()

func _action_pause(tokens: Array) -> void:
	var seconds := float(tokens[1])
	yield(get_tree().create_timer(seconds), "timeout")
	_action_completed()



