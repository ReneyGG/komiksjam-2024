extends Control

var b_flag = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _on_texture_button_pressed():
	if not b_flag:
		$Button.play()
		b_flag = true
		Fade.fade("res://scenes/menu/menu.tscn")
