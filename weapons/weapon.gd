class_name Weapon extends Node

var id: Enums.Weapons
var data: WeaponData
var type_strings:= {
    Enums.WeaponType.RANGED: "ranged",
    Enums.WeaponType.MELEE: "melee",
}
var data_ref:= {
    Enums.Weapons.BOW: "res://weapons/data/bow.tres",
    Enums.Weapons.SPEAR: "res://weapons/data/spear.tres",
    Enums.Weapons.SWORD: "res://weapons/data/sword.tres",
}

func _init(_id: Enums.Weapons) -> void:
    id = _id
    data = load(data_ref[id])

func get_type_string() -> String:
    return type_strings[data.type]