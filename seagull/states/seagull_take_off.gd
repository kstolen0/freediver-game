extends SeagullState
class_name SeagullTakeOff

var cruise_timer : Timer
@onready var animations = $"../../gull_animations/AnimationPlayer"

func enter():
	print("TAKING OFF")
	seagull.velocity.y = -20
	seagull.velocity.x = prev_x
	animations.play("take-off")
	setup_cruise_timer()
	
func setup_cruise_timer():
	cruise_timer = Timer.new()
	cruise_timer.wait_time = randi_range(3,10)
	cruise_timer.timeout.connect(cruise)
	cruise_timer.autostart = true
	add_child(cruise_timer)
	
func cruise():
	transitioned.emit(self, "cruise")
	
func exit():
	cruise_timer.queue_free()
