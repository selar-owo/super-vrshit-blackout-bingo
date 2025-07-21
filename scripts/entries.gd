extends Node2D

@onready var bingler: Bi12ngler = $".."

func reload_all_entries() -> void:
	var MeWhenImFuckingStupid := 0
	for i:Entry in self.get_children():
		var shitfart = bingler.board_data[MeWhenImFuckingStupid]
		i.reload_data(shitfart,true)
		print(i.player_idx_owned)
		MeWhenImFuckingStupid += 1
