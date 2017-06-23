extends Node

var money = 0 setget money_set

func _ready():
	add_to_group("persistent")
	
	# 돈이 변경되었음을 주변에 알림
	get_tree().call_group(0, "money_listener", "_money_changed")

func money_set( val ):
	money = val
	# 돈이 변경되었음을 주변에 알림
	get_tree().call_group(0, "money_listener", "_money_changed")
	
func _save_as_dic():
	var dic = {}
	dic.money = money
	return dic
	
func _load_from_dic(dic):
	self.money = dic["money"]