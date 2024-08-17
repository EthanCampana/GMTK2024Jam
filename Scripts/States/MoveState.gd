class_name Move
extends PlayerState




func Enter(msg: Dictionary):
    player.state = self

func Exit():
    pass

func _update(delta: float):
    pass

func _physics_update(delta: float):
    player.handle_state(delta)
    if player.velocity.x == 0:
        player.emit_signal("change_state","Idle",{})
    elif player.velocity.y >= 0 and not player.is_not_on_floor():
        player.emit_signal("change_state", "Air",{"fall":true})