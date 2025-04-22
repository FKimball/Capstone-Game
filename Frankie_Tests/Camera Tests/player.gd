extends CharacterBody3D

@onready var world = $SpringArm3D/Camera3D/WorldEnvironment
@onready var spring_arm = $SpringArm3D
@export var mouse_sensitivity = 0.0015
@export var rotation_speed = 12.0

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var saturation_level = 0.0
var max_saturation = 1.0

func _ready():
	world.environment.adjustment_saturation = saturation_level  # Initialize saturation level
	# Connect the quest_completed signal to the _on_quest_completed method
	var item = get_node("../Gem")  # Replace with the correct path to your item instance
	item.connect("quest_completed", Callable(self, "_on_quest_completed"))

func _physics_process(delta: float) -> void:
	# Add gravity to the character if it's not on the floor.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction based on player controls.
	var input_dir := Input.get_vector("left", "right", "down", "up")
	
	# Calculate the forward and right vectors from the camera's rotation.
	var camera_forward = -spring_arm.global_transform.basis.z.normalized()  # Forward in world space.
	var camera_right = spring_arm.global_transform.basis.x.normalized()    # Right in world space.
	
	# Explicitly type the direction as a Vector3.
	var direction : Vector3 = (camera_forward * input_dir.y + camera_right * input_dir.x).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# Apply movement using move_and_slide.
	move_and_slide()

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		# Rotate the spring arm and camera with mouse motion.
		spring_arm.rotation.x -= event.relative.y * mouse_sensitivity
		spring_arm.rotation_degrees.x = clamp(spring_arm.rotation_degrees.x, -90.0, 30.0)
		spring_arm.rotation.y -= event.relative.x * mouse_sensitivity

		# Rotate the character towards the camera's yaw direction (left/right rotation).
		# This ensures the character always faces the camera's direction of movement.
		var yaw = spring_arm.rotation.y
		rotation = Vector3(0, yaw, 0)
		
func _on_quest_completed():
	# Increase saturation, but cap it at the maximum value (1.0)
	saturation_level = clamp(saturation_level + 0.8, 0.0, max_saturation)
	world.environment.adjustment_saturation = saturation_level
