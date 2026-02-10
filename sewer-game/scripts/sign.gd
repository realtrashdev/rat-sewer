extends Node2D

@export var text_canvas: TextCanvas
@export_multiline var sign_text: String = "I am a sign."

var player: bool = false

func _ready() -> void:
	if not text_canvas:
		text_canvas = get_tree().current_scene.get_node("TextCanvas")
	if not text_canvas:
		push_error("Could not find text canvas")
		queue_free()

func _process(delta: float) -> void:
	if player and Input.is_action_just_pressed("move_up"):
		text_canvas.show_text(sign_text)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		player = true
		$UpArrow.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		player = false
		$UpArrow.visible = false
