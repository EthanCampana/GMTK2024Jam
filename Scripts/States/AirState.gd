class_name Air 
extends PlayerState


"""
TODO:
	Handle logic when the player is falling in the Air State
	Coyote Jump
	Logic to know the difference from walking off a ledge and jumping
"""

func Enter(msg: Dictionary):
	player.state = self
	if !msg.get("fall"):
		player.canJump  = false
		player.velocity.y = player.jump_velocity
	else:
		pass


func Exit():
	pass
func _update(_delta: float):
	pass

func _physics_update(delta: float):
	player.handle_state(delta)
	if player.velocity.x > 0 and player.is_on_floor():
		player.emit_signal("change_state","Move",{})
	elif player.velocity.x == 0 and player.is_on_floor():
		player.emit_signal("change_state","Idle",{})

