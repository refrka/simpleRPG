extends CenterContainer
var nav_title = "<foraging>"

var player: Node

var loot_table:= {
	Enums.Items.FOOD_FRUIT: 15,
	Enums.Items.FOOD_NUTS: 15,
	Enums.Items.NONE: 30,
}

var foraging:= false
var nav_labels = {}

func _ready() -> void:
	player = Global.game.player
	nav_labels = {
		%navAgain: "<forage again>",
		%navBack: "<back>",
	}
	%navAgain.mouse_entered.connect(_on_hover.bind(true, %navAgain))
	%navAgain.mouse_exited.connect(_on_hover.bind(false, %navAgain))
	%navAgain.gui_input.connect(_on_forage_again)

	%navBack.mouse_entered.connect(_on_hover.bind(true, %navBack))
	%navBack.mouse_exited.connect(_on_hover.bind(false, %navBack))
	%navBack.gui_input.connect(_on_back)
	foraging = true
	forage()

func forage() -> void:
	var loot = get_forage()
	if loot.id != Enums.Items.NONE:
		%forageLabel.text = "%s found" % loot.data.item_name
		SignalBus.PLAYER_add_item.emit(loot)
	else:
		%forageLabel.text = "no forage found"

func get_forage() -> Item:
	var loot_id = Looter.generate_loot(loot_table)
	var loot = Item.new(loot_id)
	return loot

func _on_hover(state: bool, label: RichTextLabel) -> void:
	if state == true:
		label.text = "[color=blue]%s[/color]" % label.text
	if state == false:
		label.text = nav_labels[label]

func _on_forage_again(input: InputEvent) -> void:
	if input.is_action_pressed("select"):
		forage()

func _on_back(input: InputEvent) -> void:
	if input.is_action_pressed("select"):
		SignalBus.EXPLORE_menu.emit()
