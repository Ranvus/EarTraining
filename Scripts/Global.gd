extends Node

var score = 0

var drum1_score = 0
var drum2_score = 0
var drum3_score = 0
var drum4_score = 0
var drum5_score = 0
var max_drum1_score = 0
var max_drum2_score = 0
var max_drum3_score = 0
var max_drum4_score = 0
var max_drum5_score = 0
var drum_combo = 0

var unison_score = 0
var fifth_score = 0
var octave_score = 0
var max_unison_score : int
var max_fifth_score : int
var max_octave_score : int

var great = 0
var good = 0
var okay = 0
var missed = 0
var grade = "NA"

func _process(_delta):
	if unison_score > max_unison_score:
		max_unison_score = unison_score
	
	if fifth_score > max_fifth_score:
		max_fifth_score = fifth_score
	
	if octave_score > max_octave_score:
		max_octave_score = octave_score
		
	if drum1_score > max_drum1_score:
		max_drum1_score = drum1_score
		
	if drum2_score > max_drum2_score:
		max_drum2_score = drum2_score
		
	if drum3_score > max_drum3_score:
		max_drum3_score = drum3_score
		
	if drum4_score > max_drum4_score:
		max_drum4_score = drum4_score
		
	if drum5_score > max_drum5_score:
		max_drum5_score = drum5_score

func set_score(new):
	score = new
	if score > 250000:
		grade = "A+"
	elif score > 200000:
		grade = "A"
	elif score > 150000:
		grade = "A-"
	elif score > 130000:
		grade = "B+"
	elif score > 115000:
		grade = "B"
	elif score > 100000:
		grade = "B-"
	elif score > 85000:
		grade = "C+"
	elif score > 70000:
		grade = "C"
	elif score > 55000:
		grade = "C-"
	elif score > 40000:
		grade = "D+"
	elif score > 30000:
		grade = "D"
	elif score > 20000:
		grade = "D-"
	else:
		grade = "F"
		
