extends Node3D

@export var dream = 1
@export var max_enemies := 4

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

func _process(delta):
	if over:
		return
	
	$CanvasLayer/Control/VSlider/Label.text = str($CanvasLayer/Control/VSlider.value)
	
	for i in $Points.get_children():
		if i.power < 50:
			return
	
	win()

func win():
	if not over:
		over = true
		Diary.get_dream(dream)

func game_over(pos):
	if not over:
		over = true
		get_tree().paused = true
		$CamManager.pan_lose(pos)
		#$CanvasLayer/Control/Forgor.show()

