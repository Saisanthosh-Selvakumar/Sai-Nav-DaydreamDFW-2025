extends Area2D

signal player_near(area_name)
const KEY_TEXTURE = preload("res://staticAni.png")

#MENTION ANIMATED IMAGE HERE
@export var area_name = "identity"  # Change to "identity" or "joy" in each area

func _on_body_entered(body):
	if body.name == "Player":
		for node in get_tree().get_nodes_in_group("changeable_sprites"):
			if node is Sprite2D:
				node.texture = KEY_TEXTURE
			elif node is AnimatedSprite2D:
				var new_frames = SpriteFrames.new()
				new_frames.add_animation("default")
				new_frames.add_frame("default", KEY_TEXTURE)
				new_frames.set_animation_loop("default", false)
				node.frames = new_frames
				node.animation = "default"
				node.play()
