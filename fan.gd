extends Node2D

@export var jet_strength := 800.0  # Adjust this to make jet stronger or weaker

var players_in_area: Array = []

func _ready() -> void:
	var area = $Area2D
	#area.body_entered.connect(_on_body_entered)
	#area.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		players_in_area.append(body)
		print("Player entered jet stream area")

func _on_body_exited(body: Node) -> void:
	if body.name == "":
		players_in_area.erase(body)
		print("Player exited jet stream area")

func _physics_process(delta: float) -> void:
	for player in players_in_area:
		if player.has_method("apply_jet_force"):
			# Apply upward force scaled by delta time
			player.apply_jet_force(Vector2(0, -jet_strength) * delta)
