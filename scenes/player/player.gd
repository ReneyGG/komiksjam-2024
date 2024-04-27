extends CharacterBody3D

@onready var navigationAgent : NavigationAgent3D = $NavigationAgent3D

@export var camera : Node

var speed = 4
var friction = 0.15
var acceleration = 0.1
var projectile = preload("res://scenes/boom/boom.tscn")
var stop_move = false
var hp = 100.0
var dead := false
var target_dream = null
var healing := false

func _ready():
	$maincharacter_wysrodkowany/AnimationPlayer.play("ArmatureAction")

func _physics_process(delta):
	if dead:
		return
	#if stop_move:
		#return
	if(navigationAgent.is_navigation_finished()):
		return
	
	if Input.is_action_pressed("space"):
		if target_dream:
			if target_dream.power < 100:
				target_dream.heal()
				if camera.fov > 45:
					camera.fov -= 0.03
	else:
		camera.fov = lerp(camera.fov, 75.0, 0.2)
	
	moveToPoint(delta, speed)

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

func hit():
	if dead:
		return
	hp -= 0.1
	if hp <= 0:
		dead = true
		game_over()

func game_over():
	get_parent().game_over()

func _input(event):
	if dead:
		return
	if Input.is_action_pressed("left_mouse"):
		var mousePos = get_viewport().get_mouse_position()
		var rayLength = 1000
		var from = camera.project_ray_origin(mousePos)
		var to = from + camera.project_ray_normal(mousePos) * rayLength
		var space = get_world_3d().direct_space_state
		var rayQuery = PhysicsRayQueryParameters3D.new()
		rayQuery.from = from
		rayQuery.to = to
		rayQuery.collide_with_areas = true
		var result = space.intersect_ray(rayQuery)
		
		if result.get("position"):
			navigationAgent.target_position = result.position
	
	if Input.is_action_just_pressed("right_mouse"):
		if not $Cooldown.get_time_left() > 0:
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
