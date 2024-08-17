class_name Player
extends CharacterBody2D

## Player Controller Following the Command Pattern
var _controller : PlayerController
@onready var _controller_container : Node = $ControllerContainer

## Declares the maximum jump height for the player and also the time it takes to reach the peak of the jump and back to the ground again.
@export var jump_height: float = 48
@export var jump_time_to_peak: float = 0.5
@export var jump_time_to_descent: float = 0.4

## Calculate the jump velocity and gravity based on the jump height and time to peak.
## Gravity is detirmined by the jump height and time to peak.
@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak)* -1
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0
@onready var variable_jump_gravity: float = ((jump_velocity ** 2) / (2 * jump_height)) * -1

## Self explanatory 
var canJump = true
@export var acceleration: float = 1000
@export var speed : float = 100
@export var state : PlayerState = null

func get_state()-> PlayerState:
	return state

## Signal that when called will change the state of the player.
signal change_state(state_name: String, msg: Dictionary)


## Determines which gravity to use
func get_gravity()-> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

## Applies the gravity to the player's y velocity
func apply_gravity(delta: float):
	velocity.y += get_gravity() * delta

## Handles the player's velocity x movement
func handle_movement():
	velocity.x = speed * _controller.input_dir

## Handles the physic process of the player depending on what state they are in
func handle_state(delta:float):
	apply_gravity(delta)

	# Ok this is an interesting one, in Gdscript currently there is no way to match on classes
	# This is  work around that will allow us to match on the state by class
	# Generally this looks cleanier than a bunch of if statements.
	match self.state:
		_ when self.state is Move or self.state is Air or self.state is Idle :
			handle_movement()
	move_and_slide()

## Handles setting the current PlayerController for the Player
func set_controller(controller: PlayerController)-> void:
	for child in _controller_container.get_children():
		child.queue_free()
	_controller = controller
	_controller_container.add_child(controller)

# Ready the controller
func _ready():
	set_controller(HumanController.new(self))