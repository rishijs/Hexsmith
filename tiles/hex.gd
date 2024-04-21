extends Node2D

@onready var hexmap:TileMap = get_tree().get_first_node_in_group("Hexmap")
@onready var game:Node2D = get_tree().get_first_node_in_group("Game")

enum hex_types{BASIC,MOLTEN,VOLCANIC,SOLID}

@export var hex_type:hex_types
var original_hex_type = hex_type
var loc:Vector2i
var neighbors:Array[Node2D]
var valid_hexes:Array[Node2D]

signal clicked(shift)

@export_category("refs")
@export var hex:Sprite2D
@export var index_text:Label

func _ready():
	set_loc()
	
func _process(_delta):
	pass

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

func label_neighbors():
	for hex in valid_hexes:
		hex.index_text.hide()
	for i in range(len(neighbors)):
		neighbors[i].index_text.text = str(i)
		neighbors[i].index_text.show()

func set_loc():
	loc = hexmap.local_to_map(transform.get_origin())

func set_valid_hexes():
	valid_hexes.clear()
	var all_tiles = get_tree().get_nodes_in_group("Hex")
	for tile in all_tiles:
		valid_hexes.append(tile)

func shift_hexes(dir):
	if dir == "left":
		for i in range(len(neighbors)):
			if neighbors[i].hex_type == hex_types.VOLCANIC:
				if i == len(neighbors) - 1:
					neighbors[i].change_type(neighbors[i].original_hex_type)
					neighbors[0].change_type(hex_types.VOLCANIC)
					var temp = neighbors[i]
					neighbors[i] = neighbors[0]
					neighbors[0] = temp
				else:
					neighbors[i].change_type(neighbors[i].original_hex_type)
					neighbors[i+1].change_type(hex_types.VOLCANIC)
					var temp = neighbors[i]
					neighbors[i] = neighbors[i+1]
					neighbors[i+1] = temp
	elif dir == "right":
		for i in range(len(neighbors)):
			if neighbors[i].hex_type == hex_types.VOLCANIC:
				if i == 0:
					neighbors[0].change_type(neighbors[i].original_hex_type)
					neighbors[len(neighbors)-1].change_type(hex_types.VOLCANIC)
					var temp = neighbors[0]
					neighbors[0] = neighbors[len(neighbors)-1]
					neighbors[len(neighbors)-1] = temp
				else:
					neighbors[i].change_type(neighbors[i].original_hex_type)
					neighbors[i-1].change_type(hex_types.VOLCANIC)
					var temp = neighbors[i]
					neighbors[i] = neighbors[i-1]
					neighbors[i-1] = temp

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
