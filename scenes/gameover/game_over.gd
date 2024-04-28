extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_restart_button_pressed():
	$Button.play()
	await $Button.finished
	Fade.fade("res://scenes/main.tscn")

func _on_menu_button_pressed():
	$Button.play()
	await $Button.finished
	Fade.fade("res://scenes/menu/menu.tscn")
