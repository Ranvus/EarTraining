extends Area2D

@onready var session = get_parent().get_child(3)

var speed : float
var direction : Vector2

func _ready():
	#speed = session.note_speed
	speed = 100

func _process(delta):
	position += speed * direction * delta


func _on_area_entered(area):
	if area.name == "PlayerArea":
		area.get_parent().penalty()
		area.get_parent().teacher.notes_destroy()
