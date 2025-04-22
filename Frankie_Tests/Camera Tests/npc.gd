extends Node3D

@export var quest_item: Item
@export var dialogue : Dialogue
var item_collected = false

func _ready():
	$DialogueBox.hide()  
	quest_item.item_collected.connect(_on_item_collected)
	
func  _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		dialogue.normals_dialgoue = dialogue.quest_complete_dialogue
		current_line = 0
	if Input.is_action_just_pressed("interact") and $DialogueBox.visible:
		current_line += 1
		if current_line < dialogue.normals_dialgoue.size():
			$DialogueBox/Label.text = dialogue.normals_dialgoue[current_line]
	
var current_line = 0

func _on_area_3d_body_entered(body):
	if body.name == "Player": 
		$DialogueBox.show()
		$DialogueBox/Label.text = dialogue.normals_dialgoue[current_line]
		if item_collected:
			body._on_quest_completed()
			item_collected = false
		
func _on_area_3d_body_exited(body: Node3D) -> void:
	$DialogueBox.hide()
	current_line = 0
	
func _on_item_collected():
	item_collected = true
	dialogue.normals_dialgoue = dialogue.quest_complete_dialogue
	$DialogueBox/Label.text = dialogue.quest_complete_dialogue[0] 
