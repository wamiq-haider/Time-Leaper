extends ProgressBar
@onready var dmg_bar: ProgressBar = $dmgBar
@onready var timer: Timer = $Timer

var health = 0 : set = _set_health
	
func _set_health(newHealth):
	var prevHealth = health
	health = min(max_value, newHealth)
	value = health
	if health < prevHealth:
		timer.start()
	else:
		dmg_bar.value=health


func init_health(_health):
	health = _health
	max_value = health
	value = health
	dmg_bar.max_value=health
	dmg_bar.value=health
	


func _on_timer_timeout() -> void:
	dmg_bar.value=health
