extends Node3D

var mob = preload("res://scenes/power/power.tscn")

func _ready():
	randomize()
	_on_timer_timeout()

func _on_timer_timeout():
	spawn()
	$Timer.start(randf_range(0.5, 1.0))

func spawn():
	if self.get_children().size() > 8:
		return
	var init = mob.instantiate()
	self.add_child(init)
	init.global_position = Vector3(randf_range(-9, 8), 0.5, randf_range(-9, 9))
