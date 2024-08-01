extends Node3D

@export var level = 1

var enemies = 0
var over := false
var dreams := 0

func _ready():
	Diary.av = true
	$CanvasLayer/Control/Forgor.hide()
	Diary.spawn_boss.connect(spawn_boss)

func spawn_boss():
	var boss = load("res://scenes/enemy/boss.tscn")
	var init = boss.instantiate()
	get_node("Enemies").add_child(init)
	init.global_position = get_node("Player").global_position - Vector3(0,0,15)

func _physics_process(delta):
	if over:
		return
	
	$CanvasLayer/Control/VSlider/Label.text = str($CanvasLayer/Control/VSlider.value)
	
	for i in $Points.get_children():
		if i.power < 100.0:
			return
	
	if Diary.can_go:
		win()

func win():
	if not over:
		over = true
		Diary.close_diary()
		Diary.can_go = false
		if level == 3:
			Fade.fade("res://scenes/win_screen/win_screen.tscn")
		elif level == 2:
			Fade.fade("res://scenes/Levels/main11.tscn")
		else:
			Fade.fade("res://scenes/Levels/main12.tscn")

func game_over(pos):
	if not over:
		over = true
		get_tree().paused = true
		$CamManager.pan_lose(pos)
		#$CanvasLayer/Control/Forgor.show()

