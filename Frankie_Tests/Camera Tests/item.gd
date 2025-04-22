extends Area3D

@export var item_name: String = "Gem"
signal item_collected
signal quest_completed

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player": 
		print("Picked up:", item_name)
		emit_signal("item_collected")
		emit_signal("quest_completed")
		queue_free()
