extends CharacterBody2D

var glide = Vector2(15, 0)
var prev_x = 15
var current_animation = "cruising"
var state = "cruising"
var submerged = 0

signal on_water

func _ready():
	$timers/turn_timer.start()
	$timers/animation_timer.start()
	$timers/land_timer.start()
	connect("on_water", landed)

func landed():
	print("LANDED")
	state = "idle"
	glide.y = 0
	glide.x = 0
	$gull_animations/AnimationPlayer.play("idle")
	$timers/flight_timer.wait_time = randi() % 3 + 5
	$timers/flight_timer.start()
	
func _physics_process(delta):
	velocity = glide
	
	if ($"../player".position - position).length() < 60 :
		print("TOO CLOSE")
		for timer in $timers.get_children():
			timer.stop()
			_on_flight_timer_timeout()
	move_and_slide()

func _on_animation_timer_timeout():
	print("FLAP")
	if current_animation == "cruising":
		current_animation = "flap"
		$timers/animation_timer.wait_time = randi() % 6 + 5
	else:
		current_animation = "cruising"
		$timers/animation_timer.wait_time = 0.4
	$"gull_animations/AnimationPlayer".play(current_animation)

func _on_land_timer_timeout():
	print("LANDING")
	state = "landing"
	$timers/turn_timer.stop()
	$timers/animation_timer.stop()
	$gull_animations/AnimationPlayer.play("take-off")
	glide.y = 15
	prev_x = glide.x

func _on_flight_timer_timeout():
	print("TAKE OFF")
	state = "take_off"
	$gull_animations/AnimationPlayer.play("take-off")
	glide.y = -15
	glide.x = prev_x
	$timers/cruise_timer.wait_time = randi() % 3 + 5
	$timers/cruise_timer.start()

func _on_cruise_timer_timeout():
	print("CRUISING")
	state = "cruising"
	glide.y = 0
	$timers/animation_timer.start()
	$timers/turn_timer.start()
	$gull_animations/AnimationPlayer.play("cruising")
	$timers/land_timer.wait_time = randi() % 6 + 5
	$timers/land_timer.start()


func _on_turn_timer_timeout():
	print("TURN")
	$timers/turn_timer.wait_time = randi() % 6 + 5
	glide.x = -glide.x
	prev_x = glide.x
	$"gull_animations".scale.x = -$"gull_animations".scale.x
