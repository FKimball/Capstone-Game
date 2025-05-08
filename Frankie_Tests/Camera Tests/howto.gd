extends Control

func _ready():
	# Connect buttons by their node names
	$Button.pressed.connect(_on_back_pressed)
	
func _on_back_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")  # replace with your game scene path
