extends Control

var level = 1 setget level_set; func level_set(val): level = val; _update_label()
export(float) var cost  = 1.0 setget cost_set;  func cost_set(val):  cost = val;  _update_label()
var power = 1 setget power_set; func power_set(val): power = val; _update_label()
export(String) var level_formatter = "Lv. %d"
export(String) var cost_formatter  = "$ %.2f"
export(String) var power_formatter = "+ %.2f"
export(float) var cost_multiply = 1.7
export(float) var power_add     = 1

signal label_updated

func _ready():
	_update_label()

func _money_changed():
	var button = get_node("upgrade_button")
	button.set_disabled(true) if cost > money_manager.money else button.set_disabled(false)

func _upgrade():
	if cost > money_manager.money: return
	
	money_manager.money -= cost
	
	self.cost  *= cost_multiply
	self.power += power_add
	self.level += 1

func _update_label():
	if get_node("level_label") != null: get_node("level_label").set_text(level_formatter % level)
	if get_node("cost_label")  != null: get_node("cost_label" ).set_text (cost_formatter  % cost)
	if get_node("power_label") != null: get_node("power_label").set_text(power_formatter % power)
	emit_signal("label_updated")
	
func _save_as_dic():
	var dic = {}
	dic.level = level
	dic.cost = cost
	dic.power = power
	return dic
	
func _load_from_dic(dic):
	self.level = dic["level"]
	self.cost = dic["cost"]
	self.power = dic["power"]