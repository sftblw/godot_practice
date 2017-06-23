extends Label

export(String) var label_formatter = "$ %.2f"

func _money_changed():
	_update_label()

func _update_label():
	set_text( label_formatter % money_manager.money )