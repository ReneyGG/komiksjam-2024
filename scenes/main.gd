extends Node3D

@export var max_enemies := 4
@export var end := false

var enemies = 0
var over := false
var win_flag := false
var dreams := 0

func _ready():
	Diary.reset()
	$CanvasLayer/Control/Forgor.hide()
	Diary.spawn_boss.connect(spawn_boss)

func spawn_boss():
	var boss = load("res://scenes/enemy/boss.tscn")
	var init = boss.instantiate()
	get_node("Enemies").add_child(init)
	init.global_position = get_node("Player").global_position - Vector3(0,0,15)

func _process(delta):
	pass
	#if end and $Enemies.get_children().size() == 0:
		#win()

func win(dream):
	pass
	#if not win_flag:
		#win_flag = true
		#Diary.get_dream(dream)

func game_over(pos):
	if not over:
		over = true
		get_tree().paused = true
		$CamManager/Camera3D.pan_lose(pos)
		#$CanvasLayer/Control/Forgor.show()

