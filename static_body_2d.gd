extends StaticBody2D

func _on_body_entered(body: StaticBody2D) -> void:
	if body.name == "Player":
		body.reset_to_start()
