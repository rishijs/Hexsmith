extends CanvasLayer


func _ready():
	pass


func _process(_delta):
	pass


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")
