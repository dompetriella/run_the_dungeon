extends Panel

@export var color: Color = Color.TRANSPARENT;
@export var index: int = 0;
var placement_tile_data: MapTileData;

func _ready():
	#set styles
	var style:StyleBoxFlat = StyleBoxFlat.new();
	style.bg_color = color;
	style.set_border_width_all(1);
	style.set_corner_radius_all(3);
	var border_color: Color = Color.WEB_GRAY;
	style.border_color = border_color;
	self.add_theme_stylebox_override('panel', style);
	set_tile_data_to_UI(placement_tile_data);

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if (placement_tile_data == null && data is MapTileData):
		return is_tile_available(index);
	return false;
	

func _drop_data(at_position: Vector2, data: Variant) -> void:
	set_tile_data_to_UI(data);
	GlobalGameBoard.Gameboard.filled_tiles.append(data);
	print(GlobalGameBoard.Gameboard.filled_tiles.size());
	

	
func set_tile_data_to_UI(data: MapTileData):
	%BackgroundTile/EncounterTypeIcon/IndexLabel.text = str(index);
	if (data != null):
		placement_tile_data = data;
		placement_tile_data.id = index;

		%BackgroundTile.texture = data.background_texture;
		var image_path: String = "res://assets/" + Enums.EncounterType.keys()[data.encounter_type] + ".png";
		%BackgroundTile/EncounterTypeIcon.texture = load(image_path);

func is_left_edge(index: int) -> bool:
	if (index % GlobalGameBoard.Gameboard.columns == 0):
		return true;
	return false;

func is_right_edge(index: int) -> bool:
	if ((index+1) % GlobalGameBoard.Gameboard.columns == 0):
		return true;
	return false;
		
func is_tile_available(target_index: int) -> bool:
	
	for map_tile_data: MapTileData in GlobalGameBoard.Gameboard.filled_tiles:
		#check left
		if (target_index == map_tile_data.id-1):
			return true;
		#check right
		if (target_index == map_tile_data.id+1):
			return true;
		#check top
		if (target_index == map_tile_data.id - GlobalGameBoard.Gameboard.columns):
			return true;
		#check bottom
		if (target_index == map_tile_data.id + GlobalGameBoard.Gameboard.columns):
			return true;
	return false;
