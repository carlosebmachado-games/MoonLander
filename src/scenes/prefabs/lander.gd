extends RigidBody2D

signal stopped
signal moving

# movement
var thrust = 500
var side_thrust = 300

# controls
var input_left = false
var input_right = false

# sprites
onready var spr_engine = $sprites/engine
onready var spr_ljet = $sprites/jet_left
onready var spr_rjet = $sprites/jet_right

#objects
onready var pivot_arrow = $pivot

var reach_point_position = Vector2.ZERO
var reach_point_distance = 0
var show_arrow = true

func _ready():
	#reach_point_position = Global.arrival_current_position
	for ap in get_tree().get_nodes_in_group("arrival_point"):
		reach_point_position = ap.position

func _input(event):
	# handle debug keyboard input
	if Input.is_action_pressed("player_left"):
		input_left = true
	else:
		input_left = false
	if Input.is_action_pressed("player_right"):
		input_right = true
	else:
		input_right = false

	# handle touch input
	if Input.is_mouse_button_pressed(1):
		if event.position.x < 400:
			input_left = true
		else:
			input_left = false
		if event.position.x > 400:
			input_right = true
		else:
			input_right = false

func _process(_delta):
	#arrow.set_global_pos(finger_down_pos)
	if show_arrow:
		pivot_arrow.rotation = (reach_point_position - position).angle() - rotation
	reach_point_distance = position.distance_to(reach_point_position)
	
	if int(linear_velocity.x) == 0 and int(linear_velocity.y) == 0:
		emit_signal("stopped")
	else:
		emit_signal("moving")
	
	if main_propulser():
		spr_engine.show()
	else:
		spr_engine.hide()
	
	if left_propulser() and not main_propulser():
		spr_ljet.show()
	else:
		spr_ljet.hide()
	
	if right_propulser() and not main_propulser():
		spr_rjet.show()
	else:
		spr_rjet.hide()

func _physics_process(delta):
	var direction = Vector2(sin(rotation), -cos(rotation))
	var dir_thrust = direction * thrust
	
	if main_propulser():
		apply_central_impulse(dir_thrust * delta)
	elif left_propulser():
		apply_torque_impulse(side_thrust * delta)
	elif right_propulser():
		apply_torque_impulse(-(side_thrust * delta))
	
func right_propulser():
	return input_right

func left_propulser():
	return input_left

func main_propulser():
	return input_left and input_right

func _on_arrival_point_screen_entered():
	show_arrow = false
	pivot_arrow.hide()

func _on_arrival_point_screen_exited():
	show_arrow = true
	pivot_arrow.show()
