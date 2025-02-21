extends ProgressBar

const MAX_BREATH = 50
var breath = MAX_BREATH
var holding = false
var sent_death_signal = false
signal out_of_breath(toggle)

# Called when the node enters the scene tree for the first time.
func _ready():	
	max_value = MAX_BREATH
	value = MAX_BREATH
	$"../../player".holding_breath.connect(toggleOxygen)
	$"../../player".recovering_breath.connect(toggleOxygen)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if holding:
		value -= 0.1
		if value <= 0:
			if !sent_death_signal:
				emit_signal("out_of_breath", true)
				sent_death_signal = !sent_death_signal
	else:
		if sent_death_signal:
			emit_signal("out_of_breath", false)
			sent_death_signal = !sent_death_signal
		recoverBreath()
	
func toggleOxygen():
	print("toggled")
	holding = !holding
	
func recoverBreath():
	if value < MAX_BREATH:
		value += 0.5
			
