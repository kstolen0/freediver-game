extends Node

@export var initial_state: FishSmState
var current_state: FishSmState
var states = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is FishSmState:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)
	if initial_state:
		current_state = initial_state
		current_state.enter()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_state:
		current_state.process_state(delta)
		
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_process_state(delta)

func on_child_transition(state: FishSmState, new_state_name):
	if state != current_state:
		print("wrong state [", state.name.to_lower(), "] current state is [", current_state.name.to_lower(), "]")
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("new state [", new_state_name, "] does not exist")
		return
		
	if current_state:
		current_state.exit()
		
	new_state.enter()
	current_state = new_state
