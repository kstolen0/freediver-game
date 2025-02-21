extends SeagullState
class_name SeagullIdle

var take_off_timer : Timer

func enter():
	print("LANDED")
	seagull.velocity = Vector2.ZERO
	$"../../gull_animations/AnimationPlayer".play("idle")
	setup_take_off_timer()
	
func setup_take_off_timer():
	take_off_timer = Timer.new()
	take_off_timer.wait_time = randi_range(5, 10)
	take_off_timer.timeout.connect(take_off)
	take_off_timer.autostart = true
	add_child(take_off_timer)

func take_off():
	transitioned.emit(self, "take_off")
	
func exit():
	take_off_timer.queue_free()
