extends CanvasLayer

@onready var health_container = get_node_or_null("HealthContainer")
@onready var player = get_node_or_null("../Player")

func _ready():
	health_container.set_max_health(player.max_health)
	
	player.healthChanged.connect(health_container.update_health)
	
func _process(_delta):
	health_container.update_health(player.cur_health)
