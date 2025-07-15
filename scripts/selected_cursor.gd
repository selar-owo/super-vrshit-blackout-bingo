extends Node2D

@onready var players: Node2D = $"../Players"
@onready var bingler: Bi12ngler = $".."

func _ready() -> void:
	for i in self.get_children():
		i.appear_animation.play("appear_false")
	for i:Player in players.get_children():
		i.player_toggled.connect(func(tog,color)->void:
			var fart:int = 0
			match tog:
				false: fart = 1
			self.get_child(bingler.currently_selected.size() + fart).appear_animation.play(str("appear_",tog))
			self.get_child(bingler.currently_selected.size() + fart).modulate = color
			)

func _process(delta: float) -> void:
	self.global_position = get_global_mouse_position()
