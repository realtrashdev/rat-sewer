class_name PlayerTweenComponent extends PlayerComponent

@export var tween_dict: Dictionary[Player.State, TweenSettings]
@export var scale_target: Node2D
@export var position_target: Node2D

var tween: Tween


func setup() -> void:
	player.state_changed.connect(_on_state_changed)

func _on_state_changed(new_state: Player.State):
	if tween_dict.has(new_state):
		var settings = tween_dict[new_state]
		if settings is ScaleTweenSettings:
			_tween_scale(settings)
		if settings is PositionTweenSettings:
			_tween_position(settings)

func _tween_scale(settings: ScaleTweenSettings):
	if tween:
		tween.kill()
	
	scale_target.scale = settings.initial_scale
	
	tween = create_tween().set_parallel(true)
	tween.tween_property(scale_target, "scale", settings.final_scale, settings.duration
		).set_ease(settings.easing).set_trans(settings.trans)

func _tween_position(settings: PositionTweenSettings):
	if tween:
		tween.kill()
	
	position_target.position = settings.initial_position
	
	tween = create_tween().set_parallel(true)
	tween.tween_property(position_target, "position", settings.final_position, settings.duration
		).set_ease(settings.easing).set_trans(settings.trans)
