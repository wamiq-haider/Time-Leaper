extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var bobHeight = 4.0
@export var bobSpd = 3.0

@onready var label_c: Label = %Label_C

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
	label_c.visible = true
	if body.is_in_group("player"):
		if pickedUp:
			return
			
		pickedUp = true
		var tween = create_tween()
		tween.tween_property(self, "position:y", position.y - 30, 0.3)
		tween.tween_property(self, "modulate:a", 0.0, 0.2)
		await tween.finished
		queue_free()
		body.can_dj = true
