extends Node3D
signal spawned

@onready var nod = get_parent().get_parent().get_node("Enemies")

@export var horizontal := false

var mob = preload("res://scenes/enemy/enemy.tscn")

func _ready():
	randomize()
	_on_timer_timeout()

func _on_timer_timeout():
	spawn()
	#$Timer.start(randf_range(8.0,15.0))

func spawn():
	if nod.get_children().size() > 10:
		return
	emit_signal("spawned")
	var p: float
	var init = mob.instantiate()
	nod.add_child(init)
	if horizontal:
		p = randf_range(-10, 10)
		init.global_position = Vector3(p, self.global_position.y , self.global_position.z)
	else:
		p = randf_range(-10, 10)
		init.global_position = Vector3(self.global_position.x, self.global_position.y, p)
