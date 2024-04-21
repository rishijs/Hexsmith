extends CanvasLayer

@onready var game = get_tree().get_first_node_in_group("Game")
@onready var complete_ref = get_tree().get_first_node_in_group("LevelComplete")

var hints = [
	"Click the yellow hexagons to rotate a small hexagon rune around it",
	"If multiple runes are around the same rotator hexagon, they will all move",
	"Keep it simple, follow a pattern, just use the rotator hexagons in the middle",
	"This may be challenging, but stick to what you have learned"
]

func _ready():
	pass


func _process(_delta):
	if game.selected_tile != null:
		%right.show()
		%left.show()
	else:
		%right.hide()
		%left.hide()
			
	%timer.text = Globals.time_string


func _on_right_pressed():
	if game.selected_tile != null:
		game.selected_tile.clicked.emit("right")


func _on_left_pressed():
	if %left.visible and game.selected_tile != null:
		game.selected_tile.clicked.emit("left")


func _on_hint_pressed():
	var level_index = complete_ref.level_index-1
	%Hint.text = hints[level_index]
	%HintContainer.show()
	await get_tree().create_timer(7,false).timeout
	%HintContainer.hide()


func _on_restart_pressed():
	get_tree().reload_current_scene()
