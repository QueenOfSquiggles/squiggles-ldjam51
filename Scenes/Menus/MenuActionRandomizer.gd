extends Node

export (float) var pause_time_max := 2.0
export (float) var pause_time_min := 0.2
export (float) var move_distance_max := 20.0
export (float) var move_distance_min := 3.0
export (float) var chance_pause := 0.5

func _ready() -> void:
	randomize()
	for _i in range(5):
		create_action()

func create_action() -> void:
	if randf() < chance_pause:
		var pause_time := (randf() * (pause_time_max - pause_time_min)) + pause_time_min
		EventBus.trigger_ava_action("pause %s" % str(pause_time))
	else:
		var move_delta := Vector2()
		move_delta.x = (randf() * (move_distance_max - move_distance_min)) + move_distance_min
		move_delta.y = (randf() * (move_distance_max - move_distance_min)) + move_distance_min
		move_delta.x *= 1.0 if (randf() > 0.5) else -1.0
		move_delta.y *= 1.0 if (randf() > 0.5) else -1.0
		
		EventBus.trigger_ava_action("move %s %s" % [str(int(move_delta.x)), str(int(move_delta.y))])

func _on_Timer_timeout() -> void:
	create_action()
