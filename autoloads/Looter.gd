extends Node

func generate_loot(loot_table: Dictionary) -> Enums.Items:
	var total := 0
	for loot_chance in loot_table.values():
		total += loot_chance
	var roll = randi_range(1,total)
	for item_id in loot_table:
		roll -= loot_table[item_id]
		if roll < 0:
			return item_id
	return Enums.Items.NONE

func generate_event(event_table: Dictionary) -> Enums.Events:
	var total := 0
	for event_chance in event_table.values():
		total += event_chance
	var roll = randi_range(1,total)
	for event_id in event_table:
		roll -= event_table[event_id]
		if roll < 0:
			return event_id
	return Enums.EventType.NONE
