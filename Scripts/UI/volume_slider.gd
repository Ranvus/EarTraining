extends HSlider

@export var bus_name : String

var bus_index : int
var bus_value : float

func _ready():
	bus_index = AudioServer.get_bus_index(bus_name)
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	value_changed.connect(_on_value_changed)
	
func _on_value_changed(value : float) -> void:
	#bus_value =  value
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))

func _process(delta):
	print(db_to_linear(AudioServer.get_bus_volume_db(2)))
