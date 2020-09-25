extends RigidBody2D

signal stopped
signal moving

# movement
var thrust = 50000
var side_thrust = 20000

# controls
var input_left = false
var input_right = false

# sprites
onready var spr_engine = $sprites/engine
onready var spr_ljet = $sprites/jet_left
onready var spr_rjet = $sprites/jet_right

func _ready():
	pass

func _input(_event):
	if Input.is_action_pressed("player_left"):
		input_left = true
	else:
		input_left = false
	if Input.is_action_pressed("player_right"):
		input_right = true
	else:
		input_right = false

func _process(_delta):
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
