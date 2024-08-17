extends Node
class_name StateMachine


@export var init_state : State
var current_state : State
var states : Dictionary = {}

# Signal is mostly for debugging and keeping track of the current state in the state machine.
signal transitioned(state_name: String)

# Called when the node enters the scene tree for the first time. Loads the State nodes into the state Machine.
func _ready():
    current_state = init_state
    for child in get_children():
        if child is State:
            states[child.name.to_lower()] = child

# Calls the related physics process function of the current state.
func _process(delta: float):
    if current_state:
        current_state._update(delta)

# Calls the related physics process function of the current state.
func _physics_process(delta: float):
    if current_state:
        current_state._physics_update(delta)

# Calls when the state machine changes the state.
func change_state(state_name: String, msg: Dictionary):
    if not states.get(state_name.to_lower()):
        return
    states.get(current_state.name.to_lower()).Exit()
    current_state = states.get(state_name.to_lower())
    states[current_state.to_lower()].Enter(msg)
    emit_signal("transitioned", current_state.name.to_lower())


func _on_player_change_state(state_name: String, msg: Dictionary):
    change_state(state_name, msg)


