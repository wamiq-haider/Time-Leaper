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
			DialogueBox.show_dialogue("This must be a place of worship for them. Ironically, just like my family the demons believe in a system of hierarchy with Yarvan at the top. Humans however know not to ascend man to godhood, while the demon’s worship Yarvan.",portrait_texture)
		else:
			pass


func _on_worship_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = true
