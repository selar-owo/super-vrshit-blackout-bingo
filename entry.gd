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

func _ready() -> void:
	label.text = entry_title
	button.button_down.connect(func()->void:
		for i in players_done.get_children():
			i.hide()
		if bingler.currently_selected.size() == 0: return
		var idx := 0
		for i in bingler.currently_selected:
			players_done.get_child(idx).color = players.get_player(i).player_color
			players_done.get_child(idx).show()
			idx += 1
		)
