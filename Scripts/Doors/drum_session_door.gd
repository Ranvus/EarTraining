extends Node2D

@export var session_number : int

@onready var interaction_area_node : InteractionArea = get_node_or_null("InteractionArea")
@onready var label_node = get_node_or_null("Label")
@onready var save_system_node = get_node_or_null("../../SaveSystem")

const FILE_BEGIN = "res://Scenes/Levels/drum_session_"

var session_path
var session_name 

func _ready():
	save_system_node.load_data(save_system_node.SAVE_DIR + save_system_node.SAVE_FILE_NAME)
	
	session_name = "Drum Session " + str(session_number)
	interaction_area_node.interact = Callable(self, "_on_interact")
	interaction_area_node.session_name = session_name
	session_path = FILE_BEGIN + str(session_number) + ".tscn"
	
	label_node.global_position.y -= 20
	label_node.global_position.x -= label_node.size.x / 3
	var max_score = "max_drum" + str(session_number) + "_score"
	label_node.text = "Max Score: " + str(Global.get(max_score))

func _on_interact():
	get_tree().call_deferred("change_scene_to_file", session_path)
