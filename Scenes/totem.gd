extends Node2D

var player_in_range = false
var has_been_read = false
var portrait_texture = preload("res://Assets/mainCharacter.png")


	
func _process(delta: float):
	if player_in_range  and not DialogueBox.panel.visible:
		if not has_been_read:
			has_been_read = true
			DialogueBox.show_dialogue("Is this? My god it is, the totem from the book. Why’s it just out here? I can see the exit right in front of me and it just so happens to be here? I know you’re planning something demon, but if you think this will stop me you’ve got another thing coming!",portrait_texture)
		
		if  Input.is_action_just_pressed("interact"):
			pick_up_totem()

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		player_in_range = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		player_in_range = false

func pick_up_totem():
	player_in_range = false
	get_parent().get_node("Player").has_totem = true
	$TotemTravel.queue_free()
