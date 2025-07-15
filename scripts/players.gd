extends Node2D

@export var all_players := {
	"flutter": Color(0.934, 0.226, 0.226),
	"tofucurry": Color(0.12, 0.613, 0.0),
	"jaykeezy": Color(0.485, 0.488, 0.109),
	"nari": Color(0.0, 0.75, 0.521),
	"kobu": Color(0.131, 0.439, 0.836),
	"aaron": Color(0.922, 0.13, 0.798),
	"alina": Color(0.64, 0.305, 0.918),
	"chills": Color(0.652, 0.441, 0.441),
}

func _ready() -> void:
	for i in self.get_children():
		i.hide()
	
	var idx := 0
	for i in all_players.keys():
		self.get_child(idx).show()
		self.get_child(idx).player_name = i
		self.get_child(idx).player_color = all_players[i]
		self.get_child(idx).reload_player()
		idx += 1

func get_player(nodename) -> Node:
	print(nodename)
	return self.get_node(NodePath(nodename))
