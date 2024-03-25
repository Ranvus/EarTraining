extends Node

@onready var conductor = $DrumTeacher/AudioStreamPlayer2D
@onready var drum_teacher = $DrumTeacher
@export var note : PackedScene
@onready var road_node = get_node_or_null("Road")
@onready var score_node = get_node_or_null("DrumUI/Score")
@onready var combo_node = get_node_or_null("DrumUI/Combo")
@onready var savesystem_node = get_node_or_null("SaveSystem")
@onready var sessionend_node = get_node_or_null("SessionEnd")

var audio
var map
var audio_file = "res://Audio/Drum Sessions/Drum Session 1.ogg"
var map_file = "res://Audio/Drum Sessions/Drum Session 1.mboy"

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
	audio = load(audio_file)
	map = load_map()
	calc_params()	
	
	drum_teacher.setup(self)
	road_node.setup(self)
	
	sessionend_node.hide()	
	savesystem_node.load_data(savesystem_node.SAVE_DIR + savesystem_node.SAVE_FILE_NAME)

func _process(_delta):
	#print(get_tree().get_nodes_in_group("beats").size())
	if get_tree().get_nodes_in_group("beats").size() == 0:
		savesystem_node.save_data(savesystem_node.SAVE_DIR + savesystem_node.SAVE_FILE_NAME)
		sessionend_node.show()

func calc_params():
	bpm = int(map.tempo)
	bar_len = 256
	spb = 60 / float(bpm)
	speed = bar_len / float(4 * spb)
	#beat_scale = bar_len / 4
	beat_scale = 0.16
	#start_pos_in_sec = (float(map.start_pos)/400.0) * spb
	start_pos_in_sec = 43.2

func load_map():
	var file = FileAccess.open(map_file, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	return JSON.parse_string(content)
