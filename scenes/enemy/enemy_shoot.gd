extends CharacterBody3D

@onready var player = get_parent().get_parent().get_node("Player")

var speed = 2.0
var friction = 0.02
var acceleration = 0.1
var target = null
var attack := false
var blobs = []
var projectile = preload("res://scenes/boom/enemy_boom.tscn")

func _ready():
	randomize()
	$Timer.start(randf_range(0.0,0.2))
	await $Timer.timeout
	$strzelajacy_poprawiony/AnimationPlayer.play("Armature_001Action")
	target = player
	var pick = [0,1,2].pick_random()
	if pick == 0:
		target = player
	elif pick == 1 and get_parent().get_parent().get_node("Minions").get_children().size() != 0:
		target = get_parent().get_parent().get_node("Minions").get_children().pick_random()
	else:
		var points = get_parent().get_parent().get_node("Points").get_children()
		var pool : Array
		for i in points:
			if i.power < 100.0:
				pool.append(i)
		if pool.size() > 0:
			target = pool.pick_random()
		else:
			target = player

func _physics_process(delta):
	if not target:
		target = player
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
	self.global_position.y = player.global_position.y
	if self.global_position.distance_to(target.global_position) <= 5 and $AttackTimer.time_left == 0:
		$AttackTimer.start(3)

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
	$strzelajacy_poprawiony.hide()
	$GPUParticles3D.restart()
	await $GPUParticles3D.finished
	queue_free()

func _on_area_3d_body_entered(body):
	if body.is_in_group("obelisk"):
		blobs.append(body)
	elif body.is_in_group("player"):
		body.hit(0,self)
	elif body.is_in_group("minion"):
		body.hit(0)

func _on_area_3d_body_exited(body):
	blobs.erase(body)

func _on_attack_timer_timeout():
	shoot(target.global_position)
