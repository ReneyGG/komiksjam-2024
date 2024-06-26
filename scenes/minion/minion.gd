extends CharacterBody3D

@onready var player = get_parent().get_parent().get_node("Player")

var speed = 0
var friction = 0.15
var acceleration = 0.1
var target = null
var array_targets : Array
var face = null
var attack := false
var blobs = []
var projectile = preload("res://scenes/boom/boom.tscn")

func _ready():
	await get_tree().physics_frame
	$Timer.start(randf_range(0.0,0.2))
	await $Timer.timeout
	$minionek_poprawiony_2/AnimationPlayer.play("Armature_001Action")

func _physics_process(delta):
	for i in blobs:
		i.heal(0.04)
	if array_targets.size() != 0:
		target = array_targets[0]
		face = array_targets[0]
	else:
		target = null
		face = player
	var direction = global_position.direction_to(face.global_position)
	faceDirection(face.global_position)
	move_and_slide()
	self.global_position.y = player.global_position.y + 0.1

func faceDirection(direction):
	look_at(Vector3(direction.x, global_position.y, direction.z), Vector3.UP)

func shoot(end_pos):
	var init = projectile.instantiate()
	get_parent().get_parent().get_node("Projectiles").add_child(init)
	init.global_position = self.global_position
	init.end_pos = end_pos

func hit(_p):
	$Area3D.monitoring = false
	target = null
	$minionek_poprawiony_2.hide()
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

func _on_range_body_entered(body):
	if body.is_in_group("enemy"):
		array_targets.append(body)
		if $AttackTimer.time_left == 0:
			$AttackTimer.start(2)

func _on_range_body_exited(body):
	array_targets.erase(body)

func _on_attack_timer_timeout():
	if target:
		shoot(target.global_position)
		$AttackTimer.start(2)
