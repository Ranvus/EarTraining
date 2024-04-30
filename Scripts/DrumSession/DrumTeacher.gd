extends CharacterBody2D

@onready var audio_player_node = get_node_or_null("AudioStreamPlayer2D")
@onready var animated_sprite_node = get_node_or_null("AnimatedSprite2D")

var speed
var started
var pre_start_duration
var start_pos_in_sec

func _ready():
	animated_sprite_node.play()
	var session_number = int(get_parent().name.substr(11, 2))
	print(session_number)

func setup(game):
	audio_player_node.stream = game.audio
	speed = game.speed
	pre_start_duration = game.bar_len
	start_pos_in_sec = game.start_pos_in_sec
	started = false
	
func start():
	started = true
	audio_player_node.play(start_pos_in_sec)
	
func _process(delta):
	if !started:
		pre_start_duration -= speed * delta
		if pre_start_duration <= 0:
			start()
			return
