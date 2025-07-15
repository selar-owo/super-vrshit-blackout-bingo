extends Node2D
class_name Player

@export var player_name := "flutter"
@export var player_color := Color(1,0,0)
@onready var name_label: Label = $NameLabel
@onready var button: Button = $Button
@onready var bingler: Node2D = $"../.."
@onready var toggleanim: AnimationPlayer = $toggleanim
signal player_toggled(tog:bool,color)

func _ready() -> void:
	reload_player()

func reload_player() -> void:
	name_label.text = player_name
	self.modulate = player_color
	button.toggled.connect(func(tog)->void:
		bingler.updated_toggled()
		toggleanim.play(str("tog_",tog))
		print(tog is bool)
		emit_signal("player_toggled",tog,player_color)
		)
