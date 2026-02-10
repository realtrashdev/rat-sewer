extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		restart_game()

func restart_game():
	var game_scene = load("res://scenes/game.tscn")
	var new_game = game_scene.instantiate()
	
	var parent = get_parent()
	parent.add_child(new_game)
	queue_free()
