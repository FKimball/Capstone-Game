extends Node3D

@export var dialogue : Dialogue
@onready var item = get_node("../Gem")
var item_collected = false

func _ready():
	$DialogueBox.hide()  
	item.item_collected.connect(_on_item_collected)
	
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

func _on_area_3d_body_exited(body: Node3D) -> void:
	$DialogueBox.hide()
	current_line = 0
	
func _on_item_collected():
	item_collected = true
	dialogue.normals_dialgoue = dialogue.quest_complete_dialogue
	$DialogueBox/Label.text = dialogue.quest_complete_dialogue[0] 
