extends TextureButton

@onready var music: AudioStreamPlayer = $"../Intro2/Music"

func _ready() -> void:
	self.connect("toggled",func(tog)->void:
		music.stream_paused = tog
		)
