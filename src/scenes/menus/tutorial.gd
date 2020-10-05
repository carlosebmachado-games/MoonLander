extends Control

func _ready():
	pass

func _on_to_part_2_button_up():
	$part_1.queue_free()
	$part_2.show()

func _on_to_part_3_button_up():
	$part_2.queue_free()
	$part_3.show()

func _on_to_main_menu_button_up():
	get_tree().change_scene("res://scenes/menus/main_menu.tscn")
	queue_free()
