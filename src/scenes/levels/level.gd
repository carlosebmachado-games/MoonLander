extends Node2D

var on_area = false
var stopped = false

func _process(delta):
	#todo: chamar menu para prox fase
	#print(on_area and stopped)
	
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()

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
