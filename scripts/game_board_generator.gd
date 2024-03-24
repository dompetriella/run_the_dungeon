extends GridContainer

var placement_tile: PackedScene = preload("res://scenes/placement_tile.tscn");

var rows = 6;
var total = columns * rows;
var starting_point: int =  total - ((columns / 2) + 1);

func _ready():
	for i in total:
		var grid_piece = placement_tile.instantiate();
		grid_piece.index = i;
		if (i == starting_point):
			var starting_tile = MapTileData.new();
			starting_tile.background_texture = load("res://assets/map_pieces/map_piece.png");
			starting_tile.encounter_type = Enums.EncounterType.NONE;
			starting_tile.id = i;
			grid_piece.tile_data = starting_tile;
		self.add_child(grid_piece);
		
