extends Node3D

@onready var scene_camera = get_parent().get_parent().get_node("CamManager/CamShaker")

@export var end_pos : Vector3
var start_pos : Vector3
var height_pos : Vector3
var height = 4.0
var count = 0.0
var flag := false

func _ready():
	randomize()
	await get_tree().physics_frame
	start_pos = global_position
	height_pos = start_pos + (end_pos - start_pos)/2 + Vector3.UP * height
	#$AnimatedSprite3D.play("default")
	#$AnimationPlayer.play("start")

func _physics_process(delta):
	if flag:
		return
	if count < 1.0:
		count += 1.0 * delta
		var m1 = lerp(start_pos, height_pos, count)
		var m2 = lerp(height_pos, end_pos, count)
		global_position = lerp(m1, m2, count)
	else:
		explode()
		flag = true
		return

func explode():
	$Boom.pitch_scale = randf_range(0.9,1.3)
	$Boom.play()
	scene_camera.shake()
	#FrameFreeze.frame_freeze(0.1,0.1)
	for i in $Area3D.get_overlapping_bodies():
		i.hit(2)
	$MeshInstance3D.hide()
	$GPUParticles3D.restart()
	await $GPUParticles3D.finished
	queue_free()
