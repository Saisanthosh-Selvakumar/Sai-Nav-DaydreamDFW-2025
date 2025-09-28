extends Node2D
class_name JumpBoostPad

@export var jump_boost_multiplier: float = 1.5  # How much to boost jump
@export var boost_duration: float = 5.0         # Duration in seconds
@export var cooldown_time: float = 10.0         # Cooldown before reuse
@export var visual_color_available: Color = Color.GREEN
@export var visual_color_used: Color = Color.RED

@onready var area = $Area2D
@onready var timer = $Timer
@onready var visual = $Area2D/Sprite2D  # Adjust path as needed

var is_available: bool = true
var boosted_character = null

signal boost_activated(character, pad)
signal boost_expired(character, pad)

func _ready():
	# Connect signals
	area.body_entered.connect(_on_body_entered)
	timer.timeout.connect(_on_boost_expired)
	timer.wait_time = boost_duration
	
	# Setup visual
	_update_visual()
	_create_idle_animation()

func _on_body_entered(body):
	# Check if it's the player and boost is available
	if _is_player(body) and is_available:
		_activate_boost(body)

func _is_player(body) -> bool:
	# Customize this check for your player detection method
	return body.name == "Player" or body.is_in_group("player")

func _activate_boost(character):
	if not is_available:
		return
		
	is_available = false
	boosted_character = character
	
	# Apply boost to character
	if character.has_method("apply_jump_boost"):
		character.apply_jump_boost(jump_boost_multiplier, boost_duration)
	
	# Start timer
	timer.start()
	
	# Visual feedback
	_update_visual()
	_play_activation_effect()
	
	# Emit signal
	boost_activated.emit(character, self)
	print("Jump boost activated by pad: ", name)

func _on_boost_expired():
	# Remove boost from character
	if boosted_character and boosted_character.has_method("remove_jump_boost"):
		boosted_character.remove_jump_boost()
	
	boost_expired.emit(boosted_character, self)
	boosted_character = null
	
	# Start cooldown
	await get_tree().create_timer(cooldown_time).timeout
	
	# Reset availability
	is_available = true
	_update_visual()
	_create_idle_animation()
	print("Jump boost pad ready: ", name)

func _update_visual():
	if not visual:
		return
		
	if is_available:
		visual.modulate = visual_color_available
		visual.scale = Vector2.ONE
	else:
		visual.modulate = visual_color_used
		visual.scale = Vector2(0.8, 0.8)

func _create_idle_animation():
	if not is_available or not visual:
		return
		
	# Floating animation when available
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(visual, "position", visual.position + Vector2(0, -5), 1.0)
	tween.tween_property(visual, "position", visual.position, 1.0)

func _play_activation_effect():
	# Scale pulse when activated
	var effect_tween = create_tween()
	effect_tween.tween_property(visual, "scale", Vector2(1.3, 1.3), 0.1)
	effect_tween.tween_property(visual, "scale", Vector2(0.8, 0.8), 0.2)

# Public methods for external control
func set_boost_parameters(multiplier: float, duration: float, cooldown: float):
	jump_boost_multiplier = multiplier
	boost_duration = duration
	cooldown_time = cooldown
	timer.wait_time = duration

func force_activate():
	if is_available:
		var player = get_tree().get_first_node_in_group("player")
		if player:
			_activate_boost(player)

func reset_pad():
	is_available = true
	if boosted_character and boosted_character.has_method("remove_jump_boost"):
		boosted_character.remove_jump_boost()
	boosted_character = null
	timer.stop()
	_update_visual()
	_create_idle_animation()
