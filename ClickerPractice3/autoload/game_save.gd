extends Node

const SAVE_PATH = "user://game.save"

func _ready():
	_load_game()
		
func _notification(what):
	if what == SceneTree.NOTIFICATION_WM_QUIT_REQUEST:
		_save_game()

func _save_game():
	print("save_game called")
	# 파일 열기
	var file = File.new()
	file.open_encrypted_with_pass(SAVE_PATH, File.WRITE, "mypass" + OS.get_unique_ID())

	# 직렬화
	var dic = {}
	
	var nodes = get_tree().get_nodes_in_group("persistent")
	for node in nodes:
		dic[ node.get_path() ] = node._save_as_dic()
		
	# 파일에 쓰기
	file.store_string( dic.to_json() )
	
	# 파일 닫기
	file.close()

func _load_game():
	# 파일 열기
	var file = File.new()
	if not file.file_exists(SAVE_PATH): return null
	file.open_encrypted_with_pass(SAVE_PATH, File.READ, "mypass" + OS.get_unique_ID())
	
	# 파일에서 읽어오기
	var dic = {}
	dic.parse_json( file.get_as_text() )
	
	# 로드
	for path in dic:
		get_node(path)._load_from_dic(dic[path])
	
	# 파일 닫기
	file.close()