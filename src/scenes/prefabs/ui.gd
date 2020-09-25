extends Control

func _process(_delta):
	for l in get_tree().get_nodes_in_group("lander"):
		$speed.text = ("H-SPEED: " + str(int(l.linear_velocity.x)) +
					"\nV-SPEED: " + str(int(l.linear_velocity.y)))
