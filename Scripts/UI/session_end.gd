extends CanvasLayer

@onready var score_node = get_node_or_null("ScoreLabel")
@onready var max_score_node = get_node_or_null("MaxScoreLabel")
@onready var next_btn_node = get_node_or_null("NextSessionBtn")

var drum_session : String
var session_number : int

func _ready():
	session_number = int(get_parent().name.substr(11, 1))
	drum_session = "res://Scenes/Levels/drum_session_" + str(session_number) + ".tscn"
	
	if session_number < 5:
		next_btn_node.show()
	else:
		next_btn_node.hide()

func _process(_delta):
	#if "1" in get_parent().name:
		#get_parent().save_system_node.load_data(get_parent().save_system_node.SAVE_DIR + get_parent().save_system_node.SAVE_FILE_NAME)
		#score_node.text = "Score: " + str(Global.drum1_score)
		#max_score_node.text = "Max Score: " + str(Global.max_drum1_score)
	#elif "2" in get_parent().name:
		#get_parent().save_system_node.load_data(get_parent().save_system_node.SAVE_DIR + get_parent().save_system_node.SAVE_FILE_NAME)
		#score_node.text = "Score: " + str(Global.drum2_score)
		#max_score_node.text = "Max Score: " + str(Global.max_drum2_score)
	#elif "3" in get_parent().name:
		#get_parent().save_system_node.load_data(get_parent().save_system_node.SAVE_DIR + get_parent().save_system_node.SAVE_FILE_NAME)
		#score_node.text = "Score: " + str(Global.drum3_score)
		#max_score_node.text = "Max Score: " + str(Global.max_drum3_score)
	#elif "4" in get_parent().name:
		#get_parent().save_system_node.load_data(get_parent().save_system_node.SAVE_DIR + get_parent().save_system_node.SAVE_FILE_NAME)
		#score_node.text = "Score: " + str(Global.drum4_score)
		#max_score_node.text = "Max Score: " + str(Global.max_drum4_score)
	#elif "5" in get_parent().name:
		#get_parent().save_system_node.load_data(get_parent().save_system_node.SAVE_DIR + get_parent().save_system_node.SAVE_FILE_NAME)
		#score_node.text = "Score: " + str(Global.drum5_score)
		#max_score_node.text = "Max Score: " + str(Global.max_drum5_score)
		
	get_parent().save_system_node.load_data(get_parent().save_system_node.SAVE_DIR + get_parent().save_system_node.SAVE_FILE_NAME)
	var session_score = "drum" + str(session_number) + "_score"
	var max_session_score = "max_drum" + str(session_number) + "_score"
	score_node.text = "Score: " + str(Global.get(session_score))
	max_score_node.text = "Max Score: " + str(Global.get(max_session_score))


func _on_retry_btn_pressed():
	get_tree().call_deferred("change_scene_to_file", drum_session)


func _on_quit_session_btn_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/Levels/main.tscn")


func _on_next_session_btn_pressed():
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/Levels/drum_session_" + str(session_number + 1) + ".tscn")
