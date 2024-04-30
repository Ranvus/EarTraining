extends Control

func _ready():
	$PianoScore.text = "Баллы за тренировку \nотносительного слуха: " + str(Global.total_piano_score)
	$PianoIntervalScore.text = "Баллы за тренировку \nинтервального слуха: " + str(Global.total_piano_interval_score)
	$DrumScore.text = "Баллы за тренировку ритма: " + str(Global.total_drum_score)
	$DrumScore2.text = "Баллы за тренировку ритма: " + str(Global.total_drum_score)
	$Score.text = "Всего баллов: " + str(Global.total_score)
