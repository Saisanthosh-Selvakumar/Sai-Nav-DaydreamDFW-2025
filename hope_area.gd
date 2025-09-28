extends Area2D

#signal player_near(area_name)

#@export var limit_left: int
#@export var limit_right: int
#@export var limit_top: int
#@export var limit_bottom: int

@export var area_name = "hope"  # Change to "identity" or "joy" in each area


func _on_body_entered(body):
		
		if body.name == "Player":
			if body.selection == "none" or body.selection == "hope":
				#var camera = body.get_node("Camera2D")
				#camera.limit_left = limit_left
				#camera.limit_right = limit_right
				#camera.limit_top = limit_top
				#camera.limit_bottom = limit_bottom
				body.selection = "hope"
				
				
