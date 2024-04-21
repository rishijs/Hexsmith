extends Node2D

@onready var hexmap:TileMap = get_tree().get_first_node_in_group("Hexmap")

var hex_textures = {
	"basic" = preload("res://art/basictile.png"),
	"molten" = preload("res://art/moltentile.png"),
	"volcanic" = preload("res://art/volatile.png"),
	"solid" = preload("res://art/hex.png"),
}

var selected_tile:Node2D

func _input(_event):
	if Input.is_action_just_pressed("shift_left"):
		shift_left()
	if Input.is_action_just_pressed("shift_right"):
		shift_right()
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
func _ready():
	pass


func _process(_delta):
	check_win_state()

func shift_left():
	var selected = get_selected_tile()
	if selected!=null:
		selected.clicked.emit("left")

func shift_right():
	var selected = get_selected_tile()
	if selected!=null:
		selected.clicked.emit("right")

func get_selected_tile():
	var mouse_map_pos = hexmap.local_to_map(get_global_mouse_position())
	var all_tiles = get_tree().get_nodes_in_group("Hex")
	for tile in all_tiles:
		if tile.loc == mouse_map_pos:
			return tile
	return null

func check_win_state():
	var runes = get_tree().get_nodes_in_group("Rune")
	var win = true
	for rune in runes:
		if rune.solidified == false:
			win = false
	if win == true and runes.size() > 0:
		get_tree().get_first_node_in_group("LevelComplete").show()
		if get_tree().get_first_node_in_group("LevelComplete").level_index == 4:
			get_tree().change_scene_to_file("res://menus/crafted.tscn")

