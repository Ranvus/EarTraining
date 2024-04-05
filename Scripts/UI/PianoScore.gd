extends Label

@onready var teacher1_node = get_node_or_null("../../SecondThirdTeacher")
@onready var teacher2_node = get_node_or_null("../../FifthTeacher")
@onready var teacher3_node = get_node_or_null("../../OctaveTeacher")

func _ready():
	if teacher1_node:
		teacher1_node.pianoUnisonScoreChanged.connect(update_unison)
	elif teacher2_node:
		teacher2_node.pianoFifthScoreChanged.connect(update_fifth)
	elif teacher3_node:
		teacher3_node.pianoOctaveScoreChanged.connect(update_octave)
	
func _process(_delta):
	if teacher1_node:
		update_unison()
	elif teacher2_node:
		update_fifth()
	elif teacher3_node:
		update_octave()
	

func update_unison():
	text = str(Global.piano1_score)
	
func update_fifth():
	text = str(Global.piano2_score)
	
func update_octave():
	text = str(Global.piano3_score)
