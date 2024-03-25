extends CharacterBody2D

@onready var player = $AudioStreamPlayer2D

var speed
var started
var pre_start_duration
var start_pos_in_sec

func setup(game):
	player.stream = game.audio
	speed = game.speed
	pre_start_duration = game.bar_len
	start_pos_in_sec = game.start_pos_in_sec
	started = false
	
func start():
	started = true
	player.play(start_pos_in_sec)
	
func _process(delta):
	if !started:
		pre_start_duration -= speed * delta
		if pre_start_duration <= 0:
			start()
			return
