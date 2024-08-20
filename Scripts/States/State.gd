class_name State
extends Node


# Called when entering the state
func Enter(_msg: Dictionary):
    pass
# Called when exiting the state
func Exit():
    pass

# Called every frame handles non physics related updates
func _update(_delta: float):
    pass

# Called every frame handles physics related updates
func _physics_update(_delta: float):
    pass


