extends Area2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@onready var game_manager = %GameManager
# Called when the node enters the scene tree for the first time.
@onready var animation_player = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.addCoin()
		game_manager.add_point()
		animation_player.play("pickup")
