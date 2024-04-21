extends CanvasLayer


func _ready():
	%Time.text = "COMPLETED IN : "+Globals.time_string


func _process(_delta):
	pass


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://menus/main_menu.tscn")
