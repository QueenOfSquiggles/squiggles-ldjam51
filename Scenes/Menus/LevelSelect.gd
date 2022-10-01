extends Control

export (Array, Resource) var level_entries
export (PackedScene) var level_selector_scene : PackedScene
onready var flow_container := $VBoxContainer/HFlowContainer

func _ready() -> void:
	build()

func build() -> void:
	for r in level_entries:
		if not r is LevelEntry:
			continue
		var entry := r as LevelEntry
		var sel := level_selector_scene.instance() as LevelSelector
		flow_container.add_child(sel)
		sel.create(entry.name, entry.icon)
		sel.connect("selected", self, "load_level", [entry.level_scene])

func load_level(level_scene : PackedScene) -> void:
	SceneTransition.load_level(level_scene)


func _on_Button_pressed() -> void:
	SceneTransition.load_level(load("res://Scenes/Menus/MainMenu.tscn"))
