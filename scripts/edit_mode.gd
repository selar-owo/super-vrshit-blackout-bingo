extends Node2D

@onready var edit_board: TextureButton = $EditBoard
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	edit_board.button_down.connect(func()->void:
		animation_player.play("edit_enter")
		)
