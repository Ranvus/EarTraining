extends CharacterBody2D

signal healthChanged

#переменные персонажа
var speed : int = 400
var max_health : int
var cur_health : int
var loose : bool = false


var answer : String = "Blank"
@onready var teacher1 = get_node_or_null("../SecondThirdTeacher")
@onready var teacher2 = get_node_or_null("../FifthTeacher")
@onready var teacher3 = get_node_or_null("../OctaveTeacher")
@onready var road = get_node_or_null("../Road")

var teacher

var piano_score = 0

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
	elif get_parent().name == "Main":
		is_walk = true
		is_piano = false
		is_drum = false
		
	if teacher1:
		teacher = teacher1
	elif teacher2:
		teacher = teacher2
	elif teacher3:
		teacher = teacher3
		
	reset()
	#print(teacher.name)
	
func reset():
	loose = false
	max_health = 3
	cur_health = max_health

func dir_input():
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir.normalized() * speed

func note_input():
	if Input.is_action_just_pressed("space"):
		if teacher.name == "SecondThirdTeacher":
			answer = "Unison"
		elif teacher.name == "OctaveTeacher":
			answer = "Octave"
		teacher.right_answer()
	elif Input.is_action_just_pressed("left"):
		if teacher.name == "SecondThirdTeacher":
			answer = "MinSecond"
		elif teacher.name == "FifthTeacher":
			answer = "Fourth"
		elif teacher.name == "OctaveTeacher":
			answer = "MinSixth"
		teacher.right_answer()
	elif Input.is_action_just_pressed("right"):
		if teacher.name == "SecondThirdTeacher":
			answer = "MajSecond"
		elif teacher.name == "FifthTeacher":
			answer = "Fifth"
		elif teacher.name == "OctaveTeacher":
			answer = "MajSixth"
		teacher.right_answer()
	elif Input.is_action_just_pressed("up"):
		if teacher.name == "SecondThirdTeacher":
			answer = "MinThird"
		elif teacher.name == "FifthTeacher":
			answer = "Tritone"
		elif teacher.name == "OctaveTeacher":
			answer = "MinSeventh"
		teacher.right_answer()
	elif Input.is_action_just_pressed("down"):
		if teacher.name == "SecondThirdTeacher":
			answer = "MajThird"
		elif teacher.name == "OctaveTeacher":
			answer = "MajSeventh"
		teacher.right_answer()
		
func beat_input():
	if Input.is_action_just_pressed("left"):
		if road.perfect_l:
			print("P")
			#road.current_beat.queue_free()
			road.increment_score(3)
			road.current_beat.destroy(3)
		elif road.good_l:
			print("G")
			#road.current_beat.queue_free()
			road.increment_score(2)
			road.current_beat.destroy(2)
		elif road.ok_l:
			print("O")
			#road.current_beat.queue_free()
			road.increment_score(1)
			road.current_beat.destroy(1)
		if !road.perfect_l and !road.good_l and !road.ok_l:
			road.increment_score(0)
	if Input.is_action_just_pressed("right"):
		if road.perfect_r:
			print("P")
			#road.current_beat.queue_free()
			road.increment_score(3)
			road.current_beat.destroy(3)
		elif road.good_r:
			print("G")
			#road.current_beat.queue_free()
			road.increment_score(2)
			road.current_beat.destroy(2)
		elif road.ok_r:
			print("O")
			#road.current_beat.queue_free()
			road.increment_score(1)
			road.current_beat.destroy(1)
		if !road.perfect_r and !road.good_r and !road.ok_r:
			road.increment_score(0)
		

func _physics_process(_delta):
	#Global.piano_score = piano_score
	if is_walk:
		dir_input()
		move_and_slide()
	elif is_piano:
		if teacher.get_tree().get_nodes_in_group("notes").size() == 2:
			note_input()
			die()
	elif is_drum:
		beat_input()

func die():
	if cur_health <= 0:
		loose = true

#func right_answer():
	#if teacher.interval_answer == answer:
		#piano_score += 1
		#pianoScoreChanged.emit()
		#for i in get_tree().get_nodes_in_group("notes"):
			#i.queue_free()
	#else:
		#cur_health -= 1
		#healthChanged.emit()
		#for i in get_tree().get_nodes_in_group("notes"):
			#i.queue_free()
