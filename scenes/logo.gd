extends Control


func _on_video_stream_player_finished():
	Fade.fade("res://scenes/opening/opening.tscn")

func _input(event):
	if Input.is_action_just_pressed("left_mouse"):
		Fade.fade("res://scenes/opening/opening.tscn")
