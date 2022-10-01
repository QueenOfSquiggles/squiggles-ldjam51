extends CanvasLayer

onready var colour := $Colour

func _ready() -> void:
	visible = false
	colour.color.a = 0.0
	
func load_level(level_scene : PackedScene, duration : float = 1.0) -> void:
	visible = true
	var tween := get_tree().create_tween()
	tween.tween_property(colour, "color:a", 1.0, duration/2.0)
	tween.tween_property(colour, "color:a", 0.0, duration/2.0)
	yield(tween, "step_finished")
	get_tree().change_scene_to(level_scene)
	yield(tween, "finished")
	visible = false
