class_name JumpCommand


# TODO Coyote Jump Implementation and Jump Buffering
func execute(player: Player, state: PlayerState) -> void:
    match state:
        _ when state is Idle or state is Move:
            player.emit_signal("change_state","AIR",{})
            