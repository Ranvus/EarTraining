extends CharacterBody2D

#переменные персонажа
var speed : int = 400
var max_health : int
var cur_health : int
var alive : bool
var answer1 : String = "Blank"
var answer2 : String = "Blank"
var answer3 : String = "Blank"
var answer : String = "Blank"
@onready var teacher1 = get_node_or_null("/root/PianoLesson/SecondThirdTeacher")
@onready var teacher2 = get_node_or_null("/root/PianoLesson/FifthTeacher")
@onready var teacher3 = get_node_or_null("/root/PianoLesson/OctaveTeacher")
@onready var ui = get_node("/root/PianoLesson/UI")
@onready var road = get_node("/root/DrumLesson/Road")

var teacher

var score = 0

var screen_size : Vector2

var is_walk : bool = false
var is_piano : bool = false
var is_drum : bool = false
var is_pressed : bool = false


func _ready():
	if "Drum" in get_parent().name:
		is_walk = false
		is_piano = false
		is_drum = true
	elif "Piano" in get_parent().name:
		is_walk = false
		is_piano = true
		is_drum = false
	else:
		is_walk = true
		is_piano = false
		is_drum = false
	max_health = 3
	cur_health = max_health
	
	if teacher1:
		teacher = teacher1
	elif teacher2:
		teacher = teacher2
	elif teacher3:
		teacher = teacher3
		
	#print(teacher.name)

func dir_input():
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir.normalized() * speed

func note_input():
	if Input.is_action_just_pressed("space"):
		if teacher.name == "SecondThirdTeacher":
			answer = "Unison"
		elif teacher.name == "OctaveTeacher":
			answer = "Octave"
		#answer1 = "Unison"
		#answer3 = "Octave"
		right_answer()
	elif Input.is_action_just_pressed("left"):
		if teacher.name == "SecondThirdTeacher":
			answer = "MinSecond"
		elif teacher.name == "FifthTeacher":
			answer = "Fourth"
		elif teacher.name == "OctaveTeacher":
			answer = "MinSixth"
		#answer1 = "MinSecond"
		#answer2 = "Fourth"
		#answer3 = "MinSixth"
		right_answer()
	elif Input.is_action_just_pressed("right"):
		if teacher.name == "SecondThirdTeacher":
			answer = "MajSecond"
		elif teacher.name == "FifthTeacher":
			answer = "Fifth"
		elif teacher.name == "OctaveTeacher":
			answer = "MajSixth"
		#answer1 = "MajSecond"
		#answer2 = "Fifth"
		#answer3 = "MajSixth"
		right_answer()
	elif Input.is_action_just_pressed("up"):
		if teacher.name == "SecondThirdTeacher":
			answer = "MinThird"
		elif teacher.name == "FifthTeacher":
			answer = "Tritone"
		elif teacher.name == "OctaveTeacher":
			answer = "MinSeventh"
		#answer1 = "MinThird"
		#answer2 = "Tritone"
		#answer3 = "MinSeventh"
		right_answer()
	elif Input.is_action_just_pressed("down"):
		if teacher.name == "SecondThirdTeacher":
			answer = "MajThird"
		elif teacher.name == "OctaveTeacher":
			answer = "MajSeventh"
		#answer1 = "MajThird"
		#answer3 = "MajSeventh"
		right_answer()
		
func beat_input():
	if Input.is_action_just_pressed("space"):
		if road.perfect:
			print("P")
			road.current_beat.queue_free()
			road.increment_score(3)
		elif road.good:
			print("G")
			road.current_beat.queue_free()
			road.increment_score(2)
		elif road.ok:
			print("O")
			road.current_beat.queue_free()
			road.increment_score(1)
		if !road.perfect and !road.good and !road.ok:
			road.increment_score(0)
		

func _physics_process(delta):
	Global.piano_score = score
	if is_walk:
		dir_input()
		move_and_slide()
	elif is_piano:
		if teacher.get_tree().get_nodes_in_group("notes").size() == 2:
			note_input()
			die()
	elif is_drum:
		beat_input()
	#print(cur_health)

func die():
	if cur_health <= 0:
		queue_free()

func right_answer():
	if teacher.interval_answer == answer:
		#print("w")
		#answer = "Blank"
		score += 1
		for i in get_tree().get_nodes_in_group("notes"):
			i.queue_free()
	else:
		#answer = "Blank"
		cur_health -= 1
		for i in get_tree().get_nodes_in_group("notes"):
			i.queue_free()
