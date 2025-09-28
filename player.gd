extends CharacterBody2D

var SPEED = 300.0
var JUMP_VELOCITY = -300.0
@export var jump_delay = 0.0
var jumping = false
@export var selection = "none"
@onready var vignette = get_node("../Vignette/Vignette")

func _ready() -> void:
	vignette.visible = false
	vignette.modulate.a = 0.0

func apply_jet_force(force: Vector2) -> void:
	print("Jet force applied")
	velocity += force
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor(): 
		velocity += get_gravity() * delta
	
	if (selection == "none" && global_position[0] >= 1500):
		reset_to_start()
		
	
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and not jumping:
		jumping = true
		jump_with_delay()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func jump_with_delay() -> void:
	await get_tree().create_timer(jump_delay).timeout
	if is_on_floor():  # Still on ground after delay
		velocity.y = JUMP_VELOCITY
	jumping = false

func reset_to_start() -> void:
	global_position = Vector2(-5, -12)

@onready var _animated_sprite = $PlayerSprite
var walk_speed_scale : float = 1.5

func _process(_delta):
	if Input.is_action_pressed("right"):
		_animated_sprite.play("right")
		_animated_sprite.speed_scale = walk_speed_scale
	elif Input.is_action_pressed("left"):
		_animated_sprite.play("left")
		_animated_sprite.speed_scale = walk_speed_scale
	else:
		_animated_sprite.stop()

func _on_hope_area_body_entered(body: Node2D) -> void:
	if body == self:
		vignette.visible = true
		vignette.modulate.a = 0.0
		create_tween().tween_property(vignette, "modulate:a", 1.0, 0.4)
