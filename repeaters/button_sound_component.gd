extends Node

@onready var button_node = $".."
@onready var hover: AudioStreamPlayer = $Hover
@onready var click: AudioStreamPlayer = $Click

func _ready() -> void:
	button_node.connect("mouse_entered",func()->void:
		if !get_window().has_focus(): return
		hover.play())
	button_node.connect("button_down",func()->void:click.play())
