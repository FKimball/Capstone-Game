extends Area3D

@export var item_name: String = "Gem"

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":  # Adjust name/tag as needed
		print("Picked up:", item_name)
		queue_free()  # Removes the item from the scene
