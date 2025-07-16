extends Node2D
class_name Player

@export var player_name := "flutter"
@export var player_color := Color(1,0,0)
@onready var name_label: Label = $NameLabel
@onready var button: Button = $Button
@onready var bingler: Node2D = $"../.."
@onready var toggleanim: AnimationPlayer = $toggleanim
@onready var edit_mode: Node2D = $"../../EditMode"
signal player_toggled(tog:bool,color)

@onready var gradient: Sprite2D = $Gradient
@onready var color_sprite: Sprite2D = $ColorSprite
@onready var edit_color_button: TextureButton = $EditColorButton
@onready var colorpicke_thingt: Node2D = $"../../ColorpickeThingt"
@onready var color_picker: ColorPicker = $"../../ColorpickeThingt/ColorPicker"
@onready var edit_name: LineEdit = $EditName
@onready var players: Node2D = $".."
@onready var faggot: ColorRect = $Faggot

func _ready() -> void:
	reload_player()
	update_player_edit_state(false)
	button.toggled.connect(func(tog)->void:
		bingler.updated_toggled()
		toggleanim.play(str("tog_",tog))
		print(tog is bool)
		emit_signal("player_toggled",tog,player_color)
		)
	edit_mode.change_edit_state.connect(func(state)->void:
		reload_player()
		update_player_edit_state(state)
		)
	edit_color_button.button_down.connect(func()->void:
		colorpicke_thingt.visible = !colorpicke_thingt.visible
		colorpicke_thingt.global_position.y = self.global_position.y
		color_picker.color = player_color
		for i in players.get_children():
			print("Bro im ab")
			if colorpicke_thingt.visible: i.edit_name.mouse_filter = Control.MOUSE_FILTER_IGNORE
			else: i.edit_name.mouse_filter = Control.MOUSE_FILTER_STOP
			if i.name == name: continue
			i.edit_color_button.disabled = colorpicke_thingt.visible
		)
	color_picker.color_changed.connect(func(clr) -> void:
		if edit_color_button.disabled: return
		player_color = clr
		edit_color_button.modulate = player_color
		)
	edit_name.text_changed.connect(func(txt)->void:
		var myfaaart := edit_name.caret_column
		player_name = txt.to_lower()
		name_label.text = player_name
		edit_name.text = player_name
		edit_name.caret_column = myfaaart
		)

func reload_player() -> void:
	name_label.text = player_name
	self.modulate = player_color
	edit_color_button.modulate = player_color

func update_player_edit_state(state) -> void:
	gradient.visible = !state
	color_sprite.visible = !state
	edit_color_button.visible = state
	button.visible = !state
	faggot.visible = state
	print("Buh Dih",state)
	edit_name.visible = state
	name_label.visible = !state
	match state:
		true:
			self.modulate = Color(1,1,1)
			button.set_pressed(false)
			edit_name.text = player_name
			color_picker.color = player_color
