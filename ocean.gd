extends Area2D

func _on_body_entered(body):
	print("entered ocean")
	body.submerged += 1
		
	false

func _on_body_exited(body):
	print("left ocean")
	body.submerged -= 1
