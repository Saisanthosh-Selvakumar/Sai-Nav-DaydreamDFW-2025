extends Area2D

signal player_near(area_name)
const KEY_TEXTURE = preload("res://")
#MENTION ANIMATED IMAGE HERE
@export var area_name = "identity"  # Change to "identity" or "joy" in each area

func _on_body_entered(body):
	if body.name == "Player":
		for sprite in get_tree().get_nodes_in_group("changeable_sprites"):
			if sprite is Sprite2D:
				sprite.texture = KEY_TEXTURE
