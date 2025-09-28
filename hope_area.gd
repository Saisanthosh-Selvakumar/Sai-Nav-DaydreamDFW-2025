extends Area2D

@export var area_name = "hope"  # Change to "identity" or "joy" in each area

func _on_body_entered(body):
		if body.name == "Player":
			if body.selection == "none" or body.selection == "hope":
				body.selection = "hope"
