class_name PlayerMovementComponent extends PlayerComponent

@export_category("Movement")
@export var move_speed: float = 70.0
@export var air_stop_speed: float = 10.0
@export var ground_stop_speed: float = 20.0

@export_category("Jumping")
@export var jump_force: float = 200.0


func physics_update(delta: float) -> void:
	_horizontal_movement()
	_jumping()
	
	# State checks
	if not player.is_on_floor() and player.is_grounded():
		player.change_state(Player.State.FALL)
	
	if player.current_state == Player.State.ACTIVE and player.velocity.x == 0:
		player.change_state(Player.State.IDLE)
	elif player.is_grounded() and player.velocity.x != 0:
		player.change_state(Player.State.ACTIVE)

func _horizontal_movement():
	# X axis movement
	var direction = Input.get_axis("move_left", "move_right")
	
	# Moving
	if player.velocity.x <= move_speed:
		player.velocity.x = move_speed * direction
	else:
		player.velocity.x = move_toward(player.velocity.x, move_speed * direction, ground_stop_speed)

func _jumping() -> void:
	if Input.is_action_just_pressed("jump"):
		player.velocity.y = -jump_force
		player.change_state(Player.State.JUMPING)
