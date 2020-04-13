extends Area2D

signal hit

export (int) var SPEED
var velocity = Vector2()
var screesize

func _ready():
	hide()
	screesize = get_viewport_rect().size
	
func _process(delta):
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		$AnimatedSprite.play()
		velocity = velocity.normalized() * SPEED
	else:
		$AnimatedSprite.stop()
		
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
		$AnimatedSprite.flip_h = false
		
		
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screesize.x)
	position.y = clamp(position.y, 0, screesize.y)

func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	call_deferred("set_monitoring", false)
	
func start(pos):
	position = pos
	show()
	monitoring = true	
