extends Node

var index := 0
var effectively_silent_db := -100.0
var target_playing_decibels := -20.0

func _ready() -> void:
	for i in range(2):
		var player := AudioStreamPlayer.new()
		player.name="BGM Player " + str(i)
		add_child(player)

func play_bgm(audio : AudioStream, crossfade_time : float = 1.5) -> void:
	var tween := get_tree().create_tween()
	# fade out current
	tween.tween_property((get_child(index) as AudioStreamPlayer), "volume_db", effectively_silent_db, crossfade_time)

	# get next available
	index += 1
	index %= get_child_count()
	var current := (get_child(index) as AudioStreamPlayer)
	current.stream = audio
	current.volume_db = effectively_silent_db
	current.play()

	# fade in new current
	tween.parallel().tween_property(current, "volume_db", target_playing_decibels, crossfade_time)
