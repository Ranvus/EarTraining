extends Node

@onready var gameover_node = get_node_or_null("GameOver")
@onready var retrybtn_node = get_node_or_null("GameOver/RetryBtn")
@onready var player_node = get_node_or_null("Player")
@onready var teacher1 = get_node_or_null("SecondThirdTeacher")
@onready var teacher2 = get_node_or_null("FifthTeacher")
@onready var teacher3 = get_node_or_null("OctaveTeacher")
@onready var savesystem_node = get_node_or_null("SaveSystem")

var teacher

func _ready():
	new_game()
	#$GameOver/RetryBtn.pressed.connect(reset)

func _process(_delta):
	if player_node.loose:
		#await get_tree().create_timer(0.2).timeout
		#get_tree().paused = true
		teacher.can_play = false
		gameover_node.show()
		savesystem_node.save_data(savesystem_node.SAVE_DIR + savesystem_node.SAVE_FILE_NAME)

func new_game():
	if teacher1:
		teacher = teacher1
		teacher.unison_score = 0		
	elif teacher2:
		teacher = teacher2
		teacher.fifth_score = 0
	elif teacher3:
		teacher = teacher3
		teacher.octave_score = 0
	#get_tree().paused = false
	player_node.teacher.can_play = true
	gameover_node.hide()
	player_node.reset()
	savesystem_node.load_data(savesystem_node.SAVE_DIR + savesystem_node.SAVE_FILE_NAME)
