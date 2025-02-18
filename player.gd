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

signal holding_breath
signal recovering_breath
var can_breath = true
var is_alive = true

var submerged = -1

func _ready():
	print("player loaded")
	add_to_group("Player")
	$"../CanvasLayer/breath".out_of_breath.connect(unalive)

func unalive(toggle):
	is_alive = !toggle

func _physics_process(delta):
	var animation_to_play = "idle"
	if submerged <= 0:
		if submerged < 0:
			velocity.y += gravity * delta * 0.8
		else:
			animation_to_play = "surface"
		if !can_breath:
			can_breath = true
			emit_signal("recovering_breath")
	elif submerged > 0:
		velocity.y -= (buoyancy - submerged) * 0.5
		if can_breath:
			can_breath = false
			emit_signal("holding_breath")
	
	if is_alive:
		animation_to_play = do_alive_things(animation_to_play)

	velocity *= Vector2(0.97,0.97)
	$"Diver-sheet/AnimationPlayer".play(animation_to_play)
	
	move_and_slide()

func do_alive_things(animation_to_play):
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
		
	var r = player_rotation * max(min(1, abs(velocity.length())), 0.15)
	if Input.is_key_pressed(KEY_L):
		if flip_flag:
			r /= 2
		heading += r
		rotate(r)
	if Input.is_key_pressed(KEY_H):
		if !flip_flag:
			r /= 2
		heading -= r
		rotate(-r)
		
	return animation_to_play

func _input(event):
	if Input.is_action_just_pressed("flip_diver"):
		$"Diver-sheet".scale.y = -$"Diver-sheet".scale.y
		flip_flag = !flip_flag
	
func apply_force(leg: Vector2):
		var force = Vector2.from_angle(heading)
		force *= leg
		leg *= Vector2(0.95,0.95)
		velocity += force * 5
		return leg
		
		
func recover_leg(leg: Vector2):
	if leg < leg_force:
		leg += Vector2(0.08, 0.08)
	return leg
