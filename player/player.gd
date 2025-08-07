extends Node

var inventory: Array[Items]
var inventory_size:= 6
var weapon: Weapon

var lvl:= 1
var xp:= 0
var hp_current:=25.0
var hp_max:=25.0
var mp_current:=5.0
var mp_max:=5.0
var atk:=1.0
var atk_buff:= 0.0
var def:=1.0
var def_buff:=0.0


func _init() -> void:
    Global.player = self

func get_inventory() -> void:
    inventory = [
        Items.new(Enums.Items.POTION_HEAL),
        Items.new(Enums.Items.BUFF_ATK),
        Items.new(Enums.Items.BOOK_CAST_FIRE),
    ]

func get_weapon() -> void:
    var starting_weapons = [
        Enums.Weapons.BOW,
        Enums.Weapons.SPEAR,
        Enums.Weapons.SWORD,   
    ]
    weapon = Weapon.new(starting_weapons.pick_random())


func start_game() -> void:
    get_inventory()
    get_weapon()

func update_stat(stat: StringName, new_value: Variant) -> void:
    set(stat, new_value)
    SignalBus.PLAYER_stat_change.emit(stat)
