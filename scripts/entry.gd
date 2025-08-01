extends Node2D
class_name Entry

@export_multiline var entry_title := "crying/
crashout 
live"
@export_multiline var entry_description := ""
@export_enum("Pure Luck","Piss easy","yeah","My Penis hard","Kovu find a Girlfriend level") var entry_difficulty := 0

@onready var label: Label = $Label
@onready var button: Button = $Button
@onready var bingler: Bi12ngler = $"../.."
@onready var players_done: Node2D = $PlayersDone
@onready var players: Node2D = $"../../Players"
@onready var save_states: Node = $"../../SaveStates"
@onready var removed: TextureRect = $TextureRect
@onready var edit_entry: Node2D = $"../../EditEntry"
@onready var rename_entry: LineEdit = $"../../EditEntry/RenameEntry"

var player_idx_owned := []

func _ready() -> void:
	label.text = entry_title
	button.button_down.connect(func()->void:
		if !bingler.editing:
			reload_data(bingler.currently_selected)
			return
		edit_entry.visible = !(edit_entry.global_position == self.global_position and edit_entry.visible)
		edit_entry.global_position = self.global_position
		rename_entry.text = label.text
		save_states.save_n_download()
		)
	rename_entry.text_changed.connect(func(newtext)->void:
		if !(edit_entry.global_position == self.global_position): return
		bingler.all_entries[self.get_index()] = newtext.to_lower()
		reload_data(self.player_idx_owned,true)
		)
	button.mouse_entered.connect(func()->void:hover_anim(false))
	button.mouse_exited.connect(func()->void:hover_anim(true))

func hover_anim(hide) -> void:
	if bingler.editing: return
	for i in players_done.get_children():
		i.hide()
	if bingler.currently_selected == player_idx_owned and !hide: return
	if hide:
		var idx2 := 0
		for i in self.player_idx_owned:
			players_done.get_child(idx2).modulate = players.get_player(str("Player",i+1)).player_color
			players_done.get_child(idx2).show()
			idx2 += 1
	if hide: return
	var idx := 0
	for i in bingler.currently_selected:
		players_done.get_child(idx).modulate = players.get_player(str("Player",i+1)).player_color
		players_done.get_child(idx).show()
		idx += 1

func reload_data(data,refreshing=false) -> void:
	print("reloading ",data)
	var prev_owned := player_idx_owned
	player_idx_owned = []
	for i in players_done.get_children():
		i.hide()
	label.modulate.a = 1
	label.text = bingler.all_entries[self.get_index()]
	removed.visible = !(data.size() == 0 or (data == prev_owned and !refreshing))
	if data.size() == 0 or (data == prev_owned and !refreshing): return
	label.modulate.a = 0.5
	var idx := 0
	for i in data:
		players_done.get_child(idx).modulate = players.get_player(str("Player",i+1)).player_color
		players_done.get_child(idx).show()
		if !refreshing: players_done.get_child(idx).appear_animation.play("appear_true")
		player_idx_owned.append(players.get_player(str("Player",i+1)).get_index())
		idx += 1
