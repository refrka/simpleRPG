class_name Items extends Node

var id: Enums.Items
var data: ItemData
var data_ref:= {
    Enums.Items.BOOK_CAST_FIRE: "res://items/data/book_cast_fire.tres",
    Enums.Items.BUFF_ATK: "res://items/data/buff_atk.tres",
    Enums.Items.POTION_HEAL: "res://items/data/potion_heal.tres",
}

func _init(_id: Enums.Items) -> void:
    id = _id
    data = load(data_ref[id])