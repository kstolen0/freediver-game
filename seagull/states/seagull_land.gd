extends SeagullState
class_name SeagullLand

@onready var animations = $"../../gull_animations/AnimationPlayer"

func enter():
	print("LANDING")
	seagull.velocity.y = 20
	animations.play("take-off")
	seagull.on_water.connect(landed)
	
func landed():
	transitioned.emit(self, "idle")
	
func exit():
	animations.stop()
	seagull.disconnect("on_water", landed)
