extends VBoxContainer

var current_scene_id:= Enums.Scenes.NONE
var stored_scenes = {}
var previous_scene: Node

var scene_ref:= {
	Enums.Scenes.NONE: "res://scenes/none.tscn",
	Enums.Scenes.HOME: "res://scenes/home.tscn",
	Enums.Scenes.EXPLORE: "res://scenes/explore.tscn",
	Enums.Scenes.CRAFT: "res://scenes/craft.tscn",
	Enums.Scenes.COMBAT: "res://scenes/combat.tscn",
}

func _ready() -> void:
	SignalBus.SCENE_scene_change.connect(_scene_change)
	SignalBus.SCENE_go_back.connect(_go_back)
	SignalBus.SCENE_clear_scene.connect(_clear_scene)
	load_scene(current_scene_id)

func load_scene(scene_id: Enums.Scenes) -> void:
	var scene: Node
	if stored_scenes.has(scene_id):
		scene = stored_scenes[scene_id]
	else:
		scene = load(scene_ref[scene_id]).instantiate()
	current_scene_id = scene_id
	%navContainer.add_child(scene)
	SignalBus.SCENE_update_nav.emit(scene)

func _go_back() -> void:
	_scene_change(previous_scene.id)

func _scene_change(scene_id: Enums.Scenes) -> void:
	var old_scene = %navContainer.get_child(0)
	previous_scene = old_scene
	if old_scene.store_scene == true:
		stored_scenes[old_scene.id] = old_scene
	%navContainer.remove_child(old_scene)
	load_scene(scene_id)

func _clear_scene(scene_id: Enums.Scenes) -> void:
	if stored_scenes.has(scene_id):
		print("fuck")
	stored_scenes.erase(scene_id)
	
