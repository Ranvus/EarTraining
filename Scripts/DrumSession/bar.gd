extends Node2D

@onready var beat_tscn := preload("res://Scenes/DrumSession/beat.tscn")

var multiplier = 0
var pos : Vector2
var beat_scale
var beat_pos_x = 0
var bar_data

func _ready():
	add_beat()

		
func add_beat():
	var line = 0
	for line_data in bar_data:
		var beats_data = line_data["notes"]
		for beat_data in beats_data:
			pos = Vector2(global_position.x + multiplier, global_position.y)		
			var new_beat = beat_tscn.instantiate()
			new_beat.line = line
			new_beat.pos = float(beat_data["pos"] * beat_scale)
			new_beat.add_to_group("beats")
			add_child(new_beat)
		line += 1
