extends CharacterBody2D


var heading = 0.0
var player_rotation = 0.03
var acceleration = Vector2(0,0)
var buoyancy = 3


var leg_force = Vector2(1, 1)
var left_leg = leg_force
var right_leg = leg_force
var flip_flag = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


var submerged = -1

func _ready():
	print("player loaded")
	add_to_group("Player")

func _physics_process(delta):
	if submerged < 0:
		velocity.y += gravity * delta * 0.8
	elif submerged > 0:
		velocity.y -= buoyancy - submerged
	
		
	var animation_to_play = "neutral"
	if Input.is_key_pressed(KEY_A):
		left_leg = apply_force(left_leg)
		animation_to_play = "left_leg"
	else:
		left_leg = recover_leg(left_leg)
		
	if Input.is_key_pressed(KEY_D) && !Input.is_key_pressed(KEY_A):
		right_leg = apply_force(right_leg)
		animation_to_play = "right_leg"
	else:
		right_leg = recover_leg(right_leg)
		
	var r = player_rotation * max(min(1, abs(velocity.length())), 0.2)
	if Input.is_key_pressed(KEY_L):
		heading += r
		rotate(r)
	if Input.is_key_pressed(KEY_H):
		heading -= r
		rotate(-r)
	
	velocity *= Vector2(0.97,0.97)
	
	$"Diver-sheet/AnimationPlayer".play(animation_to_play)
	
	move_and_slide()
	
func _input(event):
	if Input.is_action_just_pressed("flip_diver"):
		$"Diver-sheet".scale.y = -$"Diver-sheet".scale.y
	
func apply_force(leg: Vector2):
		var force = Vector2.from_angle(heading)
		force *= leg
		leg *= Vector2(0.95,0.95)
		velocity += force * 10
		return leg
		
		
func recover_leg(leg: Vector2):
	if leg < leg_force:
		leg += Vector2(0.08, 0.08)
	return leg
