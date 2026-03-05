extends StaticBody2D

var player_in_range = false
var player_ref = null
var has_been_read = false
var portrait_texture = preload("res://Assets/mainCharacter.png")
func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:  # or use groups
		player_in_range = true
		player_ref = body
		if player_in_range and player_ref.has_key == false:
			$AnimatedSprite2D.play("closed")
			

func _on_area_2d_body_exited(body):
	if body == player_ref:
		player_in_range = false
		print(player_in_range)
		player_ref = null

func _process(delta):
	if player_in_range and not DialogueBox.panel.visible:
		if not has_been_read:
			has_been_read = true
			DialogueBox.show_dialogue("GAH, the door’s locked. Seems like I need to find a key.",portrait_texture)
		else:
			pass
	if player_in_range and Input.is_action_just_pressed("interact"):
		if player_ref.has_key:
			open_door()

func open_door():
	$AnimatedSprite2D.play("open")
	$AudioStreamPlayer.play()
	$CollisionShape2D.disabled = true
