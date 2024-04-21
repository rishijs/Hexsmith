extends Node2D

@onready var hexmap:TileMap = get_tree().get_first_node_in_group("Hexmap")

func _input(_event):
	if Input.is_action_just_pressed("shift_left"):
		if is_selected_tile():
			print(1)
	#if Input.is_action_just_pressed("shift_left"):
	#	pass
	#if Input.is_action_just_pressed("shift_left"):
	#	pass
		
func _ready():
	pass


func _process(delta):
	pass

func is_selected_tile():
	var mouse_map_pos = hexmap.local_to_map(get_global_mouse_position())
	var all_tiles = get_tree().get_nodes_in_group("Hex")
	for tile in all_tiles:
		if tile.loc == mouse_map_pos:
			return true
	return false
