extends Node

var score = 0

var drum1_score = 0
var drum2_score = 0
var drum3_score = 0
var drum4_score = 0
var drum5_score = 0
var drum6_score = 0
var drum7_score = 0
var drum8_score = 0
var drum9_score = 0
var drum10_score = 0
var max_drum1_score: int
var max_drum2_score: int
var max_drum3_score: int
var max_drum4_score: int
var max_drum5_score: int
var max_drum6_score: int
var max_drum7_score: int
var max_drum8_score: int
var max_drum9_score: int
var max_drum10_score: int
var total_drum_score: int
var drum_combo = 0

var piano1_score = 0
var piano2_score = 0
var piano3_score = 0
var piano4_score = 0
var piano5_score = 0
var piano6_score = 0
var max_piano1_score : int
var max_piano2_score : int
var max_piano3_score : int
var max_piano4_score : int
var max_piano5_score : int
var max_piano6_score : int
var total_piano_score : int
var total_piano_interval_score : int

var total_score : int

var great = 0
var good = 0
var okay = 0
var missed = 0
var grade = "NA"

func _process(_delta):
	if piano1_score > max_piano1_score:
		max_piano1_score = piano1_score
	
	if piano2_score > max_piano2_score:
		max_piano2_score = piano2_score
	
	if piano3_score > max_piano3_score:
		max_piano3_score = piano3_score
		
	if piano4_score > max_piano4_score:
		max_piano4_score = piano4_score
		
	if piano5_score > max_piano5_score:
		max_piano5_score = piano5_score
		
	if piano6_score > max_piano6_score:
		max_piano6_score = piano6_score
		
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
	
	if drum6_score > max_drum6_score:
		max_drum6_score = drum6_score
		
	if drum7_score > max_drum7_score:
		max_drum7_score = drum7_score
		
	if drum8_score > max_drum8_score:
		max_drum8_score = drum8_score
		
	if drum9_score > max_drum9_score:
		max_drum9_score = drum9_score
		
	if drum10_score > max_drum10_score:
		max_drum10_score = drum10_score
		
	total_drum_score = max_drum1_score + max_drum2_score + max_drum3_score + max_drum4_score + max_drum5_score + max_drum6_score + max_drum7_score + max_drum8_score + max_drum9_score + max_drum10_score
	total_piano_score = max_piano1_score + max_piano2_score + max_piano3_score
	total_piano_interval_score = max_piano4_score + max_piano5_score + max_piano6_score
	
	total_score = total_drum_score + total_piano_score + total_piano_interval_score

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
		
