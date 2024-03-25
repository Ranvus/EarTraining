extends Label

@onready var player = get_node_or_null("../../Player")
@onready var teacher1 = get_node_or_null("../../SecondThirdTeacher")
@onready var teacher2 = get_node_or_null("../../FifthTeacher")
@onready var teacher3 = get_node_or_null("../../OctaveTeacher")
#var teacher

func _ready():
	if teacher1:
		teacher1.pianoUnisonScoreChanged.connect(update_unison)
	elif teacher2:
		teacher2.pianoFifthScoreChanged.connect(update_fifth)
	elif teacher3:
		teacher3.pianoOctaveScoreChanged.connect(update_octave)
	
func _process(_delta):
	if teacher1:
		update_unison()
	elif teacher2:
		update_fifth()
	elif teacher3:
		update_octave()
	

func update_unison():
	text = str(Global.unison_score)
	
func update_fifth():
	text = str(Global.fifth_score)
	
func update_octave():
	text = str(Global.octave_score)
