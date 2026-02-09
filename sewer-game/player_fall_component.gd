## Handles player physics while jumping/falling
class_name PlayerFallComponent extends PlayerComponent

@export_category("Fall Timing")
# Time before switching to long fall animation
@export var long_fall_timer: float = 0.33
var _long_fall_timer: float = 0.0

var stored_speed: float = 0.0


func setup() -> void:
	player.state_changed.connect(_on_state_changed)

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	_check_wall_bounce()
	_state_change_checks()

func _on_state_changed(new_state: Player.State) -> void:
	if player.is_falling():
		_long_fall_timer = long_fall_timer
	else:
		_long_fall_timer = 0

func _check_wall_bounce():
	if player.is_on_wall() and player.is_airborne():
		stored_speed = -stored_speed
		player.velocity.x = stored_speed
		if player.get_current_state() == Player.State.JUMPING:
			player.change_state(Player.State.FALL)
	else:
		stored_speed = player.velocity.x

func _state_change_checks():
	if player.velocity.y < 0:
		return
	if player.is_on_floor() and player.current_state == Player.State.LONG_FALL:
		player.change_state(Player.State.HARD_LAND)
	elif player.is_on_floor():
		player.change_state(Player.State.LAND)
