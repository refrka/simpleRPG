extends HBoxContainer

var nav_labels = {}
var nav_scenes = {}

func _ready() -> void:
	SignalBus.SCENE_update_nav.connect(_update_nav)
	nav_labels = {
		%navHome: "<home>",
		%navExplore: "<explore>",
		%navCraft: "<craft>",
		%navCombat: "<combat>",
	}
	nav_scenes = {
		%navHome: Enums.Scenes.HOME,
		%navExplore: Enums.Scenes.EXPLORE,
		%navCraft: Enums.Scenes.CRAFT,
		%navCombat: Enums.Scenes.COMBAT,
	}
	%navHome.mouse_entered.connect(_on_hover.bind(true, %navHome))
	%navHome.mouse_exited.connect(_on_hover.bind(false, %navHome))
	%navHome.gui_input.connect(_on_nav_select.bind(%navHome))
	%navExplore.mouse_entered.connect(_on_hover.bind(true, %navExplore))
	%navExplore.mouse_exited.connect(_on_hover.bind(false, %navExplore))
	%navExplore.gui_input.connect(_on_nav_select.bind(%navExplore))
	%navCraft.mouse_entered.connect(_on_hover.bind(true, %navCraft))
	%navCraft.mouse_exited.connect(_on_hover.bind(false, %navCraft))
	%navCraft.gui_input.connect(_on_nav_select.bind(%navCraft))
	%navCombat.mouse_entered.connect(_on_hover.bind(true, %navCombat))
	%navCombat.mouse_exited.connect(_on_hover.bind(false, %navCombat))
	%navCombat.gui_input.connect(_on_nav_select.bind(%navCombat))

func _on_hover(state: bool, label: RichTextLabel) -> void:
	if state == true:
		label.text = "[color=blue]%s[/color]" % label.text
	if state == false:
		label.text = nav_labels[label]

func _on_nav_select(input: InputEvent, label: RichTextLabel) -> void:
	if input.is_action_pressed("select"):
		SignalBus.SCENE_scene_change.emit(nav_scenes[label])

func _update_nav(scene: Node) -> void:
	%navCurrent.text = scene.nav_title
