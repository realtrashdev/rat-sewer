class_name PlayerSpriteComponent extends PlayerComponent

@export var anim_keys: Dictionary[Player.State, String]

var sprite: AnimatedSprite2D


func setup() -> void:
	player.state_changed.connect(_on_state_changed)
	sprite = player.sprite

func update(delta: float) -> void:
	_directional_flipping()

func physics_update(delta: float) -> void:
	pass

func _directional_flipping() -> void:
	if player.is_airborne():
		return
	
	# Reversed for correct flipping
	var direction = Input.get_axis("move_right", "move_left")
	if direction:
		sprite.flip_h = clamp(direction, 0, 1)

func _on_state_changed(new_state: Player.State) -> void:
	if new_state in anim_keys:
		sprite.play(anim_keys[new_state])
