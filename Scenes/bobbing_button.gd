extends Control

var base_y: float

func _ready():
	base_y = position.y

func _process(delta: float) -> void:
	position.y = base_y + sin(Time.get_ticks_msec() * 0.005) * 3.0
