extends CanvasLayer

@onready var score_node = get_node_or_null("ScoreLabel")
@onready var max_score_node = get_node_or_null("MaxScoreLabel")
@onready var next_btn_node = get_node_or_null("NextSessionBtn")

var session_number

func _ready():
	session_number = int(get_parent().name.substr(12, 1))
	print(session_number)
	
	if session_number < 3:
		next_btn_node.show()
	else:
		next_btn_node.hide()

func _process(_delta):
	get_parent().save_system_node.load_data(get_parent().save_system_node.SAVE_DIR + get_parent().save_system_node.SAVE_FILE_NAME)
	var session_score = "piano" + str(session_number) + "_score"
	var max_session_score = "max_piano" + str(session_number) + "_score"
	score_node.text = "Score: " + str(Global.get(session_score))
	max_score_node.text = "Max Score: " + str(Global.get(max_session_score))


func _on_retry_btn_pressed():
	get_parent().new_game()


func _on_quit_session_btn_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/Levels/main.tscn")


func _on_next_session_btn_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/Levels/piano_session_" + str(session_number + 1) + ".tscn")
		
