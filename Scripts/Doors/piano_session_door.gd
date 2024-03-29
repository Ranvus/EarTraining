extends Node2D

@export var session_number : int
@export var session_name : String

@onready var interaction_area_node : InteractionArea = get_node_or_null("InteractionArea")

const FILE_BEGIN = "res://Scenes/Levels/piano_session_"

var is_door_opened = false
var session_path

func _ready():
	interaction_area_node.interact = Callable(self, "_on_interact")
	interaction_area_node.session_name = session_name
	session_path = FILE_BEGIN + str(session_number) + ".tscn"

func _on_interact():
	get_tree().call_deferred("change_scene_to_file", session_path)

#func _process(delta):
	#if Input.is_action_just_pressed("open"):
		#is_door_opened = true
	#if Input.is_action_just_released("open"):
		#is_door_opened = false
		

#func _input(event):
	#if event.is_action_pressed("open"):
		#is_door_opened = true
	#if event.is_action_released("open"):
		#is_door_opened = false

#func _on_area_entered(area):
	#if area.name == "PlayerArea":
		#var session_path = FILE_BEGIN + str(session_number) + ".tscn"
		#get_tree().call_deferred("change_scene_to_file", session_path)
