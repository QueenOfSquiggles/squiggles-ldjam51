extends Node

export (AudioStream) var pressed_sfx : AudioStream
export (AudioStream) var hover_sfx : AudioStream

onready var player := $AudioStreamPlayer

func _ready() -> void:
	var par := get_parent() as Button
	if not par:
		push_error("ButtonSFX must be a child of a button!")
		queue_free()
		return
	par.connect("pressed", self, "play_sfx_pressed")
	par.connect("mouse_entered", self, "play_sfx_hover")

func play_sfx_pressed() -> void:
	_play_sfx(pressed_sfx)

func play_sfx_hover() -> void:
	_play_sfx(hover_sfx)

func _play_sfx(audio : AudioStream) -> void:
	player.stop()
	player.stream = audio
	player.play()
