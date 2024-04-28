extends CharacterBody3D

@onready var player = get_parent().get_parent().get_node("Player")

var speed = 1.0
var friction = 0.15
var acceleration = 0.1
var target = null
var attack := false
var blobs = []
var health := 5
var dead = false

func _ready():
	target = player

func _physics_process(delta):
	if not target:
		return
	for i in blobs:
		i.hit()
	rotation_degrees.y -= 10 * delta
	var direction = global_position.direction_to(target.global_position)
	faceDirection(target.global_position)
	velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	move_and_slide()

func faceDirection(direction):
	pass
	#look_at(Vector3(direction.x, global_position.y, direction.z), Vector3.UP)

func hit():
	health -= 1
	$GPUParticles3D.restart()
	if health <= 0 and not dead:
		dead = true
		Fade.fade("res://scenes/win_screen/win_screen.tscn")
		queue_free()

func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		blobs.append(body)

func _on_area_3d_body_exited(body):
	blobs.erase(body)
