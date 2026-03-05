extends CharacterBody2D


const SPEED = 135.0
var direction: Vector2
var has_key = false
var has_totem = false
@onready var footstep_player: AudioStreamPlayer = $footsteps
var footstep_sounds = [
	preload("res://Assets/step1.ogg"),
	preload("res://Assets/step2.ogg"),
	preload("res://Assets/step3.ogg"),
]

var footstep_timer = 0.0
var footstep_interval = 0.35

		
func _physics_process(delta: float) -> void:
	
	if DialogueBox.panel.visible:
		direction = Vector2.ZERO
		velocity = direction * SPEED
		move_and_slide() 
		return
	
	direction = Input.get_vector("left","right","up","down")
		
	if direction:
		velocity = direction * SPEED
		footstep_timer -= delta
		if footstep_timer <=0:
			footstep_timer = footstep_interval
			footstep_player.stream = footstep_sounds[randi() % footstep_sounds.size()]
			footstep_player.play()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		footstep_timer = 0.0

	
	animation()
	move_and_slide()
	
func animation():
	if direction: 
		$AnimatedSprite2D.flip_h = direction.x < 0
		if direction.x != 0:
			$AnimatedSprite2D.animation = "right"
		else:
			$AnimatedSprite2D.animation = "up" if direction.y < 0 else "down"
	else:
		$AnimatedSprite2D.frame = 0 
	
	
func _on_area_2d_body_entered(body: Node2D):
	if body.name == "Player":
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/lvl2.tscn")

		
	
	


	
