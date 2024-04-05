extends Control


func _ready():
	Soundtrack.play_soundtrack()

func _on_train_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/main.tscn")


func _on_options_pressed():
	$MainMenuContainer.set_visible(false)
	$OptionMenu.set_visible(true)


func _on_quit_pressed():
	get_tree().quit()
