extends Node

func play_soundtrack():
	$AudioStreamPlayer.play()
	
	
func stop_soundtrack():
	$AudioStreamPlayer.volume_db = -80
	
func continue_soundtrack():
	var tween = create_tween()
	tween.tween_property($AudioStreamPlayer, "volume_db", -10, 1).set_ease(Tween.EASE_OUT)

