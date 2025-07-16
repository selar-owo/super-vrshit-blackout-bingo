extends Node2D

@onready var edit_board: TextureButton = $EditBoard
@onready var play_board: TextureButton = $PlayBoard
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bingler: Bi12ngler = $".."
@onready var music: AudioStreamPlayer = $"../Music"
@onready var music_toggle: TextureButton = $"../MusicToggle"
@onready var colorpicke_thingt: Node2D = $"../ColorpickeThingt"
signal change_edit_state(state)

func _ready() -> void:
	edit_board.button_down.connect(func()->void:
		edit_board.hide()
		play_board.show()
		animation_player.play("edit_enter")
		bingler.editing = true
		music.set_stream(preload("res://sounds/editing.mp3"))
		music.play()
		music.stream_paused = music_toggle.is_pressed()
		emit_signal("change_edit_state",true)
		)
	play_board.button_down.connect(func()->void:
		play_board.hide()
		colorpicke_thingt.hide()
		edit_board.show()
		animation_player.play("edit_exit")
		bingler.editing = false
		music.set_stream(preload("res://sounds/videoplayback (2) (1).mp3"))
		music.play()
		music.stream_paused = music_toggle.is_pressed()
		emit_signal("change_edit_state",false)
		)
