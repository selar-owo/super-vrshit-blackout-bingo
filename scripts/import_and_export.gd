extends Node2D

@onready var settings_location: TextureButton = $SettingsLocation
@onready var import_settings: TextureButton = $ImportSettings
@onready var save_states: SaveStatesHandler = $"../SaveStates"
@onready var file_dialog: FileDialog = $"../FileDialog"

func _ready() -> void:
	settings_location.button_down.connect(func()->void:OS.shell_show_in_file_manager(OS.get_user_data_dir()))
	import_settings.button_down.connect(func()->void:
		file_dialog.popup_centered()
		)
	file_dialog.file_selected.connect(func(file)->void:
		var confart := ConfigFile.new()
		confart.load(file)
		save_states.overrite_savefile(confart)
		)
