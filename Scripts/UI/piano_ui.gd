extends CanvasLayer

@onready var health_container_node = get_node_or_null("HealthContainer")
@onready var player_node = get_node_or_null("../Player")

func _ready():
	health_container_node.set_max_health(player_node.max_health)
	
	player_node.healthChanged.connect(health_container_node.update_health)
	
func _process(_delta):
	health_container_node.update_health(player_node.cur_health)
