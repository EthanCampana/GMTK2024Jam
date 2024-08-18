extends TileMapLayer
class_name  DynamicTileMapLayer
@onready var timer: Timer = $Timer

# Gets Set to True when the Player has entered the Dynamic Tile.
var has_entered_dyanmic_tile : bool = false

var player : Player 
var player_pos : Vector2i
var prev_pos : Vector2i

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called when the Player has walked on a dynamic Tile.
func ActivateDynamicTile() -> void:
	self.player_pos = self.local_to_map(player.global_position)
	self.player_pos.y += 1
	self.player_pos.x +=2
	var td = self.get_cell_tile_data(player_pos)
	if td != null:
		var wl = td.get_custom_data("WeightLimit")
		if timer.is_stopped():
			if player.weight > wl and self.prev_pos == self.player_pos: 
				timer.start(1.0)
			else:
				timer.stop()
		self.prev_pos = self.player_pos
	else:
		timer.stop()

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if has_entered_dyanmic_tile:
		ActivateDynamicTile()


# If the Player is overweight for the tile, the tile will be erased.
func _on_timer_timeout() -> void:
	self.erase_cell(self.player_pos)


