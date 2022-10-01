extends Button


func _ready() -> void:
	if "html" in OS.get_name().to_lower():
		queue_free()
