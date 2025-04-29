extends MeshInstance3D

var questdone = false

func _ready() -> void:
	$"../Coin".quest_completed.connect(_on_game_finished)

func _on_game_finished():
	questdone = true
	queue_free()
