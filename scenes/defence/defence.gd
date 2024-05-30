extends StaticBody3D

@export var dream : String

var taken = false
var attack = false
@export var power = 0.0

func _ready():
	power = 0.0
	$Label3D.text = "0%"

func _physics_process(delta):
	rotation_degrees.y += 10 * delta
	if power >= 50.0 and not taken:
		taken = true
		$Label3D.modulate = Color("ff1f1d")
		#Diary.get_dream(dream)
		#queue_free()
	if power < 50.0 and taken:
		taken = false
		$Label3D.modulate = Color("ffffff")
		#get_parent().get_parent().game_over(self.global_position)
	
	$Label3D.text = str(int(power))+"%"

func heal(i):
	if power < 100.0:
		power += i

func hit():
	if power > 0.0:
		power -= 0.04
