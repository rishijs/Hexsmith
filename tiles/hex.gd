extends Node2D

@onready var hexmap:TileMap = get_tree().get_first_node_in_group("Hexmap")
@onready var game:Node2D = get_tree().get_first_node_in_group("Game")

enum hex_types{BASIC,MOLTEN,SOLID}

@export var hex_type:hex_types
var loc:Vector2i
var neighbors:Array[Node2D]
var valid_hexes:Array[Node2D]
var has_rune:bool
var rune_ref:Node2D

signal clicked(shift)

@export_category("refs")
@export var hex:Sprite2D
@export var index_text:Label
@export var active_sprite:Sprite2D

func _ready():
	set_loc()
	
func _process(delta):
	if hex_type == hex_types.BASIC and active_sprite.visible:
		active_sprite.rotation -= delta/10

func set_neighbors():
	neighbors.clear()
	var dirs = [TileSet.CELL_NEIGHBOR_TOP_LEFT_SIDE,TileSet.CELL_NEIGHBOR_TOP_RIGHT_SIDE,
				TileSet.CELL_NEIGHBOR_RIGHT_SIDE,
				TileSet.CELL_NEIGHBOR_BOTTOM_RIGHT_SIDE,TileSet.CELL_NEIGHBOR_BOTTOM_LEFT_SIDE,
				TileSet.CELL_NEIGHBOR_LEFT_SIDE]
	var neighbor_locs = []
	
	for dir in dirs:
		var neighbor = hexmap.get_neighbor_cell(loc,dir)
		if neighbor != null:
			neighbor_locs.append(hexmap.get_neighbor_cell(loc,dir))
	
	for neighbor_loc in neighbor_locs:
		for valid_hex in valid_hexes:
			if neighbor_loc == valid_hex.loc:
				neighbors.append(valid_hex)
	
	if hex_type == hex_types.BASIC or hex_type == hex_types.MOLTEN:		
		active_sprite.show()

func label_neighbors():
	for curr_hex in valid_hexes:
		curr_hex.index_text.hide()
	for i in range(len(neighbors)):
		neighbors[i].index_text.text = str(i)
		#neighbors[i].index_text.show()
		neighbors[i].active_sprite.show()
		

func set_loc():
	loc = hexmap.local_to_map(transform.get_origin())

func set_valid_hexes():
	valid_hexes.clear()
	var all_tiles = get_tree().get_nodes_in_group("Hex")
	for tile in all_tiles:
		valid_hexes.append(tile)
	for hex in valid_hexes:
		hex.active_sprite.hide()

func check_runes():
	var runes = get_tree().get_nodes_in_group("Rune")
	for rune in runes:
		if rune.loc == loc:
			has_rune = true
			rune_ref = rune
			

func shift_hexes(dir):
	for i in range(len(neighbors)):
		neighbors[i].check_runes()
		if neighbors[i].has_rune:
			if neighbors[i].rune_ref.shifted == false:
				if dir == "left":
					if i == 0:
						neighbors[i].rune_ref.shift.emit(neighbors[len(neighbors)-1].loc)
					else:
						neighbors[i].rune_ref.shift.emit(neighbors[i-1].loc)
				elif dir == "right":
					if i == len(neighbors)-1:
						neighbors[i].rune_ref.shift.emit(neighbors[0].loc)
					else:
						neighbors[i].rune_ref.shift.emit(neighbors[i+1].loc)		
		neighbors[i].rune_ref = null
		neighbors[i].has_rune = false
	
	var runes = get_tree().get_nodes_in_group("Rune")
	for rune in runes:
		rune.shifted = false

func change_type(new_type:hex_types):
	hex_type = new_type
	hex.texture = game.hex_textures[game.hex_textures.keys()[new_type]]
	
func _on_clicked(shift):
	match hex_type:
		hex_types.MOLTEN:
			set_valid_hexes()
			set_neighbors()
			shift_hexes(shift)
			label_neighbors()
