extends Control

onready var more_option = $popup_mo

onready var btn_sound = $popup_mo/mc_mo/hbc_mo/sound
onready var btn_no_sound = $popup_mo/mc_mo/hbc_mo/no_sound
onready var btn_music = $popup_mo/mc_mo/hbc_mo/music
onready var btn_no_music = $popup_mo/mc_mo/hbc_mo/no_music

onready var music_bg = $music_bg
onready var snd_touch = $snd_touch

func _ready():
	btn_music.visible = Global.music
	btn_no_music.visible = not Global.music
	btn_sound.visible = Global.sound
	btn_no_sound.visible = not Global.sound
	Global.play_music(music_bg)

func _on_play_button_up():
	Global.play_sound(snd_touch)
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/game/game.tscn")
	queue_free()

func _on_tutorial_button_up():
	Global.play_sound(snd_touch)
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/menus/tutorial.tscn")
	queue_free()

func _on_config_button_up():
	Global.play_sound(snd_touch)
	more_option.show()

func _on_close_mo_button_up():
	Global.play_sound(snd_touch)
	more_option.hide()

func _on_sound_button_up():
	Global.play_sound(snd_touch)
	btn_sound.hide()
	btn_no_sound.show()
	Global.enable_sound(false)

func _on_no_sound_button_up():
	Global.play_sound(snd_touch)
	btn_sound.show()
	btn_no_sound.hide()
	Global.enable_sound(true)

func _on_music_button_up():
	Global.play_sound(snd_touch)
	btn_music.hide()
	btn_no_music.show()
	Global.enable_music(false)

func _on_no_music_button_up():
	Global.play_sound(snd_touch)
	btn_music.show()
	btn_no_music.hide()
	Global.enable_music(true)
