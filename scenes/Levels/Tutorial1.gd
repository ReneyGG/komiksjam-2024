extends TextureRect

func _ready():
	Pause.av = false
	get_tree().paused = true

func _input(event):
	if Input.is_action_just_pressed("pause") and get_parent().visible:
		get_parent().hide()
		get_tree().paused = false
		await get_tree().physics_frame
		Pause.av = true

func _on_close_tut_button_pressed():
	get_parent().hide()
	get_tree().paused = false
	Pause.av = true
