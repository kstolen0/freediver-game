extends CharacterBody2D

var submerged = 0
signal on_water()

func _physics_process(delta: float) -> void:
	move_and_slide()
