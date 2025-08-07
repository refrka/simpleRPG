extends CenterContainer

var nav_labels = {}
var nav_scenes = {}

func _ready() -> void:
	nav_labels = {
		%navForage: "[forage]",
		%navTravel: "[travel]",
		%navWait: "[wait]",
	}
	nav_scenes = {
		%navReturn: Enums.Scenes.HOME,
	}

	%navForage.mouse_entered.connect(_on_hover.bind(true, %navForage))
	%navForage.mouse_exited.connect(_on_hover.bind(false, %navForage))
	%navForage.gui_input.connect(_on_forage)
	%navTravel.mouse_entered.connect(_on_hover.bind(true, %navTravel))
	%navTravel.mouse_exited.connect(_on_hover.bind(false, %navTravel))
	%navTravel.gui_input.connect(_on_travel)
	%navWait.mouse_entered.connect(_on_hover.bind(true, %navWait))
	%navWait.mouse_exited.connect(_on_hover.bind(false, %navWait))
	%navWait.gui_input.connect(_on_wait)

func _on_hover(state: bool, label: RichTextLabel) -> void:
	if state == true:
		label.text = "[color=blue]%s[/color]" % label.text
	if state == false:
		label.text = nav_labels[label]

func _on_forage(input: InputEvent) -> void:
	if input.is_action_pressed("select"):
		SignalBus.EXPLORE_forage.emit()

func _on_travel(input: InputEvent) -> void:
	if input.is_action_pressed("select"):
		SignalBus.EXPLORE_travel.emit()

func _on_wait(input: InputEvent) -> void:
	if input.is_action_pressed("select"):
		SignalBus.EXPLORE_wait.emit()
