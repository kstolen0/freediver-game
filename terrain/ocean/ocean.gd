extends Area2D

func _on_body_entered(body):
	print("entered ocean")
	body.submerged += 1
	body.emit_signal("on_water")

func _on_body_exited(body):
	print("left ocean")
	print(body.position)
	body.submerged -= 1
