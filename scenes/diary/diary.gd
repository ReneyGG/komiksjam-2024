extends CanvasLayer
signal spawn_boss

var dreams := 0
var boss_flag := false
@export var b_flag = false

func _ready():
	$TextureRect/OutButton.disabled = true
	$TextureRect.position.y = 1084
	$TextureRect/Closeup.hide()
	$TextureRect/Darken.hide()
	dreams = 0

func _process(delta):
	pass

func reset():
	dreams = 0
	boss_flag = false
	b_flag = false
	$TextureRect.position.y = 1084
	$TextureRect/Pic1.hide()
	$TextureRect/Pic2.hide()
	$TextureRect/Pic3.hide()
	$TextureRect/Pic4.hide()
	$TextureRect/Pic5.hide()
	$TextureRect/Pic6.hide()

func _input(event):
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			close_diary()
		else:
			opeen_diary()

func get_dream(dream):
	get_node("TextureRect/Pic"+dream).visible = true

	dreams += 1
	Sfx.play_sound("dziennik")
	opeen_diary()
	if dreams == 6 and not boss_flag:
		boss_flag = true
		print("boss")
		emit_signal("spawn_boss")

func opeen_diary():
	$TextureRect/Closeup.hide()
	$TextureRect/Darken.hide()
	$AnimationPlayer.play("open_diary")

func close_diary():
	$TextureRect/Closeup.hide()
	$TextureRect/Darken.hide()
	$AnimationPlayer.play("close_diary")

func pause():
	get_tree().paused = true

func unpause():
	get_tree().paused = false

func _on_menu_button_pressed():
	if not b_flag:
		b_flag = true
		close_diary()
		Fade.fade("res://scenes/menu/menu.tscn")

func _on_out_button_pressed():
	if not b_flag:
		b_flag = true
		close_diary()

func _on__pressed():
	$TextureRect/Closeup.texture = load("res://assets/pics/1_zabawka.png")
	$TextureRect/Closeup.show()
	$TextureRect/Darken.show()
	$TextureRect/MenuButton.disabled = true

func _on_2_pressed():
	$TextureRect/Closeup.texture = load("res://assets/pics/2_plac.png")
	$TextureRect/Closeup.show()
	$TextureRect/Darken.show()
	$TextureRect/MenuButton.disabled = true

func _on_3_pressed():
	$TextureRect/Closeup.texture = load("res://assets/pics/3_jedzonko.png")
	$TextureRect/Closeup.show()
	$TextureRect/Darken.show()
	$TextureRect/MenuButton.disabled = true

func _on_4_pressed():
	$TextureRect/Closeup.texture = load("res://assets/pics/4_klotnia.png")
	$TextureRect/Closeup.show()
	$TextureRect/Darken.show()
	$TextureRect/MenuButton.disabled = true

func _on_5_pressed():
	$TextureRect/Closeup.texture = load("res://assets/pics/5_strych.png")
	$TextureRect/Closeup.show()
	$TextureRect/Darken.show()
	$TextureRect/MenuButton.disabled = true

func _on_6_pressed():
	$TextureRect/Closeup.texture = load("res://assets/pics/6_ryba.png")
	$TextureRect/Closeup.show()
	$TextureRect/Darken.show()
	$TextureRect/MenuButton.disabled = true


func _on_closeup_button_pressed():
	$TextureRect/Closeup.hide()
	$TextureRect/Darken.hide()
	$TextureRect/MenuButton.disabled = false

func _on_pullup_button_pressed():
	$AnimationPlayer.play("open_diary")
