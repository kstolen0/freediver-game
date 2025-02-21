extends CharacterBody2D
class_name Seagull

var submerged = 0

signal on_water

@onready var animations = $gull_animations/AnimationPlayer
# player

func _ready():
	pass
	
func _physics_process(delta):
	move_and_slide()
