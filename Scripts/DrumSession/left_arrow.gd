extends Node2D

@onready var road_node = get_node_or_null("../../Road")


func _on_perfect_area_entered(area):
	if area.name == "Area2D":
		road_node.perfect_l = true
		


func _on_perfect_area_exited(area):
	if area.name == "Area2D":
		road_node.perfect_l = false


func _on_good_area_entered(area):
	if area.name == "Area2D":
		road_node.good_l = true


func _on_good_area_exited(area):
	if area.name == "Area2D":
		road_node.good_l = false


func _on_ok_area_entered(area):
	if area.name == "Area2D":
		road_node.ok_l = true
		road_node.current_beat = area.get_parent()


func _on_ok_area_exited(area):
	if area.name == "Area2D":
		road_node.ok_l = false
		road_node.current_beat = null
