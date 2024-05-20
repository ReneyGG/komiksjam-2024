extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_restart_button_pressed():
	$"../../../Button".play()
	Fade.fade("res://scenes/Levels/main"+str($"../../..".dream)+".tscn")

func _on_menu_button_pressed():
	$"../../../Button".play()
	Fade.fade("res://scenes/menu/menu.tscn")
