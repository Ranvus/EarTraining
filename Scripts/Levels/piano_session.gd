extends Node

@onready var game_over_node = get_node_or_null("GameOver")
@onready var player_node = get_node_or_null("Player")
@onready var teacher1_node = get_node_or_null("SecondThirdTeacher")
@onready var teacher2_node = get_node_or_null("FifthTeacher")
@onready var teacher3_node = get_node_or_null("OctaveTeacher")
@onready var teacher4_node = get_node_or_null("UnisonIntervalTeacher")
@onready var teacher5_node = get_node_or_null("FifthIntervalTeacher")
@onready var teacher6_node = get_node_or_null("OctaveIntervalTeacher")
@onready var piano_tutorial_node = get_node_or_null("PianoTutorial")
@onready var save_system_node = get_node_or_null("SaveSystem")


const NOTE_SPEED_MULTIPLIER : float = 1.02
const BPM_MULTIPLIER : float = 1.02

var teacher
var note_speed : float
var bpm : float = 100
var is_showed = true

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
	elif teacher4_node:
		teacher = teacher4_node
		teacher.piano4_score = 0
		teacher.pianoUnisonIntervalScoreChanged.connect(increase_speed)
	elif teacher5_node:
		teacher = teacher5_node
		teacher.piano5_score = 0
		teacher.pianoFifthIntervalScoreChanged.connect(increase_speed)
	elif teacher6_node:
		teacher = teacher6_node
		teacher.piano6_score = 0
		teacher.pianoOctaveIntervalScoreChanged.connect(increase_speed)
	player_node.teacher.can_play = true
	game_over_node.hide()
	player_node.reset()
	note_speed = 50.0
	bpm = 100.0
	save_system_node.load_data(save_system_node.SAVE_DIR + save_system_node.SAVE_FILE_NAME)

func _input(event):
	if piano_tutorial_node:
		if event.is_action_pressed("show_tutorial") and !is_showed:
			piano_tutorial_node.show()
			is_showed = true
		elif event.is_action_pressed("show_tutorial") and is_showed:
			piano_tutorial_node.hide()
			is_showed = false
		

func increase_speed():
	note_speed *= NOTE_SPEED_MULTIPLIER
	bpm *= BPM_MULTIPLIER
