extends Label

@onready var road_node = get_node_or_null("../../Road")
@onready var session_node = get_node_or_null("../../")

func _ready():
	road_node.drumScoreChanged.connect(update)
	
func _process(_delta):
	update()

func update():
	if "1" in session_node.name:
		text = str(Global.drum1_score)
	elif "2" in session_node.name:
		text = str(Global.drum2_score)
	elif "3" in session_node.name:
		text = str(Global.drum3_score)
	elif "4" in session_node.name:
		text = str(Global.drum4_score)
	elif "5" in session_node.name:
		text = str(Global.drum5_score)
