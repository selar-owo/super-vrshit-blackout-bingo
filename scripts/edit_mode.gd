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
@onready var shuffle_board: TextureButton = $ShuffleBoard
@onready var entries: Node2D = $"../Entries"
@onready var farting_shuffle_board: AudioStreamPlayer = $"../ShuffleBoard"
@onready var the_shuffle_in_question: AnimationPlayer = $"../ShuffleBoard/TheShuffleInQuestion"
signal change_edit_state(state)

func _ready() -> void:
	edit_board.button_down.connect(func()->void:
		bingler.editing = true
		shuffle_board.visible = bingler.editing
		print("Editing Test b")
		edit_board.hide()
		play_board.show()
		animation_player.play("edit_enter")
		players.reload_all_players()
		music.set_stream(preload("res://sounds/Thrash Machine.mp3"))
		music.play()
		music.stream_paused = music_toggle.is_pressed()
		for i in players.get_children():
			i.edit_name.mouse_filter = Control.MOUSE_FILTER_STOP
			i.edit_color_button.disabled = false
		emit_signal("change_edit_state",true)
		save_states.save_n_download()
		)
	play_board.button_down.connect(func()->void:
		bingler.editing = false
		shuffle_board.visible = bingler.editing
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
		save_states.save_n_download()
		)
	shuffle_board.button_down.connect(func()->void:
		var faggot := []
		var dx := 0
		for i:Entry in entries.get_children():
			faggot.append({
				"entry_name": bingler.all_entries[dx],
				"players_completed": bingler.board_data[dx],
			})
			dx += 1
		faggot.shuffle()
		var idx := 0
		for i:Entry in entries.get_children():
			print(i)
			bingler.all_entries[idx] = faggot[idx]["entry_name"]
			bingler.board_data[idx] = faggot[idx]["players_completed"]
			idx+=1
		entries.reload_all_entries()
		save_states.save_n_download()
		the_shuffle_in_question.play("shuffle")
		the_shuffle_in_question.seek(0.0,true)
		print("Shuffled Board ",bingler.all_entries)
		)
