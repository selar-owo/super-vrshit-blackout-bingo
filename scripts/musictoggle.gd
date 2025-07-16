extends TextureButton

@onready var music: AudioStreamPlayer = $"../Music"
@onready var save_states: SaveStatesHandler = $"../SaveStates"

func _ready() -> void:
	self.set_pressed(save_states.config.get_value("BINGO","settings_data")["music_muted"])
	self.connect("toggled",func(tog)->void:
		music.stream_paused = tog
		save_states.save_n_download()
		)
	music.stream_paused = save_states.config.get_value("BINGO","settings_data")["music_muted"]
