extends CharacterBody2D

var submerged = 0
signal on_water()
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	add_to_group("fish")

func _physics_process(delta: float) -> void:
	if position.y < 1690:
			velocity.y += gravity * delta * 0.8
	move_and_slide()
