extends Control

onready var part1 = $enter_name
onready var part2 = $scores

onready var txt_name = $enter_name/m_container/vb_container/txt_name

const FILE_NAME = 'user://scores.json'
var scores

func _ready():
	var file = File.new()
	if file.file_exists(FILE_NAME):
		file.open(FILE_NAME, File.READ)
		var data = {}
		var text = file.get_as_text()
		scores = parse_json(text)
		file.close()

func _process(delta):
	pass

func save_scores():
	var file = File.new()
	file.open(FILE_NAME, File.WRITE)
	file.store_line(to_json(scores))
	file.close()
