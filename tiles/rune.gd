extends Node2D

@onready var hexmap:TileMap = get_tree().get_first_node_in_group("Hexmap")

var loc:Vector2i
var solidified:bool = false
var shifted:bool = false

signal shift(new_loc)

func _ready():
	set_loc()

func _process(_delta):
	pass

func set_loc():
	loc = hexmap.local_to_map(transform.get_origin())

func _on_shift(new_loc):
	var tween = get_tree().create_tween()
	tween.tween_property(self,"global_position",hexmap.map_to_local(new_loc),0.1)
	tween.connect("finished",shift_finish)
	shifted = true
	
func shift_finish():
	set_loc()
	solidified = false
	var solid_hexes = get_tree().get_nodes_in_group("Solid")
	for solid_hex in solid_hexes:
		if solid_hex.loc == loc:
			solidified = true
