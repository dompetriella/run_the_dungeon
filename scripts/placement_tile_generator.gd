extends GridContainer

var placement_tile: PackedScene = preload("res://scenes/placement_tile.tscn");

var rows: int = 6;
var total = columns * rows;
var starting_point: int =  total - ((columns / 2) + 1);

func _ready():
	#initialize the map gameboard
	
	var gameboard_init = GameBoardData.new();
	gameboard_init.rows = rows;
	gameboard_init.total_tiles = total;
	gameboard_init.columns = columns;
	
	
	for i in total:
		var grid_piece = placement_tile.instantiate();
		grid_piece.index = i;
		if (i == starting_point):
			var starting_tile = MapTileData.new();
			starting_tile.background_texture = load("res://assets/map_pieces/map_piece.png");
			starting_tile.encounter_type = Enums.EncounterType.NONE;
			starting_tile.id = i;
			grid_piece.placement_tile_data = starting_tile;
			gameboard_init.filled_tiles.append(starting_tile);
		self.add_child(grid_piece);
		
	GlobalGameBoard.Gameboard = gameboard_init;
		
