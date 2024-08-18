extends CharacterBody2D

# These are values that can change based on the stats
@export var SPEED: int = 180
@export var JUMP_FORCE: int = 255
@export var GRAVITY: int = 900
@export var WEIGHT: int = 60

func _physics_process(delta):
	var direction = Input.get_axis("move_left", "move_right")
	# Horizontal movement
	if direction:
		velocity.x = direction * SPEED - (0.20 * WEIGHT)
		$AnimatedSprite2D.play("run")
	else:
		velocity.x = 0
		if is_on_floor():
			$AnimatedSprite2D.play("idle")
	
	# rotate body depending on horizontal direction
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
	elif direction == -1:
		$AnimatedSprite2D.flip_h = true
	
	# Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		if velocity.y > 0:
			$AnimatedSprite2D.play("fall")
	
	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= JUMP_FORCE - (0.1 * WEIGHT)
		$AnimatedSprite2D.play("jump")
	
	move_and_slide()
	
		
