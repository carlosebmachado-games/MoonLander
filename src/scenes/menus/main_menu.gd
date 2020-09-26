extends Control

var pre_level1 = preload("res://scenes/levels/level_1.tscn")

func _on_play_button_up():
	get_tree().current_scene.add_child(pre_level1.instance())
	queue_free()
