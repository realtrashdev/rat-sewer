extends Node2D

var won: bool = false

func game_win():
	$RevealedOnWin/TimeText.text = "Time: %d:%02d" % [floor($"../TimerCanvas".timer_time / 60), int($"../TimerCanvas".timer_time) % 60]
	$RevealedOnWin.visible = true
	$RevealedOnWin/WinLayer.enabled = true
	$"../TimerCanvas".visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and not won:
		game_win()
		won = true
