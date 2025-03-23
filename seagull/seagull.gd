extends CharacterBody2D
class_name Seagull

var depth = 0

signal on_water

@onready var animations = $gull_animations/AnimationPlayer
# player

func _ready():
	add_to_group("birds")
	pass
	
func _physics_process(delta):
	move_and_slide()
