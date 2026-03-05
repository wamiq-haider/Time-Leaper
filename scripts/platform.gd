extends Node2D

@export var camera: Camera2D
@export var margin: float = 200.0  # buffer below camera before deletion

func _process(delta: float) -> void:
	if camera and global_position.y > camera.global_position.y + margin:
		queue_free()
