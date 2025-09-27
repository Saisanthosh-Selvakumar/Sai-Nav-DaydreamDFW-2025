extends Area2D

signal key_collected

func _on_body_entered(body):
	if body.name == "Player":
		emit_signal("key_collected")
		queue_free()  # Remove the key from the scene
