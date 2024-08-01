extends Node3D
signal spawned

@onready var nod = get_parent().get_parent().get_node("Enemies")

@export var horizontal := false

var melee = preload("res://scenes/enemy/enemy.tscn")
var shoot = preload("res://scenes/enemy/enemy_shoot.tscn")
var mobs

func _ready():
	randomize()
	if get_tree().current_scene.level == 3:
		mobs = [melee,shoot]
	else:
		mobs = [melee]
	_on_timer_timeout()

func _on_timer_timeout():
	spawn()
	$Timer.start(randf_range(0.3, 0.8))

func spawn():
	if nod.get_children().size() > 10:
		return
	emit_signal("spawned")
	var p: float
	var init = mobs.pick_random().instantiate()
	nod.add_child(init)
	if horizontal:
		p = randf_range(-10, 10)
		init.global_position = Vector3(p, self.global_position.y , self.global_position.z)
	else:
		p = randf_range(-10, 10)
		init.global_position = Vector3(self.global_position.x, self.global_position.y, p)
