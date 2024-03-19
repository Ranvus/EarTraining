extends Node

@onready var conductor = $DrumTeacher/AudioStreamPlayer2D
@onready var drum_teacher = $DrumTeacher
@export var note : PackedScene
@onready var player = get_node("/root/DrumLesson/Player")
@onready var road_node = $Road
@onready var score_node = $Score
@onready var combo_node = $Combo

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

#var dist_to_target
#var speed

func _ready():
	audio = load(audio_file)
	map = load_map()
	calc_params()
	
	drum_teacher.setup(self)
	road_node.setup(self)
	#conductor.play_with_beat_offset(0)
	#dist_to_target = drum_teacher.position - player.position
	#speed = dist_to_target / 2.0

func _process(delta):
	score_node.text = str(Global.drum_score)
	#combo_node.text = str(Global.combo) + " combo!"

func calc_params():
	bpm = int(map.tempo)
	bar_len = 256
	spb = 60 / float(bpm)
	speed = bar_len / float(4 * spb)
	#beat_scale = bar_len / 4
	beat_scale = 0.16
	start_pos_in_sec = (float(map.start_pos)/400.0) * spb
	#start_pos_in_sec = 19.2
	
func load_map():
	var file = FileAccess.open(map_file, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	return JSON.parse_string(content)

#func _on_audio_stream_player_2d_beat():
	#if conductor.measure == 1:
		#shoot_note()
		#await get_tree().create_timer(conductor.spb).timeout
		#shoot_note()



func shoot_note():
	var new_note = note.instantiate()
	new_note.speed = abs(speed.y)
	new_note.position = drum_teacher.position
	new_note.direction = (player.position - drum_teacher.position).normalized()
	new_note.add_to_group("notes")
	get_tree().root.call_deferred("add_child", new_note)
