extends Area2D

func _on_body_entered(body):
	print("in water")
	body.submerged = true
		
	

func _on_body_exited(body):
	print("not in water")
	body.submerged = false
