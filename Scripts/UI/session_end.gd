extends CanvasLayer

@onready var score_node = get_node_or_null("ScoreLabel")
@onready var max_score_node = get_node_or_null("MaxScoreLabel")

var drumsession : String

func _ready():
	drumsession = "res://Scenes/Levels/drum_session_" + get_parent().name.substr(11, 1) + ".tscn"

func _process(_delta):
	if "1" in get_parent().name:
		get_parent().save_system_node.load_data(get_parent().save_system_node.SAVE_DIR + get_parent().save_system_node.SAVE_FILE_NAME)
		score_node.text = "Score: " + str(Global.drum1_score)
		max_score_node.text = "Max Score: " + str(Global.max_drum1_score)
	elif "2" in get_parent().name:
		get_parent().save_system_node.load_data(get_parent().save_system_node.SAVE_DIR + get_parent().save_system_node.SAVE_FILE_NAME)
		score_node.text = "Score: " + str(Global.drum2_score)
		max_score_node.text = "Max Score: " + str(Global.max_drum2_score)
	elif "3" in get_parent().name:
		get_parent().save_system_node.load_data(get_parent().save_system_node.SAVE_DIR + get_parent().save_system_node.SAVE_FILE_NAME)
		score_node.text = "Score: " + str(Global.drum3_score)
		max_score_node.text = "Max Score: " + str(Global.max_drum3_score)
	elif "4" in get_parent().name:
		get_parent().save_system_node.load_data(get_parent().save_system_node.SAVE_DIR + get_parent().save_system_node.SAVE_FILE_NAME)
		score_node.text = "Score: " + str(Global.drum4_score)
		max_score_node.text = "Max Score: " + str(Global.max_drum4_score)
	elif "5" in get_parent().name:
		get_parent().save_system_node.load_data(get_parent().save_system_node.SAVE_DIR + get_parent().save_system_node.SAVE_FILE_NAME)
		score_node.text = "Score: " + str(Global.drum5_score)
		max_score_node.text = "Max Score: " + str(Global.max_drum5_score)


func _on_retry_btn_pressed():
	get_tree().call_deferred("change_scene_to_file", drumsession)


func _on_quit_session_btn_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/Levels/main.tscn")
