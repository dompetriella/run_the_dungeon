extends Panel

@export var color: Color = Color.TRANSPARENT;
@export var index: int = 0;
var tile_data: MapTileData;

func _ready():
	#set styles
	var style:StyleBoxFlat = StyleBoxFlat.new();
	style.bg_color = color;
	style.set_border_width_all(1);
	style.set_corner_radius_all(3);
	var border_color: Color = Color.WEB_GRAY;
	style.border_color = border_color;
	self.add_theme_stylebox_override('panel', style);
	set_tile_data_to_UI(tile_data);

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if (tile_data == null && data is MapTileData):
		return true;
	return false;
	

func _drop_data(at_position: Vector2, data: Variant) -> void:
	set_tile_data_to_UI(data);
	

	
func set_tile_data_to_UI(data: MapTileData):
	%BackgroundTile/EncounterTypeIcon/IndexLabel.text = str(index);
	if (data != null):
		tile_data = data;
		tile_data.id = index;

		%BackgroundTile.texture = data.background_texture;
		var image_path: String = "res://assets/" + Enums.EncounterType.keys()[data.encounter_type] + ".png";
		%BackgroundTile/EncounterTypeIcon.texture = load(image_path);
