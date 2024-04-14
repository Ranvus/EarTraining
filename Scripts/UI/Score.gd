extends Control

func _ready():
	$PianoScore.text = "Баллы за тренировку слуха: " + str(Global.total_piano_score)
	$DrumScore.text = "Баллы за тренировка ритма: " + str(Global.total_drum_score)
	$Score.text = "Всего баллов: " + str(Global.total_score)
