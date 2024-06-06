extends Label

@onready var road_node = get_node_or_null("../../Road")
@onready var session_node = get_node_or_null("../../")

func _ready():
	road_node.drumScoreChanged.connect(update)
	
func _process(_delta):
	update()

#Обновляем занчения баллов
func update():
	if session_node.name.substr(11, 2) == "1":
		text = str(Global.drum1_score)
	elif session_node.name.substr(11, 2) == "2":
		text = str(Global.drum2_score)
	elif session_node.name.substr(11, 2) == "3":
		text = str(Global.drum3_score)
	elif session_node.name.substr(11, 2) == "4":
		text = str(Global.drum4_score)
	elif session_node.name.substr(11, 2) == "5":
		text = str(Global.drum5_score)
	elif session_node.name.substr(11, 2) == "6":
		text = str(Global.drum6_score)
	elif session_node.name.substr(11, 2) == "7":
		text = str(Global.drum7_score)
	elif session_node.name.substr(11, 2) == "8":
		text = str(Global.drum8_score)
	elif session_node.name.substr(11, 2) == "9":
		text = str(Global.drum9_score)
	elif  session_node.name.substr(11, 2) == "10":
		text = str(Global.drum10_score)
