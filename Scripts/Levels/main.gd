extends Node

@onready var option_menu_node = get_node_or_null("Camera2D/OptionMenu")

var is_option_open = false

func _ready():
	Soundtrack.continue_soundtrack()
	#option_menu_node.set_visible(false)

