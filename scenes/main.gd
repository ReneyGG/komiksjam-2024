extends Node3D

@export var max_enemies := 4
@export var end := false

var enemies = 0
var over := false
var win_flag := false

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
	#if end and $Enemies.get_children().size() == 0:
		#win()

func win(dream):
	if not win_flag:
		win_flag = true
		Diary.get_dream(dream)

func game_over():
	if not over:
		over = true
		get_tree().reload_current_scene()
