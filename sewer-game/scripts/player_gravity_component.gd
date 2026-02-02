class_name PlayerGravityComponent extends PlayerComponent

@export var low_gravity_multiplier: float = 0.7
@export var high_gravity_multiplier: float = 2.5
@export var max_downward_velocity: float = 300.0


func setup() -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	if player.is_airborne() and player.velocity.y < max_downward_velocity:
		player.velocity += get_gravity() * delta
	elif player.velocity.y >= max_downward_velocity:
		player.change_state(Player.State.LONG_FALL)

func get_gravity():
	if player.velocity.y > 0:
		return player.get_gravity()
	elif Input.is_action_pressed("jump") and player.current_state == Player.State.JUMPING:
		return player.get_gravity() * low_gravity_multiplier
	elif player.current_state == Player.State.JUMPING:
		return player.get_gravity() * high_gravity_multiplier
	else:
		return player.get_gravity()
