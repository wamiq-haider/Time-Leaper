extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var healAmt = 5
@export var bobHeight = 3.0
@export var bobSpd = 2.0

var base_y := 0.0
var pickedUp := false
var time := 0.0

func _ready():
	base_y = position.y
	
func _process(delta):
	if pickedUp:
		return
	time += delta * bobSpd
	position.y = base_y + sin(time) * bobHeight

func _on_body_entered(body: CharacterBody2D) -> void:
	if pickedUp:
		return
		
	if body.has_method("heal"):
		pickedUp = true
		collision_shape_2d.disabled = true
		body.heal(healAmt)
		var tween = create_tween()
		tween.tween_property(self, "position:y", position.y - 30, 0.3)
		tween.tween_property(self, "modulate:a", 0.0, 0.2)
		await tween.finished
		queue_free()
	
