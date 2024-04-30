extends Node

const SAVE_DIR = "user://saves/"
const SAVE_FILE_NAME = "save.json"
const SECURITY_KEY = "089654SDHDH"

func _ready():
	verify_save_directory(SAVE_DIR)

func verify_save_directory(path : String):
	DirAccess.make_dir_absolute(path)

func save_data(path : String):
	var file = FileAccess.open(path, FileAccess.WRITE)
	#var file = FileAccess.open_encrypted_with_pass(path, FileAccess.WRITE, SECURITY_KEY)	
	if file == null:
		print(FileAccess.get_open_error())
		return
		
	var data = {
		"piano_score_data" : {
			"max_piano1_score" : Global.max_piano1_score,
			"max_piano2_score" : Global.max_piano2_score,
			"max_piano3_score" : Global.max_piano3_score,
			"max_piano4_score" : Global.max_piano4_score,
			"max_piano5_score" : Global.max_piano5_score,
			"max_piano6_score" : Global.max_piano6_score,
		},
		"drum_score_data" : {
			"max_drum1_score" : Global.max_drum1_score,
			"max_drum2_score" : Global.max_drum2_score,
			"max_drum3_score" : Global.max_drum3_score,
			"max_drum4_score" : Global.max_drum4_score,
			"max_drum5_score" : Global.max_drum5_score,
			"max_drum6_score" : Global.max_drum6_score,
			"max_drum7_score" : Global.max_drum7_score,
			"max_drum8_score" : Global.max_drum8_score,
			"max_drum9_score" : Global.max_drum9_score,
			"max_drum10_score" : Global.max_drum10_score,
		},
		"total_score_data" : {
			"total_drum_score" : Global.total_drum_score,
			"total_piano_score" : Global.total_piano_score,
			"total_piano_interval_score" : Global.total_piano_interval_score,
			"total_score" : Global.total_score,
		}
	}
	
	var json_string = JSON.stringify(data, "\t") 
	file.store_string(json_string)
	file.close()
	
func load_data(path : String):
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		#var file = FileAccess.open_encrypted_with_pass(path, FileAccess.READ, SECURITY_KEY)
		if file == null:
			print(FileAccess.get_open_error())
			return
			
		var content = file.get_as_text()
		file.close()
		
		var data = JSON.parse_string(content)
		if data == null:
			printerr("Cannot parse %s as a json_string: (%s)" % [path, content])
			return
		
		Global.max_piano1_score = data.piano_score_data.max_piano1_score
		Global.max_piano2_score = data.piano_score_data.max_piano2_score
		Global.max_piano3_score = data.piano_score_data.max_piano3_score
		Global.max_piano4_score = data.piano_score_data.max_piano4_score
		Global.max_piano5_score = data.piano_score_data.max_piano5_score
		Global.max_piano6_score = data.piano_score_data.max_piano6_score
		
		Global.max_drum1_score = data.drum_score_data.max_drum1_score
		Global.max_drum2_score = data.drum_score_data.max_drum2_score
		Global.max_drum3_score = data.drum_score_data.max_drum3_score
		Global.max_drum4_score = data.drum_score_data.max_drum4_score
		Global.max_drum5_score = data.drum_score_data.max_drum5_score
		Global.max_drum6_score = data.drum_score_data.max_drum6_score
		Global.max_drum7_score = data.drum_score_data.max_drum7_score
		Global.max_drum8_score = data.drum_score_data.max_drum8_score
		Global.max_drum9_score = data.drum_score_data.max_drum9_score
		Global.max_drum10_score = data.drum_score_data.max_drum10_score
		
		Global.total_drum_score = data.total_score_data.total_drum_score
		Global.total_piano_score = data.total_score_data.total_piano_score
		Global.total_piano_interval_score = data.total_score_data.total_piano_interval_score
		Global.total_score = data.total_score_data.total_score
	else:
		printerr("Cannot open non-existent file at %s!" % [path])
