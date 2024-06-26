extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_restart_button_pressed():
	var stage = get_parent().get_parent().get_parent().level
	Diary.reset(stage)
	$"../../../Button".play()
	match $"../../..".level:
		1:
			Fade.fade("res://scenes/Levels/main13.tscn")
		2:
			Fade.fade("res://scenes/Levels/main12.tscn")
		3:
			Fade.fade("res://scenes/Levels/main11.tscn")

func _on_menu_button_pressed():
	Diary.reset()
	$"../../../Button".play()
	Fade.fade("res://scenes/menu/menu.tscn")
