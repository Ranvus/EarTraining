extends Node2D

@onready var sprite_node = get_node_or_null("Sprite2D")
@onready var label_node = get_node_or_null("Node2D/Label")
@onready var timer_node = get_node_or_null("Timer")

var line : int
var pos = 0
var hit = false

func _ready():
	set_line()
	
#func _physics_process(delta):
	#if hit:
		#$Node2D.position.x += 300 * delta
	
func set_line():
	var y
	match line:
		0: 
			y = -16
		1: 
			y = 16
	self.position = Vector2(pos, y)

func destroy(score):
	#$CPUParticles2D.emitting = true
	sprite_node.visible = false
	timer_node.start()
	hit = true
	if score == 3:
		label_node.text = "PERFECT"
		label_node.modulate = Color("f6d6bd")
	elif score == 2:
		label_node.text = "GOOD"
		label_node.modulate = Color("c3a38a")
	elif score == 1:
		label_node.text = "OKAY"
		label_node.modulate = Color("997577")
	#await get_tree().create_timer(50).timeout
	#queue_free()


func _on_timer_timeout():
	queue_free()
