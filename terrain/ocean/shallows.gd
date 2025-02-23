extends ocean


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_exited.connect(on_shallows_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body):
	print(body.name, " entered shallows")
	body.depth = 0
	

func on_shallows_exited(body):
	if body.global_position.y <= global_position.y:
		body.depth = -1
	else:
		body.depth = 1
