extends CharacterBody3D

@onready var player = get_parent().get_parent().get_node("Player")

var speed = 2.0
var friction = 0.02
var acceleration = 0.1
var target = null
var attack := false
var blobs = []

func _ready():
	randomize()
	$Timer.start(randf_range(0.0,0.2))
	await $Timer.timeout
	$przeciwnik_strzelajacy_/AnimationPlayer.play("Armature_001Action_001_Armature_002")
	target = player
	#var pick = [0,1].pick_random()
	#if pick == 0:
		#target = player
	#else:
		#target = get_parent().get_parent().get_node("Points").get_children().pick_random()

func _physics_process(delta):
	if not target:
		return
	for i in blobs:
		i.hit()
	var direction = global_position.direction_to(target.global_position)
	faceDirection(target.global_position)
	if global_position.distance_to(player.global_position) < 2.5:
		velocity = velocity.lerp(global_position.direction_to(player.global_position).normalized() * -speed, acceleration)
	elif global_position.distance_to(target.global_position) > 5:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector3.ZERO, friction)
	move_and_slide()

func faceDirection(direction):
	look_at(Vector3(direction.x, global_position.y, direction.z), Vector3.UP)

func hit():
	$Area3D.monitoring = false
	target = null
	$przeciwnik_strzelajacy_.hide()
	$GPUParticles3D.restart()
	await $GPUParticles3D.finished
	queue_free()

func _on_area_3d_body_entered(body):
	if body.is_in_group("obelisk"):
		blobs.append(body)
	elif body.is_in_group("player"):
		body.hit(self)
	elif body.is_in_group("minion"):
		body.hit()

func _on_area_3d_body_exited(body):
	blobs.erase(body)
