extends Node
class_name FishSmState

signal transitioned(state, new_state_name)

@onready var fish : CharacterBody2D = get_owner()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func enter():
	pass
	
func exit():
	pass
	
func process_state(delta):
	pass
	
func physics_process_state(delta):
	pass

func _process(delta):
	pass
