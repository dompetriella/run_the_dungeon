extends TextureRect

@export var tile_data: MapTileData;

func _ready() -> void:
	texture = tile_data.background_texture;

func _get_drag_data(at_position: Vector2) -> MapTileData:
	var preview_texture: TextureRect = TextureRect.new();
	preview_texture.texture = texture;
	preview_texture.expand_mode = 1;
	preview_texture.size = Vector2(45, 45);
	
	var control_root: Control = Control.new();
	control_root.add_child(preview_texture);
	set_drag_preview(control_root);
	
	return tile_data;
