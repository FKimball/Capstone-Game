extends MeshInstance3D

func _ready():
	$Panel.visible=false
	
func _on_area_3d_body_entered(body) :
	if body.name == "Player":
		print("Player touched the area!")  # Debug message
		$Panel.visible = true
		$"../../Player/backgroundmusic".stop()
		Victorymusic.play()
		
