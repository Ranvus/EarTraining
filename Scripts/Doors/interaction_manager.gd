extends Node2D

@onready var player_node = get_node_or_null("../Player")
@onready var label_node = get_node_or_null("Label")

const base_text = "[E] чтобы "

var active_areas = []
var can_interact = true

func register_area(area : InteractionArea):
	active_areas.push_back(area)
	
func unregister_area(area : InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)
	
func _process(_delta):
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		label_node.text = base_text + active_areas[0].action_name + "\n" + active_areas[0].session_name
		label_node.global_position = active_areas[0].global_position
		label_node.global_position.y -= label_node.size.x / 2
		label_node.global_position.x += 10
		label_node.show()
	else:
		label_node.hide()
	
func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player_node.distance_to(area1.global_position)
	var area2_to_player = player_node.distance_to(area2.global_position)
	return area1_to_player < area2_to_player

func _input(event):
	if event.is_action_pressed("open") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label_node.hide()
			
			await active_areas[0].interact.call()
			
			can_interact = true
