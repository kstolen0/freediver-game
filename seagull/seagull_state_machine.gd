extends Node

@export var initial_state: SeagullState
var current_state
var states = {}


func _ready():
	for child in get_children():
			if child is SeagullState:				
				states[child.name.to_lower()] = child
				child.transitioned.connect(on_child_transition)	
				child.scared_off.connect(on_take_off)	
	if initial_state:
			print("initial state exists")
			current_state = initial_state
			current_state.enter()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_state:
		current_state.process_state(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_process_state(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
	
func on_take_off():
	var new_state = states.get("take_off")
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
