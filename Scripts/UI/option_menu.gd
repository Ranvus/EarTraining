extends Control

@onready var main_menu_node = get_node_or_null("../MainMenuContainer")
@onready var teacher1_node = get_node_or_null("../../SecondThirdTeacher")
@onready var teacher2_node = get_node_or_null("../../FifthTeacher")
@onready var teacher3_node = get_node_or_null("../../OctaveTeacher")
@onready var teacher4_node = get_node_or_null("../../UnisonIntervalTeacher")
@onready var teacher5_node = get_node_or_null("../../FifthIntervalTeacher")
@onready var teacher6_node = get_node_or_null("../../OctaveIntervalTeacher")
@onready var player_node = get_node_or_null("../../Player")
@onready var exit_btn_node = get_node_or_null("VBoxContainer/OptionsVBox/HBoxContainer/ExitBtn")


var teacher

func _ready():
	if teacher1_node:
		teacher = teacher1_node
	elif teacher2_node:
		teacher = teacher2_node
	elif teacher3_node:
		teacher = teacher3_node
	elif teacher4_node:
		teacher = teacher4_node
	elif teacher5_node:
		teacher = teacher5_node
	elif teacher6_node:
		teacher = teacher6_node
		
	if main_menu_node or get_parent().get_parent().name == "Main":
		exit_btn_node.modulate = Color(255, 255, 255, 0)
		exit_btn_node.disabled = true

func _input(event):
	if get_parent().name != "Menu":
		if event.is_action_pressed("option"):
			if !get_tree().paused:
				get_tree().paused = true			
				self.show()	
			else:
				self.hide()
				get_tree().paused = false


func _on_back_btn_pressed():
	if main_menu_node:
		main_menu_node.set_visible(true)
		self.hide()
	else:
		self.hide()
		get_tree().paused = false


func _on_exit_btn_pressed():
	self.hide()
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/Levels/main.tscn")
	get_tree().paused = false
	if teacher:
		player_node.loose = true	
		teacher.can_play = false
		teacher.notes_destroy()
