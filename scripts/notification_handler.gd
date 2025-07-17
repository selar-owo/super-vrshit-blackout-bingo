extends Node2D

@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func notif_appear(filename) -> void:
	label.text = str("Imported ",filename.get_file())
	animation_player.play("notif_appear")
	animation_player.seek(0.0,true)
