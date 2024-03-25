extends Node2D

signal drumScoreChanged

@onready var bar_tscn := preload("res://Scenes/bar.tscn")
@onready var player_tscn := preload("res://Scenes/player.tscn")
@onready var bars_spawner = $BarsSpawner

@onready var drumcombo_node = get_node_or_null("../DrumUI/DrumCombo")

var bars = []
#длина такта в пикселях
var bar_len = 256
#настоящее расположение начала такта
var curr_loc
#скорость за которую нота проходит один такт
var speed
#длина доли в пикселях
var beat_scale

var perfect
var good
var ok
var current_beat = null

var cur_bar_index
var tracks_data

var drum_score : int = 0
var drum_combo : int = 0


func setup(game):
	speed = Vector2(-game.speed, 0)
	bar_len = game.bar_len
	curr_loc = Vector2(0, 0)
	beat_scale = game.beat_scale
	cur_bar_index = 0
	tracks_data = game.map.tracks
	add_bars()
		
func _process(delta):
	#get_parent().global_drum_score = drum_score
	if "1" in get_parent().name:
		Global.drum1_score = drum_score
	elif "2" in get_parent().name:
		Global.drum2_score = drum_score
	elif "3" in get_parent().name:
		Global.drum3_score = drum_score
	elif "4" in get_parent().name:
		Global.drum4_score = drum_score
	elif "5" in get_parent().name:
		Global.drum5_score = drum_score
	Global.drum_combo = drum_combo
	
	bars_spawner.translate(speed*delta)
	
	#удаляем проехавшие такты после достижения определенных координат и создаем новые
	for bar in bars:
		if -bar.position.x - bars_spawner.position.x >= bar_len*1.5 and cur_bar_index + 1 <= len(tracks_data[0].bars):
			remove_bar(bar)
			add_bar()


func increment_score(by):
	if by > 0:
		drum_combo += 1
	else:
		drum_combo = 0

	drum_score += by * drum_combo
	drumScoreChanged.emit()
	if drum_combo > 0:
		drumcombo_node.text = str(drum_combo) + " combo!"

	elif drum_combo == 0:
		drumcombo_node.text = " "

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
	new_bar.add_to_group("bars")
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
		perfect = true


func _on_good_area_entered(area):
	if area.name == "Area2D":
		good = true



func _on_ok_area_entered(area):
	if area.name == "Area2D": 
		ok = true
		current_beat = area.get_parent()


func _on_perfect_area_exited(area):
	if area.name == "Area2D":
		perfect = false


func _on_good_area_exited(area):
	if area.name == "Area2D":
		good = false


func _on_ok_area_exited(area):
	if area.name == "Area2D":
		ok = false
		current_beat = null


func _on_end_area_entered(area):
	if area.name == "Area2D":
		area.get_parent().queue_free()
		increment_score(0)
	elif area.name == "BarCollision":
		area.get_parent().get_child(0).hide()
