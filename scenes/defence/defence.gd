extends StaticBody3D

@export var dream : String

var yes = false
var attack = false
var power = 0.0

func _ready():
	$Label3D.text = "0%"

func _process(delta):
	if yes:
		if power < 100.0:
			power += 0.1
		else:
			get_parent().get_parent().win(dream)
	
	$Label3D.text = str(int(power))+"%"

func hit():
	if power > 0:
		power -= 0.1

func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		yes = true

func _on_area_3d_body_exited(body):
	if body.is_in_group("player"):
		yes = false
