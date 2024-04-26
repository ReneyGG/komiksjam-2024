extends Node3D
#signal spawned

@export var horizontal := false

var mob = preload("res://scenes/enemy/enemy.tscn")
#var foods = ["1","2","3","4"]
#var i
#var bonus_speed = 0.0
#var bonus_cld = 0.0
#var value = 0.0

func _ready():
	#mob = load("res://prisoner.tscn")
	randomize()
	#i = foods.pick_random()
	_on_timer_timeout()

func _on_timer_timeout():
	spawn()
	$Timer.start(randf_range(3.0,5.0))

func spawn():
	var p: float
	var init = mob.instantiate()
	add_child(init)
	if horizontal:
		p = randf_range(-130, 130)
		init.global_position = Vector3(p, self.global_position.y , self.global_position.z)
	else:
		p = randf_range(-210, 13)
		init.global_position = Vector3(self.global_position.x, self.global_position.y, p)
