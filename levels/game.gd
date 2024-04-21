extends Node2D

@onready var hexmap:TileMap = get_tree().get_first_node_in_group("Hexmap")

var hex_textures = {
	"basic" = preload("res://art/basictile.png"),
	"molten" = preload("res://art/moltentile.png"),
	"volcanic" = preload("res://art/volatile.png"),
	"solid" = preload("res://art/hex.png"),
}

func _input(_event):
	if Input.is_action_just_pressed("shift_left"):
		var selected = get_selected_tile()
		if selected!=null:
			selected.clicked.emit("left")
	if Input.is_action_just_pressed("shift_right"):
		var selected = get_selected_tile()
		if selected!=null:
			selected.clicked.emit("right")
		
func _ready():
	pass


func _process(_delta):
	pass

func get_selected_tile():
	var mouse_map_pos = hexmap.local_to_map(get_global_mouse_position())
	var all_tiles = get_tree().get_nodes_in_group("Hex")
	for tile in all_tiles:
		if tile.loc == mouse_map_pos:
			return tile
	return null

