extends Label

@onready var player_node = get_node_or_null("../../Player")

func _ready():
	player_node.healthChanged.connect(update)
	update()

func update():
	text = str(player_node.cur_health)
