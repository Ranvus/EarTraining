extends Area2D

@export var session_number : int

const FILE_BEGIN = "res://Scenes/Levels/drum_session_"

func _on_body_entered(body):
	if body.name == "Player":
		var session_path = FILE_BEGIN + str(session_number) + ".tscn"
		#get_tree().change_scene_to_file(session_path)
		get_tree().call_deferred("change_scene_to_file", session_path)
