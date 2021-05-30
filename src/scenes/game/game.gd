extends Node2D

var on_area = false
var stopped = false

var time_start = 0
var time_now = 0
var time_elapsed = 0

export var new_level = ""

func _ready():
	time_start = OS.get_ticks_msec()

func _process(_delta):
	if not (stopped and on_area):
		time_now = OS.get_ticks_msec()
		time_elapsed = (time_now - time_start) / 1000.0
	#print(time_elapsed)
	
	#print(on_area and stopped)
	
#	if Input.is_action_just_pressed("ui_accept"):
#		get_tree().reload_current_scene()

func _on_arrival_point_body_entered(body):
	if body.name == "lander":
		on_area = true

func _on_arrival_point_body_exited(body):
	if body.name == "lander":
		on_area = false

func _on_lander_stopped():
	stopped = true

func _on_lander_moving():
	stopped = false

func _on_canvas_layer_exit():
	get_tree().paused = false;
	get_tree().change_scene("res://scenes/menus/main_menu.tscn")
	queue_free()
