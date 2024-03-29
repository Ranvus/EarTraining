extends Node

@onready var game_over_node = get_node_or_null("GameOver")
#@onready var retrybtn_node = get_node_or_null("GameOver/RetryBtn")
@onready var player_node = get_node_or_null("Player")
@onready var teacher1_node = get_node_or_null("SecondThirdTeacher")
@onready var teacher2_node = get_node_or_null("FifthTeacher")
@onready var teacher3_node = get_node_or_null("OctaveTeacher")
@onready var save_system_node = get_node_or_null("SaveSystem")

var teacher

func _ready():
	new_game()

func _process(_delta):
	if player_node.loose:
		teacher.can_play = false
		game_over_node.show()
		save_system_node.save_data(save_system_node.SAVE_DIR + save_system_node.SAVE_FILE_NAME)

func new_game():
	if teacher1_node:
		teacher = teacher1_node
		teacher.unison_score = 0		
	elif teacher2_node:
		teacher = teacher2_node
		teacher.fifth_score = 0
	elif teacher3_node:
		teacher = teacher3_node
		teacher.octave_score = 0
	player_node.teacher.can_play = true
	game_over_node.hide()
	player_node.reset()
	save_system_node.load_data(save_system_node.SAVE_DIR + save_system_node.SAVE_FILE_NAME)
