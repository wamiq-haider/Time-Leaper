extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var ray_cast_2dl: RayCast2D = $RayCast2DL
@onready var ray_cast_2dr: RayCast2D = $RayCast2DR
@onready var timer: Timer = $Timer
@onready var player: CharacterBody2D = %Player
@onready var area_2d: Area2D = $Area2D
@onready var timer_2: Timer = $Timer2


@export var speed : float

var direction = -1
var idle = 0
var dead = 0

func _process(delta: float) -> void:
	if idle or dead:
		return
	if speed > 60:
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("walk")
	if ray_cast_2dr.is_colliding():
		var collider = ray_cast_2dr.get_collider()
		if not collider is CharacterBody2D:
			onCollision(-1)
	if ray_cast_2dl.is_colliding():
		var collider = ray_cast_2dl.get_collider()
		if not collider is CharacterBody2D:
			onCollision(1)
	position.x += direction * speed * delta
	

func onCollision(dir):
	if not dead:
		idle = 1
		animated_sprite_2d.play("default")
		direction = dir
		if dir>0:
			animated_sprite_2d.flip_h=true
		elif dir<0:
			animated_sprite_2d.flip_h=false
		timer.start()
	
	

func _on_timer_timeout() -> void:
	idle = 0 # Replace with function body.


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		if body.is_dashing or body.is_plunging:
			body.immune()
			body.heal(2)
			dead = 1
			collision_shape_2d.disabled=true
			animated_sprite_2d.play("die")
			timer_2.start()
		else:
			body.take_damage(3)


func _on_timer_2_timeout() -> void:
	queue_free()
