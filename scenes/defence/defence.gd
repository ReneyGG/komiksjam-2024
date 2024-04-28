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
		queue_free()
	if power <= 0.0 and not yes:
		yes = true
		get_parent().get_parent().game_over(self.global_position)
	
	$Label3D.text = str(int(power))+"%"

func heal():
	if yes:
		return
	if power < 100:
		power += 0.4

func hit():
	if yes:
		return
	if power > 0:
		power -= 0.005
