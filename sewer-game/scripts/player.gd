## Base class for the Player
##
## Handles state machine changes
class_name Player extends CharacterBody2D

enum State {
	IDLE, # Not moving and on ground
	ACTIVE, # Moving and on ground
	LAND, # Normal landing after a jump or fall etc.
	HARD_LAND, # To play animation where rat is faceplanted on ground
	
	JUMPING, # No X movement while in air, will not bounce off walls in this state
	FALL, # No X movement while in air, bounce off walls in this state
	LONG_FALL, # Hit wall while falling or falling for a long time, can't do anything but watch
	
	TRY_CLING, # Short window where hitting a wall while falling/jumping will let you briefly cling to it for wall jumps. Failing this will send the player to the FALL state
	CLING, # Clinging to wall for a short time
	
	CUTSCENE, # No control
}

signal state_changed(new_state: State)

const GROUNDED_STATES: Array[State] = [State.ACTIVE, State.IDLE, State.LAND, State.HARD_LAND]
const AIRBORNE_STATES: Array[State] = [State.JUMPING, State.FALL, State.LONG_FALL]
const FALLING_STATES: Array[State] = [State.FALL, State.LONG_FALL]

var components: Array[PlayerComponent]

@export var start_state: State = State.LONG_FALL
var current_state: State

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	_cache_components()
	await get_tree().process_frame
	change_state(start_state)

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()

func get_current_state() -> State:
	return current_state

func change_state(new_state: State) -> void:
	if new_state != current_state:
		print(State.keys()[new_state])
		current_state = new_state
		state_changed.emit(new_state)

func _cache_components() -> void:
	for child in get_children():
		if child is PlayerComponent:
			components.push_back(child)
	print("PlayerComponents Cached. Amount stored: %s" % components.size())

func get_component(type: StringName) -> PlayerComponent:
	for c in components.size():
		if components[c].is_class(type):
			return components[c]
	return null

func is_airborne() -> bool:
	return current_state in AIRBORNE_STATES

func is_grounded() -> bool:
	return current_state in GROUNDED_STATES

func is_falling() -> bool:
	return current_state in FALLING_STATES
