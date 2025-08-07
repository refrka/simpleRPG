extends MarginContainer
var nav_title = "<exploring>"
var store_scene:=true

var id:= Enums.Scenes.EXPLORE

var explore_log = []

var menu_scene = "res://scenes/explore/menu.tscn"
var menu: Node

var nav_scenes = {}
var nav_labels = {}
var explore_scenes = {}

func _ready() -> void:
	SignalBus.EXPLORE_menu.connect(_on_menu)
	SignalBus.EXPLORE_forage.connect(_on_forage)
	SignalBus.EXPLORE_travel.connect(_on_travel)
	SignalBus.EXPLORE_wait.connect(_on_wait)
	SignalBus.EXPLORE_log_event.connect(_log_event)

	nav_labels = {
		%navReturn: "<return home>",
	}
	nav_scenes = {
		%navReturn: Enums.Scenes.HOME
	}
	explore_scenes = {
		Enums.Scenes.FORAGE: "res://scenes/explore/forage.tscn",
		Enums.Scenes.TRAVEL: "res://scenes/explore/travel.tscn",
		Enums.Scenes.WAIT: "res://scenes/explore/wait.tscn",
	}

	%navReturn.mouse_entered.connect(_on_hover.bind(true, %navReturn))
	%navReturn.mouse_exited.connect(_on_hover.bind(false, %navReturn))
	%navReturn.gui_input.connect(_on_nav_select.bind(%navReturn))

func _clear_menu() -> void:
	menu = %exploreContent.get_child(0)
	%exploreContent.remove_child(menu)

func _on_hover(state: bool, label: RichTextLabel) -> void:
	if state == true:
		label.text = "[color=blue]%s[/color]" % label.text
	if state == false:
		label.text = nav_labels[label]

func _on_nav_select(input: InputEvent, label: RichTextLabel) -> void:
	if input.is_action_pressed("select"):
		SignalBus.SCENE_scene_change.emit(nav_scenes[label])

func _on_menu() -> void:
	var old_scene = %exploreContent.get_child(0)
	old_scene.queue_free()
	%exploreContent.add_child(menu)
	SignalBus.SCENE_update_nav.emit(self)

func _on_forage() -> void:
	_clear_menu()
	var new_scene = load(explore_scenes[Enums.Scenes.FORAGE]).instantiate()
	SignalBus.SCENE_update_nav.emit(new_scene)
	%exploreContent.add_child(new_scene)

func _on_travel() -> void:
	_clear_menu()
	var new_scene = load(explore_scenes[Enums.Scenes.TRAVEL]).instantiate()
	SignalBus.SCENE_update_nav.emit(new_scene)
	%exploreContent.add_child(new_scene)


func _on_wait() -> void:
	_clear_menu()

func _log_event(event: Dictionary) -> void:
	explore_log.append(event)
