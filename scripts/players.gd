extends Node2D

func get_player(nodename) -> Node:
	print(nodename)
	return self.get_node(NodePath(nodename))
