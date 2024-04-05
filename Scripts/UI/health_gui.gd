extends Panel

@onready var sprite_node = get_node_or_null("Sprite2D")

func update(whole : bool):
	if whole : sprite_node.frame = 0
	else : sprite_node.frame = 1
