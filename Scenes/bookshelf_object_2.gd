extends StaticBody2D
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
			DialogueBox.show_dialogue("	Wait, this mentions something.“ 𐎧𐎤𐎫𐎫𐎮 𐏂 h𐎫𐎫e 𐎽 𐎨 who ri𐎼𐎠𐏀de𐏀𐎠𐏂s𐎼𐎠𐏀 𐏂 t𐎼𐎠𐏀im𐎤𐎫𐎠𐏂𐎫e” He who rides time..and next to it is a picture of a totem?",portrait_texture)
		else:
			pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = true
