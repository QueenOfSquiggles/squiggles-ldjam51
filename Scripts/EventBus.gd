extends Node

signal ava_action(action)

func trigger_ava_action(action : String) -> void:
	print("[Ava Action Triggered] '%s'" % action)
	emit_signal("ava_action", action)
