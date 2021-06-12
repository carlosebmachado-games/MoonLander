extends Node

const FILE_NAME = 'game_data'

var sound = true
var music = true

var current_playing_music

var cur_score

func _ready():
	var data = load_data(FILE_NAME)
	if not data.empty():
		music = data['music']
		sound = data['sound']

func play_music(playing_music):
	stop_music()
	current_playing_music = playing_music
	if music:
		start_music()

func start_music():
	if current_playing_music != null:
		current_playing_music.autoplay = true
		current_playing_music.play()

func stop_music():
	if current_playing_music != null:
		current_playing_music.autoplay = false
		current_playing_music.stop()

func play_sound(playing_sound):
	if sound:
		playing_sound.play()

func enable_music(en):
	music = en
	if music:
		start_music()
	else:
		stop_music()
	save_game_data()

func enable_sound(en):
	sound = en
	save_game_data()

func save_game_data():
	var data = {}
	data['music'] = music
	data['sound'] = sound
	save_data(FILE_NAME, data)

func save_data(file_name, data):
	var path = 'user://' + file_name + '.json'
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_line(to_json(data))
	file.close()

func load_data(file_name):
	var path = 'user://' + file_name + '.json'
	var file = File.new()
	var text = '{}'
	if file.file_exists(path):
		file.open(path, File.READ)
		text = file.get_as_text()
		file.close()
	return parse_json(text)
