extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var label_b: Label = %Label_B

@export var bobHeight = 4.0
@export var bobSpd = 3.0

var baseY := 0.0
var pickedUp := false
var time := 0.0

func _ready():
	baseY = position.y

func _process(delta):
	if pickedUp:
		return
	time += delta * bobSpd
	position.y = baseY + sin(time) * bobHeight


func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		label_b.visible = true
		if pickedUp:
			return
		
		pickedUp = true
		var tween = create_tween()
		tween.tween_property(self, "position:y", position.y - 30, 0.3)
		tween.tween_property(self, "modulate:a", 0.0, 0.2)
		await tween.finished
		queue_free()
		body.can_dash = true
	
