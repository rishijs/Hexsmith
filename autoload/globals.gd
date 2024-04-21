extends Node

var in_game:bool = false
var time_elapsed = 0
var time_string = "00:00"

func _ready():
	pass


func _process(_delta):
	pass

func convert_time_to_string(mins,seconds):
	var result:String
	if seconds < 10 and mins < 10:
		result = "0%d:0%d"%[mins,seconds]
	elif seconds < 10 and mins >= 10:
		result = "%d:0%d"%[mins,seconds]
	elif seconds >= 10 and mins < 10:
		result = "0%d:%d"%[mins,seconds]
	else:
		result = "%d:%d"%[mins,seconds]
	return result

func tick_time():
	time_elapsed += 1
	var mins = time_elapsed / 60
	var seconds = time_elapsed % 60
	time_string = convert_time_to_string(mins,seconds)
	
func _on_timer_timeout():
	if in_game:
		tick_time()
