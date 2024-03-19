extends CharacterBody2D

#@export var note : PackedScene
#@export var barell : Marker2D

#@onready var animation = $AnimatedSprite2D
#@onready var fire_sfx = $AudioStreamPlayer2D
@onready var player = get_node("/root/PianoLesson/Player")
var note_scene := preload("res://Scenes/note.tscn")

var bpm : float = 100.0
var fire_rate : float
var can_shoot = true
var notes

var intervals = {0 : "Unison",
				1 : "MinSecond",
				2 : "MajSecond",
				3 : "MinThird",
				4 : "MajThird",
				5 : "Fourth",
				6 : "Triton",
				7 : "Fifth",
				8 : "MinSixth",
				9 : "MajSixth",
				10 : "MinSeventh",
				11 : "MajSeventh",
				12 : "Octave"}
var interval 

func _ready():
	fire_rate = (60 / bpm) * 4
	#print(fire_rate)

func _physics_process(delta):
	shoot()
	#calculate_interval()
	#if Input.is_action_pressed("shoot"):
		#shoot()
		#animation.play()
		#
	#look_at(get_global_mouse_position())
	#
	#var mouse = get_global_mouse_position()
	#var mouse_pos = mouse.x - global_position.x
	#if mouse_pos < 0:
		#animation.flip_v = true	
	#elif mouse_pos > 0:
		#animation.flip_v = false	

func shoot():
	notes = get_tree().get_nodes_in_group("notes")		
	#for i in notes.size():
	if can_shoot and notes.size() < 2:
		can_shoot = false
		var new_note = note_scene.instantiate()
		new_note.add_to_group("notes")
		new_note.position = global_position
		new_note.direction = (player.position - position).normalized()
		get_tree().root.call_deferred("add_child", new_note)
		await get_tree().create_timer(fire_rate).timeout
		can_shoot = true
	elif notes.size() <= 0:
		can_shoot = false
	if notes.size() == 2:
		notes[1].speed = 75
		var note1 = notes[0].note_num
		var note2 = notes[1].note_num
		interval = intervals[abs(note2 - note1)]
		print(interval)
		
#func calculate_interval():
	#if notes.size() == 2:
		#print("c")
