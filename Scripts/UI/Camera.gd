extends Camera2D

@onready var player = get_node_or_null("../Player")

func _process(_delta):
	position = player.position
	var x = floor(position.x / 1152) * 1152
	var y = floor(position.y / 640) * 640
	position = Vector2(x, y)
	var tween := create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position", Vector2(x, y), 0.14)
