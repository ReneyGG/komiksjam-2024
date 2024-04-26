extends Node3D

var yes = false
var power = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label3D.text = "0%"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#global_position.x -= 0.1
	if yes:
		power += 0.1
		$Label3D.text = str(int(power))+"%"

func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		yes = true

func _on_area_3d_body_exited(body):
	if body.is_in_group("player"):
		yes = false
