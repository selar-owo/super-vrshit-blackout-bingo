extends Node2D

@onready var bingler: Bi12ngler = $".."

func _ready() -> void:
	for i in self.get_children():
		i.hide()
	
	var idx := 0
	for i in bingler.all_players.keys():
		self.get_child(idx).show()
		self.get_child(idx).player_name = i
		self.get_child(idx).player_color = bingler.all_players[i]
		self.get_child(idx).reload_player()
		idx += 1

func get_player(nodename) -> Node:
	print(nodename)
	return self.get_node(NodePath(nodename))
