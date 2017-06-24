extends Control

var ready = false

func _ready():
	ready = true
	

func _money_changed():
	if ready: get_node("money_animator").play("money")
