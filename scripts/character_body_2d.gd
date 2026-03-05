extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hp_bar: ProgressBar = $hpBar
@onready var timer: Timer = $Timer
@onready var timer_2: Timer = $Timer2
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var spawn = global_position

var SPEED = 140.0
var JUMP_VELOCITY
var health
var dead
var can_take_damage
var takingDmg
var maxHealth = 10

var can_dash = false
var is_dashing = false
var dash_speed = 400.0
var dash_time = 0.28 
const dash_cooldown = 3

var can_dj = 0
var djAllow = 0

var can_plunge = 0
var is_plunging = 0
var plunge_speed = 450

const plunge_cooldown = 2
func _ready():
	dead = false
	collision_shape.disabled=false
	health = 10
	hp_bar.init_health(health)
	can_take_damage = false
	await get_tree().create_timer(0.3).timeout
	can_take_damage = true

func heal(amount):
	health += amount
	if health > maxHealth:
		health = maxHealth
	hp_bar.health = health 

func take_damage(amount):
	if not can_take_damage or is_dashing: 
		return
	health -= amount 
	hp_bar.health = health
	takingDmg = true
	animated_sprite_2d.play("damaged")
	await get_tree().create_timer(0.1).timeout
	takingDmg = false
	if health <= 0:
		dead = true
		Engine.time_scale = 2
		velocity.y = -100
		collision_shape.disabled = true
		collision_layer = 0
		collision_mask = 0
		timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale=1
	get_tree().reload_current_scene()

func immune():
	can_take_damage = false
	timer_2.start()
	
func _on_timer_2_timeout() -> void:
	can_take_damage = true
	
func _input (event):
	if event.is_action_pressed("dash") and can_dash and not is_dashing:
		start_dash()
	if event.is_action_pressed("plunge") and can_plunge and not is_dashing and not is_plunging and not is_on_floor():
		start_plunge()

func start_dash():
	can_dash = false
	is_dashing = true
	animated_sprite_2d.play("dash")
	velocity.y = 0
	var dash_dir = sign(velocity.x)
	if dash_dir == 0:
		dash_dir = 1
	velocity.x = dash_dir * dash_speed
	await get_tree().create_timer(dash_time).timeout
	is_dashing = false
	if Input.get_axis("mL", "mR") == 0:
		velocity.x = 0
	dashCooldown()

func start_plunge():
	can_plunge = false
	is_plunging = true
	animated_sprite_2d.play("plunge")
	velocity.x = 0
	velocity.y = plunge_speed

func dashCooldown():
	await get_tree().create_timer(dash_cooldown).timeout
	can_dash = true

func plungeCooldown():
	await get_tree().create_timer(plunge_cooldown).timeout
	can_plunge = true

func _physics_process(delta: float) -> void:
	if is_plunging:
		if is_on_floor():
			is_plunging = false
			plungeCooldown()
		else:
			velocity.x = 0
	# Gravity (applies even while dashing for a natural arc)
	if not is_on_floor() and not is_dashing and not is_plunging:
		if SPEED <= 95:
			velocity += get_gravity() * delta * 0.15
			JUMP_VELOCITY = -80
		elif SPEED == 129 and not can_dj:
			JUMP_VELOCITY = - 555
			velocity += get_gravity() * delta
		else:
			JUMP_VELOCITY = -320
			velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_dashing and not is_plunging:
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("jump") and not is_on_floor() and not is_dashing and not is_plunging and can_dj and djAllow:
		velocity.y = JUMP_VELOCITY
		djAllow = 0
	# Horizontal input
	var input_dir := Input.get_axis("mL", "mR")
	if not is_dashing and not is_plunging:
		if input_dir < 0:
			animated_sprite_2d.flip_h = true
		elif input_dir > 0:
			animated_sprite_2d.flip_h = false

	# Movement and animation
	if is_dashing or is_plunging:
		pass
	else:
		if input_dir != 0:
			velocity.x = input_dir * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	if not takingDmg and not is_dashing and not is_plunging:
		if is_on_floor():
			djAllow = 1
			if input_dir == 0:
				animated_sprite_2d.play("idle")
			else:
				animated_sprite_2d.play("run")
		else:
			animated_sprite_2d.play("jump")

	move_and_slide()
