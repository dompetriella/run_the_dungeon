extends VBoxContainer

@export var tile_number: int = 5;
@export var map_textures: Array[Texture] = [];

var selection_tile: PackedScene = preload("res://scenes/selection_tile.tscn");

func _ready():
	var tile_number = %SelectionTileColumn.tile_number;
	for i in tile_number:
		var tile: MapTileData = MapTileData.new();
		tile.background_texture = get_random_background_texture();
		tile.encounter_type = get_encounter_type();
		var available_selection_tile = selection_tile.instantiate();
		available_selection_tile.tile_data = tile;
		add_child(available_selection_tile);

func get_random_background_texture() -> Texture:
	var random_texture: Texture = map_textures.pick_random();
	var image: Image = random_texture.get_image();
	var rng = RandomNumberGenerator.new();
	rng.randomize();
	var rotation_times: int = rng.randi_range(1,3);
	for i in rotation_times:
		image.rotate_90(CLOCKWISE);
	var rotated_texture: Texture = ImageTexture.create_from_image(image);
	return rotated_texture;
	
func get_encounter_type():
	var encounter_chance: int = randi() % 100;
	if (encounter_chance <= 30):
		return Enums.EncounterType.NONE;
	elif (encounter_chance > 30 && encounter_chance < 40 ):
		return Enums.EncounterType.TELEPORT;
	elif (encounter_chance > 40 && encounter_chance < 60 ):
		return Enums.EncounterType.PUZZLE;
	elif (encounter_chance > 60 && encounter_chance < 70 ):
		return Enums.EncounterType.TREASURE;
	else:
		return Enums.EncounterType.NONE;
