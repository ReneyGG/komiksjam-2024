extends Camera3D

#@export var target: Node3D
#@export var smooth_speed: float
#@export var offset: Vector3
#
#var fly := false
#var target_fly
#
#func _physics_process(delta: float) -> void:
	#if fly:
		#return
	#if(target != null):
		#global_position = lerp(self.global_position, target.global_position + offset, smooth_speed * delta)
	#self.look_at(get_parent().get_parent().global_position)
#
#func pan_lose(pos):
	#fly = true
	#$"../../CamTimer".start(0.5)
	#await $"../../CamTimer".timeout
	#$"../../CanvasLayer/Control/Forgor".show()
