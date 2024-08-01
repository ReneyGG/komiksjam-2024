extends CharacterBody3D

@onready var player = get_parent().get_parent().get_node("Player")

@export var speed = 2.0
var friction = 0.15
var acceleration = 0.1
var target = null
var attack := false
var blobs = []
var player_in_range := false

func _ready():
	randomize()
	$Timer.start(randf_range(0.0,0.2))
	await $Timer.timeout
	$przeciwnik_nowy_basic_poprawiony2/AnimationPlayer.play("Armature_001Action_002")
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
	velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	move_and_slide()
	self.global_position.y = player.global_position.y

func faceDirection(direction):
	look_at(Vector3(direction.x, global_position.y, direction.z), Vector3.UP)

func hit(_p):
	$Area3D.monitoring = false
	target = null
	$przeciwnik_nowy_basic_poprawiony2.hide()
	$GPUParticles3D.restart()
	await $GPUParticles3D.finished
	queue_free()

func attack_player():
	if $AttackTimer.time_left == 0 and player_in_range:
		player.hit(0,self)
		$AttackTimer.start()

func _on_area_3d_body_entered(body):
	if body.is_in_group("obelisk"):
		blobs.append(body)
	elif body.is_in_group("player"):
		player_in_range = true
		attack_player()
	elif body.is_in_group("minion"):
		body.hit(0)

func _on_area_3d_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
	else:
		blobs.erase(body)

func _on_attack_timer_timeout():
	attack_player()
