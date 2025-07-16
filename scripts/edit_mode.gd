extends Node2D

@onready var edit_board: TextureButton = $EditBoard
@onready var play_board: TextureButton = $PlayBoard
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bingler: Bi12ngler = $".."
@onready var music: AudioStreamPlayer = $"../Music"
@onready var music_toggle: TextureButton = $"../MusicToggle"
@onready var colorpicke_thingt: Node2D = $"../ColorpickeThingt"
@onready var players: Node2D = $"../Players"
@onready var save_states: SaveStatesHandler = $"../SaveStates"
@onready var edit_entry: Node2D = $"../EditEntry"
signal change_edit_state(state)

func _ready() -> void:
	edit_board.button_down.connect(func()->void:
		bingler.editing = true
		
		print("Editing Test b")
		edit_board.hide()
		play_board.show()
		animation_player.play("edit_enter")
		players.reload_all_players()
		music.set_stream(preload("res://sounds/editing.mp3"))
		music.play()
		music.stream_paused = music_toggle.is_pressed()
		for i in players.get_children():
			i.edit_name.mouse_filter = Control.MOUSE_FILTER_STOP
			i.edit_color_button.disabled = false
		emit_signal("change_edit_state",true)
		save_states.download_all_to_file()
		)
	play_board.button_down.connect(func()->void:
		bingler.editing = false
		
		print("Editing Test t")
		players.reload_all_players()
		play_board.hide()
		colorpicke_thingt.hide()
		edit_entry.hide()
		edit_board.show()
		animation_player.play("edit_exit")
		music.set_stream(preload("res://sounds/videoplayback (2) (1).mp3"))
		music.play()
		music.stream_paused = music_toggle.is_pressed()
		emit_signal("change_edit_state",false)
		save_states.download_all_to_file()
		)
