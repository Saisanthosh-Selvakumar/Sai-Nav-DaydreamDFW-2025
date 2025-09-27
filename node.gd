extends Node2D

var is_open = false
var player_has_key = false

func _ready():
	var key = get_node_or_null("/root/Level/Key")
	if key:
		key.connect("key_collected", Callable(self, "_on_key_collected"))

func _on_key_collected():
	player_has_key = true

func _on_body_entered(body):
	if body.name == "Player" and player_has_key:
		open_door()

func open_door():
	if not is_open:
		is_open = true
		print("Door opened!")
		# Optional: play an animation or disable the door
		queue_free()  # or hide(), or disable collision, etc.
