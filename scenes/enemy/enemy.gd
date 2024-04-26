extends CharacterBody3D

@onready var player = get_parent().get_parent().get_node("Player")

var speed = 10.0
var friction = 0.15
var acceleration = 0.1
var target

func _ready():
	var pool = get_parent().get_parent().get_node("Points")
	target = pool.get_children().pick_random()

func _process(delta):
	var direction = global_position.direction_to(target.global_position)
	faceDirection(target.global_position)
	velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	move_and_slide()

func faceDirection(direction):
	look_at(Vector3(direction.x, global_position.y, direction.z), Vector3.UP)

func hit():
	queue_free()
