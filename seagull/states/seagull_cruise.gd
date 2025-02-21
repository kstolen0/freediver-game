extends SeagullState
class_name SeagullCruise

var animation_timer : Timer
var turn_timer : Timer
var land_timer : Timer

var current_animation = "cruising"
@onready var animations = $"../../gull_animations/AnimationPlayer"

func enter():
	print("CRUISING")
	seagull.velocity = Vector2(prev_x, 0)
	setup_animation_timer()
	setup_turn_timer()
	setup_land_timer()
	
func exit():
	animation_timer.queue_free()
	turn_timer.queue_free()
	land_timer.queue_free()
	
func setup_animation_timer():
	animation_timer = Timer.new()
	animation_timer.wait_time = randi_range(5,10)
	animation_timer.timeout.connect(flap_wings)
	animation_timer.autostart = true
	add_child(animation_timer)

func setup_turn_timer():
	turn_timer = Timer.new()
	turn_timer.wait_time = randi_range(5,10)
	turn_timer.timeout.connect(turn)
	turn_timer.autostart = true
	add_child(turn_timer)

func setup_land_timer():
	land_timer = Timer.new()
	land_timer.wait_time = randi_range(10, 15)
	land_timer.timeout.connect(land)
	land_timer.autostart = true
	add_child(land_timer)
	
func land():
	transitioned.emit(self, "land")

func flap_wings():
	if current_animation == "cruising":
		current_animation = "flap"
		animation_timer.wait_time =  randi_range(5,10)
	else:
		current_animation = "cruising"
		animation_timer.wait_time = 0.4
	animations.play(current_animation)

func turn():
	turn_timer.wait_time = randi() % 6 + 5
	seagull.velocity.x = -seagull.velocity.x
	prev_x = seagull.velocity.x
	$"../../gull_animations".scale.x = -$"../../gull_animations".scale.x
