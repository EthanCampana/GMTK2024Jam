class_name HumanController
extends PlayerController


var state : PlayerState = null

## Gets the input direction of the player
func get_input_direction() -> float:
    self.input_dir = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    return self.input_dir

func _process(_delta):
    state = player.get_state()
    

# ? Should the Player Controller be passing any information to the other States????
func _physics_process(_delta):
    if get_input_direction():
        move_command.execute(player,state)
    if Input.is_action_just_pressed("jump"):
        jump_command.execute(player,state)
    
    
    