extends CharacterBody3D

@export var speed:float = 3.0

const JUMP_VELOCITY = 4.5
@onready var camera_pivot: Node3D = $CameraPivot
var mouse_motion:= Vector2.ZERO

<<<<<<< HEAD
@export var aim_sensitivity: float = 0.005
@onready var ray_cast_3d: RayCast3D = $CameraPivot/RayCast3D
=======
@export var aim_sensitivity: float = 0.001
>>>>>>> d4f6045c2b03598cff0fcf6a634453e41c6bb798

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _physics_process(delta: float) -> void:
	handle_camera_rotation()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion :
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			# relative is the position "relative" to the previous mouse position. It's negative because we want our mouse to move in the direction we are moving it.
			mouse_motion = -event.relative *  aim_sensitivity
	if event.is_action_pressed("ui_cancel") and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		return
	if event.is_action_pressed("ui_cancel") and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		var collider = ray_cast_3d.get_collider()
		printt("collider: ", collider)
		if collider is Interactable:
			collider.interact()
	

func handle_camera_rotation()-> void:
	rotate_y(mouse_motion.x)
	camera_pivot.rotate_x(mouse_motion.y)
	camera_pivot.rotation_degrees.x = clamp(
		camera_pivot.rotation_degrees.x,-90.0,90.0
	
	)
	mouse_motion = Vector2.ZERO
