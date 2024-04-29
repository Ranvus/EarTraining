extends Label

@onready var teacher1_node = get_node_or_null("../../SecondThirdTeacher")
@onready var teacher2_node = get_node_or_null("../../FifthTeacher")
@onready var teacher3_node = get_node_or_null("../../OctaveTeacher")
@onready var teacher4_node = get_node_or_null("../../UnisonIntervalTeacher")
@onready var teacher5_node = get_node_or_null("../../FifthIntervalTeacher")
@onready var teacher6_node = get_node_or_null("../../OctaveIntervalTeacher")

func _ready():
	if teacher1_node:
		teacher1_node.pianoUnisonScoreChanged.connect(update_unison)
	elif teacher2_node:
		teacher2_node.pianoFifthScoreChanged.connect(update_fifth)
	elif teacher3_node:
		teacher3_node.pianoOctaveScoreChanged.connect(update_octave)
	elif teacher4_node:
		teacher4_node.pianoUnisonIntervalScoreChanged.connect(update_octave)
	elif teacher5_node:
		teacher5_node.pianoFifthIntervalScoreChanged.connect(update_octave)
	elif teacher6_node:
		teacher6_node.pianoOctaveIntervalScoreChanged.connect(update_octave)
	
func _process(_delta):
	if teacher1_node:
		update_unison()
	elif teacher2_node:
		update_fifth()
	elif teacher3_node:
		update_octave()
	elif teacher4_node:
		update_unison_interval()
	elif teacher5_node:
		update_fifth_interval()
	elif teacher6_node:
		update_octave_interval()
	

func update_unison():
	text = str(Global.piano1_score)
	
func update_fifth():
	text = str(Global.piano2_score)
	
func update_octave():
	text = str(Global.piano3_score)
	
func update_unison_interval():
	text = str(Global.piano4_score)
	
func update_fifth_interval():
	text = str(Global.piano5_score)

func update_octave_interval():
	text = str(Global.piano6_score)
