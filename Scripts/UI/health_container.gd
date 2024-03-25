extends HBoxContainer

@onready var health_gui_tscn := preload("res://Scenes/UI/health_gui.tscn")

func set_max_health(max_health : int):
	for i in range(max_health):
		var health = health_gui_tscn.instantiate()
		add_child(health)

func update_health(current_health : int):
	var health = get_children()
	
	for i in range(current_health):
		health[i].update(true)
		
	for i in range(current_health, health.size()):
		health[i].update(false)
