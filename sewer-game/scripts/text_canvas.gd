class_name TextCanvas extends CanvasLayer

@onready var parent: Control = $Parent
@onready var text_label: RichTextLabel = $Parent/RichTextLabel

func _ready() -> void:
	await get_parent().ready
	show_text("arrow keys - move")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("cling") and parent.visible:
		_hide_text()
	print(get_tree().paused)

func show_text(new_text: String):
	text_label.text = new_text
	parent.visible = true
	get_tree().paused = true

func _hide_text():
	text_label.text = "YOU SHOULDN'T BE SEEING THIS!!!"
	parent.visible = false
	get_tree().paused = false
