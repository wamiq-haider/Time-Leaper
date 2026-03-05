extends CanvasLayer
@onready var text_label: RichTextLabel = $Control/PanelContainer/HBoxContainer/RichTextLabel
@onready var panel: PanelContainer = $Control/PanelContainer
@onready var portrait: TextureRect = $Control/PanelContainer/HBoxContainer/TextureRect
var full_text: String = ""
var is_typing: bool = false
var is_active: bool = false

func _ready():
	panel.hide()
	text_label.add_theme_font_size_override("normal_font_size", 60)

func show_dialogue(text: String, incoming_portrait = null):
	if is_active:
		return
	if incoming_portrait != null:
		portrait.texture = incoming_portrait
		portrait.show()
	else:
		portrait.hide()
	full_text = text
	text_label.text = full_text
	text_label.visible_characters = 0
	panel.show()
	is_typing = true
	is_active = true
	await get_tree().process_frame
	_run_typewriter()

func _run_typewriter():
	var total_chars = text_label.get_total_character_count()
	var chars_shown = 0
	while chars_shown < total_chars:
		if not is_typing:
			break
		chars_shown += 1
		text_label.visible_characters = chars_shown
		await get_tree().create_timer(0.005).timeout
	is_typing = false
	await get_tree().create_timer(5.0).timeout
	if is_active:
		hide_dialogue()

func skip_to_end():
	is_typing = false
	text_label.visible_ratio = 1.0

func hide_dialogue():
	is_active = false
	panel.hide()
	is_typing = false

func _unhandled_input(event):
	if panel.visible and event.is_action_pressed("ui_accept"):
		if is_typing:
			skip_to_end()
		else:
			hide_dialogue()
