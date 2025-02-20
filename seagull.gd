extends CharacterBody2D

var glide = Vector2(15, 0)
var prev_x = 0
var current_animation = "cruising"
var state = "cruising"
var submerged = 0

signal on_water

func _ready():
	$turn_timer.start()
	$animation_timer.start()
	$land_timer.start()
	connect("on_water", landed)

func landed():
	print("LANDED")
	glide.y = 0
	glide.x = 0
	$gull_animations/AnimationPlayer.play("idle")
	$flight_timer.wait_time = randi() % 3 + 5
	$flight_timer.start()
	
func _physics_process(delta):
	velocity = glide
	move_and_slide()

func _on_animation_timer_timeout():
	print("FLAP")
	if current_animation == "cruising":
		current_animation = "flap"
		$animation_timer.wait_time = randi() % 6 + 5
	else:
		current_animation = "cruising"
		$animation_timer.wait_time = 0.4
	$"gull_animations/AnimationPlayer".play(current_animation)

func _on_land_timer_timeout():
	print("LANDING")
	state = "landing"
	$turn_timer.stop()
	$animation_timer.stop()
	$gull_animations/AnimationPlayer.play("take-off")
	glide.y = 15
	prev_x = glide.x

func _on_flight_timer_timeout():
	print("TAKE OFF")
	state = "take_off"
	$gull_animations/AnimationPlayer.play("take-off")
	glide.y = -15
	glide.x = prev_x
	$cruise_timer.wait_time = randi() % 3 + 5
	$cruise_timer.start()

func _on_cruise_timer_timeout():
	print("CRUISING")
	state = "cruising"
	glide.y = 0
	$animation_timer.start()
	$turn_timer.start()
	$gull_animations/AnimationPlayer.play("cruising")
	$land_timer.wait_time = randi() % 6 + 5
	$land_timer.start()


func _on_turn_timer_timeout():
	print("TURN")
	$turn_timer.wait_time = randi() % 6 + 5
	glide.x = -glide.x
	$"gull_animations".scale.x = -$"gull_animations".scale.x
