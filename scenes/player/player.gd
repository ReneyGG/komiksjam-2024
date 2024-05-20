extends CharacterBody3D

@onready var navigationAgent : NavigationAgent3D = $NavigationAgent3D

@export var camera : Node
@export var power := 2

var speed = 3
var friction = 0.02
var acceleration = 0.06
var rotate_speed = 1000
var projectile = preload("res://scenes/boom/boom.tscn")
var minion = preload("res://scenes/minion/minion.tscn")
var stop_move = false
var hp = 10
var dead := false
var target_dream = null
var healing := false

func _ready():
	$maincharacter_wysrodkowany/AnimationPlayer.play("ArmatureAction")

func _physics_process(delta):
	$CanvasLayer/Control/TextureRect/Label.text = str(power)
	
	if dead:
		return
	#if stop_move:
		#return
	#if(navigationAgent.is_navigation_finished()):
		#return
	
	if Input.is_action_pressed("space"):
		if target_dream:
			if target_dream.power < 100:
				target_dream.heal(0.4)
				if camera.fov > 30:
					camera.fov -= 0.04
	else:
		camera.fov = lerp(camera.fov, 50.0, 0.2)
	
	var direction = get_input_mov()
	if direction.length() > 0:
		#var target_position = direction + global_position
		#var new_transform = $maincharacter_wysrodkowany.transform.looking_at(target_position, Vector3.UP)
		#$maincharacter_wysrodkowany.transform  = $maincharacter_wysrodkowany.transform.interpolate_with(new_transform, rotate_speed * delta)
		$maincharacter_wysrodkowany.look_at(direction+global_position)
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector3.ZERO, friction)
	
	velocity.y = 0
	move_and_slide()
	
	#moveToPoint(delta, speed)

func moveToPoint(delta, speed):
	var targetPos = navigationAgent.get_next_path_position()
	var direction = global_position.direction_to(targetPos)
	faceDirection(targetPos)
	if global_position.distance_to(navigationAgent.target_position) > 1.0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector3.ZERO, friction)
	
	move_and_slide()

func faceDirection(direction):
	$maincharacter_wysrodkowany.look_at(Vector3(direction.x, global_position.y, direction.z), Vector3.UP)

func get_power(amount):
	power += amount

func knockback(source, power):
	var point = source.global_position - self.global_position
	point = point.normalized()
	point.y = 0
	velocity -= point * power

func hit(source):
	knockback(source, 12)
	hp -= 1
	$Hit.play()
	get_parent().get_node("AnimationPlayer").play("get_hit")
	camera.get_parent().shake()
	FrameFreeze.frame_freeze(0.1,0.2)
	if hp <= 0:
		$GPUParticles3D.restart()
		$maincharacter_wysrodkowany.hide()
		game_over()

func game_over():
	get_parent().game_over(global_position)

func get_input_mov():
	var input = Vector3()
	if Input.is_action_pressed('right'):
		input.x += 1
	if Input.is_action_pressed('left'):
		input.x -= 1
	if Input.is_action_pressed('down'):
		input.z += 1
	if Input.is_action_pressed('up'):
		input.z -= 1
	return input

func _input(event):
	if dead:
		return
	
	if Input.is_action_just_pressed("left_mouse") and not Input.is_action_pressed("space"):
		if not $Cooldown.get_time_left() > 0 and power > 0:
			var mousePos = get_viewport().get_mouse_position()
			var rayLength = 1000
			var from = camera.project_ray_origin(mousePos)
			var to = from + camera.project_ray_normal(mousePos) * rayLength
			var space = get_world_3d().direct_space_state
			var rayQuery = PhysicsRayQueryParameters3D.new()
			rayQuery.from = from
			rayQuery.to = to
			rayQuery.collide_with_areas = true
			rayQuery.collision_mask = 1
			var result = space.intersect_ray(rayQuery)
			
			if result.get("position"):
				power -= 1
				stop_move = true
				$Cooldown.start()
				var init = minion.instantiate()
				get_parent().get_node("Minions").add_child(init)
				init.global_position = result.position
	
	if Input.is_action_just_pressed("right_mouse") and not Input.is_action_pressed("space"):
		if not $Cooldown.get_time_left() > 0 and power > 0:
			var mousePos = get_viewport().get_mouse_position()
			var rayLength = 1000
			var from = camera.project_ray_origin(mousePos)
			var to = from + camera.project_ray_normal(mousePos) * rayLength
			var space = get_world_3d().direct_space_state
			var rayQuery = PhysicsRayQueryParameters3D.new()
			rayQuery.from = from
			rayQuery.to = to
			rayQuery.collide_with_areas = true
			rayQuery.collision_mask = 1
			var result = space.intersect_ray(rayQuery)
			
			if result.get("position"):
				power -= 1
				stop_move = true
				$Cooldown.start()
				var init = projectile.instantiate()
				get_parent().get_node("Projectiles").add_child(init)
				init.global_position = result.position

func _on_cooldown_timeout():
	stop_move = false

func _on_area_3d_body_entered(body):
	if body.is_in_group("obelisk"):
		target_dream = body

func _on_area_3d_body_exited(body):
	if body.is_in_group("obelisk"):
		target_dream = null

func _on_knockback_area_body_entered(body):
	knockback(body, 4)
