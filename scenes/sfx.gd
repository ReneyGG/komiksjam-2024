extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
			$Boom.play()

