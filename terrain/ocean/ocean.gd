extends Area2D
class_name ocean

func _on_body_entered(body):
	body.emit_signal("on_water")

func _on_body_exited(body: Node2D):
	pass
