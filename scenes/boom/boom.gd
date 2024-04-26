extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("start")

func _process(delta):
	pass

func explode():
	for i in $Area3D.get_overlapping_bodies():
		i.hit()
	queue_free()
