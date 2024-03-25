extends CanvasLayer

@onready var score_node = get_node_or_null("ScoreLabel")
@onready var max_score_node = get_node_or_null("MaxScoreLabel")

func _process(_delta):
	if "1" in get_parent().name:
		get_parent().savesystem_node.load_data(get_parent().savesystem_node.SAVE_DIR + get_parent().savesystem_node.SAVE_FILE_NAME)
		score_node.text = "Score: " + str(Global.unison_score)
		max_score_node.text = "Max Score: " + str(Global.max_unison_score)
	elif "2" in get_parent().name:
		get_parent().savesystem_node.load_data(get_parent().savesystem_node.SAVE_DIR + get_parent().savesystem_node.SAVE_FILE_NAME)
		score_node.text = "Score: " + str(Global.fifth_score)
		max_score_node.text = "Max Score: " + str(Global.max_fifth_score)
	elif "3" in get_parent().name:
		get_parent().savesystem_node.load_data(get_parent().savesystem_node.SAVE_DIR + get_parent().savesystem_node.SAVE_FILE_NAME)
		score_node.text = "Score: " + str(Global.octave_score)
		max_score_node.text = "Max Score: " + str(Global.max_octave_score)


func _on_retry_btn_pressed():
	get_parent().new_game()


func _on_quit_session_btn_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/Levels/main.tscn")
	#get_tree().paused = false
