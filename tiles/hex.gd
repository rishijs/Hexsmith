extends Node2D

@onready var hexmap:TileMap = get_tree().get_first_node_in_group("Hexmap")

enum hex_types{NORMAL,MOLTEN,VOLCANIC,SOLID}

@export var hex_type:hex_types
var origin:Vector2i
var loc:Vector2i
var neighbor_locs:Array[Vector2i]

@export_category("refs")
@export var hex:Sprite2D

func _ready():
	set_loc()
	set_neighbor_locs()
	
func _process(_delta):
	pass

func set_neighbor_locs():
	neighbor_locs = hexmap.get_surrounding_cells(loc)

func get_neighbor_loc(dir:int):
	return hexmap.get_neighbor_cell(loc,dir)

func get_neighbor(hex_loc:Vector2i):
	return null
	
func set_loc(init = true, new_loc = Vector2i(0,0)):
	if init:
		origin = hexmap.local_to_map(transform.get_origin())
		loc = origin
	else:
		loc = hexmap.local_to_map(new_loc)
	
func shift_hexes():
	for neighbor_loc in neighbor_locs:
		pass

	
