extends Node
var highscore=0
var is_game_started = false
const save_path="/home/seyyitgenc/.local/share/godot/app_userdata/FlappyBird/save_game.save"

func _ready():
	pass
func save_highscore():
	var save_data=File.new()
	save_data.open(save_path,File.WRITE)
	save_data.store_var(highscore)
	save_data.close()
	
func load_highscore():
	var save_data = File.new()
	if save_data.file_exists(save_path):
		save_data.open(save_path,File.READ)
		highscore = save_data.get_var()
		save_data.close()
		return highscore
