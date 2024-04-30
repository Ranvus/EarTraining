extends Node

@onready var drumteacher_node = get_node_or_null("DrumTeacher")
@onready var road_node = get_node_or_null("Road")
@onready var score_node = get_node_or_null("DrumUI/Score")
@onready var combo_node = get_node_or_null("DrumUI/Combo")
@onready var save_system_node = get_node_or_null("SaveSystem")
@onready var session_end_node = get_node_or_null("SessionEnd")

var audio
var map
var audio_file
var map_file 

var bpm
#длина такта в пикселях
var bar_len
#длина доли в секундах
var spb
#скорость за которую нота проходит один такт
var speed
#длина доли в пикселях
var beat_scale
var start_pos_in_sec

func _ready():
	print(self.name)
	Soundtrack.stop_soundtrack()
	
	audio_file = "res://Audio/Drum Sessions/Drum Session " + self.name.substr(11, 2) + ".ogg"
	map_file = "res://Audio/Drum Sessions/Drum Session " + self.name.substr(11, 2) + ".mboy"
	
	audio = load(audio_file)
	map = load_map()
	calc_params()	
	
	drumteacher_node.setup(self)
	road_node.setup(self)
	
	session_end_node.hide()	
	save_system_node.load_data(save_system_node.SAVE_DIR + save_system_node.SAVE_FILE_NAME)

func _process(_delta):
	if get_tree().get_nodes_in_group("beats").size() == 0:
		save_system_node.save_data(save_system_node.SAVE_DIR + save_system_node.SAVE_FILE_NAME)
		session_end_node.show()

func calc_params():
	bpm = int(map.tempo)
	bar_len = 256
	spb = 60 / float(bpm)
	speed = bar_len / float(4 * spb)
	beat_scale = 0.16
	start_pos_in_sec = (float(map.start_pos)/400.0) * spb

func load_map():
	var file = FileAccess.open(map_file, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	return JSON.parse_string(content)
