extends Area2D

var speed : int = 50
var direction : Vector2

func _process(delta):
	position += speed * direction * delta

func _on_body_entered(body):
	if body.name == "Player":
		queue_free()
		body.penalty()
		body.teacher.notes_destroy()
