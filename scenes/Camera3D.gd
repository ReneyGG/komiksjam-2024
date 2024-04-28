extends Camera3D

@export var target: Node3D
@export var smooth_speed: float
@export var offset: Vector3

var fly := false
var target_fly

func _physics_process(delta: float) -> void:
	if fly:
		return
	if(target != null):
		global_position = lerp(self.global_position, target.global_position + offset, smooth_speed * delta)

func pan_lose(pos):
	fly = true
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "global_position", pos+offset, 1.5)
	await tween.finished
	$"../../CamTimer".start()
	await $"../../CamTimer".timeout
	$"../../CanvasLayer/Control/Forgor".show()
