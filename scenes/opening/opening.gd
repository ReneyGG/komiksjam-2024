extends Control

func _on_video_stream_player_finished():
	Fade.fade("res://scenes/menu/menu.tscn")
