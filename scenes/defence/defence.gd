extends StaticBody3D

@export var dream : int
@export var power = 0.0

var taken = false
var attack = false

func _ready():
	power = 0.0
	$Label3D.text = "0%"

func _physics_process(delta):
	rotation_degrees.y += 10 * delta
	if power >= 100.0 and not taken:
		taken = true
		$Label3D.modulate = Color("ff1f1d")
		if dream != 0:
			Diary.get_dream(dream)
		else:
			Sfx.play_sound("dziennik")
		#queue_free()
	
	$Label3D.text = str(int(power))+"%"

func heal(i):
	if power < 100.0:
		power += i

func hit(p = 0.04):
	if taken:
		return
	if power > 0.0:
		power -= p
