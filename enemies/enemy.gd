class_name Enemy extends Node

var id: Enums.Enemies
var data: EnemyData
var data_ref:= {
    Enums.Enemies.RAT: "res://enemies/data/rat.tres",
    Enums.Enemies.WOLF: "res://enemies/data/wolf.tres",
    Enums.Enemies.BANDIT: "res://enemies/data/bandit.tres",
}

func _init(_id: Enums.Enemies) -> void:
    id = _id
    data = load(data_ref[id])
