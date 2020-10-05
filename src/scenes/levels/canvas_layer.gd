extends CanvasLayer

signal exit

onready var lbl_speed = $ui/hb_container/vbc_movement/speed
onready var lbl_distance = $ui/hb_container/vbc_movement/distance
onready var lbl_time = $ui/hb_container/vbc_control/time
onready var lbl_fuel = $ui/hb_container/vbc_control/fuel

onready var ui = $ui
onready var pause_menu = $pause_menu

onready var btn_sound = $pause_menu/m_container/c_container/vb_container/cc_options/hbc_options/sound
onready var btn_no_sound = $pause_menu/m_container/c_container/vb_container/cc_options/hbc_options/no_sound
onready var btn_music = $pause_menu/m_container/c_container/vb_container/cc_options/hbc_options/music
onready var btn_no_music = $pause_menu/m_container/c_container/vb_container/cc_options/hbc_options/no_music

func _ready():
	btn_music.visible = Global.music
	btn_no_music.visible = not Global.music
	btn_sound.visible = Global.sound
	btn_no_sound.visible = not Global.sound

func _process(_delta):
	for l in get_tree().get_nodes_in_group("lander"):
		lbl_speed.text = ("H-SPEED: " + str(int(l.linear_velocity.x)) +
					"\nV-SPEED: " + str(int(l.linear_velocity.y)))
		var dist = int(l.reach_point_distance) 
		if (dist <= 21 and
			int(l.linear_velocity.x) == 0 and
			int(l.linear_velocity.y) == 0):
			dist = 0
		lbl_distance.text = "DISTANCE: " + str(dist)
	
	lbl_time.text = "TIME: 0"
	lbl_fuel.text = "FUEL: 100"

func _on_pause_button_up():
	get_tree().paused = true
	pause_menu.show()

func _on_back_button_up():
	emit_signal("exit")

func _on_play_button_up():
	get_tree().paused = false
	pause_menu.hide()

func _on_sound_button_up():
	btn_sound.hide()
	btn_no_sound.show()
	Global.sound = false

func _on_no_sound_button_up():
	btn_sound.show()
	btn_no_sound.hide()
	Global.sound = true

func _on_music_button_up():
	btn_music.hide()
	btn_no_music.show()
	Global.sound = true

func _on_no_music_button_up():
	btn_music.show()
	btn_no_music.hide()
	Global.sound = false
