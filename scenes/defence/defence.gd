extends StaticBody3D

@export var dream : String

var yes = false
var attack = false
@export var power = 0.0

func _ready():
	$Label3D.text = "0%"

func _physics_process(delta):
	rotation_degrees.y += 10 * delta
	if power >= 100.0 and not yes:
		yes = true
		Diary.get_dream(dream)
	
	$Label3D.text = str(int(power))+"%"

func heal():
	if power < 100:
		power += 1

func hit():
	if power > 0:
		power -= 0.2
