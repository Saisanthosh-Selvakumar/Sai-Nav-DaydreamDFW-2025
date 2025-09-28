extends Node2D

@onready var area: Area2D = $spike_area

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		
		body.reset_to_start()
