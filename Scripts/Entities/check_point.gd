extends Area2D

@onready var marker_2d: Marker2D = $Marker2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_body_entered(body:Node2D) -> void:
	if body is Player:
		body.spawn_location = marker_2d.global_position
