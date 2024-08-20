extends Camera2D

@export var tilemap: TileMapLayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_anchor_mode(Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT)
	var zoom_vector = get_camera_zoom_to_tilemap()
	set_zoom(zoom_vector)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Function to determine the camera zoom based on the tilemap layer
func get_camera_zoom_to_tilemap() -> Vector2:
	var viewport_size = get_viewport().size  # [x,y]
	var tilemap_info = get_tilemap_info()
	var level_size = Vector2(tilemap_info["tile_size"].x * tilemap_info["size"].x,
							 tilemap_info["tile_size"].y * tilemap_info["size"].y)

	var viewport_aspect = viewport_size.x / viewport_size.y
	var level_aspect = float(level_size.x) / float(level_size.y)

	var new_zoom = 1.0

	if level_aspect > viewport_aspect:
		new_zoom = viewport_size.y / level_size.y
	else:
		new_zoom = viewport_size.x / level_size.x

	return Vector2(new_zoom, new_zoom)

func get_tilemap_info():
	var tile_size = tilemap.tile_set.tile_size
	
	#Used area in tilemap horizontally and vertically
	var tilemap_rect = tilemap.get_used_rect()
	
	var tilemap_size = Vector2i(
		tilemap_rect.end.x - tilemap_rect.position.x,
		tilemap_rect.end.y - tilemap_rect.position.y
	)

	return {"size": tilemap_size, "tile_size": tile_size}
