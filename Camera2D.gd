extends Camera2D

@export var tilemap: TileMapLayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_anchor_mode(Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT)
	var zoom_vector = get_camera_zoom_to_tilemap()
	set_zoom(zoom_vector)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_camera_zoom_to_tilemap():
	var viewport_size = get_viewport().size # [x,y]
	var tilemap_info = get_tilemap_info()
	var level_size = Vector2i(tilemap_info.tile_size * tilemap_info.size)
	
	var viewport_aspect = viewport_size[0] / viewport_size[1]
	var level_aspect = float(level_size.x / level_size.y)
	
	var new_zoom = 1.0
	
	if level_aspect > viewport_aspect:
		new_zoom = float(viewport_size[1]) / level_size.y
	else:
		new_zoom = float(viewport_size[0]) / level_size.x
		
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
	
	
	
	
	
	
