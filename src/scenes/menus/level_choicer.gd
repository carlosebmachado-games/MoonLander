extends Control

var cur_path = ""

func _on_back_button_up():
	get_tree().change_scene("res://scenes/menus/main_menu.tscn")
	queue_free()

func _on_level_item1_button_up():
	cur_path = "res://scenes/levels/level_1.tscn"
	$level_info.show()

func _on_play_button_up():
	get_tree().change_scene(cur_path)
	queue_free()

func _on_back_choice_button_up():
	$level_info.hide()
	cur_path = ""
