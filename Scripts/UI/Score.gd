extends Control

func _ready():
	$PianoScore.text = "ear training score: " + str(Global.total_piano_score)
	$DrumScore.text = "rhythm training score: " + str(Global.total_drum_score)
	$Score.text = "score: " + str(Global.total_score)
