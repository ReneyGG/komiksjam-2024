extends Node


func frame_freeze(timeScale, duration):
	Engine.time_scale = timeScale
	$Freeze.start(duration * timeScale)

func _on_freeze_timeout():
	Engine.time_scale = 1.0
