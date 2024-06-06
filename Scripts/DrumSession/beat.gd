extends Node2D

@onready var sprite_node = get_node_or_null("Sprite2D")
@onready var label_node = get_node_or_null("Node2D/Label")
@onready var timer_node = get_node_or_null("Timer")

var line : int
var pos = 0
var hit = false

func _ready():
	set_line()
	
	
func set_line():
	var y
	match line:
		0: 
			y = -16
		1: 
			y = 16
	self.position = Vector2(pos, y)

func destroy(score):
	sprite_node.visible = false
	timer_node.start()
	hit = true
	if score == 3:
		label_node.text = "ОТЛИЧНО"
		label_node.modulate = Color("f0a5a5")
	elif score == 2:
		label_node.text = "ХОРОШО"
		label_node.modulate = Color("ca9494")
	elif score == 1:
		label_node.text = "НЕПЛОХО"
		label_node.modulate = Color("ba8b8b")


func _on_timer_timeout():
	queue_free()
