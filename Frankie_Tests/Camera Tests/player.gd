extends CharacterBody3D

@onready var world = $SpringArm3D/Camera3D/WorldEnvironment
@onready var spring_arm = $SpringArm3D
@export var mouse_sensitivity = 0.0015
@export var rotation_speed = 12.0
@onready var anim_player = $Mage/AnimationPlayer
@onready var model = $Mage

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var saturation_level = 0.0
var max_saturation = 1.0

func _ready():
	world.environment.adjustment_saturation = saturation_level  

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim_player.play("Jump_Start")
		
	var input_dir := Input.get_vector("left", "right", "down", "up")
	var camera_forward = -spring_arm.global_transform.basis.z.normalized()
	var camera_right = spring_arm.global_transform.basis.x.normalized()
	var move_dir: Vector3 = (camera_forward * input_dir.y + camera_right * input_dir.x).normalized()

	if move_dir != Vector3.ZERO:
		# Move the character
		velocity.x = move_dir.x * SPEED
		velocity.z = move_dir.z * SPEED
		# Only rotate the model when input is pressed (WASD)
		var target_rotation = atan2(-move_dir.x, -move_dir.z)
		model.rotation.y = lerp_angle(model.rotation.y, target_rotation, delta * rotation_speed)
		if anim_player.current_animation != "Walking_A":
			anim_player.play("Walking_A")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		if anim_player.current_animation != "Idle":
			anim_player.play("Idle")
	move_and_slide()

	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		# Rotate the spring arm and camera with mouse motion.
		spring_arm.rotation.x -= event.relative.y * mouse_sensitivity
		spring_arm.rotation_degrees.x = clamp(spring_arm.rotation_degrees.x, -90.0, 30.0)  # Limit vertical camera rotation
		spring_arm.rotation.y -= event.relative.x * mouse_sensitivity  # Rotate around the y-axis (yaw)

	var yaw = spring_arm.rotation.y
		
func _on_quest_completed():
	# Increase saturation, but cap it at the maximum value (1.0)
	saturation_level = clamp(saturation_level + 0.28, 0.0, max_saturation)
	world.environment.adjustment_saturation = saturation_level
