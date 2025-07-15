extends Node2D
class_name Bi12ngler

const VER := 3

var currently_selected := []
var quotes := [
	"DO not let Jay know about this he will Block me again",
	"Have you ever checked the discord channel descriptions i think theyre funny :heart:",
	"So like. Does Kovu still struggle to talk to women at the time of seeing this or not",
	"my kidney hurts",
	"Flutter Splooging everywhere after Laying eyes on nari:",
	"Theres this person that i know that takes 20 Minutes pisses how is that Even possible",
	"No. Undertale is NOT Better than Deltarune. You need to Kill yourself",
	"#FATKOVU",
	"#KILLKOVU",
]

@onready var players: Node2D = $Players

func _ready() -> void:
	version_handler()

func version_handler() -> void:
	if randi_range(1,10) == 1:
		get_window().title = quotes.pick_random()
		return
	get_window().title += str(" U",VER)

func updated_toggled() -> void:
	currently_selected = []
	for b in players.get_children():
		b.button.disabled = false
	for i in players.get_children():
		if i.button.is_pressed():
			currently_selected.append(i.get_index())
		if currently_selected.size() >= 9:
			for b in players.get_children():
				if !b.button.is_pressed(): b.button.disabled = true
			return
