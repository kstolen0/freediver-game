extends ProgressBar

const MAX_BREATH = 100
var modifier = 2
var breath = MAX_BREATH / modifier
var holding = false
var sent_death_signal = false
signal out_of_breath(toggle)

# Called when the node enters the scene tree for the first time.
func _ready():	
	max_value = MAX_BREATH
	value = MAX_BREATH / 2
	size = Vector2(MAX_BREATH, 10)
	$"../../player".holding_breath.connect(toggleOxygen)
	$"../../player".recovering_breath.connect(toggleOxygen)
	$"../../player".final_breath.connect(on_final_breath)
	
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
	holding = !holding
	
func on_final_breath(state):
	if state == "begin":
		modifier = 1
	else:
		modifier = 2
	
func recoverBreath():
	if value < MAX_BREATH / modifier:
		value += 0.5
		return
		
	if modifier == 1 && value >= MAX_BREATH / modifier:
		modifier = 2
		return
	
	if value >= MAX_BREATH / modifier:
		value -= 0.5
		return
