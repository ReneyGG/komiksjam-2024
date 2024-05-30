extends CharacterBody3D

var pull := false
var target = null

func _ready():
	randomize()

func _physics_process(delta):
	if pull and target:
		var player_pos = target.global_position
		var direction = global_position.direction_to(player_pos)
		var accel = 1.0 - global_position.distance_to(player_pos)/4
		accel = accel / 20
		velocity = velocity.lerp(direction.normalized() * 1.0, accel)
	else:
		velocity = velocity.lerp(Vector3(0,0,0), 0.02)
	move_and_slide()

func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		if body.power < 9:
			body.get_power(1)
			self.hide()
			$Boop.pitch_scale = randf_range(0.8,1.2)
			$Boop.play()
			await $Boop.finished
			queue_free()

func _on_area_pull_body_entered(body):
	if body.is_in_group("player"):
		target = body
		pull = true

func _on_area_pull_body_exited(body):
	if body.is_in_group("player"):
		pull = false
