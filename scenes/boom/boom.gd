extends Node3D

@onready var scene_camera = get_parent().get_parent().get_node("CamManager")

func _ready():
	$AnimatedSprite3D.play("default")
	$AnimationPlayer.play("start")

func _process(delta):
	pass

func explode():
	Sfx.play_sound("boom")
	scene_camera.shake()
	for i in $Area3D.get_overlapping_bodies():
		i.hit()
	queue_free()
