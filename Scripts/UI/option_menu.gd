extends Control

@onready var main_menu = get_node_or_null("../MainMenuContainer")


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
	if main_menu:
		main_menu.set_visible(true)
		self.hide()
	else:
		self.hide()
		get_tree().paused = false
		
