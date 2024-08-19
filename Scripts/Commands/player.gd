extends CharacterBody2D

enum Stats {SPEED = 0, JUMP = 1, WEIGHT = 2}
# These are values that can change based on the stats
@export var speed_multiplier: int = 0
@export var jump_force_multiplier: int = 0
@export var weight_multiplier: int = 0
@export var current_stat: Stats = Stats.SPEED
@export var TOTAL_POINTS: int = 4

var BASE_SPEED: int = 180
var BASE_JUMP_FORCE: int = 255
var BASE_GRAVITY: int = 900
var BASE_WEIGHT: int = 60
var STAT_COUNT: int = len(Stats)

func _physics_process(delta):
	""" Handles all the input functionalities and physics """
	# Horizontal movement
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * BASE_SPEED
		if is_on_floor():
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
		velocity.y += BASE_GRAVITY * delta
		if velocity.y > 0:
			$AnimatedSprite2D.play("fall")
	
	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= BASE_JUMP_FORCE - (0.1 * BASE_WEIGHT)
		$AnimatedSprite2D.play("jump")
		
	# Scroll through the stats
	if Input.is_action_just_pressed("stat_up"):
		set_stat_to_change(-1)
	elif Input.is_action_just_pressed("stat_down"):
		set_stat_to_change(1)
		
	# increase or decrease stat
	if Input.is_action_just_pressed("decrease"):
		change_stat_value(-1)
	elif Input.is_action_just_pressed("increase"):
		change_stat_value(1)
	move_and_slide()

func set_stat_to_change(vertical_direction: int) -> void:
	""" Changes the currently selected stat """
	var previous: int = current_stat
	var normalized_index = (current_stat + vertical_direction) % STAT_COUNT

	if normalized_index < 0:
		normalized_index += STAT_COUNT
	
	current_stat = normalized_index
	UiController.emit_signal("stat_selection_changed",current_stat)

func get_total_points_allocated() -> int:
	""" Gets total points currently allocated """
	return speed_multiplier + jump_force_multiplier + weight_multiplier

func can_increase_stat(stat_value: int) -> bool:
	""" Determines whether the stat could be increased """
	return get_total_points_allocated() < TOTAL_POINTS and stat_value < TOTAL_POINTS
	
func can_decrease_stat(stat_value: int) -> bool:
	""" Determines whether the stat could be decreased """
	return stat_value > 0
	
func change_stat_value(change: int) -> void:
	""" Changes the value of the stat if it meets the right conditions. 
	
	Must follow these principles:
		1) a stat cannot be negative
		2) a stat cannot exceed total points
		3) the sum of all stats cannot exceed total points
	"""
	var change_func: Callable = can_increase_stat if change == 1 else can_decrease_stat
	if current_stat == Stats.SPEED and change_func.call(speed_multiplier):
		speed_multiplier += change
		UiController.emit_signal("stat_changed", Stats.SPEED, speed_multiplier)
	elif current_stat == Stats.JUMP and change_func.call(jump_force_multiplier):
		jump_force_multiplier += change
		UiController.emit_signal("stat_changed", Stats.JUMP, jump_force_multiplier)
	elif current_stat == Stats.WEIGHT and change_func.call(weight_multiplier):
		weight_multiplier += change
		UiController.emit_signal("stat_changed", Stats.WEIGHT, weight_multiplier)
