extends CharacterBody2D

@onready var spawnPoint: Vector2
@onready var spawnRot: float
@onready var dir: float
@onready var collided = false

func _ready():
	global_position = spawnPoint
	global_rotation = spawnRot
	velocity = Vector2(100, 0).rotated(dir)
	

func _physics_process(delta: float) -> void:
	
	if not is_on_floor() and not collided:
		velocity += get_gravity() * delta * 0.01
		global_rotation = velocity.angle()
	velocity *= 0.99
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("HIT")
	if body.is_in_group("player"):
		body.add_spears(1)
		queue_free()
		return
	if body.is_in_group("fish"):
		
		if velocity.length() < 20:
			print("not strong enough")
			return 
		body.queue_free()
		return
	
	velocity = Vector2.ZERO
	collided = true
	
