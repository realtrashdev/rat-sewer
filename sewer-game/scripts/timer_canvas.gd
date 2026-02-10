extends CanvasLayer

var timer_time: float = 0.0
var timer_started: bool = false
var timer_stopped: bool = false

func _process(delta: float) -> void:
	if timer_stopped: return
	
	if not timer_started:
		if Input.is_anything_pressed():
			timer_started = true
	else:
		timer_time += delta
	
	$RichTextLabel.text = "%d:%02d" % [floor(timer_time / 60), int(timer_time) % 60]

func stop_timer() -> float:
	timer_stopped = true
	return timer_time
