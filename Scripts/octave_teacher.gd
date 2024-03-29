extends CharacterBody2D

signal pianoOctaveScoreChanged

@export var note : PackedScene

@onready var player_node = get_node_or_null("../Player")
@onready var animated_sprite_node = get_node_or_null("AnimatedSprite2D")

var bpm : float = 100.0
var fire_rate : float
var can_play = true

var octave_score = 0

@onready var C3_note = $Notes/C3
@onready var Db3_note = $Notes/Db3
@onready var D3_note = $Notes/D3
@onready var Eb3_note = $Notes/Eb3
@onready var E3_note = $Notes/E3
@onready var F3_note = $Notes/F3
@onready var Gb3_note = $Notes/Gb3
@onready var G3_note = $Notes/G3
@onready var Ab3_note = $Notes/Ab3
@onready var A3_note = $Notes/A3
@onready var Bb3_note = $Notes/Bb3
@onready var B3_note = $Notes/B3
@onready var C4_note = $Notes/C4
@onready var Db4_note = $Notes/Db4
@onready var D4_note = $Notes/D4
@onready var Eb4_note = $Notes/Eb4
@onready var E4_note = $Notes/E4
@onready var F4_note = $Notes/F4
@onready var Gb4_note = $Notes/Gb4
@onready var G4_note = $Notes/G4
@onready var Ab4_note = $Notes/Ab4
@onready var A4_note = $Notes/A4
@onready var Bb4_note = $Notes/Bb4
@onready var B4_note = $Notes/B4
@onready var C5_note = $Notes/C5
@onready var Db5_note = $Notes/Db5
@onready var D5_note = $Notes/D5
@onready var Eb5_note = $Notes/Eb5
@onready var E5_note = $Notes/E5
@onready var F5_note = $Notes/F5 
@onready var Gb5_note = $Notes/Gb5
@onready var G5_note = $Notes/G5
@onready var Ab5_note = $Notes/Ab5
@onready var A5_note = $Notes/A5
@onready var Bb5_note = $Notes/Bb5
@onready var B5_note = $Notes/B5
@onready var notes = ["C3_note", "Db3_note", "D3_note", "Eb3_note", "E3_note", "F3_note",
					"Gb3_note", "G3_note", "Ab3_note", "A3_note", "Bb3_note", "B3_note",
					"C4_note", "Db4_note", "D4_note", "Eb4_note", "E4_note", "F4_note",
					"Gb4_note", "G4_note", "Ab4_note", "A4_note", "Bb4_note", "B4_note", 
					"C5_note", "Db5_note", "D5_note", "Eb5_note", "E5_note", "F5_note",
					"Gb5_note", "G5_note", "Ab5_note", "A5_note", "Bb5_note", "B5_note"]

var note_group
var rand_note
var note_array : Array

var intervals = {12 : "Octave",
				8 : "MinSixth",
				9 : "MajSixth",
				10 : "MinSeventh",
				11 : "MajSeventh"}
var interval 
var interval_answer : String

func _ready():
	fire_rate = (60 / bpm) * 2
	animated_sprite_node.play()
	
func _process(_delta):
	Global.octave_score = octave_score
	
	play_note()

func play_note():
	note_group = get_tree().get_nodes_in_group("notes")
	if can_play and note_group.size() == 0:
		can_play = false
		for i in range(2):
			if i == 0:
				rand_note = notes[randi() % notes.size()]
			else:
				if notes.find(note_array[i-1])+12 < notes.size():
					rand_note = notes[randi_range(notes.find(note_array[i-1])+8, notes.find(note_array[i-1])+12)]
				else:
					rand_note = notes[randi_range(notes.find(note_array[i-1])-8, notes.find(note_array[i-1])-12)]
			note_array.append(rand_note)
			var notee = get(rand_note)
			#print(notee)
			notee.play()
			shoot_note()
			if i == 0:
				await get_tree().create_timer(fire_rate).timeout
		can_play = true
		calculate_interval(notes.find(note_array[0]), notes.find(note_array[1]))
		note_array.clear()

func shoot_note():
	var new_note = note.instantiate()
	new_note.position = global_position
	new_note.direction = (player_node.position - position).normalized()
	new_note.add_to_group("notes")
	get_tree().root.call_deferred("add_child", new_note)
	
func calculate_interval(note1, note2):
	interval = abs(note1 - note2)
	interval_answer = intervals[interval]
	print(interval_answer)


func right_answer():
	if interval_answer == player_node.answer:
		octave_score += 1
		pianoOctaveScoreChanged.emit()
		for i in get_tree().get_nodes_in_group("notes"):
			i.queue_free()
	else:
		player_node.cur_health -= 1
		player_node.healthChanged.emit(player_node.cur_health)
		for i in get_tree().get_nodes_in_group("notes"):
			i.queue_free()
