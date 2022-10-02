extends Node2D


export (String) var label_text := "Pop Label"
export (float) var time_fade_in := 0.1
export (float) var time_rise := 1.5
export (float) var time_fade_out := 1.7
export (float) var distance_rise := 10


const full_size := 0.192

func pop() -> void:
	$Label.text = label_text
	var tween := get_tree().create_tween()
	self.scale = Vector2.ZERO
	tween.tween_property(self, "scale", Vector2.ONE * full_size, time_fade_in).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", position - Vector2(0, distance_rise), time_rise).set_trans(Tween.TRANS_BACK)
	tween.parallel().tween_property(self, "modulate:a", 0.0, time_fade_out).set_trans(Tween.TRANS_EXPO)
	yield(tween, "finished")
	queue_free()
