extends MarginContainer
var nav_title = "<travelling>"
var nav_labels = {}
var chosen_dir: Enums.TravelDir

var event_table:= {
	Enums.Events.COMBAT: 50,
	Enums.Events.NONE: 50,
}

func _ready() -> void:
	nav_labels = {
		%navBack: "<back>",
		%travelWest: "< west",
		%travelNorth: "^ north",
		%travelEast: "east >",
		%travelSouth: "v south",
	}

	%navBack.mouse_entered.connect(_on_hover.bind(true, %navBack))
	%navBack.mouse_exited.connect(_on_hover.bind(false, %navBack))
	%navBack.gui_input.connect(_on_back)
	%travelWest.mouse_entered.connect(_on_hover.bind(true, %travelWest))
	%travelWest.mouse_exited.connect(_on_hover.bind(false, %travelWest))
	%travelWest.gui_input.connect(_on_direction_select.bind(Enums.TravelDir.WEST))
	%travelNorth.mouse_entered.connect(_on_hover.bind(true, %travelNorth))
	%travelNorth.mouse_exited.connect(_on_hover.bind(false, %travelNorth))
	%travelNorth.gui_input.connect(_on_direction_select.bind(Enums.TravelDir.NORTH))
	%travelEast.mouse_entered.connect(_on_hover.bind(true, %travelEast))
	%travelEast.mouse_exited.connect(_on_hover.bind(false, %travelEast))
	%travelEast.gui_input.connect(_on_direction_select.bind(Enums.TravelDir.EAST))
	%travelSouth.mouse_entered.connect(_on_hover.bind(true, %travelSouth))
	%travelSouth.mouse_exited.connect(_on_hover.bind(false, %travelSouth))
	%travelSouth.gui_input.connect(_on_direction_select.bind(Enums.TravelDir.SOUTH))

func _clear_content() -> void:
	for child in %travelContent.get_children():
		if child != %travelText:
			child.queue_free()

func _do_combat() -> void:
	SignalBus.SCENE_scene_change.emit(Enums.Scenes.COMBAT)

func _on_hover(state: bool, label: RichTextLabel) -> void:
	if state == true:
		label.text = "[color=blue]%s[/color]" % label.text
	if state == false:
		label.text = nav_labels[label]

func _on_direction_select(input:InputEvent, dir: Enums.TravelDir) -> void:
	if input.is_action_pressed("select"):
		chosen_dir = dir
		_travel(chosen_dir)

func _on_back(input: InputEvent) -> void:
	if input.is_action_pressed("select"):
		SignalBus.EXPLORE_menu.emit()

func _travel(dir: Enums.TravelDir) -> void:
	var event = Looter.generate_event(event_table)
	_clear_content()
	match event:
		Enums.Events.COMBAT:
			_do_combat()
		Enums.Events.NONE:
			%travelLabel.text = "nothing found"
