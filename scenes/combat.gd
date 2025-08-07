extends MarginContainer
var nav_title = "<combat>"
var nav_labels = {}
var store_scene:=false

var player: Node

var active_enemies = []
var enemy_list = [
	Enums.Enemies.RAT,
	Enums.Enemies.WOLF,
	Enums.Enemies.BANDIT,
]

var id:= Enums.Scenes.COMBAT

var combat_scenes = {
	Enums.Scenes.COMBAT_REWARDS: "res://scenes/combat/rewards.tscn"
}

func _ready() -> void: 
	player = Global.game.player
	nav_labels = {
		%combatFight: "<fight>",
		%combatRetreat: "<retreat>",
	}
	%combatFight.mouse_entered.connect(_on_hover.bind(true, %combatFight))
	%combatFight.mouse_exited.connect(_on_hover.bind(false, %combatFight))
	%combatFight.gui_input.connect(_on_fight)
	%combatRetreat.mouse_entered.connect(_on_hover.bind(true, %combatRetreat))
	%combatRetreat.mouse_exited.connect(_on_hover.bind(false, %combatRetreat))
	%combatRetreat.gui_input.connect(_on_retreat)

func _on_fight(input: InputEvent) -> void:
	if input.is_action_pressed("select"):
		var enemy_id = enemy_list.pick_random()
		var enemy = Enemy.new(enemy_id)
		active_enemies.append(enemy)
		_victory()

func _on_hover(state: bool, label: RichTextLabel) -> void:
	if state == true:
		label.text = "[color=blue]%s[/color]" % label.text
	if state == false:
		label.text = nav_labels[label]

func _on_retreat(input: InputEvent) -> void:
	if input.is_action_pressed("select"):
		SignalBus.SCENE_go_back.emit()

func _victory() -> void:
	var loot = []
	for enemy in active_enemies:
		for item_id in enemy.data.loot:
			var item = Item.new(item_id)
			loot.append(item)
			SignalBus.PLAYER_add_item.emit(item)
	var reward_scene = load(combat_scenes[Enums.Scenes.COMBAT_REWARDS]).instantiate()
	for child in %combatContent.get_children():
		child.queue_free()
	%combatContent.add_child(reward_scene)
	SignalBus.SCENE_clear_scene.emit(Enums.Scenes.COMBAT)