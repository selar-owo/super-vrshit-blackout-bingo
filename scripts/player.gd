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
@onready var add_player: Button = $AddPlayer
@onready var delete_player: TextureButton = $DeletePlayer
@onready var entries: Node2D = $"../../Entries"

func _ready() -> void:
	reload_player()
	update_player_edit_state(false)
	button.toggled.connect(func(tog)->void:
		bingler.updated_toggled()
		toggleanim.play(str("tog_",tog))
		print(tog is bool)
		emit_signal("player_toggled",tog,player_color)
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
		bingler.all_players[self.get_index()][1] = clr
		player_color = clr
		edit_color_button.modulate = player_color
		)
	edit_name.text_changed.connect(func(txt)->void:
		var myfaaart := edit_name.caret_column
		bingler.all_players[self.get_index()][0] = txt
		player_name = txt.to_lower()
		name_label.text = player_name
		edit_name.text = player_name
		edit_name.caret_column = myfaaart
		)
	add_player.button_down.connect(func()->void:
		bingler.all_players.append(["player",Color(0.9,0.8,0.9)])
		players.reload_all_players()
		)
	delete_player.button_down.connect(func()->void:
		var maindicks := self.get_index()
		for i:Entry in entries.get_children():
			i.player_idx_owned = tfinamethis(i)
		bingler.all_players.remove_at(maindicks)
		print("DLT: Attempted to delete player ",bingler.all_players)
		players.reload_all_players()
		)

func tfinamethis(i) -> Array:
	print("DLT: Targetting ",i.player_idx_owned)
	var reformed_owned:Array = i.player_idx_owned
	for p in reformed_owned:
		if p == get_index(): reformed_owned.erase(p)
	var idx := 0
	for p in reformed_owned:
		if p > get_index():
			reformed_owned[idx] = p-1
		idx += 1
	return reformed_owned

func reload_player() -> void:
	name_label.text = player_name
	self.modulate = player_color
	edit_color_button.modulate = player_color
	add_player.visible = (name_label.text == "ADD PLR")
	delete_player.visible = (bingler.editing and name_label.text != "ADD PLR")
	edit_name.editable = !(name_label.text == "ADD PLR")
	if name_label.text != "ADD PLR": return
	edit_color_button.visible = false

func update_player_edit_state(state) -> void:
	gradient.visible = !state
	color_sprite.visible = !state
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
	if (name_label.text == "ADD PLR"): return
	edit_color_button.visible = state
