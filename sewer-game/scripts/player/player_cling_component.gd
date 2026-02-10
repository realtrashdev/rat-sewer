class_name PlayerClingComponent extends PlayerComponent

const WALL_JUMP_SPEED: float = 70.0
const JUMP_FORCE: float = 200.0

const CLINGABLE_STATES: Array[Player.State] = [Player.State.JUMPING]

@export var cling_window: float = 0.1
var _try_cling_timer: float = 0.0

func setup() -> void:
	player.state_changed.connect(_on_state_updated)

func update(delta: float) -> void:
	_check_try_cling()
	_check_cling()
	_check_wall_jump()
	
	## On slope
	if player.is_on_wall() and player.get_wall_normal().y != 0:
		player.change_state(Player.State.FALL)
	
	if _try_cling_timer > 0.0:
		_try_cling_timer -= delta
		if _try_cling_timer <= 0.0:
			player.change_state(Player.State.FALL)

func _check_try_cling() -> void:
	if Input.is_action_just_pressed("cling") and player.get_current_state() in CLINGABLE_STATES and player.velocity.x != 0:
		player.change_state(Player.State.TRY_CLING)
		_try_cling_timer = cling_window

func _check_cling() -> void:
	if player.is_on_wall() and player.get_current_state() == Player.State.TRY_CLING:
		player.change_state(Player.State.CLING)
		player.velocity = Vector2.ZERO
	elif not player.is_on_wall() and player.get_current_state() == Player.State.CLING:
		player.change_state(Player.State.FALL)

func _check_wall_jump() -> void:
	if player.get_current_state() == Player.State.CLING and Input.is_action_just_pressed("jump"):
		if player.sprite.flip_h:
			player.velocity.x += WALL_JUMP_SPEED
		else:
			player.velocity.x += -WALL_JUMP_SPEED
		player.velocity.y -= JUMP_FORCE
		player.sprite.flip_h = !player.sprite.flip_h
		player.change_state(Player.State.JUMPING)

func _on_state_updated(new_state: Player.State) -> void:
	if not player.get_current_state() == Player.State.TRY_CLING:
		_try_cling_timer = 0.0
