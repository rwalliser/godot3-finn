extends RigidBody2D

export (int) var MIN_SPEED
export (int) var MAX_SPEED

var mob_type = ["fliegen", "gehen", "schwimmen"]

func _ready():
	$AnimatedSprite.animation = mob_type[randi() % mob_type.size()]	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()