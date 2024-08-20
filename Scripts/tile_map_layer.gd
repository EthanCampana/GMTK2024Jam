extends TileMapLayer
class_name  DynamicTileMapLayer
@onready var timer: Timer = $Timer

# Gets Set to True when the Player has entered the Dynamic Tile.
var has_entered_dyanmic_tile : bool = false

var player_pos : Vector2i
var prev_pos : Vector2i

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# If the Player is overweight for the tile, the tile will be erased.
func _on_timer_timeout() -> void:
	self.erase_cell(self.player_pos)
