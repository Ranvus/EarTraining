extends Node2D

@export var session_number : int

@onready var interaction_area_node : InteractionArea = get_node_or_null("InteractionArea")

const FILE_BEGIN = "res://Scenes/Levels/drum_session_"

var session_path
var session_name 

func _ready():
	session_name = "Drum Session " + str(session_number)
	interaction_area_node.interact = Callable(self, "_on_interact")
	interaction_area_node.session_name = session_name
	session_path = FILE_BEGIN + str(session_number) + ".tscn"

func _on_interact():
	get_tree().call_deferred("change_scene_to_file", session_path)
