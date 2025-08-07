extends VBoxContainer

var weapon: Weapon
var player: Node:
	set(value):
		player = value
		reload()

func reload() -> void:
	weapon = Global.player.weapon

	
	%weaponName.text = weapon.data.wpn_name.capitalize()
	%weaponType.text = "(%s)" % weapon.get_type_string()
	%weaponAtk.text = str(roundi(weapon.data.atk))
	%weaponDef.text = str(roundi(weapon.data.def))


