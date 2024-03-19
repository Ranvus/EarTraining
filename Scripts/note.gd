extends Area2D

var speed : int = 50
var direction : Vector2
var pistol_damage : int = 50

#@onready var C4_note = $C4
#@onready var Db4_note = $"C#4"
#@onready var D4_note = $D4
#@onready var Eb4_note = $"D#4"
#@onready var E4_note = $E4
#@onready var F4_note = $F4
#@onready var Gb4_note = $"F#4"
#@onready var G4_note = $G4
#@onready var Ab4_note = $"G#4"
#@onready var A4_note = $A4
#@onready var Bb4_note = $"A#4"
#@onready var B4_note = $B4
#@onready var C5_note = $C5

var notes = ["C4_note", "Db4_note", "D4_note", "Eb4_note", "E4_note", "F4_note",
			"Gb4_note", "G4_note", "Ab4_note", "A4_note", "Bb4_note", "B4_note", "C5_note"]
var rand_note = notes[randi() % notes.size()]
var note : Node
var note_num : int

#func _ready():
	#direction = Vector2.RIGHT.rotated(global_rotation)
	#note = get(rand_note)
	#note_num = notes.find(rand_note)
	#note.play()
	##print(notes.find(rand_note))
	#print(note)

func _process(delta):
	position += speed * direction * delta

func _on_body_entered(body):
	#print(body.name)
	if body.name == "Player":
		queue_free()
