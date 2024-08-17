class_name MoveCommand
extends Command


func execute(player: Player, state: PlayerState) -> void:
    match state:
        _ when state is Idle:
          player.emit_signal("change_state", "Move",{})


        

        


    
        
