extends CanvasLayer


func _ready():
	pass


func _process(_delta):
	pass


func _on_continue_pressed():
	get_tree().change_scene_to_file("res://levels/puzzles/part1.tscn")
