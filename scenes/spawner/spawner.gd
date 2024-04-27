extends Node3D
signal spawned

@onready var nod = get_parent().get_node("Enemies")

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
	$Timer.start(randf_range(1.0,2.0))

func spawn():
	if get_parent().end:
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
