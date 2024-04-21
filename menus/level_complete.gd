extends CanvasLayer

@export var level_index = 0

var levels = [
	"res://levels/puzzles/part1.tscn",
	"res://levels/puzzles/part2.tscn",
	"res://levels/puzzles/part3.tscn",
	"res://levels/puzzles/part4.tscn"
]

func _ready():
	%completion.text = "%d PARTS LEFT" % (4-level_index)


func _process(_delta):
	pass


func _on_next_pressed():
	if level_index < 4:
		get_tree().change_scene_to_file(levels[level_index])
