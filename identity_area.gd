extends Area2D

signal player_near(area_name)

@export var area_name = "identity"  # Change to "identity" or "joy" in each area
@export var limit_left: int
@export var limit_right: int
@export var limit_top: int
@export var limit_bottom: int
func _on_body_entered(body):
		
		if body.name == "Player":
			
			if body.selection == "none" or body.selection == "identity":
				var camera = body.get_node("Camera2D")
				camera.limit_left = limit_left - 100
				camera.limit_right = limit_right - 100
				camera.limit_top = limit_top - 100
				camera.limit_bottom = limit_bottom - 100
				body.selection = "identity"
				print(body.selection)
