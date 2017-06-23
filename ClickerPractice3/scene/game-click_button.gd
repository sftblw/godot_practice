extends Button

func _click_for_money():
	money_manager.money += get_node("../upgrade_mouse").power
