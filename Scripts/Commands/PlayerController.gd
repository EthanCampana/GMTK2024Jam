class_name PlayerController
extends Node



var player: Player
var player_state_machine: StateMachine

var move_command : MoveCommand = MoveCommand.new()
var jump_command : JumpCommand = JumpCommand.new()
var input_dir : float


func _init(p: Player ) -> void:
    self.player = p