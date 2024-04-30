extends CharacterBody2D

signal healthChanged

@onready var teacher1_node = get_node_or_null("../SecondThirdTeacher")
@onready var teacher2_node = get_node_or_null("../FifthTeacher")
@onready var teacher3_node = get_node_or_null("../OctaveTeacher")
@onready var teacher4_node = get_node_or_null("../UnisonIntervalTeacher")
@onready var teacher5_node = get_node_or_null("../FifthIntervalTeacher")
@onready var teacher6_node = get_node_or_null("../OctaveIntervalTeacher")
@onready var road_node = get_node_or_null("../Road")
@onready var animation_player_node = get_node_or_null("AnimationPlayer")
@onready var sprite_node = get_node_or_null("Sprite2D")

#переменные персонажа
var speed : int = 400
var max_health : int
var cur_health : int
var loose : bool = false
var answer : String = "Blank"

#булевые переменные
var is_walk : bool = false
var is_piano : bool = false
var is_drum : bool = false
var is_pressed : bool = false

var teacher

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
		
	if teacher1_node:
		teacher = teacher1_node
	elif teacher2_node:
		teacher = teacher2_node
	elif teacher3_node:
		teacher = teacher3_node
	elif teacher4_node:
		teacher = teacher4_node
	elif teacher5_node:
		teacher = teacher5_node
	elif teacher6_node:
		teacher = teacher6_node
		
	reset()
	
func reset():
	loose = false
	max_health = 3
	cur_health = max_health

func dir_input():
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir.normalized() * speed

func note_input():
	if Input.is_action_just_pressed("space"):
		if teacher.name == "SecondThirdTeacher" or teacher.name == "UnisonIntervalTeacher":
			answer = "Unison"
		elif teacher.name == "OctaveTeacher" or teacher.name == "OctaveIntervalTeacher":
			answer = "Octave"
		teacher.right_answer()
	elif Input.is_action_just_pressed("left"):
		if teacher.name == "SecondThirdTeacher" or teacher.name == "UnisonIntervalTeacher":
			answer = "MinSecond"
		elif teacher.name == "FifthTeacher" or teacher.name == "FifthIntervalTeacher":
			answer = "Fourth"
		elif teacher.name == "OctaveTeacher" or teacher.name == "OctaveIntervalTeacher":
			answer = "MinSixth"
		teacher.right_answer()
	elif Input.is_action_just_pressed("right"):
		if teacher.name == "SecondThirdTeacher" or teacher.name == "UnisonIntervalTeacher":
			answer = "MajSecond"
		elif teacher.name == "FifthTeacher" or teacher.name == "FifthIntervalTeacher":
			answer = "Fifth"
		elif teacher.name == "OctaveTeacher" or teacher.name == "OctaveIntervalTeacher":
			answer = "MajSixth"
		teacher.right_answer()
	elif Input.is_action_just_pressed("up"):
		if teacher.name == "SecondThirdTeacher" or teacher.name == "UnisonIntervalTeacher":
			answer = "MinThird"
		elif teacher.name == "FifthTeacher" or teacher.name == "FifthIntervalTeacher":
			answer = "Tritone"
		elif teacher.name == "OctaveTeacher" or teacher.name == "OctaveIntervalTeacher":
			answer = "MinSeventh"
		teacher.right_answer()
	elif Input.is_action_just_pressed("down"):
		if teacher.name == "SecondThirdTeacher" or teacher.name == "UnisonIntervalTeacher":
			answer = "MajThird"
		elif teacher.name == "OctaveTeacher" or teacher.name == "OctaveIntervalTeacher":
			answer = "MajSeventh"
		teacher.right_answer()
		
func beat_input():
	if Input.is_action_just_pressed("left"):
		if road_node.perfect_l:
			print("P")
			road_node.increment_score(3)
			road_node.current_beat.destroy(3)
		elif road_node.good_l:
			print("G")
			road_node.increment_score(2)
			road_node.current_beat.destroy(2)
		elif road_node.ok_l:
			print("O")
			road_node.increment_score(1)
			road_node.current_beat.destroy(1)
		if !road_node.perfect_l and !road_node.good_l and !road_node.ok_l:
			road_node.increment_score(0)
	if Input.is_action_just_pressed("right"):
		if road_node.perfect_r:
			print("P")
			#road_node.current_beat.queue_free()
			road_node.increment_score(3)
			road_node.current_beat.destroy(3)
		elif road_node.good_r:
			print("G")
			#road_node.current_beat.queue_free()
			road_node.increment_score(2)
			road_node.current_beat.destroy(2)
		elif road_node.ok_r:
			print("O")
			#road_node.current_beat.queue_free()
			road_node.increment_score(1)
			road_node.current_beat.destroy(1)
		if !road_node.perfect_r and !road_node.good_r and !road_node.ok_r:
			road_node.increment_score(0)
		

func _physics_process(_delta):
	if is_walk:
		dir_input()
		move_and_slide()
	elif is_piano:
		note_input()
		die()
	elif is_drum:
		beat_input()
		
	if velocity.length() != 0:
		animation_player_node.play("Walk")
	else:
		animation_player_node.play("Idle")
		
	if velocity.x < 0:
		sprite_node.flip_h = true
	elif velocity.x > 0:
		sprite_node.flip_h = false

func penalty():
	cur_health -= 1
	healthChanged.emit(cur_health)
	print(cur_health)

func die():
	if cur_health <= 0:
		loose = true
