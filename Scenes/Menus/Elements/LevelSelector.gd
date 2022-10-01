extends PanelContainer
class_name LevelSelector

# warning-ignore:unused_signal
signal selected

func _ready() -> void:
	$VBoxContainer/TextureButton.connect("pressed", self, "emit_signal", ["selected"])

func create(title : String, icon : Texture) -> void:
	$VBoxContainer/PanelContainer/Label.text = title
	$VBoxContainer/TextureButton.icon = icon
