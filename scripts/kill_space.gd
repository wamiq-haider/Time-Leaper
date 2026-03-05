extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(10)
		Engine.time_scale=0.4
		body.velocity.y=-100
		body.get_node("CollisionShape2D").disabled = true
		timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale=1
	get_tree().reload_current_scene()
