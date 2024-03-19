extends CanvasLayer

@onready var player = get_node("/root/PianoLesson/Player")
@onready var teacher = get_node("/root/PianoLesson/SecondThirdTeacher")

var points = 0

func _process(delta):
	#print(points)
	$Label.text = str(Global.piano_score)
	$Label2.text = str(player.cur_health)
	
#func right_answer():
	#if teacher.interval_answer == player.answer:
		##print("w")
		#player.answer = "Blank"
		#points += 1
		#for i in get_tree().get_nodes_in_group("notes"):
			#i.queue_free()
	#else:
		#player.answer = "Blank"		
		#player.cur_health -= 1
		#for i in get_tree().get_nodes_in_group("notes"):
			#i.queue_free()
		#

#func _on_unison_pressed():
	#player.answer = "Unison"
	#right_answer()
#
#
#func _on_min_second_pressed():
	#player.answer = "MinSecond"
	#right_answer()
#
#
#func _on_maj_second_pressed():
	#player.answer = "MajSecond"
	#right_answer()
#
#
#func _on_min_third_pressed():
	#player.answer = "MinThird"
	#right_answer()
#
#
#func _on_maj_third_pressed():
	#player.answer = "MajThird"
	#right_answer()
