extends Node2D

@onready var bingler: Bi12ngler = $".."

func reload_all_entries() -> void:
	for i:Entry in self.get_children():
		var shitfart = i.player_idx_owned
		i.reload_data(shitfart,true)
		print(i.player_idx_owned)
