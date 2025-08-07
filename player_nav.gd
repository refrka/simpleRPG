extends VBoxContainer

var current_scene_id:= Enums.Scenes.NONE

var scene_ref:= {
	Enums.Scenes.NONE: "res://scenes/none.tscn",
	Enums.Scenes.HOME: "res://scenes/home.tscn",
	Enums.Scenes.EXPLORE: "res://scenes/explore.tscn",
	Enums.Scenes.CRAFT: "res://scenes/craft.tscn",
}

func load_scene(scene_id: Enums.Scenes) -> void:
	var scene = scene_ref[scene_id]
	