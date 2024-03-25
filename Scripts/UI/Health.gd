extends Label

@onready var player = get_node_or_null("../../Player")

func _ready():
	player.healthChanged.connect(update)
	update()

func update():
	text = str(player.cur_health)
