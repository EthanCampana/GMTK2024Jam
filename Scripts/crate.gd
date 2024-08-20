extends  RigidBody2D
class_name Crate

var max_weight: int = 120 
var P : Player = null
@onready var crate: AnimatedSprite2D = $Crate
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.P != null:
		print(self.P.current_weight)
		if P.current_weight > max_weight:
			crate.play("Break") 
			await crate.animation_finished
			queue_free()



