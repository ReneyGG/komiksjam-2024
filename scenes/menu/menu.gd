extends Control


func _ready():
	pass # Replace with function body.

func _on_start_button_pressed():
	pass # Replace with function body.

func _on_tutorial_button_pressed():
	pass # Replace with function body.

func _on_credits_button_pressed():
	pass # Replace with function body.

func _on_exit_button_pressed():
	pass # Replace with function body.


func _on_start_button_mouse_entered():
	$StartButton/TextureRect.scale = lerp($StartButton/TextureRect.scale, Vector2(1.5,1.5), 0.2)

func _on_start_button_mouse_exited():
	$StartButton/TextureRect.scale = lerp($StartButton/TextureRect.scale, Vector2(1,1), 0.2)


func _on_tutorial_button_mouse_entered():
	$TutorialButton/TextureRect.scale = lerp($TutorialButton/TextureRect.scale, Vector2(1.5,1.5), 0.2)

func _on_tutorial_button_mouse_exited():
	$TutorialButton/TextureRect.scale = lerp($TutorialButton/TextureRect.scale, Vector2(1,1), 0.2)


func _on_credits_button_mouse_entered():
	$CreditsButton/TextureRect.scale = lerp($CreditsButton/TextureRect.scale, Vector2(1.5,1.5), 0.2)

func _on_credits_button_mouse_exited():
	$CreditsButton/TextureRect.scale = lerp($CreditsButton/TextureRect.scale, Vector2(1,1), 0.2)


func _on_exit_button_mouse_entered():
	$ExitButton/TextureRect.scale = lerp($ExitButton/TextureRect.scale, Vector2(1.5,1.5), 0.2)

func _on_exit_button_mouse_exited():
	$ExitButton/TextureRect.scale = lerp($ExitButton/TextureRect.scale, Vector2(1,1), 0.2)
