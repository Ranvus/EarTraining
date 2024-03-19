extends Node2D

@onready var bar_tscn := preload("res://Scenes/bar.tscn")
@onready var player_tscn := preload("res://Scenes/player.tscn")
@onready var player_node = get_node("/root/DrumLesson/Player")
@onready var bars_spawner = $BarsSpawner

var bars = []
#длина такта в пикселях
var bar_len = 256
#настоящее расположение начала такта
var curr_loc
#скорость за которую нота проходит один такт
var speed
#длина доли в пикселях
var beat_scale

var is_pressed
var is_collecting
var is_colliding

var perfect
var good
var ok
var current_beat = null

var cur_bar_index
var tracks_data

var score : int = 0
var combo : int = 0
var max_combo : int = 0

#func _ready():
	#set_process(false)
	
func setup(game):
	speed = Vector2(-game.speed, 0)
	bar_len = game.bar_len
	curr_loc = Vector2(0, 0)
	beat_scale = game.beat_scale
	cur_bar_index = 0
	tracks_data = game.map.tracks
	add_bars()
		
func _process(delta):
	Global.drum_score = score
	Global.drum_combo = combo
	
	bars_spawner.translate(speed*delta)
	
	#удаляем проехавшие такты после достижения определенных координат и создаем новые
	for bar in bars:
		if -bar.position.x - bars_spawner.position.x >= bar_len*1.5 and cur_bar_index + 1 <= len(tracks_data[0].bars):
			remove_bar(bar)
			add_bar()
			
			#print(len(bars))
			

		
	
	
#func _input(event):
	#if player_node.is_drum:
		#if event.is_action_pressed("space"):
			#is_pressed = true
			#is_collecting = true
			#if perfect:
				#print("P")
				#current_beat.queue_free()
				#increment_score(3)
			#elif good:
				#print("G")
				#current_beat.queue_free()
				#increment_score(2)
			#elif ok:
				#print("O")
				#current_beat.queue_free()
				#increment_score(1)
		#elif event.is_action_released("space"):
			#is_pressed = false
			#is_collecting = false
			#
		#if event.is_action_pressed("space") and !perfect and !good and !ok:
			#increment_score(0)
	
func increment_score(by):
	if by > 0:
		combo += 1
	else:
		combo = 0
	
	#if by == 3:
		#great += 1
	#elif by == 2:
		#good += 1
	#elif by == 1:
		#okay += 1
	#else:
		#missed += 1
	
	
	score += by * combo
	if combo > 0:
		get_parent().combo_node.text = str(combo) + " combo!"
		if combo > max_combo:
			max_combo = combo
	elif combo == 0:
		get_parent().combo_node.text = " "

func add_bars():
	for i in range(3):
		add_bar()

func add_bar():
	var new_bar = bar_tscn.instantiate()
	new_bar.position = curr_loc
	new_bar.beat_scale = beat_scale
	new_bar.bar_data = get_bar_data()
	bars.append(new_bar)
	bars_spawner.add_child(new_bar)
	curr_loc += Vector2(bar_len, 0)
	cur_bar_index += 1

func get_bar_data():
	var bar_data = tracks_data[0].bars[cur_bar_index]
	return bar_data

func remove_bar(bar):
	bar.queue_free()
	bars.erase(bar)


func _on_perfect_area_entered(area):
	if area.name == "Area2D":
		is_colliding = true
		perfect = true


func _on_good_area_entered(area):
	if area.name == "Area2D":
		is_colliding = true
		good = true



func _on_ok_area_entered(area):
	if area.name == "Area2D": 
		is_colliding = true
		ok = true
		current_beat = area.get_parent()


func _on_perfect_area_exited(area):
	if area.name == "Area2D":
		is_colliding = false
		perfect = false


func _on_good_area_exited(area):
	if area.name == "Area2D":
		is_colliding = false
		good = false


func _on_ok_area_exited(area):
	if area.name == "Area2D":
		is_colliding = false
		ok = false
		current_beat = null


func _on_end_area_entered(area):
	if area.name == "Area2D":
		area.get_parent().queue_free()
		increment_score(0)
	elif area.name == "BarCollision":
		area.get_parent().get_child(0).hide()
