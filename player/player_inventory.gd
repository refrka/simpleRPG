extends VBoxContainer

var item_labels = {}

func _ready() -> void:
	SignalBus.PLAYER_add_item.connect(_on_add_item)

var player: Node:
	set(value):
		player = value
		reload()

func _on_add_item(item: Item) -> void:
	if player.inventory.size() < player.inventory_size:
		player.inventory.append(item)
		reload()

func reload() -> void:
	for child in %playerFood.get_children():
		child.queue_free()
	for child in %playerPotions.get_children():
		child.queue_free()
	for child in %playerBooks.get_children():
		child.queue_free()
	var food = []
	var potions = []
	var books = []
	for item in player.inventory:
		var label = new_item_label()
		label.mouse_entered.connect(_on_hover.bind(true, label))
		label.mouse_exited.connect(_on_hover.bind(false, label))
		label.gui_input.connect(_on_item_select.bind(item))
		label.text = item.data.item_name
		item_labels[label] = label.text
		match item.data.type:
			Enums.ItemType.FOOD:
				food.append(label)
			Enums.ItemType.POTION:
				potions.append(label)
			Enums.ItemType.BOOK:
				books.append(label)
	for label in food:
		%playerFood.add_child(label)
	for label in potions:
		%playerPotions.add_child(label)
	for label in books:
		%playerBooks.add_child(label)

func new_item_label() -> RichTextLabel:
	var new_label = RichTextLabel.new()
	new_label.fit_content = true
	new_label.bbcode_enabled = true
	new_label.autowrap_mode = TextServer.AUTOWRAP_OFF
	new_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	return new_label

func _on_hover(state: bool, label: RichTextLabel) -> void:
	if state == true:
		label.text = "[color=blue]%s[/color]" % label.text
	if state == false:
		label.text = item_labels[label]

func _on_item_select(input: InputEvent, item: Item) -> void:
	if input.is_action_pressed("select"):
		item.use()
		player.inventory.erase(item)
		reload()