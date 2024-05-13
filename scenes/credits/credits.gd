extends Control

var flag = false

func _on_back_button_pressed():
	if not flag:
		flag = true
		$Button.play()
		Fade.fade("res://scenes/menu/menu.tscn")
