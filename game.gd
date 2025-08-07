extends Node

var player: Node

func _ready() -> void:
    Global.game = self

    player = load("res://player/player.gd").new()
    player.start_game()

    %playerInfo.player = player