extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0
const FALL_TIMEOUT = 0.5  # seconds before game over

var fall_timer: float = 0.0
var last_safe_y: float = 0.0
var coins := 0
const reqCoins = 10
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	Engine.time_scale = 0.8

	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		last_safe_y = global_position.y
		fall_timer = 0.0  # reset fall timer

	# Detect falling below last safe platform
	if global_position.y > last_safe_y:
		fall_timer += delta
		if fall_timer >= FALL_TIMEOUT:
			get_tree().change_scene_to_file("res://Scenes/lvl2.tscn")
			
	else:
		fall_timer = 0.0  # reset if player is not below

	# Handle horizontal movement
	var direction := Input.get_axis("ui_left", "ui_right",)
	
	
	if direction<0:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.animation = 'right'
	elif direction>0:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.animation = 'right'
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func addCoin():
	coins += 1
	
func game_over() -> void:
	if (coins >= reqCoins):
		print("You did it!")
		get_tree().change_scene_to_file("res://Scenes/win_menu.tscn")
	else:
		print("Not Enough Coins Collected!")
		
	# If you have a UI node for Game Over, show it here:
	# $GameOverUI.visible = true
