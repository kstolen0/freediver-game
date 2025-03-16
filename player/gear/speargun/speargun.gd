extends Area2D

@onready var spear_sprite: Sprite2D = $spear_sprite
@onready var main = get_tree().get_root().get_node("world")
@onready var spear = load("res://player/gear/spear/spear.tscn")
var ammo = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)

func fire():
	if ammo:
		ammo -= 1
		var s = spear.instantiate()
		
		s.spawnPoint = spear_sprite.global_position
		s.spawnRot = global_rotation
		s.dir = global_rotation
		
		main.add_child.call_deferred(s)
		if ammo < 1:
			spear_sprite.visible = false
			
func add_spears(amount):
	ammo += amount
	spear_sprite.visible = true
