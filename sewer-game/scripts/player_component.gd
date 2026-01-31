class_name PlayerComponent extends Node

@export var active_states: Array[Player.State]

var player: Player


func _ready() -> void:
	await get_parent().ready
	player = get_parent()
	
	if not player is Player:
		push_warning("PlayerComponent parent must be of class Player. Deleting %s" % name)
		queue_free()
	
	setup()

func _process(delta: float) -> void:
	if player.get_current_state() in active_states or active_states.size() == 0:
		update(delta)

func _physics_process(delta: float) -> void:
	if player.get_current_state() in active_states or active_states.size() == 0:
		physics_update(delta)

## Override in subclasses
func setup() -> void:
	pass

## Override in subclasses
func update(delta: float) -> void:
	pass

## Override in subclasses
func physics_update(delta: float) -> void:
	pass
