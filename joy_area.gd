extends Area2D

signal player_near(area_name)

@export var area_name = "joy" 



func _on_body_entered(body):
		
		if body.name == "Player":
			if body.selection == "none" or body.selection == "joy":
		#Configure hope logic
		#Put x into position past three icons.
				body.jump_delay = 0.2
				body.selection = "joy"
		
		
		


		
