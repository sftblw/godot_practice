extends Control

var power setget ,get_power
export(String) var power_formatter = "POW %d"

func _ready():
	var children = get_node("powers").get_children()
	var power = 0
	for child in children:
		child.connect( "label_updated", self, "_update_label" )
	
	get_power()
	_update_label()
	
func get_power():
	var children = get_node("powers").get_children()
	var power = 1
	for child in children:
		power *= child.power
	return power

func _update_label():
	get_node("total_power").set_text( power_formatter % self.power )