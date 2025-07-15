extends Node2D

@onready var player: TextureRect = $Player
@onready var label: Label = $Label
@onready var appear_animation: AnimationPlayer = $AppearAnimation

func _ready() -> void:
	player.mouse_entered.connect(func()->void:label.show())
	player.mouse_exited.connect(func()->void:label.hide())
