extends Node2D

signal drumScoreChanged

@onready var bar_tscn := preload("res://Scenes/DrumSession/bar.tscn")

@onready var bars_spawner_node = get_node_or_null("BarsSpawner")
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

var perfect_l
var good_l
var ok_l
var perfect_r
var good_r
var ok_r
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

func _ready():
	print(get_parent().name.substr(11, 2))

func _process(delta):
	if get_parent().name.substr(11, 2) == "1":
		Global.drum1_score = drum_score
	elif get_parent().name.substr(11, 2) == "2":
		Global.drum2_score = drum_score
	elif get_parent().name.substr(11, 2) == "3":
		Global.drum3_score = drum_score
	elif get_parent().name.substr(11, 2) == "4":
		Global.drum4_score = drum_score
	elif get_parent().name.substr(11, 2) == "5":
		Global.drum5_score = drum_score
	elif get_parent().name.substr(11, 2) == "6":
		Global.drum6_score = drum_score
	elif get_parent().name.substr(11, 2) == "7":
		Global.drum7_score = drum_score
	elif get_parent().name.substr(11, 2) == "8":
		Global.drum8_score = drum_score
	elif get_parent().name.substr(11, 2) == "9":
		Global.drum9_score = drum_score
	elif get_parent().name.substr(11, 2) == "10":
		Global.drum10_score = drum_score
	Global.drum_combo = drum_combo
	
	bars_spawner_node.translate(speed*delta)
	
	#удаляем проехавшие такты после достижения определенных координат и создаем новые
	for bar in bars:
		if -bar.position.x - bars_spawner_node.position.x >= bar_len*1.5 and cur_bar_index + 1 <= len(tracks_data[0].bars):
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
		drumcombo_node.text = str(drum_combo) + " комбо!"

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
	bars_spawner_node.add_child(new_bar)
	new_bar.add_to_group("bars")
	curr_loc += Vector2(bar_len, 0)
	cur_bar_index += 1

func get_bar_data():
	var left_data = tracks_data[0].bars[cur_bar_index]
	var right_data = tracks_data[1].bars[cur_bar_index]
	var bar_data = [left_data, right_data]
	return bar_data

func remove_bar(bar):
	bar.queue_free()
	bars.erase(bar)
	

func _on_end_area_entered(area):
	if area.name == "Area2D":
		area.get_parent().queue_free()
		increment_score(0)


func _on_end_bar_area_entered(area):
	if area.name == "BarCollision" or area.name == "Area2D":
		area.get_parent().get_child(0).hide()
