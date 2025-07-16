extends Node2D

@export var hide_label_on_click := false
@export var label_text := "My cock"
@export var label_configfuckingthingidontknow := preload("res://shadersnmore/fontchoice.tres")

@onready var button_node = $".."
@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	button_node.connect("mouse_entered",func()->void:change_label_state(true))
	button_node.connect("mouse_exited",func()->void:change_label_state(false))
	button_node.connect("button_down",func()->void:if !hide_label_on_click: return; change_label_state(false))
	label.label_settings = label_configfuckingthingidontknow
	label.text = label_text

func change_label_text(Bro) -> void:
	label.text = Bro

func change_label_state(state) -> void:
	if !get_window().has_focus() and label.modulate.a > 0:
		animation_player.play(str("pop_false"))
		return
	if !get_window().has_focus(): return
	animation_player.play(str("pop_",state))
