extends Area2D

# Path to the scene to load
@export var target_scene: PackedScene

func _ready():
	monitoring = true
	monitorable = true
	# Connect signals via code
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	# Check if the player entered
	if body.is_in_group("player"):
		if target_scene:
			get_tree().change_scene_to_packed(target_scene)
