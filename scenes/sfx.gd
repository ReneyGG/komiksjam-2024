extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func play_sound(s):
	match s:
		"death":
			$Death.play()
		"dziennik":
			$Dziennik.play()
		"jedzonnko":
			$Jedzonko.play()
		"button":
			$Button.play()
		"kids":
			$Kids.play()
		"podloga":
			$Podloga.play()
		"pozytywka":
			$Pozytywka.play()
		"zabawka":
			$Zabawka.play()
		"boom":
			$Boom.pitch_scale = randf_range(0.8,1.3)
			$Boom.play()

