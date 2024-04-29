extends Node2D

@onready var road_node = get_node_or_null("../../Road")

func _input(event):
	if event.is_action_pressed("right"):
		$AnimatedSprite2D.play()

func _on_perfect_area_entered(area):
	if area.name == "Area2D":
		road_node.perfect_r = true


func _on_perfect_area_exited(area):
	if area.name == "Area2D":
		road_node.perfect_r = false


func _on_good_area_entered(area):
	if area.name == "Area2D":
		road_node.good_r = true


func _on_good_area_exited(area):
	if area.name == "Area2D":
		road_node.good_r = false


func _on_ok_area_entered(area):
	if area.name == "Area2D":
		road_node.ok_r = true
		road_node.current_beat = area.get_parent()

func _on_ok_area_exited(area):
	if area.name == "Area2D":
		road_node.ok_r = false
		road_node.current_beat = null
