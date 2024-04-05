extends Node

@onready var game_over_node = get_node_or_null("GameOver")
#@onready var retrybtn_node = get_node_or_null("GameOver/RetryBtn")
@onready var player_node = get_node_or_null("Player")
@onready var teacher1_node = get_node_or_null("SecondThirdTeacher")
@onready var teacher2_node = get_node_or_null("FifthTeacher")
@onready var teacher3_node = get_node_or_null("OctaveTeacher")
@onready var save_system_node = get_node_or_null("SaveSystem")

const NOTE_SPEED_MULTIPLIER : float = 1.02
const BPM_MULTIPLIER : float = 1.02

var teacher
var note_speed : float
var bpm : float = 100

func _ready():
	new_game()
	Soundtrack.stop_soundtrack()

func _process(_delta):
	if player_node.loose:
		teacher.can_play = false
		game_over_node.show()
		save_system_node.save_data(save_system_node.SAVE_DIR + save_system_node.SAVE_FILE_NAME)

func new_game():
	if teacher1_node:
		teacher = teacher1_node
		teacher.piano1_score = 0
		teacher.pianoUnisonScoreChanged.connect(increase_speed)
	elif teacher2_node:
		teacher = teacher2_node
		teacher.piano2_score = 0
		teacher.pianoFifthScoreChanged.connect(increase_speed)		
	elif teacher3_node:
		teacher = teacher3_node
		teacher.piano3_score = 0
		teacher.pianoOctaveScoreChanged.connect(increase_speed)
	player_node.teacher.can_play = true
	game_over_node.hide()
	player_node.reset()
	note_speed = 50.0
	bpm = 100.0
	save_system_node.load_data(save_system_node.SAVE_DIR + save_system_node.SAVE_FILE_NAME)

func increase_speed():
	note_speed *= NOTE_SPEED_MULTIPLIER
	bpm *= BPM_MULTIPLIER
