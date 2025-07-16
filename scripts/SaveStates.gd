extends Node
class_name SaveStatesHandler

var save_file := "user://bingodata.svbb"
var config := ConfigFile.new()

@onready var entries: Node2D = $"../Entries"
@onready var music_toggle: TextureButton = $"../MusicToggle"
@onready var bingler: Bi12ngler = $".."
@onready var players: Node2D = $"../Players"

func _ready() -> void:
	var bingo_check = FileAccess.file_exists(save_file)
	if !bingo_check:
		config.set_value("BINGO","board_data",{0: [],1: [],2: [],3: [],4: [],5: [],6: [],7: [],8: [],9: [],10: [],11: [],12: [],13: [],14: [],15: [],16: [],17: [],18: [],19: [],20: [],21: [],22: [],23: [],24: []})
		config.set_value("BINGO","bingo_data",{
			"entries": bingler.all_entries,
			"players": bingler.all_players,
		})
		config.set_value("BINGO","settings_data",{
			"music_muted": false,
		})
		config.save(save_file)
		print("created bingo file")
	self.tree_exiting.connect(func()->void:
		save_n_download()
		)
	config.load(save_file)
	await get_tree().create_timer(0.3).timeout
	load_bingoboard()
	
	get_window().files_dropped.connect(func(file)->void:
		var confart := ConfigFile.new()
		confart.load(file[0])
		overrite_savefile(confart)
		)

func load_bingoboard() -> void:
	var fart:Dictionary= config.get_value("BINGO","bingo_data")
	bingler.all_entries = fart["entries"]
	bingler.all_players = fart["players"]
	players.reload_all_players()
	reload_all_entries_by_data(config.get_value("BINGO","board_data"))
	print("load bingo with ",config.get_value("BINGO","board_data"))

func overrite_savefile(conflick:ConfigFile) -> void:
	var darta:Dictionary = conflick.get_value("BINGO","bingo_data")
	bingler.all_entries = darta["entries"]
	bingler.all_players = darta["players"]
	players.reload_all_players()
	reload_all_entries_by_data(conflick.get_value("BINGO","board_data"))

func reload_all_entries_by_data(data) -> void:
	for i in entries.get_children():
		i.reload_data(data[i.get_index()],true)
		print(i," ",data[i.get_index()])

func save_n_download() -> void:
	save_bingoboard()
	download_all_to_file()

func save_bingoboard() -> void:
	var gathered := {}
	for i:Entry in entries.get_children():
		gathered[i.get_index()] = i.player_idx_owned
	bingler.board_data = gathered
	print("saved board with ",gathered)

func download_all_to_file() -> void:
	config.set_value("BINGO","board_data",bingler.board_data)
	var formed_bingodata := {
		"entries": bingler.all_entries,
		"players": bingler.all_players,
	}
	config.set_value("BINGO","bingo_data",formed_bingodata)
	
	var Fuckme = config.get_value("BINGO","settings_data")
	Fuckme["music_muted"] = music_toggle.is_pressed()
	config.set_value("BINGO","settings_data",Fuckme)
	
	config.save(save_file)
	print("downloaded to file with board ",bingler.board_data)
