extends Node
class_name SaveStatesHandler

var save_file := "user://svbb_config.cfg"
var config := ConfigFile.new()

@onready var entries: Node2D = $"../Entries"
@onready var music_toggle: TextureButton = $"../MusicToggle"

func _ready() -> void:
	var bingo_check = FileAccess.file_exists(save_file)
	if !bingo_check:
		config.set_value("BINGO","bingo_data",{0: [],1: [],2: [],3: [],4: [],5: [],6: [],7: [],8: [],9: [],10: [],11: [],12: [],13: [],14: [],15: [],16: [],17: [],18: [],19: [],20: [],21: [],22: [],23: [],24: []})
		config.set_value("BINGO","settings_data",{
			"music": false,
		})
		config.save(save_file)
		print("created bingo file")
	self.tree_exiting.connect(func()->void:
		save_bingoboard()
		save_settings()
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
	reload_all_entries(config.get_value("BINGO","bingo_data"))
	print("load bingo with ",config.get_value("BINGO","bingo_data"))

func overrite_savefile(config:ConfigFile) -> void:
	config.set_value("BINGO","bingo_data",config.get_value("BINGO","bingo_data"))
	reload_all_entries(config.get_value("BINGO","bingo_data"))

func reload_all_entries(data) -> void:
	for i in entries.get_children():
		i.reload_data(data[i.get_index()])
		print(i," ",data[i.get_index()])

func save_bingoboard() -> void:
	var gathered := {}
	for i:Entry in entries.get_children():
		gathered[i.get_index()] = i.player_idx_owned
	config.set_value("BINGO","bingo_data",gathered)
	config.save(save_file)
	print("save bingo with ",gathered)

func save_settings() -> void:
	var Fuckme = config.get_value("BINGO","settings_data")
	Fuckme["music"] = !music_toggle
	
	config.set_value("BINGO","settings_data",Fuckme)
	config.save(save_file)
