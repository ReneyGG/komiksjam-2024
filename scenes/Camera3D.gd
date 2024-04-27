extends Camera3D

@export var target: Node3D
@export var smooth_speed: float
@export var offset: Vector3

func _physics_process(delta: float) -> void:
	if(target != null):
		global_position = lerp(self.global_position, target.global_position + offset, smooth_speed * delta)
