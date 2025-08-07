extends Node

var inventory: Array[Item]
var inventory_size:= 10
var weapon: Weapon

var lvl:= 1
var xp:= 0
var hp_current:=15:
	set(value):
		if value > hp_max:
			hp_current = hp_max
		else:
			hp_current = value
var hp_max:=25
var mp_current:=5
var mp_max:=5
var atk:=1
var atk_buff:= 0
var def:=1
var def_buff:=0


func _init() -> void:
	Global.player = self
	SignalBus.PLAYER_use_item.connect(_on_use_item)

func get_inventory() -> void:
	inventory = []

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

func _on_use_item(item: Item) -> void:
	var target_stat = item.data.target_stat
	var value_change = item.data.value_change
	var old_value = get(target_stat)
	var new_value = old_value + value_change
	update_stat(target_stat, new_value)
