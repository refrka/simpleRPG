extends VBoxContainer

var player: Node:
    set(value):
        player = value
        reload()


func reload() -> void:
    var potions = []
    var books = []
    for item in player.inventory:
        var label = new_item_label()
        label.text = item.data.item_name
        match item.data.type:
            Enums.ItemType.POTION:
                potions.append(label)
            Enums.ItemType.BOOK:
                label.text = item.data.item_name
                books.append(label)
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