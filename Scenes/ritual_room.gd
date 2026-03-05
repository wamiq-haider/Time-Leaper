extends Node2D
var player_in_range = false
var has_been_read = false
var portrait_texture = preload("res://Assets/mainCharacter.png")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_range and not DialogueBox.panel.visible:
		if not has_been_read:
			has_been_read = true
			DialogueBox.show_dialogue("This…what is this place? The stench from those pits!! It’s like a rotten egg lit on fire. Seems like this was a ritual room of sorts, the setup matches ones I’ve heard of in other demon enclaves. I might learn something about Yarvan here.",portrait_texture)
		else:
			pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = true
