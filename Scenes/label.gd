extends Label

@onready var label: Label = $Label
var base_y: float

func _ready():
	base_y = label.position.y

func _process(delta: float) -> void:
	label.position.y = base_y + sin(Time.get_ticks_msec() * 0.005) * 5.0
