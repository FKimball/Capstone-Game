extends Control

func _ready():
	# Connect buttons by their node names
	$MarginContainer/VBoxContainer/Button.pressed.connect(_on_start_game_pressed)
	$MarginContainer/VBoxContainer/Button3.pressed.connect(_on_how_to_play_pressed)
	$MarginContainer/VBoxContainer/Button2.pressed.connect(_on_quit_pressed)

func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://Lab4.tscn")  # replace with your game scene path

func _on_how_to_play_pressed():
	get_tree().change_scene_to_file("res://howto.tscn")  # replace with your tutorial scene path

func _on_quit_pressed():
	get_tree().quit()
