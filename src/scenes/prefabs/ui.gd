extends Control

onready var lbl_speed = $speed
onready var lbl_distance = $distance
onready var lbl_time = $time
onready var lbl_fuel = $fuel

func _process(_delta):
	for l in get_tree().get_nodes_in_group("lander"):
		lbl_speed.text = ("H-SPEED: " + str(int(l.linear_velocity.x)) +
					"\nV-SPEED: " + str(int(l.linear_velocity.y)))
		var dist = int(l.reach_point_distance) 
		if dist <= 20:
			dist = 0
		lbl_distance.text = "DISTANCE: " + str(dist)
	
	lbl_time.text = "TIME: 0"
	lbl_fuel.text = "FUEL: 100"
