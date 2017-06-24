extends "upgrade_multiply.gd"

onready var money_timer = get_node("money_timer")
var is_ready = false
func _ready():
	is_ready = true
	money_timer.set_active(false)
	_check_activate_timer()

func _check_activate_timer():
	if self.power > 0 and (not money_timer.is_active()):
		money_timer.set_active(true)
		money_timer.start()

func _timer_for_money():
	money_manager.money += self.power
	get_node("animation_player").play("money_animation")

# override
func _update_label():
	._update_label()
	if is_ready:
		_check_activate_timer()
	_check_icon_count()
	
func _check_icon_count():
	var child_count = get_node("icons").get_child_count()
	var currnet_count = get_node("powers/count_up").power
	if child_count < currnet_count:
		for i in range(0, currnet_count - child_count):
			var duplicated_node = get_node("icons/icon").duplicate(false)
			get_node("icons").add_child( duplicated_node )
		get_node("icons").set("custom_constants/separation", (200 - 100.0 * currnet_count) / (1 - currnet_count) * -1 )