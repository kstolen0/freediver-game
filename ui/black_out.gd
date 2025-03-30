extends ColorRect

@onready var player: CharacterBody2D = $player

func _ready():
	$"../breath".connect("out_of_breath", toggleBlackOut)
	
func toggleBlackOut(blacking_out):
	print("show black out ", blacking_out)
	var end_alpha = 1.0 if blacking_out else 0.0
	
	var current_color = color
	var tween = get_tree().create_tween()
	tween.tween_property(
		self,
		"color",
		Color(current_color.r, current_color.g, current_color.b, end_alpha),
		5.0
	)
