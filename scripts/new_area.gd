extends Area2D

@export var newLimitBottom: int
@export var newBoundBottom: int
@export var newLimitTop: int
@export var newLimitLeft: int
@export var camX: float
@export var camY: float
@export var speed: int
@onready var kill_space: Area2D = %killSpace

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):	
		var cam = body.get_node("Camera2D")
		cam.limit_bottom = newLimitBottom
		cam.limit_top = newLimitTop
		cam.limit_left = newLimitLeft
		body.SPEED=speed
		var tween = create_tween()
		tween.tween_property(cam, "zoom", Vector2(camX, camY), 0.6)
		kill_space.position.y = newBoundBottom
