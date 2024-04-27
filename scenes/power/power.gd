extends Node3D


func _ready():
	$Area3D.monitoring = false

func _process(delta):
	pass

func available():
	visible = true
	$Area3D.monitoring = true

func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		Diary.get_dream()
		queue_free()
