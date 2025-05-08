extends Control

@onready var start_button = $MarginContainer/VBoxContainer/PlayButton
@onready var how_to_play_button = $MarginContainer/VBoxContainer/HowToPlayButton
@onready var quit_button = $MarginContainer/VBoxContainer/QuitButton

func _ready(): 
	start_button.pressed.connect(_on_start_pressed)
	how_to_play_button.pressed.connect(_on_how_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

func _on_start_pressed():
	Audiobutton.play()
	get_tree().change_scene_to_file("res://Lab4.tscn")  # Make sure this path is correct
func _on_start_game_pressed():
	Audiobutton.play()
	get_tree().change_scene_to_file("res://Lab4.tscn")  # replace with your game scene path
func _on_how_pressed():
	Audiobutton.play()
	get_tree().change_scene_to_file("res://how_to_play.tscn")  # Replace with your real scene path
func _on_quit_pressed():
	Audiobutton.play()
	get_tree().quit()
	
