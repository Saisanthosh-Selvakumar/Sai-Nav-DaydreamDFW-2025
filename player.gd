extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -700.0

func apply_jet_force(force: Vector2) -> void:
	print("Jet force applied")
	velocity += force
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
func reset_to_start() -> void:
	global_position = Vector2(514, 343)


	#velocity = Vector2.ZERO  # Optional: clear any motion
