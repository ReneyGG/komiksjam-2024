extends CharacterBody3D

@onready var player = get_parent().get_parent().get_node("Player")

var speed = 2.0
var friction = 0.15
var acceleration = 0.1
var target = null
var attack := false
var blobs = []

func _ready():
	await get_tree().physics_frame
	var dist = 100.0
	for i in get_parent().get_parent().get_node("Points").get_children():
		var t = global_position.distance_to(i.global_position)
		if t < dist:
			dist = t
			target = i
	$Timer.start(randf_range(0.0,0.2))
	await $Timer.timeout
	$test_animprzeciwnika6/AnimationPlayer.play("Armature_001Action_001")

func _physics_process(delta):
	if not target:
		return
	for i in blobs:
		i.heal(0.04)
	var direction = global_position.direction_to(target.global_position)
	faceDirection(target.global_position)
	velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	move_and_slide()

func faceDirection(direction):
	look_at(Vector3(direction.x, global_position.y, direction.z), Vector3.UP)

func hit():
	$Area3D.monitoring = false
	target = null
	$test_animprzeciwnika6/Armature_001/Skeleton3D/Sphere.hide()
	$GPUParticles3D.restart()
	await $GPUParticles3D.finished
	queue_free()

func _on_area_3d_body_entered(body):
	if body.is_in_group("obelisk"):
		blobs.append(body)
	#elif body.is_in_group("enemy"):
		#body.hit()

func _on_area_3d_body_exited(body):
	blobs.erase(body)
