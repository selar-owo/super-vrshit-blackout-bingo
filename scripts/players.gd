extends Node2D

@onready var bingler: Bi12ngler = $".."
@onready var edit_mode: Node2D = $"../EditMode"

func _ready() -> void:
	for i in self.get_children():
		i.hide()
	reload_all_players()

func reload_all_players() -> void:
	print("Editing Test c")
	var idx := 0
	for i in bingler.all_players:
		self.get_child(idx).show()
		self.get_child(idx).player_name = i[0]
		self.get_child(idx).player_color = i[1]
		self.get_child(idx).update_player_edit_state(bingler.editing)
		self.get_child(idx).reload_player()
		idx += 1
	print("Editing Test ",bingler.editing)
	if self.get_child(idx) == null: return
	self.get_child(idx).hide()
	if bingler.editing == false: return
	if idx >= 16: return
	print("Editing Test ",bingler.editing)
	self.get_child(idx).show()
	self.get_child(idx).player_name = "ADD PLR"
	self.get_child(idx).player_color = Color(1,1,1)
	self.get_child(idx).update_player_edit_state(bingler.editing)
	self.get_child(idx).reload_player()

func get_player(nodename) -> Node:
	print(nodename)
	return self.get_node(NodePath(nodename))
