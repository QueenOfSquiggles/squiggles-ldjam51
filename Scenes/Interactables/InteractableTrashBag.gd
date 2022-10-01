extends StaticBody2D

func interact() -> void:
	EventBus.call_deferred("trigger_refresh_win_condition")
	queue_free()

func _input(event: InputEvent) -> void:
	if event.is_action("cheat_code"):
		interact()
