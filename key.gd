extends Node2D
 
var player_in_range = false
var has_been_read = false
var portrait_texture = preload("res://Assets/mainCharacter.png")
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if player_in_range and not DialogueBox.panel.visible:
		if not has_been_read:
			has_been_read = true
			DialogueBox.show_dialogue("I found it! Time to leave this place.",portrait_texture)
		else:
			pass
	if player_in_range and Input.is_action_just_pressed("interact"):
		pick_up_key()


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		player_in_range = true
	

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		player_in_range = false

func pick_up_key():
	get_parent().get_node("Player").has_key = true
	$AudioStreamPlayer.play()
	$Key01.queue_free()
	
