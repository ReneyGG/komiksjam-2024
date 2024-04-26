extends CharacterBody3D

@onready var navigationAgent : NavigationAgent3D = $NavigationAgent3D

@export var camera : Node

var speed = 60
var friction = 0.15
var acceleration = 0.1
var projectile = preload("res://scenes/boom/boom.tscn")

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(navigationAgent.is_navigation_finished()):
		return
	
	moveToPoint(delta, speed)

func moveToPoint(delta, speed):
	var targetPos = navigationAgent.get_next_path_position()
	var direction = global_position.direction_to(targetPos)
	faceDirection(targetPos)
	velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	move_and_slide()

func faceDirection(direction):
	look_at(Vector3(direction.x, global_position.y, direction.z), Vector3.UP)

func _input(event):
	if Input.is_action_just_pressed("left_mouse"):
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
				$Cooldown.start()
				var init = projectile.instantiate()
				get_parent().get_node("Projectiles").add_child(init)
				init.global_position = result.position
