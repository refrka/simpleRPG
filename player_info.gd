extends VBoxContainer

var player: Node:
	set(value):
		player = value
		connect_signals()
		reload()

var lvl: int
var hp_current: int
var hp_max: int
var mp_current: int
var mp_max: int
var xp: int
var color_timer: Timer

func connect_signals() -> void:
	SignalBus.PLAYER_stat_change.connect(reload_stat)

func reload() -> void:
	%playerInventory.player = player
	%playerEquipment.player = player
	var script = self.get_script()
	for property in script.get_script_property_list():
		if property.name != "player":
			var property_name = property.name
			var new_value = player.get(property_name)
			self.set(property_name, new_value)

	%playerLvl.text = str(lvl)
	%playerHP.text = str(roundi(hp_current))
	%playerHPmax.text = str(roundi(hp_max))
	%playerMP.text = str(roundi(mp_current))
	%playerMPmax.text = str(roundi(mp_max))
	%playerXP.text = "(%s xp)" % str(roundi(xp))



func reload_stat(stat_name: StringName) -> void:
	var stat_ref = {
		"lvl": %playerLvl,
		"hp_current": %playerHP,
		"hp_max": %playerHPmax,
		"mp_current": %playerMP,
		"mp_max": %playerMPmax,
		"xp": %playerXP
	}
	var stat = stat_ref[stat_name]
	var new_value = player.get(stat_name)
	var new_text = str(new_value)
	if new_value < self.get(stat_name):
		new_text = "[color=red]%s[/color]" % new_text
	if new_value > self.get(stat_name):
		new_text = "[color=green]%s[/color]" % new_text
	if color_timer != null:
		print("fuckl")
		color_timer.timeout.disconnect(reset_color)
	color_timer = Timer.new()
	color_timer.one_shot = true
	color_timer.timeout.connect(reset_color.bind(stat, new_value))
	add_child(color_timer)
	color_timer.start(1.5)
	stat.text = new_text
	self.set(stat_name, new_value)

func reset_color(label: RichTextLabel, value: Variant) -> void:
	label.text = str(value)

