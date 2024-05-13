extends Control

func _ready():
	Diary.av = false

func _on_start_button_pressed():
	$Button.play()
	Fade.fade("res://scenes/main.tscn")

func _on_tutorial_button_pressed():
	$Button.play()
	Fade.fade("res://scenes/tutorial/tutorial.tscn")

func _on_credits_button_pressed():
	$Button.play()
	Fade.fade("res://scenes/credits/credits.tscn")

func _on_exit_button_pressed():
	$Button.play()
	await $Button.finished
	get_tree().quit()


func _on_start_button_mouse_entered():
	$Hover.play()
	$StartButton/Label.scale = lerp($StartButton/Label.scale, Vector2(1.2,1.2), 0.2)

func _on_start_button_mouse_exited():
	$StartButton/Label.scale = lerp($StartButton/Label.scale, Vector2(1,1), 0.2)


func _on_tutorial_button_mouse_entered():
	$Hover.play()
	$TutorialButton/Label.scale = lerp($TutorialButton/Label.scale, Vector2(1.2,1.2), 0.2)

func _on_tutorial_button_mouse_exited():
	$TutorialButton/Label.scale = lerp($TutorialButton/Label.scale, Vector2(1,1), 0.2)


func _on_credits_button_mouse_entered():
	$Hover.play()
	$CreditsButton/Label.scale = lerp($CreditsButton/Label.scale, Vector2(1.2,1.2), 0.2)

func _on_credits_button_mouse_exited():
	$CreditsButton/Label.scale = lerp($CreditsButton/Label.scale, Vector2(1,1), 0.2)


func _on_exit_button_mouse_entered():
	$Hover.play()
	$ExitButton/Label.scale = lerp($ExitButton/Label.scale, Vector2(1.2,1.2), 0.2)

func _on_exit_button_mouse_exited():
	$ExitButton/Label.scale = lerp($ExitButton/Label.scale, Vector2(1,1), 0.2)
