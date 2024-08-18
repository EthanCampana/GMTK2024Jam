class_name Death 
extends PlayerState


func Enter(msg: Dictionary):
    player.state = self
    # play the death animation and make the character not visible

func Exit():
    # Make the player sprite visible again
    player.isAlive = true

func _update(delta: float):
    player.global_position = player.spawn_location


func _physics_update(delta: float):
    # Pushs this all back and make it wait till the animation is done
    player.handle_state(delta)

    if player.velocity.x != 0:
        player.emit_signal("change_state", "Move",{})
    
    if player.velocity.y >= 0 and not player.is_on_floor():
        player.emit_signal("change_state", "Air",{"fall":true})
    else: 
        player.emit_signal("change_state", "Idle",{})

    