extends Control

onready var part1 = $enter_name
onready var part2 = $scores

onready var txt_name = $enter_name/m_container/vb_container/txt_name
onready var lbl_scores = $scores/m_container2/vb_container/scroll/lbl_scores

const FILE_NAME = 'scores'
var scores = {}

var ainputs = [
	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
	'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
	'Enter', 'BackSpace']

func _ready():
	scores = Global.load_data(FILE_NAME)

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if part1.visible:
			var input = OS.get_scancode_string(event.scancode)
			if input in ainputs:
				if input == 'Enter':
					if txt_name.text == '':
						txt_name.text = 'UNNAMED'
					if len(txt_name.text) > 10:
						txt_name.text = txt_name.text.substr(0, 10)
					part1.hide()
					part2.show()
					set_new_score()
				elif input == 'BackSpace':
					var txt = txt_name.text
					txt_name.text = txt.substr(0, txt.length() - 1)
				else:
					txt_name.text += input
		else:
			var input = OS.get_scancode_string(event.scancode)
			if input == 'Enter':
				get_tree().change_scene("res://scenes/menus/main_menu.tscn")

func set_new_score():
	var player_name = txt_name.text
	var score = Global.cur_score
	
	scores[player_name] = float(score)
	
	var key_scores = scores.keys()
	var val_scores = scores.values()
	
	print(key_scores)
	print(val_scores)
	
	sort(key_scores, val_scores)
	
	for i in range(len(key_scores)):
		lbl_scores.text += key_scores[i] + ': ' + str(val_scores[i]) + '\n'
	
	Global.save_data(FILE_NAME, scores)

func sort(keys, values):
	for i in range(1, len(keys)):
		for j in range(0, len(keys) - 1):
			if values[j] > values[j + 1]:
				var temp = keys[j]
				keys[j] = keys[j + 1]
				keys[j + 1] = temp
				var temp2 = values[j]
				values[j] = values[j + 1]
				values[j + 1] = temp2
