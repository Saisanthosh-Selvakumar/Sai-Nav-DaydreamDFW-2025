extends Node2D

func _on_fan_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		# Apply an upward force (negative Y)
		body.velocity.y = -2000
	elif body.has_method("set_velocity"):
		# Optional: If it's a custom class with a set_velocity method
		body.set_velocity(Vector2(body.velocity.x, -2000))
	else:
		print("Unsupported body type: ", body)
