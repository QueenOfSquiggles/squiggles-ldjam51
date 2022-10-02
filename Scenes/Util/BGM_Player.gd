extends Node

export(AudioStream) var audiostream : AudioStream

func _ready() -> void:
	BGM.play_bgm(audiostream)
