extends CharacterBody2D


var heading = 0.0
var player_rotation = 0.03
var acceleration = Vector2(0,0)


var leg_force = Vector2(1, 1)
var left_leg = leg_force
var right_leg = leg_force

func _physics_process(delta):
	var animation_to_play = "neutral"
	if Input.is_key_pressed(KEY_F):
		left_leg = apply_force(left_leg)
		animation_to_play = "left_leg"
	else:
		left_leg = recover_leg(left_leg)
		
	if Input.is_key_pressed(KEY_P):
		right_leg = apply_force(right_leg)
		animation_to_play = "right_leg"
	else:
		right_leg = recover_leg(right_leg)
		
	var r = player_rotation * max(min(1, abs(velocity.length())), 0.2)
	if Input.is_key_pressed(KEY_L):
		heading += r
		rotate(r)
	if Input.is_key_pressed(KEY_U):
		heading -= r
		rotate(-r)
		
	velocity *= Vector2(0.95,0.95)
	
	$"Diver-sheet/AnimationPlayer".play(animation_to_play)
	move_and_slide()
	
func apply_force(leg: Vector2):
		var force = Vector2.from_angle(heading)
		force *= leg
		leg *= Vector2(0.95,0.95)
		velocity += force * 10
		return leg
		
		
func recover_leg(leg: Vector2):
	if leg < leg_force:
		leg += Vector2(0.1, 0.1)
	return leg
