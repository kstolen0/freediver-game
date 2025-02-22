extends FishSmState
class_name FishSmCruise

var turn_timer : Timer
var time = 0
var initial_velocity = Vector2(-20,0)

@onready var animation = $"../../bw-fish-sprite/animation"
@onready var sprite = $"../../bw-fish-sprite"

# Called when the node enters the scene tree for the first time.
func enter():
	print("fish-sm CRUISING")
	fish.velocity = initial_velocity
	animation.play("cruise")	
	setup_turn_timer()
	
func setup_turn_timer():
	turn_timer = Timer.new()
	turn_timer.wait_time = randi_range(10,15)
	turn_timer.timeout.connect(turn)
	turn_timer.autostart = true
	add_child(turn_timer)

func turn():
	sprite.scale.x = -sprite.scale.x
	fish.velocity.x = initial_velocity.x * sprite.scale.x
	
func exit():
	turn_timer.queue_free()
	
func process_state(delta):
	time += delta
	var amplitude = 0.2
	var frequency = 0.5
	var y = sin(time * frequency) * amplitude
	fish.position.y = fish.position.y + y
