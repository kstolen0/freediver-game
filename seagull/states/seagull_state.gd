extends Node
class_name SeagullState

signal transitioned(state, new_state_name)
signal scared_off()

@onready var seagull : CharacterBody2D = get_owner()
var prev_x = 15
const PLAYER_DISTANCE_THRESHOLD = 100
var player : CollisionObject2D

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")
	
func enter():
	pass

func process_state(delta):
	pass
	
func physics_process_state(delta):
	var dist = (player.position - seagull.position).length()
	if dist < PLAYER_DISTANCE_THRESHOLD  && seagull.velocity.y >= 0:
		scared_off.emit()
	pass

func exit():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
