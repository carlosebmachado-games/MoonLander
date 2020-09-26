extends Area2D

signal screen_entered
signal screen_exited

func _ready():
	#Global.arrival_current_position = position
	pass

func _on_visible_screen_entered():
	emit_signal("screen_entered")

func _on_visible_screen_exited():
	emit_signal("screen_exited")
