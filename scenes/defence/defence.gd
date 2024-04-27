extends StaticBody3D

@export var dream : String

var yes = false
var attack = false
@export var power = 0.0

func _ready():
	$Label3D.text = "0%"

func _process(delta):
	if power >= 100.0:
		get_parent().get_parent().win(dream)
	
	$Label3D.text = str(int(power))+"%"

func heal():
	if power < 100:
		power += 0.2

func hit():
	if power > 0:
		power -= 0.1
